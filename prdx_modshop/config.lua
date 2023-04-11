Config = Config or {}
Config.itemCosts = {
	-- DO NOT CHANGE THIS ORDER OR COMMENT ANYTHING OUT IN THIS TABLE --
	-- For all multi-items ("brakes", "engines", "suspension", "transmission") you are specifying the price for the first level upgrade, each level upgrade will go up a certain percentage after that. --
	-- You can change the percentage value with the variable above this table --
	-- Everything else is a flat rate for that type of upgrade. --
	30, -- liveries
	50, -- tyres
	250, -- brakes
	10, -- spoilers
	20, -- bumper front
	20, -- bumper rear
	20, -- skirts
	10, -- mufflers
	30, -- chassis
	10, -- grill
	20, -- hoods
	20, -- fenders
	20, -- roofs
	500, -- engine
	5000, -- turbo
	250, -- suspension
	250, -- transmission
	10, -- plate holder		(Bennys)
	10, -- vanity plate		(Bennys)
	10, -- trim design			(Bennys)
	10, -- ornaments			(Bennys)
	10, -- dashboard			(Bennys)
	10, -- dial design			(Bennys)
	10, -- door speakers		(Bennys)
	10, -- seats				(Bennys)
	10, -- steering wheels		(Bennys)
	10, -- shifter knobs		(Bennys)
	10, -- plaques				(Bennys)
	10, -- speakers			(Bennys)
	10, -- trunk				(Bennys)
	30, -- hydraulics			(Bennys)
	20, -- engine block		(Bennys)
	10, -- air filter			(Bennys)
	10, -- struts				(Bennys)
	10, -- arch cover			(Bennys)
	10, -- arials				(Bennys)
	10, -- trim				(Bennys)
	10, -- tank				(Bennys)
	10, -- windows				(Bennys)
	10, -- fucked if I know?	(Bennys) I actually have no idea what this one is?
	10, -- Benny Liveries		(Bennys)
	10, -- light colour		(Bennys)
	10, -- tank again?			(Bennys) Looks like this one is ONLY for the slamvan3, perhaps price it the same as the other tank option
	10, -- respray
	35, -- neon colour		
	10, -- plate
	2000, -- rename plate 		
	100, -- window tint
	50, -- Honk
}

Config.AllNeonColours = {
	{{222, 222, 255}, "CMOD_NEONCOL_0"},
	{{2, 21, 255}, "CMOD_NEONCOL_1"},
	{{3, 83, 255}, "CMOD_NEONCOL_2"},
	{{0, 255, 140}, "CMOD_NEONCOL_3"},
	{{94, 255, 1}, "CMOD_NEONCOL_4"},
	{{255, 255, 0}, "CMOD_NEONCOL_5"},
	{{255, 150, 0}, "CMOD_NEONCOL_6"},
	{{255, 62, 0}, "CMOD_NEONCOL_7"},
	{{255, 1, 1}, "CMOD_NEONCOL_8"},
	{{255, 50, 100}, "CMOD_NEONCOL_9"},
	{{255, 5, 190}, "CMOD_NEONCOL_10"},
	{{35, 1, 255}, "CMOD_NEONCOL_11"},
	{{15, 3, 255}, "CMOD_NEONCOL_12"},
}

Config.priceMultiplier = 1

Config.Locations = {
    {
        shopType = 'LSCustomsInt',
        blip = true,
        coords = vec3(-337.38, -136.92, 38.57),
    },
    {
        shopType = 'LSCustomsInt',
        blip = true,
        coords = vec3(-1155.53, -2007.18, 12.74),
    },
    {
        shopType = 'LSCustomsInt',
        blip = true,
        coords = vec3(731.81, -1088.82, 21.73),
    },
    {
        shopType = 'LSCustomsInt',
        blip = true,
        coords = vec3(1175.04, 2640.21, 37.32),
    },
    {
        shopType = 'LSCustomsInt',
        blip = true,
        coords = vec3(110.99, 6626.39, 30.89),
    },
    {
        shopType = 'LSCustomsInt',
        blip = true,
        coords = vec3(-212.368, -1325.486, 31.176),
    },
    -- Non-interiors --
    {
        shopType = 'LSCustoms',
        blip = true,
        coords = vec3(-991.92, -2058.48, -121.0),
    },
    {
        shopType = 'LSCustoms',
        blip = true,
        coords = vec3(964.07, -1816.19, -111.49),
    },
    {
        shopType = 'LSCustoms',
        blip = true,
        coords = vec3(2854.19, -3792.54, 129.72),
    },
    {
        shopType = 'LSCustoms',
        blip = true,
        coords = vec3(548.51, -198.7, 54.49-0.95),
    },
    -- No markers --
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vec3(-559.74, -914.59, 23.89),
    },
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vec3(829.88, -805.26, 26.33),
    },
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vec3(830.04, -812.96, 26.33),
    },
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vec3(830.45, -820.31, 26.33),
    },
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vec3(831.74, -788.79, 27.45),
    },
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vec3(-1625.74, -824.15, 10.07),
    },
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vec3(38.28, 6491.87, 31.44),
    },
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vec3(77.5, 91.43, 78.75),
    },
    {
        shopType = 'LSCustoms', --pilbox garage ems
        blip = false,
        coords = vec3(315.71, -576.13, 28.8),
    },
    {
        shopType = 'LSCustoms', --kildares
        blip = false,
        coords = vec3(-948.52, -2050.69, 9.51),
    },
    -- Commercial --
    {
        shopType = 'Commercial',
        blip = true,
        coords = vec3(332.31, 3408.84, 35.6),
    }, 
    {
        shopType = 'Commercial',
        blip = true,
        coords = vec3(921.13, -1233.6, 24.3),
    }, 
    {
        shopType = 'Commercial',
        blip = true,
        coords = vec3(-364.79, 6063.8, 30.45),
    }, 
    -- Aircraft --
    {
        shopType = 'Aircraft',
        blip = true,
        coords = vec3(-1486.62, -3225.86, 13.0),
    },
    {
        shopType = 'Aircraft',
        blip = true,
        coords = vec3(1699.73, 3272.35, 40.1),
    },
    -- Boat --
    {
        shopType = 'Boat',
        blip = true,
        coords = vec3(-934.69, -1461.01, 0.0),
    },
    {
        shopType = 'Boat',
        blip = true,
        coords = vec3(1485.8, 3848.62, 29.5),
    },
    {
        shopType = 'Boat',
        blip = true,
        coords = vec3(-300.0, 6623.0, -0.8),
    },
    {
        shopType = 'LSCustoms',
        blip = false,
        coords = vector3(834.65, -3236.26, -98.7),
    },
}