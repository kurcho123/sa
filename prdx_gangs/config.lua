GangConfig = GangConfig or {}

GangConfig.Enabled = true
GangConfig.Debug = false

GangConfig.Gangs = {
    ballas = "Kilo Tray Ballas",
    nismos = "Nismos",
    collective = "Collective",
    srr = "Seven River Rangers",
    madrazo = "Madrazo Inc",
    chaotek = "Chaotek",
    reapers = "Reapers MC"
}

GangConfig.Storage = {
    ["ballas"] = { 
        [1] = {
            location = vector3(101.50, -1930.68, 16.56),
            heading = 306.37,
            stashName = "ballas",
            minZ = 15.56,
            maxZ = 17.36,
            length = 2.00,
            width = 2.00,
        },         
    },
    ["nismos"] = {
        [1] = {
            location = vector3(-1562.1, -369.66, 47.89),
            heading = 354.2,
            stashName = "nismos",
            minZ = 46.58,
            maxZ = 49.0,
            length = 1.0,
            width = 1.2,

        },    
    },
    ["collective"] = { 
        [1] = {
            location = vector3(-101.2, 994.91, 235.33),
            heading = 288.16,
            stashName = "collective",
            minZ = 235.15,
            maxZ = 235.45,
            length = 0.25,
            width = 0.25,
        },
        [2] = {
            location = vector3(1111.08, -2327.24, 31.39),
            heading = 355,
            stashName = "collective",
            minZ = 30.59,
            maxZ = 31.39,
            length = 1.4,
            width = 0.6,
        },    
    },
    ["srr"] = {   
        [1] = {
            location = vector3(97.44, 3596.23, 40.72),
            heading = 95.22,
            stashName = "srr",
            minZ = 39.65,
            maxZ = 42.0,
            length = 0.6,
            width = 2.0,

        },    
    },
    ["madrazo"] = {   
        [1] = {
            location = vector3(505.94, -2756.2, 3.07),
            heading = 57.95,
            stashName = "madrazo",
            minZ = 2.65,
            maxZ = 7.65,
            length = 1.20,
            width = 1.20,
        },    
        [2] = {
            location = vector3(516.69, -2758.57, 6.64),
            heading = 330.0,
            stashName = "madrazo-secondary",
            minZ = 3.44,
            maxZ = 7.44,
            length = 1.25,
            width = 1.40,
        },   
    },
    ["chaotek"] = {   
        [1] = {
            location = vector3(-568.95, 226.68, 74.89),
            heading = 175.9,
            stashName = "chaotek",
            minZ = 73.9,
            maxZ = 75.0,
            length = 1.2,
            width = 3.3,
        },    
    },
    ["reapers"] = {   
        [1] = {
            location = vector3(37.46, 6471.86, 31.9),
            heading = 226.61,
            stashName = "reapers",
            minZ = 31.0,
            maxZ = 32.5,
            length = 0.8,
            width = 0.8,
        },    
    },
}  

