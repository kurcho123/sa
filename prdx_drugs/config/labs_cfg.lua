Config = Config or {}
Config.ActiveLabs = {} -- Autogen
Config.MaxOpenCokeLabs = 1 -- Coke Labs
Config.LabRekeyTimer = 7
Config.DrugLabs = { -- Lab setups
    ['coke'] = {
        insideCoords = vector4(1088.63, -3187.82, -38.99, 180.89),
        pedModels = {'s_m_m_migrant_01'},
        pedScanarios = {'WORLD_HUMAN_HANG_OUT_STREET', 'WORLD_HUMAN_AA_SMOKE', 'WORLD_HUMAN_AA_COFFEE', 'WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT'},
        labStorage = vector4(1094.92, -3192.32, -39.35, 90.0),
        swapZones = {
            {
                label = 'Cocaine Bar Pressing Station',
                coords = vector4(1100.83, -3199.53, -39.11, 90.0),
                stash = 'Cokepressing',
            },
        },
        craftBenches = {
            {
                label = 'Cocaine Paste Mixing Station',
                coords = vector4(1086.58, -3197.38, -39.35, 0.0),
                recipes = {'coke_paste'},
            },
            {
                label = 'Cocaine Packing Station',
                coords = vector4(1095.36, -3195.79, -39.17, 90.0),
                recipes = {'wet_coke_brick', 'cokebaggy'},
            },
            {
                label = 'Cocaine Packing Station',
                coords = vector4(1092.96, -3195.79, -39.17, 90.0),
                recipes = {'wet_coke_brick', 'cokebaggy'},
            },
            {
                label = 'Cocaine Packing Station',
                coords = vector4(1089.99, -3195.79, -39.17, 90.0),
                recipes = {'wet_coke_brick', 'cokebaggy'},
            },
        },
        interior = function ()
            -- Getting the object to interact with
            BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
            -- Setting the style
            BikerCocaine.Style.Set(BikerCocaine.Style.basic)
            -- Setting the security
            BikerCocaine.Security.Set(BikerCocaine.Security.basic)
            -- Refreshing the interior to the see the result
            RefreshInterior(BikerCocaine.interiorId)
        end,
    },
    ['crack'] = {
        insideCoords = vector4(1088.63, -3187.82, -38.99, 0),
        pedModels = {'s_m_m_migrant_01'},
        pedScanarios = {'WORLD_HUMAN_CLIPBOARD', 'WORLD_HUMAN_AA_SMOKE'},
        labStorage = vector4(1094.92, -3192.32, -39.35, 90.0),
        swapZones = {
            {
                label = 'Cocaine Bar Pressing Station',
                coords = vector4(1100.83, -3199.53, -39.11, 0),
                stash = 'Crackpressing',
            },
        },
        craftBenches = {
            {
                label = 'Cocaine Paste Mixing Station',
                coords = vector4(1086.58, -3197.38, -39.35, 0),
                recipes = {'coke_paste'},
            },
            {
                label = 'Packing Station',
                coords = vector4(1095.36, -3195.79, -39.17, 90.0),
                recipes = {'wet_coke_brick', 'cokebaggy', 'crack_baggy'},
            },
            {
                label = 'Packing Station',
                coords = vector4(1092.96, -3195.79, -39.17, 90.0),
                recipes = {'wet_coke_brick', 'cokebaggy', 'crack_baggy'},
            },
            {
                label = 'Packing Station',
                coords = vector4(1089.99, -3195.79, -39.17, 90.0),
                recipes = {'wet_coke_brick', 'cokebaggy', 'crack_baggy'},
            },
            {
                label = 'Crack Mixing Station',
                coords = vector4(1103.27, -3193.75, -39.17, 0),
                recipes = {'crack_paste'},
            },
            {
                label = 'Crack Boiling Station',
                coords = vector4(1099.07, -3199.72, -39.29, 0),
                recipes = {'crack_brick'},
            },
            
        },
        interior = function ()
            -- Getting the object to interact with
            BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
            -- Setting the style
            BikerCocaine.Style.Set(BikerCocaine.Style.basic)
            -- Setting the security
            BikerCocaine.Security.Set(BikerCocaine.Security.basic)
            -- Refreshing the interior to the see the result
            RefreshInterior(BikerCocaine.interiorId)
        end,
    }
}

Config.Interiors = {
    ['crack'] = function ()
        -- Getting the object to interact with
        BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
        -- Setting the style
        BikerCocaine.Style.Set(BikerCocaine.Style.upgrade)
        -- Setting the security
        BikerCocaine.Security.Set(BikerCocaine.Security.basic)
        -- Refreshing the interior to the see the result
        RefreshInterior(BikerCocaine.interiorId)
    end,
    ['coke'] = function ()
        -- Getting the object to interact with
        BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
        -- Setting the style
        BikerCocaine.Style.Set(BikerCocaine.Style.basic)
        -- Setting the security
        BikerCocaine.Security.Set(BikerCocaine.Security.basic)
        -- Refreshing the interior to the see the result
        RefreshInterior(BikerCocaine.interiorId)
    end,
}

Config.PrivateLabs = {
    {
        id = 'Ballas Crack',
        enterCoords = vector4(6.29, -1816.6, 25.35, 230.26),
        owner = {gang = 'ballas', citizenid = 'QCE51214'},
        labType = 'crack',
        instanceid = 880001,
        interior = 'Crack'
    },
}

Config.DrugStageTwo = {
    ['coke'] = {
        intake = 'wet_coke_brick',
        output = 'coke_brick',
        time = 6, -- minutes per item
    },
    ['crack'] = {
        intake = 'wet_coke_brick',
        output = 'coke_brick',
        time = 6, -- minutes per item
    },
}

Config.Labs = { -- Lab spawn locations
    {
        id = 'Postal 1031',
        enterCoords = vector4(1862.09, 3857.23, 36.27, 290.2),
        pedCoords = vector4(1861.52, 3859.2, 36.27, 229.25),
        owner = false,
        code = 0000,
    },
    {
        id = 'Postal 955',
        enterCoords = vector4(2484.02, 3445.93, 51.07, 315.26),
        pedCoords = vector4(2485.38, 3444.91, 51.07, 343.8),
        owner = false,
        code = 0000,
    },
    {
        id = 'Postal 1047',
        enterCoords = vector4(2728.95, 4280.62, 48.96, 90.82),
        pedCoords = vector4(2728.15, 4282.53, 49.13, 112.83),
        owner = false,
        code = 0000,
    },
    {
        id = 'Grapeseed Airfield',
        enterCoords = vector4(1967.05, 4634.22, 41.1, 38.67),
        pedCoords = vector4(1967.96, 4636.09, 40.77, 58.45),
        owner = false,
        code = 0000,
    },
    {
        id = 'Postal 720',
        enterCoords = vector4(1211.27, 1857.49, 78.97, 48.4),
        pedCoords = vector4(1206.0, 1853.72, 78.91, 343.57),
        owner = false,
        code = 0000,
    },
    {
        id = 'Postal 1001',
        enterCoords = vector4(-2521.14, 2310.29, 33.22, 271.78),
        pedCoords = vector4(-2521.06, 2313.18, 33.22, 276.93),
        owner = false,
        code = 0000,
    },
    {
        id = 'Postal 3009',
        enterCoords = vector4(-400.03, 6378.07, 14.06, 29.17),
        pedCoords = vector4(-395.85, 6377.96, 14.01, 299.78),
        owner = false,
        code = 0000,
    },
}
