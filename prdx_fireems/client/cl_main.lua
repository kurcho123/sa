QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}
local currentGarage = 1

---Opens the hospital stash.
local function openStash()
    QBCore.Functions.TriggerCallback('prdx_fireems:server:generatePersonalStash', function(id, citizenID)
        if id then
            exports.ox_inventory:openInventory('stash', {id = id, owner = citizenID})
        end
    end)
end

---Opens the hospital pharmacy.
local function openPharmacy()
    exports.ox_inventory:openInventory('shop', { type = 'HospitalPharmacy' })
end

CreateThread(function()
    for k, v in pairs(Config.Locations.Duty) do
        exports.ox_target:addBoxZone({
            name = "duty" .. k,
            coords = vec3(v.x, v.y, v.z),
            size = vec3(1, 1, 2),
            rotation = v.w,
            debug = false,
            options = {
                {
                    serverEvent = 'QBCore:jobs:ToggleDuty',
                    icon = 'fas fa-business-time',
                    label = 'Go on/off duty',
                    distance = 2,
                    dutyJob = "ambulance"
                }
            }
        })
    end
    for k, v in pairs(Config.Locations.Stash) do
        exports.ox_target:addBoxZone({
            name = "stash" .. k,
            coords = vec3(v.x, v.y, v.z),
            size = vec3(1, 1, 2),
            rotation = v.w,
            debug = false,
            options = {
                {
                    type = "client",
                    onSelect = openStash,
                    icon = "fas fa-boxes-packing",
                    label = 'Job Personal Stash',
                    distance = 2,
                    groups = "ambulance",
                },
                {
                    type = "client",
                    onSelect = openPharmacy,
                    icon = "fas fa-pills",
                    label = 'Open Pharmacy',
                    distance = 1.5,
                    groups = "ambulance",
                }
            }
        })
    end
    for k, v in pairs(Config.Locations.ClothingLocker) do
        exports.ox_target:addBoxZone({
            name = "pharmacy" .. k,
            coords = vec3(v.x, v.y, v.z),
            size = vec3(1, 1, 2),
            rotation = v.w,
            debug = false,
            options = {
                {
                    event = "raid_clothes:client:openJobClothing",
                    icon = "fas fa-user-tie",
                    label = 'Open Uniform Locker',
                    groups = {"ambulance", "clinic", "fire"},
                },
                {
                    event = "raid_clothes:outfitsMenu",
                    icon = "fas fa-tshirt",
                    label = 'Open Personal Outfits',
                },
            }
        })
    end
    for k, v in pairs(Config.Locations.Boss) do
        exports.ox_target:addBoxZone({
            name = "emsboss" .. k,
            coords = vec3(v.x, v.y, v.z),
            size = vec3(1, 1, 2),
            rotation = v.w,
            debug = false,
            options = {
                {
                    event = "prdx_bossmenu:client:openMenu",
                    icon = "fas fa-users",
                    label = 'Fire/EMS Management',
                    groups = {["ambulance"] = 5},
                },
            }
        })
    end
end)

-- Functions

function TakeOutVehicle(vehicleInfo)
    local coords
    for k,v in pairs(Config.Locations.Garage[currentGarage]) do
        local isSpawnPointClear = QBCore.Functions.IsSpawnPointClear(v.xyz, 1.0)
        if isSpawnPointClear then
            coords = v
            break
        end
    end
    if coords then
        QBCore.Functions.SpawnVehicle(vehicleInfo.vehicle, function(veh)
            TriggerServerEvent("ambulance:server:setVehicleState", NetworkGetNetworkIdFromEntity(veh), vehicleInfo.id, 0)
            QBCore.Functions.TriggerCallback('ambulance:server:GetVehicleProperties', function(properties, name)
                if properties ~= nil then
                    QBCore.Functions.SetVehicleProperties(veh, properties)
                end
                SetVehicleNumberPlateText(veh, "AMBU"..tostring(math.random(1000, 9999)))
                if name == "Medic" then
                    SetVehicleLivery(veh, 2)
                    SetVehicleExtra(veh, 1, true)
                elseif name == "Rescue" then
                    SetVehicleLivery(veh, 1)
                    SetVehicleExtra(veh, 1, false)
                elseif name == "Probation" then
                    SetVehicleLivery(veh, 0)
                    SetVehicleExtra(veh, 1, false)
                end
                SetEntityHeading(veh, coords.w)
                exports['ps-fuel']:SetFuel(veh, 100.0)
                TaskWarpPedIntoVehicle(cache.ped, veh, -1)
                QBCore.Functions.SetStateBag(veh, 'id', vehicleInfo.id)
                QBCore.Functions.SetStateBag(veh, 'powerDecrease', 0)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
                SetVehicleEngineOn(veh, true, true)
            end, vehicleInfo.id)
        end, coords, true)
    else
        QBCore.Functions.Notify("There are no free spaces to pull out this vehicle", "error", 5000)
    end
