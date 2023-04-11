local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local PlayerGang = {}
local PlayerJob = {}
local CurrentHouseGarage = nil
local OutsideVehicles = {}
local CurrentGarage = nil
local GaragePoly = {}
local MenuItemId = nil
local VehicleClassMap = {}

-- helper functionw

local function TableContains (tab, val)
    if type(val) == "table" then -- checks if atleast one the values in val is contained in tab 
        for _, value in ipairs(tab) do
            if TableContains(val, value) then
                return true
            end
        end
        return false
    else
        for _, value in ipairs(tab) do
            if value == val then
                return true
            end
        end
    end
    return false
end

local function IsStringNilOrEmpty(s)
    return s == nil or s == ''
end

local function GetSuperCategoryFromCategories(categories)
    local superCategory = 'car'
    if TableContains(categories, {'car'}) then
        superCategory = 'car'
    elseif TableContains(categories, {'plane', 'helicopter'}) then
        superCategory = 'air'
    elseif TableContains(categories, 'boat') then
        superCategory = 'sea'
    end
    return superCategory
end

local function GetClosestLocation(locations)
    local closestDistance = -1
    local closestIndex = -1
    local closestLocation = nil
    for i,v in ipairs(locations) do
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local location = vector3(v.x, v.y, v.z)
        local distance = #(plyCoords - location)
        if(closestDistance == -1 or closestDistance > distance) then
            closestDistance = distance
            closestIndex = i
            closestLocation = v
        end
    end
    return closestIndex, closestDistance, closestLocation
end

local function GetOpenLocation(locations)
    local closestDistance = -1
    local closestIndex = -1
    local closestLocation = nil
    for i,v in ipairs(locations) do
        local veh, distance = QBCore.Functions.GetClosestVehicle(vector3(v.x,v.y, v.z))
        if veh == -1 or distance >= 1.5 then
            return i, distance, v
        end
    end
end

--Menus
local function PublicGarage()
    local garage = Garages[CurrentGarage]
    local type = garage.type
    local categories = garage.vehicleCategories
    local superCategory = GetSuperCategoryFromCategories(categories)

    lib.registerContext({
		id = 'PublicGarage',
		title = garage.label,
		onExit = function() end,
		options = {
            {
                title = Lang:t("menu.text.vehicles"),
                description = Lang:t("menu.text.vehicles"),
                event = "qb-garages:client:GarageMenu",
                args = {
                    garageId = CurrentGarage,
                    garage = garage,
                    categories = categories,
                    header =  Lang:t("menu.header."..garage.type.."_"..superCategory, {value = garage.label}),
                    superCategory = superCategory,
                    type = type
                }
            }
        }
	})
	lib.showContext('PublicGarage')
end

local function MenuHouseGarage()
    local superCategory = GetSuperCategoryFromCategories(HouseGarageCategories)
    lib.registerContext({
		id = 'menuHouseGarage',
		title = Lang:t("menu.header.house_garage"),
		onExit = function() end,
		options = {
            {
                title = Lang:t("menu.text.vehicles"),
                description = Lang:t("menu.text.vehicles"),
                event = "qb-garages:client:GarageMenu",
                args = {
                    garageId = CurrentHouseGarage,
                    categories = HouseGarageCategories,
                    header =  HouseGarages[CurrentHouseGarage].label,
                    garage = HouseGarages[CurrentHouseGarage],
                    superCategory = superCategory,
                    type = 'house'
                }
            }
        }
	})
	lib.showContext('menuHouseGarage')
end

-- Functions

