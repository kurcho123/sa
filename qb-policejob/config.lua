Config = {}
Config.ShowTargetZones = false

Config.GPSItem = 'radio' -- Item to enable LEO blips
Config.Objects = {
    ["cone"] = {model = 'prop_roadcone02a', freeze = false},
    ["barier"] = {model = 'prop_barrier_work06a', freeze = true},
    ["schotten"] = {model = 'prop_snow_sign_road_06g', freeze = true},
    ["tent"] = {model = 'prop_gazebo_03', freeze = true},
    ["light"] = {model = 'prop_worklight_03b', freeze = true},
}

Config.Locations = {
    ["vehicle"] = {
        ["mrpd"] = {
           vector4(445.89, -996.9, 25.7, 270.53),
           vector4(445.89, -994.26, 25.7, 270.53),
           vector4(445.89, -991.59, 25.7, 270.53),
           vector4(445.89, -988.89, 25.7, 270.53),
           vector4(445.89, -986.13, 25.7, 270.53)

        },
        ["sandy"] = {
           vector4(1871.13, 3704.19, 33.54, 207.59),
           vector4(1874.03, 3705.97, 33.55, 207.77),
           vector4(1877.06, 3707.94, 33.55, 204.59),
           vector4(1879.52, 3689.54, 33.54, 26.98),
           vector4(1882.51, 3691.24, 33.54, 33.21),
        },
        ["davis"] = {
           vector4(386.94, -1615.22, 29.29, 225.16),
           vector4(388.74, -1612.92, 29.29, 230.71),
           vector4(390.87, -1610.59, 29.29, 239.73),
           vector4(392.87, -1608.1, 29.29, 235.45),
           vector4(403.19, -1616.74, 29.29, 52.48),
           vector4(401.03, -1619.02, 29.29, 46.49),
        },
        ["paleto"] = {
            vector4(-451.59, 5994.01, 31.34, 87.06),
            vector4(-454.24, 5998.34, 31.34, 87.19),
         },
    },
    ["boat"] = {
        [1] = {marker = vector4(-781.21, -1440.52, 1.6, 45.86), spawn = vector4(-785.04, -1437.89, 1.6, 138.86)}, -- city
        [2] = {marker = vector4(1480.16, 3779.55, 31.75, 28.96), spawn = vector4(1476.63, 3785.45, 31.75, 106.95)}, -- sandy
        [3] = {marker = vector4(-284.79, 6627.37, 7.2, 134.71), spawn = vector4(-290.51, 6621.71, 2.14, 134.71)}, -- paleto
    },
    ["fingerprint"] = {
        [1] = vector3(473.19, -1007.55, 26.27), -- MRPD
        [2] = vector3(1845.2, 3692.61, 34.22), -- Sandy
        [3] = vector3(380.04, -1602.85, 25.45), -- Davis
    },
    ["stash"] = {
        [1] = vector3(447.75, -996.82, 30.69), -- MRPD
        [2] = vector3(1846.63, 3690.95, 38.22), -- Sandy
        [3] = vector3(379.61, -1609.68, 30.2), -- Davis
    },
    ["impound"] = {
        [1] = vector4(-139.89, -1170.55, 23.77, 175.38),
        [2] = vector4(402.9, -1651.24, 29.29, 323.35),
    },
    ["evidence"] = {
       [1] = vector3(473.97, -995.3, 26.27), -- MRPD
       [2] = vector3(1857.92, 3691.23, 29.82), -- Sandy
       [3] = vector3(360.43, -1601.42, 25.45), -- Davis
    },
    ["evidence2"] = {
       [1] = vector3(481.26, -991.6, 30.69),
    },
    ["evidence3"] = {
       [1] = vector3(-522.51, -182.04, 38.22),
    },
    ["stations"] = {
       [1] = {label = "Misson Row PD - LSPD", coords = vector4(428.23, -984.28, 29.76, 3.5), sprite = 526, color = 38},
       [2] = {label = "Sandy Shores Station - BCSO", coords = vector4(1852.8, 3688.51, 34.22, 213.68), sprite = 526, color = 25},
       [3] = {label = "Davis Outpost #143 - SAST/COMMAND/MARSHALS", coords = vector3(373.25, -1601.9, 30.05), sprite = 58, color = 39},
       [4] = {label = "Boilingbroke Penitentiary", coords = vector4(1845.903, 2585.873, 45.672, 272.249), sprite = 285, color = 6},
       [5] = {label = "Police Dock", coords = vector4(-781.21, -1440.52, 1.6, 45.86), sprite = 410, color = 38, policeOnly = true},
       [6] = {label = "Police Dock", coords = vector4(1480.16, 3779.55, 31.75, 28.96), sprite = 410, color = 38, policeOnly = true},
       [7] = {label = "Police Dock", coords = vector4(-284.79, 6627.37, 7.2, 134.71), sprite = 410, color = 38, policeOnly = true},
    },
}

