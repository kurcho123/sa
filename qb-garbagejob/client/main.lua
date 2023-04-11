local QBCore = exports['qb-core']:GetCoreObject()
local garbageVehicle = nil
local hasBag = false
local currentStop = 0
local deliveryBlip = nil
local isWorking = false
local amountOfBags = 0
local bagsCollected = 0
local garbageObject = nil
local endBlip = nil
local garbageBlip = nil
local canTakeBag = true
local currentStopNum = 0
local payCoords = vector3(Config.Locations["paycheck"].coords.x, Config.Locations["paycheck"].coords.y, Config.Locations["paycheck"].coords.z)
local vehCoords = vector3(Config.Locations["vehicle"].coords.x, Config.Locations["vehicle"].coords.y, Config.Locations["vehicle"].coords.z)
local MyTruck = nil
local runActive = false
local party = nil
local driverCitizenId = nil
local routeInProgress = false

-- Handlers

local function setupClient()
    if endBlip ~= nil then
        RemoveBlip(endBlip)
    end
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
    garbageVehicle = nil
    hasBag = false
    currentStop = 0
    deliveryBlip = nil
    isWorking = false
    amountOfBags = 0
    garbageObject = nil
    endBlip = nil
    currentStopNum = 0
    runActive = false
    party = nil
    driverCitizenId = nil
    routeInProgress = false
    garbageBlip = AddBlipForCoord(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y, Config.Locations["main"].coords.z)
    SetBlipSprite(garbageBlip, 318)
    SetBlipDisplay(garbageBlip, 4)
    SetBlipScale(garbageBlip, 0.5)
    SetBlipAsShortRange(garbageBlip, true)
    SetBlipColour(garbageBlip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["main"].label)
    EndTextCommandSetBlipName(garbageBlip)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    setupClient()
    -- Resume existing route if found
    QBCore.Functions.TriggerCallback("garbagejob:server:GetExistingRoute", function(response)
        if response then
            routeInProgress = true
            QBCore.Functions.Notify({text = "You currently have a garbage route in progress!", caption = "Get into a garbage truck to resume the route or head back to the depot to end the route!"}, "inform", 15000)
            while not IsPedInAnyVehicle(PlayerPedId(), false) and Entity(GetVehiclePedIsIn(PlayerPedId())).state.garbageJobVehicle ~= "true" do
                Wait(1000)
                if routeInProgress == false then
                    return
                end
            end
            if routeInProgress then
                garbageVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                exports['qb-target']:AddTargetEntity(garbageVehicle, {
                    options = {
                        {
                            type = "client",
                            event = "garbage:putTrashTruck",
                            icon = "fas fa-sign-in-alt",
                            label = "Put trash in truck"
                        },
                    },
                    distance = 3.0
                })
                currentStopNum = response.currentStop + 1
                currentStop = response.stops[currentStopNum].stop
                amountOfBags = response.stops[currentStopNum].bags
                isWorking = true
                exports['qb-target']:RemoveZone('trashcans')
                SetGarbageRoute()
                QBCore.Functions.Notify("Successfully resumed your existing garbage route!", "success")
            end
        end
    end)
end)

AddEventHandler('onResourceStop', function(resource)
    if GetCurrentResourceName() == resource then
        if garbageObject ~= nil then
            DeleteEntity(garbageObject)
            garbageObject = nil
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        setupClient()
    end
end)

