--[[
    Author: JDev17#8160
    TRANSLATION: 
        To create a new translation file, copy an existing one and rename it to e.g. es (spanish), then translate it and change the imported file in the fxmanifest under shared_scripts.
    GARAGE CONFIGURATION EXAMPLE:
    ['somegarage'] = {
        ['Zone'] = {
            ['Shape'] = { -- Create a polyzone by using '/pzcreate poly', '/pzadd' and '/pzfinish' or '/pzcancel' to cancel it. the newly created polyzone will be in txData/QBCoreFramework_******.base/polyzone_created_zones.txt
            vector2(-1030.4713134766, -3016.3388671875),
            vector2(-970.09686279296, -2914.7397460938),
            vector2(-948.322265625, -2927.9030761718),
            vector2(-950.47174072266, -2941.6584472656),
            vector2(-949.04180908204, -2953.9467773438),
            vector2(-940.78369140625, -2957.2941894532),
            vector2(-943.88732910156, -2964.5512695312),
            vector2(-897.61529541016, -2990.0505371094),
            vector2(-930.01025390625, -3046.0695800782),
            vector2(-942.36407470704, -3044.7858886718),
            vector2(-952.97467041016, -3056.5122070312),
            vector2(-957.11712646484, -3057.0900878906)
            },
            ['minZ'] = 12.5,  -- min height of the parking zone, cannot be the same as maxZ, and must be smaller than maxZ
            ['maxZ'] = 20.0,  -- max height of the parking zone
            -- Important: Make sure the parking zone is high enough - higher than the tallest vehicle and touches the ground (turn on debug to see)
        },
        label = 'Hangar', -- label displayed on phone
        type = 'public', -- 'public', 'job', 'depot' or 'gang'
        showBlip = true, -- optional, when not defined, defaults to false
        blipName = 'Police', -- otional
        blipNumber = 90, -- optional, numbers can be found here: https://docs.fivem.net/docs/game-references/blips/
        blipColor = 69, -- optional, defaults to 3 (Blue), numbers can be found here: https://docs.fivem.net/docs/game-references/blips/
        blipcoords = vector3(-972.66, -3005.4, 13.32), -- blip coordinates
        job = 'police', -- optional, everyone can use it when not defined
        vehicleCategories = {'helicopter', 'plane'}, -- categories defined in VehicleCategories
        drawText = 'Hangar', -- the drawtext text, shown when entering the polyzone of that garage
        ParkingDistance = 10.0 -- Optional ParkingDistance, to override the global ParkingDistance
        SpawnDistance = 5.0 -- Optional SpawnDistance, to override the global SpawnDistance
        debug = false -- will show the polyzone and the parking spots, helpful when creating new garages. If too many garages are set to debug, it will not show all parking lots
        ExitWarpLocations: { -- Optional, Used for e.g. Boat parking, to teleport the player out of the boat to the closest location defined in the list. 
            vector3(-807.15, -1496.86, 1.6),
            vector3(-800.17, -1494.87, 1.6),
            vector3(-792.92, -1492.18, 1.6),
            vector3(-787.58, -1508.59, 1.6),
            vector3(-794.89, -1511.16, 1.6),
            vector3(-800.21, -1513.05, 1.6),
        } 
    },
]]



FuelScript = 'ps-fuel' -- change to ps-fuel if you use ps-fuel or something else if you use any other LegcyFuel compatible script
AutoRespawn = false --True == auto respawn cars that are outside into your garage on script restart, false == does not put them into your garage and players have to go to the impound
SharedGarages = true   --True == Gang and job garages are shared, false == Gang and Job garages are personal
WarpPlayerIntoVehicle = false -- True == Will Warp Player Into their vehicle after pulling it out of garage. False It will spawn on the parking lot / in front of them  (Global, can be overriden by each garage)
HouseParkingDrawText = 'Parking' -- text when driving on to the HOUSE parking lot
ParkingDistance = 2.0 -- Distance to the parking lot when trying to park the vehicle  (Global, can be overriden by each garage)
SpawnDistance = 4.5 -- The maximum distance you can be from a parking spot, to spawn a car (Global, can be overriden by each garage)
DepotPrice = 250.0 -- The price to take out a despawned vehicle from impound.
DrawTextPosition = 'left' -- location of drawtext: left, top, right

-- '/restorelostcars <destination_garage>' allows you to restore cars that have been parked in garages which no longer exist in the config (garage renamed or removed). The restored cars get sent to the destination garage or if left empty to the first garage in the list.
RestoreCommandPermissionLevel = 'god' -- sets the permission level for the above mentioned command

-- Here you can define which category contains which vehicle class. These categories can then be used in the garage config
-- All vehicle classes can be found here: https://docs.fivem.net/natives/?_0x29439776AAA00A62
VehicleCategories = {
    ['car'] = {0,1,2,3,4,5,6,7,9,10,11,12,13,18,19},
    ['motorcycle'] = {8},
    ['boat'] = {14},
    ['helicopter'] = {15},
    ['plane'] = {16},
    ['service'] = {17},
    ['emergency'] = {18},
    ['other'] = {13, 20} -- cycles: 13 - you can move cycles to cars if you want and have anything else like military vehicles in this category
    -- you can also create new / delete or update categories, and use them below in the config. 
}

HouseGarageCategories = {'car', 'motorcycle', 'other'} -- Which categories are allowed to be parked at a house garage


VehicleHeading = 'driverside' -- only used when NO parking spots are defined in the garage config
--[[^^^^^^^^
    'forward' = will face the sameway as the ped
    'driverside' = will put the driver door closets to the ped
    'hood' = will face the hood towards ped
    'passengerside' = will put the passenger door closets to the ped
]]

SharedJobGarages = { -- define the job garages which are shared
    --'pdgarage',
}