Config.ArmoryWhitelist = {}

Config.Helicopters = {
    [1] = {name = "Phoenix 1", model = "as350"},
    [2] = {name = "Swat", model = "littlebird"}
}

Config.Boats = {
    [1] = {name = "Police Defender", model = "poldef"},
    [2] = {name = "Police Response Boat", model = "rbsheriff"}
}

Config.SecurityCameras = {
    hideradar = false,
    cameras = {
        [1] = {label = "Pacific Bank CAM#1", coords = vector3(257.45, 210.07, 109.08), r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false, isOnline = true},
        [2] = {label = "Pacific Bank CAM#2", coords = vector3(232.86, 221.46, 107.83), r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false, isOnline = true},
        [3] = {label = "Pacific Bank CAM#3", coords = vector3(252.27, 225.52, 103.99), r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false, isOnline = true},
        [4] = {label = "Limited Ltd Grove St. CAM#1", coords = vector3(-53.1433, -1746.714, 31.546), r = {x = -35.0, y = 0.0, z = -168.9182}, canRotate = false, isOnline = true},
        [5] = {label = "Rob's Liqour Prosperity St. CAM#1", coords = vector3(-1482.9, -380.463, 42.363), r = {x = -35.0, y = 0.0, z = 79.53281}, canRotate = false, isOnline = true},
        [6] = {label = "Rob's Liqour San Andreas Ave. CAM#1", coords = vector3(-1224.874, -911.094, 14.401), r = {x = -35.0, y = 0.0, z = -6.778894}, canRotate = false, isOnline = true},
        [7] = {label = "Limited Ltd Ginger St. CAM#1", coords = vector3(-718.153, -909.211, 21.49), r = {x = -35.0, y = 0.0, z = -137.1431}, canRotate = false, isOnline = true},
        [8] = {label = "24/7 Supermarkt Innocence Blvd. CAM#1", coords = vector3(23.885, -1342.441, 31.672), r = {x = -35.0, y = 0.0, z = -142.9191}, canRotate = false, isOnline = true},
        [9] = {label = "Rob's Liqour El Rancho Blvd. CAM#1", coords = vector3(1133.024, -978.712, 48.515), r = {x = -35.0, y = 0.0, z = -137.302}, canRotate = false, isOnline = true},
        [10] = {label = "Limited Ltd West Mirror Drive CAM#1", coords = vector3(1151.93, -320.389, 71.33), r = {x = -35.0, y = 0.0, z = -119.4468}, canRotate = false, isOnline = true},
        [11] = {label = "24/7 Supermarkt Clinton Ave CAM#1", coords = vector3(383.402, 328.915, 105.541), r = {x = -35.0, y = 0.0, z = 118.585}, canRotate = false, isOnline = true},
        [12] = {label = "Limited Ltd Banham Canyon Dr CAM#1", coords = vector3(-1832.057, 789.389, 140.436), r = {x = -35.0, y = 0.0, z = -91.481}, canRotate = false, isOnline = true},
        [13] = {label = "Rob's Liqour Great Ocean Hwy CAM#1", coords = vector3(-2966.15, 387.067, 17.393), r = {x = -35.0, y = 0.0, z = 32.92229}, canRotate = false, isOnline = true},
        [14] = {label = "24/7 Supermarkt Ineseno Road CAM#1", coords = vector3(-3046.749, 592.491, 9.808), r = {x = -35.0, y = 0.0, z = -116.673}, canRotate = false, isOnline = true},
        [15] = {label = "24/7 Supermarkt Barbareno Rd. CAM#1", coords = vector3(-3246.489, 1010.408, 14.705), r = {x = -35.0, y = 0.0, z = -135.2151}, canRotate = false, isOnline = true},
        [16] = {label = "24/7 Supermarkt Route 68 CAM#1", coords = vector3(539.773, 2664.904, 44.056), r = {x = -35.0, y = 0.0, z = -42.947}, canRotate = false, isOnline = true},
        [17] = {label = "Rob's Liqour Route 68 CAM#1", coords = vector3(1169.855, 2711.493, 40.432), r = {x = -35.0, y = 0.0, z = 127.17}, canRotate = false, isOnline = true},
        [18] = {label = "24/7 Supermarkt Senora Fwy CAM#1", coords = vector3(2673.579, 3281.265, 57.541), r = {x = -35.0, y = 0.0, z = -80.242}, canRotate = false, isOnline = true},
        [19] = {label = "24/7 Supermarkt Alhambra Dr. CAM#1", coords = vector3(1966.24, 3749.545, 34.143), r = {x = -35.0, y = 0.0, z = 163.065}, canRotate = false, isOnline = true},
        [20] = {label = "24/7 Supermarkt Senora Fwy CAM#2", coords = vector3(1729.522, 6419.87, 37.262), r = {x = -35.0, y = 0.0, z = -160.089}, canRotate = false, isOnline = true},
        [21] = {label = "Fleeca Bank Hawick Ave CAM#1", coords = vector3(309.341, -281.439, 55.88), r = {x = -35.0, y = 0.0, z = -146.1595}, canRotate = false, isOnline = true},
        [22] = {label = "Fleeca Bank Legion Square CAM#1", coords = vector3(144.871, -1043.044, 31.017), r = {x = -35.0, y = 0.0, z = -143.9796}, canRotate = false, isOnline = true},
        [23] = {label = "Fleeca Bank Hawick Ave CAM#2", coords = vector3(-355.7643, -52.506, 50.746), r = {x = -35.0, y = 0.0, z = -143.8711}, canRotate = false, isOnline = true},
        [24] = {label = "Fleeca Bank Del Perro Blvd CAM#1", coords = vector3(-1214.226, -335.86, 39.515), r = {x = -35.0, y = 0.0, z = -97.862}, canRotate = false, isOnline = true},
        [25] = {label = "Fleeca Bank Great Ocean Hwy CAM#1", coords = vector3(-2958.885, 478.983, 17.406), r = {x = -35.0, y = 0.0, z = -34.69595}, canRotate = false, isOnline = true},
        [26] = {label = "Paleto Bank CAM#1", coords = vector3(-102.939, 6467.668, 33.424), r = {x = -35.0, y = 0.0, z = 24.66}, canRotate = false, isOnline = true},
        [27] = {label = "Del Vecchio Liquor Paleto Bay", coords = vector3(-163.75, 6323.45, 33.424), r = {x = -35.0, y = 0.0, z = 260.00}, canRotate = false, isOnline = true},
        [28] = {label = "Don's Country Store Paleto Bay CAM#1", coords = vector3(166.42, 6634.4, 33.69), r = {x = -35.0, y = 0.0, z = 32.00}, canRotate = false, isOnline = true},
        [29] = {label = "Don's Country Store Paleto Bay CAM#2", coords = vector3(163.74, 6644.34, 33.69), r = {x = -35.0, y = 0.0, z = 168.00}, canRotate = false, isOnline = true},
        [30] = {label = "Don's Country Store Paleto Bay CAM#3", coords = vector3(169.54, 6640.89, 33.69), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = false, isOnline = true},
        [31] = {label = "Vangelico Jewelery CAM#1", coords = vector3(-627.54, -239.74, 40.33), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
        [32] = {label = "Vangelico Jewelery CAM#2", coords = vector3(-627.51, -229.51, 40.24), r = {x = -35.0, y = 0.0, z = -95.78}, canRotate = true, isOnline = true},
        [33] = {label = "Vangelico Jewelery CAM#3", coords = vector3(-620.3, -224.31, 40.23), r = {x = -35.0, y = 0.0, z = 165.78}, canRotate = true, isOnline = true},
        [34] = {label = "Vangelico Jewelery CAM#4", coords = vector3(-622.57, -236.3, 40.31), r = {x = -35.0, y = 0.0, z = 5.78}, canRotate = true, isOnline = true},
    },
}

Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 1
	[1] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",

	},
	-- Grade 2
	[2] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 3
	[3] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	},
	-- Grade 4
	[4] = {
		["police"] = "Police Car 1",
		["police2"] = "Police Car 2",
		["police3"] = "Police Car 3",
		["police4"] = "Police Car 4",
		["policeb"] = "Police Car 5",
		["policet"] = "Police Car 6",
		["sheriff"] = "Sheriff Car 1",
		["sheriff2"] = "Sheriff Car 2",
	}
}

