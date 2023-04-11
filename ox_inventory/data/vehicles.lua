return {
	-- 0	vehicle has no storage
	-- 1	vehicle has no trunk storage
	-- 2	vehicle has no glovebox storage
	-- 3	vehicle has trunk in the hood
	Storage = {
		[`jester`] = 3,
		[`adder`] = 3,
		[`osiris`] = 1,
		[`pfister811`] = 1,
		[`penetrator`] = 1,
		[`autarch`] = 1,
		[`bullet`] = 1,
		[`cheetah`] = 1,
		[`cyclone`] = 1,
		[`voltic`] = 1,
		[`reaper`] = 3,
		[`entityxf`] = 1,
		[`t20`] = 1,
		[`taipan`] = 1,
		[`tezeract`] = 1,
		[`torero`] = 3,
		[`turismor`] = 1,
		[`fmj`] = 1,
		[`infernus`] = 1,
		[`italigtb`] = 3,
		[`italigtb2`] = 3,
		[`nero2`] = 1,
		[`vacca`] = 3,
		[`vagner`] = 1,
		[`visione`] = 1,
		[`prototipo`] = 1,
		[`zentorno`] = 1,
		[`trophytruck`] = 0,
		[`trophytruck2`] = 0,
	},

	-- slots, maxWeight; default weight is 8000 per slot
	glovebox = {
		[0] = {5, 25000},		-- Compact
		[1] = {5, 25000},		-- Sedan
		[2] = {5, 25000},		-- SUV
		[3] = {5, 25000},		-- Coupe
		[4] = {5, 25000},		-- Muscle
		[5] = {5, 25000},		-- Sports Classic
		[6] = {5, 25000},		-- Sports
		[7] = {5, 25000},		-- Super
		[8] = {5, 15000},		-- Motorcycle
		[9] = {5, 25000},		-- Offroad
		[10] = {5, 25000},		-- Industrial
		[11] = {5, 25000},		-- Utility
		[12] = {5, 25000},		-- Van
		[14] = {25, 150000},	-- Boat
		[15] = {25, 150000},	-- Helicopter
		[16] = {25, 408000},	-- Plane
		[17] = {5, 25000},		-- Service
		[18] = {5, 25000},		-- Emergency
		[19] = {5, 25000},		-- Military
		[20] = {5, 25000},		-- Commercial (trucks)
		models = {},
		boneIndex = {},
	},

	trunk = {
		[0] = {10, 38000},		-- Compact
		[1] = {10, 50000},		-- Sedan
		[2] = {10, 75000},		-- SUV
		[3] = {10, 42000},		-- Coupe
		[4] = {10, 38000},		-- Muscle
		[5] = {10, 30000},		-- Sports Classic
		[6] = {10, 30000},		-- Sports
		[7] = {10, 30000},		-- Super
		[8] = {10, 15000},		-- Motorcycle
		[9] = {10, 60000},		-- Offroad
		[10] = {10, 80000},	-- Industrial
		[11] = {10, 80000},	-- Utility
		[12] = {10, 120000},	-- Van
		-- [14] -- Boat
		-- [15] -- Helicopter
		-- [16] -- Plane
		[17] = {10, 30000},	-- Service
		[18] = {10, 30000},	-- Emergency
		[19] = {10, 30000},	-- Military
		[20] = {10, 750000},	-- Commercial
		models = {
			[`nspeedo`] = {30, 750000},
			[`dloader`] = {25, 150000}
		},
		boneIndex = {
			[`pounder`] = 'wheel_rr',
			[`pounder2`] = 'wheel_rr',
			[`nspeedo`] = 'door_pside_r'
		},
		open = {
			[`nspeedo`] = {2, 3}
		}
	}
}
