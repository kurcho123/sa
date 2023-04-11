-- Variables
local currentGarage = 1
local inFingerprint = false
local FingerPrintSessionId = nil
local isDriving = false
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

local function GetClosestPlayer() -- interactions, job, tracker
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i = 1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

local function openFingerprintUI()
    SendNUIMessage({
        type = "fingerprintOpen"
    })
    inFingerprint = true
    SetNuiFocus(true, true)
end

local function SetCarItemsInfo()
	local items = {}
	for k, item in pairs(Config.CarItems) do
		local itemInfo = exports.ox_inventory:Items()[item.name]
		items[item.slot] = {
			name = itemInfo.name,
			amount = tonumber(item.amount),
			info = item.info,
			label = itemInfo["label"],
			description = itemInfo.description and itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
		}
	end
	Config.CarItems = items
end

local function doCarDamage(currentVehicle, veh)
	local smash = false
	local damageOutside = false
	local damageOutside2 = false
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0

	if engine < 200.0 then engine = 200.0 end
    if engine  > 1000.0 then engine = 950.0 end
	if body < 150.0 then body = 150.0 end
	if body < 950.0 then smash = true end
	if body < 920.0 then damageOutside = true end
	if body < 920.0 then damageOutside2 = true end

    Citizen.Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)

	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end

	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end

	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end

	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

function TakeOutImpound(vehicle)
    local coords = Config.Locations["impound"][currentGarage]
    QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
        
        --local veh = NetToVeh(retveh)
        QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
            QBCore.Functions.SetVehicleProperties(veh, properties)
            SetVehicleNumberPlateText(veh, vehicle.plate)
            SetEntityHeading(veh, coords.w)
            exports['ps-fuel']:SetFuel(veh, vehicle.fuel)
            doCarDamage(veh, vehicle)
            TriggerServerEvent('police:server:TakeOutImpound',vehicle.plate)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, vehicle.plate)
    end, coords, true)
end

RegisterNetEvent('police:client:TakeOutImpound', function(data)
    local vehicle = data.vehicle
    TakeOutImpound(vehicle)
end)

