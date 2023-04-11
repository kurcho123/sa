Config = Config or {}
Config.MinimumPolice = 4
Config.DebugMode = false

Config.Payouts = {
    ['FleecaBank'] = { -- MUST MATCH A COOLDOWN TYPE
        min = 55000,
        max = 65000,
        items = {'goldbar', 'largegoldbar', 'bankroll', 'markedbills'}
    },
    ['PaletoBank'] = { -- MUST MATCH A COOLDOWN TYPE
        min = 95000,
        max = 125000,
        items = {'goldbar', 'largegoldbar', 'bankroll', 'markedbills', 'medinkedbag'}
    },
}

Config.GoldItems = { -- RANK IN ORDER OF BIGGEST PRICE TO SMALLEST
    [1] = {
        item = 'large_goldbar',
        worth = 3500,
    },
    [2] = {
        item = 'goldbar',
        worth = 100,
    },
}

Config.MoneyItems = {
    [1] = {
        item = 'medinkedbag',
        worth = 5000,
    },
    [2] = {
        item = 'markedbills',
        worth = 1500,
    },
    [3] = {
        item = 'bankroll',
        worth = 250,
    },
}

Config.LootItems = {}

Config.Heists = {
    {
        ["label"] = "Fleeca Bank #584",
        ["active"] = false,
        ["doors"] = {
            [1] =  { -- Per door hacks
                ["coords"] = vector4(311.57, -284.0903, 53.974, 259.00),
                ["object"] = `v_ilev_gb_vauldr`,
                ["isOpened"] = false,
                ["isVaultDoor"] = true,
                ["wait"] = 3, -- Minutes door takes to open
                ["heading"] = {
                    closed = 250.0,
                    open = 160.0
                },
                ["hack"] = {
                    item = 'laptop_green',
                    hacktype = 'colormatch', -- code, colormatch, lockpick
                    options = {5, 5000},
                    coords = vector4(311.66, -284.66, 54.4, 252.65), -- must be vec4
                },
            }
        },
        ["cooldown"] = 'FleecaBank',
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                ["coords"] = vector3(315.230, -284.93, 53.1430),
                ["heading"] = 70.00,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
            {
                ["coords"] = vector3(313.480, -283.25, 53.1430),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
        },
        ["camId"] = 21,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(315.2048, -287.468, 54.143),
                ["heading"] = 246.70,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(314.6565, -288.885, 54.143),
                ["heading"] = 246.70,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(313.1488, -289.375, 54.143),
                ["heading"] = 156.90,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(311.7352, -288.875, 54.143),
                ["heading"] = 156.90,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(310.9144, -287.467, 54.143),
                ["heading"] = 66.70,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(311.4365, -286.277, 54.143),
                ["heading"] = 66.70,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    {
        ["label"] = "Fleeca Bank #206",
        ["active"] = false,
        ["doors"] = {
            [1] =  {
                ["coords"] = vector4(148.1218, -1046.60, 30.000, 250.7),
                ["object"] = `v_ilev_gb_vauldr`,
                ["isOpened"] = false,
                ["isVaultDoor"] = true,
                ["wait"] = 3, -- Minutes door takes to open
                ["heading"] = {
                    closed = 250.0,
                    open = 160.0
                },
                ["hack"] = {
                    item = 'laptop_green',
                    hacktype = 'colormatch', -- code, colormatch, lockpick
                    options = {5, 5000},
                    coords = vector4(147.18, -1046.22, 29.55, 249.26) -- must be vec4
                },
            }
        },
        ["cooldown"] = 'FleecaBank',
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                ["coords"] = vector3(149.5361, -1045.02, 28.346),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
            {
                ["coords"] = vector3(150.8701, -1046.30, 28.346),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
        },
        ["camId"] = 22,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(150.5759, -1049.07, 29.346),
                ["heading"] = 250.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(150.0989, -1050.43, 29.346),
                ["heading"] = 250.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(149.0469, -1051.08, 29.346),
                ["heading"] = 155.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(147.3068, -1050.42, 29.346),
                ["heading"] = 155.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(146.5203, -1049.30, 29.346),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(147.0513, -1047.85, 29.346),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    {
        ["label"] = "Fleeca Bank #529",
        ["active"] = false,
        ["doors"] = {
            [1] =  {
                ["coords"] = vector4(-354.00, -55.30, 49.85, 257.45),
                ["object"] = `v_ilev_gb_vauldr`,
                ["isOpened"] = false,
                ["isVaultDoor"] = true,
                ["wait"] = 3, -- Minutes door takes to open
                ["heading"] = {
                    closed = 250.0,
                    open = 160.0
                },
                ["hack"] = {
                    item = 'laptop_green',
                    hacktype = 'colormatch', -- code, colormatch, lockpick
                    options = {5, 5000},
                    coords = vector4(-353.45, -55.44, 49.30, 251.09) -- must be vec4
                },
            }
        },
        ["cooldown"] = 'FleecaBank',

        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                ["coords"] = vector3(-350.955, -54.3646, 48.014),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
            {
                ["coords"] = vector3(-349.708, -55.5932, 48.014),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
        },
        ["camId"] = 23,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(-349.795, -58.2366, 49.014),
                ["heading"] = 250.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(-350.292, -59.6852, 49.014),
                ["heading"] = 250.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(-351.550, -60.3088, 49.014),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(-353.348, -59.6940, 49.014),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(-354.147, -58.5504, 49.014),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(-353.656, -57.0587, 49.014),
                ["heading"] = 70.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    {
        ["label"] = "Fleeca Bank #656",
        ["active"] = false,
        ["doors"] = {
            [1] =  {
                ["coords"] = vector4(-1210.150, -336.350, 37.380, 299.500),
                ["object"] = `v_ilev_gb_vauldr`,
                ["isOpened"] = false,
                ["isVaultDoor"] = true,
                ["wait"] = 3, -- Minutes door takes to open
                ["heading"] = {
                    closed = 296.863,
                    open = 206.863
                },
                ["hack"] = {
                    item = 'laptop_green',
                    hacktype = 'colormatch', -- code, colormatch, lockpick
                    options = {5, 5000},
                    coords = vector4(-1210.5, -336.4, 37.95, 297.28) -- must be vec4
                },
            }
        },
        ["cooldown"] = 'FleecaBank',
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                
                ["coords"] = vector3(-1209.60, -333.876, 36.759),
                ["heading"] = 206.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
            {
                ["coords"] = vector3(-1207.67, -333.946, 36.759),
                ["heading"] = 115.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
        },
        ["camId"] = 24,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(-1205.84, -335.683, 37.759),
                ["heading"] = 290.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(-1205.17, -337.042, 37.759),
                ["heading"] = 290.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(-1205.56, -338.343, 37.759),
                ["heading"] = 205.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(-1207.37, -339.294, 37.759),
                ["heading"] = 205.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(-1208.64, -338.993, 37.759),
                ["heading"] = 115.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(-1209.32, -337.726, 37.759),
                ["heading"] = 115.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    {
        ["label"] = "Fleeca Bank #814",
        ["active"] = false,
        ["doors"] = {
            [1] =  {
                ["coords"] = vector4(-2956.500, 482.075, 15.300, 347.00),
                ["object"] = `hei_prop_heist_sec_door`,
                ["isOpened"] = false,
                ["isVaultDoor"] = true,
                ["wait"] = 3, -- Minutes door takes to open
                ["heading"] = {
                    closed = 357.542,
                    open = 267.542
                },
                ["hack"] = {
                    item = 'laptop_green',
                    hacktype = 'colormatch', -- code, colormatch, lockpick
                    options = {5, 5000},
                    coords = vector4(-2956.58, 481.99, 15.95, 352.71) -- must be vec4
                },
            }
        },
        ["cooldown"] = 'FleecaBank',

        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                ["coords"] = vector3(-2958.34, 484.0975, 14.675),
                ["heading"] = 268.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
            {
                ["coords"] = vector3(-2957.35, 485.6234, 14.675),
                ["heading"] = 178.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
        },
        ["camId"] = 25,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(-2954.89, 486.4198, 15.675),
                ["heading"] = 355.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(-2953.42, 486.3435, 15.675),
                ["heading"] = 355.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(-2952.43, 485.4940, 15.675),
                ["heading"] = 265.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(-2952.58, 483.4612, 15.675),
                ["heading"] = 265.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(-2953.44, 482.3929, 15.675),
                ["heading"] = 180.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(-2954.90, 482.4014, 15.675),
                ["heading"] = 180.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    {
        ["label"] = "Fleeca Bank #940",
        ["active"] = false,
        ["doors"] = {
            [1] =  {
                ["coords"] = vector4(1175.350, 2712.900, 39.350, 84.600),
                ["object"] = `v_ilev_gb_vauldr`,
                ["isOpened"] = false,
                ["isVaultDoor"] = true,
                ["wait"] = 3, -- Minutes door takes to open
                ["heading"] = {
                    closed = 90.542,
                    open = 10.542
                },
                ["hack"] = {
                    item = 'laptop_green',
                    hacktype = 'colormatch', -- code, colormatch, lockpick
                    options = {5, 5000},
                    coords = vector4(1175.63, 2712.89, 38.34, 89.69) -- must be vec4
                },
            }
        },
        ["cooldown"] = 'FleecaBank',

        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                ["coords"] = vector3(1172.139, 2711.782, 37.066),
                ["heading"] = 270.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
            {
                ["coords"] = vector3(1173.668, 2711.000, 37.066),
                ["heading"] = 0.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
        },
        ["camId"] = 25,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(1171.216, 2714.311, 38.066),
                ["heading"] = 90.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(1171.214, 2715.894, 38.066),
                ["heading"] = 90.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(1172.274, 2716.826, 38.066),
                ["heading"] = 360.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(1174.206, 2716.818, 38.066),
                ["heading"] = 360.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(1175.264, 2715.944, 38.066),
                ["heading"] = 270.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(1175.247, 2714.510, 38.066),
                ["heading"] = 270.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
    -- NON-FLEECA --
    {
        ["label"] = "Blaine County Savings Bank",
        ["active"] = false,
        ["doors"] = {
            [1] =  {
                ["coords"] = vector4(-106.060, 6472.420, 31.010, 43.500),
                ["object"] = `v_ilev_cbankvauldoor01`,
                ["isOpened"] = false,
                ["isVaultDoor"] = true,
                ["wait"] = 5, -- Minutes door takes to open
                ["heading"] = {
                    closed = 45.45,
                    open = 163.45,
                    invserse = true
                },
                ["hack"] = {
                    item = 'laptop_blue',
                    hacktype = 'advcolormatch', -- code, colormatch, lockpick, blockmatch, advcolormatch
                    options = {},
                    coords = vector4(-105.79, 6472.14, 31.85, 47.86) -- must be vec4
                },
            }
        },
        ["cooldown"] = 'PaletoBank',

        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                ["coords"] = vector3(-107.038, 6473.670, 30.626),
                ["heading"] = 315.00,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
            {
                ["coords"] = vector3(-107.525, 6475.475, 30.626),
                ["heading"] = 225.0,
                ["isBusy"] = false,
                ["isGrabbed"] = false
            },
        },
        ["camId"] = 25,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(-106.597, 6477.979, 31.626),
                ["heading"] = 40.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(-105.398, 6478.903, 31.649),
                ["heading"] = 40.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(-104.137, 6479.149, 31.626),
                ["heading"] = 310.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(-102.636, 6477.651, 31.678),
                ["heading"] = 310.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(-102.308, 6476.092, 31.626),
                ["heading"] = 220.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(-103.241, 6475.249, 31.647),
                ["heading"] = 220.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
        }
    },
}

--[[ Config.BigBanks = {
    ["pacific"] = {
        ["label"] = "Pacific Standard",
        ["coords"] = {
            [1] = vector3(261.95, 223.11, 106.28),
            [2] = vector4(253.210, 228.30, 101.700, 73.150)
        },
        ["alarm"] = true,
        ["object"] = 961976194,
        ["isVaultDoor"] = true,
                ["heading"] = {
            closed = 160.00001,
            open = 70.00001
        },
        -- Cash/Gold Trolleys
        ["trolleys"] = {
            {
                coords = vector3(266.20, 214.6539, 100.68),
                heading = 70.00,
                grabbed = false
            },
            {
                coords = vector3(265.50, 212.6842, 100.68),
                heading = 70.0,
                grabbed = false
            },
            {
                coords = vector3(263.6069, 216.2170, 100.68),
                heading = 160.0,
                grabbed = false
            },
            {
                coords = vector3(262.2430, 213.1907, 100.68),
                heading = 340.0,
                grabbed = false
            },
        },
        ["thermite"] = {
            [1] = {
                ["coords"] = vector3(252.55, 221.15, 101.68),
                ["heading"] = 160.0,
                ["isOpened"] = false,
            },
            [2] = {
                ["coords"] = vector3(261.15, 215.21, 101.68),
                ["heading"] = 250.0,
                ["isOpened"] = false,
            },
            [3] = {
                ["coords"] = vector3(257.2764, 220.2341, 106.28),
                ["heading"] = 335.0,
                ["isOpened"] = false,
            }
        },
        ["camId"] = 26,
        ["lockers"] = {
            [1] = {
                ["coords"] = vector3(258.1886, 218.5870, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [2] = {
                ["coords"] = vector3(259.4572, 218.0901, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [3] = {
                ["coords"] = vector3(261.0686, 217.5370, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [4] = {
                ["coords"] = vector3(256.6934, 214.6796, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [5] = {
                ["coords"] = vector3(258.2743, 214.1041, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [6] = {
                ["coords"] = vector3(259.7899, 213.6278, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [7] = {
                ["coords"] = vector3(263.1606, 212.3338, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [8] = {
                ["coords"] = vector3(264.2391, 211.9872, 101.68),
                ["heading"] = 160.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [9] = {
                ["coords"] = vector3(266.0842, 213.5762, 101.68),
                ["heading"] = 337.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [10] = {
                ["coords"] = vector3(265.7250, 215.7426, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            },
            [11] = {
                ["coords"] = vector3(264.7821, 216.1715, 101.68),
                ["heading"] = 340.0,
                ["isBusy"] = false,
                ["isOpened"] = false
            }
        }
    }
} ]]

Config.HitsNeeded = 3
Config.PowerStations = {
    [1] = {
        coords = vector4(2778.61, 1554.26, 30.79, 350.28),
        hit = false
    },
    [2] = {
        coords = vector4(2769.67, 1520.92, 30.79, 354.76),
        hit = false
    },
    [3] = {
        coords = vector4(2760.78, 1488.29, 30.79, 343.29),
        hit = false
    },
    -- OLD STATIONS --
    -- [1] = {
    --     coords = vector4(2835.24, 1505.68, 24.72, 160.0),
    --     hit = false
    -- },
    -- [2] = {
    --     coords = vector4(2811.76, 1500.6, 24.72, 338.8),
    --     hit = false
    -- },
    -- [3] = {
    --     coords = vector4(2137.73, 1949.62, 93.78, 176.0),
    --     hit = false
    -- },
    -- [4] = {
    --     coords = vector4(708.92, 117.49, 80.95, 152.5),
    --     hit = false
    -- },
    -- [5] = {
    --     coords = vector4(670.23, 128.14, 80.95, 340.0),
    --     hit = false
    -- },
    -- [6] = {
    --     coords = vector4(692.17, 160.28, 80.94, 162.0),
    --     hit = false
    -- },
    -- [7] = {
    --     coords = vector4(2459.16, 1460.94, 36.2, 3.5),
    --     hit = false
    -- },
    -- [8] = {
    --     coords = vector4(2280.45, 2964.83, 46.75, 267.0),
    --     hit = false
    -- },
    -- [9] = {
    --     coords = vector4(2059.68, 3683.8, 34.58, 303.0),
    --     hit = false
    -- },
    -- [10] = {
    --     coords = vector4(2589.5, 5057.38, 44.91, 17.0),
    --     hit = false
    -- },
    -- [11] = {
    --     coords = vector4(1343.61, 6388.13, 33.4, 90.0),
    --     hit = false
    -- },
    -- [12] = {
    --     coords = vector4(236.61, 6406.1, 31.83, 115.0),
    --     hit = false
    -- },
    -- [13] = {
    --     coords = vector4(-293.1, 6023.54, 31.54, 135.0),
    --     hit = false
    -- }
}

Config.MaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true
}

Config.FemaleNoHandshoes = {
    [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true
}

GrabCash = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'enter', 'enter_bag'},
        {'grab', 'grab_bag', 'grab_cash'},
        {'grab_idle', 'grab_idle_bag'},
        {'exit', 'exit_bag'},
    },
    ['scenes'] = {},
    ['scenesObjects'] = {}
}

LaserDrill = {
    ['animations'] = {
        {'intro', 'bag_intro', 'intro_drill_bit'},
        {'drill_straight_start', 'bag_drill_straight_start', 'drill_straight_start_drill_bit'},
        {'drill_straight_end_idle', 'bag_drill_straight_idle', 'drill_straight_idle_drill_bit'},
        {'drill_straight_fail', 'bag_drill_straight_fail', 'drill_straight_fail_drill_bit'},
        {'drill_straight_end', 'bag_drill_straight_end', 'drill_straight_end_drill_bit'},
        {'exit', 'bag_exit', 'exit_drill_bit'},
    },
    ['scenes'] = {}
}

Trolly = {
    ['objects'] = {
        'hei_p_m_bag_var22_arm_s'
    },
    ['animations'] = {
        {'intro', 'bag_intro'},
        {'grab', 'bag_grab', 'cart_cash_dissapear'},
        {'exit', 'bag_exit'}
    },
    ['scenes'] = {}
}