Config = {}
Config.JackModel = 'xs_prop_x18_engine_hoist_02a'
Config.EngineModelModded = `prop_car_engine_01`
Config.EngineModelStock = `imp_prop_impexp_engine_part_01a`
Config.TurboPart = 'turbocharger'
Config.Debug = false

-- NITROUS --
Config.NitrousPrice = 20 -- per 1 percent ($200 per bottle sell for $250 per refill) 50 refills
Config.NitrousParts = {
    nitrous_system_1 = 1,
    nitrous_system_2 = 2,
    nitrous_system_3 = 3
}
Config.NitrousStations = {
    ['nismostuning'] = {
        Name = 'Nismos Repair',
        Coords = vector4(-1602.57, -840.99, 10.08, 225.96),
        Capacity = 5000
    },
    ['bikinitow'] = {
        Name = 'Bikini Automotive',
        Coords = vector4(838.39, -804.29, 26.37, 268.47),
        Capacity = 5000
    },
    ['bikedealer'] = {
        Name = 'Reapers Bike Shop',
        Coords = vector4(39.35, 6497.46, 31.43, 324.71),
        Capacity = 5000
    },
}

-- STOCK ENGINE REPAIR --
Config.StockEngineComponents = { 
    intakemanifold = {
        DamageScaler = 1.0,
        RepairItem = 'iron',
        RepairCost = 1,
    },
    exhaustmanifold = {
        DamageScaler = 1.0,
        RepairItem = 'iron',
        RepairCost = 1,
    },
    pistons = {
        DamageScaler = 1.0,
        RepairItem = 'iron',
        RepairCost = 1,
    },
    camshaft = {
        DamageScaler = 1.0,
        RepairItem = 'iron',
        RepairCost = 2,
    },
    crankshaft = {
        DamageScaler = 1.0,
        RepairItem = 'iron',
        RepairCost = 5,
    },
    engineblock = {
        DamageScaler = 1.0,
        RepairItem = 'iron',
        RepairCost = 6,
    },
    cylinderhead = {
        DamageScaler = 1.0,
        RepairItem = 'iron',
        RepairCost = 4,
    },
    fuelsystem = {
        DamageScaler = 1.0,
        RepairItem = 'iron',
        RepairCost = 2,
    },
    turbocharger = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'iron',
        RepairCost = 1,
    },
    supercharger = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'iron',
        RepairCost = 1,
    },
    nitrous_system_1 = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'steel',
        RepairCost = 1,
    },
    nitrous_system_2 = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'steel',
        RepairCost = 1,
    },
    nitrous_system_3 = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'steel',
        RepairCost = 1,
    },
}

-- MODDED ENGINE REPAIR --
Config.ModdedEngineComponents = { 
    billet_intakemanifold = {
        DamageScaler = 1.0,
        RepairItem = 'steel',
        RepairCost = 2,
    },
    billet_exhaustmanifold = {
        DamageScaler = 1.0,
        RepairItem = 'steel',
        RepairCost = 1,
    },
    billet_pistons = {
        DamageScaler = 1.0,
        RepairItem = 'steel',
        RepairCost = 1,
    },
    billet_camshaft = {
        DamageScaler = 1.0,
        RepairItem = 'steel',
        RepairCost = 2,
    },
    billet_crankshaft = {
        DamageScaler = 1.0,
        RepairItem = 'steel',
        RepairCost = 3,
    },
    billet_engineblock = {
        DamageScaler = 1.0,
        RepairItem = 'steel',
        RepairCost = 5,
    },
    billet_cylinderhead = {
        DamageScaler = 1.0,
        RepairItem = 'steel',
        RepairCost = 4,
    },
    billet_fuelsystem = {
        DamageScaler = 1.0,
        RepairItem = 'steel',
        RepairCost = 2,
    },
    turbocharger = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'steel',
        RepairCost = 1,
    },
    supercharger = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'steel',
        RepairCost = 1,
    },
    nitrous_system_1 = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'steel',
        RepairCost = 1,
    },
    nitrous_system_2 = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'steel',
        RepairCost = 1,
    },
    nitrous_system_3 = {
        DamageScaler = 1.0,
        Optional = true,
        RepairItem = 'steel',
        RepairCost = 1,
    },
}