Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.EnableProne = false
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 10 -- carwash

Config.Class1Weapons = {
    ['weapon_p226'] = true,
    ['weapon_g17'] = true,
    ['weapon_snspistol'] = true,
    ['weapon_flaregun'] = true,
}

Config.Class2Weapons = {
    ["weapon_fbiarb"] = true,
	["weapon_appistol"] = true,
	["weapon_assaultrifle"] = true,
    ["weapon_dbshotgun"] = true, -- One shot break action shotgun
    ["weapon_sawnoffshotgun"] = true, -- Mini pump shotgun
    ["weapon_pistol50"] = true,
    ["weapon_microsmg"] = true,
    ["weapon_compactrifle"] = true,
}

ConsumablesDrink = {
    ["slushie"] = math.random(20, 40),
    ["water_bottle"] = 20,
}

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
        "WORLD_VEHICLE_AMBULANCE",
        "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_POLICE_CAR",
        "WORLD_VEHICLE_POLICE_BIKE",
    },
    ['GROUPS'] = {
        2017590552,
        2141866469,
        1409640232,
        `ng_planes`,
        'GRAPESEED_PLANES',
        "Grapeseed_Planes",
        "LSA_Planes",
        "SANDY_PLANES",
        "ALAMO_PLANES",
        "ARMY_HELI",
        "BLIMP",
        "LOST_BIKERS",
        "MP_POLICE",
        "POLICE_POUND1",
        "POLICE_POUND2",
        "POLICE_POUND3",
        "POLICE_POUND4",
        "POLICE_POUND5",
    }
}

Config.Teleports = {
    --Elevator @ labs
    [1] = {
        [1] = {
            coords = vector4(3540.74, 3675.59, 20.99, 167.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Up'
        },
        [2] = {
            coords = vector4(3540.74, 3675.59, 28.11, 172.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Down'
        },

    },
    --Coke Processing Enter/Exit
    -- [2] = {
    --     [1] = {
    --         coords = vector4(909.49, -1589.22, 30.51, 92.24),
    --         ["AllowVehicle"] = false, 
    --         drawText = '[E] Enter Coke Processing'
    --     },
    --     [2] = {
    --         coords = vector4(1088.81, -3187.57, -38.99, 181.7),
    --         ["AllowVehicle"] = false,
    --         drawText = '[E] Leave'
    --     },
    -- },
}

Config.Pickups = {
    `PICKUP_WEAPON_PISTOL`,
    `PICKUP_WEAPON_COMBATPISTOL`,
    `PICKUP_WEAPON_APPISTOL`,
    `PICKUP_WEAPON_MICROSMG`,
    `PICKUP_WEAPON_SMG`,
    `PICKUP_WEAPON_ASSAULTRIFLE`,
    `PICKUP_WEAPON_CARBINERIFLE`,
    `PICKUP_WEAPON_ADVANCEDRIFLE`,
    `PICKUP_WEAPON_SAWNOFFSHOTGUN`,
    `PICKUP_WEAPON_PUMPSHOTGUN`,
    `PICKUP_WEAPON_ASSAULTSHOTGUN`,
    `PICKUP_WEAPON_SNIPERRIFLE`,
    `PICKUP_WEAPON_HEAVYSNIPER`,
    `PICKUP_WEAPON_MG`,
    `PICKUP_WEAPON_COMBATMG`,
    `PICKUP_WEAPON_GRENADELAUNCHER`,
    `PICKUP_WEAPON_RPG`,
    `PICKUP_WEAPON_MINIGUN`,
    `PICKUP_WEAPON_GRENADE`,
    `PICKUP_WEAPON_STICKYBOMB`,
    `PICKUP_WEAPON_MOLOTOV`,
    `PICKUP_WEAPON_PETROLCAN`,
    `PICKUP_WEAPON_SMOKEGRENADE`,
    `PICKUP_WEAPON_KNIFE`,
    `PICKUP_WEAPON_BAT`,
    `PICKUP_WEAPON_HAMMER`,
    `PICKUP_WEAPON_CROWBAR`,
    `PICKUP_WEAPON_GOLFCLUB`,
    `PICKUP_WEAPON_NIGHTSTICK`,
    `PICKUP_WEAPON_FIREEXTINGUISHER`,
    `PICKUP_WEAPON_LASSO`,
    `PICKUP_WEAPON_LOUDHAILER`,
    `PICKUP_PARACHUTE`,
    `PICKUP_ARMOUR_STANDARD`,
    `PICKUP_HEALTH_STANDARD`,
    `PICKUP_VEHICLE_WEAPON_PISTOL`,
    `PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,
    `PICKUP_VEHICLE_WEAPON_APPISTOL`,
    `PICKUP_VEHICLE_WEAPON_MICROSMG`,
    `PICKUP_VEHICLE_WEAPON_SMG`,
    `PICKUP_VEHICLE_WEAPON_SAWNOFF`,
    `PICKUP_VEHICLE_WEAPON_GRENADE`,
    `PICKUP_VEHICLE_WEAPON_MOLOTOV`,
    `PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,
    `PICKUP_VEHICLE_WEAPON_STICKYBOMB`,
    `PICKUP_VEHICLE_HEALTH_STANDARD`,
    `PICKUP_VEHICLE_ARMOUR_STANDARD`,
    `PICKUP_MONEY_CASE`,
    `PICKUP_MONEY_DEP_BAG`,
    `PICKUP_MONEY_MED_BAG`,
    `PICKUP_MONEY_PAPER_BAG`,
    `PICKUP_PORTABLE_CRATE_UNFIXED`,
    `PICKUP_PORTABLE_PACKAGE`,
    `PICKUP_MONEY_CASE`,
    `PICKUP_AMMO_BULLET_MP`,
    `PICKUP_AMMO_MISSILE_MP`,
    `PICKUP_CAMERA`,
    `PICKUP_CUSTOM_SCRIPT`,
    `PICKUP_HANDCUFF_KEY`,
    `PICKUP_HEALTH_SNACK`,
    `PICKUP_MONEY_PURSE`,
    `PICKUP_MONEY_SECURITY_CASE`,
    `PICKUP_MONEY_VARIABLE`,
    `PICKUP_MONEY_WALLET`,
    `PICKUP_SUBMARINE`,
    `PICKUP_TYPE_INVALID`,
    `PICKUP_MONEY_WALLET`,
    `PICKUP_VEHICLE_CUSTOM_SCRIPT`,
}

Config.Locations = { -- carwash
    [1] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(26.5906, -1392.0261, 27.3634),
    },
    [2] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(167.1034, -1719.4704, 27.2916),
    },
    [3] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-74.5693, 6427.8715, 29.4400),
    },
    [4] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-1200.4, -1720.46, 3.40),
    },
    [5] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(1363.22, 3592.7, 34.41),
    },
    [6] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-699.6325, -932.7043, 17.0139),
    }
}

