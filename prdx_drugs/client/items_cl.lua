local QBCore = exports['qb-core']:GetCoreObject()

function ItemEmote(animType, cb)
    local animData = Config.DrugAnimations[animType]
    if not animData then return end
    TriggerEvent('animations:client:EmoteCommandStart', {animData.anim})
    QBCore.Functions.Progressbar("do_drugs", animData.label, animData.length, false, true, {}, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        cb(false)
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Canceled", "error")
        cb(true)
    end) 
end

RegisterNetEvent('prdx_drugs:client:UseDrug', function(itemName)
    if not Config.DrugItems[itemName] then return end
    local DrugData = Config.DrugItems[itemName]
    if DrugData.animation then 
        ItemEmote(DrugData.animation, function(hasCancelled)
            if not DrugData.effects and not DrugData.visualEffects then return end
            if hasCancelled then return end
            exports['prdx_buffs']:AddBuff(itemName, DrugData.time or 30, DrugData.effects or {}, DrugData.visualEffects or {}, DrugData.toxicity or 0.0) 
            TriggerServerEvent("prdx_business:items:removeitem", itemName)   
        end)           
    else
        if not DrugData.effects and not DrugData.visualEffects then return end
        if hasCancelled then return end
        exports['prdx_buffs']:AddBuff(itemName, DrugData.time or 30, DrugData.effects or {}, DrugData.visualEffects or {}, DrugData.toxicity or 0.0) 
        TriggerServerEvent("prdx_business:items:removeitem", itemName)
    end
end)