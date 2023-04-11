Config = Config or {}

----[[      Metal detecting      ]]----
Config.metalDetecting = {}
Config.metalDetecting.debug = false
Config.metalDetecting.sounds = false
Config.metalDetecting.boneoffsets = {
    ["w_am_digiscanner"] = {
        bone = 18905,
        offset   = vector3(0.15, 0.1, 0.0),
        rotation = vector3(270.0, 90.0, 80.0),
    },
}
Config.metalDetecting.commonRewards = {
    'plastictrash',
    'metalscrap',
    'copper',
    'bottle',
    'iron',
}
Config.metalDetecting.rareRewards = {
    'lockpick',
    'goldchain',
    'fishinglootbig',
    'fishingkey',
    'puregoldcoin',
    'glass',
}

Config.metalDetecting.zones = {
    [1] = {
        name = "beach1",
        points = {
            vec3(-1137.0, -1678.0, 0.0),
            vec3(-1112.0, -1705.0, 0.0),
            vec3(-1106.0, -1715.0, 0.0),
            vec3(-1146.0, -1742.0, 0.0),
            vec3(-1158.0, -1725.0, 0.0),
            vec3(-1213.0, -1763.0, 0.0),
            vec3(-1227.0, -1791.0, 0.0),
            vec3(-1209.0, -1817.0, 0.0),
            vec3(-1231.0, -1864.0, 0.0),
            vec3(-1540.0, -1271.0, 0.0),
            vec3(-1635.0, -1128.0, 0.0),
            vec3(-1500.0, -967.0, 0.0),
            vec3(-1481.0, -978.0, 0.0),
            vec3(-1508.0, -1023.0, 0.0),
            vec3(-1488.0, -1040.0, 0.0),
            vec3(-1472.0, -1023.0, 0.0),
            vec3(-1450.0, -1038.0, 0.0),
            vec3(-1456.0, -1045.0, 0.0),
            vec3(-1446.0, -1054.0, 0.0),
            vec3(-1405.0, -1081.0, 0.0),
            vec3(-1389.0, -1165.0, 0.0),
            vec3(-1392.0, -1188.0, 0.0),
            vec3(-1356.0, -1282.0, 0.0),
            vec3(-1362.0, -1347.0, 0.0),
            vec3(-1406.0, -1382.0, 0.0),
            vec3(-1387.0, -1446.0, 0.0),
            vec3(-1370.0, -1519.0, 0.0),
            vec3(-1344.0, -1571.0, 0.0),
            vec3(-1241.0, -1725.0, 0.0),
            vec3(-1226.0, -1724.0, 0.0),
            vec3(-1202.0, -1713.0, 0.0),
            vec3(-1154.0, -1677.0, 0.0),
        },
        thickness = 10,
    },
    [2] = {
        name = "beach2",
        points = {
            vec3(-1669.0, -964.0, 0.0),
            vec3(-1689.0, -1001.0, 0.0),
            vec3(-1671.0, -1017.0, 0.0),
            vec3(-1712.0, -1068.0, 0.0),
            vec3(-1723.0, -1060.0, 0.0),
            vec3(-1793.0, -990.0, 0.0),
            vec3(-1743.0, -965.0, 0.0),
            vec3(-1750.0, -949.0, 0.0),
            vec3(-1805.0, -973.0, 0.0),
            vec3(-1814.0, -925.0, 0.0),
            vec3(-1837.0, -879.0, 0.0),
            vec3(-2087.0, -579.0, 0.0),
            vec3(-2120.0, -542.0, 0.0),
            vec3(-2156.0, -487.0, 0.0),
            vec3(-2130.0, -448.0, 0.0),
            vec3(-2056.0, -482.0, 0.0),
            vec3(-1670.0, -813.0, 0.0),
            vec3(-1673.0, -826.0, 0.0),
            vec3(-1735.0, -899.0, 0.0),
            vec3(-1733.0, -912.0, 0.0),
            vec3(-1716.0, -932.0, 0.0),
            vec3(-1707.0, -951.0, 0.0),
        },
        thickness = 25.0,
    },
    [3] = {
        name = "beach3",
        points = {
            vec3(-3262.0, 985.0, 0.0),
            vec3(-3285.0, 984.0, 0.0),
            vec3(-3285.0, 972.0, 0.0),
            vec3(-3310.0, 973.0, 0.0),
            vec3(-3254.0, 1306.0, 0.0),
            vec3(-3226.0, 1334.0, 0.0),
            vec3(-3205.0, 1336.0, 0.0),
            vec3(-3220.0, 1295.0, 0.0),
            vec3(-3219.0, 1272.0, 0.0),
            vec3(-3212.0, 1259.0, 0.0),
            vec3(-3215.0, 1188.0, 0.0),
            vec3(-3231.0, 1130.0, 0.0),
            vec3(-3263.0, 1073.0, 0.0),
            vec3(-3269.0, 1035.0, 0.0),
        },
        thickness = 10.0,
    },
    [4] = {
        name = "beach4",
        points = {
            vec3(-2571.0, 3523.0, 0.0),
            vec3(-2642.0, 3568.0, 0.0),
            vec3(-2569.0, 3715.0, 0.0),
            vec3(-2550.0, 3813.0, 0.0),
            vec3(-2568.0, 3888.0, 0.0),
            vec3(-2555.0, 3923.0, 0.0),
            vec3(-2518.0, 3974.0, 0.0),
            vec3(-2517.0, 4133.0, 0.0),
            vec3(-2411.0, 4345.0, 0.0),
            vec3(-2252.0, 4508.0, 0.0),
            vec3(-2237.0, 4536.0, 0.0),
            vec3(-2202.0, 4608.0, 0.0),
            vec3(-2071.0, 4586.0, 0.0),
            vec3(-1978.0, 4588.0, 0.0),
            vec3(-2015.0, 4547.0, 0.0),
            vec3(-2195.0, 4567.0, 0.0),
            vec3(-2286.0, 4430.0, 0.0),
            vec3(-2281.0, 4395.0, 0.0),
            vec3(-2299.0, 4365.0, 0.0),
            vec3(-2286.0, 4337.0, 0.0),
            vec3(-2294.0, 4326.0, 0.0),
            vec3(-2340.0, 4324.0, 0.0),
            vec3(-2369.0, 4264.0, 0.0),
            vec3(-2415.0, 4214.0, 0.0),
            vec3(-2420.0, 4112.0, 0.0),
            vec3(-2435.0, 4081.0, 0.0),
            vec3(-2407.0, 4034.0, 0.0),
            vec3(-2404.0, 3975.0, 0.0),
        },
        thickness = 12.0,
    },
    [5] = {
        name = "paleto1",
        points = {
            vec3(-632.0, 6187.0, 3.0),
            vec3(-657.0, 6187.0, 3.0),
            vec3(-647.0, 6318.0, 3.0),
            vec3(-603.0, 6390.0, 3.0),
            vec3(-437.0, 6481.0, 3.0),
            vec3(-382.0, 6496.0, 3.0),
            vec3(-258.0, 6616.0, 3.0),
            vec3(-257.0, 6637.0, 3.0),
            vec3(-157.0, 6716.0, 3.0),
            vec3(-140.0, 6712.0, 3.0),
            vec3(-117.0, 6678.0, 3.0),
            vec3(-167.0, 6609.0, 3.0),
            vec3(-186.0, 6589.0, 3.0),
        },
        thickness = 4.0,
    },
    [6] = {
        name = "paleto2",
        points = {
            vec3(154.0, 7040.0, 2.0),
            vec3(189.0, 7085.0, 2.0),
            vec3(415.0, 6894.0, 2.0),
            vec3(408.0, 6856.0, 2.0),
            vec3(470.0, 6773.0, 2.0),
            vec3(657.0, 6697.0, 2.0),
            vec3(731.0, 6643.0, 2.0),
            vec3(823.0, 6664.0, 2.0),
            vec3(957.0, 6613.0, 2.0),
            vec3(1070.0, 6613.0, 2.0),
            vec3(1192.0, 6590.0, 2.0),
            vec3(1268.0, 6624.0, 2.0),
            vec3(1332.0, 6628.0, 2.0),
            vec3(1303.0, 6560.0, 2.0),
            vec3(1183.0, 6552.0, 2.0),
            vec3(1126.0, 6580.0, 2.0),
            vec3(1000.0, 6568.0, 2.0),
            vec3(720.0, 6584.0, 2.0),
            vec3(536.0, 6615.0, 2.0),
            vec3(401.0, 6726.0, 2.0),
            vec3(350.0, 6791.0, 2.0),
            vec3(322.0, 6807.0, 2.0),
            vec3(325.0, 6847.0, 2.0),
        },
        thickness = 4.0,
    },
}


----[[      Gold panning      ]]----

Config.goldPanning = {}
Config.goldPanning.validDirt = { -- I have no idea about the last value. It just works?
        [2409420175] = 1.0,
        [3008270349] = 1.0,
        [3833216577] = 1.0,
        [223086562] = 1.0,
        [1333033863] = 1.0,
        [4170197704] = 1.0,
        [3594309083] = 1.0,
        [2461440131] = 1.0,
        [1109728704] = 1.0,
        [2352068586] = 1.0,
        [1144315879] = 1.0,
        [581794674] = 1.0,
        [2128369009] = 1.0,
        [1045062756] = 1.0,
        [-461750719] = 1.0,
        [-1286696947] = 1.0,
        [-1186320715] = 1.0,
        [-1942898710] = 1.0,
        [1288448767] = 1.0,
        [-1885547121] = 1.0,
        [834144982] = 1.0,
        [509508168] = 1.0,
        [510490462] = 1.0,
}
Config.goldPanning.Rewards = {
    'goldpowder',
    'ironpowder',
    'copperpowder'
}

Config.goldPanning.rewardAmount = {
    ['goldpowder'] = 2,
    ['ironpowder'] = 4,
    ['copperpowder'] = 4,
}