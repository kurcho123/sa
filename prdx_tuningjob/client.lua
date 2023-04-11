local QBCore = exports['qb-core']:GetCoreObject()
local CurrentShop = nil
NitrousStorage = LoadResourceFile(GetCurrentResourceName(), "NitrousStorage.json")
local NitrousEntities = {}
---------------
--  Threads  --
---------------
CreateThread(function()
    Wait(5000)   
    NitrousStorage = json.decode(NitrousStorage) or {}
    for k,v in pairs(Config.NitrousStations) do 
        Config.NitrousStations[k].entity = CreateObjectNoOffset(`v_med_gastank`, v.Coords.x, v.Coords.y, v.Coords.z-0.97, false, true)
        while not DoesEntityExist(station) do Wait(0) end
        PlaceObjectOnGroundProperly(station)
        FreezeEntityPosition(station, true)
        SetEntityHeading(station, v.Coords.w-180.0)
    end
end)

---------------
-- Functions --
---------------

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function FixNitrousTanks()
    for k,v in pairs(Config.NitrousStations) do 
        if Config.NitrousStations[k].entity and DoesEntityExist(Config.NitrousStations[k].entity) then
            local station = Config.NitrousStations[k].entity
            FreezeEntityPosition(station, true)
            SetEntityCoords(station, v.Coords.x, v.Coords.y, v.Coords.z-0.97)
            SetEntityHeading(station, v.Coords.w-180.0)
        else
            Config.NitrousStations[k].entity = CreateObjectNoOffset(`v_med_gastank`, v.Coords.x, v.Coords.y, v.Coords.z-0.97, false, false, false, true)
            local station = Config.NitrousStations[k].entity
            FreezeEntityPosition(station, true)
            SetEntityCoords(station, v.Coords.x, v.Coords.y, v.Coords.z-0.97, false, false, false, true)
            SetEntityHeading(station, v.Coords.w-180.0)
        end
    end
end

------------
-- Events --
------------
RegisterNetEvent('prdx_tuningjob:client:spawnEngine', function(engineType, EngineSerial)
    local Engine = CreateObjectNoOffset(Config.EngineModelModded, -1582.19, -833.42, 8.99, true, true, false)
    QBCore.Functions.SetStateBag(Engine, 'engineData', {engine = engineType, netid = ObjToNet(Engine), serialno = EngineSerial})
end)

RegisterNetEvent('prdx_tuningjob:client:cheatTurbo', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle > 0 then
        SetVehicleModKit(vehicle, 0)
        ToggleVehicleMod(vehicle, 18, true)
        QBCore.Functions.Notify('Installed turbo', 'success') 
    else
        QBCore.Functions.Notify('No vehicle', 'error') 
    end
end)

RegisterNetEvent('prdx_tuningjob:client:installHeadlights', function(color)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle > 0 then
        SetVehicleModKit(vehicle, 0)
        ToggleVehicleMod(vehicle, 22, true) -- toggle xenon JIC
        SetVehicleXenonLightsColor(vehicle, tonumber(color))
        QBCore.Functions.Notify('Installed headlight color: '..color, 'success') 
    else
        QBCore.Functions.Notify('No vehicle', 'error') 
    end
    
end)

RegisterNetEvent('prdx_tuningjob:client:installPaint', function(paint)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle > 0 then
        SetVehicleModKit(vehicle, 0)
        SetVehicleColours(vehicle, tonumber(paint), tonumber(paint))
        QBCore.Functions.Notify('Installed chameleon paint number: '..paint, 'success') 
    else
        QBCore.Functions.Notify('No vehicle', 'error') 
    end
end)

