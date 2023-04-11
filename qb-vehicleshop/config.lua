Config = {}
Config.UsingTarget = true
Config.Commission = 0.10 -- Percent that goes to sales person from a full car sale 10%
Config.FinanceCommission = 0.05 -- Percent that goes to sales person from a finance sale 5%
Config.FinanceZone = vector3(5000.0, -5000.0, -26.42) -- Where the finance menu is located
Config.PaymentWarning = 10 -- time in minutes that player has to make payment before repo
Config.PaymentInterval = 24 -- time in hours between payment being due
Config.MinimumDown = 10 -- minimum percentage allowed down
Config.MaximumPayments = 24 -- maximum payments allowed
Config.TestDriveArena = vector4(-2139.84, 1106.17, -26.48, 270.68)
Config.RefundPercent = 70
Config.Shops = {
    -- Player-ran shops --
    ['pdm'] = {
        ['Type'] = 'managed',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-952.33758544922, -2085.1157226563),
                vector2(-895.92895507813, -2028.8188476563),
                vector2(-918.22784423828, -2007.2514648438),
                vector2(-974.25915527344, -2063.1889648438)
            },
            ['minZ'] = 25.0,  -- min height of the shop zone
            ['maxZ'] = 28.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'cardealer', -- Name of job or none
        ['ShopLabel'] = 'Kildare Autos', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 641,  -- Blip sprite
        ['blipColor'] = 1,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['import'] = "Import",
            ['limitedtime'] = "Limited Time",
            ['commercial'] = "Commercial",
            ['motorcycles'] = "Motorcycles",
            ['compacts'] = "Compacts",
            ['coupes'] = "Coupes",
            ['sedans'] = "Sedans",
            ['sports'] = "Sports",
            ['sportsclassics'] = "Sports Classics",
            ['muscle'] = "Muscle",
            ['suvs'] = "SUVs",
            ['offroad'] = "Offroad",
            ['importmoto'] = "Import Motorcycles",
        },
        ['TestDriveTimeLimit'] = 0.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-927.62, -2041.34, 9.51), -- Blip Location
        ['ReturnLocation'] = vector3(-960.76, -2062.63, 9.51), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-959.98, -2062.11, 9.51, 138.12), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(-959.98, -2062.11, 9.51, 138.12), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-922.86, -2045.07, 9.59, 169.08), -- where the vehicle will spawn on display
                defaultVehicle = 'sugoi', -- Default display vehicle
                chosenVehicle = 'sugoi', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-928.73, -2050.66, 9.59, 165.64),
                defaultVehicle = 'tulip',
                chosenVehicle = 'tulip',
            },
            [3] = {
                coords = vector4(-934.6, -2056.65, 9.59, 170.58),
                defaultVehicle = 'rebla',
                chosenVehicle = 'rebla',
            },
            [4] = {
                coords = vector4(-940.56, -2062.43, 9.59, 168.84),
                defaultVehicle = 'zr350',
                chosenVehicle = 'zr350',
            },
        },
    },
    
    ['bikedealer'] = {
        ['Type'] = 'managed',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(48.788681030273, 6467.056640625),
                vector2(32.670017242432, 6482.7299804688),
                vector2(41.932025909424, 6492.7856445313),
                vector2(59.222770690918, 6477.0708007813)
            },
            ['minZ'] = 31.14,  -- min height of the shop zone
            ['maxZ'] = 31.14,  -- max height of the shop zone
            ['size'] = 2.50, -- size of the vehicles zones
        },
        ['Job'] = 'bikedealer', -- Name of job or none
        ['ShopLabel'] = 'Reapers Bike Shop', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 661,  -- Blip sprite
        ['blipColor'] = 47,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['motorcycles'] = "Motorcycles",
            ['importmoto'] = "Import Motorcycles",
        },
        ['TestDriveTimeLimit'] = 0.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(48.95, 6473.99, 31.44), -- Blip Location
        ['ReturnLocation'] = vector3(52.0, 6489.03, 31.43), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(58.03, 6496.24, 31.57, 136.76), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(62.6, 6491.29, 31.46, 134.54), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(41.79, 6474.76, 31.53, 309.89), -- where the vehicle will spawn on display
                defaultVehicle = 'sovereign', -- Default display vehicle
                chosenVehicle = 'sovereign', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(43.73, 6473.09, 31.53, 312.89), -- where the vehicle will spawn on display
                defaultVehicle = 'nightblade', -- Default display vehicle
                chosenVehicle = 'nightblade', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(45.42, 6471.41, 31.53, 321.89), -- where the vehicle will spawn on display
                defaultVehicle = 'wolfsbane', -- Default display vehicle
                chosenVehicle = 'wolfsbane', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(47.05, 6470.0, 31.53, 327.89), -- where the vehicle will spawn on display
                defaultVehicle = 'sanctus', -- Default display vehicle
                chosenVehicle = 'sanctus', -- Same as default but is dynamically changed when swapping vehicles
            },
            [5] = {
                coords = vector4(57.43, 6477.23, 31.44, 203.43), -- where the vehicle will spawn on display
                defaultVehicle = 'sovereign', -- Default display vehicle
                chosenVehicle = 'sovereign', -- Same as default but is dynamically changed when swapping vehicles
            },
            [6] = {
                coords = vector4(56.09, 6475.89, 31.44, 205.34), -- where the vehicle will spawn on display
                defaultVehicle = 'nightblade', -- Default display vehicle
                chosenVehicle = 'nightblade', -- Same as default but is dynamically changed when swapping vehicles
            },
            [7] = {
                coords = vector4(55.03, 6474.6, 31.44, 197.4), -- where the vehicle will spawn on display
                defaultVehicle = 'wolfsbane', -- Default display vehicle
                chosenVehicle = 'wolfsbane', -- Same as default but is dynamically changed when swapping vehicles
            },
            [8] = {
                coords = vector4(53.75, 6473.39, 31.44, 200.59), -- where the vehicle will spawn on display
                defaultVehicle = 'gargoyle', -- Default display vehicle
                chosenVehicle = 'gargoyle', -- Same as default but is dynamically changed when swapping vehicles
            },
            [9] = {
                coords = vector4(47.4, 6474.48, 31.44, 207.71), -- where the vehicle will spawn on display
                defaultVehicle = 'shinobi', -- Default display vehicle
                chosenVehicle = 'shinobi', -- Same as default but is dynamically changed when swapping vehicles
            },
            [10] = {
                coords = vector4(48.79, 6475.93, 31.44, 210.71), -- where the vehicle will spawn on display
                defaultVehicle = 'bati', -- Default display vehicle
                chosenVehicle = 'bati', -- Same as default but is dynamically changed when swapping vehicles
            },
            [11] = {
                coords = vector4(50.36, 6477.55, 31.44, 216.71), -- where the vehicle will spawn on display
                defaultVehicle = 'diablous', -- Default display vehicle
                chosenVehicle = 'diablous', -- Same as default but is dynamically changed when swapping vehicles
            },
            [12] = {
                coords = vector4(44.33, 6477.62, 31.14, 207.71), -- where the vehicle will spawn on display
                defaultVehicle = 'zombiea', -- Default display vehicle
                chosenVehicle = 'zombiea', -- Same as default but is dynamically changed when swapping vehicles
            },
            [13] = {
                coords = vector4(45.87, 6479.22, 31.26, 207.7), -- where the vehicle will spawn on display
                defaultVehicle = 'zombiea', -- Default display vehicle
                chosenVehicle = 'zombiea', -- Same as default but is dynamically changed when swapping vehicles
            },
            [14] = {
                coords = vector4(47.5, 6480.81, 31.14, 213.71), -- where the vehicle will spawn on display
                defaultVehicle = 'gargoyle', -- Default display vehicle
                chosenVehicle = 'gargoyle', -- Same as default but is dynamically changed when swapping vehicles
            },
            [15] = {
                coords = vector4(41.33, 6480.75, 31.5, 198.7), -- where the vehicle will spawn on display
                defaultVehicle = 'cliffhanger', -- Default display vehicle
                chosenVehicle = 'cliffhanger', -- Same as default but is dynamically changed when swapping vehicles
            },
            [17] = {
                coords = vector4(42.82, 6482.21, 31.5, 207.7), -- where the vehicle will spawn on display
                defaultVehicle = 'bf400', -- Default display vehicle
                chosenVehicle = 'bf400', -- Same as default but is dynamically changed when swapping vehicles
            },
            [18] = {
                coords = vector4(44.31, 6483.9, 31.5, 213.7), -- where the vehicle will spawn on display
                defaultVehicle = 'manchez', -- Default display vehicle
                chosenVehicle = 'manchez', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    -- Public shops --
    ['bicycle'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-1208.04, -1152.12),
                vector2(-1206.59, -1156.28),
                vector2(-1201.15, -1156.0),
                vector2(-1203.29, -1149.34)
            },
            ['minZ'] = 6.0,  -- min height of the shop zone
            ['maxZ'] = 10.0,  -- max height of the shop zone
            ['size'] = 1.0, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Bicycle Shop', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 226,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['cycles'] = 'Bicycles',
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-1203.78, -1154.81, 7.73), -- Blip Location
        ['ReturnLocation'] = vector3(315.16, -1158.13, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-1203.23, -1156.53, 7.73, 105.51), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1204.44, -1151.48, 7.9, 105.59), -- where the vehicle will spawn on display
                defaultVehicle = 'bmx', -- Default display vehicle
                chosenVehicle = 'bmx', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-1204.23, -1152.25, 7.9, 102.18), -- where the vehicle will spawn on display
                defaultVehicle = 'cruiser', -- Default display vehicle
                chosenVehicle = 'cruiser', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(-1204.06, -1153.04, 7.9, 108.94), -- where the vehicle will spawn on display
                defaultVehicle = 'fixter', -- Default display vehicle
                chosenVehicle = 'fixter', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(-1203.82, -1153.85, 7.9, 112.81), -- where the vehicle will spawn on display
                defaultVehicle = 'scorcher', -- Default display vehicle
                chosenVehicle = 'scorcher', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    ['motorcycle'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(303.95, -1159.73),
                vector2(304.07, -1167.43),
                vector2(319.87, -1165.69),
                vector2(320.38, -1155.48)
            },
            ['minZ'] = 27.0,  -- min height of the shop zone
            ['maxZ'] = 35.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Motorcycle Dealership', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 226,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['motorcycles'] = 'Motorcycles',
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(305.49, -1164.05, 29.29), -- Blip Location
        ['ReturnLocation'] = vector3(315.16, -1158.13, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(315.51, -1155.67, 29.29, 0.23), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(317.44, -1166.09, 29.29, 1.99), -- where the vehicle will spawn on display
                defaultVehicle = 'avarus', -- Default display vehicle
                chosenVehicle = 'avarus', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(315.44, -1166.09, 29.29, 1.99), -- where the vehicle will spawn on display
                defaultVehicle = 'bagger', -- Default display vehicle
                chosenVehicle = 'bagger', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(313.44, -1166.09, 29.29, 1.99), -- where the vehicle will spawn on display
                defaultVehicle = 'chimera', -- Default display vehicle
                chosenVehicle = 'chimera', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(311.44, -1166.09, 29.29, 1.99), -- where the vehicle will spawn on display
                defaultVehicle = 'daemon', -- Default display vehicle
                chosenVehicle = 'daemon', -- Same as default but is dynamically changed when swapping vehicles
            },
            [5] = {
                coords = vector4(309.44, -1166.09, 29.29, 1.99), -- where the vehicle will spawn on display
                defaultVehicle = 'daemon2', -- Default display vehicle
                chosenVehicle = 'daemon2', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    ['commercial'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(894.02795410156, -1553.5659179688),
                vector2(910.38256835938, -1571.1160888672),
                vector2(927.66156005859, -1574.7971191406),
                vector2(927.06146240234, -1550.5997314453),
                vector2(919.87469482422, -1534.7595214844)
            },
            ['minZ'] = 30.67,  -- min height of the shop zone
            ['maxZ'] = 30.67,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Commercial Dealership', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 616,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['commercial'] = 'Commercial',
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(907.96, -1561.98, 30.75), -- Blip Location
        ['ReturnLocation'] = vector3(315.16, -1158.13, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(896.37, -1568.86, 30.84, 93.18), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(920.33, -1563.9, 30.75, 88.11), -- where the vehicle will spawn on display
                defaultVehicle = 'tractor', -- Default display vehicle
                chosenVehicle = 'tractor', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(920.59, -1556.26, 30.77, 91.63), -- where the vehicle will spawn on display
                defaultVehicle = 'stretch', -- Default display vehicle
                chosenVehicle = 'stretch', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(910.4, -1549.71, 30.69, 224.67), -- where the vehicle will spawn on display
                defaultVehicle = 'mule', -- Default display vehicle
                chosenVehicle = 'mule', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(903.68, -1555.09, 30.68, 221.08), -- where the vehicle will spawn on display
                defaultVehicle = 'coach', -- Default display vehicle
                chosenVehicle = 'coach', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    ['offroad'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(1212.31, 2727.69),
                vector2(1213.02, 2693.35),
                vector2(1244.16, 2693.24),
                vector2(1240.83, 2727.6)
            },
            ['minZ'] = 34.0,  -- min height of the shop zone
            ['maxZ'] = 40.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Off-Road Dealership', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 67,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['offroad'] = 'Offroad',
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(1224.72, 2728.06, 38.28), -- Blip Location
        ['ReturnLocation'] = vector3(315.16, -1158.13, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(1250.28, 2715.58, 38.01, 183.84), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(1220.2, 2720.55, 38.0, 176.82), -- where the vehicle will spawn on display
                defaultVehicle = 'caracara2', -- Default display vehicle
                chosenVehicle = 'caracara2', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(1227.46, 2719.9, 38.01, 176.82), -- where the vehicle will spawn on display
                defaultVehicle = 'hellion', -- Default display vehicle
                chosenVehicle = 'hellion', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(1227.07, 2707.07, 38.01, 176.82), -- where the vehicle will spawn on display
                defaultVehicle = 'slamvan', -- Default display vehicle
                chosenVehicle = 'slamvan', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(1220.2, 2707.36, 38.01, 176.82), -- where the vehicle will spawn on display
                defaultVehicle = 'moonbeam2', -- Default display vehicle
                chosenVehicle = 'moonbeam2', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    ['sports'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-181.75, 6221.36),
                vector2(-196.35, 6237.39),
                vector2(-213.99, 6219.71),
                vector2(-198.29, 6204.65)
            },
            ['minZ'] = 29.0,  -- min height of the shop zone
            ['maxZ'] = 39.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Sports Dealership', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 523,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['sports'] = 'Sports',
            ['sportsclassics'] = 'Sports Classics',
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-215.18, 6218.67, 31.49), -- Blip Location
        ['ReturnLocation'] = vector3(315.16, -1158.13, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-189.24, 6221.16, 31.49, 136.7), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-208.09, 6220.24, 31.49, 226.65), -- where the vehicle will spawn on display
                defaultVehicle = 'coquette2', -- Default display vehicle
                chosenVehicle = 'coquette2', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-205.7, 6222.4, 31.49, 226.65), -- where the vehicle will spawn on display
                defaultVehicle = 'feltzer2', -- Default display vehicle
                chosenVehicle = 'feltzer2', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(-203.39, 6224.98, 31.49, 226.65), -- where the vehicle will spawn on display
                defaultVehicle = 'locust', -- Default display vehicle
                chosenVehicle = 'locust', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(-201.13, 6227.22, 31.49, 226.65), -- where the vehicle will spawn on display
                defaultVehicle = 'dynasty', -- Default display vehicle
                chosenVehicle = 'dynasty', -- Same as default but is dynamically changed when swapping vehicles
            },
            [5] = {
                coords = vector4(-198.41, 6229.17, 31.5, 226.65), -- where the vehicle will spawn on display
                defaultVehicle = 'mamba', -- Default display vehicle
                chosenVehicle = 'mamba', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    ['muscle'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-101.83, 82.46),
                vector2(-91.01, 76.72),
                vector2(-82.26, 94.46),
                vector2(-92.49, 99.12)
            },
            ['minZ'] = 65.0,  -- min height of the shop zone
            ['maxZ'] = 75.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Muscle & SUV Dealership', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 596,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['muscle'] = 'Muscles',
            ['suvs'] = 'SUVs',
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-83.81, 79.89, 71.56), -- Blip Location
        ['ReturnLocation'] = vector3(315.16, -1158.13, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-83.81, 79.89, 71.56, 150.17), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-85.66, 92.37, 72.38, 157.56), -- where the vehicle will spawn on display
                defaultVehicle = 'blade', -- Default display vehicle
                chosenVehicle = 'blade', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-88.7, 94.04, 72.38, 153.71), -- where the vehicle will spawn on display
                defaultVehicle = 'clique', -- Default display vehicle
                chosenVehicle = 'clique', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(-92.0, 80.48, 71.59, 333.77), -- where the vehicle will spawn on display
                defaultVehicle = 'bjxl', -- Default display vehicle
                chosenVehicle = 'bjxl', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(-94.97, 82.26, 71.56, 330.13), -- where the vehicle will spawn on display
                defaultVehicle = 'fq2', -- Default display vehicle
                chosenVehicle = 'fq2', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    ['sedans'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-64.800567626953, -1101.5234375),
                vector2(-35.272693634033, -1111.7365722656),
                vector2(-28.292734146118, -1094.8432617188),
                vector2(-56.389354705811, -1085.7965087891)
            },
            ['minZ'] = 26.0,  -- min height of the shop zone
            ['maxZ'] = 36.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Coupes, Compacts & Sedans Dealership', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 530,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['coupes'] = 'Coupes',
            ['compacts'] = 'Compacts',
            ['sedans'] = 'Sedans'
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-37.81, -1099.26, 26.42), -- Blip Location
        ['ReturnLocation'] = vector3(315.16, -1158.13, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-31.95, -1090.79, 26.42, 325.83), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-40.63, -1095.75, 26.42, 188.47), -- where the vehicle will spawn on display
                defaultVehicle = 'club', -- Default display vehicle
                chosenVehicle = 'club', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-46.48, -1093.83, 26.42, 194.55), -- where the vehicle will spawn on display
                defaultVehicle = 'previon', -- Default display vehicle
                chosenVehicle = 'previon', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(-46.9, -1101.43, 26.42, 300.84), -- where the vehicle will spawn on display
                defaultVehicle = 'stafford', -- Default display vehicle
                chosenVehicle = 'stafford', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(-41.43, -1102.41, 26.42, 250.76), -- where the vehicle will spawn on display
                defaultVehicle = 'warrener2', -- Default display vehicle
                chosenVehicle = 'warrener2', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },
    ['lowend'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-48.680648803711, -1666.3706054688),
                vector2(-64.05256652832, -1684.4781494141),
                vector2(-51.213108062744, -1697.7048339844),
                vector2(-32.070804595947, -1689.4108886719)
            },
            ['minZ'] = 28.0,  -- min height of the shop zone
            ['maxZ'] = 38.0,  -- max height of the shop zone
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Low-End Dealership', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 225,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['lowend'] = 'Low-End'
        },
        ['TestDriveTimeLimit'] = 1.0, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-53.28, -1684.8, 29.49), -- Blip Location
        ['ReturnLocation'] = vector3(315.16, -1158.13, 29.29), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-27.91, -1679.53, 29.47, 116.81), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-43.44, -1689.42, 29.37, 29.08), -- where the vehicle will spawn on display
                defaultVehicle = 'asbo', -- Default display vehicle
                chosenVehicle = 'asbo', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-50.26, -1691.46, 29.47, 32.89), -- where the vehicle will spawn on display
                defaultVehicle = 'fagaloa', -- Default display vehicle
                chosenVehicle = 'fagaloa', -- Same as default but is dynamically changed when swapping vehicles
            },
            [3] = {
                coords = vector4(-52.16, -1679.34, 29.41, 219.03), -- where the vehicle will spawn on display
                defaultVehicle = 'bison', -- Default display vehicle
                chosenVehicle = 'bison', -- Same as default but is dynamically changed when swapping vehicles
            },
            [4] = {
                coords = vector4(-56.28, -1683.75, 29.49, 219.6), -- where the vehicle will spawn on display
                defaultVehicle = 'rumpo', -- Default display vehicle
                chosenVehicle = 'rumpo', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },


    ['luxury'] = {
        ['Type'] = 'managed',  -- meaning a real player has to sell the car
        ['Zone'] = {
            ['Shape'] = {
                vector2(-1260.6973876953, -349.21334838867),
                vector2(-1268.6248779297, -352.87365722656),
                vector2(-1274.1533203125, -358.29794311523),
                vector2(-1273.8425292969, -362.73715209961),
                vector2(-1270.5701904297, -368.6716003418),
                vector2(-1266.0561523438, -375.14080810547),
                vector2(-1244.3684082031, -362.70278930664),
                vector2(-1249.8704833984, -352.03326416016),
                vector2(-1252.9503173828, -345.85726928711)
            },
            ['minZ'] = 36.646457672119,
            ['maxZ'] = 37.516143798828,
            ['size'] = 2.75, -- size of the vehicles zones
        },
        ['Job'] = 'cardealer', -- Name of job or none
        ['ShopLabel'] = 'Luxury Vehicle Shop',
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 326,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = {
            ['super'] = 'Super',
            ['sports'] = 'Sports'
        },
        ['TestDriveTimeLimit'] = 0.5,
        ['Location'] = vector3(-1255.6, -361.16, 36.91),
        ['ReturnLocation'] = vector3(-1231.46, -349.86, 37.33),
        ['VehicleSpawn'] = vector4(-1231.46, -349.86, 37.33, 26.61),
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1265.31, -354.44, 35.91, 205.08),
                defaultVehicle = 'italirsx',
                chosenVehicle = 'italirsx',
            },
            [2] = {
                coords = vector4(-1270.06, -358.55, 35.91, 247.08),
                defaultVehicle = 'italigtb',
                chosenVehicle = 'italigtb',
            },
            [3] = {
                coords = vector4(-1269.21, -365.03, 35.91, 297.12),
                defaultVehicle = 'nero',
                chosenVehicle = 'nero',
            },
            [4] = {
                coords = vector4(-1252.07, -364.2, 35.91, 56.44),
                defaultVehicle = 'bati',
                chosenVehicle = 'bati',
            },
            [5] = {
                coords = vector4(-1255.49, -365.91, 35.91, 55.63),
                defaultVehicle = 'carbonrs',
                chosenVehicle = 'carbonrs',
            },
            [6] = {
                coords = vector4(-1249.21, -362.97, 35.91, 53.24),
                defaultVehicle = 'hexer',
                chosenVehicle = 'hexer',
            },
        }
    },
    ['boats'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a vehicle
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-730.05230712891, -1317.8101806641),
                vector2(-753.64501953125, -1345.7990722656),
                vector2(-736.27557373047, -1360.5770263672),
                vector2(-710.91064453125, -1332.2618408203)
            }, 
            ['minZ'] = 1.00,  -- min height of the shop zone
            ['maxZ'] = 5.06,  -- max height of the shop zone
            ['size'] = 6.2, -- size of the vehicles zones
        },
        ['Job'] = 'none', -- Name of job or none
        ['ShopLabel'] = 'Marina Shop', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 410,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['boats'] = 'Boats',
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-738.25, -1334.38, 1.6), -- Blip Location
        ['ReturnLocation'] = vector3(-714.34, -1343.31, 0.0), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-727.87, -1353.1, -0.17, 137.09), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-727.05, -1326.59, 0.00, 229.5), -- where the vehicle will spawn on display
                defaultVehicle = 'Jetmax', -- Default display vehicle
                chosenVehicle = 'Jetmax', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-732.84, -1333.5, -0.50, 229.5),
                defaultVehicle = 'dinghy2',
                chosenVehicle = 'dinghy2',
            },
            [3] = {
                coords = vector4(-737.84, -1340.83, -0.50, 229.5),
                defaultVehicle = 'dinghy4',
                chosenVehicle = 'dinghy4',
            },
            [4] = {
                coords = vector4(-741.53, -1349.7, -2.00, 229.5),
                defaultVehicle = 'marquis',
                chosenVehicle = 'marquis',
            },
        },
    },
    ['air'] = {
        ['Type'] = 'managed',  -- no player interaction is required to purchase a vehicle
        ['Zone'] = {
            ['Shape'] = { --polygon that surrounds the shop
                vector2(-1607.58, -3141.7),
                vector2(-1672.54, -3103.87),
                vector2(-1703.49, -3158.02),
                vector2(-1646.03, -3190.84),
            },
            ['minZ'] = 0.0,  -- min height of the shop zone
            ['maxZ'] = 5.0,  -- max height of the shop zone
            ['size'] = 7.0, -- size of the vehicles zones
        },
        ['Job'] = 'beaveraviation', -- Name of job or none
        ['ShopLabel'] = 'Air Shop', -- Blip name
        ['showBlip'] = true,  -- true or false
        ['blipSprite'] = 251,  -- Blip sprite
        ['blipColor'] = 3,  -- Blip color
        ['Categories'] = { -- Categories available to browse
            ['helicopters'] = 'Helicopters',
            ['planes'] = 'Planes',
        },
        ['TestDriveTimeLimit'] = 1.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-1652.76, -3143.4, 13.99), -- Blip Location
        ['ReturnLocation'] = vector3(-1628.44, -3104.7, 13.94), -- Location to return vehicle, only enables if the vehicleshop has a job owned
        ['VehicleSpawn'] = vector4(-1617.49, -3086.17, 13.94, 329.2), -- Spawn location when vehicle is bought
        ['TestDriveSpawn'] = vector4(-1543.67, -3171.14, 13.94, 325.07), -- Spawn location for test drive
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(-1651.36, -3162.66, 12.99, 346.89), -- where the vehicle will spawn on display
                defaultVehicle = 'maverick', -- Default display vehicle
                chosenVehicle = 'maverick', -- Same as default but is dynamically changed when swapping vehicles
            },
            [2] = {
                coords = vector4(-1668.53, -3152.56, 12.99, 303.22),
                defaultVehicle = 'conada',
                chosenVehicle = 'conada',
            },
            [3] = {
                coords = vector4(-1632.02, -3144.48, 12.99, 31.08),
                defaultVehicle = 'nimbus',
                chosenVehicle = 'nimbus',
            },
            [4] = {
                coords = vector4(-1663.74, -3126.32, 12.99, 275.03),
                defaultVehicle = 'dodo',
                chosenVehicle = 'dodo',
            },
        },
    },
}

Config.DebugSellZones = false
Config.SellZones = {
    ["Vehicle Buyer"] = {
        coords = vector4(-620.47, -1649.61, 25.83, 60.8),
        blip = {
            sprite = 642,
            color = 2,
        },
        zoneName = "pdmcarsell",
    },
    ["Boat Buyer"] = {
        coords = vector4(-844.84, -1361.77, 0.94, 113.37),
        blip = {
            sprite = 642,
            color = 2,
        },
        zoneName = "pdmboatsell",
    },
}