Config.PoolVehicles = {
	["mrpd"] = {
		["11cvpiw"] = {name = "Crown Victoria Police Interceptor", price = 8000},
        ["leg18taurus"] = {name = "Ford Taurus", price = 12500},
        ["leg21durango"] = {name = "Dodge Durango", price = 14000},
        ["umkbuffalo"] = {name = "Unmarked Buffalo", price = 25000},
	},
	["sandy"] = {
		["11cvpiw"] = {name = "Crown Victoria Police Interceptor", price = 8000},
        ["leg18taurus"] = {name = "Ford Taurus", price = 12500},
        ["leg21durango"] = {name = "Dodge Durango", price = 14000},
        ["umkbuffalo"] = {name = "Unmarked Buffalo", price = 25000},
	},
	["davis"] = {
		["11cvpiw"] = {name = "Crown Victoria Police Interceptor", price = 8000},
        ["leg18taurus"] = {name = "Ford Taurus", price = 12500},
        ["leg21durango"] = {name = "Dodge Durango", price = 14000},
        ["umkbuffalo"] = {name = "Unmarked Buffalo", price = 25000},
	},
}

Config.PersonalVehicles = {
	["mrpd"] = {
		["11cvpiw"] = {name = "Crown Victoria Police Interceptor", price = 40000},
        ["leg18taurus"] = {name = "Ford Taurus", price = 60000},
        ["umkbuffalo"] = {name = "Unmarked Buffalo", price = 65000},
	},
	["sandy"] = {
		["11cvpiw"] = {name = "Crown Victoria Police Interceptor", price = 40000},
        ["leg18taurus"] = {name = "Ford Taurus", price = 60000},
        ["umkbuffalo"] = {name = "Unmarked Buffalo", price = 65000},
	},
	["davis"] = {
		["11cvpiw"] = {name = "Crown Victoria Police Interceptor", price = 40000},
        ["leg18taurus"] = {name = "Ford Taurus", price = 60000},
        ["umkbuffalo"] = {name = "Unmarked Buffalo", price = 65000},
	},
}

