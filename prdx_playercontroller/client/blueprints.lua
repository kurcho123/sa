local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('blueprints:client:openCrafting', function(data)
    exports.ox_inventory:openInventory('crafting')
end)

local toolBoxModels = {
	'gr_prop_gr_bench_02a'
}

exports['qb-target']:AddTargetModel(toolBoxModels, {
		options = {
			{
				event = "blueprints:client:openCrafting",
				icon = "fas fa-wrench",
				label = "Blueprint Crafting", 
			},
		},
    distance = 1.0
})