Config.Permissions = {
    ["serverOne"] = {
        ["veteran"] = "802676956243951628",
        ["vip1"] = "825963785386721310",
        ["vip2"] = "802676956243951629",
        ["vip3"] = "802676956243951630",
        ["tow"] = "823088917749825566",
        ["member"] = "802676956234776634"
    },
    ["staff"] = {
        ["director"] = "802676956247097383",
        ["headadmin"] = "802676956247097382",
        ["admin"] = "802676956247097380",
        ["staff"] = "802676956247097379",
        ["moderator"] = "802676956243951632"
    },
    ["serverTwo"] = {
        ["k9"] = "613678718120099870",
        ["swat"] = "666485825168605209",
        ["lspd"] = "822364599507746856",
        ["bcso"] = "822361997915193344",
        ["sast"] = "821647951142453278",
        ["pd_cid"] = "763155605305163806",
        ["hc"] = "838989591205642272",
        ["marshalls"] = "678477440456065034",
        ["ambulance"] = "571130370389704714",
        ["fire"] = "716055355104428083",
        ["dispatch"] = "571130322314461216",
        ["lawyer"] = "971152607190089729",
        ["judge"] = "927376956796842044",
        ["citycouncil"] = "980887639530016778",
        ["clerk"] = "1020799111903060151",
        ["mayor"] = "980888605805379594"
    }
}