Config.AmmoLabels = {
    ["AMMO_PISTOL"] = "9x19mm parabellum bullet",
    ["AMMO_SMG"] = "9x19mm parabellum bullet",
    ["AMMO_RIFLE"] = "7.62x39mm bullet",
    ["AMMO_MG"] = "7.92x57mm mauser bullet",
    ["AMMO_SHOTGUN"] = "12-gauge bullet",
    ["AMMO_SNIPER"] = "Large caliber bullet",
}

Config.Radars = {
	vector4(-623.44421386719, -823.08361816406, 25.25704574585, 145.0),
	vector4(-652.44421386719, -854.08361816406, 24.55704574585, 325.0),
	vector4(1623.0114746094, 1068.9924316406, 80.903594970703, 84.0),
	vector4(-2604.8994140625, 2996.3391113281, 27.528566360474, 175.0),
	vector4(2136.65234375, -591.81469726563, 94.272926330566, 318.0),
	vector4(2117.5764160156, -558.51013183594, 95.683128356934, 158.0),
	vector4(406.89505004883, -969.06286621094, 29.436267852783, 33.0),
	vector4(657.315, -218.819, 44.06, 320.0),
	vector4(2118.287, 6040.027, 50.928, 172.0),
	vector4(-106.304, -1127.5530, 30.778, 230.0),
	vector4(-823.3688, -1146.980, 8.0, 300.0),
}

