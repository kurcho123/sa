local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('prdx_drugs:client:UseTable', function(TableType)
    local netid = false
    if TableType == 'Weed' then
        netid = exports['prdx_props']:generateProp('weedtable')
    elseif TableType == 'Coke' then
        netid = exports['prdx_props']:generateProp('coketable')
    end
    local entity = NetworkGetEntityFromNetworkId(netid)
    if entity and DoesEntityExist(entity) then
        QBCore.Functions.SetStateBag(entity, 'plantTable', true)
    end
end)

RegisterNetEvent('prdx_drugs:client:cocaLeaves', function(purity, slot)
    local weapon = cache.weapon
    local petrolHash = joaat('weapon_petrolcan')
    local ammo = GetAmmoInPedWeapon(cache.ped, petrolHash)
    local retval, maxAmmo = GetMaxAmmo(cache.ped, petrolHash)
    local minAmmo = math.round(maxAmmo/4,0)
    if weapon == petrolHash and ammo >= minAmmo then
        TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
        QBCore.Functions.Progressbar("add_gas", "Washing in gasoline...", math.random(10000,20000), false, true, {
            disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
            TriggerServerEvent("prdx_drugs:server:cocaLeaves", purity, slot)
            SetPedAmmo(cache.ped, petrolHash, ammo - minAmmo) 
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    elseif weapon == petrolHash and ammo <= minAmmo then
        QBCore.Functions.Notify('Gas can seems empty', 'error')
    else
        QBCore.Functions.Notify('You are missing something', 'error')
    end
end)

AddEventHandler('prdx_drugs:client:plantBreakdownMenu', function(data)
    local menu = {
        {
            title = "Place Plant(s)", 
            event = "target:client:openStash",
            args = data
        },
        {
            title = "Start Processing", 
            event = "prdx_drugs:client:plantConfirmMenu",
            args = data
        },
    }
    lib.registerContext({
        id = 'plant_breakdown_menu',
        title = 'Breakdown Plant',
        options = menu,
    })
    lib.showContext('plant_breakdown_menu')
end)

AddEventHandler('prdx_drugs:client:plantConfirmMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm", 
            event = "prdx_drugs:client:startPlantBreakdown",
            args = data       
        }      
    }
    lib.registerContext({
        id = 'plant_confirm_menu',
        title = 'Breakdown Plant',
        options = menu,
    })
    lib.showContext('plant_confirm_menu')
end)

AddEventHandler('prdx_drugs:client:startPlantBreakdown', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
    local success = lib.skillCheck({'easy', 'easy', 'medium', 'medium' })
    local timer = math.random(20000,50000)
    if success then
        timer = math.random(5000,10000)
    end
    QBCore.Functions.Progressbar("breakdown_plant", "Breaking down plant...", timer, false, true, {
            disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
            data.args = {data.args[1], true}
            TriggerServerEvent("inventory:server:sellStash", data)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

CreateThread(function()
    for k,v in pairs(Config.PlantTables) do
        local options = {
            {
                name = 'prdx_drugs:tables:openCraftSet',
                event = 'inventory:client:OpenCraftSet',
                icon = 'fas fa-capsules',
                label = 'Table Crafting',
                args = v.Recipes or {},
                canInteract = function(entity, distance, coords, name, bone)
                    if not Entity(entity).state.plantTable then return false end
                    return true
                end,
                distance = 1.25
            },
            {
                name = 'prdx_drugs:client:plantBreakdownMenu',
                event = 'prdx_drugs:client:plantBreakdownMenu',
                icon = 'fas fa-cannabis',
                label = 'Process Plant(s)',
                args = {k..'breakdown', k..'breakdown'},
                canInteract = function(entity, distance, coords, name, bone)
                    if not Entity(entity).state.plantTable then return false end
                    return true
                end,
                distance = 1.25
            }
        }
        exports.ox_target:addModel(v.TableModel, options) 
    end
end)