-- Functions

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function DrawText3D2(coords, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords.x,coords.y,coords.z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function LoadAnimation(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(10) end
end

local function BringBackCar()
    local veh = GetVehiclePedIsIn(PlayerPedId(), true)
    QBCore.Functions.DeleteVehicle(veh)
    QBCore.Functions.DeleteVehicle(garbageVehicle)    
    if endBlip ~= nil then
        RemoveBlip(endBlip)
    end
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
    garbageVehicle = nil
    hasBag = false
    currentStop = 0
    deliveryBlip = nil
    isWorking = false
    amountOfBags = 0
    garbageObject = nil
    endBlip = nil
    currentStopNum = 0
    runActive = false
    party = nil
    driverCitizenId = nil
    routeInProgress = false
end

local function SetRouteBack()
    local inleverpunt = Config.Locations["vehicle"]
    endBlip = AddBlipForCoord(inleverpunt.coords.x, inleverpunt.coords.y, inleverpunt.coords.z)
    exports['qb-target']:RemoveZone('trashcans')
    SetBlipSprite(endBlip, 1)
    SetBlipDisplay(endBlip, 2)
    SetBlipScale(endBlip, 0.5)
    SetBlipAsShortRange(endBlip, false)
    SetBlipColour(endBlip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["vehicle"].name)
    EndTextCommandSetBlipName(endBlip)
    SetBlipRoute(endBlip, true)
end

local function AnimCheck()
    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            if hasBag then
                if not IsEntityPlayingAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 3) then
                    ClearPedTasksImmediately(ped)
                    LoadAnimation('missfbi4prepp1')
                    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                end
            else
                break
            end
            Wait(200)
        end
    end)
end

local function TakeAnim()
    local ped = PlayerPedId()
    local pedcoords = GetEntityCoords(ped)
    TriggerEvent('animations:client:EmoteCommandStart', {"bumbin"})
    QBCore.Functions.Progressbar("collectbag", "Collecting bag...", math.random(2000,5000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        LoadAnimation('missfbi4prepp1')
        TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_walk_garbage_man', 6.0, -6.0, -1, 49, 0, 0, 0, 0)
        QBCore.Functions.SpawnObject("prop_cs_rub_binbag_01", function(garbageBag)
            garbageObject = ObjToNet(garbageBag)
            AttachEntityToEntity(garbageBag, ped, GetPedBoneIndex(ped, 57005), 0.12, 0.0, -0.05, 220.0, 120.0, 0.0, true, true, false, true, 1, true)
        end, vec3(pedcoords.x, pedcoords.y, pedcoords.z - 20.0), true)
        AnimCheck()
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Canceled", "error")
    end)
end

local function DeliverAnim()
    local ped = PlayerPedId()
    LoadAnimation('missfbi4prepp1')
    TaskPlayAnim(ped, 'missfbi4prepp1', '_bag_throw_garbage_man', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, GetEntityHeading(garbageVehicle))
    canTakeBag = false
    SetTimeout(1250, function()
        FreezeEntityPosition(ped, false)
        canTakeBag = true
        TaskPlayAnim(ped, 'missfbi4prepp1', 'exit', 8.0, 8.0, 1100, 48, 0.0, 0, 0, 0)        
        DetachEntity(garbageObject, 1, false)
        TriggerServerEvent('QBCore:Game:Delete', garbageObject)
        garbageObject = nil        
    end)
end

function SetGarbageRoute()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local CurrentLocation = Config.Locations["trashcan"][currentStop]
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
    exports['qb-target']:AddBoxZone("trashcans", vector3(CurrentLocation.pz), CurrentLocation.length, CurrentLocation.width, {
        name = "trashcans", 
        heading = CurrentLocation.heading,
        debugPoly = CurrentLocation.debugPz,
        minZ = CurrentLocation.minZ,
        maxZ = CurrentLocation.maxZ,
        }, {
            options = {
                {
                    type = "client",
                    event = "garbage:takeBag",
                    icon = "fas fa-sign-in-alt",
                    label = "Get bag of trash"
                },
            },
            distance = 3.0
    })
    deliveryBlip = AddBlipForCoord(CurrentLocation.coords.x, CurrentLocation.coords.y, CurrentLocation.coords.z)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 0.5)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Config.Locations["trashcan"][currentStop].name)
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
end

RegisterNetEvent("garbage:endRoute", function()
    BringBackCar()
end)

