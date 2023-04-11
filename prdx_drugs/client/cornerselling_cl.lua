local QBCore = exports['qb-core']:GetCoreObject()
local cornerselling = false
local hasTarget = false
local lastPed = {}
local stealingPed = nil
local stealData = {}
local availableDrugs = {}
local currentOfferDrug = nil
local CurrentCops = 0
local textDrawn = false
local zoneMade = false
local findClient = false

-- Functions
local function TooFarAway()
    QBCore.Functions.Notify('Too far away!', 'error')
    LocalPlayer.state:set("inv_busy", false, true)
    cornerselling = false
    hasTarget = false
    availableDrugs = {}
end

local function PoliceCall()
    math.randomseed(GetGameTimer())
    local Random = math.random(1, 100)
    if Random <= Config.PoliceCallChance then
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'}, --{'police', 'sheriff} 
            coords = data.coords,
            title = '10-17 - Suspicious Person',
            message = 'A suspicious '..data.sex..' was reported at '..data.street, 
            flash = 0, 
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 66, 
                scale = 1.2, 
                colour = 5,
                flashes = false, 
                text = '10-17 - Suspicious Person',
                sound = 1,
            }
        })      
    end
end

local function RobberyPed()
    local options = {
        {
            name = 'prdx:drugs:searchPed',
            icon = 'fas fa-magnifying-glass',
            label = "Search Ped",
            distance = 1.5,
            onSelect = function()
                local player = cache.ped
                lib.requestAnimDict("pickup_object")
                TaskPlayAnim(player, "pickup_object", "pickup_low", 8.0, -8.0, -1, 1, 0, false, false, false)
                Wait(2000)
                ClearPedTasks(player)
                TriggerServerEvent("QBCore:Server:AddItem", stealData.item, stealData.count)
                stealingPed = nil
                stealData = {}
                exports.ox_target:removeEntity(NetworkGetNetworkIdFromEntity(stealingPed), {'prdx:drugs:searchPed'})
            end,
            canInteract = function(entity)
                if IsEntityDead(entity) then
                    return true
                end
            end
        }
    }
    exports.ox_target:addEntity(NetworkGetNetworkIdFromEntity(stealingPed), options)
    CreateThread(function()
        while stealingPed do
            local playerPed = cache.ped
            local pos = GetEntityCoords(playerPed)
            local pedpos = GetEntityCoords(stealingPed)
            local dist = #(pos - pedpos)
            if dist > 100 then
                exports.ox_target:removeEntity(NetworkGetNetworkIdFromEntity(stealingPed), {'prdx:drugs:searchPed'})
                stealingPed = nil
                stealData = {}
                break
            end
            Wait(0)
        end
    end)
end