GangConfig.Clothing = {
    ["ballas"] = { 
        [1] = {
            location = vector3(75.48, -1956.26, 21.17),
            heading = 229.47,
            minZ = 20.47,
            maxZ = 22.17,
            length = 0.85,
            width = 1.80,
        },     
        [2] = {
            location = vector3(79.96, -1967.58, 21.12),
            heading = 48.59,
            minZ = 20.47,
            maxZ = 22.17,
            length = 0.85,
            width = 0.85,
        },     
        [3] = {
            location = vector3(121.66, -1976.5, 21.33),
            heading = 200.54,
            minZ = 20.47,
            maxZ = 22.17,
            length = 0.85,
            width = 0.85,
        },    
        [4] = {
            location = vector3(132.47, -1922.41, 21.33),
            heading = 300.77,
            minZ = 20.47,
            maxZ = 22.17,
            length = 0.85,
            width = 0.85,
        },     
        [5] = {
            location = vector3(118.66, -1919.0, 21.33),
            heading = 236.11,
            minZ = 20.47,
            maxZ = 22.17,
            length = 0.85,
            width = 0.85,
        },      
    }, 
    ["nismos"] = { 
        [1] = {
            location = vector3(-1559.4030, -405.4908, 49.3296),
            heading = 139.62,
            minZ = 47.02,
            maxZ = 49.72,
            length = 0.70,
            width = 1.60,
        },    
        [2] = {
            location = vector3(-1561.2903, -400.8607, 52.2151),
            heading = 320.39,
            minZ = 50.60,
            maxZ = 53.51,
            length = 0.90,
            width = 1.60,
        }, 
    },
    ["collective"] = { 
        [1] = {
            location = vector3(-59.59, 995.42, 234.4),
            heading = 320,
            minZ = 232.6,
            maxZ = 235.4,
            length = 1.00,
            width = 2.00,
        },
        [2] = {
            location = vector3(1110.97, -2329.82, 31.39),
            heading = 3355,
            minZ = 30.59,
            maxZ = 31.39,
            length = 1,
            width = 1,
        },
    },
    ["srr"] = {   
        [1] = { 
            location = vector3(100.42, 3616.51, 40.91),
            heading = 357.07,
            minZ = 39.55,
            maxZ = 41.8,
            length = 0.9,
            width = 0.9,
        },
    },
    ["madrazo"] = {   
        [1] = {  -- Bunker
            location = vector3(904.83, -3239.84, -98.29),
            heading = 271.0,
            minZ = -100.69,
            maxZ = -96.69,
            length = 3.50,
            width = 1.50,
        },
        [2] = { 
            location = vector3(568.56, -2780.95, 6.09),
            heading = 59.0,
            minZ = 3.49,
            maxZ = 7.49,
            length = 1.00,
            width = 3.40,
        },
        [3] = { 
            location = vector3(557.35, -2774.18, 6.09),
            heading = 59.0,
            minZ = 3.49,
            maxZ = 7.49,
            length = 1.00,
            width = 3.40,
        },
        
    },
    ["chaotek"] = {   
        [1] = { 
            location = vector3(-582.77, 240.3, 74.89),
            heading = 84.96,
            minZ = 73.9,
            maxZ = 76.0,
            length = 0.5,
            width = 3.1,
        },        
    },
    ["reapers"] = {   
        [1] = { 
            location = vector3(42.15, 6465.2, 32.09),
            heading = 227.3,
            minZ = 31.1,
            maxZ = 33.1,
            length = 0.9,
            width = 0.9,
        },        
    },
}  

GangConfig.BossMenu = {
    ["ballas"] = { 
        [1] = {
            location = vector3(84.48, -1926.27, 16.61),
            heading = 29.87,
            minZ = 16.21,
            maxZ = 16.81,
            length = 1.0,
            width = 1.0,
        },         
    },
    ["nismos"] = {
        [1] = {
            location = vector3(-1574.7, -382.2, 52.08),
            heading = 345.25,
            minZ = 51.9,
            maxZ = 52.2,
            length = 0.3,
            width = 0.4,
        },    
    },
    ["collective"] = { 
        [1] = {
            location = vector3(-72.96, 994.68, 234.4), 
            heading = 227,
            minZ = 234.4,
            maxZ = 234.8,
            length = 0.4,
            width = 1.0,
        },
    },
    ["srr"] = {   
        [1] = { 
            location = vector3(100.25, 3613.68, 40.87), 
            heading = 96.82,
            minZ = 40.55,
            maxZ = 41.0,
            length = 0.3,
            width = 0.3,
        },
    },
    ["madrazo"] = {   
        [1] = { 
            location = vector3(544.29, -2782.89, 6.1), 
            heading = 19.01,
            minZ = 5.8,
            maxZ = 6.2,
            length = 0.5,
            width = 0.7,
        },
    },
    ["chaotek"] = {   
        [1] = { 
            location = vector3(-561.75, 227.75, 75.5), 
            heading = 265.57,
            minZ = 75.0,
            maxZ = 76.5,
            length = 0.5,
            width = 2.0,
        },
    },
    ["reapers"] = {   
        [1] = { 
            location = vector3(37.1, 6464.9, 32.09), 
            heading = 348.39,
            minZ = 31.9,
            maxZ = 32.4,
            length = 0.5,
            width = 0.5,
        },
    },
}  