Garages = {
    --[[
        types:
        - public
        - job
        - depot
        - mechanic
        vehicleCategories:
        - car
        - motorcycle
        - boat
        - helicopter
        - plane
        - other
    ]]  
    ['cityimpound'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-194.38752746582, -1164.9888916016),
                vector2(-194.43885803223, -1161.0760498047),
                vector2(-187.63911437988, -1161.0333251953),
                vector2(-187.63139343262, -1167.2899169922),
                vector2(-192.22409057617, -1167.4770507813),
                vector2(-192.28872680664, -1164.9576416016)
            },
            ['minZ'] = 23.0,  -- min height of the parking zone
            ['maxZ'] = 25.0,  -- max height of the parking zone
        },
        label = 'City Impound',
        showBlip = true,
        blipcoords = vector3(-189.94, -1163.64, 23.67),
        blipName = 'Impound Lot',
        blipNumber = 68,
        type = 'depot',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Impound',
        debug = false,
        ['ParkingSpots'] = {
            vector4(-209.0, -1169.03, 23.04, 83.82),
            vector4(-197.97, -1174.32, 23.04, 189.51),
            vector4(-194.61, -1174.09, 23.04, 201.51),
            vector4(-191.18, -1174.03, 23.04, 198.09),
            vector4(-187.42, -1174.17, 23.04, 194.17),
            vector4(-184.14, -1173.85, 23.04, 209.22)
        }
    },
    ['harmonyimpound'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(1189.77, 2644.09),
                vector2(1189.85, 2635.1),
                vector2(1185.53, 2636.49),
                vector2(1184.58, 2643.87)
            },
            ['minZ'] = 37.0,  -- min height of the parking zone
            ['maxZ'] = 40.0,  -- max height of the parking zone
        },
        label = 'Harmony Impound',
        showBlip = true,
        blipcoords = vector3(1171.78, 2671.24, 38.38),
        blipName = 'Impound Lot',
        blipNumber = 68,
        type = 'depot',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Impound',
        debug = false,
        ['ParkingSpots'] = {
            vector4(1167.21, 2656.9, 38.03, 267.53),
            vector4(1167.14, 2660.42, 37.99, 272.48),
            vector4(1167.25, 2664.07, 37.95, 272.19),
            vector4(1167.22, 2667.45, 37.86, 268.39)
            -- vector4(1747.86, 3314.47, 41.15, 292.31),
            -- vector4(1747.17, 3318.62, 41.23, 292.69),
            -- vector4(1746.18, 3322.71, 41.19, 293.32),
            -- vector4(1744.79, 3326.97, 41.07, 292.87),
            -- vector4(1746.17, 3332.15, 41.12, 193.3),
            -- vector4(1749.83, 3334.27, 41.16, 208.71)
        }
    },
    ['paletoimpound'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(117.25157928467, 6626.3618164063),
                vector2(109.86758422852, 6634.1762695313),
                vector2(116.83855438232, 6640.9853515625),
                vector2(124.59935760498, 6633.1357421875)
            },
            ['minZ'] = 30.0,  -- min height of the parking zone
            ['maxZ'] = 33.0,  -- max height of the parking zone
        },
        label = 'Paleto Bay Impound',
        showBlip = true,
        blipcoords =vector3(115.6, 6633.78, 32.0),
        blipName = 'Impound Lot',
        blipNumber = 68,
        type = 'depot',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Impound',
        debug = false,
        ['ParkingSpots'] = {
            vector4(140.97, 6635.40, 31.17, 225.88),
            -- vector4(136.28, 6634.39, 31.65, 226.23),
            -- vector4(132.56, 6631.04, 31.69, 221.51),
            -- vector4(129.65, 6628.02, 31.72, 224.42),
            -- vector4(126.81, 6625.17, 31.79, 221.15),
            -- vector4(123.86, 6622.15, 31.82, 226.55),
        }
    },
    ['pillboxlowergarage'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(352.34439086914, -620.59851074219),
                vector2(344.32354736328, -636.03747558594),
                vector2(325.94189453125, -628.93359375),
                vector2(331.88412475586, -613.10968017578)
            },
            ['minZ'] = 28.2,  -- min height of the parking zone
            ['maxZ'] = 31.30,  -- max height of the parking zone
        },
        label = 'Pillbox Lower Parking',
        showBlip = true,
        blipcoords = vector3(341.7, -623.33, 29.29),
        blipName = 'Pillbox Lower Parking',
        blipNumber = 357,
        type = 'public',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(342.07, -632.51, 28.87, 340.17),
            vector4(338.89, -631.43, 28.87, 341.89),
            vector4(335.77, -630.04, 28.87, 340.85),
            vector4(332.61, -628.68, 28.87, 342.74),
            vector4(329.16, -627.36, 28.87, 341.84),
            vector4(346.44, -620.82, 28.87, 157.15),
            vector4(343.13, -619.38, 28.87, 157.56),
            vector4(339.76, -619.01, 28.87, 157.43),
            vector4(336.5, -617.88, 28.87, 162.09),
            vector4(333.34, -616.15, 28.87, 160.22),
            vector4(269.97, -322.62, 44.5, 248.07),
        }
    },
    ['mirrorpark'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(1043.447265625, -767.26947021484),
                vector2(1049.4702148438, -769.44775390625),
                vector2(1049.4797363281, -794.31622314453),
                vector2(1048.9655761719, -794.32214355469),
                vector2(1049.03125, -793.87451171875),
                vector2(1043.466796875, -793.80151367188),
                vector2(1043.3436279297, -794.52691650391),
                vector2(1031.5026855469, -794.34808349609),
                vector2(1007.7255859375, -764.88061523438),
                vector2(1022.2494506836, -752.11022949219),
                vector2(1025.6563720703, -755.25653076172),
                vector2(1030.9210205078, -758.50311279297),
                vector2(1031.2462158203, -758.19201660156),
                vector2(1035.1042480469, -760.79956054688),
                vector2(1030.6268310547, -767.16302490234),
                vector2(1025.9473876953, -763.81085205078),
                vector2(1024.8063964844, -765.39245605469),
                vector2(1033.9915771484, -772.05816650391),
                vector2(1036.6497802734, -781.24871826172),
                vector2(1038.708984375, -780.87786865234),
                vector2(1035.7690429688, -770.72528076172),
                vector2(1032.0593261719, -768.04278564453),
                vector2(1034.0390625, -764.51586914062),
                vector2(1036.8060302734, -766.30773925781),
                vector2(1038.0424804688, -763.41851806641),
                vector2(1043.5157470703, -766.21325683594)
            },
            ['minZ'] = 56.50,
            ['maxZ'] = 59.20
        },
        label = 'Mirror Park Parking',
        showBlip = true,
        blipcoords = vector3(1037.65, -771.62, 58.01),
        blipName = 'Mirror Park Parking',
        blipNumber = 357,
        type = 'public',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(1023.5, -756.15, 57.48, 225.44),
            vector4(1020.64, -758.19, 57.49, 225.22),
            vector4(1017.57, -760.75, 57.47, 222.83),
            vector4(1014.9, -763.11, 57.4, 223.82),
            vector4(1016.1, -770.57, 57.41, 311.2),
            vector4(1018.8, -773.42, 57.43, 308.15),
            vector4(1020.68, -776.34, 57.39, 311.86),
            vector4(1023.75, -779.38, 57.41, 309.66),
            vector4(1025.72, -782.07, 57.4, 308.8),
            vector4(1028.49, -784.92, 57.41, 307.36),
            vector4(1030.06, -787.96, 57.38, 310.65),
            vector4(1038.12, -791.16, 57.47, 1.48),
            vector4(1046.49, -785.56, 57.5, 89.6),
            vector4(1046.38, -782.01, 57.51, 92.17),
            vector4(1046.22, -778.03, 57.52, 89.04),
            vector4(1046.27, -774.45, 57.52, 90.5),
            vector4(1030.96, -773.4, 57.57, 144.89),
            vector4(1028.05, -771.42, 57.55, 146.44),
            vector4(1029.35, -763.6, 57.49, 56.05),
            vector4(1041.6, -791.45, 57.5, 0.97),
        }
    },
    ['caears242'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-480.87042236328, -819.84265136719),
                vector2(-441.08392333984, -820.39178466797),
                vector2(-440.29922485352, -795.61010742188),
                vector2(-450.12713623047, -795.83892822266),
                vector2(-450.57876586914, -792.54748535156),
                vector2(-480.38143920898, -792.79217529297)
            },
            ['minZ'] = 29.47,  -- min height of the parking zone
            ['maxZ'] = 32.82,  -- max height of the parking zone
        },
        label = "Caears 24 Parking",
        showBlip = true,
        blipcoords = vector3(-475.31, -818.73, 30.46),
        blipName = "Caears 24 Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(-477.62, -816.44, 30.05, 271.2),
            vector4(-477.28, -813.29, 30.1, 265.04),
            vector4(-477.3, -809.77, 30.12, 268.93),
            vector4(-477.37, -806.7, 30.12, 271.51),
            vector4(-477.45, -803.55, 30.12, 268.73),
            vector4(-477.12, -800.59, 30.12, 270.28),
            vector4(-476.98, -796.99, 30.12, 269.26),
            vector4(-476.98, -796.99, 30.12, 269.26),
            vector4(-476.99, -794.09, 30.13, 268.72),
            vector4(-459.54, -797.15, 30.12, 267.11),
            vector4(-460.45, -800.21, 30.12, 270.89),
            vector4(-460.18, -803.33, 30.11, 269.85),
            vector4(-460.74, -809.84, 30.11, 270.31),
            vector4(-460.21, -813.14, 30.13, 271.44),
            vector4(-460.21, -816.42, 30.16, 269.02),
            vector4(-444.8, -797.5, 30.12, 90.73),
            vector4(-444.33, -801.16, 30.12, 92.51),
            vector4(-444.6, -804.72, 30.11, 90.88),
            vector4(-444.63, -808.75, 30.11, 89.24),
            vector4(-443.84, -812.02, 30.13, 87.33),
            vector4(-444.21, -816.02, 30.24, 89.21),
            vector4(-460.34, -806.46, 30.11, 267.68),
            vector4(-466.14, -816.36, 30.11, 88.66),
            vector4(-466.18, -812.98, 30.11, 88.96),
            vector4(-466.22, -809.72, 30.11, 89.54),
            vector4(-467.38, -806.99, 30.11, 89.36),
            vector4(-466.99, -803.3, 30.12, 85.98),
            vector4(-466.81, -800.55, 30.12, 89.29),
            vector4(-466.41, -797.08, 30.12, 88.09),
            vector4(-460.34, -806.46, 30.11, 267.68),
        }
    },
    ['crastenburg'] = {          
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-329.67749023438, -988.03240966797),
                vector2(-296.36920166016, -999.9755859375),
                vector2(-302.67437744141, -1019.979675293),
                vector2(-315.67620849609, -1015.4108276367),
                vector2(-325.99209594727, -1016.2496337891),
                vector2(-337.08245849609, -1012.9448852539)
            },
            ['minZ'] = 29.27,  -- min height of the parking zone
            ['maxZ'] = 37.47,  -- max height of the parking zone
        },
        label = "Alta Apartments Parking",
        showBlip = false,
        blipcoords = vector3(-317.24, -1003.87, 30.38),
        blipName = "Alta Apartments Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(-321.91, -997.38, 29.97, 249.13),
            vector4(-323.38, -1003.46, 29.97, 248.9),
            vector4(-325.4, -1009.17, 29.97, 247.12),
            vector4(-332.66, -1009.66, 29.97, 67.96),
            vector4(-329.91, -1004.06, 29.97, 69.04),
            vector4(-327.69, -998.25, 29.97, 69.07),
            vector4(-302.29, -1004.18, 29.97, 249.43),
            vector4(-303.38, -1010.37, 29.97, 248.48),
            vector4(-306.4, -1015.7, 29.97, 249.53),
            vector4(-310.37, -1010.97, 29.97, 67.53),
            vector4(-308.59, -1005.29, 29.97, 69.32),
        }
    },
    ['marathon'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-1462.0177001953, -504.92785644531),
                vector2(-1481.5424804688, -518.4609375),
                vector2(-1480.9051513672, -519.37152099609),
                vector2(-1484.3217773438, -522.08020019531),
                vector2(-1483.5651855469, -523.06848144531),
                vector2(-1492.6707763672, -528.95916748047),
                vector2(-1504.3449707031, -508.01290893555),
                vector2(-1473.1278076172, -487.73834228516)
            },
            ['minZ'] = 31.00,  -- min height of the parking zone
            ['maxZ'] = 35.00,  -- max height of the parking zone
        },
        label = "Marathon Ave Parking",
        showBlip = false,
        blipcoords = vector3(-1478.27, -504.01, 32.81),
        blipName = "Marathon Ave Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(-1467.28, -504.99, 32.81, 35.14),
            vector4(-1469.83, -506.67, 32.81, 41.24),
            vector4(-1472.05, -508.6, 32.81, 37.9),
            vector4(-1474.84, -510.62, 32.81, 33.4),
            vector4(-1477.14, -511.93, 32.81, 41.12),
            vector4(-1479.77, -513.6, 32.81, 31.42),
            vector4(-1500.97, -509.44, 32.81, 216.07),
            vector4(-1498.66, -507.63, 32.81, 211.94),
            vector4(-1495.72, -506.23, 32.81, 220.81),
            vector4(-1493.31, -504.18, 32.81, 219.63),
            vector4(-1488.13, -500.98, 32.81, 229.69),
            vector4(-1485.36, -499.22, 32.81, 207.73),
            vector4(-1482.88, -497.65, 32.81, 211.88),
            vector4(-1480.26, -495.93, 32.81, 214.04),
            vector4(-1477.66, -494.09, 32.81, 205.9),
            vector4(-1475.47, -492.35, 32.81, 210.44)
        }
    },
    ['airportp'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-779.76104736328, -2023.2966308594),
                vector2(-775.14440917969, -2019.8140869141),
                vector2(-767.18334960938, -2012.3591308594),
                vector2(-760.70989990234, -2004.76171875),
                vector2(-756.01049804688, -1997.4604492188),
                vector2(-753.18353271484, -1990.4525146484),
                vector2(-751.64544677734, -1983.7036132812),
                vector2(-748.98046875, -1969.5380859375),
                vector2(-748.11468505859, -1967.5456542969),
                vector2(-746.72650146484, -1965.5721435547),
                vector2(-744.23596191406, -1963.4608154297),
                vector2(-739.22473144531, -1961.9007568359),
                vector2(-733.59368896484, -1962.0502929688),
                vector2(-729.30279541016, -1963.3483886719),
                vector2(-727.666015625, -1964.8414306641),
                vector2(-725.72021484375, -1966.9916992188),
                vector2(-714.04919433594, -2019.2927246094),
                vector2(-710.76025390625, -2032.8103027344),
                vector2(-707.01336669922, -2040.8115234375),
                vector2(-704.6533203125, -2044.3029785156),
                vector2(-703.19024658203, -2045.3291015625),
                vector2(-701.63171386719, -2045.6253662109),
                vector2(-699.74157714844, -2045.2917480469),
                vector2(-687.05395507812, -2039.5653076172),
                vector2(-685.76708984375, -2038.6518554688),
                vector2(-684.13092041016, -2036.3044433594),
                vector2(-672.29400634766, -2041.8348388672),
                vector2(-670.67193603516, -2043.4077148438),
                vector2(-665.39947509766, -2046.6591796875),
                vector2(-657.96466064453, -2048.1787109375),
                vector2(-655.55963134766, -2048.3508300781),
                vector2(-651.94177246094, -2047.6011962891),
                vector2(-649.02130126953, -2046.1932373047),
                vector2(-633.71252441406, -2030.9672851562),
                vector2(-631.34783935547, -2030.0726318359),
                vector2(-628.30303955078, -2030.5014648438),
                vector2(-616.89349365234, -2042.3790283203),
                vector2(-616.16394042969, -2045.1605224609),
                vector2(-617.02777099609, -2047.9118652344),
                vector2(-648.34002685547, -2079.3305664062),
                vector2(-652.69281005859, -2082.1706542969),
                vector2(-658.36376953125, -2083.3293457031),
                vector2(-671.02252197266, -2082.0708007812),
                vector2(-676.02673339844, -2082.1984863281),
                vector2(-684.85815429688, -2084.7019042969),
                vector2(-695.00408935547, -2087.8937988281),
                vector2(-701.19207763672, -2088.712890625),
                vector2(-703.89630126953, -2088.4221191406),
                vector2(-708.56176757812, -2085.2458496094),
                vector2(-713.30065917969, -2087.1435546875),
                vector2(-718.29937744141, -2082.3813476562),
                vector2(-724.05651855469, -2078.2341308594),
                vector2(-736.53204345703, -2071.5529785156),
                vector2(-746.24493408203, -2067.9118652344),
                vector2(-751.45703125, -2073.4653320312),
                vector2(-787.72106933594, -2037.2147216797)
            },
            ['minZ'] = 7.85,  -- min height of the parking zone
            ['maxZ'] = 10.10,  -- max height of the parking zone
        },
        label = "Airport Parking",
        showBlip = false,
        blipcoords = vector3(-796.86, -2024.85, 8.88),
        blipName = "Airport Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,

    },
    ['beachp'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-1177.4599609375, -1504.8297119141),
                vector2(-1170.6567382812, -1500.1866455078),
                vector2(-1167.892578125, -1496.4272460938),
                vector2(-1167.0075683594, -1491.4938964844),
                vector2(-1168.083984375, -1487.3162841797),
                vector2(-1184.8902587891, -1461.9444580078),
                vector2(-1203.3045654297, -1475.2700195312),
                vector2(-1202.2609863281, -1476.640625),
                vector2(-1208.1496582031, -1480.9470214844),
                vector2(-1207.1524658203, -1483.8693847656),
                vector2(-1207.7424316406, -1485.8941650391),
                vector2(-1188.0931396484, -1513.3830566406),
                vector2(-1185.7036132812, -1511.7416992188),
                vector2(-1187.1550292969, -1509.7088623047),
                vector2(-1183.7425537109, -1507.1494140625),
                vector2(-1182.2048339844, -1508.9814453125)
            },
            ['minZ'] = 3.20,  -- min height of the parking zone
            ['maxZ'] = 6.53,  -- max height of the parking zone
        },
        label = "Beach Parking",
        showBlip = false,
        blipcoords = vector3(-1183.1, -1511.11, 4.36),
        blipName = "Beach Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',                 --car, air, sea
        debug = false
    },
    ["themotorhotel"] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(1140.2746582031, 2644.5261230469),
                vector2(1108.8831787109, 2644.2172851562),
                vector2(1108.5783691406, 2660.1645507812),
                vector2(1089.9521484375, 2660.1198730469),
                vector2(1091.3571777344, 2677.4743652344),
                vector2(1133.5280761719, 2674.8422851562),
                vector2(1133.7532958984, 2658.8393554688),
                vector2(1140.4176025391, 2658.8898925781)
            },
            ['minZ'] = 36.78,  -- min height of the parking zone
            ['maxZ'] = 39.74,  -- max height of the parking zone
        },
        label = "The Motor Hotel Parking",
        showBlip = false,
        blipcoords = vector3(1137.77, 2663.54, 37.9),
        blipName = "Motor Hotel Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(1135.05, 2648.52, 37.53, 359.9),
            vector4(1131.63, 2648.65, 37.53, 0.84),
            vector4(1127.62, 2648.64, 37.53, 358.95),
            vector4(1124.01, 2648.78, 37.53, 359.86),
            vector4(1120.54, 2648.37, 37.53, 359.29),
            vector4(1116.61, 2648.06, 37.53, 359.24),
            vector4(1112.7, 2654.15, 37.53, 270.72),
            vector4(1112.45, 2657.74, 37.53, 268.39),
            vector4(1105.39, 2664.3, 37.52, 358.28),
            vector4(1101.83, 2663.94, 37.51, 0.22),
            vector4(1098.16, 2663.85, 37.51, 358.64),
        },
    },
    ['liqourparking'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(953.42, 3626.16, 32.34),
            vector3(953.73, 3612.58, 32.73),
            vector3(936.41, 3611.31, 32.68),
            vector3(936.64, 3625.96, 32.42)
            },
            ['minZ'] = 31.5,  -- min height of the parking zone
            ['maxZ'] = 35.99,  -- max height of the parking zone
        },
        label = "Sandy Parking",
        showBlip = true,
        blipcoords = vector3(934.95, 3606.59, 32.81),
        blipName = "Liqour Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(951.27, 3623.09, 31.96, 91.39),
            vector4(950.94, 3619.05, 32.1, 92.01),
            vector4(951.33, 3615.41, 32.16, 88.83),
            vector4(938.4, 3615.89, 32.11, 87.41),
            vector4(939.12, 3619.37, 32.04, 91.53),
            vector4(938.81, 3623.38, 31.96, 88.63),
            vector4(944.23, 3623.59, 31.95, 90.71),
            vector4(944.81, 3619.08, 32.1, 92.52),
            vector4(945.03, 3615.7, 32.14, 88.4)
        },
    },
    ['haanparking'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(85.85, 6396.84, 31.23),
            vector3(72.65, 6382.24, 31.24),
            vector3(53.3, 6401.58, 31.38),
            vector3(67.15, 6416.04, 31.38),
            },
            ['minZ'] = 30.00,  -- min height of the parking zone
            ['maxZ'] = 33.38,  -- max height of the parking zone
        },
        label = "Bell Farms Parking",
        showBlip = true,
        blipcoords = vector3(70.35, 6398.75, 31.23),
        blipName = "Bell Farms Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(81.03, 6396.18, 30.76, 134.82),
            vector4(78.27, 6398.67, 30.76, 135.37),
            vector4(75.44, 6401.29, 30.76, 133.90),
            vector4(72.79, 6404.34, 30.76, 132.19),
            vector4(64.42, 6406.97, 30.76, 214.01),
            vector4(61.94, 6404.05, 30.76, 211.45),
            vector4(59.54, 6400.65, 30.76, 213.17),
        },
    },
    ['cityhall'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector2(-539.98022460938, -275.70364379883),
            vector2(-537.67120361328, -270.44470214844),
            vector2(-486.3830871582, -249.66979980469),
            vector2(-483.94976806641, -249.64471435547),
            vector2(-480.14627075195, -251.68218994141)
            },
            ['minZ'] = 35.0,  -- min height of the parking zone
            ['maxZ'] = 39.0,  -- max height of the parking zone
        },
        label = 'City Hall Parking',
        type = 'public',
        showBlip = false,
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        ["ParkingSpots"] = {
            vector4(-487.73, -252.34, 35.69, 109.31),
            vector4(-494.06, -255.01, 35.62, 110.77),
            vector4(-498.73, -256.93, 35.58, 113.0),
            vector4(-504.24, -259.16, 35.54, 112.03),
            vector4(-509.67, -261.37, 35.47, 112.21),
            vector4(-515.03, -263.6, 35.41, 111.81),
            vector4(-520.43, -265.8, 35.33, 112.28),
            vector4(-526.44, -268.25, 35.27, 112.78),
            vector4(-532.09, -270.51, 35.21, 111.7),
        },
        debug = false
    },
    ['kildareautospublic'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-973.78765869141, -2106.7236328125),
                vector2(-961.48071289063, -2094.4028320313),
                vector2(-956.36669921875, -2099.8957519531),
                vector2(-966.361328125, -2111.8288574219)
            },
            ['minZ'] = 8.29,  -- min height of the parking zone
            ['maxZ'] = 12.40,  -- max height of the parking zone
        },
        label = 'Kildare Autos Parking',
        type = 'public',
        showBlip = true,
        blipcoords = vector3(-964.79, -2103.25, 9.3),
        blipName = "Kildare Autos Parking",
        blipNumber = 357,
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        ["ParkingSpots"] = {
            vector4(-960.55, -2098.3, 9.3, 228.25),
            vector4(-962.88, -2100.7, 9.3, 221.57),
            vector4(-965.43, -2103.42, 9.3, 226.88),
            vector4(-967.79, -2105.77, 9.3, 225.32),
        },
        debug = false
    },
    ['lsiahangerparking'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector2(-1610.3303222656, -3136.4255371094),
            vector2(-1604.8737792969, -3126.9050292969),
            vector2(-1594.3740234375, -3132.8718261719),
            vector2(-1599.7579345703, -3142.5065917969),
            },
            ['minZ'] = 11.94,  -- min height of the parking zone
            ['maxZ'] = 15.94,  -- max height of the parking zone
        },
        label = 'LSIA Hanger Parking',
        type = 'public',
        showBlip = false,
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        ["ParkingSpots"] = {
            vector4(-1606.15, -3134.23, 13.95, 335.74),
            vector4(-1602.59, -3137.04, 13.94, 335.34),
        },
        debug = false
    },
    ['helipad'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-757.8896484375, -1469.876953125),
                vector2(-744.54223632812, -1480.4110107422),
                vector2(-733.07989501954, -1467.4460449218),
                vector2(-746.4605102539, -1456.0607910156)
            },
            ['minZ'] = 4.0,  -- min height of the parking zone
            ['maxZ'] = 8.0,  -- max height of the parking zone
        },
        label = 'Helipad',
        type = 'public',
        vehicleCategories = {'helicopter', 'plane'},
        drawText = 'Helipad',
        showBlip = false, 
        blipName = "Helipad",
        blipNumber = 64,
        blipColor = 50, 
        blipcoords = vector3(-745.61, -1468.57, 4.37),
        ["ParkingSpots"] = {
            vector4(-745.53, -1468.68, 5.0, 321.19)
        },
        ParkingDistance = 10.0,
        debug = false
    },
    ['shoreheli'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(1774.4047851562, 3246.9484863281),
                vector2(1762.30859375, 3244.3928222656),
                vector2(1765.3605957031, 3231.908203125),
                vector2(1777.5689697266, 3235.4580078125)
            },
            ['minZ'] = 40.0,  -- min height of the parking zone
            ['maxZ'] = 46.0,  -- max height of the parking zone
        },
        label = 'Sandy Shores Helipad',
        type = 'public',
        vehicleCategories = {'helicopter', 'plane'},
        drawText = 'Sandy Shores Helipad',
        showBlip = false, 
        blipName = 'Helipad',
        blipNumber = 64,
        blipColor = 50, 
        blipcoords = vector3(1769.62, 3240.14, 42.01),
        ['ParkingSpots'] = {
            vector4(1769.62, 3240.14, 42.01, 60.44),
        },
        ParkingDistance = 100.0,
        debug = false
    },
    ['grapeheli'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(2143.7600097656, 4825.8354492188),
                vector2(2120.908203125, 4815.7680664063),
                vector2(2129.5307617188, 4794.7836914063),
                vector2(2154.888671875, 4805.4580078125)
            },
            ['minZ'] = 40,  -- min height of the parking zone
            ['maxZ'] = 46,  -- max height of the parking zone
        },
        label = 'Grapeseed Helipad',
        type = 'public',
        vehicleCategories = {'helicopter', 'plane'},
        drawText = 'Sandy Shores Helipad',
        showBlip = false, 
        blipName = 'Helipad',
        blipNumber = 64,
        blipColor = 50, 
        blipcoords = vector3(1769.62, 3240.14, 42.01),
        ParkingDistance = 100.0,
        debug = false
    },
    ['airdepot'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-1235.3253173828, -3378.4008789062),
                vector2(-1284.2642822266, -3350.1474609375),
                vector2(-1284.5589599609, -3350.7241210938),
                vector2(-1289.5042724609, -3348.0512695312),
                vector2(-1308.7587890625, -3382.4091796875),
                vector2(-1307.0877685547, -3383.8776855469),
                vector2(-1307.6185302734, -3385.4577636719),
                vector2(-1306.0087890625, -3386.4213867188),
                vector2(-1308.2755126953, -3391.1662597656),
                vector2(-1306.2180175781, -3392.1394042969),
                vector2(-1264.1188964844, -3420.0451660156),
                vector2(-1258.6077880859, -3412.1069335938),
                vector2(-1258.1317138672, -3412.4846191406),
                vector2(-1237.5152587891, -3387.8581542969),
                vector2(-1236.4268798828, -3387.1162109375),
                vector2(-1233.0942382812, -3380.8115234375),
                vector2(-1233.4357910156, -3380.13671875),
                vector2(-1235.1755371094, -3379.1962890625)
            },
            ['minZ'] = 12.00,  -- min height of the parking zone
            ['maxZ'] = 20.0,  -- max height of the parking zone
        },
        label = 'Air Depot',
        type = 'depot',
        vehicleCategories = {'helicopter', 'plane'},
        drawText = 'AIR DEPOT',
        showBlip = true, 
        blipName = 'Air Depot',
        blipNumber = 569,
        blipColor = 33, 
        blipcoords = vector3(-1274.34, -3385.97, 13.94),
        ParkingDistance = 100.0,
        debug = false,
        ['ParkingSpots'] = {
            vector4(-1286.09, -3363.24, 14.54, 275.59),
            vector4(-1292.65, -3383.11, 14.54, 280.17),
            vector4(-1252.97, -3385.7, 14.54, 11.75),
            vector4(-1268.63, -3402.56, 14.54, 14.72),
            vector4(-1280.83, -3395.7, 14.54, 330.47),

        },
    },
    ['boatdepot'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-1002.41, -1410.59),
                vector2(-957.79, -1394.19),
                vector2(-963.72, -1379.45),
                vector2(-1006.79, -1396.0),
            },
            ['minZ'] = 0.0,  -- min height of the parking zone
            ['maxZ'] = 5.0,  -- max height of the parking zone
        },
        label = 'Boat Impound',
        type = 'depot',
        vehicleCategories = {'boat'},
        drawText = 'BOAT IMPOUND',
        showBlip = true, 
        blipName = 'Boat Impound',
        blipNumber = 68,
        blipColor = 15, 
        blipcoords = vector3(-1004.48, -1402.19, 1.6),
        debug = false,
        ['ParkingSpots'] = {
            vector4(-998.6, -1400.41, 0.82, 28.99),
            vector4(-990.51, -1397.12, 0.82, 28.99),
            vector4(-981.46, -1393.79, 0.82, 28.99),
            vector4(-973.72, -1390.97, 0.82, 28.99),
            vector4(-965.16, -1387.02, 0.82, 28.98),

        },
    },
    ['boathouse1'] = {
        ['Zone'] = {
            ['Shape'] = { 
                vector2(-778.9291381836, -1513.3040771484),
                vector2(-803.83276367188, -1521.1665039062),
                vector2(-816.67852783204, -1493.2373046875),
                vector2(-791.34436035156, -1481.7546386718)
            },
            ['minZ'] = 0.00,
            ['maxZ'] = 5.00
        },
        label = 'Boat House',
        type = 'public',
        vehicleCategories = {'boat'},
        drawText = 'BOAT HOUSE',
        showBlip = true, 
        blipName = 'Boat House',
        blipNumber = 427,
        blipColor = 15,
        blipcoords = vector3(-784.84, -1498.33, 0.2),
        ParkingDistance = 20.0,
        SpawnDistance = 10.0,
        debug = false,
        ['ParkingSpots'] = {
            vector4(-798.39, -1499.15, 0.37, 109.87),
            vector4(-797.47, -1506.73, 0.3, 114.49),
        },
        ExitWarpLocations = {
            vector3(-807.15, -1496.86, 1.6),
            vector3(-800.17, -1494.87, 1.6),
            vector3(-792.92, -1492.18, 1.6),
            vector3(-787.58, -1508.59, 1.6),
            vector3(-794.89, -1511.16, 1.6),
            vector3(-800.21, -1513.05, 1.6),
        },
    },
    ['boathouse2'] = {
        ['Zone'] = {
            ['Shape'] = { 
                vector2(-471.95428466797, 6510.6743164063),
                vector2(-451.20068359375, 6490.6201171875),
                vector2(-494.95248413086, 6461.1489257813),
                vector2(-513.23284912109, 6480.6723632813)
            },
            ['minZ'] = 0.00,
            ['maxZ'] = 14.97
        },
        label = 'Boat House',
        type = 'public',
        vehicleCategories = {'boat'},
        drawText = 'BOAT HOUSE',
        showBlip = true, 
        blipName = 'Boat House',
        blipNumber = 427,
        blipColor = 15,
        blipcoords = vector3(-484.09, 6488.374, 1.279),
        ParkingDistance = 20.0,
        SpawnDistance = 10.0,
        debug = false,
        ['ParkingSpots'] = {
            vector4(-483.698, 6491.521, -0.475, 305.523),
            vector4(-489.428, 6487.905, -0.51, 111.871),
        },
        ExitWarpLocations = {
            vector3(-475.851, 6491.313, -0.475),
        },
    },
    ['intairport'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-992.59680175781, -2949.84375),
                vector2(-1030.8975830078, -3016.2927246094),
                vector2(-1030.3382568359, -3016.5925292969),
                vector2(-1029.6291503906, -3017.0434570312),
                vector2(-1028.7434082031, -3018.0705566406),
                vector2(-1022.2585449219, -3021.5798339844),
                vector2(-1021.3436279297, -3020.5522460938),
                vector2(-1016.1632080078, -3023.6635742188),
                vector2(-1016.3262329102, -3024.7385253906),
                vector2(-966.09301757812, -3052.3435058594),
                vector2(-965.42352294922, -3051.1135253906),
                vector2(-961.01477050781, -3052.7600097656),
                vector2(-923.76300048828, -2978.2124023438)
            },
            ['minZ'] = 12.00,  -- min height of the parking zone
            ['maxZ'] = 20.0,  -- max height of the parking zone
        },
        label = 'Airport Hangar', 
        type = 'public',
        vehicleCategories = {'helicopter', 'plane'},
        drawText = 'Airport Hangar',
        showBlip = true, 
        blipName = 'Hangar',
        blipNumber = 359,
        blipColor = 50, 
        blipcoords = vector3(-930.23, -2995.38, 19.85),
        ParkingDistance = 100.0,
        SpawnDistance = 100.0,
        debug = false,
        ['ParkingSpots'] = {
            vector4(-985.04, -2965.05, 14.55, 128.92),
            vector4(-964.84, -2974.78, 14.55, 125.92),
            vector4(-945.49, -2985.63, 14.55, 117.77),
            vector4(-967.17, -3034.71, 14.55, 14.16),
            vector4(-990.13, -3022.86, 14.55, 15.42),
            vector4(-1010.91, -3012.56, 14.55, 2.31),
            vector4(-968.09, -3004.59, 14.55, 62.25)

        },
    },

    ------------ Whitelisted Jobs

    -- Job (EMS: Pillbox)
    ['ambulance'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(319.62, -539.2),
                vector2(319.34, -544.24),
                vector2(337.11, -544.75),
                vector2(336.29, -538.43),
            },
            ['minZ'] = 27.85,  -- min height of the parking zone
            ['maxZ'] = 30.30,  -- max height of the parking zone
        },
        label = 'Pillbox EMS Parking',
        showBlip = false,
        type = 'job',
        job = 'ambulance',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(335.27, -541.36, 28.1, 180.53),
            vector4(332.18, -541.36, 28.1, 179.88),
            vector4(329.37, -541.36, 28.1, 180.28),
            vector4(326.59, -541.36, 28.1, 178.06),
            vector4(323.86, -541.36, 28.1, 180.2),
            vector4(321.11, -541.36, 28.1, 179.86),
        }
    },

    -- Job (EMS: Sandy)
    ['sandyemsgarage'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(1835.66, 3668.61),
                vector2(1838.87, 3662.61),
                vector2(1819.69, 3652.57),
                vector2(1816.39, 3657.75),
            },
            ['minZ'] = 33.00,  -- min height of the parking zone
            ['maxZ'] = 35.00,  -- max height of the parking zone
        },
        label = 'Sandy EMS Parking',
        showBlip = false,
        type = 'job',
        job = 'ambulance',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(1819.17, 3655.45, 34.14, 210.57),
            vector4(1822.22, 3657.13, 34.07, 212.91),
            vector4(1825.83, 3658.56, 34.02, 212.36),
            vector4(1828.81, 3660.56, 33.94, 210.97),
            vector4(1831.82, 3662.58, 33.89, 211.18),
            vector4(1835.41, 3664.56, 33.79, 211.25),
        }
    },

    -- Job (EMS: Pillbox)
    ['elsemsgarage'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(1163.04, -1456.31, 34.79),
                vector3(1163.74, -1461.43, 34.91),
                vector3(1160.02, -1461.66, 34.84),
                vector3(1160.30, -1486.26, 34.84),
                vector3(1154.26, -1485.90, 34.84),
                vector3(1154.28, -1456.21, 34.69),
            },
            ['minZ'] = 34.09,  -- min height of the parking zone
            ['maxZ'] = 35.09,  -- max height of the parking zone
        },
        label = 'ELS EMS Parking',
        showBlip = false,
        type = 'job',
        job = 'ambulance',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(1159.99, -1459.06, 34.28, 90.73),
            vector4(1157.09, -1467.24, 34.28, 89.78),
            vector4(1157.12, -1470.56, 34.28, 91.25),
            vector4(1157.02, -1474.3, 34.28, 91.21),
            vector4(1157.22, -1477.97, 34.28, 89.87),
            vector4(1157.04, -1481.88, 34.28, 90.46),
        }
    },

    -- Job (PD: Sandy)
    ['bcso'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(1854.63, 3679.68),
                vector2(1857.5, 3674.37),
                vector2(1846.28, 3669.23),
                vector2(1843.79, 3673.38),
            },
            ['minZ'] = 33.00,  -- min height of the parking zone
            ['maxZ'] = 35.00,  -- max height of the parking zone
        },
        label = 'Sandy PD Parking',
        showBlip = false,
        type = 'job',
        job = 'police',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(1848.02, 3671.03, 33.76, 212.0),
            vector4(1850.86, 3673.18, 33.8, 211.17),
            vector4(1854.22, 3675.28, 33.74, 209.35),
        }
    },        

    -- Job (PD: MRPD)
    ['lspd'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(428.95, -974.74, 25.7),
                vector3(423.15, -974.88, 25.7),
                vector3(423.16, -1000.25, 25.71),
                vector3(427.82, -1000.31, 25.7),

            },
            ['minZ'] = 24.00,  -- min height of the parking zone
            ['maxZ'] = 26.00,  -- max height of the parking zone
        },
        label = 'MRPD Parking',
        showBlip = false,
        type = 'job',
        job = 'police',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(426.50, -978.97, 25.29, 270.65),
            vector4(426.50, -981.64, 25.29, 270.65),
            vector4(426.50, -991.73, 25.29, 270.65),
            vector4(426.50, -994.50, 25.29, 270.65),
        }
    }, 

    -- Job (PD: Davis)
    ['state'] = {
            ['Zone'] = {
                ['Shape'] = {
                    vector3(393.96, -1631.6, 29.29),
                    vector3(389.17, -1628.48, 29.29),
                    vector3(401.9, -1613.77, 29.29),
                    vector3(406.01, -1617.08, 29.35),    
                },
                ['minZ'] = 27.55,  -- min height of the parking zone
                ['maxZ'] = 29.75,  -- max height of the parking zone
            },
            label = 'Davis PD Parking',
            showBlip = false,
            type = 'job',
            job = 'police',
            vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
            drawText = 'Parking',
            debug = false,
            ['ParkingSpots'] = {
                vector4(392.1, -1628.52, 28.65, 49.19),
                vector4(394.87, -1625.87, 28.65, 50.46),
                vector4(396.85, -1623.99, 28.65, 48.41),
                vector4(398.85, -1621.28, 28.65, 49.61),
                vector4(400.73, -1618.83, 28.65, 52.06),
                vector4(402.7, -1617.03, 28.65, 49.23),
            }
        },   

    -- Job (Tow)
    ['tow'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(787.59, -810.17, 26.16),
                vector3(791.06, -810.39, 26.31),
                vector3(791.23, -830.69, 26.15),
                vector3(787.30, -830.96, 25.98),
            },
            ['minZ'] = 24.55,  -- min height of the parking zone
            ['maxZ'] = 26.50,  -- max height of the parking zone
        },
        label = 'SADOT Parking',
        showBlip = false,
        type = 'job',
        job = 'tow',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(789.30, -812.99, 25.73, 359.82),
            vector4(789.30, -818.08, 25.71, 359.89),
            vector4(789.30, -823.04, 25.66, 359.96),
            vector4(789.30, -828.22, 25.61, 0.01)
        }
    },   

    ------------ Businesses

    -- Arcadius (public)
    ['arcadius'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(-149.95, -588.4, 32.42),
            vector3(-157.08, -585.65, 32.42),
            vector3(-172.03, -625.76, 32.42),
            vector3(-164.38, -629.19, 32.42),
            },
            ['minZ'] = 31.50,  -- min height of the parking zone
            ['maxZ'] = 33.50,  -- max height of the parking zone
        },
        label = "Arcadius Parking",
        showBlip = false,
        blipcoords = vector3(-1478.27, -504.01, 32.81),
        blipName = "Public Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(-167.22, -625.21, 32.01, 69.93),
            vector4(-165.45, -622.32, 32.01, 69.93),
            vector4(-164.59, -616.32, 32.01, 69.93),
            vector4(-163.28, -613.52, 32.01, 69.93),
            vector4(-161.57, -609.61, 32.01, 69.93),
            vector4(-160.40, -606.26, 32.01, 69.93),
            vector4(-158.68, -600.74, 32.01, 69.93),
            vector4(-157.51, -597.67, 32.01, 69.93),
            vector4(-155.77, -593.90, 32.01, 69.93),
            vector4(-154.92, -590.50, 32.01, 69.93),
        }
    },

    -- Paintball (public)
    ['paintball'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
                vector2(-1038.62, 4918.13),
                vector2(-1032.88, 4924.76),
                vector2(-1025.95, 4921.11),
                vector2(-1034.39, 4911.39),
            },
            ['minZ'] = 200.0,  -- min height of the parking zone
            ['maxZ'] = 210.0,  -- max height of the parking zone
        },
        label = "Paintball Parking",
        showBlip = false,
        blipcoords = vector3(-1478.27, -504.01, 32.81),
        blipName = "Public Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
    },

    -- Job (Beaver Aviation)
    ['beaveraviation'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(1713.23, 3325.31, 41.22),
                vector3(1740.2, 3332.56, 41.22),
                vector3(1754.85, 3278.13, 41.11),
                vector3(1729.45, 3270.96, 41.15),
            },
            ['minZ'] = 38.55,  -- min height of the parking zone
            ['maxZ'] = 56.50,  -- max height of the parking zone
        },
        label = 'Flying Beaver Aviation Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'beaveraviation',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'helicopter', 'plane'},
        drawText = 'Flying Beaver Aviation Employee Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(1750.54, 3287.37, 41.49, 166.68),
            vector4(1737.84, 3283.82, 41.51, 191.93),
            vector4(1728.66, 3283.07, 41.46, 225.33),
            vector4(1731.66, 3309.98, 41.61, 194.18)
        }
    },   

    -- Job (Slurp n Go)
    ['slurpngo'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(-1414.04, -285.27, 46.35),
                vector3(-1417.31, -281.3, 46.22),
                vector3(-1412.62, -277.35, 46.36),
                vector3(-1413.65, -275.9, 46.35),
                vector3(-1406.78, -269.62, 46.39),
                vector3(-1402.42, -274.94, 46.42),
            },
            ['minZ'] = 45.55,  -- min height of the parking zone
            ['maxZ'] = 46.85,  -- max height of the parking zone
        },
        label = 'Slurp n Go Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'slurpngo',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Slurp n Go Employee Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(-1412.78, -280.72, 45.93, 129.56),
            vector4(-1408.38, -275.02, 45.97, 133.80),
        }
    }, 

    -- Job (Smoke On The Water)
    ['sotw'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(367.43, -816.67, 29.26),
                vector3(372.22, -816.68, 29.29),
                vector3(371.99, -825.19, 29.29),
                vector3(367.43, -825.18, 29.26),
            },
            ['minZ'] = 25.0,  -- min height of the parking zone
            ['maxZ'] = 45.0  -- max height of the parking zone
        },
        label = 'Smoke On The Water Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'smokeonthewater',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Smoke On The Water Employee Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(368.86, -819.08, 29.29, 89.68),
            vector4(368.87, -822.84, 29.29, 88.47),
        }
    },

     -- Job (Clinic)
     ['clinic'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(318.06692504883, -562.01684570313),
                vector2(325.66061401367, -564.77294921875),
                vector2(322.76403808594, -573.51477050781),
                vector2(315.10610961914, -570.46429443359),
            },
            ['minZ'] = 25.79,  -- min height of the parking zone
            ['maxZ'] = 31.79, -- max height of the parking zone
        },
        label = 'LS Clinic Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'clinic',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'LS Clinic Employee Parking',
        debug = false,
    },

     -- Job (Clinic)
     ['koi'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-991.97692871094, -1467.6392822266),
                vector2(-995.81219482422, -1462.4298095703),
                vector2(-991.39849853516, -1459.4482421875),
                vector2(-987.06298828125, -1465.2550048828)
            },
            ['minZ'] = 2.96,  -- min height of the parking zone
            ['maxZ'] = 7.04, -- max height of the parking zone
        },
        label = 'KOI Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'koi',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'KOI Employee Parking',
        debug = false,
    },

     -- Job (Clinic)
     ['kildareautos'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-973.73553466797, -2058.1596679688),
                vector2(-982.64440917969, -2067.3879394531),
                vector2(-993.18255615234, -2057.5173339844),
                vector2(-983.21441650391, -2048.0258789063)
            },
            ['minZ'] = 6.51,  -- min height of the parking zone
            ['maxZ'] = 15.51, -- max height of the parking zone
        },
        label = 'Kildare Autos Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'cardealer',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Kildare Autos Employee Parking',
        debug = false,
    },

    -- Job (Skull Island)
    ['tequilala'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-565.69720458984, 305.44512939453),
                vector2(-557.91271972656, 305.08905029297),
                vector2(-558.64483642578, 298.78454589844),
                vector2(-566.76373291016, 299.24615478516),
            },
            ['minZ'] = 80.0,  -- min height of the parking zone
            ['maxZ'] = 95.0  -- max height of the parking zone
        },
        label = 'Skull Island Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'tequilala',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Skull Island Employee Parking',
        debug = false
    },

    -- Job (Finnis Taxi)
    ['finnistaxi'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(902.90692138672, -187.47985839844),
                vector2(907.35974121094, -180.36595153809),
                vector2(911.60333251953, -183.10850524902),
                vector2(907.23480224609, -190.02226257324),
            },
            ['minZ'] = 73.25,  -- min height of the parking zone
            ['maxZ'] = 75.85  -- max height of the parking zone
        },
        label = 'Finnis Taxi Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'finnistaxi',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Finnis Taxi Employee Parking',
        debug = flase
    },

    -- Job (10-42)
    ['tenfourtwo'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(1239.0637207031, -411.67785644531),
                vector2(1241.5891113281, -401.98522949219),
                vector2(1249.2108154297, -403.36752319336),
                vector2(1246.1567382813, -414.349609375),
            },
            ['minZ'] = 67.98,  -- min height of the parking zone
            ['maxZ'] = 72.58,  -- max height of the parking zone
        },
        label = '10-42 Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'tenfourtwo',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = '10-42 Employee Parking',
        debug = false
    },
    -- Job (GoPostal)
    ['gopostal-hq'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(88.64, 96.49),
                vector2(83.45, 83.91),
                vector2(67.22, 88.86),
                vector2(72.92, 102.62) 
            },
            ['minZ'] = 70.00,  -- min height of the parking zone
            ['maxZ'] = 80.00,  -- max height of the parking zone
        },
        label = 'GoPostal Fleet Garage',
        showBlip = false,
        type = 'job',
        job = 'gopostal',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'GoPostal Fleet Garage',
        debug = false,
    },
    
    -- Job (Wolfs's Realestate)
    ['realestate'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-590.55780029297, -723.91058349609),
                vector2(-590.6337890625, -709.62384033203),
                vector2(-604.84912109375, -709.74066162109),
                vector2(-604.83404541016, -724.01098632813) 
            },
            ['minZ'] = 130.04,  -- min height of the parking zone
            ['maxZ'] = 134.84,  -- max height of the parking zone
        },
        label = 'Wolfs Helipad',
        showBlip = false,
        type = 'job',
        job = 'realestate',
        vehicleCategories = {'helicopter', 'plane'},
        drawText = 'Wolfs Helipad',
        debug = false,
    },
    
    -- Job (G&G)
    ['glazedandglorious'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-624.0498046875, -1064.4324951172),
                vector2(-623.99114990234, -1042.3095703125),
                vector2(-614.37176513672, -1042.1977539063),
                vector2(-614.65112304688, -1054.5500488281),
                vector2(-604.01550292969, -1054.5458984375),
                vector2(-602.85601806641, -1064.001953125)
            },
            ['minZ'] = 20.00,  -- min height of the parking zone
            ['maxZ'] = 25.00,  -- max height of the parking zone
        },
        label = 'Glazed N\' Glorious Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'glazedandglorious',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Glazed N\' Glorious Employee Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(-619.52, -1062.67, 21.79, 271.18),
            vector4(-619.28, -1058.76, 21.79, 261.68),
            vector4(-619.79, -1055.0, 21.79, 275.73),
            vector4(-619.72, -1051.36, 21.79, 262.22),
            vector4(-609.96, -1059.4, 21.79, 93.56),
            vector4(-614.2, -1061.09, 21.79, 184.56)
        }
    },

     -- Job (Maisonette)
     ['maisonette'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-1425.7132568359, -643.75012207031),
                vector2(-1422.4912109375, -648.66687011719),
                vector2(-1412.6680908203, -642.20758056641),
                vector2(-1416.0802001953, -637.35955810547)
            },
            ['minZ'] = 25.67,  -- min height of the parking zone
            ['maxZ'] = 30.67,  -- max height of the parking zone
        },
        label = 'Maisonette Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'maisonette',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Maisonette Employee Parking',
        debug = false,
        
    },

     -- Job (Vanilla Unicorn)
     ['vanillaunicorn'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(143.51643371582, -1289.8930664063),
                vector2(148.39840698242, -1287.2170410156),
                vector2(144.42124938965, -1279.8314208984),
                vector2(139.35687255859, -1282.6750488281)
            },
            ['minZ'] = 27.16,  -- min height of the parking zone
            ['maxZ'] = 31.53,  -- max height of the parking zone
        },
        label = 'VU Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'vanillaunicorn',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'VU Employee Parking',
        debug = false,
        
    },

     -- Job (Sycthe Smiths)
     ['knifeshop'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-665.34088134766, 5832.16015625),
                vector2(-671.01727294922, 5826.4775390625),
                vector2(-663.89892578125, 5819.5009765625),
                vector2(-657.32788085938, 5824.7446289063)
            },
            ['minZ'] = 12.33,  -- min height of the parking zone
            ['maxZ'] = 30.63,  -- max height of the parking zone
        },
        label = 'Sycthe Smiths Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'knifeshop',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Sycthe Smiths Employee Parking',
        debug = false,
        
    },

    -- Job (Open Road)
    ['yellowjack'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(2513.29, 4069.7),
                vector2(2507.17, 4073.11),
                vector2(2512.0, 4081.78),
                vector2(2518.16, 4078.26)
            },
            ['minZ'] = 35.00,  -- min height of the parking zone
            ['maxZ'] = 50.00,  -- max height of the parking zone
        },
        label = 'Open Road Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'yellowjack',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Open Road Employee Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(2512.23, 4072.82, 38.49, 63.74),
            vector4(2515.22, 4078.22, 38.55, 63.74)
        }
    }, 

    -- Job (Glizzy Comics)
    ['glizzycomics'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-29.723608016968, -65.997230529785),
                vector2(-42.654846191406, -62.305839538574),
                vector2(-43.693336486816, -67.787559509277),
                vector2(-30.294389724731, -72.495216369629)
            },
            ['minZ'] = 47.04,  -- min height of the parking zone
            ['maxZ'] = 65.54,  -- max height of the parking zone
        },
        label = 'Glizzy Comics Employee Parking',
        showBlip = false,
        type = 'job',
        job = 'glizzycomics',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Glizzy Comics Employee Parking',
        debug = false,
    },

    ------------ Gangs
            
    -- Gang (Ballas)
    ['ballas'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(86.31, -1973.7, 20.82),
                vector3(82.38, -1970.82, 20.84),
                vector3(94.46, -1957.49, 20.91),
                vector3(98.62, -1959.33, 20.73),
            },
            ['minZ'] = 19.82,  -- min height of the parking zone
            ['maxZ'] = 21.22,  -- max height of the parking zone
        },
        label = 'Ballas Parking',
        showBlip = false,
        --type = 'job',
        type = 'gang',
        --job = 'ambulance',
        gang = 'ballas',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(85.75, -1971.41, 20.14, 320.48),
            vector4(89.53, -1966.83, 20.1, 320.49),
            vector4(93.69, -1961.77, 20.11, 320.5),
        }
    },   

    -- Gang (Nismos)
    ['nismos'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-1544.8394775391, -392.83941650391),
                vector2(-1551.5047607422, -400.27307128906),
                vector2(-1546.0662841797, -404.78573608398),
                vector2(-1539.5994873047, -396.9231262207)
            },
            ['minZ'] = 40.98,  -- min height of the parking zone
            ['maxZ'] = 46.98,  -- max height of the parking zone
        },
        label = 'Nismos Parking',
        showBlip = false,
        type = 'gang',
        gang = 'nismos',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',
        debug = false,
    },   

    -- Gang (Collective)
    ['collective'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(-121.24, 1009.18, 235.73),
                vector3(-134.87, 1006.05, 235.73),
                vector3(-126.49, 984.43, 235.74),
                vector3(-115.03, 988.93, 235.75),
            },
            ['minZ'] = 234.73,  -- min height of the parking zone
            ['maxZ'] = 236.73,  -- max height of the parking zone
        },
        label = 'Collective Parking',
        showBlip = false,
        type = 'gang',
        gang = 'collective',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(-125.2, 991.62, 235.11, 201.48),
            vector4(-127.85, 998.33, 235.1, 201.51),
            vector4(-130.45, 1004.94, 235.09, 201.5),
            vector4(-124.14, 1006.45, 235.09, 199.75),
            vector4(-122.29, 1001.29, 235.09, 199.77),
            vector4(-119.25, 992.83, 235.11, 199.76),
        }
    },
    
    -- Gang (Collective)
    ['collective2'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-45.585201263428, 938.17840576172),
                vector2(-44.545467376709, 947.36877441406),
                vector2(-35.114253997803, 946.89245605469),
                vector2(-35.669464111328, 937.06042480469)
            },
            ['minZ'] = 230.08,  -- min height of the parking zone
            ['maxZ'] = 238.08,  -- max height of the parking zone
        },
        label = 'Collective Parking',
        showBlip = false,
        type = 'gang',
        gang = 'collective',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'helicopter', 'plane'},
        drawText = 'Parking',
        debug = false,
    },   

    -- Gang (SRR)
    ['srr'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(102.94, 3621.13, 39.75),
                vector3(91.08, 3621.04, 39.81),
                vector3(91.1, 3630.08, 39.69),
                vector3(103.03, 3631.02, 39.75),
            },
            ['minZ'] = 37.86,  -- min height of the parking zone
            ['maxZ'] = 41.86,  -- max height of the parking zone
        },
        label = 'Seven River Rangers Parking',
        showBlip = false,
        type = 'gang',
        gang = 'srr',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(101.38, 3625.61, 39.75, 0.35),
            vector4(94.78, 3625.63, 39.74, 359.59),
        }
    },
    
    -- Gang (SRR)
    ['srr2'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(46.684566497803, 3711.9211425781),
                vector2(57.403259277344, 3706.462890625),
                vector2(65.716346740723, 3719.3725585938),
                vector2(53.771461486816, 3724.4030761719)
            },
            ['minZ'] = 36.69,  -- min height of the parking zone
            ['maxZ'] = 42.75,  -- max height of the parking zone
        },
        label = 'Seven River Rangers Parking',
        showBlip = false,
        type = 'gang',
        gang = 'srr',
        vehicleCategories = {'other', 'service', 'helicopter', 'plane'},
        drawText = 'Parking',
        debug = false,
    },  

    -- Gang (Madrazo)
    ['bunker'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(879.52, -3237.18, -98.29),
                vector3(879.12, -3248.8, -98.29),
                vector3(892.5, -3249.71, -98.29),
                vector3(896.35, -3235.11, -98.31),
            },
            ['minZ'] = -100.0,  -- min height of the parking zone
            ['maxZ'] = -95.0,  -- max height of the parking zone
        },
        label = 'Bunker Parking',
        showBlip = false,
        type = 'public',
        showBlip = false,
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        debug = false,
    },   
    -- Gang (Madrazo)
    ['madrazo'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector3(509.24, -2743.36, 3.07),
                vector3(495.53, -2765.62, 3.07),
                vector3(480.02, -2755.53, 3.07),
                vector3(493.25, -2733.49, 3.07),
            },
            ['minZ'] = 2.28,  -- min height of the parking zone
            ['maxZ'] = 6.78,  -- max height of the parking zone
        },
        label = 'Madrazo Parking',
        showBlip = false,
        type = 'gang',
        gang = 'madrazo',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',
        debug = false,
    },  
    -- Gang (Chaotek)
    ['chaotek'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(-585.91, 199.63),
                vector2(-591.82, 199.2),
                vector2(-591.44, 180.5),
                vector2(-585.75, 180.55)
            },
            ['minZ'] = 68.0,  -- min height of the parking zone
            ['maxZ'] = 80.0,  -- max height of the parking zone
        },
        label = 'Chaotek Parking',
        showBlip = false,
        type = 'gang',
        gang = 'chaotek',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(-589.44, 181.86, 70.85, 87.9),
            vector4(-589.67, 184.91, 70.96, 85.82),
            vector4(-589.75, 188.04, 71.15, 90.57),
            vector4(-589.77, 191.33, 71.26, 90.66),
            vector4(-589.69, 194.22, 71.34, 92.1),
            vector4(-589.9, 197.23, 71.45, 92.2)
        }
    },  

    -- Gang (Reapers)
    ['reapers'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(11.63, 6493.05),
                vector2(16.04, 6489.02),
                vector2(10.77, 6483.82),
                vector2(6.36, 6488.3)
            },
            ['minZ'] = 30.0,  -- min height of the parking zone
            ['maxZ'] = 33.0,  -- max height of the parking zone
        },
        label = 'Reapers Parking',
        showBlip = false,
        type = 'gang',
        gang = 'reapers',
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',
        debug = false,
        ['ParkingSpots'] = {
            vector4(11.07, 6488.61, 31.31, 137.0),
        }
    },
    
    -- Gang (Reapers Heli)
    ['reapers2'] = {
        ['Zone'] = {
            ['Shape'] = {
                vector2(49.808837890625, 6509.892578125),
                vector2(61.960227966309, 6500.6127929688),
                vector2(73.383781433105, 6511.6850585938),
                vector2(60.400959014893, 6523.66015625)
            },
            ['minZ'] = 31.33,  -- min height of the parking zone
            ['maxZ'] = 31.95  -- max height of the parking zone
        },
        label = 'Reapers Parking',
        showBlip = false,
        type = 'gang',
        gang = 'reapers',
        vehicleCategories = {'helicopter', 'plane'},
        drawText = 'Parking',
        debug = false,
    },   

    ------------ Civ Jobs

    --Mining
    ['quarry'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(2948.53, 2736.54, 44.71),
            vector3(2952.21, 2730.84, 45.42),
            vector3(2965.13, 2736.66, 43.63),
            vector3(2959.18, 2746.22, 43.47),
            },
            ['minZ'] = 42.06,  -- min height of the parking zone
            ['maxZ'] = 44.56,  -- max height of the parking zone
        },
        label = "Quarry Parking",
        showBlip = false,
        blipcoords = vector3(-1478.27, -504.01, 32.81),
        blipName = "Quarry Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(2950.47, 2735.72, 44.17, 261.43),
            vector4(2958.78, 2738.21, 43.36, 346.99),
        }
    },

    -- Trucking
    ['trucking'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(-379.35, -2802.24, 6.0),
            vector3(-369.18, -2792.56, 6.0),
            vector3(-369.42, -2782.77, 6.0),
            vector3(-374.9, -2777.34, 6.0),
            vector3(-382.61, -2776.2, 6.0),
            vector3(-388.5, -2786.93, 6.0),
            },
            ['minZ'] = 4.25,  -- min height of the parking zone
            ['maxZ'] = 6.256,  -- max height of the parking zone
        },
        label = "Trucker Parking",
        showBlip = false,
        blipcoords = vector3(-1478.27, -504.01, 32.81),
        blipName = "Trucker Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(-376.16, -2781.71, 5.54, 315.48),
            vector4(-382.7, -2788.32, 5.54, 311.1),
            vector4(-373.48, -2784.81, 5.54, 316.2),
            vector4(-379.32, -2791.17, 5.54, 318.11),
            vector4(-372.01, -2791.27, 5.54, 318.93),
            vector4(-378.13, -2798.24, 5.54, 319.15),
        }
    },

    -- Garbage
    ['garbage'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(-335.56, -1533.01, 27.57),
            vector3(-335.8, -1527.21, 27.69),
            vector3(-322.06, -1527.46, 27.55),
            vector3(-321.86, -1533.38, 27.58),
            },
            ['minZ'] = 26.55,  -- min height of the parking zone
            ['maxZ'] = 28.15,  -- max height of the parking zone
        },
        label = "Rubbish Parking",
        showBlip = false,
        blipcoords = vector3(-1478.27, -504.01, 32.81),
        blipName = "Rubbish Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(-324.4, -1529.74, 27.08, 1.61),
            vector4(-327.62, -1529.98, 27.08, 0.86),
            vector4(-330.7, -1529.96, 27.08, 0.18),
            vector4(-333.97, -1529.99, 27.09, 359.75),
        }
    },

    ------------ Boat Rentals
    
    -- Boat Rentals (LSMC)
    ['lsmc_dock'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(-683.07, -1397.35, 5.0),
            vector3(-676.9, -1397.67, 5.0),
            vector3(-678.15, -1418.49, 5.0),
            vector3(-684.53, -1418.19, 5.0),
            },
            ['minZ'] = 4.01,  -- min height of the parking zone
            ['maxZ'] = 5.20,  -- max height of the parking zone
        },
        label = "LSMC Parking",
        showBlip = false,
        blipcoords = vector3(-682.31, -1408.92, 4.48),
        blipName = "LSMC Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(-681.45, -1416.22, 4.4, 86.02),
            vector4(-681.48, -1412.19, 4.4, 86.59),
            vector4(-681.22, -1408.00, 4.4, 86.87),
            vector4(-680.93, -1403.78, 4.4, 87.52),
            vector4(-680.64, -1399.86, 4.4, 86.93),
        }
    },

    -- Boat Rentals ()
    ['millars_dock'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(1316.53, 4309.19, 37.99),
            vector3(1305.20, 4309.80, 37.49),
            vector3(1306.63, 4329.18, 38.33),
            vector3(1319.55, 4327.26, 38.16),
            },
            ['minZ'] = 36.79,  -- min height of the parking zone
            ['maxZ'] = 38.95,  -- max height of the parking zone
        },
        label = "Millars Parking",
        showBlip = false,
        blipcoords = vector3(1311.80, 4318.46, 37.59),
        blipName = "Millars Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(1315.60, 4313.18, 37.79, 170.71),
            vector4(1317.30, 4323.75, 37.87, 170.71),
            vector4(1308.42, 4312.61, 37.45, 177.57),
            vector4(1308.91, 4322.60, 37.81, 176.24),
            vector4(1311.60, 4312.65, 37.72, 176.96),
            vector4(1312.77, 4324.33, 37.84, 174.13),
        }
    },

    -- Boat Rentals (El Gordo)
    ['gordo_dock'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(3334.22, 5155.15, 18.25),
            vector3(3327.65, 5159.27, 18.57),
            vector3(3320.16, 5143.78, 18.20),
            vector3(3327.63, 5141.79, 18.21),
            },
            ['minZ'] = 17.75,  -- min height of the parking zone
            ['maxZ'] = 18.75,  -- max height of the parking zone
        },
        label = "Gordo Parking",
        showBlip = false,
        blipcoords = vector3(3327.65, 5159.27, 18.57),
        blipName = "Gordo Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(3328.20, 5152.99, 17.98, 136.90),
            vector4(3324.76, 5146.99, 17.95, 113.83)
        }
    },

    -- Boat Rentals (El Gordo)
    ['paletofishing_dock'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector3(-1574.18, 5174.38, 19.52),
            vector3(-1584.51, 5171.67, 19.52),
            vector3(-1590.01, 5160.87, 19.53),
            vector3(-1580.37, 5147.59, 19.89),
            vector3(-1568.22, 5155.58, 19.79)
            },
            ['minZ'] = 19.01,  -- min height of the parking zone
            ['maxZ'] = 20.20,  -- max height of the parking zone
        },
        label = "Paleto Dock Parking",
        showBlip = false,
        blipcoords = vector3(-1576.93, 5159.82, 19.8),
        blipName = "Paleto Dock Parking",
        blipNumber = 357,
        type = 'public',                --public, job, gang, depot
        vehicleCategories = {'car', 'motorcycle', 'other', 'service'},
        drawText = 'Parking',                 --car, air, sea
        debug = false,
        ['ParkingSpots'] = {
            vector4(-1572.62, 5157.17, 19.45, 167.25),
            vector4(-1581.61, 5153.23, 19.48, 217.62),
            vector4(-1576.87, 5156.71, 19.57, 187.60),
            vector4(-1574.95, 5168.52, 19.26, 181.33),
            vector4(-1584.76, 5160.51, 19.25, 226.32),
            vector4(-1579.86, 5165.36, 19.24, 187.43),
        }
    },

    ------------ Mechanic Garages

    ['bikinimechanic'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector2(821.32, -831.92),
            vector2(821.34, -823.95),
            vector2(806.25, -824.11),
            vector2(807.27, -832.23)
            },
            ['minZ'] = 20.0,  -- min height of the parking zone
            ['maxZ'] = 40.0,  -- max height of the parking zone
        },
        label = 'Bikini Automotive',
        type = 'mechanic',
        showBlip = false,
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        ["ParkingSpots"] = {
            vector4(819.29, -829.17, 26.22, 358.76),
            vector4(816.03, -829.17, 26.22, 359.35),
            vector4(813.07, -829.17, 26.22, 359.5),
            vector4(809.64, -829.17, 26.22, 357.75)
        },
        debug = false
    },

    ['nismostuning'] = {
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the parking area
            vector2(-1589.37, -824.68),
            vector2(-1594.18, -830.78),
            vector2(-1604.71, -821.7),
            vector2(-1600.08, -815.6)
            },
            ['minZ'] = 8.0,  -- min height of the parking zone
            ['maxZ'] = 12.0,  -- max height of the parking zone
        },
        label = 'Nismos Tuning',
        type = 'mechanic',
        showBlip = false,
        vehicleCategories = {'car', 'motorcycle', 'other', 'service', 'emergency'},
        drawText = 'Parking',
        ["ParkingSpots"] = {
            vector4(-1593.82, -826.24, 9.98, 142.63),
            vector4(-1596.27, -824.08, 9.98, 139.15),
            vector4(-1598.47, -822.1, 9.98, 139.62),
            vector4(-1600.82, -820.18, 9.98, 134.24)
        },
        debug = false
    },
}

HouseGarages = {} -- DO NOT TOUCH!