end

function MenuGarage()
    local Categories = {}
    local CategoryVehicles = {}
    local vehicleMenu = { }

    QBCore.Functions.TriggerCallback('ambulance:server:getAvailableVehicles', function(vehicles)
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
                event = "ambulance:client:openCategory",
                args = CategoryVehicles[category]
            }
        end
        lib.registerContext({
            id = 'emsgarage',
            title = 'Available Fire/EMS Vehicles',
            onExit = function() end,
            options = vehicleMenu
        })
        lib.showContext('emsgarage')
    end)
end

RegisterNetEvent('ambulance:client:openCategory', function(CategoryVehicles)
    local vehicleMenu = {}
    
    --QBCore.Functions.Tableprint(CategoryVehicles)
    for k,v in pairs(CategoryVehicles) do
        local vehmods = json.decode(v.mods) or {}
        if not vehmods.fuelLevel then vehmods.fuelLevel = 100 end
        vehicleMenu[#vehicleMenu+1] = {
            title = v.name,
            description = 'Plate: ' ..(vehmods.plate or 'UNKNOWN')..' | Fuel: '.. QBCore.Shared.Round(vehmods.fuelLevel)..'%',
            progress = QBCore.Shared.Round(vehmods.fuelLevel),
            event = "ambulance:client:TakeOutVehicle",
            args = {
                id = v.id,
                vehicle = v.vehicle,
                mods = v.mods,
                name = v.name
            }
        }
    end

    lib.registerContext({
        id = 'fireEMSCatMenu',
        title = 'Available EMS Vehicles',
        onExit = function() end,
        menu = 'emsgarage',
        options = vehicleMenu
    })
    lib.showContext('fireEMSCatMenu')
end)

function MenuVehiclePurchase()
    local vehicleMenu = {}

    local purchasableVehicles = Config.PurchasableVehicles[currentGarage]
    for k, v in pairs(purchasableVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            title = v.name,
            description = "$" .. v.price,
            serverEvent = "ambulance:server:PurchaseVehicle",
            args = {
                vehicle = k,
                price = v.price,
                name = v.name
            }
        }
    end

    lib.registerContext({
        id = 'emsgarageshop',
        title = 'Purchasable EMS Vehicles',
        onExit = function() end,
        options = vehicleMenu
    })
    lib.showContext('emsgarageshop')
end

function StoreVehicle()
    local veh = GetVehiclePedIsIn(cache.ped, true)
    if veh ~= 0 then
        local netId = NetworkGetNetworkIdFromEntity(veh)
        local idState = Entity(veh).state.id
        local props = QBCore.Functions.GetVehicleProperties(veh)
        TriggerServerEvent("ambulance:server:setVehicleState", netId, idState, 1, props)
        QBCore.Functions.DeleteVehicle(veh)
    end
end

function GetPlayerFromPed(ped)
    for _,player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end
    return -1
end

-- Events

RegisterNetEvent('ambulance:client:TakeOutVehicle', function(data)
    TakeOutVehicle(data)
end)

