local QBCore = exports['qb-core']:GetCoreObject()
local CurrentLocker
local CurrentLocation

-- Main Menu --
AddEventHandler('prdx_storagelockers:client:openLocation', function(data)
    if data.location and Config.StorageLockers[data.location] then
        CurrentLocation = data.location or false
        local menu = {
            {
                title = 'Open Storage Locker', 
                event = "prdx_storagelockers:client:openLockers"
            },
            {
                title = 'Purchase Storage Locker', 
                event = "prdx_storagelockers:client:purchaseLocker"
            },
            {
                title = 'Sell Storage Locker', 
                event = "prdx_storagelockers:client:sellLocker"
            },
        }
        lib.registerContext({
            id = 'storage_locker_menu',
            title = Config.StorageLockers[CurrentLocation].name.." Storage",
            options = menu,
        })
        lib.showContext('storage_locker_menu')
    end
end)

-- Purchase Menu --
AddEventHandler('prdx_storagelockers:client:purchaseLocker', function(data)
    if CurrentLocation then
        QBCore.Functions.TriggerCallback("prdx_storagelockers:server:getOwnedLockers", function(lockers)
            if not lockers or #lockers < 1 then
                local menu = {
                    {
                        title = 'Rent: $'..Config.StorageLockers[CurrentLocation].rentalcost..'/day', 
                        event = "prdx_storagelockers:client:setupPincode"
                    },
                }
                lib.registerContext({
                    id = 'purchase_storage_locker_menu',
                    title = Config.StorageLockers[CurrentLocation].name.." Storage",
                    options = menu,
                })
                lib.showContext('purchase_storage_locker_menu')
            end
        end, CurrentLocation)
    end
end)

-- Sell Menu --
AddEventHandler('prdx_storagelockers:client:setupPincode', function()
    if CurrentLocation then
        local dialog = lib.inputDialog("Setup Storage Pincode",{
            { type = "number", label = "Storage Pin Code", placeholder = "0" },
        })
        if not dialog then return end

        TriggerServerEvent('prdx_storagelockers:server:rentLocker', CurrentLocation, dialog[1])
        
    end
end)

-- Sell Menu --
AddEventHandler('prdx_storagelockers:client:sellLocker', function(data)
    if CurrentLocation then
        QBCore.Functions.TriggerCallback("prdx_storagelockers:server:getOwnedLockers", function(lockers)
            if lockers or #lockers < 1 then
                local menu = {}
                if lockers then
                    for k,v in pairs(lockers) do
                        menu[#menu+1] = {
                            title = 'Sell Locker: '..v.lockerid, 
                            description = 'WARNING THIS IS NOT REVERSABLE!',
                            serverEvent = "prdx_storagelockers:server:sellLocker",
                            args = v.lockerid
                        }
                    end
                end
                lib.registerContext({
                    id = 'owned_storage_lockers_menu',
                    title = Config.StorageLockers[CurrentLocation].name.." Storage",
                    options = menu,
                })
                lib.showContext('owned_storage_lockers_menu')
            end
        end, CurrentLocation)
    end
end)

-- Open Menu --
AddEventHandler('prdx_storagelockers:client:openLockers', function(data)
    if CurrentLocation then
        QBCore.Functions.TriggerCallback("prdx_storagelockers:server:getOwnedLockers", function(lockers)
            local menu = {
                {
                    title = 'Open Storage by ID', 
                    event = "prdx_storagelockers:client:doOpenDialogue",
                },
            }
            if lockers then
                for k,v in pairs(lockers) do
                    menu[#menu+1] = {
                        title = 'Locker: '..v.lockerid, 
                        event = "prdx_storagelockers:client:openLocker",
                        args = v.lockerid
                    }
                end
            end
            lib.registerContext({
                id = 'open_storage_locker_menu',
                title = Config.StorageLockers[CurrentLocation].name.." Storage",
                options = menu,
            })
            lib.showContext('open_storage_locker_menu')
        end, CurrentLocation)
    end
end)

AddEventHandler("prdx_storagelockers:client:doOpenDialogue", function(data)
    local dialog = lib.inputDialog("Open Storage Locker",{
        { type = "input", label = "Storage Locker ID", placeholder = "0" },
    })
    if not dialog then return end

    CurrentLocker = string.upper(dialog[1])
    SendNUIMessage({
        action = "openKeypad",
    })
    SetNuiFocus(true, true)
    exports['keypad']:OpenKeypad(function(combination)
        if combination then
            QBCore.Functions.TriggerCallback('prdx_storagelockers:server:tryOpenLocker', function(id, owner)
                if id then
                    exports.ox_inventory:openInventory('stash', { id = id, owner = owner })
                else
                    CurrentLocker = nil
                    QBCore.Functions.Notify('You cannot open this', 'error')
                end
            end, CurrentLocker, combination, CurrentLocation)
        end
    end)
end)

AddEventHandler("prdx_storagelockers:client:openLocker", function(lockerid)
    if CurrentLocation and lockerid then
        CurrentLocker = lockerid
        QBCore.Functions.TriggerCallback('prdx_storagelockers:server:openLocker', function(id)
            if id then
                exports.ox_inventory:openInventory('stash', { id = id, owner = QBCore.Functions.GetPlayerData().citizenid })
            else
                CurrentLocker = nil
                QBCore.Functions.Notify('You cannot open this', 'error')
            end
        end, CurrentLocker, CurrentLocation)
    end
end)