local function SellToPed(ped)
    hasTarget = true

    for i = 1, #lastPed, 1 do
        if lastPed[i] == ped then
            hasTarget = false
            return
        end
    end

    math.randomseed(GetGameTimer())
    local successChance = math.random(1, 100)
    local scamChance = math.random(1, 100)
    local getRobbed = math.random(1, 100)
    if successChance <= Config.SellingDrugs.SuccessChance then hasTarget = false return end
    if not availableDrugs then hasTarget = false return end
    local drugType = math.random(1, #availableDrugs)
    currentOfferDrug = availableDrugs[drugType]
    local maxAmount = Config.SellingDrugs.DrugsList[currentOfferDrug.item]?.maxAmount or 3
    local bagAmount = math.random(1, maxAmount)
    if bagAmount >= 5 then bagAmount = math.random(1, 5) end

    local ddata = Config.SellingDrugs.DrugsList[currentOfferDrug.item]
    local randomPrice = math.random(ddata.PriceMin, ddata.PriceMax) * bagAmount
    if scamChance <= Config.SellingDrugs.ScamChance then randomPrice = math.random(3, 10) * bagAmount end
    QBCore.Functions.TakeControl(ped)
    ClearPedTasks(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)
    local coords = GetEntityCoords(cache.ped, true)
    local heading = math.rad(GetEntityHeading(cache.ped) - 180)
    local pedCoords = GetEntityCoords(ped)
    local pedDist = #(coords - pedCoords)
    if getRobbed <= Config.SellingDrugs.RobberyChance then
        TaskGoStraightToCoord(ped, coords, 15.0, -1, heading, 0.0)
    else
        TaskGoStraightToCoord(ped, coords, 1.2, -1, heading, 0.0)
    end

    while pedDist > 2.5 do
        coords = GetEntityCoords(cache.ped, true)
        pedCoords = GetEntityCoords(ped)
        heading = math.rad(GetEntityHeading(cache.ped) - 180)
        if getRobbed <= Config.SellingDrugs.RobberyChance then
            TaskGoStraightToCoord(ped, coords, 15.0, -1, heading, 0.0)
        else
            TaskGoStraightToCoord(ped, coords, 1.2, -1, heading, 0.0)
        end
        TaskGoStraightToCoord(ped, coords, 1.2, -1, heading, 0.0)
        pedDist = #(coords - pedCoords)
        Wait(100)
    end
    ClearPedTasksImmediately(ped)
    TaskLookAtEntity(ped, cache.ped, 500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, cache.ped, 500)
    Wait(500)
    ClearPedTasksImmediately(ped)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_HANG_OUT_STREET", 0, true)
    SetPedKeepTask(ped, true)
    if hasTarget then
        while pedDist < 2.5 and not IsPedDeadOrDying(ped) do
            local coords2 = GetEntityCoords(cache.ped, true)
            local pedCoords2 = GetEntityCoords(ped)
            local pedDist2 = #(coords2 - pedCoords2)
            if getRobbed <= Config.SellingDrugs.RobberyChance then
                TriggerServerEvent('prdx_drugs:server:robCornerDrugs', availableDrugs[drugType].item, bagAmount)
                QBCore.Functions.Notify('You have been robbed and lost '..bagAmount..' bag(s) of '..availableDrugs[drugType].label, 'error')
                stealingPed = ped
                stealData = {
                    item = availableDrugs[drugType].item,
                    amount = bagAmount,
                }
                local moveto = GetEntityCoords(cache.ped)
                local movetoCoords = {x = moveto.x + math.random(100, 500), y = moveto.y + math.random(100, 500), z = moveto.z, }
                ClearPedTasksImmediately(ped)
                TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)
                lastPed[#lastPed + 1] = ped
                RobberyPed()
                Wait(Config.CornerCooldown * 60000)
                hasTarget = false
                break
            else
                if pedDist2 < 2.5 and cornerselling then
                    if not zoneMade then
                        zoneMade = true
                        local options = {
                            {
                                name = 'prdx:drugs:sellDrugs',
                                icon = 'fas fa-hand-holding-dollar',
                                label = "Sell "..bagAmount.."x "..currentOfferDrug.label.." for $"..randomPrice.."?",
                                distance = 2.0,
                                event = 'prdx_drugs:client:AcceptOffer',
                                args = {drugType, bagAmount, randomPrice}
                            },
                            {
                                name = 'prdx:drugs:declineOffer',
                                icon = 'fas fa-x',
                                label = "Decline offer",
                                distance = 2.0,
                                event = 'prdx_drugs:client:DeclineOffer'
                            }
                        }
                        exports.ox_target:addEntity(NetworkGetNetworkIdFromEntity(ped), options)
                    end
                else
                    zoneMade = false
                    exports.ox_target:removeEntity(NetworkGetNetworkIdFromEntity(ped), {'prdx:drugs:sellDrugs', 'prdx:drugs:declineOffer'})
                    hasTarget = false
                    isBusy = false
                    break
                end
            end
            Wait(0)
        end
        Wait(math.random(4000, 7000))
    end
end

AddEventHandler('prdx_drugs:client:AcceptOffer', function(data)
    if not isBusy then
        isBusy = true
        LocalPlayer.state:set("inv_busy", true, true)
        PoliceCall()
        TriggerEvent('animations:client:EmoteCommandStart', {"drugdeal"})
        SetTimeout(math.random(1, Config.SellingDrugs.DelayTimer) * 60000, function()
            findClient = true
            print('Find next offer:', findClient)
        end)
        lib.requestAnimDict('mp_common')
        QBCore.Functions.Progressbar("accept_offer", 'Completing deal...', math.random(5000, 7000), false, true, 
            {disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false,}, {}, {}, {}, function() 
            TriggerEvent('animations:client:EmoteCommandStart', {"give"})
            local drugType, bagAmount, randomPrice = data.args[1], data.args[2], data.args[3]
            local entity = data.entity
            TriggerServerEvent('prdx_drugs:server:sellCornerDrugs', availableDrugs[drugType].item, bagAmount, randomPrice)
            SetPedKeepTask(entity, false)
            ClearPedTasksImmediately(entity)
            Wait(0)
            TaskPlayAnim(entity, "mp_common", "givetake2_b", 8.0, -8.0, -1, 1, 0, false, false, false)
            Wait(2500)
            ClearPedTasksImmediately(entity)
            SetEntityAsNoLongerNeeded(entity)
            TaskWanderStandard(entity, 10.0, 10)
            lastPed[#lastPed + 1] = entity
            exports.ox_target:removeEntity(NetworkGetNetworkIdFromEntity(entity), {'prdx:drugs:sellDrugs', 'prdx:drugs:declineOffer'})
            LocalPlayer.state:set("inv_busy", false, true)
            hasTarget = false
            findClient = false
            isBusy = false
        end, function()
            QBCore.Functions.Notify("Cancelled deal!", "error")
            isBusy = false
            return true
        end)
    else
        QBCore.Functions.Notify("Error: Too fast", "error")
    end
end)

AddEventHandler('prdx_drugs:client:DeclineOffer', function(data)
    local entity = data.entity
    TriggerEvent('animations:client:EmoteCommandStart', {"pointdown"})
    SetTimeout(math.random(1, Config.SellingDrugs.DelayTimer) * 60000, function()
        findClient = true
        print('Find next offer:', findClient)
    end)
    QBCore.Functions.Notify('Offer declined', 'error')
    SetPedKeepTask(entity, false)
    SetEntityAsNoLongerNeeded(entity)
    ClearPedTasksImmediately(entity)
    TaskWanderStandard(entity, 10.0, 10)
    lastPed[#lastPed + 1] = entity
    exports.ox_target:removeEntity(NetworkGetNetworkIdFromEntity(entity), {'prdx:drugs:sellDrugs', 'prdx:drugs:declineOffer'})
    hasTarget = false
    findClient = false
    isBusy = false
end)

local function ToggleSelling()
    if not cornerselling then
        QBCore.Functions.Notify('Started to sell drugs, it may take some time for people to see you!')
        Wait(math.random(1, Config.SellingDrugs.DelayTimer) * 60000)
        local startLocation = GetEntityCoords(cache.ped)
        QBCore.Functions.Notify('Looks like people are noticing you...')
        cornerselling = true
        findClient = true
        CreateThread(function()
            while cornerselling do
                local sleep = 1000
                local player = cache.ped
                local coords = GetEntityCoords(player)
                local startDist = #(startLocation - coords)
                if startDist > 50.0 then
                    TooFarAway()
                elseif findClient then
                    sleep = 0
                    if not hasTarget then
                        local PlayerPeds = {}
                        if next(PlayerPeds) == nil then
                            for _, activePlayer in ipairs(GetActivePlayers()) do
                                local ped = GetPlayerPed(activePlayer)
                                PlayerPeds[#PlayerPeds + 1] = ped
                            end
                        end
                        local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
                        if closestDistance < 15.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) and GetPedType(closestPed) ~= 28 then
                            SellToPed(closestPed)
                        end
                    end
                end
                Wait(sleep)
            end
        end)
    else
        stealingPed = nil
        stealData = {}
        cornerselling = false
        LocalPlayer.state:set("inv_busy", false, true)
        QBCore.Functions.Notify('Stopped selling drugs', 'error')
    end
end

-- Events
RegisterNetEvent('prdx_drugs:client:cornerselling', function()
    QBCore.Functions.TriggerCallback('prdx_drugs:server:cornerselling:getAvailableDrugs', function(result)
        if CurrentCops >= Config.MinimumDrugSalePolice then
            if result then
                availableDrugs = result
                ToggleSelling()
            else
                QBCore.Functions.Notify('No drugs', 'error')
                LocalPlayer.state:set("inv_busy", false, true)
            end
        else
            QBCore.Functions.Notify('Streets are too clean, no buyers around', "error")
        end
    end)
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('prdx_drugs:client:refreshAvailableDrugs', function(items)
    availableDrugs = items
    if #availableDrugs <= 0 then
        QBCore.Functions.Notify('No drugs left', 'error')
        cornerselling = false
        LocalPlayer.state:set("inv_busy", false, true)
    end
end)