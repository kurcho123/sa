Config = Config or {}
Config.Job = {}

Config.Job.MobileCrafting = {
    ["slurpngo"] = {   
        [1] = { 
            location = vector3(1530.25, -415.37, 300.00), 
            heading = 346.38,
            minZ = 250.00,
            maxZ = 250.00,
            length = 0.60,
            width = 3.00,
            items = {'sng_coconut_slushy', 'sng_grape_slushy', 'sng_tangerine_slushy', 'sng_melon_slushy', 'sng_strawberry_cream', 'sng_dragon_cream', 'sng_rootbeer_cream', 'sng_banana_cream', 'sng_icepack', 'dough', 'sugar', 'ice_cream', 'flour'}
        },       
    }
}  

Config.Job.Registers = {
    ["yellowjack"] = {
        [1] = { 
            location = vector3(2514.42, 4100.43, -38.66),
            heading = 244.71,
            minZ = -38.7,
            maxZ = -39.1,
            length = 0.5,
            width = 0.4,
        },
        [2] = { 
            location = vector3(2514.42, 4100.43, 38.66),
            heading = 244.71,
            minZ = 38.6,
            maxZ = 39.1,
            length = 0.5,
            width = 0.4,
        },
        [3] = { 
            location = vector3(2519.92, 4109.41, 42.92),
            heading = 335.18,
            minZ = 42.72,
            maxZ = 43.22,
            length = 0.4,
            width = 0.6,
        },
    },
    ["glazedandglorious"] = {
        [1] = {
            location = vector3(-584.03, -1061.46, 22.34),
            heading = 346,
            minZ = 22.34,
            maxZ = 22.54,
            length = 0.3,
            width = 0.5,
        },
        [2] = {
            location = vector3(-584.1, -1058.74, 22.34),
            heading = 10,
            minZ = 22.34,
            maxZ = 22.54,
            length = 0.3,
            width = 0.5,
        },
    },
    ["vanillaunicorn"] = {
        [1] = {
            location = vector3(129.14, -1284.94, 29.27),
            heading = 124.14,
            minZ = 29.27,
            maxZ = 29.75,
            length = 0.5,
            width = 0.5,
        },
        [2] = {
            location = vector3(133.01, -1286.05, 29.27),
            heading = 115.00,
            minZ = 29.30,
            maxZ = 29.72,
            length = 0.60,
            width = 0.5,
        },
    },
    ["tequilala"] = {  
        [1] = {
            location =vector3(-560.72, 289.23, 82.28),
            heading = 265.2,
            minZ = 82.2,
            maxZ = 82.7,
            length = 0.4,
            width = 0.7,
        },
        [2] = {
            location = vector3(-560.81, 286.7, 82.28),
            heading = 265.2,
            minZ = 82.2,
            maxZ = 82.7,
            length = 0.4,
            width = 0.7,
        },
        [3] = {
            location = vector3(-564.18, 284.98, 85.48),
            heading = 85.88,
            minZ = 85.38,
            maxZ = 85.88,
            length = 0.4,
            width = 0.6,
        },
    }, 
    ["smokeonthewater"] = {
        [1] = {
            location = vector3(380.18, -827.86, 29.3),
            heading = 0,
            minZ = 29.3,
            maxZ = 29.7,
            length = 0.6,
            width = 0.6,
        },
        [2] = {
            location = vector3(375.71, -827.89, 29.3),
            heading = 0,
            minZ = 29.3,
            maxZ = 29.7,
            length = 0.6,
            width = 0.6,
        },
    }, 
    ["tenfourtwo"] = {
        [1] = {
            location = vector3(1229.59, -418.36, 67.89),
            heading = 165.52,
            minZ = 67.82,
            maxZ = 68.12,
            length = 0.40,
            width = 0.60,
        },
        -- [2] = {
        --     location = vector3(1230.73, -418.53, 67.89),
        --     heading = 165.52,
        --     minZ = 67.82,
        --     maxZ = 68.12,
        --     length = 0.40,
        --     width = 0.60,
        -- },
    },
    ["nismostuning"] = {
        [1] = {
            location = vector3(-1603.08, -837.21, 10.35),
            heading = 49.13,
            minZ = 10.3,
            maxZ = 10.6,
            length = 0.40,
            width = 0.60,
        },
        -- [2] = {
        --     location = vector3(1230.73, -418.53, 67.89),
        --     heading = 165.52,
        --     minZ = 67.82,
        --     maxZ = 68.12,
        --     length = 0.40,
        --     width = 0.60,
        -- },
    },
    ["bikinitow"] = {
        [1] = {
            location = vector3(831.94, -823.8, 26.35),
            heading = 0,
            minZ = 26.35,
            maxZ = 26.75,
            length =0.4,
            width = 0.4,
        },
    },
    ["slurpngo"] = {
        [1] = {
            --Location somewhere random in the sky to pass the register check
            location = vector3(1229.59, -418.36, 999),
            heading = 165.52,
            minZ = 500.00,
            maxZ = 500.00,
            length = 0.01,
            width = 0.01,
        },
    },
    ["finnistaxi"] = {
        [1] = {
            --Location somewhere random in the sky to pass the register check
            location = vector3(1229.59, -418.36, 999),
            heading = 165.52,
            minZ = 500.00,
            maxZ = 500.00,
            length = 0.01,
            width = 0.01,
        },
    },
    ["paintball"] = {
        [1] = {
            location = vector3(-1047.87, 4916.53, 209.23),
            heading = 3,
            minZ = 208.88,
            maxZ = 209.28,
            length = 0.4,
            width = 0.6,
        },
    },
    ["maisonette"] = {
        [1] = {
            location = vector3(-1393.52, -602.19, 30.32),
            heading = 0,
            minZ = 30.32,
            maxZ = 30.72,
            length = 0.6,
            width = 0.8,
        },
        [2] = {
            location = vector3(-1389.61, -609.3, 30.32),
            heading = 325,
            minZ = 30.37,
            maxZ = 30.77,
            length = 0.6,
            width = 0.6,
        },
        [3] = {
            location = vector3(-1376.47, -627.75, 30.82),
            heading = 303,
            minZ = 30.82,
            maxZ = 31.22,
            length = 0.6,
            width = 0.8,
        },
        [4] = {
            location = vector3(-1379.49, -629.67, 30.82),
            heading = 301,
            minZ = 30.62,
            maxZ = 31.42,
            length = 0.8,
            width = 1.4,
        }
    },
    ["knifeshop"] = {
        [1] = {
            location = vector3(-675.36, 5837.79, 17.34),
            heading = 315,
            minZ = 17.34,
            maxZ = 17.54,
            length = 0.6,
            width = 0.4,
        },
        [2] = {
            location = vector3(-675.32, 5834.24, 17.34),
            heading = 0,
            minZ = 17.34,
            maxZ = 17.54,
            length = 0.4,
            width = 0.6,
        },
    },
    ["glizzycomics"] = {
        [1] = {
            location = vector3(-39.87, -78.48, 56.77),
            heading = 340,
            minZ = 56.77,
            maxZ = 57.17,
            length = 0.8,
            width = 0.6,
        },
        [2] = {
            location = vector3(-38.35, -82.05, 56.77),
            heading = 340,
            minZ = 56.72,
            maxZ = 57.12,
            length = 0.6,
            width = 0.8,
        },
    },
    ["bikedealer"] = {
        [1] = {
            location = vector3(39.96, 6477.63, 31.44),
            heading = 315,
            minZ = 31.44,
            maxZ = 31.84,
            length = 0.6,
            width = 0.6,
        },
    },
    ["clinic"] = {
        [1] = {
            location = vector3(308.42, -593.74, 43.28),
            heading = 320,
            minZ = 43.13,
            maxZ = 43.53,
            length = 0.6,
            width = 0.8,
        },
    },
    ["cardealer"] = {
        [1] = {
            location = vector3(-921.0, -2033.43, 9.51),
            heading = 315,
            minZ = 9.46,
            maxZ = 9.86,
            length = 0.6,
            width = 1,
        },
    },
    ["koi"] = {
        [1] = {
            location = vector3(-1029.36, -1473.05, 5.3),
            heading = 35,
            minZ = 5.35,
            maxZ = 5.75,
            length = 0.4,
            width = 0.8,
        },
        [2] = {
            location = vector3(-1043.28, -1484.05, 5.3),
            heading = 305,
            minZ = 4.35,
            maxZ = 5.35,
            length = 3.4,
            width = 5.8,
        },
        [3] = {
            location = vector3(-1048.52, -1490.52, 5.3),
            heading = 35,
            minZ = 4.89,
            maxZ = 5.69,
            length = 3.6,
            width = 5.8,
        },
        [4] = {
            location = vector3(-1051.43, -1486.18, 5.3),
            heading = 35,
            minZ = 4.81,
            maxZ = 5.81,
            length = 3.4,
            width = 5.8,
        },
        [5] = {
            location = vector3(-1036.48, -1485.85, 5.3),
            heading = 35,
            minZ = 5.0,
            maxZ = 5.4,
            length = 1,
            width = 1,
        },
        [6] = {
            location = vector3(-1033.43, -1483.73, 5.3),
            heading = 35,
            minZ = 4.9,
            maxZ = 5.3,
            length = 1,
            width = 1,
        },
        [7] = {
            location = vector3(-1031.16, -1482.13, 5.3),
            heading = 35,
            minZ = 5.0,
            maxZ = 5.4,
            length = 1,
            width = 1,
        },
        [8] = {
            location = vector3(-1028.15, -1480.03, 5.3),
            heading = 35,
            minZ = 5.1,
            maxZ = 5.5,
            length = 1,
            width = 1,
        },
        [9] = {
            location = vector3(-1041.05, -1486.12, 9.05),
            heading = 35,
            minZ = 8.69,
            maxZ = 9.09,
            length = 1.4,
            width = 2.8,
        },
        [10] = {
            location = vector3(-1042.96, -1483.39, 9.05),
            heading = 35,
            minZ = 8.49,
            maxZ = 9.09,
            length = 1.4,
            width = 2.8,
        },
        [11] = {
            location = vector3(-1044.82, -1480.72, 9.05),
            heading = 35,
            minZ = 8.49,
            maxZ = 9.09,
            length = 1.4,
            width = 2.8,
        },
    },
    
    ["ambulance"] = {
        [1] = {
            --Location somewhere random in the sky to pass the register check
            location = vector3(1229.59, -418.36, 999),
            heading = 165.52,
            minZ = 500.00,
            maxZ = 500.00,
            length = 0.01,
            width = 0.01,
        },
    },

    ["government"] = {
        [1] = {
            location = vector3(-543.57, -198.08, 38.23),
            heading = 345,
            minZ = 38.23,
            maxZ = 38.63,
            length = 0.6,
            width = 0.6,
        },
    },
}