local function DoCarDamage(currentVehicle, veh)
	local engine = veh.engine + 0.0
	local body = veh.body + 0.0
    if veh.engine <= 0 then
        veh.engine = 1000.0
    end
    if veh.body <= 0 then
        veh.body = 1000.0
    end

    Wait(100)
    if body < 900.0 then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
		SmashVehicleWindow(currentVehicle, 5)
		SmashVehicleWindow(currentVehicle, 6)
		SmashVehicleWindow(currentVehicle, 7)
	end
	if body < 800.0 then
		SetVehicleDoorBroken(currentVehicle, 0, true)
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 2, true)
		SetVehicleDoorBroken(currentVehicle, 3, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
		SetVehicleDoorBroken(currentVehicle, 5, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
	end
	if engine < 700.0 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end
	if engine < 500.0 then
		SetVehicleTyreBurst(currentVehicle, 0, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 5, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 6, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 7, false, 990.0)
	end
    SetVehicleEngineHealth(currentVehicle, engine)
    SetVehicleBodyHealth(currentVehicle, body)

end

local function Round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function ExitAndDeleteVehicle(vehicle)
    local garage = Garages[CurrentGarage]
    local exitLocation = nil
    if garage and garage.ExitWarpLocations and next(garage.ExitWarpLocations) then
        _, _, exitLocation = GetClosestLocation(garage.ExitWarpLocations)
    end
    for i = -1, 5, 1 do
        local ped = GetPedInVehicleSeat(vehicle, i)
        if ped then
            TaskLeaveVehicle(ped, vehicle, 0)
            if exitLocation then
                SetEntityCoords(ped, exitLocation.x, exitLocation.y, exitLocation.z)
            end
        end
    end
    SetVehicleDoorsLocked(vehicle)
    Wait(1500)
    QBCore.Functions.DeleteVehicle(vehicle)
end

local function GetVehicleCategoryFromClass(class)
    return VehicleClassMap[class]
end

local function CanParkVehicle(veh)
    local garage = CurrentGarage and Garages[CurrentGarage] or HouseGarages[CurrentHouseGarage]
    if not garage then return end
    local parkingDistance =  garage.ParkingDistance and garage.ParkingDistance or ParkingDistance
    local vehClass = GetVehicleClass(veh)
    local vehCategory = GetVehicleCategoryFromClass(vehClass)

    if CurrentGarage and not TableContains(Garages[CurrentGarage].vehicleCategories, vehCategory) then
        QBCore.Functions.Notify(Lang:t("error.not_correct_type"), "error", 4500)
        return false
    end

    local parkingSpots = garage.ParkingSpots and garage.ParkingSpots or {}
    if next(parkingSpots) ~= nil then
        local _, closestDistance, _ = GetClosestLocation(parkingSpots)
        if closestDistance >= parkingDistance then
            QBCore.Functions.Notify(Lang:t("error.too_far_away"), "error", 4500)
            return false
        else
            return true
        end
    else
        return true
    end
end

local function ParkVehicle(veh)
    local plate = QBCore.Functions.GetPlate(veh)
    local garage = CurrentGarage and CurrentGarage or CurrentHouseGarage
    local type = CurrentGarage and Garages[garage].type or 'house'
    local gang = PlayerGang.name;
    QBCore.Functions.TriggerCallback('qb-garage:server:checkOwnership', function(owned)
        if owned then
            local bodyDamage = math.ceil(GetVehicleBodyHealth(veh))
            local engineDamage = math.ceil(GetVehicleEngineHealth(veh))
            local mods = QBCore.Functions.GetVehicleProperties(veh)
            local totalFuel = 0

            if FuelScript then
                totalFuel = exports[FuelScript]:GetFuel(veh)
            else
                totalFuel = exports['LegacyFuel']:GetFuel(veh) -- Don't change this. Change it in the config. Defaults to legacy fuel if not set in the config
            end

            if not CanParkVehicle(veh) then return end
            TriggerServerEvent('qb-garage:server:updateVehicle', 1, totalFuel, engineDamage, bodyDamage, plate, garage, mods)
            ExitAndDeleteVehicle(veh)
            QBCore.Functions.Notify(Lang:t("success.vehicle_parked"), "success", 4500)
        else
            QBCore.Functions.Notify(Lang:t("error.not_owned"), "error", 3500)
        end
    end, plate, type, garage, gang)
end

local function AddRadialParkingOption()
    local Player = PlayerPedId()
    if IsPedInAnyVehicle(Player) then
        lib.addRadialItem({
            {
              id = 'park_vehicle',
              label = 'Park Vehicle',
              icon = 'square-parking',
              onSelect = function()
                TriggerEvent('qb-garages:client:ParkVehicle')
              end
            }
        })
    else
        lib.addRadialItem({
            {
              id = 'open_garage_menu',
              label = 'Open Garage',
              icon = 'warehouse',
              onSelect = function()
                TriggerEvent('qb-garages:client:OpenMenu')
              end
            }
        })
    end
end

local function AddRadialImpoundOption()
    lib.addRadialItem({
        {
          id = 'open_impound_menu',
          label = 'Open Impound Lot',
          icon = 'warehouse',
          onSelect = function()
            TriggerEvent('qb-garages:client:OpenMenu')
          end
        }
    })
end

local function UpdateRadialMenu()
    local garage = Garages[CurrentGarage]

    if CurrentGarage ~= nil and garage ~= nil then
        lib.removeRadialItem('park_vehicle')
        lib.removeRadialItem('open_garage_menu')
        if garage.type == 'job' and not IsStringNilOrEmpty(garage.job) then
            if PlayerJob.name == "lspd" or PlayerJob.name == "bcso" or PlayerJob.name == "sast" or PlayerJob.name == "marshalls" or PlayerJob.name == "hc" or PlayerJob.name == "pd_cid" then
                if garage.job == "police" then 
                    AddRadialParkingOption()
                end
            elseif PlayerJob.name == 'tow' or PlayerJob.name == 'bikinitow' then
                if garage.job == "tow" then 
                    AddRadialParkingOption()
                end
            elseif PlayerJob.name == garage.job then
                AddRadialParkingOption()
            end
        elseif garage.type == 'gang' and not IsStringNilOrEmpty(garage.gang) then
            if PlayerGang.name == garage.gang then
                AddRadialParkingOption()
            end
        elseif garage.type == 'depot' then
            --AddRadialImpoundOption()
        else
           AddRadialParkingOption()
        end
    elseif CurrentHouseGarage ~= nil then
       AddRadialParkingOption()
    end
end

local function CreateGarageZone(zone, garageName)
    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            CurrentGarage = garageName
            exports['qb-core']:DrawText(Garages[CurrentGarage]['drawText'], DrawTextPosition)
            UpdateRadialMenu()
        else
            CurrentGarage = nil
            lib.removeRadialItem('park_vehicle')
            lib.removeRadialItem('open_garage_menu')
            exports['qb-core']:HideText()
        end
    end)
end

lib.onCache('vehicle', function(value)
    if CurrentGarage then
        UpdateRadialMenu()
    end
end)

local function CreateGaragePolyZone(garage)
    local zone = PolyZone:Create(Garages[garage].Zone.Shape, {
        name = garage,
        minZ = Garages[garage].Zone.minZ,
        maxZ = Garages[garage].Zone.maxZ,
        debugPoly = Garages[garage].debug
    })
   CreateGarageZone(zone, garage)
end

local function CreateGarageBoxZone(house, coords, debugPoly)
    local pos = vector3(coords.x, coords.y, coords.z)
    return BoxZone:Create(pos,5,3.5, {
        name = house,
        offset = {0.0, 0.0, 0.0},
        debugPoly = debugPoly,
        heading = coords.h,
        minZ = pos.z - 1.0,
        maxZ = pos.z + 1.0,
    })
end

local function RegisterHousePoly(house)
    if GaragePoly[house] then return end
    local coords = HouseGarages[house].takeVehicle
    if not coords or not coords.x then return end
    local zone = CreateGarageBoxZone(house, coords, false)
    GaragePoly[house] = {
        Polyzone = zone,
        coords = coords,
    }
    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            CurrentHouseGarage = house
            exports['qb-core']:DrawText(HouseParkingDrawText, DrawTextPosition)
            UpdateRadialMenu()
        else
            exports['qb-core']:HideText()
            lib.removeRadialItem('park_vehicle')
            lib.removeRadialItem('open_garage_menu')
            CurrentHouseGarage = nil
        end
    end)