Config.CarItems = {
    [1] = {
        name = "empty_evidence_bag",
        amount = 10,
        info = {},
        type = "item",
        slot = 1,
    },
    [2] = {
        name = "WEAPON_FIREEXTINGUISHER",
        amount = 1,
        info = {},
        type = "item",
        slot = 2,
    },
}

Config.Armory = {
    label = "Police Armory",
    items = {
        [1] = {
            name = "weapon_nightstick",
            price = 10,
            amount = 1,
        },
        [2] = {
            name = "weapon_stungun",
            price = 25,
            amount = 1,
        },
        [3] = {
            name = "weapon_g17",
            price = 100,
            amount = 3,
        },
        [4] = {
            name = "weapon_fbiarb",
            price = 250,
            amount = 2,
        },
        [5] = {
            name = "heavyarmor",
            price = 50,
            amount = 20,
        },
        [6] = {
            name = "pistol_ammo",
            price = 3,
            amount = 20,
        },
        [7] = {
            name = "taser_ammo",
            price = 3,
            amount = 20,
        },
        [8] = {
            name = "rifle_ammo",
            price = 15,
            amount = 20,
        },
        [9] = {
            name = "handcuffs",
            price = 25,
            amount = 1,
        },
        [10] = {
            name = "weapon_flashlight",
            price = 10,
            amount = 1,
        },
        [11] = {
            name = "radio",
            price = 5,
            amount = 1,
        },
        [12] = {
            name = "ifak",
            price = 15,
            amount = 5,
        },
        [13] = {
            name = "empty_evidence_bag",
            price = 0,
            amount = 50,
        },
        [14] = {
            name = "police_stormram",
            price = 10,
            amount = 3,
        },
        [15] = {
            name = "pdcamera",
            price = 35,
            amount = 3,
        },
        [16] = {
            name = "dnatestingkit",
            price = 5,
            amount = 5,
        },
        [17] = {
            name = "spikestrip",
            price = 20,
            amount = 20,
        },
        [18] = {
            name = "breaching_charge",
            price = 150,
            amount = 20,
        },
        [19] = {
            name = "parachute",
            price = 15,
            amount = 1,
        },
        [21] = {
            name = "megaphone",
            price = 2500,
            amount = 1,
        },
        [22] = {
            name = "flashlight",
            price = 50,
            amount = 1,
        },
    }
}

