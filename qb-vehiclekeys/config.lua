Config = {}
Config.HotwireChance = 0.90 -- Chance for successful hotwire or not

Config.RemoveLockpickNormal = 0.5 -- Chance to remove lockpick on fail
Config.RemoveLockpickAdvanced = 0.2 -- Chance to remove advanced lockpick on fail

Config.CarjackingTime = 7500 -- How long it takes to carjack
Config.DelayBetweenCarjackings = 10000 -- Time before you can carjack again

Config.TimeBetweenHotwires = 5000
Config.minHotwireTime = 10000
Config.maxHotwireTime = 25000

Config.AlertCooldown = 30000 -- 30 seconds
Config.PoliceAlertChance = 1.75 -- Chance of alerting police during the day
Config.PoliceNightAlertChance = 1.20 -- Chance of alerting police at night (times:01-06)

Config.ImmuneVehicles = { -- These vehicles cannot be jacked
    `STOCKADE`,
    `CARGOBOB`,
    `JET`,
    `LAZER`,
    `BUZZARD2`,
    `ANNIHILATOR`,
    `SAVAGE`,
    `RHINO`,
    `FIRETRUK`,
    `BLIMP`,
    `CAMPER`,
    `HYDRA`,
    `OPPRESSOR`,
    `technical3`,
    `insurgent3`,
    `apc`,
    `tampa3`,
    `trailersmall2`,
    `halftrack`,
    `hunter`,
    `vigilante`,
    `akula`,
    `khanjali`,
    `caracara`,
    `blimp3`,
    `menacer`,
    `oppressor2`,
    `scramjet`,
    `strikeforce`,
    `cerberus`,
    `cerberus2`,
    `cerberus3`,
    `scarab2`,
    `scarab3`,
    `rrocket`,
    `ruiner2`,
    `deluxo`,  
    `POLICEB`,  
    `POLICE`, 
    `POLICE2`, 
    `POLICE3`, 
    `POLICE4`, 
    `SHERIFF`, 
    `SHERIFF2`, 
    `FIRETRUK`, 
    `frogger`,
}

Config.NoLockVehicles = {}

Config.NoCarjackWeapons = {
    "WEAPON_UNARMED",
    "WEAPON_Knife",
    "WEAPON_Nightstick",
    "WEAPON_HAMMER",
    "WEAPON_Bat",
    "WEAPON_Crowbar",
    "WEAPON_Golfclub",
    "WEAPON_Bottle",
    "WEAPON_Dagger",
    "WEAPON_Hatchet",
    "WEAPON_KnuckleDuster",
    "WEAPON_Machete",
    "WEAPON_Flashlight",
    "WEAPON_SwitchBlade",
    "WEAPON_Poolcue",
    "WEAPON_Wrench",
    "WEAPON_Battleaxe",
    "WEAPON_Grenade",
    "WEAPON_StickyBomb",
    "WEAPON_ProximityMine",
    "WEAPON_BZGas",
    "WEAPON_Molotov",
    "WEAPON_FireExtinguisher",
    "WEAPON_PetrolCan",
    "WEAPON_Flare",
    "WEAPON_Ball",
    "WEAPON_Snowball",
    "WEAPON_SmokeGrenade",
}

Config.CarjackChance = {
    ['2685387236'] = 0.0,   -- melee
    ['416676503'] = 0.1,   -- handguns
    ['337201093'] = 0.3,   -- SMG
    ['860033945'] = 0.5,   -- shotgun
    ['970310034'] = 0.5,   -- assault
    ['1159398588'] = 0.5,  -- LMG
    ['3082541095'] = 0.5,  -- sniper
    ['2725924767'] = 0.5,  -- heavy
    ['1548507267'] = 0.0,   -- throwable
    ['4257178988'] = 0.0,   -- misc
}

Config.ImmuneClasses = {
    [13] = 1, -- Cycles
}

Config.ClassList = {
    [0] = 'easy', -- Compacts
    [1] = 'easy', -- Sedans
    [2] = 'med', -- SUVs
    [3] = 'med', -- Coupes
    [4] = 'med', -- Muscle
    [5] = 'hard', -- Sports Classics
    [6] = 'hard', -- Sports
    [7] = 'codebreaker', -- Super
    [8] = 'med', -- Motorcycles
    [9] = 'hard', -- Off-road
    [10] = 'hard', -- Industrial
    [11] = 'hard', -- Utility
    [12] = 'easy', -- Vans
    [13] = 'easy', -- Cycles
    [14] = 'med', -- Boats
    [15] = 'codebreaker', -- Helicopters
    [16] = 'codebreaker', -- Planes
    [17] = 'easy', -- Service
    [18] = 'codebreaker', -- Emergency
    [19] = 'codebreaker', -- Military
    [20] = 'med', -- Commercial
    [21] = 'hard', -- Trains
}