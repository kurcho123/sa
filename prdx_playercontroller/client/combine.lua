RegisterNetEvent('combine:client:progress', function(recipe, slots)
    TriggerEvent('ox_inventory:closeInventory')
    Wait(1000)
    QBCore.Functions.Progressbar("combining_item", Config.CombineRecipes[recipe].text, Config.CombineRecipes[recipe].duration, false, true, {disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = true}, { animDict = Config.CombineRecipes[recipe].anim.dict, anim = Config.CombineRecipes[recipe].anim.lib, flags = 17, task = nil }, {}, {}, function() 
        TriggerServerEvent('combine:server:result', recipe, slots)
    end, function()
        QBCore.Functions.Notify("Cancelled", "error")
    end)
end)