function TakeOutVehicle(vehicleInfo)
    local coords
    local properties = json.decode(vehicleInfo.mods)
    for k,v in pairs(Config.Locations["vehicle"][currentGarage]) do
        local isSpawnPointClear = QBCore.Functions.IsSpawnPointClear(v.xyz, 1.0)
        if isSpawnPointClear then
            coords = v
            break
        end
    end
    if coords then
        QBCore.Functions.SpawnVehicle(vehicleInfo.vehicle, function(veh)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            SetEntityHeading(veh, coords.w)
            if properties ~= nil then
                QBCore.Functions.SetVehicleProperties(veh, properties)
                if vehicleInfo.vehicle == "11cvpiw" then
                    if string.sub(vehicleInfo.name, 1, 4) == "LSPD" then
                        SetVehicleLivery(veh, 0)
                    elseif string.sub(vehicleInfo.name, 1, 4) == "BCSO" then
                        SetVehicleLivery(veh, 2)
                    elseif string.sub(vehicleInfo.name, 1, 4) == "SAST" then
                        SetVehicleLivery(veh, 4)
                    elseif string.sub(vehicleInfo.name, 1, 2) == "HC" then
                        SetVehicleLivery(veh, 6)
                    elseif string.sub(vehicleInfo.name, 1, 9) == "Marshalls" then
                        SetVehicleLivery(veh, 7)
                    elseif string.sub(vehicleInfo.name, 1, 3) == "CID" then
                        SetVehicleLivery(veh, 8) 
                        SetVehicleColours(veh, 0, 0)
                        SetVehicleMod(veh, 1, 0, false)
                        SetVehicleMod(veh, 7, 1, false)
                        SetVehicleMod(veh, 42, 2, false)
                        SetVehicleExtra(veh, 1, 0)
                        SetVehicleExtra(veh, 2, 0)
                        SetVehicleExtra(veh, 3, 0)
                        SetVehicleExtra(veh, 4, 0)
                        SetVehicleExtra(veh, 5, 0)
                        SetVehicleExtra(veh, 6, 0)
                        SetVehicleExtra(veh, 7, 0)
                        SetVehicleExtra(veh, 8, 0)
                        SetVehicleExtra(veh, 9, 0)
                    end
                elseif vehicleInfo.vehicle == "leg18taurus" then
                    if string.sub(vehicleInfo.name, 1, 4) == "LSPD" then
                        SetVehicleLivery(veh, 0)
                        SetVehicleExtra(veh, 4, 0)
                    elseif string.sub(vehicleInfo.name, 1, 4) == "BCSO" then
                        SetVehicleLivery(veh, 2)
                        SetVehicleExtra(veh, 4, 0)
                    elseif string.sub(vehicleInfo.name, 1, 4) == "SAST" then
                        SetVehicleLivery(veh, 4)
                        SetVehicleExtra(veh, 4, 0)
                    elseif string.sub(vehicleInfo.name, 1, 2) == "HC" then
                        SetVehicleLivery(veh, 6)
                        SetVehicleColours(veh, 0, 0)
                        SetVehicleExtra(veh, 1, 0)
                        SetVehicleExtra(veh, 2, 1)
                        SetVehicleExtra(veh, 3, 1)
                        SetVehicleExtra(veh, 4, 0)
                        SetVehicleExtra(veh, 5, 0)
                        SetVehicleExtra(veh, 6, 0)
                        SetVehicleExtra(veh, 7, 0)
                        SetVehicleExtra(veh, 8, 0)
                        SetVehicleExtra(veh, 9, 1)
                        SetVehicleExtra(veh, 10, 0)
                        SetVehicleExtra(veh, 11, 0)
                        SetVehicleExtra(veh, 12, 0)
                    elseif string.sub(vehicleInfo.name, 1, 8) == "Marshals" then
                        SetVehicleLivery(veh, 6)
                        SetVehicleColours(veh, 0, 0)
                        SetVehicleExtra(veh, 1, 0)
                        SetVehicleExtra(veh, 2, 1)
                        SetVehicleExtra(veh, 3, 1)
                        SetVehicleExtra(veh, 4, 0)
                        SetVehicleExtra(veh, 5, 0)
                        SetVehicleExtra(veh, 6, 0)
                        SetVehicleExtra(veh, 7, 0)
                        SetVehicleExtra(veh, 8, 0)
                        SetVehicleExtra(veh, 9, 1)
                        SetVehicleExtra(veh, 10, 0)
                        SetVehicleExtra(veh, 11, 0)
                        SetVehicleExtra(veh, 12, 0)
                    elseif string.sub(vehicleInfo.name, 1, 3) == "CID" then
                        SetVehicleLivery(veh, 6) 
                        SetVehicleColours(veh, 0, 0)
                        SetVehicleExtra(veh, 1, 0)
                        SetVehicleExtra(veh, 2, 1)
                        SetVehicleExtra(veh, 3, 1)
                        SetVehicleExtra(veh, 4, 0)
                        SetVehicleExtra(veh, 5, 0)
                        SetVehicleExtra(veh, 6, 0)
                        SetVehicleExtra(veh, 7, 0)
                        SetVehicleExtra(veh, 8, 0)
                        SetVehicleExtra(veh, 9, 1)
                        SetVehicleExtra(veh, 10, 0)
                        SetVehicleExtra(veh, 11, 0)
                        SetVehicleExtra(veh, 12, 0)
                    end
                elseif vehicleInfo.vehicle == "leg21durango" then
                    if string.sub(vehicleInfo.name, 1, 2) == "HC" then
                        SetVehicleLivery(veh, 0)
                        SetVehicleExtra(veh, 4, 0)
                    elseif string.sub(vehicleInfo.name, 1, 8) == "Marshals" then
                        SetVehicleLivery(veh, 1)
                        SetVehicleExtra(veh, 4, 0)
                    end
                elseif vehicleInfo.vehicle == "viperleo" then
                    SetVehicleLivery(veh, 0)
                    SetVehicleExtra(veh, 10, 0)
                    SetVehicleExtra(veh, 11, 0)
                    QBCore.Functions.SetStateBag(veh, 'tunerData', 'pursuit')
                    exports['ps-fuel']:SetFuel(veh, 100.0)
                elseif vehicleInfo.vehicle == "kawasaki" then
                    print('I am moto unit')
                    SetVehicleLivery(veh, 0)
                    SetVehicleExtra(veh, 1, 0)
                    SetVehicleExtra(veh, 2, 0)
                    SetVehicleExtra(veh, 3, 0)
                    SetVehicleExtra(veh, 4, 0)
                    SetVehicleExtra(veh, 5, 1)
                    SetVehicleExtra(veh, 6, 1)
                end
                SetVehicleDirtLevel(veh, 0.0)
                SetCarItemsInfo()
                --SetVehicleNumberPlateText(veh, "M"..tostring(math.random(1000000, 9999999)))
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
                QBCore.Functions.SetStateBag(veh, 'powerDecrease', 0)
                QBCore.Functions.SetStateBag(veh, 'id', vehicleInfo.id)
                local props = QBCore.Functions.GetVehicleProperties(veh)
                TriggerServerEvent("police:server:setVehicleState", NetworkGetNetworkIdFromEntity(veh), vehicleInfo.id, 0, props)
            end
            SetVehicleEngineOn(veh, true, true)
        end, coords, true, true)
    else
        QBCore.Functions.Notify("There are no free spaces to pull out this vehicle", "error", 5000)
    end