RegisterNetEvent('garbage:takeBag')
AddEventHandler('garbage:takeBag', function()
    if currentStop ~= 0 and deliveryBlip ~= nil then
        if not hasBag and canTakeBag then
            hasBag = true
            TakeAnim()
        end
    else
        QBCore.Functions.Notify("You must be clocked in to collect trash.", 'error')
    end
end)

RegisterNetEvent('garbage:putTrashTruck')
AddEventHandler('garbage:putTrashTruck', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    if hasBag then
        LoadAnimation('missfbi4prepp1')
        if DoesEntityExist(garbageVehicle) then
            QBCore.Functions.Progressbar("deliverbag", "Putting bag in trashmaster ..", 2000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                hasBag = false
                bagsCollected = bagsCollected + 1
                -- Looks if you have delivered all bags
                if (amountOfBags - 1) == 0 then
                    QBCore.Functions.TriggerCallback('garbagejob:server:NextStop', function(hasMoreStops, nextStop, newBagAmount)
                        if hasMoreStops and nextStop ~= 0 then
                            -- Here he puts your next location and you are not finished working yet.
                            currentStop = nextStop
                            currentStopNum = currentStopNum + 1
                            amountOfBags = newBagAmount
                            bagsCollected = 0
                            SetGarbageRoute()
                            QBCore.Functions.Notify({text = "All garbage bags collected!", caption = "Proceed to the next location or head back to the depot to end your route early!"}, "success", 7500)
                        else
                            if hasMoreStops and nextStop == currentStop then
                                QBCore.Functions.Notify("There was an issue at the depot, please return immediately!")
                                amountOfBags = 0
                            else
                                -- You are done with work here.
                                QBCore.Functions.Notify("You are done working! Head back to the depot.")
                                isWorking = false
                                RemoveBlip(deliveryBlip)
                                SetRouteBack()
                                amountOfBags = 0
                            end
                        end
                    end, currentStop, currentStopNum, pos, bagsCollected, driverCitizenId)
                    hasBag = false
                else
                    -- You haven't delivered all bags here
                    amountOfBags = amountOfBags - 1
                    QBCore.Functions.Notify("There is still "..amountOfBags.." bag(s) left to collect!")
                    hasBag = false
                end

                DeliverAnim()
            end, function() -- Cancel
                QBCore.Functions.Notify("Canceled", "error")
            end)
        else
            QBCore.Functions.Notify("You have no truck", "error")
            DeliverAnim()
            hasBag = false
        end
    else
        QBCore.Functions.Notify("You don\'t have trash..", "error")
    end
end)

-- Events

RegisterNetEvent('garbagejob:client:SetWaypointHome', function()
    SetNewWaypoint(Config.Locations["main"].coords.x, Config.Locations["main"].coords.y)
end)

RegisterNetEvent('garbage:paySlip', function()
    TriggerServerEvent('garbagejob:server:PayShift')
end)