Config.DeathClasses = {
    ['SMALL_CALIBER'] = '9mm bullet impact sites',
    ['MEDIUM_CALIBER'] = '5.56 or 45 ACP caliber bullet impact sites',
    ['HIGH_CALIBER'] = '7.62 or larger caliber bullet impact sites',
    ['SHOTGUN'] = 'Small shotgun pellets',
    ['CUTTING'] = 'Stab wounds or cuts',
    ['LIGHT_IMPACT'] = 'Light blunt force trauma',
    ['HEAVY_IMPACT'] = 'Heavy blunt force trauma',
    ['EXPLOSIVE'] = 'Explosive residue and burn marks',
    ['FIRE'] = 'Burn marks',
    ['SUFFOCATING'] = 'Unknown causes',
    ['OTHER'] = 'Unknown causes',
    ['WILDLIFE'] = 'Claw marks and bite marks',
    ['NOTHING'] = 'Unknown causes'
}

Config.DeathCauses = {
    [`WEAPON_STUNGUN`] = Config.DeathClasses['NONE'],
    [`WEAPON_SNSPISTOL_MK2`] = Config.DeathClasses['NONE'], -- Paintball

    --[[ Small Caliber ]]--
    [`WEAPON_PISTOL`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_COMBATPISTOL`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_APPISTOL`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_COMBATPDW`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_MACHINEPISTOL`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_MICROSMG`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_MINISMG`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_PISTOL_MK2`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_SNSPISTOL`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_VINTAGEPISTOL`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_G17`] = Config.DeathClasses['SMALL_CALIBER'],
    [`WEAPON_P226`] = Config.DeathClasses['SMALL_CALIBER'],

    --[[ Medium Caliber ]]--
    [`WEAPON_ADVANCEDRIFLE`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_ASSAULTSMG`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_BULLPUPRIFLE`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_BULLPUPRIFLE_MK2`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_CARBINERIFLE`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_CARBINERIFLE_MK2`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_COMPACTRIFLE`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_DOUBLEACTION`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_GUSENBERG`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_HEAVYPISTOL`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_MARKSMANPISTOL`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_PISTOL50`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_REVOLVER`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_REVOLVER_MK2`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_SMG`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_SMG_MK2`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_SPECIALCARBINE`] = Config.DeathClasses['MEDIUM_CALIBER'],
    [`WEAPON_SPECIALCARBINE_MK2`] = Config.DeathClasses['MEDIUM_CALIBER'],

    --[[ High Caliber ]]--
    [`WEAPON_ASSAULTRIFLE`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_ASSAULTRIFLE_MK2`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_COMBATMG`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_COMBATMG_MK2`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYSNIPER`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYSNIPER_MK2`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_MARKSMANRIFLE`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_MARKSMANRIFLE_MK2`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_MG`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_MINIGUN`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_MUSKET`] = Config.DeathClasses['HIGH_CALIBER'],
    [`WEAPON_RAILGUN`] = Config.DeathClasses['HIGH_CALIBER'],

    --[[ Shotguns ]]--
    [`WEAPON_ASSAULTSHOTGUN`] = Config.DeathClasses['SHOTGUN'],
    [`WEAPON_BULLUPSHOTGUN`] = Config.DeathClasses['SHOTGUN'],
    [`WEAPON_DBSHOTGUN`] = Config.DeathClasses['SHOTGUN'],
    [`WEAPON_HEAVYSHOTGUN`] = Config.DeathClasses['SHOTGUN'],
    [`WEAPON_PUMPSHOTGUN`] = Config.DeathClasses['SHOTGUN'],
    [`WEAPON_PUMPSHOTGUN_MK2`] = Config.DeathClasses['SHOTGUN'],
    [`WEAPON_SAWNOFFSHOTGUN`] = Config.DeathClasses['SHOTGUN'],
    [`WEAPON_SWEEPERSHOTGUN`] = Config.DeathClasses['SHOTGUN'],

    --[[ Animals ]]--
    [`WEAPON_ANIMAL`] = Config.DeathClasses['WILDLIFE'], -- Animal
    [`WEAPON_COUGAR`] = Config.DeathClasses['WILDLIFE'], -- Cougar
    [`WEAPON_BARBED_WIRE`] = Config.DeathClasses['WILDLIFE'], -- Barbed Wire

    --[[ Cutting Weapons ]]--
    [`WEAPON_BATTLEAXE`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_BOTTLE`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_DAGGER`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_HATCHET`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_KNIFE`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_MACHETE`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_SWITCHBLADE`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_KATANA`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_RAINBOW`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_HATCHET_SMITHS`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_GUTKNIFE`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_BUTTERFLY`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_KARAMBIT`] = Config.DeathClasses['CUTTING'],
    [`WEAPON_STATGEAR`] = Config.DeathClasses['CUTTING'],

    --[[ Light Impact ]]--
    [`WEAPON_KNUCKLE`] = Config.DeathClasses['LIGHT_IMPACT'],
    [`WEAPON_UNARMED`] = Config.DeathClasses['LIGHT_IMPACT'],

    --[[ Heavy Impact ]]--
    [`WEAPON_BAT`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_CROWBAR`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_FIREEXTINGUISHER`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_FIRWORK`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_GOLFLCUB`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_HAMMER`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_PETROLCAN`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_POOLCUE`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_WRENCH`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_RAMMED_BY_CAR`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_RUN_OVER_BY_CAR`] = Config.DeathClasses['HEAVY_IMPACT'],
    [`WEAPON_COLBATON`] = Config.DeathClasses['HEAVY_IMPACT'],

    --[[ Explosives ]]--
    [`WEAPON_EXPLOSION`] = Config.DeathClasses['EXPLOSIVE'],
    [`WEAPON_GRENADE`] = Config.DeathClasses['EXPLOSIVE'],
    [`WEAPON_COMPACTLAUNCHER`] = Config.DeathClasses['EXPLOSIVE'],
    [`WEAPON_HOMINGLAUNCHER`] = Config.DeathClasses['EXPLOSIVE'],
    [`WEAPON_PIPEBOMB`] = Config.DeathClasses['EXPLOSIVE'],
    [`WEAPON_PROXMINE`] = Config.DeathClasses['EXPLOSIVE'],
    [`WEAPON_RPG`] = Config.DeathClasses['EXPLOSIVE'],
    [`WEAPON_STICKYBOMB`] = Config.DeathClasses['EXPLOSIVE'],
    [`WEAPON_HELI_CRASH`] = Config.DeathClasses['EXPLOSIVE'],

    --[[ Other ]]--
    [`WEAPON_FALL`] = Config.DeathClasses['OTHER'], -- Fall
    [`WEAPON_HIT_BY_WATER_CANNON`] = Config.DeathClasses['OTHER'], -- Water Cannon

    --[[ Fire ]]--
    [`WEAPON_ELECTRIC_FENCE`] = Config.DeathClasses['FIRE'],
    [`WEAPON_FIRE`] = Config.DeathClasses['FIRE'],
    [`WEAPON_MOLOTOV`] = Config.DeathClasses['FIRE'],
    [`WEAPON_FLARE`] = Config.DeathClasses['FIRE'],
    [`WEAPON_FLAREGUN`] = Config.DeathClasses['FIRE'],

    --[[ Suffocate ]]--
    [`WEAPON_DROWNING`] = Config.DeathClasses['SUFFOCATING'], -- Drowning
    [`WEAPON_DROWNING_IN_VEHICLE`] = Config.DeathClasses['SUFFOCATING'], -- Drowning Veh
    [`WEAPON_EXHAUSTION`] = Config.DeathClasses['SUFFOCATING'], -- Exhaust
    [`WEAPON_BZGAS`] = Config.DeathClasses['SUFFOCATING'],
    [`WEAPON_SMOKEGRENADE`] = Config.DeathClasses['SUFFOCATING'],
    [`WEAPON_FALL`] = Config.DeathClasses['SUFFOCATING'],
    
}