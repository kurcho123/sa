local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = nil
local JobsDone = 0
local NpcOn = false
local CurrentLocation = {}
local CurrentBlip = nil
local LastVehicle = 0
local VehicleSpawned = false
local selectedVeh = nil

-- Functions --

local function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, cache.ped, 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

local function getRandomVehicleLocation()
    local randomVehicle = math.random(1, #Config.Locations["towspots"])
    while (randomVehicle == LastVehicle) do
        Wait(10)
        randomVehicle = math.random(1, #Config.Locations["towspots"])
    end
    return randomVehicle
end

local function isTowVehicle(vehicle)
    local retval = false
    for k, v in pairs(Config.Vehicles) do
        if joaat(vehicle) == joaat(k) then
            retval = true
        end
    end
    return retval
end

local function doCarDamage(currentVehicle)
	smash = false
	damageOutside = false
	damageOutside2 = false
	local engine = 199.0
	local body = 149.0
	if engine < 200.0 then
		engine = 200.0
    end

    if engine  > 1000.0 then
        engine = 950.0
    end

	if body < 150.0 then
		body = 150.0
	end
	if body < 950.0 then
		smash = true
	end

	if body < 920.0 then
		damageOutside = true
	end

	if body < 920.0 then
		damageOutside2 = true
	end

    Wait(100)
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

-- Menus

function MenuGarage(location)
    local menu = {
        {
            title = "Vehicles",
            disabled = true,
            icon = "truck-pickup"
        }
    }

    for veh, label in pairs(Config.Vehicles["vehicles"]) do
        menu[#menu+1] = {
            title = label,
            event = "qb-tow:client:SpawnVehicle",
            args = {
                vehicle = veh,
                location = location
            },
        }
    end

    menu[#menu+1] = {
        title = "Trailers",
        disabled = true,
        icon = "trailer"
    }

    for veh, label in pairs(Config.Vehicles["trailers"]) do
        menu[#menu+1] = {
            title = label,
            event = "qb-tow:client:SpawnVehicle",
            args = {
                vehicle = veh,
                location = location
            },
        }
    end
    lib.registerContext({
        id = 'towvehicles',
        title = 'Tow vehicles',
        onExit = function() end,
        options = menu
    })
    lib.showContext('towvehicles')
end

-- Events

RegisterNetEvent('qb-tow:client:repairVehicle', function(data)
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.onduty then
        local vehicle = data[1].entity
        local engineCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
        TaskGoStraightToCoord(cache.ped, engineCoords, 1.0, 4000, GetEntityHeading(vehicle) - 180, 0.0)
        Wait(4000)
        SetVehicleDoorOpen(vehicle, 4)
        TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
        QBCore.Functions.Progressbar("tow_repair", "Repairing Vehicle Engine", math.random(4000, 6000), false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            SetVehicleDoorShut(vehicle, 4)
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehicleEngineOn(vehicle, true, false, false)
            QBCore.Functions.Notify("Successsfully repaired the vehicles engine", "success")
            TriggerServerEvent("VehicleDeformation:fix_sv", NetworkGetNetworkIdFromEntity(vehicle))
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent("prdx_bossmenu:towRepair")
        end, function()
            QBCore.Functions.Notify("Failed to repair the vehicles engine", "error")
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    else
        QBCore.Functions.Notify("You must be on duty to do this.", "error")
    end
end)

RegisterNetEvent('qb-tow:client:impoundVehicle', function(data)
    local Player = QBCore.Functions.GetPlayerData()
    local vehicle = data[1].entity
    QBCore.Functions.DeleteVehicle(vehicle)
    QBCore.Functions.Notify("Successfully impounded the vehicle.", "success", 5000)
    TriggerServerEvent("prdx_bossmenu:towImpound")
end)

RegisterNetEvent('qb-tow:client:lockpickVehicle', function(data)
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.onduty then
        local vehicle = (data[1] and data[1].entity) or QBCore.Functions.GetClosestVehicle(GetEntityCoords(cache.ped))
        local driverDoorCoords = GetWorldPositionOfEntityBone(vehicle, 3)
        TaskGoStraightToCoord(cache.ped, driverDoorCoords, 1.0, 2000, GetEntityHeading(vehicle) - 90, 0.0)
        Wait(2000)
        TriggerEvent('animations:client:EmoteCommandStart', {"weld"})
        QBCore.Functions.Progressbar("tow_lockpick", "Unlocking Vehicle", math.random(4000, 6000), false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            SetVehicleDoorsLocked(vehicle, 1)
            TriggerServerEvent('vehiclekeys:server:SetVehicleOwner', QBCore.Functions.GetPlate(vehicle))
            QBCore.Functions.Notify("Successfully unlocked the vehicle.", "success", 5000)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end, function()
            QBCore.Functions.Notify("Failed to unlock the vehicles door", "error")
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    else
        QBCore.Functions.Notify("You must be on duty to do this.", "error")
    end
end)

RegisterNetEvent('qb-tow:client:storeVehicle', function()
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.onduty then
        local playerVeh = GetVehiclePedIsIn(cache.ped, true)
        if playerVeh ~= 0 and #(GetEntityCoords(cache.ped) - GetEntityCoords(playerVeh)) < 10.0 then
            QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(cache.ped, true))
            QBCore.Functions.Notify("Successfully stored the vehicle.", "success", 5000)
        else
            local closestVeh, closestDistance = QBCore.Functions.GetClosestVehicle(GetEntityCoords(cache.ped))
            if Config.Vehicles["trailers"][joaat(closestVeh)] and closestDistance < 15.0 then
                QBCore.Functions.DeleteVehicle(closestVeh)
                QBCore.Functions.Notify("Successfully stored the vehicle.", "success", 5000)
            else
                QBCore.Functions.Notify("No vehicle to store. Try moving it closer if you're having trouble.", "error")
            end
        end
    else
        QBCore.Functions.Notify("You must be on duty to do this.", "error")
    end
end)

RegisterNetEvent('qb-tow:client:openGarage', function(data)
    local location = data.location
    MenuGarage(location)
end)

RegisterNetEvent('qb-tow:client:openShop', function(data)
    exports.ox_inventory:openInventory('shop', { type = 'TowShop' })
end)

RegisterNetEvent('qb-tow:client:SpawnVehicle', function(data)
    local location = data.location
    local vehicleInfo = data.vehicle
    local coords = Config.Locations["vehicle"][location].coords
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "DOT "..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        SetEntityAsMissionEntity(veh, true, true)
        TaskWarpPedIntoVehicle(cache.ped, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        if vehicleInfo == "t680" then 
            SetVehicleExtra(veh, 1, 1)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0) 
            SetVehicleExtra(veh, 4, 0)
            SetVehicleExtra(veh, 5, 1) 
            SetVehicleExtra(veh, 6, 0) 
            SetVehicleExtra(veh, 7, 0) 
            SetVehicleExtra(veh, 8, 1)
            SetVehicleExtra(veh, 9, 0) 
            SetVehicleExtra(veh, 10, 0) 
            SetVehicleExtra(veh, 11, 0)
        elseif vehicleInfo == "hvywrecker" then
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0) 
            SetVehicleExtra(veh, 4, 1)
            SetVehicleExtra(veh, 5, 0) 
            SetVehicleExtra(veh, 6, 1) 
            SetVehicleExtra(veh, 7, 0) 
            SetVehicleExtra(veh, 8, 1)
            SetVehicleExtra(veh, 9, 1) 
            SetVehicleExtra(veh, 10, 0) 
            SetVehicleExtra(veh, 11, 1)
        elseif vehicleInfo == "tow" then
            SetVehicleExtra(veh, 1, 0)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 1) 
            SetVehicleExtra(veh, 4, 1)
            SetVehicleExtra(veh, 5, 1) 
            SetVehicleExtra(veh, 6, 1) 
            SetVehicleExtra(veh, 7, 1) 
            SetVehicleExtra(veh, 8, 1)
            SetVehicleExtra(veh, 9, 0) 
            SetVehicleExtra(veh, 10, 0) 
            SetVehicleExtra(veh, 11, 0)
            SetVehicleExtra(veh, 12, 0)
        elseif vehicleInfo == "20ramdot" then
            SetVehicleExtra(veh, 1, 1)
            SetVehicleExtra(veh, 2, 0)
            SetVehicleExtra(veh, 3, 0)
            SetVehicleExtra(veh, 4, 1)
            SetVehicleExtra(veh, 5, 1) 
            SetVehicleExtra(veh, 6, 0) 
            SetVehicleExtra(veh, 7, 0) 
            SetVehicleExtra(veh, 8, 0)
            SetVehicleExtra(veh, 9, 0) 
            SetVehicleExtra(veh, 10, 1) 
            SetVehicleExtra(veh, 11, 1)
            SetVehicleExtra(veh, 12, 1)
        else
            for i = 1, 9, 1 do
                SetVehicleExtra(veh, i, 0)
            end
        end
        QBCore.Functions.SetStateBag(veh, 'powerDecrease', 0)
    end, coords, true)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

CreateThread(function()
    for k,v in pairs(Config.Locations["map"]) do
        local TowBlip = AddBlipForCoord(v.coords)
        SetBlipSprite(TowBlip, 643)
        SetBlipDisplay(TowBlip, 4)
        SetBlipScale(TowBlip, 0.5)
        SetBlipAsShortRange(TowBlip, true)
        SetBlipColour(TowBlip, 47)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(v.label)
        EndTextCommandSetBlipName(TowBlip)
    end
end)

RegisterNetEvent('tow:vehicleInteractions')
AddEventHandler('tow:vehicleInteractions', function(data)
    lib.registerContext({
        id = 'MenuInteractionOptionsTowCar',
        title = 'Tow Vehicle Interactions',
        onExit = function() end,
        options = {
            {
                title = 'Repair Vehicle',
                event = 'qb-tow:client:repairVehicle',
                args = {data},
            },{
                title = 'Impound Vehicle',
                event = 'qb-tow:client:impoundVehicle',
                args = {data},
            },{
                title = 'Unlock Doors',
                event = 'qb-tow:client:lockpickVehicle',
                args = {data},
            },
            
        }
    })
    lib.showContext('MenuInteractionOptionsTowCar')
end)