end

-- Events

RegisterNetEvent("qb-garages:client:GarageMenu", function(data)
    local type = data.type
    local garageId = data.garageId
    local garage = data.garage
    local categories = data.categories and data.categories or {'car'}
    local header = data.header
    local superCategory = data.superCategory
    local leave

    leave = Lang:t("menu.leave."..superCategory)
    QBCore.Functions.TriggerCallback("qb-garage:server:GetGarageVehicles", function(result)
        if result == nil then
            QBCore.Functions.Notify(Lang:t("error.no_vehicles"), "error", 5000)
        else
            local MenuGarageOptions = { }
            result = result and result or {}
            for k, v in pairs(result) do
                local enginePercent = Round(v.engine / 10, 0)
                local bodyPercent = Round(v.body / 10, 0)
                local currentFuel = v.fuel
                local vname = v.vehicle

                if QBCore.Shared.Vehicles[v.vehicle] then
                    vname = QBCore.Shared.Vehicles[v.vehicle].name
                end

                if v.state == 0 then
                    v.state = Lang:t("status.out")
                elseif v.state == 1 then
                    v.state = Lang:t("status.garaged")
                end

                if v.state ~= 2 then 
                    if type == "depot" then
                        if findVehFromPlate(v.plate) ~= true then
                            MenuGarageOptions[#MenuGarageOptions+1] = {
                                title = Lang:t('menu.header.depot', {value = vname, value2 = math.ceil(v.impoundprice)}),
                                description = Lang:t('menu.text.depot', {value = v.plate, value2 = currentFuel, value3 = enginePercent, value4 = bodyPercent}),
                                event = "qb-garages:client:TakeOutDepot",
                                args = {
                                    vehicle = v,
                                    type = type,
                                    garage = garage,
                                }
                            }
                        end
                    else
                        MenuGarageOptions[#MenuGarageOptions+1] = {
                            title = Lang:t('menu.header.garage', {value = vname, value2 = v.plate}),
                            description = Lang:t('menu.text.garage', {value = v.state, value2 = currentFuel, value3 = enginePercent, value4 = bodyPercent}),
                            event = "qb-garages:client:TakeOutGarage",
                            args = {
                                vehicle = v,
                                type = type,
                                garage = garage,
                                superCategory = superCategory,
                            }
                        }
                    end
                end
            end

            lib.registerContext({
                id = 'GarageMenu',
                title = header,
                onExit = function() end,
                options = MenuGarageOptions
            })
            lib.showContext('GarageMenu')
        end
    end, garageId, type, superCategory)
end)