end

RegisterNetEvent('police:client:TakeOutVehicle', function(data)
    TakeOutVehicle(data)
end)

local function IsArmoryWhitelist() -- being removed
    local retval = false

    if QBCore.Functions.GetPlayerData().job.name == 'police' then
        retval = true
    end
    return retval
end

-- GUI Menu Functions (being replaced)

function MenuGarage()
    local Categories = {}
    local CategoryVehicles = {}
    local vehicleMenu = { }

    QBCore.Functions.TriggerCallback('police:server:getAvailableVehicles', function(vehicles)
        local availableVehicles = vehicles
        for k, v in pairs(availableVehicles) do
            if Categories[v.name] then
                Categories[v.name] = Categories[v.name] + 1
                CategoryVehicles[v.name][#CategoryVehicles[v.name]+1] = v
            else
                Categories[v.name] = 1
                CategoryVehicles[v.name] = {v}
            end
        end

        for category,amount in pairs(Categories) do
            vehicleMenu[#vehicleMenu+1] = {
                title = category,
                description = amount..' Vehicles',
                event = "police:client:openCategory",
                args = CategoryVehicles[category]
            }
        end
        lib.registerContext({
            id = 'policeVehicleMenu',
            title = 'Available Police Vehicles',
            onExit = function() end,
            options = vehicleMenu
        })
        lib.showContext('policeVehicleMenu')
    end)
end

RegisterNetEvent('police:client:openCategory', function(CategoryVehicles)
    local vehicleMenu = {}
    
    --QBCore.Functions.Tableprint(CategoryVehicles)
    for k,v in pairs(CategoryVehicles) do
        local vehmods = json.decode(v.mods) or {}
        if not vehmods.fuelLevel then vehmods.fuelLevel = 100 end
        vehicleMenu[#vehicleMenu+1] = {
            title = v.name,
            description = 'Plate: ' ..(vehmods.plate or 'UNKNOWN')..' | Fuel: '.. QBCore.Shared.Round(vehmods.fuelLevel)..'%',
            progress = QBCore.Shared.Round(vehmods.fuelLevel),
            event = "police:client:TakeOutVehicle",
            args = {
                id = v.id,
                vehicle = v.vehicle,
                mods = v.mods,
                name = v.name
            }
        }
    end

    lib.registerContext({
        id = 'policeCatMenu',
        title = 'Available Police Vehicles',
        onExit = function() end,
        options = vehicleMenu
    })
    lib.showContext('policeCatMenu')
end)


function MenuVehiclePersonalPurchase()
    local vehicleMenu = {}

    local purchasableVehicles = Config.PersonalVehicles[currentGarage]
    if purchasableVehicles then
        for k, v in pairs(purchasableVehicles) do
            vehicleMenu[#vehicleMenu+1] = {
                title = v.name,
                description = "$" .. v.price,
                event = "police:client:PurchasePersonalVehicle",
                args = {
                    vehicle = k,
                    price = v.price,
                    name = v.name
                }
            }
        end
    else
        vehicleMenu[#vehicleMenu+1] = {
            title = "No available vehicles to purchase",
            description = "Check back later"
        }
    end
    lib.registerContext({
        id = 'policePurchasableMenu',
        title = 'Purchasable Police Vehicles',
        onExit = function() end,
        options = vehicleMenu
    })
    lib.showContext('policePurchasableMenu')
end

function MenuVehiclePoolPurchase()
    local vehicleMenu = {}

    local purchasableVehicles = Config.PoolVehicles[currentGarage]
    if purchasableVehicles then
        for k, v in pairs(purchasableVehicles) do
            vehicleMenu[#vehicleMenu+1] = {
                title = v.name,
                description = "$" .. v.price,
                serverEvent = "police:server:PurchasePoolVehicle",
                args = {
                    vehicle = k,
                    price = v.price,
                    name = v.name
                }
            }
        end
    else
        vehicleMenu[#vehicleMenu+1] = {
            title = "No available vehicles to purchase",
            description = "Check back later",
        }
    end
    lib.registerContext({
        id = 'MenuVehiclePoolPurchase',
        title = 'Purchasable Police Vehicles',
        onExit = function() end,
        options = vehicleMenu
    })
    lib.showContext('MenuVehiclePoolPurchase')
end

function StoreVehicle()
    local veh = GetVehiclePedIsIn(PlayerPedId(), true)
    if veh ~= 0 then
        local netId = NetworkGetNetworkIdFromEntity(veh)
        local idState = Entity(veh).state.id
        local props = QBCore.Functions.GetVehicleProperties(veh)
        TriggerServerEvent("police:server:setVehicleState", netId, idState, 1, props)
        QBCore.Functions.DeleteVehicle(veh)
    end
end

function MenuImpound()
    local impoundMenu = {}
    QBCore.Functions.TriggerCallback("police:GetImpoundedVehicles", function(result)
        local shouldContinue = false
        if result == nil then
            QBCore.Functions.Notify("There are no impounded vehicles", "error", 5000)
        else
            shouldContinue = true
            for _ , v in pairs(result) do
                local enginePercent = QBCore.Shared.Round(v.engine / 10)
                local bodyPercent = QBCore.Shared.Round(v.body / 10)
                local currentFuel = v.fuel
                local vname = QBCore.Shared.Vehicles[v.vehicle].name

                impoundMenu[#impoundMenu+1] = {
                    title = vname.." ["..v.plate.."]",
                    description = "Engine: " .. enginePercent .. "% | Fuel: "..currentFuel.. "%",
                    event = "police:client:TakeOutImpound",
                    args = {
                        vehicle = v
                    }
                }
            end
        end


        if shouldContinue then
            lib.registerContext({
                id = 'MenuImpound',
                title = 'Impounded Vehicles',
                onExit = function() end,
                options = impoundMenu
            })
            lib.showContext('MenuImpound')
        end
    end)

end

-- NUI

RegisterNUICallback('closeFingerprint', function()
    SetNuiFocus(false, false)
    inFingerprint = false
end)

-- Events

RegisterNetEvent('police:client:showFingerprint', function(playerId)
    openFingerprintUI()
    FingerPrintSessionId = playerId
end)

RegisterNetEvent('police:client:showFingerprintId', function(fid)
    SendNUIMessage({
        type = "updateFingerprintId",
        fingerprintId = fid
    })
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNUICallback('doFingerScan', function(data)
    TriggerServerEvent('police:server:showFingerprintId', FingerPrintSessionId)
end)

RegisterNetEvent('police:client:SendEmergencyMessage', function(coords, message)
    TriggerServerEvent("police:server:SendEmergencyMessage", coords, message)
    TriggerEvent("police:client:CallAnim")
end)

RegisterNetEvent('police:client:EmergencySound', function()
    PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
end)

RegisterNetEvent('police:client:CallAnim', function()
    local isCalling = true
    local callCount = 5
    QBCore.Functions.RequestAnimDict("cellphone@")
    TaskPlayAnim(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 3.0, -1, -1, 49, 0, false, false, false)
    Citizen.Wait(1000)
    Citizen.CreateThread(function()
        while isCalling do
            Citizen.Wait(1000)
            callCount = callCount - 1
            if callCount <= 0 then
                isCalling = false
                StopAnimTask(PlayerPedId(), 'cellphone@', 'cellphone_call_listen_base', 1.0)
            end
        end
    end)
end)

RegisterNetEvent('police:client:ImpoundVehicle', function(fullImpound, price, sentVeh)
    if not sentVeh then
        local vehicle = QBCore.Functions.GetClosestVehicle()
    end
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['ps-fuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            local plate = QBCore.Functions.GetPlate(vehicle)
            TriggerServerEvent("qb-garage:server:updateVehicleStatusPolice", totalFuel, engineDamage, bodyDamage, plate)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
    end
end)

RegisterNetEvent('police:client:DepotVehicle', function(fullImpound, price, sentVeh)
    local vehicle = sentVeh
    if not vehicle then
        vehicle = QBCore.Functions.GetClosestVehicle()
    end
    local bodyDamage = math.ceil(GetVehicleBodyHealth(vehicle))
    local engineDamage = math.ceil(GetVehicleEngineHealth(vehicle))
    local totalFuel = exports['ps-fuel']:GetFuel(vehicle)
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            local plate = QBCore.Functions.GetPlate(vehicle)
            TriggerServerEvent("police:server:Impound", plate, bodyDamage, engineDamage, totalFuel)
            QBCore.Functions.DeleteVehicle(vehicle)
        end
    end
end)

RegisterNetEvent('police:client:CheckStatus', function()
    
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.name == "marshalls" or PlayerData.job.name == "lspd" or PlayerData.job.name == "bcso" or PlayerData.job.name == "sast" or PlayerData.job.name == "hc" or PlayerData.job.name == "pd_cid" then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                QBCore.Functions.TriggerCallback('police:GetPlayerStatus', function(result)
                    
                    if result then
                        if #result > 0 then
                            for k, v in pairs(result) do
                                QBCore.Functions.Notify(''..v..'')
                            end
                        else
                            QBCore.Functions.Notify("You can observe nothing")
                        end
                    else
                        QBCore.Functions.Notify("You can observe nothing")
                    end
                end, playerId)
            else
                QBCore.Functions.Notify("No One Nearby", "error")
            end
        end
    end)
end)

RegisterNetEvent("police:client:PurchasePersonalVehicle", function(data)
    
    local coords
    for k,v in pairs(Config.Locations["vehicle"][currentGarage]) do
        local isSpawnPointClear = QBCore.Functions.IsSpawnPointClear(v.xyz, 1.0)
        if isSpawnPointClear then
            coords = v
            break
        end
    end
    if coords then
        QBCore.Functions.TriggerCallback("police:server:checkMoney", function(bool)
            
            if bool == true then
                QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
                    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                    SetCarItemsInfo()
                    SetEntityHeading(veh, coords.w)
                    -- exports['ps-fuel']:SetFuel(veh, 100.0)
                    
                    -- TriggerServerEvent("inventory:server:addTrunkItems", QBCore.Functions.GetPlate(veh), Config.CarItems)
                    QBCore.Functions.GetPlayerData(function(PlayerData)
                        if data.vehicle == "11cvpiw" then
                            if PlayerData.job.name == "lspd" then
                                SetVehicleLivery(veh, 0)
                            elseif PlayerData.job.name == "bcso" then
                                SetVehicleLivery(veh, 2)
                            elseif PlayerData.job.name == "sast" then
                                SetVehicleLivery(veh, 4)
                            elseif PlayerData.job.name == "hc" then
                                SetVehicleLivery(veh, 6)
                            elseif PlayerData.job.name == "marshalls" then
                                SetVehicleLivery(veh, 7)
                            elseif PlayerData.job.name == "pd_cid" then
                                SetVehicleLivery(veh, 0)
                            end
                        elseif data.vehicle == "leg18taurus" then
                            if PlayerData.job.name == "lspd" then
                                SetVehicleLivery(veh, 0)
                            elseif PlayerData.job.name == "bcso" then
                                SetVehicleLivery(veh, 2)
                            elseif PlayerData.job.name == "sast" then
                                SetVehicleLivery(veh, 4)
                            elseif PlayerData.job.name == "hc" then
                                SetVehicleLivery(veh, 6)
                            elseif PlayerData.job.name == "marshalls" then
                                SetVehicleLivery(veh, 6)
                            elseif PlayerData.job.name == "pd_cid" then
                                SetVehicleLivery(veh, 6)
                            end
                        end
                    end)
                    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                    SetVehicleEngineOn(veh, true, true)
                    local props = QBCore.Functions.GetVehicleProperties(veh)
                    TriggerServerEvent("police:server:PurchasePersonalVehicle", data, props)
                end, coords, true, true)
            else
                QBCore.Functions.Notify("You do not have enough money to purchase this vehicle", "error", 5000)
            end
        end, data.price)
    else
        QBCore.Functions.Notify("There are no free spaces to pull out this vehicle", "error", 5000)
    end
end)

RegisterNetEvent("Toggle:Duty", function(data)
    TriggerServerEvent("police:server:UpdateCurrentCops")
    TriggerServerEvent("Target:ToggleDuty", data.dutyJob)
    TriggerServerEvent("police:server:UpdateBlips")
end)

RegisterNetEvent("police:client:openevidence",function(stash)
    local drawer = lib.inputDialog('Evidence Stash',{
        { type = "number", label = 'Slot no. (1,2,3)', placeholder = "0" },
    })
    if not drawer then return end
    if type(stash) == "table" then stash = stash.args end
    QBCore.Functions.TriggerCallback('police:server:generateStash', function(id)
        if id then
            exports.ox_inventory:openInventory('stash', id)
        end
    end, stash, drawer[1])
end)

function OpenPersonalStash()
    QBCore.Functions.TriggerCallback('police:server:generatePersonalStash', function(id)
        if id then
            exports.ox_inventory:openInventory('stash', {id = id, owner = QBCore.Functions.GetPlayerData().citizenid})
        end
    end)
end

--Threads

CreateThread(function()
    while true do
        sleep = 2000
        if LocalPlayer.state.isLoggedIn and (PlayerJob.name == "marshalls" or PlayerJob.name == "lspd" or PlayerJob.name == "bcso" or PlayerJob.name == "sast" or PlayerJob.name == "hc" or PlayerJob.name == "pd_cid") then
            local pos = GetEntityCoords(PlayerPedId())

            for k, v in pairs(Config.Locations["evidence"]) do
                if #(pos - v) < 2.5 then
                    sleep = 5
                    if #(pos - v) < 2.5 then
                        lib.showTextUI('[E] - Evidence stash', {
                            position = "top-center",
                            icon = 'hand',
                            style = {
                                borderRadius = 0,
                                backgroundColor = 'black',
                                color = 'white'
                            }
                        })
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("police:client:openevidence", 1)
                        end
                    elseif #(pos - v) < 1.5 then
                        DrawText3D(v.x, v.y, v.z, "Stash 1")
                    end
                end
            end

            for k, v in pairs(Config.Locations["evidence2"]) do
                if #(pos - v) < 2 then
                    sleep = 5
                    if #(pos - v) < 1.0 then
                        lib.showTextUI('[E] - Evidence stash', {
                            position = "top-center",
                            icon = 'hand',
                            style = {
                                borderRadius = 0,
                                backgroundColor = 'black',
                                color = 'white'
                            }
                        })
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("police:client:openevidence", 2)
                        end
                    elseif #(pos - v) < 1.5 then
                        DrawText3D(v.x, v.y, v.z, "Stash 2")
                    end
                end
            end

            for k, v in pairs(Config.Locations["evidence3"]) do
                if #(pos - v) < 2 then
                    sleep = 5
                    if #(pos - v) < 1.0 then
                        lib.showTextUI('[E] - Evidence stash', {
                            position = "top-center",
                            icon = 'hand',
                            style = {
                                borderRadius = 0,
                                backgroundColor = 'black',
                                color = 'white'
                            }
                        })
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent("police:client:openevidence", 0)
                        end
                    elseif #(pos - v) < 1.5 then
                        DrawText3D(v.x, v.y, v.z, "Stash 3")
                    end
                end
            end

            for k, v in pairs(Config.Locations["stash"]) do
                if #(pos - v) < 4.5 then
                    sleep = 5
                    if #(pos - v) < 1.5 then
                        lib.showTextUI('[E] - Personal stash', {
                            position = "top-center",
                            icon = 'hand',
                            style = {
                                borderRadius = 0,
                                backgroundColor = 'black',
                                color = 'white'
                            }
                        })
                        if IsControlJustReleased(0, 38) then
                            OpenPersonalStash()
                        end
                    elseif #(pos - v) < 2.5 then
                        DrawText3D(v.x, v.y, v.z, "Personal stash")
                    end
                end
            end

            for k, v in pairs(Config.Locations["boat"]) do
                if #(pos - vector3(v.marker.x, v.marker.y, v.marker.z)) < 7.5 then
                    sleep = 5
                    DrawMarker(2, v.marker.x, v.marker.y, v.marker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(v.marker.x, v.marker.y, v.marker.z)) < 1.5 then
                        lib.showTextUI('[E] - Take out boat', {
                            position = "top-center",
                            icon = 'hand',
                            style = {
                                borderRadius = 0,
                                backgroundColor = '#48BB78',
                                color = 'white'
                            }
                        })
                        if IsControlJustReleased(0, 38) then
                            local spawn = v.spawn
                            local vehicleMenu = { }
                            local availableVehicles = Config.Boats
                            for k, v in pairs(availableVehicles) do
                                vehicleMenu[#vehicleMenu+1] = {
                                    title = v.name,
                                    event = "police:client:spawnboat",
                                    args = {
                                        vehicle = v.model,
                                        spawn = spawn
                                    }
                                }
                            end
                            lib.registerContext({
                                id = 'availablePoliceBoats',
                                title = 'Available Police Boats',
                                onExit = function() end,
                                options = vehicleMenu
                            })
                            lib.showContext('availablePoliceBoats')
                        end
                    else
                        lib.hideTextUI()
                    end
                end
                if #(pos - vector3(v.spawn.x, v.spawn.y, v.spawn.z)) < 7.5 then
                    sleep = 5
                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                        DrawMarker(2, v.spawn.x, v.spawn.y, v.spawn.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if #(pos - vector3(v.spawn.x, v.spawn.y, v.spawn.z)) < 3.0 then
                            lib.showTextUI('[E] - Store boat', {
                                position = "top-center",
                                icon = 'hand',
                                style = {
                                    borderRadius = 0,
                                    backgroundColor = 'black',
                                    color = 'white'
                                }
                            })
                            if IsControlJustReleased(0, 38) then
                                QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                SetEntityCoords(PlayerPedId(), v.marker.xyz)
                            end
                        else
                            lib.hideTextUI()
                        end
                    end
                end
            end

            for k, v in pairs(Config.Locations["fingerprint"]) do
                if #(pos - v) < 4.5 then
                    sleep = 5
                    if #(pos - v) < 1.5 then
                        lib.showTextUI('[E] - Scan fingerprint', {
                            position = "top-center",
                            icon = 'hand',
                            style = {
                                borderRadius = 0,
                                backgroundColor = 'black',
                                color = 'white'
                            }
                        })
                        if IsControlJustReleased(0, 38) then
                            local player, distance = GetClosestPlayer()
                            if player ~= -1 and distance < 2.5 then
                                local playerId = GetPlayerServerId(player)
                                TriggerServerEvent("police:server:showFingerprint", playerId)
                            else
                                QBCore.Functions.Notify("No one nearby!", "error")
                            end
                        end
                    elseif #(pos - v) < 2.5 then
                        DrawText3D(v.x, v.y, v.z, "Finger scan")
                    end
                end
            end
        end
        Wait(sleep)
        lib.hideTextUI()
    end
end)

AddEventHandler("police:client:spawnboat", function(data)
    local coords = vector4(data.spawn.x, data.spawn.y, data.spawn.z, data.spawn.w)
    QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
        SetVehicleLivery(veh , 0)
        SetVehicleMod(veh, 0, 48)
        SetVehicleNumberPlateText(veh, "BOAT"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords.xyz, true)
end)


RegisterNetEvent("police:client:OpenTrash", function()
    exports.ox_inventory:openInventory('stash', {id = 'policetrash', owner = QBCore.Functions.GetPlayerData().citizenid})
    Wait(250)
    while LocalPlayer.state.invOpen do
        Wait(250)
    end
    TriggerServerEvent('police:server:CleanTrash')
end)

RegisterNetEvent("police:client:openImpound")
AddEventHandler("police:client:openImpound", function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job
    if LocalPlayer.state.isLoggedIn and (PlayerJob.name == "marshalls" or PlayerJob.name == "lspd" or PlayerJob.name == "bcso" or PlayerJob.name == "sast" or PlayerJob.name == "hc" or PlayerJob.name == "pd_cid") then
        local coords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Config.Locations["impound"]) do
            if #(vector3(v.x, v.y, v.z) - coords) < 50.0 then
                currentGarage = k
            end
        end
        MenuImpound()
    end
end)

RegisterNetEvent("police:client:openArmory")
AddEventHandler("police:client:openArmory", function()
    exports.ox_inventory:openInventory('shop', { type = 'PoliceArmory' })
end)

RegisterNetEvent("police:client:openGarage")
AddEventHandler("police:client:openGarage", function(data)
    currentGarage = nil
    local coords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(Config.Locations["vehicle"]) do
        for k2,v2 in pairs(v) do
            
            if #(vector3(v2.x, v2.y, v2.z) - coords) < 50.0 then
                currentGarage = k
            end
        end
    end
    if currentGarage then
        MenuGarage()
    end
end)

RegisterNetEvent("police:client:openVehiclePersonalPurchase")
AddEventHandler("police:client:openVehiclePersonalPurchase", function(data)
    currentGarage = data.garage
    MenuVehiclePersonalPurchase()
end)

RegisterNetEvent("police:client:openVehiclePoolPurchase")
AddEventHandler("police:client:openVehiclePoolPurchase", function(data)
    currentGarage = data.garage
    MenuVehiclePoolPurchase()
end)

RegisterNetEvent("police:client:storeVehicle")
AddEventHandler("police:client:storeVehicle", function(data)
    currentGarage = data.garage
    StoreVehicle()
end)

RegisterNetEvent("police:client:SpawnHelicopter")
AddEventHandler("police:client:SpawnHelicopter", function(data)
    local vehicleMenu = { }
    local availableVehicles = Config.Helicopters
    local spawn = data.args.coords
    for k, v in pairs(availableVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            title = v.name,
            event = "police:client:spawnselectedhelicopter",
            args = {
                vehicle = v.model,
                spawn = spawn
            }
        }
    end
    lib.registerContext({
        id = 'availablePoliceHelicopters',
        title = 'Available Police Helicopters',
        options = vehicleMenu
    })
    lib.showContext('availablePoliceHelicopters')
end)

RegisterNetEvent("police:client:spawnselectedhelicopter")
AddEventHandler("police:client:spawnselectedhelicopter", function(data)
    local ped = PlayerPedId()
    local coords = vector4(data.spawn.x, data.spawn.y, data.spawn.z, data.spawn.w)
    QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
        SetVehicleLivery(veh , 0)
        SetVehicleMod(veh, 0, 48)
        SetVehicleExtra(veh, 1, 0)
        SetVehicleExtra(veh, 2, 0)
        SetVehicleExtra(veh, 4, 0)
        SetVehicleExtra(veh, 5, 1)
        SetVehicleExtra(veh, 7, 0)
        SetVehicleExtra(veh, 10, 0)
        SetVehicleExtra(veh, 11, 0)
        SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(ped, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords.xyz, true)
end)

RegisterNetEvent("police:client:deleteHelicopter")
AddEventHandler("police:client:deleteHelicopter", function()
    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), true))
end)

function PDCarLoop(veh)
    local veh = GetVehiclePedIsIn(PlayerPedId())
    while isDriving do
        local state = GetVehicleWheelieState(veh)
        if (IsControlPressed(0, 76) and IsControlPressed(0, 71)) then -- space + w
            if state == 129 then
                SetVehicleEngineTorqueMultiplier(veh, 2.5)
              end
            SetVehicleWheelieState(veh, 129)
        end
        Wait(0)
    end
end


RegisterNetEvent('QBCore:drivingVehicle', function(driver, currentVehicle)
    isDriving = driver
    if GetVehicleClass(currentVehicle) == 18 and isDriving then
        Wait(500)
        isDriving = true
        PDCarLoop(currentVehicle) 
    end
end)