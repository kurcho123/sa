Config = Config or {}
Config.MinimumDamageCheck = 10 -- Minimum damage done before a check will occur for injuries
Config.ForceInjuryDamage = 30 -- At or above this damage amount forces an injury no matter what
Config.BleedTimerMultiplier = 35 -- Seconds each blood drop (MAX, its dividded by the level) 
Config.BleedMultiplier = 2-- multiplied by bleeding amount for the amount removed
Config.MaxBleedAmount = 5 -- Max bleed level

Config.DamageClasses = {
    ['NOTHING'] = {
        unconcious = true,
        bleedChance = 0.0,
        limbDamageChance = 0.0,
    },
    ['FALL'] = {
        injuries = {
            'Contusion',
        },
        bleedChance = 0.0,
        limbDamageChance = 0.10,
    },
    ['PUNCH'] = {
        unconcious = true,
        injuries = {
            'Contusion',
        },
        bleedChance = 0.05,
        limbDamageChance = 0.15,
    },
    ['LIGHT_IMPACT'] = {
        unconcious = true,
        injuries = {
            'Contusion',
            'BlockedAirWay',
        },
        bleedChance = 0.0,
        limbDamageChance = 0.15,
    },
    ['HEAVY_IMPACT'] = {
        injuries = {
            'Contusion',
            'BrokenBone',
        },
        bleedChance = 0.25,
        limbDamageChance = 0.65,
    },
    ['SMALL_CALIBER'] = {
        alwaysInjury = 'GunshotWoundSm',
        injuries = {
            'BrokenBone',
        },
        bleedChance = 0.25,
        limbDamageChance = 0.15,
    },
    ['MEDIUM_CALIBER'] = {
        alwaysInjury = 'GunshotWoundMed',
        injuries = {
            'BrokenBone',
            'BrokenNeck',
        },
        bleedChance = 0.50,
        limbDamageChance = 0.25,
    },
    ['SHOTGUN'] = {
        alwaysInjury = 'GunshotWoundSg',
        injuries = {
            'BrokenBone',
            'DeepCut',
            'BrokenNeck',
        },
        bleedChance = 0.75,
        limbDamageChance = 0.35,
    },
    ['HIGH_CALIBER'] = {
        alwaysInjury = 'GunshotWoundLrg',
        injuries = {
            'BrokenBone',
            'DeepCut',
        },
        bleedChance = 0.75,
        limbDamageChance = 0.45,
    },
    ['WILDLIFE'] = {
        injuries = {
            'DeepCut',
            'StabWound',
        },
        bleedChance = 0.35,
        limbDamageChance = 0.65,
    },
    ['CUTTING'] = {
        alwaysInjury = 'StabWound',
        injuries = {
            'DeepCut',
        },
        bleedChance = 1.00,
        limbDamageChance = 0.85,
    },
    ['EXPLOSIVE'] = {
        injuries = {
            'Contusion',
            'BrokenBone',
            'DeepCut',
            'BlockedAirWay',
        },
        bleedChance = 1.00,
        limbDamageChance = 1.00,
    },
    ['FIRE'] = {
        injuries = {
            'MildDegreeBurns',
        },
        alwaysInjury = 'Burns',
        bleedChance = 0.00,
        limbDamageChance = 1.00,
    },
    ['SUFFOCATING'] = {
        alwaysInjury = 'Suffocate',
        bleedChance = 0.00,
        limbDamageChance = 1.00,
    },
}