RegisterNetEvent('qb-garages:client:TakeOutGarage', function(data, cb)
    local type = data.type
    local vehicle = data.vehicle
    local garage = data.garage
    local superCategory = data.superCategory
    local spawnDistance = garage.SpawnDistance and garage.SpawnDistance or SpawnDistance
    local location
    local heading
    local closestDistance = -1

    if type == "house" then
        location = garage.takeVehicle
        heading = garage.takeVehicle.h -- yes its 'h' not 'w'...
    else
        local parkingSpots = garage.ParkingSpots and garage.ParkingSpots or {}
        if next(parkingSpots) ~= nil then
            if garage.type ~= 'depot' then
                _, closestDistance, location = GetClosestLocation(parkingSpots)
                if closestDistance >= spawnDistance then
                    QBCore.Functions.Notify(Lang:t("error.too_far_away"), "error", 4500)
                    return
                else
                    heading = location.w
                end
                
            else
                _, closestDistance, location = GetOpenLocation(parkingSpots)
                heading = location.w
            end
        else
            local ped = GetEntityCoords(PlayerPedId())
            local pedheadin = GetEntityHeading(PlayerPedId())
            local forward = GetEntityForwardVector(PlayerPedId())
            local x, y, z = table.unpack(ped + forward * 3)
            location = vector3(x, y, z)
            if VehicleHeading == 'forward' then
                heading = pedheadin
            elseif VehicleHeading == 'driverside' then
                heading = pedheadin + 90
            elseif VehicleHeading == 'hood' then
                heading = pedheadin + 180
            elseif VehicleHeading == 'passengerside' then
                heading = pedheadin + 270
            end
        end
    end

    local veh, distance = QBCore.Functions.GetClosestVehicle(vector3(location.x,location.y, location.z))
    if veh ~= -1 and distance <= 1.5 then
        QBCore.Functions.Notify(Lang:t("error.occupied"), "error", 4500)
        do return end
    end

    QBCore.Functions.SpawnVehicle(vehicle.vehicle, function(veh)
        QBCore.Functions.TriggerCallback('qb-garage:server:GetVehicleProperties', function(properties)
            QBCore.Functions.SetVehicleProperties(veh, properties)
            SetVehicleNumberPlateText(veh, vehicle.plate)
            SetEntityHeading(veh, heading)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)

            if FuelScript then
                exports[FuelScript]:SetFuel(veh, vehicle.fuel)
            else
                exports['LegacyFuel']:SetFuel(veh, vehicle.fuel) -- Don't change this. Change it in the config. Defaults to legacy fuel if not set in the config
            end

            DoCarDamage(veh, vehicle)
            SetEntityAsMissionEntity(veh, true, true)
            TriggerServerEvent('qb-garage:server:updateVehicleState', 0, vehicle.plate, vehicle.garage)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
        end, vehicle.plate)

    end, location, true)
    if cb then cb(veh) end
end)

