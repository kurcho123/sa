local QBCore = exports['qb-core']:GetCoreObject()

--#region Functions

-- Global
function SpawnRegisterProps()
    local hash = joaat("vw_prop_casino_till")
    lib.requestModel(hash)
    for k, v in pairs(Config.Job.RegisterSpawns) do
        local prop = CreateObject(hash, v.position, false, false, true)
        local ent = Entity(prop)
        ent.state:set(prop, 80001171, true)
        SetEntityRotation(ent, 0.0, 0.0, v.heading, 0, true)
        FreezeEntityPosition(ent, true)
    end
end

-- Setup business related areas

function SetupRegisters()
    local currentBusiness = nil
    local area = 1
    for k,v in pairs(Config.Job.Registers) do
        for i=1, #v do
            if currentBusiness ~= k then
                currentBusiness = k
                area = 1
            else
                area += 1
            end
            exports.ox_target:addBoxZone({
                coords = vec3(v[i].location.x, v[i].location.y, v[i].location.z), 
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ),
                rotation = v[i].heading,
                debug = Config.Debug,
                options = {
                    {
                        event = "prdx_business:openOrderDrawer",
                        icon = 'fas fa-box',
                        label = "Open Order Drawer",
                        groups = k,
                        business = k,
                        register = area,
                    },
                    {
                        event = "prdx_business:addExtraItem",
                        icon = 'fas fa-box',
                        label = "Add Extra Item",
                        groups = k,
                        business = k,
                        register = area,
                    },
                    {
                        event = "prdx_business:clearExtraItems",
                        icon = 'fas fa-trash',
                        label = "Clear Extra Items",
                        groups = k,
                        business = k,
                        register = area,
                    },
                    {
                        event = "prdx_business:openOrder",
                        icon = 'fas fa-cash-register',
                        label = "Pay for Order",
                        business = k,
                        register = area,
                    },
                    {
                        serverEvent = "prdx_bossmenu:server:giveDayRecipt",
                        icon = 'fas fa-cash-register',
                        label = "Generate Day Receipt",
                        groups = k,
                    },
                },
            })
        end
    end
end

function SetupStorage()
    local currentBusiness = nil
    local area = 1
    for k,v in pairs(Config.Job.Storage) do
        for i=1, #v do
            if currentBusiness ~= k then
                currentBusiness = k
                area = 1
            else
                area += 1
            end
            exports.ox_target:addBoxZone({
                coords = vec3(v[i].location.x, v[i].location.y, v[i].location.z),
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ),
                rotation = v[i].heading,
                debug = Config.Debug,
                options = {
                    {
                        event = "prdx_business:storage",
                        icon = 'fas fa-box',
                        label = "Open Storage",
                        stash = v[i].stashName,
                        groups = k,
                        distance = 1.5
                    },
                }
            })
        end
    end
end

function SetupBossMenus()
    for k,v in pairs(Config.Job.BossLocations) do
        for i=1, #v do
            exports.ox_target:addBoxZone({
                coords = vec3(v[i].location.x, v[i].location.y, v[i].location.z), 
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ),
                rotation = v[i].heading,
                debug = Config.Debug,
                options = {
                    {
                        event = "prdx_bossmenu:client:openMenu",
                        icon = 'fas fa-box',
                        label = "Boss Actions",
                        groups = k,
                        distance = 1.5
                    }
                }
            })
        end
    end
end

function SetupDutyLocations()
    for k,v in pairs(Config.Job.DutyLocations) do
        for i=1, #v do
            exports.ox_target:addBoxZone({
                coords = vec3(v[i].location.x, v[i].location.y, v[i].location.z), 
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ), 
                rotation = v[i].heading,
                debug = Config.Debug,
                options = {
                    {
                        serverEvent = "QBCore:jobs:ToggleDuty",
                        icon = 'fas fa-box',
                        label = "Toggle Duty",
                        dutyJob = k,
                        distance = 1.5
                    },
                }
            })
        end
    end
end

