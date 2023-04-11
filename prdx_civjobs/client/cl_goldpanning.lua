RegisterNetEvent('goldpanning:client:washdirt')
AddEventHandler('goldpanning:client:washdirt', function(item)
    local isSwimming = IsPedSwimming(cache.ped) or IsPedSwimmingUnderWater(cache.ped)
    if item.metadata.durability then if item.metadata.durability == 0 then return end end
    if IsEntityInWater(cache.ped) and not isSwimming then
        lib.requestAnimDict('amb@prop_human_bum_bin@base')
        if lib.progressBar({
            duration = 5000,
            label = 'Washing dirt',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true
            },
            anim = {
                dict = 'amb@prop_human_bum_bin@base',
                clip = 'base',
                flag = 49,
            },
        }) then --complete
            TriggerServerEvent("QBCore:Server:RemoveItemDurability", item.name, 50, item.slot)
            TriggerServerEvent('goldpanning:server:washdirt', source, item)
        else end
    end
end)

RegisterNetEvent('goldpanning:client:digfordirt')
AddEventHandler('goldpanning:client:digfordirt', function(item)
    local playerCoord = GetEntityCoords(cache.ped)
    local target = GetOffsetFromEntityGivenWorldCoords(cache.ped,vector3(0,2,-3))
    local testRay = StartShapeTestLosProbe(playerCoord,target,511, 4)
    local retval, hit, endCoords, surfaceNormal, materialHash, entityHit

    while true do
        Wait(1)
        retval, hit, endCoords, surfaceNormal, materialHash, entityHit = GetShapeTestResultIncludingMaterial(testRay)
        if retval ~=1 then
            break
        end
    end
    if not Config.goldPanning.validDirt[materialHash] then
        lib.notify({
            title = 'Gold panning',
            description = "This dirt is not suitable for digging up",
            type = 'inform'
        })
        return
    end
    TriggerEvent('animations:client:EmoteCommandStart', {"dig"})
    if lib.progressBar({
        duration = 2500,
        label = 'Digging for dirt',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true
        },
    }) then --complete
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('goldpanning:server:getdirt')
        TriggerServerEvent("QBCore:Server:RemoveItemDurability", item.name, 2, item.slot)
    else end
end)

RegisterNetEvent('goldpanning:client:panformetals')
AddEventHandler('goldpanning:client:panformetals', function(item)
    local isSwimming = IsPedSwimming(cache.ped) or IsPedSwimmingUnderWater(cache.ped)
    if IsEntityInWater(cache.ped) and not isSwimming then
        local count = exports.ox_inventory:Search('count', 'dirt_pile')
        if count <= 0 then 
            lib.notify({
                title = 'Gold panning',
                description = "You don't have any dirt to wash",
                type = 'inform'
            })
            return
        end
        lib.requestAnimDict('amb@prop_human_bum_bin@base')
        if lib.progressBar({
            duration = 5000,
            label = 'Panning for metals',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true
            },
            anim = {
                dict = 'amb@prop_human_bum_bin@base',
                clip = 'base',
                flag = 49,
            },
        }) then --complete
            local success = lib.skillCheck({'easy', 'easy', 'easy'})
            if success then
                TriggerServerEvent('goldpanning:server:panreward', source)
            end
        else end
    else
    end
end)