Config.BlacklistedWeapons = {
    [`weapon_advancedrifle`] = true,
	--[`weapon_appistol`] = true,
	-- [`weapon_assaultrifle`] = true,
	[`weapon_assaultrifle_mk2`] = true,
	[`weapon_assaultshotgun`] = true,
	[`weapon_assaultsmg`] = true,
	[`weapon_autoshotgun`] = true,
	--[`weapon_ball`] = true,
	--[`weapon_battleaxe`] = true,
	--[`weapon_bottle`] = true,
	[`weapon_bullpuprifle`] = true,
	[`weapon_bullpuprifle_mk2`] = true,
	[`weapon_bullpupshotgun`] = true,
	[`weapon_bzgas`] = true,
	[`weapon_carbinerifle`] = true,
	[`weapon_carbinerifle_mk2`] = true,
	[`weapon_combatmg`] = true,
	[`weapon_combatmg_mk2`] = true,
	[`weapon_combatpdw`] = true,
	[`weapon_combatpistol`] = true,
	[`weapon_compactlauncher`] = true,
	-- [`weapon_compactrifle`] = true,
	-- [`weapon_dagger`] = true,
	-- [`weapon_dbshotgun`] = true,
	[`weapon_doubleaction`] = true,
	[`weapon_firework`] = true,
	[`weapon_golfclub`] = true,
	[`weapon_grenade`] = true,
	--[`weapon_grenadelauncher`] = "Smoke Launcher",
	[`weapon_gusenberg`] = true,
	--[`weapon_hatchet`] = true,
	[`weapon_heavypistol`] = true,
	[`weapon_heavyshotgun`] = true,
	[`weapon_heavysniper`] = true,
	[`weapon_heavysniper_mk2`] = true,
	[`weapon_hominglauncher`] = true,
	-- [`weapon_knuckle`] = true,
	--[`weapon_machete`] = true,
	[`weapon_machinepistol`] = true,
	[`weapon_marksmanpistol`] = true,
	[`weapon_marksmanrifle`] = true,
	[`weapon_marksmanrifle_mk2`] = true,
	[`weapon_mg`] = true,
	--[`weapon_microsmg`] = true,
	[`weapon_minigun`] = true,
	[`weapon_minismg`] = true,
	[`weapon_molotov`] = true,
	--[`weapon_musket`] = "Hunting Musket",
	[`weapon_pipebomb`] = true,
	[`weapon_pistol`] = true,
	-- [`weapon_pistol50`] = true,
	[`weapon_pistol_mk2`] = true,
	-- [`weapon_poolcue`] = true,
	[`weapon_proxmine`] = true,
	[`weapon_pumpshotgun`] = true,
	[`weapon_pumpshotgun_mk2`] = true,
	[`weapon_railgun`] = true,
	[`weapon_revolver`] = true,
	[`weapon_revolver_mk2`] = true,
	[`weapon_rpg`] = true,
	--[`weapon_sawnoffshotgun`] = true,
	[`weapon_smg`] = true,
	[`weapon_smg_mk2`] = true,
	[`weapon_smokegrenade`] = true,
	-- [`weapon_sniperrifle`] = "Hunting Rifle",
	--[`weapon_snowball`] = true,
	--[`weapon_snspistol`] = true,
	--[`weapon_snspistol_mk2`] = true,
	[`weapon_specialcarbine`] = true,
	[`weapon_specialcarbine_mk2`] = true,
	[`weapon_stickybomb`] = true,
	-- [`weapon_switchblade`] = true,
	[`weapon_vintagepistol`] = true,

	-- DLC CHRISTMAS2018 (v 1604)
	[`weapon_raypistol`] = true,
	[`weapon_raycarbine`] = true,
	[`weapon_rayminigun`] = true,
	--[`weapon_stone_hatchet`] = true,

	-- DLC v2060+ --
	[`weapon_gadgetpistol`] = true,
	[`weapon_ceramicpistol`] = true,
	[`weapon_navyrevolver`] = true,
	[`weapon_combatshotgun`] = true,
	[`weapon_militaryrifle`] = true,
	--[`weapon_hazardcan`] = true,
}

Config.CombineRecipes = {
    [1] = {
        requirements = {'sotw_bong', 'rolling_paper'},
        reward = {item = 'joint_sparkplug', count = 1},
        text = 'Rolling joint',
        duration = 5000,
        anim = {dict = 'anim@amb@business@weed@weed_inspecting_high_dry@', lib = 'weed_inspecting_high_base_inspector'}
    }
}