function SetupClothing()
    for k,v in pairs(Config.Job.Clothing) do
        for i=1, #v do
            exports.ox_target:addBoxZone({
                coords = vec3(v[i].location.x, v[i].location.y, v[i].location.z), 
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ),
                rotation = v[i].heading,
                debug = Config.Debug,
                options = {
                    {
                        event = "prdx_business:clothing",
                        icon = 'fas fa-box',
                        label = "Open Clothing",
                    }
                }
            })
        end
    end
end

function SetupSeating()
    for k,v in pairs(Config.Job.Seating) do
        for i=1, #v do
            local c_label = "Sit"
            if v[i].label ~= nil then c_label = v[i].label end
            exports.ox_target:addBoxZone({
                coords = vec3(v[i].location.x, v[i].location.y, v[i].location.z), 
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ),
                rotation = v[i].heading,
                debug = Config.Debug,
                options = {
                    {
                        event = 'prdx_sit:client:sit',
                        icon = v[i].icon,
                        label = c_label,
                        heading = v[i].heading,
                        seatingPos = v[i].sitPos,
                        sitanim = v[i].sitanim,
                        sitclip = v[i].sitclip or nil,
                        ispoly = true,
                        distance = 1.5
                    }
                }
            })
        end
    end
end

function SetupElevators()
    for k, elevator in pairs(Config.Job.Elevators) do
        if elevator.job then
            if not QBCore.Functions.GetPlayerData().metadata["ranks"][elevator.job] then break end
        end
        exports.ox_target:addBoxZone({
            coords = vec3(elevator.boxPosition.x, elevator.boxPosition.y, elevator.boxPosition.z),
            size = vec3(elevator.ysize, elevator.xsize, elevator.maxz - elevator.minz),
            rotation = elevator.heading,
            debug = Config.Debug,
            options = {
                { 
                    event = "prdx_business:client:elevator",
                    icon = elevator.icon,
                    label = elevator.label, 
                    exitCoords = elevator.exitPoint,
                    name = elevator.name,
                    tooltiptext = elevator.tooltiptext,
                    distance = 5.0
                }
            }
         }) 
    end
end


-- Mobile business functions

function SetupMobileOptions()
    for k,v in pairs(Config.MobileBusiness) do
        local options = {
            { num = 1, event = 'prdx_business:mobileMenus', icon = 'fas fa-circle', label = Config.Businesses[v.job] .. ' Options', groups = v.job, job = v.job, showStorage = v.showStorage },
            { num = 2, event = 'prdx_business:openOrder', icon = 'fas fa-circle', label = 'Pay for Order', business = v.job, register = 1 },
        }
        if v.showBoss then
            options[#options+1] = { num = 3, event = 'prdx_bossmenu:client:openMenu', icon = 'fas fa-circle', label = 'Boss Actions', groups = v.job }
        end
        exports.ox_target:addModel(joaat(v.vehicle), options)
    end
    SetupGarages()
end

-- Unique garages
function SetupGarages()
    for k,v in pairs(Config.Job.Garages) do
        for i=1, #v do
            local options = {}
            if type(v[i].vehicleHash) == "table" then
                for x,y in pairs(v[i].vehicleHash) do
                    options[#options+1] = {
                        event = "prdx_business:mobilespawn",
                        icon = 'fas fa-box',
                        label = "Spawn " .. Config.Job.Vehicles[joaat(y)],
                        groups = v[i].busName,
                        vehiclename = y,
                        spawnPoint = v[i].spawnPoint,
                        platePrefix = v[i].platePrefix,
                        distance = 1.5
                    }
                end
            else
                options[#options+1] = {
                    event = "prdx_business:mobilespawn",
                    icon = 'fas fa-box',
                    label = "Spawn " .. Config.Job.Vehicles[joaat(v[i].vehicleHash)],
                    groups = v[i].busName,
                    vehiclename = v[i].vehicleHash,
                    spawnPoint = v[i].spawnPoint,
                    platePrefix = v[i].platePrefix,
                    distance = 1.5
                }
            end

            options[#options+1] = {
                event = "prdx_business:mobileremove",
                icon = 'fas fa-box',
                label = "Return Vehicle",
                groups = v[i].busName,
                location = i,
                business = v[i].busName,
                distance = 1.5
            }

            exports.ox_target:addBoxZone({
                coords = vec3(v[i].location.x, v[i].location.y, v[i].location.z),
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ),
                rotation = v[i].heading,
                debug = Config.Debug,
                options = options        
            })
        end
    end
