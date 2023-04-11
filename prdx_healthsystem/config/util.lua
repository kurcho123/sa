Config = Config or {}
Config.Bones = { -- Correspond bone hash numbers to their label
    [0]     = 'CHEST',
    [31085] = 'HEAD',
    [31086] = 'HEAD',
    [39317] = 'NECK',
    [57597] = 'TORSO',
    [23553] = 'TORSO',
    [24816] = 'TORSO',
    [24817] = 'TORSO',
    [24818] = 'TORSO',
    [10706] = 'UPPER BODY',
    [64729] = 'UPPER BODY',
    [11816] = 'LOWER BODY',
    [45509] = 'LEFT ARM',
    [61163] = 'LEFT ARM',
    [18905] = 'LEFT HAND',
    [4089]  = 'LEFT FINGER',
    [4090]  = 'LEFT FINGER',
    [4137]  = 'LEFT FINGER',
    [4138]  = 'LEFT FINGER',
    [4153]  = 'LEFT FINGER',
    [4154]  = 'LEFT FINGER',
    [4169]  = 'LEFT FINGER',
    [4170]  = 'LEFT FINGER',
    [4185]  = 'LEFT FINGER',
    [4186]  = 'LEFT FINGER',
    [26610] = 'LEFT FINGER',
    [26611] = 'LEFT FINGER',
    [26612] = 'LEFT FINGER',
    [26613] = 'LEFT FINGER',
    [26614] = 'LEFT FINGER',
    [58271] = 'LEFT LEG',
    [63931] = 'LEFT LEG',
    [2108]  = 'LEFT FOOT',
    [14201] = 'LEFT FOOT',
    [40269] = 'RIGHT ARM',
    [28252] = 'RIGHT ARM',
    [57005] = 'RIGHT HAND',
    [58866] = 'RIGHT FINGER',
    [58867] = 'RIGHT FINGER',
    [58868] = 'RIGHT FINGER',
    [58869] = 'RIGHT FINGER',
    [58870] = 'RIGHT FINGER',
    [64016] = 'RIGHT FINGER',
    [64017] = 'RIGHT FINGER',
    [64064] = 'RIGHT FINGER',
    [64065] = 'RIGHT FINGER',
    [64080] = 'RIGHT FINGER',
    [64081] = 'RIGHT FINGER',
    [64096] = 'RIGHT FINGER',
    [64097] = 'RIGHT FINGER',
    [64112] = 'RIGHT FINGER',
    [64113] = 'RIGHT FINGER',
    [36864] = 'RIGHT LEG',
    [51826] = 'RIGHT LEG',
    [20781] = 'RIGHT FOOT',
    [52301] = 'RIGHT FOOT',
}

Config.BoneIndexes = { -- Correspond bone labels to their hash number
    ['CHEST'] = 0,
    ['HEAD'] = 31086,
    ['NECK'] = 39317,
    ['TORSO'] = 24818,
    ['UPPER BODY'] = 64729,
    ['LOWER BODY'] = 11816,
    ['LEFT ARM'] = 61163,
    ['LEFT HAND'] = 18905,
    ['LEFT FINGER'] = 26614,
    ['LEFT LEG'] = 63931,
    ['LEFT FOOT'] = 14201,
    ['RIGHT ARM'] = 28252,
    ['RIGHT HAND'] = 57005,
    ['RIGHT FINGER'] = 64113,
    ['RIGHT LEG'] = 51826,
    ['RIGHT FOOT'] = 52301,
}

function drawTxt(msg)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(1100, true)
end