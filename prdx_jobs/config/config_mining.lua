-- -- -- -- -- -- -- -- -- -- -- -- -- --
--            Mining CONFIG            --
-- -- -- -- -- -- -- -- -- -- -- -- -- --
Config = Config or {}
Config.Mining = {
    MaxOreSpawn = 70, -- Max number of ores that will spawn in a given mine, this number is taken by a 1/3 and then randomized per mine
    MineRegenTime =  math.random(10,20) * (60000), -- Minutes math.random(25, 35)
    RegenPercentage = 45, -- Percentage in whole number, at or below this percent of completion and no one in a mine it will regen
    MaxMines = 15, -- Total max amount of virtual mines to generate
    MetalScrapDrop = 22, -- Percent of drop for metal scrap (on smelt) -SIMPLE
    MetalScrapDropAdv = 44, -- Percent of drop for metal scrap (on smelt)
    TeleportInsideLocation = vector4(2908.54, 2735.18, 43.94, 116.76), -- Where to teleport the player inside the mine (Enter)
    TeleportOutsideLocation = vector4(2920.22, 2739.28, 43.98, 279.66), -- Where to teleport the player outside the mine (Leave)
    DrillBitDropChance = 3, -- 3% drop
    DrillbitLevel = 500, -- mining XP 
    ShowDebug = false,


    Locations =  { -- Old
        ['Mine'] = { name = "Davis Quartz Mine", location = vector3(2937.47, 2744.37, 43.35), heading = 61.59, blipTrue = true }, -- The location where you enter the mine 
        ['Smelter'] = {	name = "Smeltery", location = vector3(1112.29, -2009.9, 31.46), blipTrue = false }, -- The location of the smelter
        ['Buyer'] = { name = "Ore Dealer", location = vector3(1085.7,-2001.04,31.41), heading = 323.73, blipTrue = true }, -- The Location of the ore buyer
        ['JewelCut'] = { name = "Jewel Cutting", location = vector3(1077.24, -1984.22, 31.0-0.95), heading = 300.0, blipTrue = false }, -- The Location of the jewel cutting bench. Couldn't decide so left in smeltery
        ['Buyer2'] = { name = "Jewel Dealer", location = vector3(-622.48, -229.69, 38.06), heading = 105.74, blipTrue = true }, -- The Location of the jewel buyer, I left this as Vangelico, others will proabably change to pawn shops
    },
       
    SpawnRates = {
        -- item = multiplier
        ['carbon'] = 19,
        ['copperore'] = 22,
        ['goldore'] = 8,
        ['ironore'] = 23,
        ['aluminumore'] = 23,
        ['gems'] = 5, -- High Value Gems
    },

    MiningTime = {
        -- item = multiplier
        ['copperore'] = math.random(10000, 15000),
        ['ironore'] = math.random(10000, 15000),
        ['aluminumore'] = math.random(10000, 15000),
        ['carbon'] = math.random(20000, 25000),
        ['goldore'] = math.random(30000, 35000),
        ['uncut_emerald'] = math.random(30000, 35000),
        ['uncut_ruby'] = math.random(30000, 35000),
        ['uncut_sapphire'] = math.random(30000, 35000),
        ['uncut_diamond'] = math.random(35000, 45000),
    },

    SmeltingPressures = { -- minigame (I am a dick) -- (SLider 3 - Slider 1) + (100 - Slider 2)
        -- item = multiplier
        ['gold_ring'] = math.random(10, 70),
        ['goldchain'] = math.random(10, 70),
        ['10kgoldchain'] = math.random(10, 70),
        ['copperore'] = math.random(10, 70),
        ['ironore'] = math.random(10, 70),
        ['steel'] = math.random(10, 70),
        ['aluminumore'] = math.random(10, 70),
        ['carbon'] = math.random(10, 70),
        ['goldore'] = math.random(10, 40),
        -- ['uncut_emerald'] = math.random(60, 70),
        -- ['uncut_ruby'] = math.random(70, 80),
        -- ['uncut_sapphire'] = math.random(80, 90),
        -- ['uncut_diamond'] = math.random(90, 100),
    },

    SmeltingRecipes = {
        -- item = multiplier
        ['copperore'] = {
            cost = {
                ['copperore'] = 1,
            },
            drop = 4,
            reward = "copper",
        },
        ['copperpowder'] = {
            cost = {
                ['copperpowder'] = 10,
            },
            drop = 4,
            reward = "copper",
        },
        ['goldore'] = {
            cost = {
                ['goldore'] = 4,
            },
            drop = 1,
            reward = "goldbar",
        },
        ['goldpowder'] = {
            cost = {
                ['goldpowder'] = 10,
            },
            drop = 1,
            reward = "goldbar",
        },
        ['ironore'] = {
            cost = {
                ['ironore'] = 1,
            },
            drop = 8,
            reward = "iron",
        },
        ['ironpowder'] = {
            cost = {
                ['ironpowder'] = 10,
            },
            drop = 4,
            reward = "iron",
        },
        ['aluminumore'] = {
            cost = {
                ['aluminumore'] = 1,
            },
            drop = 4,
            reward = "aluminum",
        },
        ['steel'] = {
            cost = {
                ['iron'] = 5,
                ['carbon'] = 1,
            },
            drop = 5,
            reward = "steel",
        },
        ['gold_ring'] = {
            cost = {
                ['goldbar'] = 1,
                ['iron'] = 1,
            },
            drop = 3,
            reward = "gold_ring",
        },
        ['goldchain'] = {
            cost = {
                ['goldbar'] = 1,
                ['iron'] = 1,
            },
            drop = 3,
            reward = "goldchain",
        },
        ['10kgoldchain'] = {
            cost = {
                ['goldbar'] = 1,
                ['iron'] = 1,
            },
            drop = 2,
            reward = "10kgoldchain",
        },
    },

    CuttingRecipes = {
        -- itemyou wanna make is the key
        ['emerald'] = {
            cost = {
                ['uncut_emerald'] = 1,
            },
            drop = 1, -- Yes I know this will only change per restrt, thats why its here
            reward = "emerald",
        },
        ['ruby'] = {
            cost = {
                ['uncut_ruby'] = 1,
            },
            drop = 1,
            reward = "ruby",
        },
        ['sapphire'] = {
            cost = {
                ['uncut_sapphire'] = 1,
            },
            drop = 1,
            reward = "sapphire",
        },
        ['diamond'] = {
            cost = {
                ['uncut_diamond'] = 1,
            },
            drop = 1,
            reward = "diamond",
        },
    },
    
    --------------
    -- Jewelry --
    --------------
    JewelryRecipes = {
        -- Necklaces --
        ['emerald_necklace'] = {
            cost = {
                ['goldchain'] = 1,
                ['emerald'] = 1,
            },
            drop = 1,
            reward = "emerald_necklace",
        },
        ['ruby_necklace'] = {
            cost = {
                ['goldchain'] = 1,
                ['ruby'] = 1,
            },
            drop = 1,
            reward = "ruby_necklace",
        },
        ['sapphire_necklace'] = {
            cost = {
                ['goldchain'] = 1,
                ['sapphire'] = 1,
            },
            drop = 1,
            reward = "sapphire_necklace",
        },
        ['diamond_necklace'] = {
            cost = {
                ['goldchain'] = 1,
                ['diamond'] = 1,
            },
            drop = 1,
            reward = "diamond_necklace",
        },
        -- Rings --
        ['emerald_ring'] = {
            cost = {
                ['gold_ring'] = 1,
                ['emerald'] = 1,
            },
            drop = 1,
            reward = "emerald_ring",
        },
        ['ruby_ring'] = {
            cost = {
                ['gold_ring'] = 1,
                ['ruby'] = 1,
            },
            drop = 1,
            reward = "ruby_ring",
        },
        ['sapphire_ring'] = {
            cost = {
                ['gold_ring'] = 1,
                ['sapphire'] = 1,
            },
            drop = 1,
            reward = "sapphire_ring",
        },
        ['diamond_ring'] = {
            cost = {
                ['gold_ring'] = 1,
                ['diamond'] = 1,
            },
            drop = 1,
            reward = "diamond_ring",
        },
    },

    SellPricesOres = {  -- Seperate so we can do menu stuff (SET TO 1 FOR TESTING SO THE NOTIFS SHOW THE AMOUNT THEY SOLD)
        -- Ores --
        ['copperore'] = 3,
        ['aluminumore'] = 4,
        ['ironore'] = 3,
        ['goldore'] = 4,
        ['carbon'] = 5,
        ['steel'] = 8,

        -- Ingots --
        ['iron'] = 5,
        ['copper'] = 9,
        ['aluminum'] = 12,
        ['metalscrap'] = 2,

        -- Uncut Gems --
        ['uncut_emerald'] = 3,
        ['uncut_ruby'] = 3,
        ['uncut_diamond'] = 3,
        ['uncut_sapphire'] = 3,
    },

    SellPricesGems = {  -- Seperate so we can do menu stuff
        
        ['goldbar'] = 25,

        -- Gems --
        ['emerald'] = 65,
        ['ruby'] = 55,
        ['diamond'] = 75,
        ['sapphire'] = 50,

        -- Rings --
        ['diamond_ring'] = 225, 
        ['emerald_ring'] = 200,
        ['ruby_ring'] = 190,
        ['sapphire_ring'] = 180,

        -- Necklaces --
        ['diamond_necklace'] = 225,
        ['emerald_necklace'] = 200,
        ['ruby_necklace'] = 190,
        ['sapphire_necklace'] = 180,

        -- Gold Craftings --
        ['gold_ring'] = 75,
        ['goldchain'] = 75,
        ['10kgoldchain'] = 115,
    },
        
    --Mining Store Items
    ShopItems = {
        label = "Mining Store",
        items = {
            [1] = { name = "water_bottle", price = 5, amount = 100 },
            [2] = { name = "sandwich", price = 10, amount = 250 },
            [3] = { name = "bandage", price = 25, amount = 100 },
            [4] = { name = "weapon_flashlight", price = 25, amount = 100 }, 
            [5] = { name = "drill",	price = 500, amount = 100 }, 
            [6] = { name = "handdrill",	price = 750, amount = 100 },
            [7] = { name = "oredictionary", price = 150, amount = 100 }, 
        },
    },

    --This is the new ones location in the quarry
    SmelterInformation = { location = vector3(2921.93, 2653.42, 43.17), sizeX = 2.0, sizeY = 2.5, direction = 270.40},

    --Ore Spawn Locations   
    OreSpawnLocations = {
        --Room 1  (Room Coords: vector3(2879.34, 2694.4, 46.99))
        [1] = vector3(2892.30, 2667.09, 46.08),
        [2] = vector3(2904.72, 2675.47, 46.08),
        [3] = vector3(2887.66, 2679.97, 49.54),
        [4] = vector3(2893.99, 2673.71, 44.50),
        [5] = vector3(2890.56, 2681.09, 44.50),
        [6] = vector3(2891.65, 2686.43, 45.04),
        [7] = vector3(2880.23, 2685.62, 47.44),
        [8] = vector3(2876.81, 2706.64, 48.46), 
        [9] = vector3(2882.25, 2683.74, 50.38),
        [10] = vector3(2866.89, 2695.95, 48.18),

        --Room 2  (Room Coords: vector3(2851.02, 2672.33, 41.22))
        [11] = vector3(2868.04, 2682.53, 47.75),
        [12] = vector3(2860.74, 2671.53, 46.30),
        [13] = vector3(2856.56, 2658.20, 44.09),
        [14] = vector3(2842.99, 2657.51, 41.77),
        [15] = vector3(2842.11, 2664.94, 42.80),
        [16] = vector3(2841.73, 2669.25, 46.34),
        [17] = vector3(2851.16, 2684.12, 46.33),
        [18] = vector3(2855.13, 2687.41, 46.71),
        [19] = vector3(2854.47, 2662.13, 41.11),
        [20] = vector3(2858.53, 2675.75, 43.16),
        [21] = vector3(2845.81, 2670.56, 42.40),

        -- --Room 3 (Room Coords: vector3(2846.44, 2636.36, 37.83))
        [22] = vector3(2865.22, 2632.38, 39.42),
        [23] = vector3(2854.79, 2626.64, 38.70),
        [24] = vector3(2850.52, 2623.91, 37.81),
        [25] = vector3(2844.63, 2618.01, 37.20),
        [26] = vector3(2831.63, 2618.31, 37.87),
        [27] = vector3(2827.71, 2628.07, 39.28),
        [28] = vector3(2834.23, 2641.79, 39.25),
        [29] = vector3(2841.64, 2640.96, 38.61),
        [30] = vector3(2861.34, 2648.86, 42.41),
        [31] = vector3(2866.17, 2643.08, 40.54),

        -- --Room 4 (Room Coords: vector3(2885.9, 2643.61, 38.89))
        [32] = vector3(2872.18, 2643.29, 38.99),
        [33] = vector3(2876.95, 2648.44, 43.65),
        [34] = vector3(2882.30, 2650.70, 44.07),
        [35] = vector3(2894.30, 2649.41, 40.35),
        [36] = vector3(2896.36, 2632.04, 36.93),
        [37] = vector3(2899.04, 2628.55, 37.21),
        [38] = vector3(2888.39, 2636.83, 40.73),
        [39] = vector3(2881.86, 2635.54, 39.76),
        [40] = vector3(2876.36, 2633.51, 40.19),
        [41] = vector3(2888.68, 2651.33, 40.69),

        -- --Room 5 (Room Coords: vector3(2827.0, 2602.66, 33.15))
        [42] = vector3(2838.26, 2608.09, 36.04),
        [43] = vector3(2837.86, 2604.08, 36.04),
        [44] = vector3(2831.22, 2596.02, 36.20),
        [45] = vector3(2825.01, 2588.33, 30.91),
        [46] = vector3(2818.48, 2588.92, 34.10),
        [47] = vector3(2817.22, 2593.55, 32.66),
        [48] = vector3(2817.51, 2600.77, 33.91),
        [49] = vector3(2821.64, 2608.12, 38.19),
        [50] = vector3(2829.75, 2615.56, 38.33),
        [51] = vector3(2828.10, 2611.10, 34.53),

        --Room 6 (Room Coords: vector3(2828.05, 2639.79, 36.91))

        [52] = vector3(2825.98, 2634.75, 39.86),
        [53] = vector3(2815.31, 2632.86, 41.03),
        [54] = vector3(2794.26, 2629.56, 40.43),
        [55] = vector3(2802.27, 2635.11, 37.81),
        [56] = vector3(2818.94, 2636.43, 37.59),
        [57] = vector3(2793.94, 2638.01, 37.73),
        [58] = vector3(2794.42, 2643.43, 40.90),
        [59] = vector3(2803.20, 2644.99, 39.28),
        [60] = vector3(2814.46, 2649.90, 41.48),
        [61] = vector3(2825.42, 2647.05, 40.69),

        --Room 7 (Room Coords: vector3(2915.82, 2706.26, 43.81))
        [62] = vector3(2929.67, 2683.82, 46.20),
        [63] = vector3(2930.13, 2697.16, 45.08),
        [64] = vector3(2920.48, 2707.28, 46.41),
        [65] = vector3(2921.14, 2687.99, 44.66),
        [66] = vector3(2912.52, 2689.05, 48.01),
        [67] = vector3(2909.26, 2698.28, 48.07),
        [68] = vector3(2906.60, 2705.57, 48.01),
        [69] = vector3(2902.14, 2708.59, 48.25),
        [70] = vector3(2907.77, 2723.92, 47.60),
        [71] = vector3(2915.33, 2716.51, 47.14),

    },
    
    --Spawn empty ores on the random holes in the MLO to stop people falling through/scuffing their instance.
    MLOFixerPoints = {
        [1] = vector3(2839.44, 2617.06, 33.86),
        [2] = vector3(2886.68, 2636.48, 41.29),
        [3] = vector3(2912.16, 2709.01, 42.81),
        [4] = vector3(2910.65, 2709.54, 42.37),
        [5] = vector3(2910.57, 2708.58, 43.34),
    }
}