end

-- Deprectated

-- function SetupCrafting()
--     local currentBusiness = QBCore.Functions.GetPlayerData().job.name
--     local area = 1
--     if PrevJob then
--         if Config.Crafting[PrevJob.name] then
--             for k,v in pairs(Config.Crafting[PrevJob.name]) do
--                 if currentBusiness ~= k then
--                     currentBusiness = k
--                     area = 1
--                 else
--                     area += 1
--                 end
--                 exports['qb-target']:RemoveZone(k .. ".Crafting." .. tostring(area))
--             end
--         end
--     end
--     if Config.Crafting[currentBusiness] then
--         area = 1
--         for k,v in pairs(Config.Crafting[currentBusiness]) do
--             if currentBusiness ~= k then
--                 currentBusiness = k
--                 area = 1
--             else
--                 area += 1
--             end
--             exports['qb-target']:AddBoxZone(k .. ".Crafting." .. tostring(area), v.location, v.length, v.width, {
--                 name = k .. ".Crafting." .. tostring(area),
--                 heading = v.heading,
--                 debugPoly = Config.Debug,
--                 minZ = v.minZ,
--                 maxZ = v.maxZ
--                 }, {
--                 options = {
--                     {
--                         type = "client",
--                         event = "inventory:client:JobCrafting",
--                         icon = 'fas fa-hand-sparkles',
--                         label = "Open Crafting Station",
--                         craftJob = currentBusiness,
--                         craftingItems = v.items,
--                     },
--                 },
--                 distance = 1.0
--             })
--         end
--     end
-- end

--#endregion

--#region events

-- Mobile businesses
AddEventHandler('prdx_business:mobileMenus', function(data)
    local menu = {
        {
            title = 'Open Order Drawer',
            event = "prdx_business:openOrderDrawer",
            args = {business = data.job, register = 1}
        },{
            title = 'Add Extra Item',
            event = "prdx_business:addExtraItem",
            args = {job = data.job, business = data.job, register = 1}
        },{
            title = 'Generate Day Reciept',
            event = "prdx_business:mobilereciept",
            args = {job = data.job}
        }
    }

    if data.showStorage then
        menu[#menu+1] = {
            title = "Open Storage",
            event = "prdx_business:storage",
            args = { stash = data.job }
        }
    end
    if Config.Job.MobileCrafting[data.job] then
        menu[#menu+1] = {
            title = "Open Crafting",
            event = "inventory:client:OpenCraftSet",
            args = { args = Config.Job.MobileCrafting[data.job][1].items }
        }
    end
    lib.registerContext({
		id = 'mobileMenu',
		title = 'Business Menu',
		onExit = function() end,
		options = menu
	})
	lib.showContext('mobileMenu')
end)

AddEventHandler("prdx_business:mobilereciept", function(data)
    TriggerServerEvent('prdx_bossmenu:server:giveDayRecipt', data.job)
end)

AddEventHandler("prdx_business:mobilespawn", function(data)
    QBCore.Functions.SpawnVehicle(data.vehiclename, function(vehicle)
        SetVehicleNumberPlateText(vehicle, data.platePrefix .. tostring(math.random(111,999)))
        exports['ps-fuel']:SetFuel(vehicle, 100.0)
        SetEntityHeading(vehicle, data.spawnPoint.w)
        TaskWarpPedIntoVehicle(cache.ped, vehicle, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(vehicle))
        SetVehicleEngineOn(vehicle, true, true)
    end, data.spawnPoint, true) 
end)