Config.Job.Storage = {
    ["yellowjack"] = {
        [1] = { 
            location = vector3(2512.52, 4101.07, 38.58),
            heading = 335,
            stashName = "yellowjack",
            minZ = 37.78,
            maxZ = 38.58,
            length = 1.0,
            width = 0.4,
        },
        [2] = { 
            location = vector3(2520.49, 4108.83, 42.8),
            heading = 315,
            stashName = "yellowjack",
            minZ = 42.05,
            maxZ = 42.45,
            length = 0.6,
            width = 0.6,
        },
    },
    ["glazedandglorious"] = { --
        [1] = {
            location = vector3(-588.11, -1067.11, 22.34),
            heading = 0,
            stashName = "glazedandglorious",
            minZ = 21.34,
            maxZ = 23.54,
            length = 4.0,
            width = 1.2,
        },
        [2] = {
            location = vector3(-590.83, -1058.59, 22.34),
            heading = 90.0,
            stashName = "glazedandglorious",
            minZ = 21.34,
            maxZ = 23.54,
            length = 0.5,
            width = 1.0,
        },
    },
    ["vanillaunicorn"] = {
        [1] = {
            location = vector3(128.62, -1284.15, 29.27),
            heading = 30,
            stashName = "vanillaunicorn",
            minZ = 28.27,
            maxZ = 29.42,
            length = 1.5,
            width = 1.0,
        },
    },
    ["tequilala"] = {
        [1] = {
            location = vector3(-562.7, 288.84, 82.18), 
            heading = 355,
            stashName = "tequilala",
            minZ =81.38,
            maxZ = 82.18,
            length = 1.0,
            width = 0.6,
        },
        [2] = {
            location = vector3(-566.01, 287.09, 85.38), 
            heading = 355,
            stashName = "tequilala",
            minZ =84.68,
            maxZ = 85.48,
            length = 1.0,
            width = 0.6,
        },
    },
    ["smokeonthewater"] = {
        [1] = {
            location = vector3(381.74, -819.65, 29.3),
            heading = 0,
            stashName = "smokeonthewater",
            minZ = 28.3,
            maxZ = 31.0,
            length = 1.9,
            width = 4.6,
        },
    },
    ["gopostal"] = {
        [1] = {
            location = vector3(76.79, 157.96, 80.57),
            heading = 250,
            stashName = "gopostal",
            minZ = 79.27,
            maxZ = 81.07,
            length = 1.7,
            width = 0.75,
        },
    },
    ["tenfourtwo"] = {
        [1] = {
            location = vector3(1235.69, -418.1, 67.77),
            heading = 75.39,
            stashName = "tenfourtwo",
            minZ = 65.77,
            maxZ = 68.77,
            length = 4.00,
            width = 4.00,
        },
    },
    ["nismostuning"] = {
        [1] = {
            location = vector3(-1596.63, -855.65, 10.1),  
            heading = 319.0,
            stashName = "nismostuning",
            minZ = 9.1,
            maxZ = 11.5,
            length = 2.6,
            width = 3.0,
        },
    }, 
    ["bikinitow"] = {
        [1] = {
            location = vector3(837.0, -819.53, 26.33),  
            heading = 0,
            stashName = "bikinitow",
            minZ = 25.53,
            maxZ = 26.53,
            length = 1.8,
            width = 1,
        },
    }, 
    ["realestate"] = {
        [1] = {
            location = vector3(-595.43, -723.22, 116.81),  
            heading = 90.44,
            stashName = "realestate",
            minZ = 116.01,
            maxZ = 116.81,
            length = 1.0,
            width = 3.6,
        },
    }, 
    ["cardealer"] = {
        [1] = {
            location = vector3(-936.32, -2032.39, 9.51),  
            heading = 315,
            stashName = "cardealer",
            minZ = 8.71,
            maxZ = 9.51,
            length = 1.2,
            width = 0.4,
        },
    }, 
    ["paintball"] = {
        [1] = {
            location = vector3(-1045.66, 4918.05, 209.39),  
            heading = 355,
            stashName = "paintball",
            minZ = 207.99,
            maxZ = 209.19,
            length = 1.4,
            width = 1.2,
        },
    }, 
    ["maisonette"] = {
        [1] = {
            location = vector3(-1389.58, -606.28, 30.32),  
            heading = 42,
            stashName = "maisonette",
            minZ = 29.32,
            maxZ = 30.32,
            length = 1.2,
            width = 1,
        },
        [2] = {
            location = vector3(-1377.58, -631.15, 30.82),  
            heading = 34,
            stashName = "maisonette",
            minZ = 29.82,
            maxZ = 30.82,
            length = 1.0,
            width = 1.4,
        },
    },
    ["slurpngo"] = {   
        [1] = {
            --Location somewhere random in the sky
            location = vector3(1229.59, -418.36, 999),
            heading = 165.52,
            stashName = "slurpngo",
            minZ = 500.00,
            maxZ = 500.00,
            length = 0.01,
            width = 0.01,
        },
    },
    ["finnistaxi"] = {
        [1] = {
            location = vector3(892.86, -145.55, 76.89),  
            heading = 42,
            stashName = "finnistaxi",
            minZ = 76.14,
            maxZ = 77.74,
            length = 2.8,
            width = 1,
        },
    },
    ["knifeshop"] = {
        [1] = {
            location = vector3(-672.18, 5834.63, 17.34),  
            heading = 45,
            stashName = "knifeshop",
            minZ = 16.74,
            maxZ = 17.74,
            length = 0.6,
            width = 1,
        },
        [2] = {
            location = vector3(-672.98, 5838.45, 17.34),  
            heading = 45,
            stashName = "knifeshop",
            minZ = 16.54,
            maxZ = 17.54,
            length = 1.4,
            width = 0.4,
        },
    },
    ["glizzycomics"] = {   
        [1] = {      
            location = vector3(-46.25, -90.38, 58.37),
            heading = 340,
            stashName = "glizzycomics",
            minZ = 58.62,
            maxZ = 59.22,
            length = 0.6,
            width = 0.6,
        },
        [2] = {      
            location = vector3(-35.7, -81.01, 56.77),
            heading = 340,
            stashName = "glizzycomics",
            minZ = 55.77,
            maxZ = 56.77,
            length = 1.2,
            width = 1,
        },
    },
    ["bikedealer"] = {   
        [1] = {      
            location = vector3(36.21, 6478.92, 31.44),
            heading = 45,
            stashName = "bikedealer",
            minZ = 30.44,
            maxZ = 31.44,
            length = 1.0,
            width = 0.4,
        },
    },
    ["clinic"] = {   
        [1] = {      
            location = vector3(355.68, -602.81, 43.28),
            heading = 340,
            stashName = "clinic",
            minZ = 42.28,
            maxZ = 44.08,
            length = 0.6,
            width = 1,
        },
        [2] = {      
            location = vector3(312.25, -564.31, 43.28),
            heading = 339,
            stashName = "clinic",
            minZ = 42.88,
            maxZ = 44.28,
            length = 1.0,
            width = 0.6,
        },
    },
    ["koi"] = {   
        [1] = {      
            location = vector3(-1022.53, -1469.82, 5.3),
            heading = 305,
            stashName = "koi",
            minZ = 4.9,
            maxZ = 6.3,
            length = 0.4,
            width = 1,
        },
    },
}

Config.Job.Clothing = {
    ["yellowjack"] = {
        [1] = { 
            location = vector3(2509.13, 4097.39, 38.58),
            heading = 333.54,
            minZ = 38.28,
            maxZ = 39.29,
            length = 0.5,
            width = 1.5,
        },
    },
    ["glazedandglorious"] = {
        [1] = {
            location = vector3(-586.68, -1049.91, 22.34),
            heading = 0.0,
            minZ = 21.34,
            maxZ = 23.94,
            length = 2.6,
            width = 1.8,
        },
    },
    ["vanillaunicorn"] = {
        [1] = {
            location = vector3(104.48, -1302.15, 28.79), 
            heading = 30.0,
            minZ = 27.57,
            maxZ = 30.17,
            length = 0.7,
            width = 1.8,
        },
        [2] = {
            location = vector3(105.8, -1304.59, 28.79), 
            heading = 30.0,
            minZ = 27.57,
            maxZ = 30.17,
            length = 0.7,
            width = 1.8,
        },
    },
    ["tequilala"] = {
        [1] = {
            location = vector3(-564.74, 280.25, 83.12),
            heading = 85.0,
            minZ = 82.0,
            maxZ = 84.20,
            length = 4.0,
            width = 1.0,
        },
    },
    ["smokeonthewater"] = {
        [1] = {
            location = vector3(374.30, -824.56, 29.3),
            heading = 0,
            minZ = 28.3,
            maxZ = 30.2,
            length = 0.8,
            width = 0.8,
        },
    },
    ["gopostal"] = { 
        [1] = {
            location = vector3(71.7, 154.98, 80.57),
            heading = 340,
            minZ = 79.42,
            maxZ = 82.42,
            length = 4.8,
            width = 0.85,
        },
        [2] = {
            location = vector3(4431.99, -4447.03, 7.24), --cayo hanger office
            heading = 20,
            minZ = 6.44,
            maxZ = 7.64,
            length = 0.6,
            width = 1.8,
        },
    },
    ["finnistaxi"] = {   
        [1] = {      
            location = vector3(887.86, -153.51, 76.89),
            heading = 57.43,
            minZ = 75.39,
            maxZ = 77.99,
            length = 0.7,
            width = 2.4,
        },
    },
    ["tennfourtwo"] = {   
        [1] = {      
            location = vector3(1234.05, -418.79, 71.55),
            heading = 344.87,
            minZ = 70.55,
            maxZ = 71.85,
            length = 0.80,
            width = 0.80,
        },
    },
    ["nismostuning"] = {   
        [1] = {      
            location = vector3(-1610.07, -842.06, 10.27),
            heading = 49.0,
            minZ = 9.27,
            maxZ = 11.27,
            length = 1.00,
            width = 1.00,
        },
    },
    ["realestate"] = {   
        [1] = {      
            location = vector3(-581.75, -720.12, 116.8),
            heading = 179.89,
            minZ = 115.80,
            maxZ = 119.20,
            length = 1.00,
            width = 7.20,
        },
    },
    ["beaveraviation"] = {   
        [1] = {      
            location = vector3(1725.37, 3293.95, 41.22),
            heading = 179.89,
            minZ = 40.00,
            maxZ = 43.00,
            length = 1.00,
            width = 1.00,
        },
    },
    ["cardealer"] = {   
        [1] = {      
            location = vector3(-935.29, -2031.55, 9.51),
            heading = 315,
            minZ = 8.91,
            maxZ = 10.51,
            length = 1.00,
            width = 0.4,
        },
    },
    ["maisonette"] = {   
        [1] = {      
            location = vector3(-1384.91, -606.26, 30.32),
            heading = 35,
            minZ = 29.52,
            maxZ = 31.52,
            length = 1.2,
            width = 0.2,
        },
    },
    ["knifeshop"] = {   
        [1] = {      
            location = vector3(-674.93, 5831.66, 17.34),
            heading = 45,
            minZ = 16.69,
            maxZ = 18.09,
            length = 0.8,
            width = 0.6,
        },
    },
    ["glizzycomics"] = {   
        [1] = {      
            location = vector3(-39.93, -91.12, 58.36),
            heading = 340,
            minZ = 57.26,
            maxZ = 59.06,
            length = 1,
            width = 0.2,
        },
    },
    ["bikedealer"] = {   
        [1] = {      
            location = vector3(32.26, 6490.96, 31.44),
            heading = 45,
            minZ = 30.54,
            maxZ = 31.54,
            length = 10.4,
            width = 1.6,
        },
    },
    ["koi"] = {   
        [1] = {      
            location = vector3(-1032.64, -1485.28, 1.64),
            heading = 35,
            minZ = 0.94,
            maxZ = 2.54,
            length = 0.4,
            width = 1.4,
        },
    },
} 

