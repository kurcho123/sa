local QBCore = exports['qb-core']:GetCoreObject()

---wip types

---@class OxShop
---@field name string
---@field blip? { id: number, colour: number, scale: number }
---@field inventory { name: string, price: number, count?: number, currency?: string }
---@field locations? vector3[]
---@field targets? { loc: vector3, length: number, width: number, heading: number, minZ: number, maxZ: number, distance: number, debug?: boolean, drawSprite?: boolean }[]
---@field groups? string | string[] | { [string]: number }

return {
	General = {
		name = '24/7 Supermarket',
		blip = {
			id = 59, colour = 69, scale = 0.4
		}, inventory = {
			{ name = 'tosti', price = 5 },
			{ name = 'water_bottle', price = 5 },
			{ name = 'coffee', price = 5 },
			{ name = 'kurkakola', price = 5 },
			{ name = 'sprunk', price = 5 },
			{ name = 'juicebox', price = 5 },
			{ name = 'cereal', price = 10 },
			{ name = 'twerks_candy', price = 2 },
			{ name = 'snikkel_candy', price = 1 },
			{ name = 'sandwich', price = 10 },
			{ name = 'phat_chips', price = 10 },
			{ name = 'beer', price = 10 },
			{ name = 'whiskey', price = 15 },
			{ name = 'vodka', price = 12 },
			{ name = 'bandage', price = 25 },
			{ name = 'rolling_paper', price = 5 },
			{ name = 'notepad', price = 5, metadata = { noteId = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)) } },
			{ name = 'lime', price = 5 },
			{ name = 'wallet', price = 90 },			
			{ name = 'baking_soda', price = 8 },
			{ name = 'bookbag', price = 1000 },
			{ name = 'easter_bunny', price = 5 }
			
			
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
			vec3(813.81, -782.9, 26.18),
			vec3(161.32, 6640.68, 31.61)
		}
	},

	General2 = {
		name = 'LTD Gasoline',
		blip = {
			id = 59, colour = 69, scale = 0.4
		}, inventory = {
			{ name = 'tosti', price = 5 },
			{ name = 'water_bottle', price = 5 },
			{ name = 'coffee', price = 5 },
			{ name = 'kurkakola', price = 5 },
			{ name = 'sprunk', price = 5 },
			{ name = 'twerks_candy', price = 2 },
			{ name = 'snikkel_candy', price = 1 },
			{ name = 'sandwich', price = 10 },
			{ name = 'juicebox', price = 5 },
			{ name = 'cereal', price = 10 },
			{ name = 'phat_chips', price = 10 },
			{ name = 'beer', price = 10 },
			{ name = 'whiskey', price = 15 },
			{ name = 'vodka', price = 12 },
			{ name = 'bandage', price = 25 },
			{ name = 'rolling_paper', price = 5 },
			{ name = 'notepad', price = 5, metadata = { noteId = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)) } },
			{ name = 'lime', price = 5 },
			{ name = 'wallet', price = 90 },			
			{ name = 'baking_soda', price = 8 },
			{ name = 'bookbag', price = 1000 },
			{ name = 'easter_bunny', price = 5 }
		}, locations = {
			vec3(-48.44, -1757.72, 29.42),
			vec3(-707.4, -914.62, 19.22),
			vec3(-1820.41, 792.61, 138.11),
			vec3(1163.59, -323.81, 69.21),
			vec3(1697.99, 4924.4, 42.06)
		}
	},

	Liquor = {
		name = 'Rob\'s Liqour',
		blip = {
			id = 93, colour = 69, scale = 0.4
		}, inventory = {
			{ name = 'tosti', price = 5 },
			{ name = 'water_bottle', price = 5 },
			{ name = 'coffee', price = 5 },
			{ name = 'kurkakola', price = 5 },
			{ name = 'sprunk', price = 5 },
			{ name = 'twerks_candy', price = 2 },
			{ name = 'snikkel_candy', price = 1 },
			{ name = 'phat_chips', price = 10 },
			{ name = 'sandwich', price = 10 },
			{ name = 'beer', price = 10 },
			{ name = 'whiskey', price = 15 },
			{ name = 'vodka', price = 12 },
			{ name = 'bandage', price = 25 },
			{ name = 'rolling_paper', price = 5 },
			{ name = 'notepad', price = 5, metadata = { noteId = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)) } }
		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980)
		}
	},

	Hardware = {
		name = 'Hardware Store',
		blip = {
			id = 402, colour = 69, scale = 0.4
		}, inventory = {
			{ name = 'lockpick', price = 250 },
			{ name = 'weapon_wrench', price = 75 },
			{ name = 'weapon_hammer', price = 50 },
			{ name = 'screwdriverset', price = 150 },
			{ name = 'phone', price = 50 },
			{ name = 'binoculars', price = 25 },
			{ name = 'cleaningkit', price = 15 },
			{ name = 'raw_wood', price = 10 },
			{ name = 'armor', price = 1000 },
			{ name = 'wallet', price = 80 },			
			{ name = 'acetone', price = 5 },
			{ name = 'water_tank', price = 2500 },
			{ name = 'bookbag', price = 1000 },
			{ name = 'metal_shovel', price = 500 }
		}, locations = {
			vec3(-3152.89, 1109.99, 20.87),
			vec3(2747.71, 3472.85, 55.67),
			vec3(158.024, 6651.772, 31.667)
		}
	},

	Leisure = {
		name = 'Leisure Shop',
		blip = {
			id = 52, colour = 69, scale = 0.4
		}, inventory = {
			{ name = 'parachute', price = 50 },
			{ name = 'binoculars', price = 25 },
			{ name = 'diving_gear', price = 300, metadata = { oxygen = 1800 } },
			{ name = 'huntingbait', price = 25 },
			{ name = 'chlorine_tablet', price = 3 },
			{ name = 'fishingrod', price = 50 },
			{ name = 'fishbait', price = 5 },
			{ name = 'fishicebox', price = 500 },
			{ name = 'bikelock', price = 100 },
			{ name = 'wallet', price = 60 },			
			{ name = 'metaldetector', price = 500 },
			{ name = 'gold_pan', price = 750 },
			{ name = 'bookbag', price = 1000 }
		}, locations = {
			vec3(-1505.91, 1511.95, 115.29)
		}
	},

	DigitalDen = {
		name = 'Digital Den',
		blip = {
			id = 52, colour = 69, scale = 0.4
		}, inventory = {
			{ name = 'phone', price = 45 },
			{ name = 'wallet', price = 110 },			
			{ name = 'radio', price = 500 }
		}, locations = {
			vec3(-658.71, -854.56, 24.5),
			vec3(392.79, -831.88, 29.29),
			vec3(1137.84, -470.69, 66.67),
			vec3(-389.64, 6050.88, 31.5)
		}
	},
	
	FeedStore = {
		name = 'Seed and Feed Store',
		blip = {
			id = 52, colour = 69, scale = 0.4
		}, inventory = {
			{ name = 'wheat_seed', price = 1 },
			{ name = 'corn_seed', price = 1 },
			{ name = 'sugar_cane_seed', price = 1 },
			{ name = 'spices_seed', price = 1 },
			{ name = 'onion_seed', price = 1 },
			{ name = 'lettuce_seed', price = 1 },
			{ name = 'garlic_seed', price = 1 },
			{ name = 'tomato_seed', price = 1 },
			{ name = 'carrot_seed', price = 1 },
			{ name = 'tobacco_seed', price = 1 },
			{ name = 'hops_seed', price = 1 },
			{ name = 'potato_seed', price = 1 },
			{ name = 'rubber_seed', price = 1 },
			{ name = 'plant_nutrition', price = 375 },
			{ name = 'watering_can', price = 275 },
			{ name = 'chlorine_tablet', price = 4 },
			{ name = 'water_bottle', price = 4 },
			{ name = 'cattle_feed', price = 375 },
			{ name = 'potassium', price = 5 }
		}, locations = {
			vec3(1710.35, 4728.49, 42.15)
		}
	},
	
	BusinessImports = {
		name = 'Commercial Imports',
		inventory = {
			{ name = 'raw_fabric', price = 50 },
			{ name = 'fresh_fruits', price = 50 },
			{ name = 'chocolate', price = 50 },
			{ name = 'coffee_grounds', price = 50 },
			{ name = 'raw_salmon', price = 50 },
			{ name = 'raw_shrimp', price = 50 },
			{ name = 'raw_crab', price = 50 },
			{ name = 'glass', price = 50 },
			{ name = 'yeast', price = 8 },
			{ name = 'raw_medical', price = 50 }
		}
	},

	SeedImports = {
		name = 'Seed Imports',
		inventory = {
			{ name = 'weed_legion_diesel_seed', price = 10 },
			{ name = 'weed_sparkplug_seed', price = 10 },
			{ name = 'weed_vss_seed', price = 10 },
			{ name = 'weed_seebeedeebees_seed', price = 10 }
		}
	},

	IllegalImports = {
		name = 'Current Offerings',
		inventory = {
			{ name = 'weed_seed', price = 5 },
			{ name = 'weed_table', price = 750 }
		}
	},

	MovingDealer = {
		name = 'Current Offerings',
		inventory = {
			{ name = 'coke_seed', price = 5 },
			{ name = 'coke_table', price = 750 },
			{ name = 'weapon_sawnoffshotgun', price = 15000 },
			{ name = 'weapon_microsmg', price = 30000 },
			{ name = 'bank_drill', price = 25000 },
			{ name = 'laptop_green', price = 30000 },
		}
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.4
		}, inventory = {
			{ name = 'weapon_knife', price = 500, },
			{ name = 'weapon_bat', price = 150 },
			{ name = 'huntingknife', price = 500, license = 'hunting' },
			{ name = 'weapon_flaregun', price = 500 },
			{ name = 'guncleaningkit', price = 3000 },
			{ name = 'weapon_p226', price = 900, license = 'weapon' },
			{ name = 'weapon_snspistol', price = 700, license = 'weapon' },
			{ name = 'weapon_sniperrifle', price = 1000, license = 'hunting' },
			{ name = 'snp_ammo', price = 100 },
			{ name = 'pistol_ammo', price = 10 },
			{ name = 'rifle_ammo', price = 50 },
			{ name = 'smg_ammo', price = 35 },
			{ name = 'shotgun_ammo', price = 35 },
			{ name = 'flare_ammo', price = 10 },
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19),
			vec3(-1305.8, -394.6, 36.7),
			vec3(-3171.77, 1088.11, 20.84)
		}
	},

	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'kurkakola', price = 5 },
			{ name = 'water_bottle', price = 5 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_soda_01`
		}
	},

	VendingMachineCandy = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'twerks_candy', price = 2 },
			{ name = 'snikkel_candy', price = 2 },
		},
		model = {
			`prop_vend_snak_01`, `prop_vend_snak_01_tu`
		}
	},

	VendingMachineCoffee = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'coffee', price = 5 },
		},
		model = {
			`prop_vend_coffe_01`
		}
	},

	VendingMachineWater = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water_bottle', price = 5 },
		},
		model = {
			`prop_vend_water_01`, `prop_watercooler`, `prop_watercooler_Dark`
		}
	}
}