RegisterNetEvent('qb-garages:client:OpenMenu', function()
    if CurrentGarage then
        PublicGarage()
    elseif CurrentHouseGarage then
        TriggerEvent('qb-garages:client:OpenHouseGarage')
    end
end)

RegisterNetEvent('qb-garages:client:ParkVehicle', function()
    local ped = PlayerPedId()
    local curVeh = GetVehiclePedIsIn(ped)
    ParkVehicle(curVeh)
end)

RegisterNetEvent('qb-garages:client:TakeOutDepot', function(data)
    local vehicle = data.vehicle
    QBCore.Functions.TriggerCallback('qb-garage:server:GetOutsideVehicle', function(vehExists)
        if not vehExists then
            QBCore.Functions.TriggerCallback('qb-garage:server:PayDepotPrice', function(retval)
                if retval then
                    TriggerEvent("qb-garages:client:TakeOutGarage", data)
                end
            end, data)
        else
            QBCore.Functions.Notify(Lang:t('error.not_impound'), "error", 5000)
        end
    end, vehicle.plate)
end)

RegisterNetEvent('qb-garages:client:OpenHouseGarage', function()
    QBCore.Functions.TriggerCallback('qb-houses:server:hasKey', function(hasKey)
        if hasKey then
            MenuHouseGarage()
        else
            QBCore.Functions.Notify(Lang:t("error.no_house_keys"), "error")
        end
    end, CurrentHouseGarage)
end)

RegisterNetEvent('qb-garages:client:houseGarageConfig', function(garageConfig)
    HouseGarages = garageConfig
    for house, _ in pairs(HouseGarages) do
        RegisterHousePoly(house)
    end
end)

RegisterNetEvent('qb-garages:client:addHouseGarage', function(house, garageInfo)
    HouseGarages[house] = garageInfo
    RegisterHousePoly(house)
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    if not PlayerData then return end
    PlayerGang = PlayerData.gang
    PlayerJob = PlayerData.job
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() and QBCore.Functions.GetPlayerData() ~= {} then
        PlayerData = QBCore.Functions.GetPlayerData()
        if not PlayerData then return end
        PlayerGang = PlayerData.gang
        PlayerJob = PlayerData.job
    end
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
    PlayerGang = gang
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = job
end)

-- Threads

CreateThread(function()
    for _, garage in pairs(Garages) do
        if garage.showBlip then
            local Garage = AddBlipForCoord(garage.blipcoords.x, garage.blipcoords.y, garage.blipcoords.z)
            local blipColor = garage.blipColor ~= nil and garage.blipColor or 3
            SetBlipSprite(Garage, garage.blipNumber)
            SetBlipDisplay(Garage, 4)
            SetBlipScale(Garage, 0.4)
            SetBlipAsShortRange(Garage, true)
            SetBlipColour(Garage, blipColor)
            BeginTextCommandSetBlipName("STRING")
            if garage.type == "depot" then
                AddTextComponentSubstringPlayerName('Impound')
            else
                AddTextComponentSubstringPlayerName('Garage')
            end
            EndTextCommandSetBlipName(Garage)
        end
    end
end)

CreateThread(function()
    for garageName, garage in pairs(Garages) do
        if(garage.type == 'public' or garage.type == 'depot' or garage.type == 'job' or garage.type == 'gang' or garage.type == 'mechanic') then
            CreateGaragePolyZone(garageName)
        end
    end
end)

CreateThread(function()
    local debug = false
    for _, garage in pairs(Garages) do
        if garage.debug then
            debug = true
            break
        end
    end
    while debug do
        for _, garage in pairs(Garages) do
            local parkingSpots = garage.ParkingSpots and garage.ParkingSpots or {}
            if next(parkingSpots) ~= nil and garage.debug then
                for _, location in pairs(parkingSpots) do
                    DrawMarker(2, location.x, location.y, location.z + 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                end
            end
        end
        Wait(0)
    end
end)

CreateThread(function()
    for category, classes  in pairs(VehicleCategories) do
        for _, class  in pairs(classes) do
            VehicleClassMap[class] = category
        end
    end
end)

function findVehFromPlate(plate)
    local gameVehicles = QBCore.Functions.GetVehicles()
    for i = 1, #gameVehicles do
        local vehicle = gameVehicles[i]
        if DoesEntityExist(vehicle) then
            if QBCore.Functions.GetPlate(vehicle) == plate then
                return true
            end
        end
    end
end