Config.Job.Seating = {
    ["yellowjack"] = --Upstairs Done, Downstairs seats not static.
    {   
        --New  
        [1] = {sitanim = "", sitPos = vector3(2521.65, 4099.47, 38.63), location = vector3(2521.72, 4099.91, 38.58), minZ = 37.71, maxZ = 39.08, heading = 154.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [2] = {sitanim = "", sitPos = vector3(2521.88, 4098.95, 38.63), location = vector3(2522.44, 4098.81, 38.58), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [3] = {sitanim = "", sitPos = vector3(2521.44, 4098.21, 38.63), location = vector3(2522.04, 4098.09, 38.58), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [4] = {sitanim = "", sitPos = vector3(2521.14, 4097.65, 38.63), location = vector3(2521.61, 4097.38, 38.58), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [5] = {sitanim = "", sitPos = vector3(2520.69, 4097.84, 38.63), location = vector3(2520.6, 4097.26, 38.58), minZ = 37.71, maxZ = 39.08, heading = 334.15, length = 0.7, width = 0.7, icon = "fas fa-chair",        },

        [6] = {sitanim = "", sitPos = vector3(2519.82, 4096.01, 38.63), location = vector3(2520.07, 4096.38, 38.51), minZ = 37.71, maxZ = 39.08, heading = 154.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [7] = {sitanim = "", sitPos = vector3(2520.34, 4095.81, 38.63), location = vector3(2520.71, 4095.56, 38.51), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [8] = {sitanim = "", sitPos = vector3(2519.85, 4094.97, 38.63), location = vector3(2520.27, 4094.8, 38.51), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [9] = {sitanim = "", sitPos = vector3(2519.53, 4094.35, 38.63), location = vector3(2520.1, 4094.15, 38.51), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [10] = {sitanim = "", sitPos = vector3(2519.16, 4094.32, 38.63), location = vector3(2518.85, 4093.81, 38.51), minZ = 37.71, maxZ = 39.08, heading = 334.15, length = 0.7, width = 0.7, icon = "fas fa-chair",        }, 

        [11] = {sitanim = "", sitPos = vector3(2518.32, 4092.58, 38.63), location = vector3(2518.5, 4092.99, 38.62), minZ = 37.71, maxZ = 39.08, heading = 154.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [12] = {sitanim = "", sitPos = vector3(2518.49, 4092.23, 38.63), location = vector3(2519.08, 4092.09, 38.62), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [13] = {sitanim = "", sitPos = vector3(2518.22, 4091.54, 38.63), location = vector3(2518.64, 4091.38, 38.62), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [14] = {sitanim = "", sitPos = vector3(2517.84, 4090.81, 38.63), location = vector3(2518.24, 4090.6, 38.62), minZ = 37.71, maxZ = 39.08, heading = 63.01, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [15] = {sitanim = "", sitPos = vector3(2517.4, 4090.85, 38.63), location = vector3(2517.21, 4090.43, 38.62), minZ = 37.71, maxZ = 39.08, heading = 334.15, length = 0.7, width = 0.7, icon = "fas fa-chair",        },

        [16] = {sitanim = "", sitPos = vector3(2509.61, 4094.12, 38.58), location = vector3(2509.21, 4094.34, 38.58), minZ = 37.71, maxZ = 39.08, heading = 243.92, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [17] = {sitanim = "", sitPos = vector3(2509.95, 4094.84, 38.58), location = vector3(2509.53, 4095.01, 38.58), minZ = 37.71, maxZ = 39.08, heading = 243.92, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [18] = {sitanim = "", sitPos = vector3(2513.87, 4102.62, 38.58), location = vector3(2513.34, 4102.91, 38.58), minZ = 37.71, maxZ = 39.08, heading = 243.92, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        [19] = {sitanim = "", sitPos = vector3(2514.22, 4103.41, 38.58), location = vector3(2513.84, 4103.64, 38.58), minZ = 37.71, maxZ = 39.08, heading = 243.92, length = 0.7, width = 0.7, icon = "fas fa-chair",        },
        
    },
    ["glazedandglorious"] = -- Done
    {   --Striped Couches
        [1] = {sitanim = "timetable@jimmy@mics3_ig_15@", sitclip = "idle_a_jimmy", sitPos = vector3(-583.61, -1049.43, 23.3), location = vector3(-583.49, -1049.48, 21.59), minZ = 20.59, maxZ = 22.69, heading = 211.29, length = 1.0, width = 1.0, icon = "fas fa-chair",},
        [2] = {sitanim = "amb@world_human_stupor@male@idle_a", sitclip = "idle_a", sitPos = vector3(-582.32, -1049.4, 23.3), location = vector3(-582.32, -1049.4, 21.59), minZ = 20.59, maxZ = 22.69, heading = 137.23, length = 1.0, width = 1.0, icon = "fas fa-chair",},
        --Fireplace Chairs
        [3] = {sitanim = "",     sitPos = vector3(-580.29, -1051.11, 22.35), location = vector3(-580.87, -1051.25, 21.59), minZ = 20.59, maxZ = 22.59, heading = 283.30, length = 1.0, width = 1.0, icon = "fas fa-chair",},
        [4] = {sitanim = "",     sitPos = vector3(-579.5, -1052.05, 22.35), location = vector3(-579.72, -1052.44, 21.59), minZ = 20.59, maxZ = 22.59, heading = 331.30, length = 1.0, width = 1.0, icon = "fas fa-chair",},
        [5] = {sitanim = "",     sitPos = vector3(-577.93, -1052.14, 22.35), location = vector3(-577.64, -1052.48, 21.59), minZ = 20.59, maxZ = 22.59, heading = 40.30, length = 1.0, width = 1.0, icon = "fas fa-chair",},
        [6] = {sitanim = "",     sitPos = vector3(-577.47, -1051.15, 22.35), location = vector3(-576.89, -1051.01, 21.59), minZ = 20.59, maxZ = 22.59, heading = 103.30, length = 1.0, width = 1.0, icon = "fas fa-chair",},
        --Sittable Cushions
        [7] = {sitanim = "amb@world_human_stupor@male@idle_a", sitclip = "idle_a", sitPos = vector3(-582.2, -1054.72, 22.53), location = vector3(-582.2, -1054.72, 21.36), minZ = 21.09, maxZ = 21.59, heading = 255.25, length = 1.1, width = 1.1, icon = "fas fa-chair",},
        [8] = {sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork",  sitPos = vector3(-582.08, -1056.01, 22.53), location = vector3(-582.08, -1056.01, 21.36), minZ = 21.09, maxZ = 21.59, heading = 290.14, length = 1.1, width = 1.1, icon = "fas fa-chair",},
        [9] = {sitanim = "anim@heists@fleeca_bank@ig_7_jetski_owner", sitclip = "owner_idle", sitPos = vector3(-576.48, -1056.3, 22.53), location = vector3(-576.48, -1056.3, 21.36), minZ = 21.09, maxZ = 21.59, heading = 288.91, length = 1.1, width = 1.1, icon = "fas fa-chair",},
        [10] = {sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork", sitPos = vector3(-576.53, -1054.89, 22.53), location = vector3(-576.53, -1054.89, 21.36), minZ = 21.09, maxZ = 21.59, heading = 257.66, length = 1.1, width = 1.1, icon = "fas fa-chair",},
        [11] = {sitanim = "rcm_barry3", sitclip = "barry_3_sit_loop", sitPos = vector3(-574.01, -1054.93, 22.53), location = vector3(-574.01, -1054.93, 21.36), minZ = 21.09, maxZ = 21.59, heading = 111.54, length = 1.1, width = 1.1, icon = "fas fa-chair",},
        [12] = {sitanim = "amb@world_human_stupor@male@idle_a", sitclip = "idle_a",sitPos = vector3(-574.09, -1056.31, 22.53), location = vector3(-574.09, -1056.31, 21.36), minZ = 21.09, maxZ = 21.59, heading = 70.15, length = 1.1, width = 1.1, icon = "fas fa-chair",},
        --Upstairs Hallway Couch
        [13] = {sitanim = "", sitPos = vector3(-573.07, -1052.11, 26.61), location = vector3(-573.67, -1052.11, 25.96), minZ = 25.81, maxZ = 26.51, heading = 270.18, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [14] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(-572.92, -1052.86, 26.61), location = vector3(-573.52, -1052.84, 25.96), minZ = 25.81, maxZ = 26.51, heading = 268.23, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [15] = {sitanim = "", sitPos = vector3(-573.06, -1053.72, 26.61), location = vector3(-573.51, -1053.73, 25.96), minZ = 25.81, maxZ = 26.51, heading = 270.85, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        --Upstairs Room Big Sofa
        [16] = {sitanim = "", sitPos = vector3(-570.44, -1066.01, 26.62), location = vector3(-569.84, -1066.03, 26.16), minZ = 25.81, maxZ = 26.51, heading = 87.75, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [17] = {sitanim = "", sitPos = vector3(-570.27, -1066.94, 26.62), location = vector3(-569.67, -1066.93, 26.16), minZ = 25.81, maxZ = 26.51, heading = 90.75, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [18] = {sitanim = "", sitPos = vector3(-570.22, -1067.66, 26.62), location = vector3(-569.77, -1067.67, 26.16), minZ = 25.81, maxZ = 26.51, heading = 87.75, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [19] = {sitanim = "", sitPos = vector3(-570.31, -1068.52, 26.62), location = vector3(-569.71, -1068.54, 26.16), minZ = 25.81, maxZ = 26.51, heading = 87.75, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [20] = {sitanim = "", sitPos = vector3(-570.77, -1068.71, 26.62), location = vector3(-570.76, -1069.46, 26.16), minZ = 25.81, maxZ = 26.51, heading = 0.75, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [21] = {sitanim = "", sitPos = vector3(-571.37, -1068.75, 26.62), location = vector3(-571.4, -1069.5, 26.16), minZ = 25.81, maxZ = 26.51, heading = 0.75, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [22] = {sitanim = "", sitPos = vector3(-572.21, -1068.69, 26.62), location = vector3(-572.2, -1069.44, 26.16), minZ = 25.81, maxZ = 26.51, heading = 0.75, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [23] = {sitanim = "", sitPos = vector3(-573.03, -1068.72, 26.62), location = vector3(-572.98, -1069.46, 26.16), minZ = 25.81, maxZ = 26.51, heading = 0.75, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        --Office Window Seat
        [24] = {sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork", sitPos = vector3(-576.69, -1069.43, 27.26), location = vector3(-576.69, -1069.43, 26.50), minZ = 26.00, maxZ = 27.00, heading = 78.64, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [25] = {sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork", sitPos = vector3(-579.32, -1069.18, 27.26), location = vector3(-579.32, -1069.18, 26.50), minZ = 26.00, maxZ = 27.00, heading = 269.55, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        --Upstairs Office Couch
        [26] = {sitanim = "", sitPos = vector3(-578.81, -1058.55, 26.61), location = vector3(-578.81, -1057.95, 26.06), minZ = 25.51, maxZ = 26.61, heading = 180.70, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [27] = {sitanim = "", sitPos = vector3(-578.12, -1058.41, 26.61), location = vector3(-578.13, -1057.96, 26.06), minZ = 25.51, maxZ = 26.61, heading = 180.70, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [28] = {sitanim = "", sitPos = vector3(-577.21, -1058.46, 26.61), location = vector3(-577.21, -1058.01, 26.06), minZ = 25.51, maxZ = 26.61, heading = 180.70, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        --Window Benches (Left)
        [29] = {sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork", sitPos = vector3(-576.6, -1069.34, 23.01), location = vector3(-576.6, -1069.34, 22.01), minZ = 21.51, maxZ = 22.51, heading = 88.39, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [30] = {sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork", sitPos = vector3(-578.0, -1069.4, 22.99), location = vector3(-578.0, -1069.4, 22.01), minZ = 21.51, maxZ = 22.51, heading = 274.15, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        [31] = {sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork", sitPos = vector3(-578.9, -1069.3, 22.99), location = vector3(-578.9, -1069.3, 22.01), minZ = 21.51, maxZ = 22.51, heading = 350.83, length = 0.9, width = 0.9, icon = "fas fa-chair",},
        --Window Benches (Right)
        [32] = { sitanim = "amb@world_human_sunbathe@female@back@base", sitclip = "base", sitPos = vector3(-583.41, -1069.54, 22.99), location = vector3(-583.41, -1069.54, 22.01), minZ = 21.51, maxZ = 22.51, heading = 272.26, length = 0.9, width = 0.9, icon = "fas fa-chair", },
        [33] = { sitanim = "timetable@jimmy@mics3_ig_15@", sitclip = "idle_a_jimmy", sitPos = vector3(-585.55, -1069.26, 22.99), location = vector3(-585.55, -1069.26, 22.01), minZ = 21.51, maxZ = 22.51, heading = 275.25, length = 0.9, width = 0.9, icon = "fas fa-chair",        },
        --Downstairs Bar Stools
        [34] = { sitanim = "", sitPos = vector3(-586.65, -1067.67, 22.65), location = vector3(-586.35, -1067.68, 21.91), minZ = 21.51, maxZ = 22.31, heading = 88.12, length = 0.45, width = 0.45, icon = "fas fa-chair",        },
        [35] = { sitanim = "", sitPos = vector3(-586.63, -1066.7, 22.65), location = vector3(-586.33, -1066.69, 21.91), minZ = 21.51, maxZ = 22.31, heading = 88.12, length = 0.45, width = 0.45, icon = "fas fa-chair",        },
        [36] = { sitanim = "", sitPos = vector3(-586.63, -1065.66, 22.65), location = vector3(-586.33, -1065.67, 21.91), minZ = 21.51, maxZ = 22.31, heading = 88.12, length = 0.45, width = 0.45, icon = "fas fa-chair",        },
        [37] = { sitanim = "", sitPos = vector3(-586.58, -1064.7, 22.65), location = vector3(-586.28, -1064.71, 21.91), minZ = 21.51, maxZ = 22.31, heading = 88.12, length = 0.45, width = 0.45, icon = "fas fa-chair",        },
        --Tree Seating
        [38] = { sitanim = "", sitPos = vector3(-580.93, -1062.24, 22.35), location = vector3(-580.54, -1062.47, 21.91), minZ = 21.51, maxZ = 22.35, heading = 53.10, length = 1.0, width = 1.0, icon = "fas fa-chair",        },
        [39] = { sitanim = "", sitPos = vector3(-581.45, -1063.47, 22.35), location = vector3(-581.0, -1063.44, 21.91), minZ = 21.51, maxZ = 22.35, heading = 94.57, length = 1.0, width = 1.0, icon = "fas fa-chair",        },
        [40] = { sitanim = "", sitPos = vector3(-580.49, -1064.92, 22.35), location = vector3(-580.38, -1064.64, 21.91), minZ = 21.51, maxZ = 22.35, heading = 158.02, length = 1.0, width = 1.0, icon = "fas fa-chair",        },
        [41] = { sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork", sitPos = vector3(-579.18, -1064.79, 22.79), location = vector3(-579.18, -1064.79, 21.91), minZ = 21.51, maxZ = 22.35, heading = 287.02, length = 1.0, width = 1.0, icon = "fas fa-chair",        },
        [42] = { sitanim = "anim@amb@business@bgen@bgen_no_work@", sitclip = "sit_phone_phoneputdown_idle_nowork", sitPos = vector3(-578.24, -1063.75, 22.79), location = vector3(-578.24, -1063.75, 21.91), minZ = 21.51, maxZ = 22.35, heading = 132.05, length = 1.0, width = 1.0, icon = "fas fa-chair",        },
        [43] = { sitanim = "", sitPos = vector3(-579.01, -1061.85, 22.35), location = vector3(-579.09, -1062.08, 21.91), minZ = 21.51, maxZ = 22.35, heading = 339.72, length = 1.0, width = 1.0, icon = "fas fa-chair",  },
        --Outside Benches (Left)
        [44] = { sitanim = "", sitPos = vector3(-582.33, -1075.83, 22.33), location = vector3(-582.78, -1075.84, 22.00), minZ = 21.51, maxZ = 22.35, heading = 270.06, length = 1.0, width = 1.0, icon = "fas fa-chair",        }, 
        [45] = { sitanim = "", sitPos = vector3(-582.33, -1077.21, 22.33), location = vector3(-582.72, -1077.25, 22.00), minZ = 21.51, maxZ = 22.35, heading = 270.06, length = 1.0, width = 1.0, icon = "fas fa-chair",        }, 
        [46] = { sitanim = "", sitPos = vector3(-582.33, -1081.36, 22.33), location = vector3(-582.74, -1081.37, 22.00), minZ = 21.51, maxZ = 22.35, heading = 270.06, length = 1.0, width = 1.0, icon = "fas fa-chair",        }, 
        [47] = { sitanim = "", sitPos = vector3(-582.33, -1082.75, 22.33), location = vector3(-582.76, -1082.75, 22.00), minZ = 21.51, maxZ = 22.35, heading = 270.06, length = 1.0, width = 1.0, icon = "fas fa-chair", }, 
        --Outside Benches (Right)
        [48] = { sitanim = "", sitPos = vector3(-579.72, -1075.73, 22.33), location = vector3(-579.27, -1075.74, 22.00), minZ = 21.51, maxZ = 22.35, heading = 88.84, length = 1.0, width = 1.0, icon = "fas fa-chair",        }, 
        [49] = { sitanim = "", sitPos = vector3(-579.57, -1077.07, 22.33), location = vector3(-579.27, -1077.09, 22.00), minZ = 21.51, maxZ = 22.35, heading = 88.84, length = 1.0, width = 1.0, icon = "fas fa-chair",        }, 
        [50] = { sitanim = "", sitPos = vector3(-579.63, -1081.4, 22.33), location = vector3(-579.33, -1081.43, 22.00), minZ = 21.51, maxZ = 22.35, heading = 88.84, length = 1.0, width = 1.0, icon = "fas fa-chair",        }, 
        [51] = { sitanim = "", sitPos = vector3(-579.71, -1082.9, 22.33), location = vector3(-579.26, -1082.91, 22.00), minZ = 21.51, maxZ = 22.35, heading = 88.84, length = 1.0, width = 1.0, icon = "fas fa-chair",        }, 
        --Alcove (Right)
        [52] = { sitanim = "", sitPos = vector3(-573.04, -1066.45, 22.41), location = vector3(-572.99, -1066.09, 21.81), minZ = 21.51, maxZ = 22.65, heading = 180.69, length = 1.0, width = 1.0, icon = "fas fa-chair",        }, 
        [53] = { sitanim = "", sitPos = vector3(-573.86, -1066.45, 22.41), location = vector3(-573.86, -1066.1, 21.81), minZ = 21.51, maxZ = 22.65, heading = 180.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [54] = { sitanim = "", sitPos = vector3(-573.83, -1067.6, 22.41), location = vector3(-573.85, -1068.05, 21.81), minZ = 21.51, maxZ = 22.65, heading = 357.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [55] = { sitanim = "", sitPos = vector3(-573.04, -1067.58, 22.41), location = vector3(-573.06, -1068.03, 21.81), minZ = 21.51, maxZ = 22.65, heading = 357.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        --Alcove (Middle)
        [56] = { sitanim = "", sitPos = vector3(-573.06, -1062.75, 21.81), location = vector3(-573.06, -1062.38, 21.81), minZ = 21.51, maxZ = 22.65, heading = 180.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [57] = { sitanim = "", sitPos = vector3(-573.96, -1062.75, 21.81), location = vector3(-573.94, -1062.47, 21.81), minZ = 21.51, maxZ = 22.65, heading = 180.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [58] = { sitanim = "", sitPos = vector3(-573.08, -1063.85, 21.81), location = vector3(-573.08, -1064.41, 21.81), minZ = 21.51, maxZ = 22.65, heading = 357.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [59] = { sitanim = "", sitPos = vector3(-573.91, -1063.85, 21.81), location = vector3(-573.92, -1064.33, 21.81), minZ = 21.51, maxZ = 22.65, heading = 357.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        --Alcove Left
        [60] = { sitanim = "", sitPos = vector3(-572.98, -1059.10, 21.81), location = vector3(-572.98, -1058.77, 21.81), minZ = 21.51, maxZ = 22.65, heading = 180.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [61] = { sitanim = "", sitPos = vector3(-573.93, -1059.10, 21.81), location = vector3(-573.91, -1058.75, 21.81), minZ = 21.51, maxZ = 22.65, heading = 180.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [62] = { sitanim = "", sitPos = vector3(-572.93, -1060.15, 21.81), location = vector3(-572.95, -1060.73, 21.81), minZ = 21.51, maxZ = 22.65, heading = 357.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [63] = { sitanim = "", sitPos = vector3(-574.01, -1060.15, 21.81), location = vector3(-574.0, -1060.77, 21.81), minZ = 21.51, maxZ = 22.65, heading = 357.69, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        --Locker Room Couch
        [64] = { sitanim = "", sitPos = vector3(-591.48, -1049.72, 22.34), location = vector3(-591.48, -1049.12, 22.04), minZ = 21.61, maxZ = 22.25, heading = 180.30, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [65] = { sitanim = "", sitPos = vector3(-590.58, -1049.67, 22.34), location = vector3(-590.56, -1049.22, 22.04), minZ = 21.61, maxZ = 22.25, heading = 180.30, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
        [66] = { sitanim = "", sitPos = vector3(-589.83, -1049.66, 22.34), location = vector3(-589.81, -1049.22, 22.04), minZ = 21.61, maxZ = 22.25, heading = 180.30, length = 1.0, width = 1.0, icon = "fas fa-chair",}, 
    }, 
    ["vanillaunicorn"] = -- Done
    {   --DJ Booth Stool
      [1] = {sitanim = "", sitPos = vector3(120.8, -1280.14, 29.78),  location = vector3(120.71, -1279.85, 29.0),  minZ = 28.5, maxZ = 29.6,  heading = 196.9, length = 0.5, width = 0.5, icon = "fas fa-chair",},
        --DJ Booth Sofa
      [2] = {sitanim = "", sitPos = vector3(124.3, -1279.98, 28.5),  location = vector3(123.91, -1279.53, 28.5), minZ = 28.5, maxZ = 29.15, heading = 220.90, length = 1.0, width = 1.0, icon = "fas fa-chair",},
      [3] = {sitanim = "", sitPos = vector3(125.28, -1279.26, 28.5), location = vector3(125.04, -1278.88, 28.5), minZ = 28.5, maxZ = 29.15, heading = 202.90, length = 1.0, width = 1.0, icon = "fas fa-chair",},
      --Bar Stools
      [4] = {sitanim = "", sitPos = vector3(126.94, -1282.45, 29.52), location = vector3(126.54, -1282.65, 28.5), minZ = 28.5, maxZ = 29.15, heading = 295.90, length = 0.5, width = 0.5, icon = "fas fa-chair",},
      [5] = {sitanim = "", sitPos = vector3(127.65, -1283.84, 29.52), location = vector3(127.38, -1283.99, 28.5), minZ = 28.5, maxZ = 29.15, heading = 295.90, length = 0.5, width = 0.5, icon = "fas fa-chair",},
      [6] = {sitanim = "", sitPos = vector3(128.4, -1285.06, 29.52),  location = vector3(128.03, -1285.25, 28.5), minZ = 28.5, maxZ = 29.15, heading = 295.90, length = 0.5, width = 0.5, icon = "fas fa-chair",},
      [7] = {sitanim = "", sitPos = vector3(129.09, -1286.24, 29.52), location = vector3(128.82, -1286.37, 28.5), minZ = 28.5, maxZ = 29.15, heading = 295.90, length = 0.5, width = 0.5, icon = "fas fa-chair",},
      [8] = {sitanim = "", sitPos = vector3(129.71, -1287.4, 29.52),  location = vector3(129.45, -1287.55, 28.5), minZ = 28.5, maxZ = 29.15, heading = 295.90, length = 0.5, width = 0.5, icon = "fas fa-chair",},
      --Booth 1 (6 Seater)
      [9] = {sitanim = "",  sitPos = vector3(123.98, -1293.99, 29.25),  location = vector3(124.37, -1293.76, 28.0), minZ = 28.0, maxZ = 29.15, heading = 118.89, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [10] = {sitanim = "", sitPos = vector3(124.51, -1294.82, 29.25),  location = vector3(124.78, -1294.69, 28.0), minZ = 28.0, maxZ = 29.15, heading = 118.89, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [11] = {sitanim = "", sitPos = vector3(124.33, -1295.53, 29.25),  location = vector3(124.49, -1295.78, 28.0), minZ = 28.0, maxZ = 29.15, heading = 28.89, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [12] = {sitanim = "", sitPos = vector3(123.57, -1295.95, 29.25),  location = vector3(123.73, -1296.2, 28.0), minZ = 28.0, maxZ = 29.15, heading = 28.89, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [13] = {sitanim = "", sitPos = vector3(122.8, -1295.82, 29.25),   location = vector3(122.54, -1295.98, 28.0), minZ = 28.0, maxZ = 29.15, heading = 301.88, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [14] = {sitanim = "", sitPos = vector3(122.43, -1294.96, 29.25),  location = vector3(122.05, -1295.19, 28.0), minZ = 28.0, maxZ = 29.15, heading = 301.88, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      --Booth 2 (6 Seater)
      [15] = {sitanim = "", sitPos = vector3(120.59, -1295.93, 29.25),   location = vector3(120.97, -1295.69, 28.0), minZ = 28.0, maxZ = 29.15, heading = 118.89, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [16] = {sitanim = "", sitPos = vector3(121.1, -1296.84, 29.25),    location = vector3(121.48, -1296.59, 28.0), minZ = 28.0, maxZ = 29.15, heading = 118.89, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [17] = {sitanim = "", sitPos = vector3(120.96, -1297.55, 29.25),   location = vector3(121.11, -1297.81, 28.0), minZ = 28.0, maxZ = 29.15, heading = 28.89, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [18] = {sitanim = "", sitPos = vector3(120.09, -1297.9, 29.25),    location = vector3(120.32, -1298.29, 28.0), minZ = 28.0, maxZ = 29.15, heading = 28.89, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [19] = {sitanim = "", sitPos = vector3(119.51, -1297.79, 29.25),   location = vector3(119.13, -1298.02, 28.0), minZ = 28.0, maxZ = 29.15, heading = 301.88, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [20] = {sitanim = "", sitPos = vector3(118.98, -1296.94, 29.25),   location = vector3(118.59, -1297.17, 28.0), minZ = 28.0, maxZ = 29.15, heading = 301.88, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      --Dancefloor Seats (8)
      [21] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(107.81, -1292.8, 28.26),   location = vector3(108.21, -1293.4, 27.76), minZ = 27.0, maxZ = 28.20, heading = 26.07, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [22] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(109.52, -1291.87, 28.26),  location = vector3(109.9, -1292.42, 27.76), minZ = 27.0, maxZ = 28.20, heading = 33.55, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [23] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(110.96, -1290.48, 28.26),  location = vector3(111.65, -1290.77, 27.76), minZ = 27.0, maxZ = 28.20, heading = 67.14, length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [24] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(111.16, -1288.56, 28.26),  location = vector3(111.9, -1288.41, 27.76), minZ = 27.0, maxZ = 28.20, heading = 100.13, length = 0.90, width = 0.90, icon = "fas fa-chair",},
      [25] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(110.26, -1287.3, 28.26),   location = vector3(110.6, -1286.76, 27.76), minZ = 27.0, maxZ = 28.20, heading = 140.23, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [26] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(108.44, -1286.97, 28.26),  location = vector3(108.5, -1286.13, 27.76), minZ = 27.0, maxZ = 28.20, heading = 184.94, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [27] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(106.75, -1287.46, 28.26),  location = vector3(106.48, -1286.77, 27.76), minZ = 27.0, maxZ = 28.20, heading = 208.04, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [28] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(105.12, -1288.4, 28.26),   location = vector3(104.75, -1287.62, 27.76), minZ = 27.0, maxZ = 28.20, heading = 208.04, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      --Corner Booth 1
      [29] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(116.75, -1292.18, 28.26),  location = vector3(117.1, -1292.78, 28.26), minZ = 27.0, maxZ = 28.20, heading = 30.83, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [30] = {sitanim = "timetable@ron@ig_5_p3", sitclip = "ig_5_p3_base", sitPos = vector3(116.15, -1292.0, 28.26),   location = vector3(115.59, -1292.24, 28.26), minZ = 27.0, maxZ = 28.20, heading = 316.80, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      --Mini Booth 1 (Office)
      [31] = {sitanim = "", sitPos = vector3(115.63, -1303.6, 29.27),    location = vector3(116.03, -1303.39, 29.27), minZ = 27.0, maxZ = 29.20, heading = 117.93, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [32] = {sitanim = "", sitPos = vector3(115.9, -1304.18, 29.27),    location = vector3(116.19, -1304.27, 29.27), minZ = 27.0, maxZ = 29.20, heading = 72.93, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [33] = {sitanim = "", sitPos = vector3(115.37, -1304.62, 29.27),   location = vector3(115.6, -1305.01, 29.27), minZ = 27.0, maxZ = 29.20, heading = 30.93, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [34] = {sitanim = "", sitPos = vector3(113.5, -1305.66, 29.48),    location = vector3(113.72, -1306.05, 29.24), minZ = 27.0, maxZ = 29.20, heading = 30.93, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [35] = {sitanim = "", sitPos = vector3(112.85, -1305.96, 29.24),   location = vector3(112.74, -1306.24, 29.24), minZ = 27.0, maxZ = 29.20, heading = 338.61, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [36] = {sitanim = "", sitPos = vector3(112.3, -1305.43, 29.24),    location = vector3(112.03, -1305.56, 29.24), minZ = 27.0, maxZ = 29.20, heading = 296.61, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      -- L Couch back room
      [37] = {sitanim = "", sitPos = vector3(110.96, -1302.91, 29.24),   location = vector3(110.58, -1303.16, 29.24), minZ = 27.0, maxZ = 29.20, heading = 296.61, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [38] = {sitanim = "", sitPos = vector3(110.72, -1302.21, 29.24),   location = vector3(110.29, -1302.07, 29.24), minZ = 27.0, maxZ = 29.20, heading = 251.61, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [39] = {sitanim = "", sitPos = vector3(111.25, -1301.77, 29.24),   location = vector3(111.03, -1301.38, 29.24), minZ = 27.0, maxZ = 29.20, heading = 209.61, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [40] = {sitanim = "", sitPos = vector3(112.09, -1301.25, 29.24),   location = vector3(111.87, -1300.86, 29.24), minZ = 27.0, maxZ = 29.20, heading = 209.61, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [41] = {sitanim = "", sitPos = vector3(112.95, -1300.75, 29.24),   location = vector3(112.73, -1300.35, 29.24), minZ = 27.0, maxZ = 29.20, heading = 209.61, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      --Makeup Bar
      [42] = {sitanim = "", sitPos = vector3(109.42, -1305.8, 29.07),    location = vector3(109.35, -1305.67, 28.77), minZ = 28.0, maxZ = 28.90, heading = 208.30, length = 0.50, width = 0.50, icon = "fas fa-chair",},
      [43] = {sitanim = "", sitPos = vector3(108.14, -1306.43, 29.07),   location = vector3(107.99, -1306.17, 28.77), minZ = 28.0, maxZ = 28.90, heading = 208.30, length = 0.50, width = 0.50, icon = "fas fa-chair",},
      [44] = {sitanim = "", sitPos = vector3(107.18, -1306.9, 29.07),    location = vector3(107.04, -1306.63, 28.77), minZ = 28.0, maxZ = 28.90, heading = 208.30, length = 0.50, width = 0.50, icon = "fas fa-chair",},
      --Casting Couch
      [45] = {sitanim = "", sitPos = vector3(98.32, -1290.67, 29.26),    location = vector3(98.72, -1290.45, 29.26), minZ = 27.0, maxZ = 29.20, heading = 119.29, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [46] = {sitanim = "", sitPos = vector3(97.63, -1289.67, 29.26),    location = vector3(98.02, -1289.45, 29.26), minZ = 27.0, maxZ = 29.20, heading = 119.28, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      --Dancefloor Couch 1
      [47] = {sitanim = "", sitPos = vector3(123.69, -1288.33, 28.26),   location = vector3(124.13, -1288.41, 28.05), minZ = 27.0, maxZ = 28.20, heading = 78.59, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [48] = {sitanim = "", sitPos = vector3(123.01, -1287.14, 28.26),   location = vector3(123.19, -1286.72, 28.05), minZ = 27.0, maxZ = 28.20, heading = 156.58, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      --Small middle wall (Left DJ Booth)
      [49] = {sitanim = "", sitPos = vector3(122.07, -1285.43, 28.26),   location = vector3(122.34, -1285.55, 28.05), minZ = 27.0, maxZ = 28.20, heading = 66.58, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [50] = {sitanim = "", sitPos = vector3(121.68, -1284.78, 28.26),   location = vector3(122.07, -1284.57, 28.05), minZ = 27.0, maxZ = 28.20, heading = 117.58, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [51] = {sitanim = "", sitPos = vector3(121.32, -1284.26, 28.26),   location = vector3(121.41, -1283.82, 28.05), minZ = 27.0, maxZ = 28.20, heading = 168.58, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      --Half Circle Couch (Under DJ Booth)
      [52] = {sitanim = "", sitPos = vector3(118.57, -1282.18, 28.26),   location = vector3(118.93, -1281.91, 28.05), minZ = 27.0, maxZ = 28.20, heading = 126.58, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [53] = {sitanim = "", sitPos = vector3(118.06, -1281.72, 28.26),   location = vector3(118.26, -1281.32, 28.05), minZ = 27.0, maxZ = 28.20, heading = 153.58, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [54] = {sitanim = "", sitPos = vector3(117.41, -1281.65, 28.26),   location = vector3(117.38, -1281.21, 28.05), minZ = 27.0, maxZ = 28.20, heading = 183.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [55] = {sitanim = "", sitPos = vector3(116.20, -1282.3, 28.26),    location = vector3(115.82, -1282.05, 28.05), minZ = 27.0, maxZ = 28.20, heading = 237.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [56] = {sitanim = "", sitPos = vector3(116.04, -1283.0, 28.26),    location = vector3(115.59, -1282.98, 28.05), minZ = 27.0, maxZ = 28.20, heading = 267.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      --Middle Half-Circle Cough
      [57] = {sitanim = "", sitPos = vector3(116.15, -1288.19, 28.26),   location = vector3(116.25, -1288.62, 28.05), minZ = 27.0, maxZ = 28.20, heading = 12.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [58] = {sitanim = "", sitPos = vector3(116.73, -1287.87, 28.26),   location = vector3(117.0, -1288.23, 28.05), minZ = 27.0, maxZ = 28.20, heading = 36.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [59] = {sitanim = "", sitPos = vector3(117.18, -1287.33, 28.26),   location = vector3(117.6, -1287.51, 28.05), minZ = 27.0, maxZ = 28.20, heading = 66.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [60] = {sitanim = "", sitPos = vector3(117.24, -1286.67, 28.26),   location = vector3(117.69, -1286.62, 28.05), minZ = 27.0, maxZ = 28.20, heading = 96.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      --Half-Circle (Under Ladies Sign)
      [61] = {sitanim = "", sitPos = vector3(114.16, -1283.2, 28.26),    location = vector3(114.61, -1283.22, 28.05), minZ = 27.0, maxZ = 28.20, heading = 87.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [62] = {sitanim = "", sitPos = vector3(113.99, -1282.55, 28.26),   location = vector3(114.39, -1282.35, 28.05), minZ = 27.0, maxZ = 28.20, heading = 117.57, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [63] = {sitanim = "", sitPos = vector3(113.71, -1281.98, 28.26),   location = vector3(114.0, -1281.64, 28.05), minZ = 27.0, maxZ = 28.20, heading = 138.56, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [64] = {sitanim = "", sitPos = vector3(113.01, -1281.72, 28.26),   location = vector3(113.07, -1281.28, 28.05), minZ = 27.0, maxZ = 28.20, heading = 171.56, length = 0.85, width = 0.85, icon = "fas fa-chair",},
      
      --Tables - Dance WIP (Needs Moved from target:sit)
      [65] = {label = "Dance", sitanim = "lapdance", sitPos = vector3(112.73, -1283.08, 28.88),  location = vector3(112.73, -1283.08, 28.88), minZ = 27.0, maxZ = 28.20, heading = 280.90, length = 0.85, width = 0.85, icon = "fas fa-music",},
      [66] = {label = "Dance", sitanim = "lapdance", sitPos = vector3(115.93, -1286.66, 28.88),  location = vector3(115.93, -1286.66, 28.88), minZ = 27.0, maxZ = 28.20, heading = 294.13, length = 0.85, width = 0.85, icon = "fas fa-music",},
      [67] = {label = "Dance", sitanim = "lapdance", sitPos = vector3(113.4, -1302.91, 29.89),  location = vector3(113.4, -1302.91, 29.23), minZ = 28.0, maxZ = 29.95, heading = 294.13, length = 1.0, width = 1.0, icon = "fas fa-music",},
      --Poles
      [68] = {label = "Dance", sitanim = "lapdance", sitPos = vector3(105.23, -1294.17, 29.25),  location = vector3(104.81, -1294.48, 29.25), minZ = 27.5, maxZ = 30.00, heading = 301.17, length = 0.3, width = 0.3, icon = "fas fa-music",},
      [69] = {label = "Dance", sitanim = "lapdance", sitPos = vector3(102.79, -1289.69, 29.25),  location = vector3(102.17, -1290.14, 29.25), minZ = 27.5, maxZ = 30.00, heading = 306.13, length = 0.3, width = 0.3, icon = "fas fa-music",},
      [70] = {label = "Dance", sitanim = "lapdance", sitPos = vector3(109.05, -1289.16, 29.25),  location = vector3(108.76, -1289.29, 29.25), minZ = 27.5, maxZ = 30.00, heading = 294.13, length = 0.3, width = 0.3, icon = "fas fa-music",},
      
    }, 
    ["arcadius"] = 
    {   --Desk
      [1] =  {sitanim = "", sitPos = vector3(-126.06, -641.58, 168.82),  location = vector3(-125.71, -641.87, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 50.88,   length = 1.00, width = 1.00, icon = "fas fa-chair",},      
        --Private Lounge
      [2] =  {sitanim = "", sitPos = vector3(-136.62, -641.31, 168.82),  location = vector3(-136.21, -640.87, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 136.67,  length = 1.00, width = 1.00, icon = "fas fa-chair",},      
      [3] =  {sitanim = "", sitPos = vector3(-140.03, -641.57, 168.82),  location = vector3(-140.50, -641.21, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 232.67,  length = 1.00, width = 1.00, icon = "fas fa-chair",},      
      [4] =  {sitanim = "", sitPos = vector3(-137.13, -644.06, 168.83),  location = vector3(-136.92, -644.63, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 6.44,    length = 0.75, width = 0.75, icon = "fas fa-chair",},      
      [5] =  {sitanim = "", sitPos = vector3(-137.93, -644.14, 168.83),  location = vector3(-137.82, -644.75, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 6.44,    length = 0.75, width = 0.75, icon = "fas fa-chair",},      
      [6] =  {sitanim = "", sitPos = vector3(-138.77, -644.17, 168.83),  location = vector3(-138.70, -644.74, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 6.44,    length = 0.75, width = 0.75, icon = "fas fa-chair",},               
        -- Meeting Room
      [7] =  {sitanim = "", sitPos = vector3(-146.03, -642.40, 168.82),  location = vector3(-145.54, -642.32, 168.90),  minZ = 167.82, maxZ = 169.32,  heading = 100.58,  length = 1.00, width = 1.00, icon = "fas fa-chair",},
      [8] =  {sitanim = "", sitPos = vector3(-145.92, -643.54, 168.90),  location = vector3(-145.38, -643.51, 168.90),  minZ = 167.82, maxZ = 169.32,  heading = 100.58,  length = 1.00, width = 1.00, icon = "fas fa-chair",},
      [9] =  {sitanim = "", sitPos = vector3(-145.85, -644.81, 168.90),  location = vector3(-145.41, -644.70, 168.90),  minZ = 167.82, maxZ = 169.32,  heading = 100.58,  length = 1.00, width = 1.00, icon = "fas fa-chair",},
      [10] = {sitanim = "", sitPos = vector3(-146.55, -645.72, 168.90),  location = vector3(-146.44, -646.03, 168.54),  minZ = 167.82, maxZ = 169.32,  heading = 7.58,    length = 1.00, width = 1.00, icon = "fas fa-chair",},
      [11] = {sitanim = "", sitPos = vector3(-147.82, -642.54, 168.82),  location = vector3(-148.15, -642.62, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 279.09,  length = 1.00, width = 1.00, icon = "fas fa-chair",},
      [12] = {sitanim = "", sitPos = vector3(-147.66, -643.81, 168.71),  location = vector3(-148.06, -643.80, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 279.09,  length = 1.00, width = 1.00, icon = "fas fa-chair",},
      [13] = {sitanim = "", sitPos = vector3(-147.54, -644.92, 168.82),  location = vector3(-147.84, -644.96, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 279.09,  length = 1.00, width = 1.00, icon = "fas fa-chair",},
      -- Beackroom Chair
      [14] = {sitanim = "", sitPos = vector3(-126.17, -636.38, 168.82),  location = vector3(-125.61, -636.28, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 111.52,  length = 0.75, width = 0.75, icon = "fas fa-chair",},
      -- Public Lounge
      [15] = {sitanim = "", sitPos = vector3(-149.59, -632.07, 168.82),  location = vector3(-150.01, -632.11, 168.48),  minZ = 167.82, maxZ = 169.32,  heading = 274.23,  length = 1.00, width = 1.00, icon = "fas fa-chair",},
      [16] = {sitanim = "", sitPos = vector3(-149.70, -630.61, 168.82),  location = vector3(-150.19, -630.68, 168.48),  minZ = 167.82, maxZ = 169.32,  heading = 275.93,  length = 1.00, width = 1.00, icon = "fas fa-chair",},
      [17] = {sitanim = "", sitPos = vector3(-148.80, -629.88, 168.82),  location = vector3(-148.89, -629.35, 168.48),  minZ = 167.82, maxZ = 169.32,  heading = 186.50,  length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [18] = {sitanim = "", sitPos = vector3(-147.95, -629.85, 168.82),  location = vector3(-147.99, -629.29, 168.48),  minZ = 167.82, maxZ = 169.32,  heading = 186.50,  length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [19] = {sitanim = "", sitPos = vector3(-147.04, -629.69, 168.82),  location = vector3(-147.14, -629.21, 168.48),  minZ = 167.82, maxZ = 169.32,  heading = 185.77,  length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [20] = {sitanim = "", sitPos = vector3(-143.75, -630.63, 168.82),  location = vector3(-143.81, -630.07, 168.48),  minZ = 167.82, maxZ = 169.32,  heading = 184.11,  length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [21] = {sitanim = "", sitPos = vector3(-142.45, -630.51, 168.82),  location = vector3(-142.50, -629.86, 168.48),  minZ = 167.82, maxZ = 169.32,  heading = 184.11,  length = 0.85, width = 0.85, icon = "fas fa-chair",},
      -- Laptop Chairs  
      [22] = {sitanim = "", sitPos = vector3(-145.17, -634.98, 168.84),  location = vector3(-145.72, -635.07, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 275.56,  length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [23] = {sitanim = "", sitPos = vector3(-145.03, -636.50, 168.78),  location = vector3(-145.50, -636.60, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 275.56,  length = 0.85, width = 0.85, icon = "fas fa-chair",},
      [24] = {sitanim = "", sitPos = vector3(-144.88, -637.97, 168.90),  location = vector3(-145.31, -638.04, 168.82),  minZ = 167.82, maxZ = 169.32,  heading = 275.56,  length = 0.85, width = 0.85, icon = "fas fa-chair",},
    }, 
    ["tenfourtwo"] = 
    {   
      -- Downstairs Left Side
      [1] = {sitanim = "", sitPos = vector3(1227.49, -423.49, 67.77),  location = vector3(1227.45, -424.09, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 356.56,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [2] = {sitanim = "", sitPos = vector3(1226.35, -423.37, 67.77),  location = vector3(1225.93, -423.65, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 294.69,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [3] = {sitanim = "", sitPos = vector3(1224.22, -422.32, 67.77),  location = vector3(1224.68, -422.41, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [4] = {sitanim = "", sitPos = vector3(1224.03, -423.04, 67.77),  location = vector3(1224.53, -423.20, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [5] = {sitanim = "", sitPos = vector3(1220.92, -422.41, 67.77),  location = vector3(1221.38, -422.43, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [6] = {sitanim = "", sitPos = vector3(1221.10, -421.41, 67.77),  location = vector3(1221.54, -421.65, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [7] = {sitanim = "", sitPos = vector3(1218.30, -421.55, 67.77),  location = vector3(1218.77, -421.62, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [8] = {sitanim = "", sitPos = vector3(1218.48, -420.82, 67.77),  location = vector3(1218.98, -420.90, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [9] = {sitanim = "", sitPos = vector3(1221.77, -419.32, 67.77),  location = vector3(1222.21, -419.43, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [10] = {sitanim = "", sitPos = vector3(1222.61, -416.37, 67.77),  location = vector3(1223.06, -416.41, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [11] = {sitanim = "", sitPos = vector3(1222.97, -414.50, 67.77),  location = vector3(1223.47, -414.43, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [12] = {sitanim = "", sitPos = vector3(1223.27, -413.57, 67.77),  location = vector3(1223.71, -413.67, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [13] = {sitanim = "", sitPos = vector3(1220.42, -413.74, 67.77),  location = vector3(1220.99, -413.86, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [14] = {sitanim = "", sitPos = vector3(1220.63, -412.99, 67.77),  location = vector3(1221.22, -413.10, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 75.79,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      
      -- Downstairs Right Side
      [15] = {sitanim = "", sitPos = vector3(1217.84, -421.31, 67.77),  location = vector3(1217.30, -421.22, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [16] = {sitanim = "", sitPos = vector3(1217.97, -420.57, 67.77),  location = vector3(1217.55, -420.46, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [17] = {sitanim = "", sitPos = vector3(1220.41, -422.16, 67.77),  location = vector3(1219.89, -422.03, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [18] = {sitanim = "", sitPos = vector3(1220.70, -421.37, 67.77),  location = vector3(1220.21, -421.28, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [19] = {sitanim = "", sitPos = vector3(1223.73, -422.22, 67.77),  location = vector3(1223.17, -422.00, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [20] = {sitanim = "", sitPos = vector3(1223.59, -422.95, 67.77),  location = vector3(1222.99, -422.90, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [21] = {sitanim = "", sitPos = vector3(1221.23, -419.28, 67.77),  location = vector3(1220.79, -419.18, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [22] = {sitanim = "", sitPos = vector3(1221.98, -416.14, 67.77),  location = vector3(1221.54, -416.04, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [23] = {sitanim = "", sitPos = vector3(1219.96, -413.54, 67.77),  location = vector3(1219.42, -413.46, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [24] = {sitanim = "", sitPos = vector3(1220.19, -412.83, 67.77),  location = vector3(1219.72, -412.81, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [25] = {sitanim = "", sitPos = vector3(1222.49, -414.24, 67.77),  location = vector3(1222.06, -414.12, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [26] = {sitanim = "", sitPos = vector3(1222.77, -413.39, 67.77),  location = vector3(1222.21, -413.39, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 255.74,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [27] = {sitanim = "", sitPos = vector3(1225.20, -414.66, 67.77),  location = vector3(1225.19, -414.16, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 201.98,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      [28] = {sitanim = "", sitPos = vector3(1226.46, -414.99, 67.77),  location = vector3(1226.61, -414.64, 67.37),  minZ = 66.77, maxZ = 67.97,  heading = 155.95,   length = 0.75, width = 0.75, icon = "fas fa-chair",},

      -- Store room chair
      [29] = {sitanim = "", sitPos = vector3(1238.19, -421.09, 67.77),  location = vector3(1237.59, -420.99, 67.57),  minZ = 66.77, maxZ = 67.97,  heading = 257.61,   length = 0.75, width = 0.75, icon = "fas fa-chair",},
      --Bar Stools
      [30] = {label = "Sit", sitanim = "", sitPos = vector3(1226.75, -416.46, 68.07),  location = vector3(1226.37, -416.35, 67.58),  minZ = 66.77, maxZ = 67.97,  heading = 255.65,   length = 0.45, width = 0.45, icon = "fas fa-chair",},
      [31] = {label = "Sit", sitanim = "", sitPos = vector3(1226.74, -417.04, 68.07),  location = vector3(1226.25, -417.02, 67.58),  minZ = 66.77, maxZ = 67.97,  heading = 279.15,   length = 0.45, width = 0.45, icon = "fas fa-chair",},

      [32] = {label = "Sit", sitanim = "", sitPos = vector3(1227.19, -417.79, 68.07),  location = vector3(1227.11, -418.19, 67.58),  minZ = 66.77, maxZ = 67.97,  heading = 345.11,   length = 0.45, width = 0.45, icon = "fas fa-chair",},
      [33] = {label = "Sit", sitanim = "", sitPos = vector3(1227.91, -418.02, 68.07),  location = vector3(1227.83, -418.35, 67.58),  minZ = 66.77, maxZ = 67.97,  heading = 345.11,   length = 0.45, width = 0.45, icon = "fas fa-chair",},
      [34] = {label = "Sit", sitanim = "", sitPos = vector3(1231.11, -418.89, 68.07),  location = vector3(1230.95, -419.26, 67.58),  minZ = 66.77, maxZ = 67.97,  heading = 345.11,   length = 0.45, width = 0.45, icon = "fas fa-chair",},
      [35] = {label = "Sit", sitanim = "", sitPos = vector3(-542.68, -197.83, 37.76),  location = vector3(-542.68, -197.83, 37.76),  minZ = 167.77, maxZ = 167.97,  heading = 345.11,   length = 0.45, width = 0.45, icon = "fas fa-chair",},
    
      [36] = {label = "Sit", sitanim = "", sitPos = vector3(1227.19, -417.79, 68.07),  location = vector3(1227.11, -418.19, 67.58),  minZ = 66.77, maxZ = 67.97,  heading = 345.11,   length = 0.45, width = 0.45, icon = "fas fa-chair",},
      [37] = {label = "Sit", sitanim = "", sitPos = vector3(1227.91, -418.02, 68.07),  location = vector3(1227.83, -418.35, 67.58),  minZ = 66.77, maxZ = 67.97,  heading = 345.11,   length = 0.45, width = 0.45, icon = "fas fa-chair",},
      [38] = {label = "Sit", sitanim = "", sitPos = vector3(1231.11, -418.89, 68.07),  location = vector3(1230.95, -419.26, 67.58),  minZ = 66.77, maxZ = 67.97,  heading = 345.11,   length = 0.45, width = 0.45, icon = "fas fa-chair",}, 
    },
    ["government"] = 
    {   
        -- Lobby Chairs
        [1] = {sitanim = "", sitPos = vector3(-547.14, -186.51, 37.73), location = vector3(-547.2, -186.46, 38.23),  minZ = 25.23, maxZ = 66.20,  heading = 124.65,   length = 0.50, width = 0.50, icon = "fas fa-chair",},
        [2] = {label = "Sit", sitanim = "sitchair", sitPos = vector3(-551.88, -202.69, 38.32), location = vector3(-551.95, -203.19, 37.70),  minZ = 25.23, maxZ = 66.20,  heading = 3.94,    length = 0.50, width = 0.50, icon = "fas fa-chair",},
        -- Lobby Benches 
        [3] = {label = "Sit", sitanim = "sitchair", sitPos = vector3(-558.44, -194.11, 38.23), location = vector3(-558.82, -194.36, 37.70),  minZ = 25.23, maxZ = 66.20,  heading = 304.1,   length = 0.50, width = 0.50, icon = "fas fa-chair",},
        [4] = {label = "Sit", sitanim = "sitchair", sitPos = vector3(-558.94, -193.3, 38.23),  location = vector3(-559.33, -193.53, 37.70),  minZ = 25.23, maxZ = 66.20,  heading = 304.1,   length = 0.50, width = 0.50, icon = "fas fa-chair",},
        [5] = {label = "Sit", sitanim = "sitchair", sitPos = vector3(-559.08, -191.05, 38.23), location = vector3(-559.31, -190.67, 37.70),  minZ = 25.23, maxZ = 66.20,  heading = 211.22,  length = 0.50, width = 0.50, icon = "fas fa-chair",},
        [6] = {label = "Sit", sitanim = "sitchair", sitPos = vector3(-558.3, -190.6, 38.23),   location = vector3(-558.58, -190.09, 37.70),  minZ = 25.23, maxZ = 66.20,  heading = 211.22,  length = 0.50, width = 0.50, icon = "fas fa-chair",},
        [7] = {label = "Sit", sitanim = "sitchair", sitPos = vector3(-547.58, -186.75, 38.23), location = vector3(-547.18, -186.55, 37.70),  minZ = 25.23, maxZ = 66.20,  heading = 124.55,  length = 0.50, width = 0.50, icon = "fas fa-chair",},
        [8] = {label = "Sit", sitanim = "sitchair", sitPos = vector3(-547.15, -187.5, 38.23),  location = vector3(-546.65, -187.16, 37.70),  minZ = 25.23, maxZ = 66.20,  heading = 124.55,  length = 0.50, width = 0.50, icon = "fas fa-chair",},
    },
} 

Config.Job.BossLocations = {
    ["yellowjack"] = {
        [1] = { 
            location = vector3(2519.48, 4098.42, 35.59),
            heading = 243.73,
            minZ = 35.29,
            maxZ = 35.79,
            length = 0.5,
            width = 0.5,
        },
    },
    ["glazedandglorious"] = {
        [1] = {
            location = vector3(-578.27, -1066.67, 26.86),
            heading = 0.93,
            minZ = 26.61,
            maxZ = 27.11,
            length = 0.1,
            width = 0.51,
        },
    },
    ["vanillaunicorn"] = {
        [1] = {
            location = vector3(96.19, -1292.82, 29.26),
            heading = 309.96,
            minZ = 29.12,
            maxZ = 29.55,
            length = 0.2,
            width = 0.5,
        },
    },
    ["tequilala"] = {  
        [1] = {
            location = vector3(-573.47, 294.18, 79.01),
            heading = 165.00,
            minZ = 78.68,
            maxZ = 79.01,
            length = 0.5,
            width = 0.3,
        },
    }, 
    ["smokeonthewater"] = {
        [1] = {
            location = vector3(376.87, -824.59, 28.9),
            heading = 180.22,
            minZ = 28.3,
            maxZ = 29.2,
            length = 0.77,
            width = 0.7,
        },
    }, 
    ["finnistaxi"] = {
        [1] = {
            location = vector3(907.16, -149.8, 74.17),
            heading = 337.33,
            minZ = 73.87,
            maxZ = 74.47,
            length = 0.6,
            width = 0.6,
        },
    }, 
    ["tenfourtwo"] = {
        [1] = {
            location = vector3(1234.91, -416.53, 71.75),
            heading = 350.43,
            minZ = 71.55,
            maxZ = 71.95,
            length = 0.20,
            width = 0.60,
        },
    }, 
    ["nismostuning"] = {
        [1] = {
            location = vector3(-1591.65, -856.3, 10.1),
            heading = 45.0,
            minZ = 9.9,
            maxZ = 10.6,
            length = 0.2,
            width = 1.4,
        },
    },
    ["bikinitow"] = {
        [1] = {
            location = vector3(835.1, -827.34, 26.33),
            heading = 0.0,
            minZ = 26.15,
            maxZ = 26.75,
            length = 0.4,
            width = 0.4,
        },
    },
    ["realestate"] = {
        [1] = {
            location = vector3(-598.73, -718.84, 116.81),
            heading = 330.14,
            minZ = 116.51,
            maxZ = 117.31,
            length = 0.25,
            width = 1.10,
        },
    },
    ["cardealer"] = {
        [1] = {
            location = vector3(-932.7, -2031.73, 9.51),
            heading = 315,
            minZ = 9.31,
            maxZ = 9.91,
            length = 0.8,
            width = 0.6,
        },
    },
    ["beaveraviation"] = {
        [1] = {
            location = vector3(1700.71, 3289.16, 48.92),
            heading = 50.0,
            minZ = 47.0,
            maxZ = 49.0,
            length = 0.5,
            width = 0.5,
        },
    },
    ["paintball"] = {
        [1] = {
            location = vector3(-1060.05, 4919.67, 211.82),
            heading = 125.0,
            minZ = 211.8,
            maxZ = 212.5,
            length = 0.1,
            width = 0.85,
        },
    },
    ["maisonette"] = {
        [1] = {
            location = vector3(-1390.44, -605.1, 30.32),
            heading = 295,
            minZ = 30.27,
            maxZ = 30.67,
            length = 0.6,
            width = 0.4,
        },
    },
    ["knifeshop"] = {
        [1] = {
            location = vector3(-673.1, 5829.87, 17.34),
            heading = 315,
            minZ = 17.14,
            maxZ = 17.54,
            length = 0.6,
            width = 0.6,
        },
    },
    ["glizzycomics"] = {
        [1] = {
            location = vector3(-43.15, -90.43, 58.37),
            heading = 340,
            minZ = 58.22,
            maxZ = 58.57,
            length = 0.4,
            width = 0.5,
        },
    },
    ["bikedealer"] = {
        [1] = {
            location = vector3(35.4, 6491.19, 31.44),
            heading = 0,
            minZ = 31.24,
            maxZ = 31.64,
            length = 0.6,
            width = 0.6,
        },
    },
    ["clinic"] = {
        [1] = {
            location = vector3(360.21, -600.82, 43.28),
            heading = 340,
            minZ = 43.08,
            maxZ = 43.68,
            length = 0.6,
            width = 0.6,
        },
    },
    ["koi"] = {
        [1] = {
            location = vector3(-1044.0, -1489.1, 1.64),
            heading = 35,
            minZ = 1.04,
            maxZ = 2.44,
            length = 0.6,
            width = 0.6,
        },
    },
}  

Config.Job.DutyLocations = { 
    ["yellowjack"] = { --Magazine on bar, needs better placement
        [1] = {
            location = vector3(2510.37, 4095.85, 39.53),
            heading = 147.40,
            minZ = 39.18,
            maxZ = 39.88,
            length = 0.5,
            width = 0.3,
        },
    },
    ["glazedandglorious"] = { -- Cat Shelf at the moment, needs better placement  vector4(-594.19, -1052.06, 22.82, 94.75)
        [1] = {
            location = vector3(-594.19, -1052.06, 22.99),
            heading = 89.50,
            minZ = 22.74,
            maxZ = 23.17,
            length = 0.1,
            width = 0.3,
        },
    },
    ["vanillaunicorn"] = {
        [1] = {
            location = vector3(128.48, -1279.24, 29.70),
            heading = 31.06,
            minZ = 29.45,
            maxZ = 29.95,
            length = 0.25,
            width = 0.45,
        },
    },
    ["tequilala"] = {  
        [1] = {
            location = vector3(-562.77, 283.16, 82.55),
            heading = 84.91,
            minZ = 82.00,
            maxZ = 83.10,
            length = 0.3,
            width = 0.5,
        },
    }, 
    ["smokeonthewater"] = {
        [1] = {
            location = vector3(373.48, -823.95, 28.5),
            heading = 90.31,
            minZ = 28.3,
            maxZ = 29.3,
            length = 0.77,
            width = 0.7,
        },
    }, 
    ["finnistaxi"] = {
        [1] = {
            location = vector3(894.87, -168.22, 74.17),
            heading = 325.23,
            minZ = 74.07,
            maxZ = 74.57,
            length = 0.70,
            width = 0.20,
        },
    }, 
    ["tenfourtwo"] = {
        [1] = {
            location = vector3(1232.34, -419.06, 67.77),
            heading = 181.69,
            minZ = 67.57,
            maxZ = 68.07,
            length = 0.35,
            width = 0.50,
        },
    },
    ["nismostuning"] = {
        [1] = {
            location = vector3(-1605.87, -839.54, 10.33),
            heading = 318.0,
            minZ = 10.38,
            maxZ = 11.00,
            length = 0.2,
            width = 0.8,
        },
    },
    ["bikinitow"] = {
        [1] = {
            location = vector3(823.92, -829.33, 26.65),
            heading = 91.10,
            minZ = 26.45,
            maxZ = 26.85,
            length = 0.3,
            width = 0.35,
        },
    },
    ["realestate"] = {
        [1] = {
            location = vector3(-594.31, -711.11, 113.01),
            heading = 255,
            minZ = 112.86,
            maxZ = 113.26,
            length = 0.4,
            width = 0.6,
        },
    }, 
    ["slurpngo"] = {
        [1] = {
            location = vector3(-1412.61, -262.93, 46.38),
            heading = 132.00,
            minZ = 45.38,
            maxZ = 47.88,
            length = 1.50,
            width = 1.50,
        },
    }, 
    ["cardealer"] = {
        [1] = {
            location = vector3(-918.85, -2031.1, 9.51),
            heading = 315.0,
            minZ = 9.31,
            maxZ = 9.91,
            length = 0.6,
            width = 0.8,
        },
    }, 
    ["beaveraviation"] = {
        [1] = {
            location = vector3(1702.66, 3291.46, 48.92),
            heading = 50.0,
            minZ = 47.0,
            maxZ = 49.0,
            length = 0.5,
            width = 0.5,
        },
        [2] = {
            location = vector3(-1621.06, -3153.1, 13.99),
            heading = 320,
            minZ = 12.99,
            maxZ = 14.99,
            length = 1.0,
            width = 0.2,
        },
    },
    ["paintball"] = {
        [1] = {
            location = vector3(-1046.73, 4919.58, 209.36),
            heading = 0,
            minZ = 208.96,
            maxZ = 209.36,
            length = 0.2,
            width = 0.2,
        },
    },
    ["maisonette"] = {
        [1] = {
            location = vector3(-1386.37, -590.04, 30.32),
            heading = 305,
            minZ = 30.22,
            maxZ = 30.62,
            length = 0.4,
            width = 0.4,
        },
    },
    ["knifeshop"] = {
        [1] = {
            location = vector3(-673.34, 5830.75, 17.14),
            heading = 25,
            minZ = 16.89,
            maxZ = 17.19,
            length = 0.7,
            width = 0.7,
        },
    },
    ["glizzycomics"] = {
        [1] = {
            location = vector3(-46.77, -91.64, 58.37),
            heading = 342,
            minZ = 58.57,
            maxZ = 58.97,
            length = 0.8,
            width = 0.4,
        },
    },
    ["bikedealer"] = {
        [1] = {
            location = vector3(36.82, 6478.28, 31.44),
            heading = 50,
            minZ = 31.24,
            maxZ = 31.64,
            length = 0.8,
            width = 0.4,
        },
    },
    ["clinic"] = {
        [1] = {
            location = vector3(360.28, -599.56, 43.28),
            heading = 340,
            minZ = 43.28,
            maxZ = 43.48,
            length = 0.4,
            width = 0.4,
        },
    },
    ["koi"] = {
        [1] = {
            location = vector3(-1029.48, -1472.22, 5.3),
            heading = 35,
            minZ = 5.35,
            maxZ = 5.55,
            length = 0.2,
            width = 0.4,
        },
    },
}  

-- Unique garages
Config.Job.Garages = { 
    ["slurpngo"] = {
        [1] = {
            busName = "slurpngo",
            busLabel = "Slurp n Go Options",
            location = vector3(-1418.5, -255.72, 46.46),
            heading = 132.00,
            minZ = 45.38,
            maxZ = 47.88,
            length = 1.50,
            width = 1.50,
            vehicleHash = "mrtasty",
            spawnPoint = vector4(-1417.4, -249.18, 46.35, 39.96),
            platePrefix = "SLURP",
            ranks = {0, 1, 2, 3, 4}
        },
    },
    ["gopostal"] = {
        [1] = {
            busName = "gopostal",
            busLabel = "Go Postal Options",
            location = vector3(83.02, 80.96, 78.63),
            heading = 340,
            minZ = 78.23,
            maxZ = 79.83,
            length = 1.0,
            width = 0.4,
            vehicleHash = {"t680", "tvtrailer"},
            spawnPoint = vector4(76.06, 89.89, 78.74, 67.7),
            platePrefix = "GOPOST",
            ranks = {0, 1, 2, 3, 4,}
        },
    }, 
    ["clinic"] = {
        [1] = {
            busName = "clinic",
            busLabel = "Clinic Options",
            location = vector3(341.31, -578.41, 28.8),
            heading = 340,
            minZ = 29.0,
            maxZ = 229.6,
            length = 0.2,
            width = 0.6,
            vehicleHash = "express",
            spawnPoint = vector4(337.08, -579.34, 28.8, 341.82),
            platePrefix = "CLINIC",
            ranks = {0, 1, 2, 3, 4, 5, 6, 7}
        },
    }, 
}  

Config.Job.Vehicles = {
    [`mrtasty`] = "Slurp n Go Van",
    [`t680`] = "Semi Truck",
    [`tvtrailer`] = "Lowboy Trailer",
    [`express`] = "Clinic Van"
}

-- Prop registers
Config.Job.RegisterSpawns = {    
    [1] = {   --Open Road Upstairs Bar
    position = vector3(2519.92, 4109.41, 42.78),
    heading = 335.18,
    },  
    [2] = {   -- 10-42 Bar One
    position = vector3(1229.59, -418.36, 67.82),
    heading = 165.52,
    },  
    [3] = {   -- Nismos
    position = vector3(-1603.08, -837.21, 10.35),
    heading = 49.13,
    },  
}

Config.Job.Elevators = {
    {name = "Wolf Entrance", label = "Wolfs International Realty",   icon = "fa-solid fa-elevator", boxPosition = vector3(-589.45, -708.36, 36.28),  exitPoint = vector4(-574.77, -715.72, 113.01, 90.01),  heading = 180.00, minz = 34.28, maxz =  37.28, tooltiptext = "Enter", xsize = 1.0, ysize = 2.5},
    {name = "Wolf Exit", label = "Exit Building",   icon = "fa-solid fa-elevator", boxPosition = vector3(-576.16, -714.28, 113.21),  exitPoint = vector4(-589.48, -707.18, 36.28, 360.00),  heading = 180.00, minz = 112.50, maxz =  113.80, tooltiptext = "Exit", xsize = 1.4, ysize = 0.7},
    {name = "Wolf Helipad", label = "Wolfs Helipad",   icon = "fa-solid fa-elevator", boxPosition = vector3(-575.9, -711.78, 113.01),  exitPoint = vector4(-580.26, -716.74, 129.88, 95.57),  heading = 0, minz = 113.16, maxz =  113.36, tooltiptext = "Enter", xsize = 0.4, ysize = 0.2},
    {name = "Wolf Helipad Exit", label = "Wolfs Helipad Exit",   icon = "fa-solid fa-elevator", boxPosition = vector3(-578.79, -716.77, 129.88),  exitPoint = vector4(-574.8, -712.84, 113.01, 89.57),  heading = 0, minz = 129.68, maxz =  130.28, tooltiptext = "Enter", xsize = 1.0, ysize = 1.0},
} 