RegisterNetEvent("ambulance:client:openGarage")
AddEventHandler("ambulance:client:openGarage", function(data)
    currentGarage = nil
    local coords = GetEntityCoords(cache.ped)
    for k, v in pairs(Config.Locations.Garage) do
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

RegisterNetEvent("ambulance:client:openVehiclePurchase")
AddEventHandler("ambulance:client:openVehiclePurchase", function(data)
    currentGarage = data.garage
    MenuVehiclePurchase()
end)

RegisterNetEvent("ambulance:client:storeVehicle")
AddEventHandler("ambulance:client:storeVehicle", function(data)
    currentGarage = data.garage
    StoreVehicle()
end)

RegisterNetEvent("ambulance:client:SpawnHelicopter")
AddEventHandler("ambulance:client:SpawnHelicopter", function(data)
    local ped = cache.ped
    local coords = data.args.coords
    QBCore.Functions.SpawnVehicle(Config.Helicopter, function(veh)
        SetVehicleNumberPlateText(veh, "LIFE"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        SetVehicleLivery(veh, 1) -- Ambulance Livery
        exports['ps-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(ped, veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

RegisterNetEvent("ambulance:client:deleteHelicopter")
AddEventHandler("ambulance:client:deleteHelicopter", function()
    QBCore.Functions.DeleteVehicle(GetVehiclePedIsIn(cache.ped, true))
end)
TriggerEvent('prdx_stretcher:client:stretchercheck')

RegisterNetEvent('prdx_fireems:openInteractions')
AddEventHandler('prdx_fireems:openInteractions', function(data)
    local player = GetPlayerFromPed(data.entity) 
    local serverID = GetPlayerServerId(player) -- Get player ID of targeted ply
    lib.registerContext({
        id = 'hospitalopenInteractions',
        title = 'Fire/EMS Interactions',
        onExit = function() end,
        options = {
            {
                title = "Check Person Health",
                serverEvent = "prdx_healthsystem:server:GetPlayerInjuries",
                args = serverID
            },{
                title = "Load/Unload Patient",
                description = "Load or unload patient on stretcher",
                event = "prdx_stretcher:client:LoadPatient",
            },{
                title = "Observe Person",
                event = "police:client:CheckStatus",
                args  = data
            },
        }
    })

    lib.showContext('hospitalopenInteractions')
end)

RegisterNetEvent('hospital:client:openPersonalStash', function()
    QBCore.Functions.TriggerCallback('hospital:server:generatePersonalStash', function(id)
        if id then
            exports.ox_inventory:openInventory('stash', {id = id, owner = QBCore.Functions.GetPlayerData().citizenid})
        end
    end)
end)

AddEventHandler("hospital:client:spawnboat", function(data)
    local coords = vector4(data.spawn.x, data.spawn.y, data.spawn.z, data.spawn.w)
    QBCore.Functions.SpawnVehicle(data.vehicle, function(veh)
        TaskWarpPedIntoVehicle(cache.ped, veh, -1)
        SetVehicleLivery(veh , 1)
        SetVehicleNumberPlateText(veh, "BOAT"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        SetVehicleEngineOn(veh, true, true)
        exports['ps-fuel']:SetFuel(veh, 100.0)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
    end, coords.xyz, true)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

-- Threads
CreateThread(function()
    while true do
        sleep = 2000
        if LocalPlayer.state.isLoggedIn and PlayerJob and (PlayerJob.name == "ambulance" or PlayerJob.name == "fire" or PlayerJob.name == "clinic") then
            local pos = GetEntityCoords(cache.ped)
            
            for k, v in pairs(Config.Locations.BoatGarage) do
                if #(pos - vector3(v.marker.x, v.marker.y, v.marker.z)) < 7.5 then
                    sleep = 5
                    DrawMarker(2, v.marker.x, v.marker.y, v.marker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                    if #(pos - vector3(v.marker.x, v.marker.y, v.marker.z)) < 1.5 then
                        lib.showTextUI('[E] - Take out boat', {
                            position = "top-center",
                            icon = 'anchor',
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
                                    event = "hospital:client:spawnboat",
                                    args = {
                                        vehicle = v.model,
                                        spawn = spawn
                                    }
                                }
                            end
                            lib.registerContext({
                                id = 'snrboats',
                                title = 'Available S&R Boats',
                                onExit = function() end,
                                options = vehicleMenu
                            })
                        
                            lib.showContext('snrboats')
                        end
                    else
                        lib.hideTextUI() -- Hide ui text
                    end
                end
                if #(pos - vector3(v.spawn.x, v.spawn.y, v.spawn.z)) < 7.5 then
                    sleep = 5
                    if cache.vehicle then
                        DrawMarker(2, v.spawn.x, v.spawn.y, v.spawn.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
                        if #(pos - vector3(v.spawn.x, v.spawn.y, v.spawn.z)) < 3.0 then
                            lib.showTextUI('[E] - Store boat', {
                                position = "top-center",
                                icon = 'anchor',
                                style = {
                                    borderRadius = 0,
                                    backgroundColor = '#48BB78',
                                    color = 'white'
                                }
                            })
                            if IsControlJustReleased(0, 38) then
                                QBCore.Functions.DeleteVehicle(cache.vehicle)
                                SetEntityCoords(cache.ped, v.marker.xyz)
                            end
                        else
                            lib.hideTextUI() -- Hide ui text
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)