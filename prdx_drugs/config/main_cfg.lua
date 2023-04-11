Config = Config or {}
Config.Debug = false -- enables zone view
Config.MinimumDrugSalePolice = 1
Config.CornerCooldown = math.random(1,3)
Config.PoliceCallChance = 25
Config.SellingDrugs = {
    SuccessChance = 80,
    ScamChance = 18,
    RobberyChance = 0,
    DelayTimer = 3,
    DrugsList = {
        ['weed_small_brick'] = { -- (3k per hour * 2 hours to plant + materials = 15k/20 plants = $750 per plant/10 = 75$)
            PriceMin = 60,
            PriceMax = 80,
            maxAmount = 15,
        },     
        ['cokebaggy'] = { -- (Total Costs: $5,100, Total Time: 3.5 hours)
            PriceMin = 555,
            PriceMax = 680,
            maxAmount = 5,
        },   
        ['crack_baggy'] = { -- (Total Costs: $5,100, Total Time: 3.5 hours)
            PriceMin = 580,
            PriceMax = 710,
            maxAmount = 5,
        },         
        ['moonshine'] = { -- (Total Costs: $300/per, Total Time: 1 hours)
            PriceMin = 330,
            PriceMax = 455,
            maxAmount = 1,
        }, 
    },
}

Config.PlantTables = {
    Weed = {
        TableModel = `bkr_prop_weed_table_01a`,
        BreakDownAmount = 12, -- max breakdown of plant
        TableItem = 'weed_table',
        PlantItem = 'wet_weed',
        BreakdownItem = 'dry_weed',
        Recipes = {'empty_weed_bag', 'weed_small_brick'}
    },
    Coke = {
        TableModel = `bkr_prop_coke_table01a`,
        BreakDownAmount = 12, -- max breakdown of plant
        TableItem = 'coke_table',
        PlantItem = 'wet_coke',
        BreakdownItem = 'dry_coke',
        Recipes = {'empty_weed_bag'}
    }
}

Config.DrugItems = {
    ['joint'] = {
        effects = {stress = -25, food = -25, water = -10},
        visualEffects = {Drug_deadman_blend = 1.0},
        animation = 'joint',
        time = 60,
        toxicity = 0,
    },
    ['cokebaggy'] = {
        effects = {stamina = 1, strength = 1.5, stress = 15},
        visualEffects = {fp_vig_black = 1.0, michealspliff = 0.5},
        animation = 'snort',
        time = 60,
        toxicity = 2.0,
    },
    ['crack_baggy'] = {
        effects = {stamina = 1, notaze = 1, stress = 15},
        visualEffects = {drug_drive_blend01 = 1.0},
        animation = 'pipe',
        time = 60,
        toxicity = 3.0,
    },
    ['xtcbaggy'] = {
        effects = {stamina = 1, stress = -100, speed = 0.66, specialaudio = 2},
        visualEffects = {drug_flying_base = 0.9, drug_flying_02 = 1.0},
        animation = 'pills',
        time = 120,
        toxicity = 1.5,
    },
    ['oxy'] = {
        effects = {health = 25, armor = 15, stress = 25, strength = 1.75},
        visualEffects = {int_tattoo = 1.0, PPOrange01 = 0.9},
        animation = 'pills',
        time = 120,
        toxicity = 4.5,
    },
    ['meth'] = {
        effects = {health = -15, armor = 15, notaze = 1, speed = 1.25},
        visualEffects = {DRUG_gas_huffin = 1.0, glasses_green = 1.0},
        animation = 'pipe',
        time = 60,
        toxicity = 3.5,
    },
    ['moonshine'] = {
        effects = {health = 25, armor = 15, stamina = 1, strength = 1.5, speed = 0.85},
        visualEffects = {heathaze = 0.01, DRUG_2_drive = 1.0},
        animation = 'moonshine',
        time = 120,
        toxicity = 4.0,
    },
}

Config.DrugAnimations = {
    ['joint'] = {
        anim = 'smoke2',
        length = 5000,
        label = 'Smoking...'
    },
    ['bong'] = {
        anim = 'bong',
        length = 8000,
        label = 'Smoking...'
    },
    ['pipe'] = {
        anim = 'smokepipe',
        length = 5000,
        label = 'Smoking...'
    },
    ['pills'] = {
        anim = 'fallover3',
        length = 2000,
        label = 'Taking pill...'
    },
    ['snort'] = {
        anim = 'snortcoke',
        length = 8000,
        label = 'Snorting...'
    },
    ['moonshine'] = {
        anim = 'moonshine',
        length = 10000,
        label = 'Drinking...'
    },
}