RegisterNetEvent('garbage:getTruck')
AddEventHandler('garbage:getTruck', function()

    if runActive == false then 
        runActive = true
        QBCore.Functions.TriggerCallback('garbagejob:server:NewShift', function(shouldContinue, firstStop, totalBags)
            if shouldContinue then
                local coords = Config.Locations["vehicle"].coords
                QBCore.Functions.SpawnVehicle("trash2", function(veh)
                    TaskWarpPedIntoVehicle(ped, veh, -1) -- hopefully this fixes an issue if something is delayed they'll get crushed
                    SetVehicleEngineOn(veh, true, true)
                    garbageVehicle = veh
                    NetworkRegisterEntityAsNetworked(garbageVehicle)
                    SetVehicleNumberPlateText(veh, "GARB"..tostring(math.random(1000, 9999)))
                    SetEntityHeading(veh, coords.w)
                    exports['ps-fuel']:SetFuel(veh, 100.0)
                    SetEntityAsMissionEntity(veh, true, true)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                    exports['qb-target']:AddTargetEntity(veh, {
                        options = {
                            {
                                type = "client",
                                event = "garbage:putTrashTruck",
                                icon = "fas fa-sign-in-alt",
                                label = "Put trash in truck"
                            },
                        },
                        distance = 3.0
                    })
                    currentStop = firstStop
                    currentStopNum = 1
                    amountOfBags = totalBags
                    isWorking = true
                    exports['qb-target']:RemoveZone('trashcans')
                    SetGarbageRoute()
                    local randomDrop = math.random(1,500)
                    if randomDrop == 69 then -- 1% drop
                        TriggerServerEvent('blueprints:server:GiveBlueprint', 'advancedlockpick')
                    elseif randomDrop == 420 then -- 1% drop
                        TriggerServerEvent('blueprints:server:GiveBlueprint', 'screwdriverset')
                    end
                    QBCore.Functions.Notify("You have paid a deposit of $"..Config.TruckPrice.." to use the truck!")
                    QBCore.Functions.Notify("You have started working, location marked on GPS!")
                    Wait(1000)
                    local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
                    QBCore.Functions.SetStateBag(playerVeh, "garbageJobVehicle", "true")
                end, coords, true)
            else
                QBCore.Functions.Notify("You do not have enough money for the deposit.. Deposit costs are $"..Config.TruckPrice)
            end
        end)
    else
        QBCore.Functions.Notify("You are already doing a garbage run, complete that job first.")
    end
end)

RegisterNetEvent('garbage:returnTruck')
AddEventHandler('garbage:returnTruck', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local distance = #(pos - vehCoords)
    local InVehicle = IsPedInAnyVehicle(ped, false)
    if distance < 25.0 then
        if not InVehicle then
            if not party then
                QBCore.Functions.TriggerCallback('garbagejob:server:EndShift', function(endShift)
                    if endShift then
                        TriggerServerEvent('garbagejob:server:PayShift')
                        BringBackCar()
                        --QBCore.Functions.Notify("Truck returned, collect your payslip to recieve your pay and deposit back!")
                    else
                        QBCore.Functions.Notify("You have no deposit paid on this vehicle..", "error")
                        currentStopNum = 0
                        currentStop = 0
                    end
                end, pos)
            else
                QBCore.Functions.Notify("The person who started the route is required to collect the pay!", "error")
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn then
            local PlayerData = QBCore.Functions.GetPlayerData()
            if not isWorking and not routeInProgress and not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
                    if Entity(playerVeh).state.garbageJobVehicle == "true" then
                        local pedInDriverSeat = GetPedInVehicleSeat(playerVeh, -1)
                        if pedInDriverSeat and IsPedAPlayer(pedInDriverSeat) and GetPedInVehicleSeat(playerVeh, -1) ~= PlayerPedId() then
                            if not party then
                                QBCore.Functions.TriggerCallback("garbagejob:server:GetPartyInfo", function(response, driverId, driverName)
                                    party = response
                                    garbageVehicle = playerVeh
                                    exports['qb-target']:AddTargetEntity(playerVeh, {
                                        options = {
                                            {
                                                type = "client",
                                                event = "garbage:putTrashTruck",
                                                icon = "fas fa-sign-in-alt",
                                                label = "Put trash in truck"
                                            },
                                        },
                                        distance = 3.0
                                    })
                                    driverCitizenId = driverId
                                    currentStop = party.stops[party.currentStop].stop
                                    currentStopNum = party.currentStop
                                    amountOfBags = party.stops[party.currentStop].bags
                                    isWorking = true
                                    exports['qb-target']:RemoveZone('trashcans')
                                    SetGarbageRoute()
                                    QBCore.Functions.Notify("Successfully joined " .. driverName .. "'s garbage route!", "success")
                                end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(pedInDriverSeat)))
                            else
                                Wait(5000)
                            end
                        else
                            Wait(5000)
                        end
                    else
                        Wait(5000)
                    end
                end
            else
                Wait(5000)
            end
        end
    end
end)