-- Remove Engine From Car --
AddEventHandler('prdx_tuningjob:removeEngine', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local JackStand = GetClosestObjectOfType(pos.x, pos.y, pos.z, 50.0, joaat(Config.JackModel), false, false, false)
    local vehicle = data.entity
    local plate = QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
    if JackStand and JackStand ~= 0 then
        if Entity(JackStand).state.engineData then return end -- Has an engine on it
        local State = Entity(vehicle).state
        local hasEngine = Entity(vehicle).state.hasEngine
        local EngineSerial = Entity(vehicle).state.engineSerial
        local tunerData = Entity(vehicle).state.tunerData or 'stock'
        if hasEngine ~= false then
            QBCore.Functions.TriggerCallback('prdx_tuningjob:server:canRemoveEngine', function(canRemove)
                if canRemove then
                    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic2"})
                    QBCore.Functions.Progressbar("pull_engine", "Removing engine...", 7000, false, true, {
                            disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
                            QBCore.Functions.TakeControl(JackStand)
                            if tunerData and tunerData ~= 'stock' then -- Tuner engine
                                local Engine = CreateObjectNoOffset(Config.EngineModelModded, pos.x, pos.y, pos.z-50.0, true, true)
                                AttachEntityToEntity(Engine, JackStand, 0, 0.0, -1.25, 1.25, 0.0, 0.0, 0.0, 0, true, false, false, 0, true)
                                QBCore.Functions.SetStateBag(JackStand, 'engineData', {engine = tunerData, netid = NetworkGetNetworkIdFromEntity(Engine), serialno = EngineSerial})
                            else -- Stock Engine
                                local Engine = CreateObjectNoOffset(Config.EngineModelStock, pos.x, pos.y, pos.z-50.0, true, true)
                                AttachEntityToEntity(Engine, JackStand, 0, 0.0, -1.0, 1.05, 0.0, 0.0, 0.0, 0, true, false, false, 0, true)
                                QBCore.Functions.SetStateBag(JackStand, 'engineData', {engine = 'stock', netid = NetworkGetNetworkIdFromEntity(Engine), serialno = EngineSerial})
                            end
                            -- Set vehicle to having no engine --
                            SetVehicleUndriveable(vehicle, true)
                            QBCore.Functions.SetStateBag(vehicle, 'isDisabled', true)   
                            QBCore.Functions.SetStateBag(vehicle, 'hasEngine', false)   
                            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    end, function() -- Cancel
                        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    end)
                else
                    QBCore.Functions.Notify('Can not remove local engines...', 'error', 7500)
                end
            end, plate, EngineSerial, tunerData, VehToNet(vehicle))
        else
            QBCore.Functions.Notify('Vehicle does not have an engine...', 'error', 7500)
        end
    end
end)

-- Drop Engine From Jack --
AddEventHandler('prdx_tuningjob:dropEngine', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local JackStand = data.entity
    if JackStand and JackStand ~= 0 then
        local EngineData = Entity(JackStand).state.engineData
        if EngineData then 
            TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
            QBCore.Functions.Progressbar("drop_engine", "Dropping Engine...", 3000, false, true, {
                    disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
                    local EngineEntity = NetToEnt(EngineData.netid)
                    if EngineEntity and EngineEntity ~= 0 then
                        QBCore.Functions.TakeControl(JackStand)
                        DetachEntity(EngineEntity, false, true)
                        PlaceObjectOnGroundProperly(EngineEntity)
                        FreezeEntityPosition(EngineEntity, true)
                        QBCore.Functions.SetStateBag(JackStand, 'engineData', false)
                        QBCore.Functions.SetStateBag(EngineEntity, 'engineData', EngineData)
                    end   
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end)
        else
            QBCore.Functions.Notify('No engine data...', 'error', 7500)
        end
    else
        QBCore.Functions.Notify('Jackstand error...', 'error', 7500)
    end
end)

-- Pickup engine with jack --
AddEventHandler('prdx_tuningjob:pickEngine', function(data)
    local JackStand = data.entity
    local pos = GetEntityCoords(JackStand)
    local EngineModded = GetClosestObjectOfType(pos.x, pos.y, pos.z, 3.0, Config.EngineModelModded, false, false, false)
    local EngineStock = GetClosestObjectOfType(pos.x, pos.y, pos.z, 3.0, Config.EngineModelStock, false, false, false)
    local EngineData = nil
    if EngineModded and EngineModded ~= 0 then
        TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
        QBCore.Functions.Progressbar("lift_engine", "Lifting Engine..", 5000, false, true, {
                disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
                QBCore.Functions.TakeControl(EngineModded)
                FreezeEntityPosition(EngineModded, false)
                AttachEntityToEntity(EngineModded, JackStand, 0, 0.0, -1.25, 1.25, 0.0, 0.0, 0.0, 0, true, false, false, 0, true)
                EngineData = Entity(EngineModded).state.engineData
                QBCore.Functions.SetStateBag(JackStand, 'engineData', EngineData)
                QBCore.Functions.SetStateBag(EngineModded, 'engineData', false)    
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    elseif EngineStock and EngineStock ~= 0 then
        TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
        QBCore.Functions.Progressbar("lift_engine", "Lifting Engine..", 5000, false, true, {
                disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
                QBCore.Functions.TakeControl(EngineStock)
                FreezeEntityPosition(EngineStock, false)
                AttachEntityToEntity(EngineStock, JackStand, 0, 0.0, -1.0, 1.05, 0.0, 0.0, 0.0, 0, true, false, false, 0, true)
                EngineData = Entity(EngineStock).state.engineData
                QBCore.Functions.SetStateBag(JackStand, 'engineData', EngineData)
                QBCore.Functions.SetStateBag(EngineStock, 'engineData', false)    
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    else
        QBCore.Functions.Notify('No engine found', 'error', 3000)
    end
end)

-- Spawn an engine hoist --
AddEventHandler('prdx_tuningjob:getEngineHoist', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local netid = exports['prdx_props']:generateProp('tunerjack')
    local entity = NetworkGetEntityFromNetworkId(netid)
end)

-- Open the engine inventory --
AddEventHandler('prdx_tuningjob:openEngine', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local JackStand = data.entity
    local EngineData = Entity(JackStand).state.engineData
    if EngineData then
        local EngineType = EngineData.engine
        local EngineSerial = EngineData.serialno or 0
        QBCore.Functions.TriggerCallback('prdx_tuningjob:server:generateStash', function(id)
            if id then
                exports.ox_inventory:openInventory('stash', id)
            end
        end, EngineType, EngineSerial)
    end
end)

-- Install the engine, if stock we will delete the car and replace it with a new entity without tune --
AddEventHandler('prdx_tuningjob:installEngine', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local JackStand = data.entity
    local nitroData = false
    if JackStand and JackStand ~= 0 then
        local EngineData = Entity(JackStand).state.engineData
        if EngineData then 
            local EngineEntity = NetToEnt(EngineData.netid)
            local EngineSerial = EngineData.serialno
            local EngineType = EngineData.engine
            local vehicle, dist = QBCore.Functions.GetClosestVehicle(GetEntityCoords(JackStand))
            if not vehicle or dist > 5.0 then QBCore.Functions.Notify('No vehicle nearby', 'error') return end
            if EngineEntity > 0 and vehicle > 0 then
                if Entity(vehicle).state.hasEngine then
                    QBCore.Functions.Notify('Vehicle already has engine!', 'error')
                else
                    QBCore.Functions.TriggerCallback('prdx_tuningjob:server:canInstallEngine', function(canInstall, nitrousLevel, hasTurbo)
                        if canInstall then
                            print('Install Engine: ', canInstall, nitrousLevel, hasTurbo)
                            TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
                            QBCore.Functions.Progressbar("lift_engine", "Installing engine..", 25000, false, true, {
                                    disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
                                    QBCore.Functions.SetStateBag(JackStand, 'engineData', false)
                                    DetachEntity(EngineEntity, false, false)
                                    Wait(1)
                                    QBCore.Functions.SetStateBag(vehicle, 'hasEngine', true)
                                    Wait(1)
                                    QBCore.Functions.DeleteEntity(EngineEntity)
                                    QBCore.Functions.SetStateBag(vehicle, 'isDisabled', false)   
                                    if EngineType then
                                        if nitrousLevel then
                                            nitroData = {
                                                level = nitrousLevel,
                                                fuel = 0
                                            }
                                        end
                                        TriggerServerEvent('prdx_vehiclecontroller:server:TuningSet', NetworkGetNetworkIdFromEntity(vehicle), EngineType, EngineSerial, nitroData)
                                        if EngineType == 'stock' then
                                            Wait(150)
                                            TriggerEvent('QBCore:Client:ResetTunerData', vehicle)
                                        end
                                    end
                                    TriggerServerEvent('prdx_tuningjob:server:turboInstall', VehToNet(vehicle), hasTurbo)
                                    QBCore.Functions.Notify('Engine installed', 'success', 7500)    
                                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                            end, function() -- Cancel
                                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                            end)
                        else
                            QBCore.Functions.Notify('Engine unable to be built and installed', 'error', 7500)
                        end
                    end, 'Engine_'..EngineType..'_'..EngineSerial, EngineType)
                end
            else
                QBCore.Functions.Notify('No engine entity data saved...', 'error', 7500)
            end
        else
            QBCore.Functions.Notify('No engine data...', 'error', 7500)
        end
    else
        QBCore.Functions.Notify('Jackstand error...', 'error', 7500)
    end
end)

RegisterNetEvent('prdx_tuningjob:client:turboInstall', function(netid, hasTurbo)
    local vehicle = NetToVeh(netid)
    if vehicle > 0 then
        if hasTurbo then
            SetVehicleModKit(vehicle, 0)
            ToggleVehicleMod(vehicle, 18, true)
        else
            SetVehicleModKit(vehicle, 0)
            ToggleVehicleMod(vehicle, 18, false)
        end
        local mods = QBCore.Functions.GetVehicleProperties(vehicle)
        TriggerServerEvent('prdx_vehiclecontroller:server:saveProps', mods)
    end
end)

RegisterNetEvent('prdx_tuningjob:client:getLicenseplate',function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicle, dist = QBCore.Functions.GetClosestVehicle(pos)
    if not vehicle or dist > 5.0 then QBCore.Functions.Notify('No vehicle nearby', 'error') return end
    local licensePlate = QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
    TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
    QBCore.Functions.Progressbar("copy_licenseplate", "Writing down license plate", 7000, false, true, {
        disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
        QBCore.Functions.Notify('License Plate copied to clipboard', 'success', 7500)
        lib.setClipboard(licensePlate)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end, function() -- Cancel
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)
end)

local vehicle_options = {
    {
        type = "client",
        event = "prdx_tuningjob:openEngine",
        icon = "fas fa-people-carry-box",
        label = "Open Engine",
        job = {["nismostuning"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},["bikinitow"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},["bikedealer"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}},
        canInteract = function(entity, distance, data)
            if not Entity(entity).state.engineData then return false end
            return true
        end,
    },
    {
        event = "prdx_tuningjob:installEngine",
        icon = "fas fa-wrench",
        label = 'Install Engine',
        job = {["nismostuning"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},["bikinitow"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},["bikedealer"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}},
        canInteract = function(entity, distance, data)
            if not Entity(entity).state.engineData then return false end
            return true
        end,
    },{
        event = "prdx_tuningjob:client:getLicenseplate",
        icon = "fas fa-clipboard",
        label = 'Write down license plate',
        job = {["nismostuning"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},["bikinitow"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},["bikedealer"] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}},
    },
    {
        event = "prdx_tuningjob:pickEngine",
        icon = "fas fa-up-long",
        label = 'Lift Engine',
        canInteract = function(entity, distance, data)
            if Entity(entity).state.engineData then return false end
            return true
        end,
    },
    {
        event = "prdx_tuningjob:dropEngine",
        icon = "fas fa-down-long",
        label = 'Drop Engine (DANGEROUS!)',
        canInteract = function(entity, distance, data)
            if not Entity(entity).state.engineData then return false end
            return true
        end,
    },
}

local pull_options = {
    {
        type = "client",
        event = "prdx_tuningjob:removeEngine",
        icon = "fas fa-people-carry-box",
        label = "Pull Engine",
    }
}

exports['ox_target']:addModel(Config.JackModel, vehicle_options)

-- ZONE DATA --
-- Disable Tuning Options --
AddEventHandler('polyzonehelper:exit', function(name)
    if LocalPlayer.state.isLoggedIn then
        if name == "NismosTuning" or name == "BikiniTow" or name == "bikedealer" then
            print('remove targets')
            exports['ox_target']:removeModel(Config.JackModel, vehicle_options)
            exports['ox_target']:removeGlobalVehicle('Pull Engine')
            CurrentShop = nil
        end  
    end
end)

-- Enable Tuner Options --
AddEventHandler('polyzonehelper:enter', function(name)
    if LocalPlayer.state.isLoggedIn then
        if name == "NismosTuning" then
            FixNitrousTanks()
            CurrentShop = 'nismostuning'
            -- Vehicle Options --
            pull_options[1].job = 'nismostuning',
            exports['qb-target']:AddGlobalVehicle({
                options = pull_options,
                distance = 2.5,
            })
        elseif name == "BikiniTow" then
            FixNitrousTanks()
            CurrentShop = 'bikinitow'
            -- Vehicle Options --
            pull_options[1].job = 'bikinitow',
            exports['qb-target']:AddGlobalVehicle({
                options = pull_options,
                distance = 2.5,
            })

        elseif name == "bikedealer" then
            FixNitrousTanks()
            CurrentShop = 'bikedealer'
            -- Vehicle Options --
            pull_options[1].job = 'bikedealer',
            exports['qb-target']:AddGlobalVehicle({
                options = pull_options,
                distance = 2.5,
            })
        end
    end
end)

-- Refill NOS --
AddEventHandler('prdx_tuningjob:openNitroRefill', function(data)
    if not CurrentShop then return end
    QBCore.Functions.TriggerCallback('prdx_tuningjob:server:GetNitroRefill', function(RefillData, NitrousLevel)
        local FillLevel = round(NitrousLevel/RefillData.Capacity, 3) * 100
        local netid = ObjToNet(data.entity)
        local menu = {
            {
                title = 'Tank fill level: '..FillLevel.."%",
                disabled = true
            },
            {
                title = 'Fill NOS Bottle', 
                serverEvent = "prdx_tuningjob:server:fillBottle",
                args = RefillData.id
            },
            {
                title = 'Purchase Station Refill ($)', 
                event = "prdx_tuningjob:refillStation",
                args = data.entity
            },
        }
        lib.registerContext({
            id = 'nitro_refill_menu',
            title = RefillData.Name.." NOS Refill",
            options = menu,
        })
        lib.showContext('nitro_refill_menu')
    end, CurrentShop)
end)

-- Refill NOS Station --
AddEventHandler('prdx_tuningjob:refillStation', function(data)
    if not CurrentShop then return end
    QBCore.Functions.TriggerCallback('prdx_tuningjob:server:GetNitroRefill', function(RefillData, NitrousLevel)
        local FillLevel = round(NitrousLevel/RefillData.Capacity, 3) * 100
        local cost = math.ceil(Config.NitrousPrice * (100 - FillLevel))
        local menu = {
            {
                title = 'Tank fill level: '..FillLevel.."%",
                disabled = true
            },
            {
                title = 'Fill Tank',
                description = 'Cost: $'..cost,
                serverEvent = "prdx_tuningjob:server:fillStation",
                args = {RefillData.id, cost}
            }
        }
        lib.registerContext({
            id = 'refill_station_menu',
            title = RefillData.Name.." Station Refill",
            menu = 'nitro_refill_menu',
            options = menu,
        })
        lib.showContext('refill_station_menu')
    end, CurrentShop)
end)

-- Repair Parts --
AddEventHandler('prdx_tuningjob:openPartRepair', function(data)
    QBCore.Functions.TriggerCallback('prdx_tuningjob:server:GetRepairParts', function(PartsList)
        local menu = {}

        for k,v in pairs(PartsList) do
            local PartData = nil
            if data.nismos then
                PartData = Config.ModdedEngineComponents[v.name] or Config.StockEngineComponents[v.name]
            else
                PartData = Config.StockEngineComponents[v.name]
            end
            if not v.metadata.durability then v.metadata.durability = 100 end -- fixes broken items
            if PartData and PartData.RepairCost and v.metadata.durability then
                if v.metadata.durability > 0 then -- if completely broken then no repairs
                    local cost = math.floor(PartData.RepairCost * ((100 - v.metadata.durability) / 10))
                    if cost == 0 then
                        v.MenuLabel = 'Quality: '..v.metadata.durability..'%' .. '  \n' .. 'Fully Repaired'
                    else
                        v.MenuLabel = 'Quality: '..v.metadata.durability..'%' .. '  \n' .. 'Cost: '..exports.ox_inventory:Items()[PartData.RepairItem]["label"]..' '..cost..'x'
                    end
                    v.Cost = cost
                    v.PartData = PartData
                    menu[#menu+1] = {
                        title = v.label, 
                        description = v.MenuLabel,
                        disabled = v.metadata.durability >= 100,
                        event = "prdx_tuningjob:repairPart",
                        args = v
                    }
                end
            end
        end

        if not next(menu) then
            menu[#menu+1] = {
                title = 'No parts to repair!', 
                disabled = true
            }
        end

        lib.registerContext({
            id = 'parts_repair_menu',
            title = "Parts Repair",
            options = menu,
        })
        lib.showContext('parts_repair_menu')
    end)
end)

-- Repair Part --
AddEventHandler('prdx_tuningjob:repairPart', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
    QBCore.Functions.Progressbar("pull_engine", "Repairing part...", 7000, false, true, {
            disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
            TriggerServerEvent("prdx_tuningjob:server:repairPart", data)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)
-- Get Engine --
AddEventHandler('prdx_tuningjob:openEnginePurchase', function(data)
    local Engines = exports["prdx_vehiclecontroller"]:GetTunerConfig()
    local menu = {}
    local types = {}
    local SellableEngines = {}

    for k,v in pairs(Engines) do
        if v.Label and v.Cost then -- is able to be sold
            if not types[v.Type] then
                types[v.Type] = true
            end
            v.Name = k
        end
    end

    for class,_ in pairs(types) do
        menu[#menu+1] = {
            title = string.upper(class), 
            description = 'View '..class..' Engines',
            event = "prdx_tuningjob:openEngineCategory",
            args = class
        }
    end
    lib.registerContext({
        id = 'engine_purchase_menu',
        title = "Custom Engine Blocks",
        options = menu,
    })
    lib.showContext('engine_purchase_menu')
end)

AddEventHandler('prdx_tuningjob:openEngineCategory', function(category)
    local Engines = exports["prdx_vehiclecontroller"]:GetTunerConfig()
    local menu = {}
    local types = {}
    for k,v in pairs(Engines) do
        if v.Label and v.Cost and v.Type == category then -- is able to be sold
            menu[#menu+1] = {
                title = v.Label, 
                description = 'Cost: '..v.Cost..' PDX',
                serverEvent = "prdx_tuningjob:server:buyEngine",
                args = {k, v}            
            }     
        end
    end
    table.sort(menu, function(a,b)
        if not a.disabled or b.disabled then 
            return a.title < b.title 
        end
    end)
    table.insert(menu, 1, {
        title = category:gsub("^%l", string.upper).." Engine Blocks",
        disabled = true
    })
    lib.registerContext({
        id = 'engine_category_menu',
        title = "Custom Engine Blocks",
        menu = 'engine_purchase_menu',
        options = menu,
    })
    lib.showContext('engine_category_menu')
end)

CreateThread(function() -- Tuning areas (Enables special options)
    exports['polyzonehelper']:AddPolyZone("NismosTuning", {
        vector2(-1571.7589111328, -839.39752197266),
        vector2(-1628.0897216797, -792.27136230469),
        vector2(-1651.9475097656, -820.80474853516),
        vector2(-1597.4672851563, -867.87707519531)
      },{
        name="NismosTuning",
        debugPoly = false
    })
    exports['polyzonehelper']:AddPolyZone("BikiniTow", {
        vector2(794.72064208984, -832.77075195313),
        vector2(856.86242675781, -832.15588378906),
        vector2(836.38983154297, -783.48840332031),
        vector2(793.74176025391, -785.02899169922)
      },{
        name="BikiniTow",
        debugPoly = false
    })
    exports['polyzonehelper']:AddPolyZone("bikedealer", {
        vector2(53.286609649658, 6452.0170898438),
        vector2(73.04956817627, 6471.8916015625),
        vector2(31.606994628906, 6513.4633789063),
        vector2(11.692188262939, 6494.013671875)
      },{
        name="bikedealer",
        debugPoly = false
    })
    -- Specific Areas --
    
    -- Bikini Tow --
    exports['qb-target']:AddBoxZone("BikiniTowRepair", vector3(836.93, -811.73, 26.35), 2.0, 1, {
        name="BikiniTowRepair",
        heading= 0,
        debugPoly= false,
        minZ = 25.55,
        maxZ = 26.55
    }, {
        options = {
            {
                type = "client",
                event = "prdx_tuningjob:openPartRepair",
                icon = "fas fa-cart-flatbed",
                label = "Repair Parts",
                job = "bikinitow",
            },
        },
    })
    exports['qb-target']:AddBoxZone("BikiniEquipment", vector3(826.82, -809.38, 26.33), 1.0, 2.0,  {
        name = "BikiniEquipment",
        heading = 0,
        debugPoly = false,
        minZ = 25.73,
        maxZ = 27.33,
    }, {
        options = {
            {
                type = "client",
                event = "prdx_tuningjob:getEngineHoist",
                icon = "fas fa-litecoin-sign",
                label = "Get Engine Hoist",
                job = "bikinitow",
            },
        },
        distance = 1.5
    })  
    -- Nismos Tuning --
    exports['qb-target']:AddBoxZone("NismosEquipment", vector3(-1618.35, -834.7, 10.07), 4.6, 0.8,  {
        name = "NismosEquipment",
        heading = 229,
        debugPoly = false,
        minZ = 7.07,
        maxZ = 11.07
    }, {
        options = {
            {
                type = "client",
                event = "prdx_tuningjob:getEngineHoist",
                icon = "fas fa-litecoin-sign",
                label = "Get Engine Hoist",
                job = "nismostuning",
            },
        },
        distance = 1.5
    })  

    exports['qb-target']:AddBoxZone("NismosCrafting", vector3(-1607.31, -833.18, 10.07), 1.0, 2.05, {
        name="NismosCrafting",
        heading= 55.00,
        debugPoly= false,
        minZ = 9.07,
        maxZ = 10.42
    }, {
        options = {
            {
                type = "client",
                event = "prdx_tuningjob:openPartRepair",
                icon = "fas fa-cart-flatbed",
                nismos = true,
                label = "Repair Parts",
                job = "nismostuning"
            },
        },
    })
    -- Reapers Bike Shop --
    exports['qb-target']:AddBoxZone("ReapersEquipment", vector3(42.29, 6492.11, 31.44), 0.8, 1,  {
        name = "ReapersEquipment",
        heading = 315,
        debugPoly = false,
        minZ = 30.54,
        maxZ = 31.54
    }, {
        options = {
            {
                type = "client",
                event = "prdx_tuningjob:getEngineHoist",
                icon = "fas fa-litecoin-sign",
                label = "Get Engine Hoist",
                job = "bikedealer",
            },
        },
        distance = 1.5
    })  
    exports['qb-target']:AddBoxZone("ReapersCrafting", vector3(50.79, 6485.11, 30.44), 1.0, 0.8, {
        name="ReapersCrafting",
        heading= 133.66,
        debugPoly= false,
        minZ = 29.49,
        maxZ = 30.49
    }, {
        options = {
            {
                type = "client",
                event = "prdx_tuningjob:openPartRepair",
                icon = "fas fa-cart-flatbed",
                nismos = true,
                label = "Repair Parts",
                job = "bikedealer"
            },
        },
    })
    exports['qb-target']:AddBoxZone("NismosEngines", vector3(-1632.7, -822.53, 10.08), 4.4, 0.7,  {
        name = "NismosEngines",
        heading = 49,
        debugPoly = false,
        minZ = 9.08,
        maxZ = 11.48
    }, {
        options = {
            {
                type = "client",
                event = "prdx_tuningjob:openEnginePurchase",
                icon = "fas fa-cart-flatbed",
                label = "Order Engine",
                job = "nismostuning",
            },
        },
        distance = 1.5
    })
end)