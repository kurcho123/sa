Config = Config or {}
Config.Locations = {
    Pharmacy = {
        vector4(303.87, -569.01, 43.28, 338.56), -- Pillbox
        vector4(1843.12, 3682.09, 33.61, 25.91), -- Sandy
        vector4(-254.77, 6326.93, 32.43, 317.68), -- Paleto
        vector4(1207.89, -1472.07, 36.21, 261.42), -- East LS
        vector4(211.96, -1654.79, 31.15, 238.83), -- West LS
    },
    Duty = {
        vector4(307.14, -597.13, 43.78, 343.04), -- Pillbox
        vector4(1831.52, 3678.63, 35.07, 297.31), -- Sandy
        vector4(-254.3, 6330.31, 32.45, 132.8), -- Paleto
    },
    Stash = {
        vector4(303.87, -569.01, 43.28, 338.56), -- Pillbox
        vector4(1836.4, 3685.74, 33.67, 32.29), -- Sandy
        vector4(-258.26, 6332.46, 32.43, 47.11), -- Paleto
        vector4(1207.89, -1472.07, 36.21, 261.42), -- East LS
        vector4(211.96, -1654.79, 31.15, 238.83), -- West LS
    },
    ClothingLocker = {
        vector4(298.1, -598.1, 43.28, 70.0), -- Pillbox
        vector4(341.96, -598.14, 43.08, 75.12), -- Pillbox bathroom for clinic
        vector4(1824.39, 3674.1, 34.27, 30.0), -- Sandy
        vector4(-256.07, 6327.91, 32.43, 314.68), -- Paleto
        vector4(1212.31, -1474.87, 34.86, -269.85), -- East LS
        vector4(213.63, -1660.14, 29.8, 228.51), -- West LS
    },
    Boss = {
        vector4(339.4, -590.6, 43.28, 72.0), -- Pillbox
    },
    Garage = {
        {
            vector4(320.93, -553.33, 28.74, 270.73),
            vector4(320.52, -547.92, 28.74, 269.84),
            vector4(320.8, -542.81, 28.74, 276.46),
        },
        {
            vector4(1871.13, 3704.19, 33.54, 207.59),
            vector4(1874.03, 3705.97, 33.55, 207.77),
            vector4(1877.06, 3707.94, 33.55, 204.59),
            vector4(1879.52, 3689.54, 33.54, 26.98),
            vector4(1882.51, 3691.24, 33.54, 33.21),
        },
        {
            vector4(-268.29, 6337.56, 32.43, 266.34),
            vector4(-265.17, 6341.06, 32.43, 262.64),
            vector4(-262.19, 6344.19, 32.43, 270.46),
            vector4(-259.01, 6347.89, 32.43, 266.64),
        },
        {
            vector4(1196.86, -1454.46, 34.95, 0.74),
            vector4(1200.9, -1454.46, 34.97, 0.74),
            vector4(1204.74, -1454.46, 34.99, 0.74),
        },
        {
            vector4(200.85, -1674.83, 29.8, 235.01),
            vector4(185.12, -1663.82, 29.8, 235.01),
        },
        {
            vector4(-451.59, 5994.01, 31.34, 87.06), --paleto heli
            vector4(-454.24, 5998.34, 31.34, 87.19),
        },
    },
    HelicopterGarage = {
        vector4(351.58, -587.45, 74.16, 160.5),
        vector4(-475.43, 5988.353, 31.716, 31.34),
    },
    BoatGarage = {
        {marker = vector4(-781.21, -1440.52, 1.6, 45.86), spawn = vector4(-785.04, -1437.89, 1.6, 138.86)}, -- city
        {marker = vector4(1480.16, 3779.55, 31.75, 28.96), spawn = vector4(1476.63, 3785.45, 31.75, 106.95)}, -- sandy
        {marker = vector4(-284.79, 6627.37, 7.2, 134.71), spawn = vector4(-290.51, 6621.71, 2.14, 134.71)}, -- paleto
    },
}
Config.Helicopter = joaat('aw139')
Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
		["ambulance2"] = "Ambulance",
        ["16fire"] = "Explorer",
        ["arroweng"] = "Engine",
        ["arrowladder"] = "Ladder",
        ["16fireec"] = "Tesla",
	},
	-- Grade 1
	[1] = {
		["ambulance2"] = "Ambulance",
        ["16fire"] = "Explorer",
        ["arroweng"] = "Engine",
        ["arrowladder"] = "Ladder",
        ["16fireec"] = "Tesla",
	},
	-- Grade 2
	[2] = {
		["ambulance2"] = "Ambulance",
        ["16fire"] = "Explorer",
        ["arroweng"] = "Engine",
        ["arrowladder"] = "Ladder",
        ["16fireec"] = "Tesla",
	},
	-- Grade 3
	[3] = {
		["ambulance2"] = "Ambulance",
        ["16fire"] = "Explorer",
        ["arroweng"] = "Engine",
        ["arrowladder"] = "Ladder",
        ["16fireec"] = "Tesla",
	},
	-- Grade 4
	[4] = {
		["ambulance2"] = "Ambulance",
        ["16fire"] = "Explorer",
        ["arroweng"] = "Engine",
        ["arrowladder"] = "Ladder",
        ["16fireec"] = "Tesla",
	}
}

Config.PurchasableVehicles = {
	["pillbox"] = {
		["ambulance2"] = {name = "Ambulance", price = 1200},
        ["16fire"] = {name = "Explorer", price = 15000},
        ["16fireec"] = {name = "Tesla", price = 60000},
	},
	["sandy"] = {
		["ambulance2"] = {name = "Ambulance", price = 1200},
        ["16fire"] = {name = "Explorer", price = 15000},
	},
	["paleto"] = {
		["ambulance2"] = {name = "Ambulance", price = 1200},
        ["16fire"] = {name = "Explorer", price = 15000},
	},
    ["elsfirestation"] = {
		["ambulance2"] = {name = "Ambulance", price = 1200},
        ["16fire"] = {name = "Explorer", price = 15000},
	},
}