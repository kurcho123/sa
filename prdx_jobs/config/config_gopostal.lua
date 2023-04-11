-- -- -- -- -- -- -- -- -- -- -- -- -- --
--             Cargo CONFIG            --
-- -- -- -- -- -- -- -- -- -- -- -- -- --
Config = Config or {}
Config.GoPostal = {
    PalletModel = joaat('p_pallet_02a_s'),
    MaxPallets = 3,
    DeliveryPrice = 2500, -- payment price for now
    ForkliftSpawns = {
        ['hq'] = vector4(65.98, 127.06, 79.18, 156.5),
        ['lsia'] = vector4(-1225.33, -2360.35, 14.1, 339.02),
    },

    Warehouses = {
        ["hq"] = {
            location = vector3(63.87, 147.81, 80.53),
            storage = 50,
        },
    },

    DropOff = { -- Polyzones and Warehouses Config
        ["hq"] = {
            location = vector3(61.1, 140.21, 80.53),
            heading = 250.0,
            minZ = 79.48,
            maxZ = 82.98,
            length = 9.15,
            width = 2.75,
        },
    },

    Pickups = { -- 
        ["lsia"] = {
            label = 'Los Santos International Airport',
            spawnCoords = {
                vector4(-1218.12, -2357.23, 13.95, 320.0),
                vector4(-1221.22, -2355.32, 13.95, 320.0),
                vector4(-1224.59, -2353.43, 13.95, 320.0),
                vector4(-1228.09, -2351.4, 13.95, 320.0),
                vector4(-1231.78, -2349.23, 13.95, 320.0),
            },
        },    

        --[[ ["SandyAirfield"] = {
            spawnCoords = vector4(1695.09, 3281.54, 41.12, 215.51),
            label = 'Sandy Shores Airfield'
        },
        ["PaletoBay"] = {
            spawnCoords = vector4(90.35, 6363.27, 31.23, 23.63),
            label = 'Paleto Bay Depot'
        },
        ["CityDocks"] = {
            spawnCoords = vector4(132.96, -3216.44, 5.86, 5.06),
            label = 'Walker Logistics'
        }, ]]
    },

    DepositLocations = { -- must match a warehouse
        ['hq'] = vector4(62.63, 127.14, 79.21, 337.16),
    },

    BusinessDeposits = {
        ['glazedandglorious'] = vector4(-606.01, -1059.22, 21.79, 268.13),
        ['nismostuning'] = vector4(-1600.08, -851.86, 9.95, 320.05),
        ['slurpngo'] = vector4(-1418.16, -250.34, 46.38, 45.78),
        ['smokeonthewater'] = vector4(369.71, -827.08, 29.29, 182.99),
        ['vanillaunicorn'] = vector4(139.11, -1277.83, 29.32, 23.6),
        ['bikinitow'] = vector4(841.09, -814.05, 26.32, 188.07),
        ['tenfourtwo'] = vector4(1242.94, -412.36, 68.98, 257.23),
        ['yellowjack'] = vector4(2518.26, 4125.47, 38.62, 154.53),
        ['tequilala'] = vector4(-563.83, 302.52, 83.17, 177.48),
        ['maisonette'] = vector4(-1404.43, -636.66, 28.67, 2.05),
        ['knifeshop'] = vector4(-664.17, 5825.05, 17.33, 230.7), 
        ['glizzycomics'] = vector4(-43.26, -64.7, 59.35, 76.49),
        ['bikedealer'] = vector4(45.56, 6459.79, 31.43, 53.92),
        ['clinic'] = vector4(316.64, -541.04, 28.74, 264.14),
        ['cardealer'] = vector4(-972.02, -2066.2, 9.41, 313.63),
        ['koi'] = vector4(-1020.11, -1465.82, 5.04, 308.76),     
    },

    Containers = {
        ['farming'] = {
            [1] = {
                model = 'prop_boxpile_08a',
                offset = {z = 0.2},
                rotation = {}
            },
            [2] = {
                model = 'prop_watercrate_01',
                offset = {z = 0.25},
                rotation = {}
            },
        },
        ['meat'] = {
            [1] = {
                model = 'v_ind_cf_meatbox',
                offset = {z = 1.1},
                rotation = {}
            },
        },
        ['commercial'] = {
            [1] = {
                model = 'v_ind_cf_boxes',
                offset = {z = 0.97},
                rotation = {}
            },
            [2] = {
                model = 'prop_boxpile_03a',
                offset = {z = 0.25},
                rotation = {},
            },
            [3] = {
                model = 'prop_boxpile_06b',
                offset = {z = 0.25},
                rotation = {},
            },
        },
        ['construction'] = {
            [1] = {
                model = 'prop_conc_blocks01a',
                offset = {z = 0.25},
                rotation = {}
            },
            [2] = {
                model = 'prop_glf_roller',
                offset = {z = 0.25},
                rotation = {}
            },
            [3] = {
                model = 'prop_cons_cements01',
                offset = {z = 0.35},
                rotation = {}
            }
        },
        ['industry'] = {
            [1] = {
                model = 'prop_cratepile_07a_l1',
                offset = {z = 0.57},
                rotation = {}
            },
        },
        ['generic'] = {
            [1] = {
                model = 'prop_box_wood03a',
                offset = {z = 0.25},
                rotation = {}
            },
        }
    },


    StockItems = {
        raw_grains = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        }, 
        raw_corn = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        raw_sugar_cane = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        spices = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        onion = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        lettuce = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        garlic = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        tomato = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        carrot = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        potato = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        rubber = {
            container = 'industry',
            depot = 'farmsell',
            buyprice = 55,
            allowSale = true,
        },
        hops = {
            container = 'farming',
            depot = 'farmsell',
            buyprice = 90,
            allowSale = true,
        },
        -- Ranching --
        raw_beef = {
            container = 'meat',
            depot = 'ranchsell',
            buyprice = 90,
            allowSale = true,
        },
        raw_chicken = {
            container = 'meat',
            depot = 'ranchsell',
            buyprice = 90,
            allowSale = true,
        },
        raw_pork = {
            container = 'meat',
            depot = 'ranchsell',
            buyprice = 90,
            allowSale = true,
        },
        milk = {
            container = 'farming',
            depot = 'ranchsell',
            buyprice = 45,
            allowSale = true,
        },
        egg = {
            container = 'farming',
            depot = 'ranchsell',
            buyprice = 30,
            allowSale = true,
        },
        mushrooms = {
            container = 'farming',
            depot = 'ranchsell',
            buyprice = 30,
            allowSale = true,
        },
        cheese = {
            container = 'farming',
            depot = 'ranchsell',
            buyprice = 25,
            allowSale = true,
        },
        -- mining --
        iron = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 20,
            allowSale = true,
        },
        copper = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 25,
            allowSale = true,
        },
        aluminum = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 30,
            allowSale = true,
        },
        carbon = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 10,
            allowSale = true,
        },
        steel = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 30,
            allowSale = true,
        },
        metalscrap = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 10,
            allowSale = true,
        },
        emerald = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 75,
            allowSale = false,
        },
        ruby = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 65,
            allowSale = false,
        },
        diamond = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 100,
            allowSale = false,
        },
        sapphire = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 65,
            allowSale = false,
        },
        goldbar = {
            container = 'industry',
            depot = 'minesell',
            buyprice = 85,
            allowSale = false,
        },
        -- Mining no store --
        ironore = {
            container = 'industry',
            depot = 'nosale',
            buyprice = 25,
            allowSale = false,
        },
        copperore = {
            container = 'industry',
            depot = 'nosale',
            buyprice = 25,
            allowSale = false,
        },
        aluminumore = {
            container = 'industry',
            depot = 'nosale',
            buyprice = 25,
            allowSale = false,
        },
        uncut_emerald = {
            container = 'industry',
            depot = 'nosale',
            buyprice = 50,
            allowSale = false,
        },
        uncut_ruby = {
            container = 'industry',
            depot = 'nosale',
            buyprice = 40,
            allowSale = false,
        },
        uncut_diamond = {
            container = 'industry',
            depot = 'nosale',
            buyprice = 55,
            allowSale = false,
        },
        uncut_sapphire = {
            container = 'industry',
            depot = 'nosale',
            buyprice = 45,
            allowSale = false,
        },
        -- Imports --
        raw_tobacco = {
            container = 'industry',
            depot = 'imports',
            buyprice = 90,
            allowSale = true,
        },
        raw_fabric = {
            container = 'industry',
            depot = 'imports',
            buyprice = 10,
            allowSale = true,
        },
        fresh_fruits = {
            container = 'industry',
            depot = 'imports',
            buyprice = 10,
            allowSale = true,
        },
        chocolate = {
            container = 'industry',
            depot = 'imports',
            buyprice = 10,
            allowSale = true,
        },
        coffee_grounds = {
            container = 'industry',
            depot = 'imports',
            buyprice = 10,
            allowSale = true,
        },
        raw_salmon = {
            container = 'industry',
            depot = 'imports',
            buyprice = 40,
            allowSale = true,
        },
        water_bottle = {
            container = 'industry',
            depot = 'imports',
            buyprice = 4,
            allowSale = true,
        },
        plastic = {
            container = 'industry',
            depot = 'imports',
            buyprice = 35,
            allowSale = true,
        },
        glass = {
            container = 'industry',
            depot = 'imports',
            buyprice = 50,
            allowSale = true,
        },
        screwdriverset = {
            container = 'industry',
            depot = 'imports',
            buyprice = 150,
            allowSale = true,
        },
        raw_shrimp = {
            container = 'industry',
            depot = 'imports',
            buyprice = 10,
            allowSale = true,
        },
        raw_crab = {
            container = 'industry',
            depot = 'imports',
            buyprice = 10,
            allowSale = true,
        },
        raw_medical = {
            container = 'industry',
            depot = 'imports',
            buyprice = 10,
            allowSale = true,
        },
    }
}