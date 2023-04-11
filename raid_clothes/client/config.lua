Config = {
    barberShops = {
        vector3(1932.0756835938, 3729.6706542969, 32.844413757324),
        vector3(-278.19036865234, 6228.361328125, 31.695510864258),
        vector3(1211.9903564453, -472.77117919922, 66.207984924316),
        vector3(-33.224239349365, -152.62608337402, 57.076496124268),
        vector3(136.7181854248, -1708.2673339844, 29.291622161865),
        vector3(-815.18896484375, -184.53868103027, 37.568943023682),
        vector3(-1283.2886962891, -1117.3210449219, 6.9901118278503),
    },

    clothingShops = {
        vector3(1693.45667, 4823.17725, 42.1631294),
        vector3(-712.215881,-155.352982, 37.4151268),
        vector3(-1192.94495,-772.688965, 17.3255997),
        vector3( 425.236,-806.008,28.491),
        vector3( -162.658,-303.397,38.733),
        vector3( 75.950,-1392.891,28.376),
        vector3( -822.194,-1074.134,10.328),
        vector3( -1450.711,-236.83,48.809),
        vector3( 4.254,6512.813,30.877),
        vector3( 615.180,2762.933,41.088),
        vector3( 1196.785,2709.558,37.222),
        vector3( -3171.453,1043.857,19.863),
        vector3( -1100.959,2710.211,18.107),
        vector3( -1207.6564941406,-1456.8890380859,4.3784737586975),
        vector3( 121.76,-224.6,53.56),
    },

    tattoosShops = {
        vector3(1322.645, -1651.976, 52.275),
        vector3(-1153.676, -1425.68, 4.954),
        vector3(322.139, 180.467, 103.587),
        vector3(-3170.071, 1075.059, 20.829),
        vector3(1864.633, 3747.738, 33.032),
        vector3(-293.713, 6200.04, 31.487),
    },

    Outfits = {
        -- Job outfits
        ["lspd"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "LSPD Standard Uniform",
                    outfitData = {
                        ["hat"]         = { item = -1, texture = -1},  -- Hat
                        ["torso2"]      = { item = 427, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 258, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 14, texture = 0},  -- Arms
                        ["pants"]       = { item = 153, texture = 0},  -- Pants
                        ["shoes"]       = { item = 54, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = -1},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 78, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 164, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "LSPD Supervisor",
                    outfitData = {
                        ["hat"]         = { item = -1, texture = -1},  -- Hat
                        ["torso2"]      = { item = 427, texture = 1},  -- Jacket
                        ["t-shirt"]     = { item = 258, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 14, texture = 0},  -- Arms
                        ["pants"]       = { item = 149, texture = 0},  -- Pants
                        ["shoes"]       = { item = 54, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = -1},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 78, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 164, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [3] = {
                    outfitLabel = "LSPD FTO Phase Uniform",
                    outfitData = {
                        ["hat"]         = { item = 177, texture = 14},  -- Hat
                        ["torso2"]      = { item = 427, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = 258, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 1, texture = 0},  -- Arms
                        ["pants"]       = { item = 153, texture = 0},  -- Pants
                        ["shoes"]       = { item = 54, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = -1},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 57, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 164, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [4] = {
                    outfitLabel = "LSPD 14 Day Probation Uniform",
                    outfitData = {
                        ["hat"]         = { item = 177, texture = 14},  -- Hat
                        ["torso2"]      = { item = 427, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = 258, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 1, texture = 0},  -- Arms
                        ["pants"]       = { item = 153, texture = 0},  -- Pants
                        ["shoes"]       = { item = 54, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = -1},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 164, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals 
                    },
                },
                [5] = {
                    outfitLabel = "LSPD MOTO Unit",
                    outfitData = {
                        ["hat"]         = { item = 178, texture = 0},  -- Hat
                        ["torso2"]      = { item = 432, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 258, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 1, texture = 0},  -- Arms
                        ["pants"]       = { item = 153, texture = 0},  -- Pants
                        ["shoes"]       = { item = 15, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = -1},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 86, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 111, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [6] = {
                    outfitLabel = "Bicycle Patrol",
                    outfitData = {
                        ["hat"]         = { item = 192, texture = 0},  -- Hat
                        ["torso2"]      = { item = 495, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = 258, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 19, texture = 0},  -- Arms
                        ["pants"]       = { item = 156, texture = 0},  -- Pants
                        ["shoes"]       = { item = 9, texture = 13},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = -1},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 164, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [7] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 19, texture = 0},  -- Hat
                        ["torso2"]      = { item = 430, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 211, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 1, texture = 0},  -- Arms
                        ["pants"]       = { item = 154, texture = 0},  -- Pants
                        ["shoes"]       = { item = 97, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = -1},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 164, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "LSPD Standard Uniform",
                    outfitData = {
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["torso2"]      = { item = 462, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 277, texture = 1},  -- T Shirt
                        ["arms"]        = { item = 14, texture = 0},  -- Arms
                        ["pants"]       = { item = 172, texture = 0},  -- Pants
                        ["shoes"]       = { item = 117, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 115, texture = 0},  -- Bag
                    },
                },
                [2] = {
                    outfitLabel = "LSPD Supervisor Uniform",
                    outfitData = {
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["torso2"]      = { item = 462, texture = 1},  -- Jacket
                        ["t-shirt"]     = { item = 277, texture = 1},  -- T Shirt
                        ["arms"]        = { item = 14, texture = 0},  -- Arms
                        ["pants"]       = { item = 172, texture = 0},  -- Pants
                        ["shoes"]       = { item = 117, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 115, texture = 0},  -- Bag
                    },
                },
                [3] = {
                    outfitLabel = "LSPD Probationary Uniform",
                    outfitData = {
                        ["hat"]         = { item = 174, texture = 6},  -- Hat
                        ["torso2"]      = { item = 462, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 14, texture = 0},  -- Arms
                        ["pants"]       = { item = 172, texture = 0},  -- Pants
                        ["shoes"]       = { item = 117, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 115, texture = 0},  -- Bag
                    },
                },
                [4] = {
                    outfitLabel = "LSPD MOTO Unit",
                    outfitData = {
                        ["hat"]         = { item = 173, texture = 0},  -- Hat
                        ["torso2"]      = { item = 456, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 14, texture = 0},  -- Arms
                        ["pants"]       = { item = 172, texture = 0},  -- Pants
                        ["shoes"]       = { item = 57, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["bag"]         = { item = -1, texture = 0},  -- Bag
                    },
                },
                [5] = {
                    outfitLabel = "Bicycle Patrol",
                    outfitData = {
                        ["hat"]         = { item = 187, texture = 0},  -- Hat
                        ["torso2"]      = { item = 456, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 31, texture = 0},  -- Arms
                        ["pants"]       = { item = 191, texture = 0},  -- Pants
                        ["shoes"]       = { item = 81, texture = 8},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 145, texture = 0},  -- Bag
                    },
                },
                [6] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 19, texture = 0},  -- Hat
                        ["torso2"]      = { item = 328, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 23, texture = 0},  -- Arms
                        ["pants"]       = { item = 180, texture = 0},  -- Pants
                        ["shoes"]       = { item = 115, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 111, texture = 0},  -- Bag
                        ["decals"]      = { item = 87,  texture = 0},  -- Decals
                    },
                },
            }
        },
        ["bcso"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "BCSO Standard Uniform",
                    outfitData = {
                        ["pants"]       = { item = 153, texture = 4},  -- Pants
                        ["arms"]        = { item = 37, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 226, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 453, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 116, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 184, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 121, texture = 0},  -- Mask
                        ["decals"]      = { item = 139,  texture = 3 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "BCSO Probationary Officer",
                    outfitData = {
                        ["pants"]       = { item = 153, texture = 5},  -- Pants
                        ["arms"]        = { item = 38, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 226, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 452, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 116, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 185, texture = -1},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 121, texture = 0},  -- Mask
                        ["decals"]      = { item = 138,  texture = 3 },  -- Decals
                    },
                },
                [3] = {
                    outfitLabel = "BCSO MOTO Unit",
                    outfitData = {
                        ["pants"]       = { item = 155, texture = 3},  -- Pants 
                        ["arms"]        = { item = 172, texture = 0},  -- Arms 
                        ["t-shirt"]     = { item = 198, texture = 0},  -- T Shirt 
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest 
                        ["torso2"]      = { item = 448, texture = 0},  -- Jacket 
                        ["shoes"]       = { item = 33, texture = 0},  -- Shoes 
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory 
                        ["bag"]         = { item = -1, texture = 0},  -- Bag 
                        ["hat"]         = { item = 187, texture = 0},  -- Hat 
                        ["glass"]       = { item = 42, texture = 0},  -- Glasses 
                        ["mask"]        = { item = -1, texture = 0},  -- Mask  
                        ["decals"]      = { item = 0,  texture = 0},  -- Decals
                    },
                },
                [4] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 180, texture = 0},  -- Hat 
                        ["torso2"]      = { item = 430, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 198, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 17, texture = 0},  -- Arms
                        ["pants"]       = { item = 154, texture = 0},  -- Pants
                        ["shoes"]       = { item = 116, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 116, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [5] = {
                    outfitLabel = "Bicycle Patrol",
                    outfitData = {
                        ["hat"]         = { item = 192, texture = 0},  -- Hat
                        ["torso2"]      = { item = 461, texture = 16},  -- Jacket
                        ["t-shirt"]     = { item = 226, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 30, texture = 0},  -- Arms
                        ["pants"]       = { item = 15, texture = 1},  -- Pants
                        ["shoes"]       = { item = 102, texture = 0},  -- Shoes
                        ["mask"]        = { item = 121, texture = 0},  -- Mask
                        ["glass"]       = { item = 42, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "BCSO Standard Uniform", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 172, texture = 4},  -- Pants 
                        ["arms"]        = { item = 33, texture = 0},  -- Arms 
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt 
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest 
                        ["torso2"]      = { item = 477, texture = 2},  -- Jacket 
                        ["shoes"]       = { item = 117, texture = 0},  -- Shoes 
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory 
                        ["bag"]         = { item = 0, texture = 0},  -- Bag 
                        ["hat"]         = { item = -1, texture = -1},  -- Hat 
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses 
                        ["mask"]        = { item = 121, texture = 0},  -- Mask 
                        ["decals"]      = { item = 155,  texture = 0 },  -- Decals 
                    },
                },
                [2] = {
                    outfitLabel = "BCSO Probationary Uniform", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 172, texture = 5},  -- Pants 
                        ["arms"]        = { item = 36, texture = 0},  -- Arms 
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt 
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest 
                        ["torso2"]      = { item = 476, texture = 0},  -- Jacket 
                        ["shoes"]       = { item = 117, texture = 0},  -- Shoes 
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory 
                        ["bag"]         = { item = 0, texture = 0},  -- Bag 
                        ["hat"]         = { item = -1, texture = -1},  -- Hat 
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses 
                        ["mask"]        = { item = 121, texture = 0},  -- Mask 
                        ["decals"]      = { item = 154,  texture = 0 },  -- Decals 
                    },
                },
                [3] = {
                    outfitLabel = "BCSO MOTO Unit", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 175, texture = 2},  -- Pants 
                        ["arms"]        = { item = 212, texture = 0},  -- Arms 
                        ["t-shirt"]     = { item = 44, texture = 1},  -- T Shirt 
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest 
                        ["torso2"]      = { item = 474, texture = 0},  -- Jacket 
                        ["shoes"]       = { item = 9, texture = 0},  -- Shoes 
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory 
                        ["bag"]         = { item = 0, texture = 0},  -- Bag 
                        ["hat"]         = { item = 62, texture = 9},  -- Hat 
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses 
                        ["mask"]        = { item = 121, texture = 0},  -- Mask 
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals 
                    },
                },
                [4] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 199, texture = 2},  -- Hat
                        ["torso2"]      = { item = 525, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = 14, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 33, texture = 0},  -- Arms
                        ["pants"]       = { item = 185, texture = 1},  -- Pants
                        ["shoes"]       = { item = 117, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = -1, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals 
                    },
                },
                [5] = {
                    outfitLabel = "Bicycle Patrol",
                    outfitData = {
                        ["hat"]         = { item = 187, texture = 0},  -- Hat
                        ["torso2"]      = { item = 520, texture = 3},  -- Jacket
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 44, texture = 0},  -- Arms
                        ["pants"]       = { item = 25, texture = 3},  -- Pants
                        ["shoes"]       = { item = 103, texture = 2},  -- Shoes
                        ["mask"]        = { item = 121, texture = 0},  -- Mask
                        ["glass"]       = { item = 42, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
        },
        ["sast"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "SAST Standard Uniform", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 153, texture = 3},  -- Pants
                        ["arms"]        = { item = 11, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 258, texture = 1},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                        ["torso2"]      = { item = 439, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 181, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "SAST MOTO Unit", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 148, texture = 1},  -- Pants
                        ["arms"]        = { item = 17, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 194, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 407, texture = 1},  -- Jacket
                        ["shoes"]       = { item = -1, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 157, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = -1, texture = 0},  -- Bag 
                        ["hat"]         = { item = 172, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [3] = {
                    outfitLabel = "Phoenix 1", 
                    outfitData = {
                        ["hat"]         = { item = 171, texture = 0},  -- Hat
                        ["torso2"]      = { item = 410, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 209, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 1, texture = 0},  -- Arms
                        ["pants"]       = { item = 150, texture = 0},  -- Pants
                        ["shoes"]       = { item = 97, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 157, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 153, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "SAST Standard Uniform", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 151, texture = 1},  -- Pants
                        ["arms"]        = { item = 0, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 248, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 423, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 101, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 126, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 145, texture = 0},  -- Bag
                        ["hat"]         = { item = 167, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 142,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "SAST MOTO Unit", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 153, texture = 1},  -- Pants
                        ["arms"]        = { item = 18, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 248, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["decals"]      = { item = 142,  texture = 0 },  -- Decals
                        ["torso2"]      = { item = 423, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 9, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 126, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 154, texture = 0},  -- Bag
                        ["hat"]         = { item = 168, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                    },
                },
                [3] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 190, texture = 0},  -- Hat
                        ["torso2"]      = { item = 484, texture = 8},  -- Jacket
                        ["t-shirt"]     = { item = 248, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 3, texture = 0},  -- Arms
                        ["pants"]       = { item = 167, texture = 0},  -- Pants
                        ["shoes"]       = { item = 110, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 128, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 145, texture = 0},  -- Bag
                    },
                },
            }
        },
        ["hc"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "High Command Standard Uniform", 
                    outfitData = {
                        ["pants"]       = { item = 153, texture = 1},  -- Pants
                        ["arms"]        = { item = 11, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 193, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 439, texture = 1},  -- Jacket
                        ["shoes"]       = { item = 113, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 164, texture = 0},  -- Bag
                        ["hat"]         = { item = 181, texture = 1},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 210, texture = 0},  -- Mask
                        ["decals"]      = { item = 139,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 180, texture = 0},  -- Hat 
                        ["torso2"]      = { item = 430, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 198, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 17, texture = 0},  -- Arms
                        ["pants"]       = { item = 153, texture = 0},  -- Pants
                        ["shoes"]       = { item = 97, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 116, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 199, texture = 2},  -- Hat
                        ["torso2"]      = { item = 525, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = -1, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 33, texture = 0},  -- Arms
                        ["pants"]       = { item = 185, texture = 1},  -- Pants
                        ["shoes"]       = { item = 117, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = -1, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals 
                    },
                },
            }
        },
        ["marshalls"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 180, texture = 0},  -- Hat 
                        ["torso2"]      = { item = 430, texture = 0},  -- Jacket
                        ["t-shirt"]     = { item = 198, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 17, texture = 0},  -- Arms
                        ["pants"]       = { item = 153, texture = 0},  -- Pants
                        ["shoes"]       = { item = 97, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 159, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = 116, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "Phoenix 1",
                    outfitData = {
                        ["hat"]         = { item = 199, texture = 2},  -- Hat
                        ["torso2"]      = { item = 525, texture = 2},  -- Jacket
                        ["t-shirt"]     = { item = -1, texture = 0},  -- T Shirt
                        ["arms"]        = { item = 33, texture = 0},  -- Arms
                        ["pants"]       = { item = 185, texture = 1},  -- Pants
                        ["shoes"]       = { item = 117, texture = 0},  -- Shoes
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["accessory"]   = { item = 130, texture = 0},  -- Neck Accessory
                        ["vest"]        = { item = -1, texture = 0},  -- Body Vest
                        ["bag"]         = { item = -1, texture = 0},  -- Bag
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals 
                    },
                },
            },
        },
        ["pd_cid"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "Investigator (Vest)", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 33, texture = 0},  -- Pants
                        ["arms"]        = { item = 19, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 214, texture = 1},  -- T Shirt
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 398, texture = 4},  -- Jacket
                        ["shoes"]       = { item = 24, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 175, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 108, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = -1},  -- Hat
                        ["glass"]       = { item = -1, texture = -1},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                    [2] = {
                        outfitLabel = "Investigator (No Vest)", -- Out of date
                        outfitData = {
                            ["pants"]       = { item = 33, texture = 0},  -- Pants
                            ["arms"]        = { item = 19, texture = 0},  -- Arms
                            ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                            ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                            ["torso2"]      = { item = 398, texture = 4},  -- Jacket
                            ["shoes"]       = { item = 24, texture = 0},  -- Shoes
                            ["accessory"]   = { item = 175, texture = 0},  -- Neck Accessory
                            ["bag"]         = { item = 108, texture = 0},  -- Bag
                            ["hat"]         = { item = -1, texture = -1},  -- Hat
                            ["glass"]       = { item = -1, texture = -1},  -- Glasses
                            ["mask"]        = { item = 0, texture = 0},  -- Mask
                            ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                        },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "Investigator (Vest)", -- Out of date
                    outfitData = {
						["pants"]       = { item = 32, texture = 0},  -- Pants
                        ["arms"]        = { item = 31, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 253, texture = 1},  -- T Shirt
                        ["vest"]        = { item = 89, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 419, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 24, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 125, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 107, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = -1},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "Investigator (No Vest)", -- Out of date
                    outfitData = {
                        ["pants"]       = { item = 32, texture = 0},  -- Pants
                        ["arms"]        = { item = 31, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 14, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 89, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 419, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 24, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 125, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 107, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = -1},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = -1, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals    
                    },
                },
            },
        },
        ["ambulance"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "Probation",
                    outfitData = {
                        ["pants"]       = { item = 164, texture = 0},  -- Pants
                        ["arms"]        = { item = 86, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 259, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 86, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 481, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 125, texture = 0},  -- Bag
                        ["hat"]         = { item = 207, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "EMT Shirt",
                    outfitData = {
                        ["pants"]       = { item = 164, texture = 0},  -- Pants
                        ["arms"]        = { item = 85, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 258, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 86, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 479, texture = 15},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 163, texture = 0},  -- Bag
                        ["hat"]         = { item = 207, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [3] = {
                    outfitLabel = "EMT Jacket",
                    outfitData = {
                        ["pants"]       = { item = 164, texture = 0},  -- Pants
                        ["arms"]        = { item = 86, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 70, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 484, texture = 2},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 163, texture = 0},  -- Bag
                        ["hat"]         = { item = 207, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [4] = {
                    outfitLabel = "FTO Jacket",
                    outfitData = {
                        ["pants"]       = { item = 164, texture = 0},  -- Pants
                        ["arms"]        = { item = 86, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 458, texture = 1},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 207, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 153,  texture = 1 },  -- Decals
                    },
                },
                [5] = {
                    outfitLabel = "Nurse Surgery",
                    outfitData = {
                        ["pants"]       = { item = 175, texture = 3},  -- Pants
                        ["arms"]        = { item = 85, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 476, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 42, texture = 2},  -- Shoes
                        ["accessory"]   = { item = 167, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 0, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 209, texture = 1},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [6] = {
                    outfitLabel = "Clinic Surgery",
                    outfitData = {
                        ["pants"]       = { item = 175, texture = 0},  -- Pants
                        ["arms"]        = { item = 85, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 476, texture = 1},  -- Jacket
                        ["shoes"]       = { item = 42, texture = 1},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 0, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 209, texture = 2},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [7] = {
                    outfitLabel = "Clinic Nurse",
                    outfitData = {
                        ["pants"]       = { item = 92, texture = 3},  -- Pants
                        ["arms"]        = { item = 85, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 208, texture = 18},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 5},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [8] = {
                    outfitLabel = "Fire Half Turnout", --Out of date
                    outfitData = {
                        ["pants"]       = { item = 120, texture = 0},  -- Pants
                        ["arms"]        = { item = 85, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 259, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 95, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 479, texture = 14},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 172, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 216, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [9] = {
                    outfitLabel = "Fire Full Turnout", --Out of date
                    outfitData = {
                        ["pants"]       = { item = 120, texture = 0},  -- Pants
                        ["arms"]        = { item = 96, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 67, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 315, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 194, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 52, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [10] = {
                    outfitLabel = "Search and Rescue Regular",
                    outfitData = {
                        ["pants"]       = { item = 152, texture = 1},  -- Pants
                        ["arms"]        = { item = 96, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 243, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 105, texture = 2},  -- Body Vest
                        ["torso2"]      = { item = 468, texture = 16},  -- Jacket
                        ["shoes"]       = { item = 25, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 165, texture = 0},  -- Bag
                        ["hat"]         = { item = 196, texture = 2},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [11] = {
                    outfitLabel = "Search and Rescue Boat",
                    outfitData = {
                        ["pants"]       = { item = 94, texture = 7},  -- Pants
                        ["arms"]        = { item = 171, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 243, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 64, texture = 4},  -- Body Vest
                        ["torso2"]      = { item = 243, texture = 7},  -- Jacket
                        ["shoes"]       = { item = 67, texture = 7},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "Probation",
                    outfitData = {
                        ["pants"]       = { item = 184, texture = 0},  -- Pants
                        ["arms"]        = { item = 101, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 241, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 529, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 123, texture = 0},  -- Bag
                        ["hat"]         = { item = 204, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "EMT Shirt",
                    outfitData = {
                        ["pants"]       = { item = 184, texture = 0},  -- Pants
                        ["arms"]        = { item = 96, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 491, texture = 4},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 153, texture = 0},  -- Bag
                        ["hat"]         = { item = 204, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [3] = {
                    outfitLabel = "EMT Jacket",
                    outfitData = {
                        ["pants"]       = { item = 184, texture = 0},  -- Pants
                        ["arms"]        = { item = 101, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 14, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 70, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 515, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 155, texture = 0},  -- Bag
                        ["hat"]         = { item = 204, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [4] = {
                    outfitLabel = "FTO Jacket",
                    outfitData = {
                        ["pants"]       = { item = 184, texture = 0},  -- Pants
                        ["arms"]        = { item = 101, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 14, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 494, texture = 1},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 155, texture = 0},  -- Bag
                        ["hat"]         = { item = 204, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 162,  texture = 1 },  -- Decals
                    },
                },
                [5] = {
                    outfitLabel = "Nurse Surgery",
                    outfitData = {
                        ["pants"]       = { item = 192, texture = 3},  -- Pants
                        ["arms"]        = { item = 98, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 14, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 478, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 121, texture = 1},  -- Shoes
                        ["accessory"]   = { item = 97, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 0, texture = 2},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 210, texture = 1},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [6] = {
                    outfitLabel = "Clinic Surgery", 
                    outfitData = {
                        ["pants"]       = { item = 192, texture = 0},  -- Pants
                        ["arms"]        = { item = 98, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 14, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 478, texture = 1},  -- Jacket
                        ["shoes"]       = { item = 121, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 97, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 0, texture = 2},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 199, texture = 2},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [7] = {
                    outfitLabel = "Clinic Nurse",
                    outfitData = {
                        ["pants"]       = { item = 95, texture = 3},  -- Pants
                        ["arms"]        = { item = 109, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 224, texture = 18},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 0, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [8] = {
                    outfitLabel = "Fire Half Turnout",
                    outfitData = {
                        ["pants"]       = { item = 126, texture = 0},  -- Pants
                        ["arms"]        = { item = 109, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 491, texture = 2},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 133, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 179, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [9] = {
                    outfitLabel = "Fire Full Turnout", 
                    outfitData = {
                        ["pants"]       = { item = 126, texture = 0},  -- Pants
                        ["arms"]        = { item = 18, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 48, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 326, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 1},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 191, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 52, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [10] = {
                    outfitLabel = "Search and Rescue Regular",
                    outfitData = {
                        ["pants"]       = { item = 174, texture = 1},  -- Pants
                        ["arms"]        = { item = 109, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 275, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 105, texture = 2},  -- Body Vest
                        ["torso2"]      = { item = 505, texture = 16},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 157, texture = 0},  -- Bag
                        ["hat"]         = { item = 193, texture = 2},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },   
                [11] = {
                    outfitLabel = "Search and Rescue Boat",
                    outfitData = {
                        ["pants"]       = { item = 102, texture = 5},  -- Pants
                        ["arms"]        = { item = 218, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 275, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 68, texture = 4},  -- Body Vest
                        ["torso2"]      = { item = 262, texture = 5},  -- Jacket
                        ["shoes"]       = { item = 70, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 157, texture = 0},  -- Bag
                        ["hat"]         = { item = 193, texture = 2},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
        },
        ["fire"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "Fire Uniform",
                    outfitData = {
                        ["pants"]       = { item = 164, texture = 0},  -- Pants
                        ["arms"]        = { item = 86, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 259, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 86, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 481, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 125, texture = 0},  -- Bag
                        ["hat"]         = { item = 207, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "Turnout Gear",
                    outfitData = {
                        ["pants"]       = { item = 164, texture = 0},  -- Pants
                        ["arms"]        = { item = 85, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 258, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 86, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 479, texture = 15},  -- Jacket
                        ["shoes"]       = { item = 51, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 163, texture = 0},  -- Bag
                        ["hat"]         = { item = 207, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "Fire Uniform",
                    outfitData = {
                        ["pants"]       = { item = 184, texture = 0},  -- Pants
                        ["arms"]        = { item = 101, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 241, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 529, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 123, texture = 0},  -- Bag
                        ["hat"]         = { item = 204, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                [2] = {
                    outfitLabel = "Turnout Gear",
                    outfitData = {
                        ["pants"]       = { item = 184, texture = 0},  -- Pants
                        ["arms"]        = { item = 96, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 277, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 87, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 491, texture = 4},  -- Jacket
                        ["shoes"]       = { item = 52, texture = 0},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 153, texture = 0},  -- Bag
                        ["hat"]         = { item = 204, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
        },

        -- Civilian outfits

        ["surgery"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "Male Surgery",
                    outfitData = {
                        ["pants"]       = { item = 158, texture = 0},  -- Pants
                        ["arms"]        = { item = 15, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                        ["torso2"]      = { item = 503, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 108, texture = 3},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 0, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "Female Surgery",
                    outfitData = {
                        ["pants"]       = { item = 15, texture = 0},  -- Pants
                        ["arms"]        = { item = 4, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 14, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 524, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 112, texture = 3},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = 0, texture = 0},  -- Hat
                        ["glass"]       = { item = 0, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            }
        },

        ["paintball"] = {
            ["male"] = {
                ["green"] = {
                    outfitLabel = "Green Outfit",
                    outfitData = {
                        ["pants"]       = { item = 77, texture = 1},  -- Pants
                        ["arms"]        = { item = 17, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                        ["torso2"]      = { item = 178, texture = 1},  -- Jacket
                        ["shoes"]       = { item = 55, texture = 1},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 89, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                ["blue"] = {
                    outfitLabel = "Blue Outfit",
                    outfitData = {
                        ["pants"]       = { item = 77, texture = 3},  -- Pants
                        ["arms"]        = { item = 17, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                        ["torso2"]      = { item = 178, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 55, texture = 3},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 89, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                ["red"] = {
                    outfitLabel = "Red Outfit",
                    outfitData = {
                        ["pants"]       = { item = 77, texture = 5},  -- Pants
                        ["arms"]        = { item = 17, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                        ["torso2"]      = { item = 178, texture = 5},  -- Jacket
                        ["shoes"]       = { item = 55, texture = 5},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 89, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                ["white"] = {
                    outfitLabel = "White Outfit",
                    outfitData = {
                        ["pants"]       = { item = 77, texture = 9},  -- Pants
                        ["arms"]        = { item = 17, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                        ["torso2"]      = { item = 178, texture = 9},  -- Jacket
                        ["shoes"]       = { item = 55, texture = 9},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 89, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                ["green"] = {
                    outfitLabel = "Green Outfit",
                    outfitData = {
                        ["pants"]       = { item = 79, texture = 1},  -- Pants
                        ["arms"]        = { item = 3, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 3, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 180, texture = 1},  -- Jacket
                        ["shoes"]       = { item = 58, texture = 1},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 89, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                ["blue"] = {
                    outfitLabel = "Blue Outfit",
                    outfitData = {
                        ["pants"]       = { item = 79, texture = 3},  -- Pants
                        ["arms"]        = { item = 3, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 3, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 180, texture = 3},  -- Jacket
                        ["shoes"]       = { item = 58, texture = 3},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 89, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                ["red"] = {
                    outfitLabel = "Red Outfit",
                    outfitData = {
                        ["pants"]       = { item = 79, texture = 5},  -- Pants
                        ["arms"]        = { item = 3, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 3, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 180, texture = 5},  -- Jacket
                        ["shoes"]       = { item = 58, texture = 5},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 89, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
                ["white"] = {
                    outfitLabel = "White Outfit",
                    outfitData = {
                        ["pants"]       = { item = 79, texture = 9},  -- Pants
                        ["arms"]        = { item = 3, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 3, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 180, texture = 7},  -- Jacket
                        ["shoes"]       = { item = 58, texture = 9},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 89, texture = 0},  -- Mask
                        ["decals"]      = { item = 0,  texture = 0 },  -- Decals
                    },
                },
            }
        },
        ["jail"] = {
            ["male"] = {
                [1] = {
                    outfitLabel = "Jail Uniform",
                    outfitData = {
                        ["pants"]       = { item = 175, texture = 2},  -- Pants
                        ["arms"]        = { item = 11, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 476, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 42, texture = 1},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 150,  texture = 0 },  -- Decals
                    },
                },
            },
            ["female"] = {
                [1] = {
                    outfitLabel = "Jail Uniform",
                    outfitData = {
                        ["pants"]       = { item = 192, texture = 2},  -- Pants
                        ["arms"]        = { item = 9, texture = 0},  -- Arms
                        ["t-shirt"]     = { item = 14, texture = 0},  -- T Shirt
                        ["vest"]        = { item = 0, texture = 0},  -- Body Vest
                        ["torso2"]      = { item = 478, texture = 0},  -- Jacket
                        ["shoes"]       = { item = 1, texture = 1},  -- Shoes
                        ["accessory"]   = { item = 0, texture = 0},  -- Neck Accessory
                        ["bag"]         = { item = 0, texture = 0},  -- Bag
                        ["hat"]         = { item = -1, texture = 0},  -- Hat
                        ["glass"]       = { item = -1, texture = 0},  -- Glasses
                        ["mask"]        = { item = 0, texture = 0},  -- Mask
                        ["decals"]      = { item = 159,  texture = 0 },  -- Decals
                    },
                },
            },
        },
    }
}