Config.Damages = {
    --[[ IGNORE DAMAGE ]]--
    [`WEAPON_STUNGUN`] = Config.DamageClasses['NOTHING'],
    [`WEAPON_SNSPISTOL_MK2`] = Config.DamageClasses['NOTHING'], -- Paintball
    [`WEAPON_SNOWBALL`] = Config.DamageClasses['NOTHING'],

    -- [[ PUNCH ]] --
    [`WEAPON_UNARMED`] = Config.DamageClasses['PUNCH'],

    -- [[ FALL ]] --
    [`WEAPON_FALL`] = Config.DamageClasses['FALL'], -- Fall


    --[[ Small Caliber ]]--
    [`WEAPON_PISTOL`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_COMBATPISTOL`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_APPISTOL`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_COMBATPDW`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_MACHINEPISTOL`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_MICROSMG`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_MINISMG`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_PISTOL_MK2`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_SNSPISTOL`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_VINTAGEPISTOL`] = Config.DamageClasses['SMALL_CALIBER'],
    -- Addons --
    [`WEAPON_G17`] = Config.DamageClasses['SMALL_CALIBER'],
    [`WEAPON_P226`] = Config.DamageClasses['SMALL_CALIBER'],

    --[[ Medium Caliber ]]--
    [`WEAPON_ASSAULTSMG`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_COMPACTRIFLE`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_DOUBLEACTION`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_GUSENBERG`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_HEAVYPISTOL`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_PISTOL50`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_REVOLVER`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_REVOLVER_MK2`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_MARKSMANPISTOL`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_SMG`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_SMG_MK2`] = Config.DamageClasses['MEDIUM_CALIBER'],

    --[[ High Caliber ]]--
    [`WEAPON_ADVANCEDRIFLE`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_BULLPUPRIFLE`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_BULLPUPRIFLE_MK2`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_CARBINERIFLE`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_CARBINERIFLE_MK2`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_ASSAULTRIFLE`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_ASSAULTRIFLE_MK2`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_SPECIALCARBINE`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_SPECIALCARBINE_MK2`] = Config.DamageClasses['MEDIUM_CALIBER'],
    [`WEAPON_COMBATMG`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_COMBATMG_MK2`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYSNIPER`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_HEAVYSNIPER_MK2`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_MARKSMANRIFLE`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_MARKSMANRIFLE_MK2`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_MG`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_MINIGUN`] = Config.DamageClasses['HIGH_CALIBER'],
    [`WEAPON_MUSKET`] = Config.DamageClasses['HIGH_CALIBER'],
    -- Addons --
    [`WEAPON_FBIARB`] = Config.DamageClasses['HIGH_CALIBER'], -- PD AR


    --[[ Shotguns ]]--
    [`WEAPON_ASSAULTSHOTGUN`] = Config.DamageClasses['SHOTGUN'],
    [`WEAPON_BULLUPSHOTGUN`] = Config.DamageClasses['SHOTGUN'],
    [`WEAPON_DBSHOTGUN`] = Config.DamageClasses['SHOTGUN'],
    [`WEAPON_HEAVYSHOTGUN`] = Config.DamageClasses['SHOTGUN'],
    [`WEAPON_PUMPSHOTGUN`] = Config.DamageClasses['SHOTGUN'],
    [`WEAPON_PUMPSHOTGUN_MK2`] = Config.DamageClasses['SHOTGUN'],
    [`WEAPON_SAWNOFFSHOTGUN`] = Config.DamageClasses['SHOTGUN'],
    [`WEAPON_SWEEPERSHOTGUN`] = Config.DamageClasses['SHOTGUN'],

    --[[ Animals ]]--
    [`WEAPON_ANIMAL`] = Config.DamageClasses['WILDLIFE'], -- Animal
    [`WEAPON_COUGAR`] = Config.DamageClasses['WILDLIFE'], -- Cougar

    --[[ Cutting Weapons ]]--
    [`WEAPON_BATTLEAXE`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_BOTTLE`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_DAGGER`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_HATCHET`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_KNIFE`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_MACHETE`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_SWITCHBLADE`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_BARBED_WIRE`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_BLEEDING`] = Config.DamageClasses['CUTTING'],
    [`WEAPON_KATANA`] = Config.DamageClasses['CUTTING'],
    -- Addons --
    [`WEAPON_RAINBOW`] = Config.DamageClasses['CUTTING'], --addon knife for knifeshop
    [`WEAPON_HATCHET_SMITHS`] = Config.DamageClasses['CUTTING'], --addon knife for knifeshop
    [`WEAPON_GUTKNIFE`] = Config.DamageClasses['CUTTING'], --addon knife for knifeshop
    [`WEAPON_BUTTERFLY`] = Config.DamageClasses['CUTTING'], --addon knife for knifeshop
    [`WEAPON_KARAMBIT`] = Config.DamageClasses['CUTTING'], --addon knife for knifeshop
    [`WEAPON_STATGEAR`] = Config.DamageClasses['CUTTING'], --addon knife for knifeshop

    --[[ Light Impact ]]--
    [`WEAPON_KNUCKLE`] = Config.DamageClasses['LIGHT_IMPACT'],
    [`WEAPON_HIT_BY_WATER_CANNON`] = Config.DamageClasses['LIGHT_IMPACT'], -- Water Cannon
    [`WEAPON_ELECTRIC_FENCE`] = Config.DamageClasses['LIGHT_IMPACT'],

    --Glizzy LightSabors
    [`WEAPON_SABERGREEN`] = Config.DamageClasses['LIGHT_IMPACT'],
    [`WEAPON_SABERBLUE`] = Config.DamageClasses['LIGHT_IMPACT'],
    [`WEAPON_SABERRED`] = Config.DamageClasses['LIGHT_IMPACT'],
    [`WEAPON_SABERPURPLE`] = Config.DamageClasses['LIGHT_IMPACT'],
    [`WEAPON_SABERYELLOW`] = Config.DamageClasses['LIGHT_IMPACT'],


    --[[ Heavy Impact ]]--
    [`WEAPON_BAT`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_CROWBAR`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_FIREEXTINGUISHER`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_FIRWORK`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_GOLFLCUB`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_HAMMER`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_PETROLCAN`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_POOLCUE`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_WRENCH`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_RAMMED_BY_CAR`] = Config.DamageClasses['HEAVY_IMPACT'],
    [`WEAPON_RUN_OVER_BY_CAR`] = Config.DamageClasses['HEAVY_IMPACT'],

    --addon weapon for cayotec
    [`WEAPON_COLBATON`] = Config.DamageClasses['HEAVY_IMPACT'],

    --[[ Explosives ]]--
    [`WEAPON_EXPLOSION`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_GRENADE`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_COMPACTLAUNCHER`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_HOMINGLAUNCHER`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_PIPEBOMB`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_PROXMINE`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_RPG`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_STICKYBOMB`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_HELI_CRASH`] = Config.DamageClasses['EXPLOSIVE'],
    [`WEAPON_RAILGUN`] = Config.DamageClasses['EXPLOSIVE'],

    --[[ Fire ]]--
    [`WEAPON_FIRE`] = Config.DamageClasses['FIRE'],
    [`WEAPON_MOLOTOV`] = Config.DamageClasses['FIRE'],
    [`WEAPON_FLARE`] = Config.DamageClasses['FIRE'],
    [`WEAPON_FLAREGUN`] = Config.DamageClasses['FIRE'],

    --[[ Suffocate ]]--
    [`WEAPON_DROWNING`] = Config.DamageClasses['SUFFOCATING'], -- Drowning
    [`WEAPON_DROWNING_IN_VEHICLE`] = Config.DamageClasses['SUFFOCATING'], -- Drowning Veh
    [`WEAPON_EXHAUSTION`] = Config.DamageClasses['SUFFOCATING'], -- Exhaust
    [`WEAPON_BZGAS`] = Config.DamageClasses['SUFFOCATING'],
    [`WEAPON_SMOKEGRENADE`] = Config.DamageClasses['SUFFOCATING'],
    
}