AddEventHandler("prdx_business:mobileremove", function(data)
    local pedCoords = GetEntityCoords(cache.ped)
    local closestObject = nil
    if type(Config.Job.Garages[data.business][data.location].vehicleHash) == "table" then
        for k,v in pairs(Config.Job.Garages[data.business][data.location].vehicleHash) do
            closestObject = QBCore.Functions.GetVehiclesInArea(pedCoords, 15)
            for x,y in pairs(closestObject) do
                if joaat(v) == GetEntityModel(y) then
                    closestObject = y
                    goto match
                else
                    closestObject = nil
                end
            end
        end
    else
        closestObject = QBCore.Functions.GetVehiclesInArea(pedCoords, 15)
        for x,y in pairs(closestObject) do
            if joaat(Config.Job.Garages[data.business][data.location].vehicleHash) == GetEntityModel(y) then
                closestObject = y
                goto match
            else
                closestObject = nil
            end
        end
    end
    ::match::
    if not closestObject then QBCore.Functions.Notify('No job vehicles in range to return!', 'error') return end
    local timeout = 0 
    SetEntityAsMissionEntity(closestObject, true, true )
    DeleteVehicle(closestObject)
    Wait(100)
    ClearPedTasksImmediately(cache.ped)
end)

-- Orders
-- Employee opening an order drawer to put items to sell
AddEventHandler("prdx_business:openOrderDrawer", function(data)
    QBCore.Functions.TriggerCallback("prdx_business:generateStash", function(id)
        if id then
            exports.ox_inventory:openInventory('stash', id)
        end
    end, data.business, data.register)
end)

AddEventHandler("prdx_business:addExtraItem", function(data)
    local dialog = lib.inputDialog("Add Extra Item",{
        { type = "input", label = "Item Name"},
        { type = "number", label = "Item Price ($)", placeholder = "0000" }
    })
    if not dialog then return end

    TriggerServerEvent("prdx_business:addExtraItem", data.business, data.register, dialog[1], dialog[2])

end)

AddEventHandler("prdx_business:clearExtraItems", function(data)
    TriggerServerEvent("prdx_business:clearExtraItems", data.business, data.register)
end)

-- Open the order buying menu, requests the order details from server
AddEventHandler("prdx_business:openOrder", function(data)
    QBCore.Functions.TriggerCallback("prdx_business:generateSale", function(price, order, orderid, extracharges)
        local Sale = 'Total: $' ..price..'  \nOrder Items:\n'
        for k,v in pairs(order) do
            Sale = Sale..'  \n'..v.label..' '..v.amount..'x'
        end
        if extracharges then
            for k,v in pairs(extracharges) do
                Sale = Sale..'  \n'..v.label..' $'..v.amount
            end
        end
        lib.registerContext({
            id = 'business_order_menu',
            title = Config.Businesses[data.business],
            options = {
                {
                    title = 'Order #'..orderid,
                    description = Sale,
                    disabled = true
                },
                {
                    title = 'Confirm Sale',
                    event = "prdx_business:buyOrder",
                    args = {
                        order = 'Order:'..orderid,
                        business = data.business,
                        register = data.register
                    }
                }
            }
        })
        lib.showContext('business_order_menu')
    end, data.business, data.register)
end)

-- Open the order buying menu, requests the order details from server
AddEventHandler("prdx_business:buyOrder", function(data)
    TriggerServerEvent("inventory:server:buyStash", {data.order, data.business})
    Wait(1000)
    TriggerServerEvent("prdx_business:buyExtraItems", data.business, data.register)
end)

-- Job locations
-- Open storage of items
AddEventHandler("prdx_business:storage", function(data)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "LockerOpen", 0.4)
    exports.ox_inventory:openInventory('stash', {id = data.stash, owner = data.stash})
end)

-- Open clothes
AddEventHandler("prdx_business:clothing", function(data)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
    TriggerEvent('raid_clothes:outfitsMenu')
end)

--#endregion