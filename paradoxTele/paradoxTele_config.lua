Config = {}

Config.DrugBlips = {
	--vec3(-661.45, -900.83, 23.61), 	-- Weed Processing
	--vec3(2224.66, 5604.62, 53.92), 	-- Coke Lab
	--vec3(859.06, 2877.50, 56.98), 	-- Meth Lab
	--vec3(2414.84, 4032.07, 35.82), 	-- Money Laundering
	--vec3(-944.52, 323.80, 70.35), 	-- Drug Dealer
	--vec3(2685.24 + 2.4, 3515.36 + 23.4, 53.3), -- Bunker
	--vec3(2303.42 + 10.3, 5134.72 + 6.4, 51.31) 	-- Weed Field
}

Config.BannedLicenseIdentifiers = {
	"license:xxxxxxxxxxx", -- Dummy license
}

Config.telePoints = {
	{	-- Stuck in spawn
		inVec = 		vector3(2169.43, 2921.51, -81.08), 	
		outVec = 		vector3(194.96, -933.82, 30.69), 	
		inHead = 		35.33,		
		outHead = 		235.14, 
		markerType = 	42, 
		markerR = 		255, 
		markerG = 		216, 
		markerB = 		0, 
		markerA = 		100, 
		noOutsideMarker = true,
		inText = 		"Exit Spawn", 	
		outText = 		"", 
		allowVehicle = 	false, 
		markerDir = 	vec3(90.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.5, 1.5, 1.5),
	},
	{	-- Stuck in spawn 2
		inVec = 		vector3(2167.93, 2921.0, -84.8), 	
		outVec = 		vector3(194.96, -933.82, 30.69), 	
		inHead = 		93.47,		
		outHead = 		235.14, 
		markerType = 	42, 
		markerR = 		255, 
		markerG = 		216, 
		markerB = 		0, 
		markerA = 		100, 
		noOutsideMarker = true,
		inText = 		"Exit Spawn", 	
		outText = 		"", 
		allowVehicle = 	false, 
		markerDir = 	vec3(90.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.5, 1.5, 1.5),
	},
	{	-- FBI Building
		inVec = 		vec3(136.212, -761.383, 44.772), 	
		outVec = 		vec3(136.348, -761.73, 241.172), 	
		inHead = 		165.16,		
		outHead = 		165.16, 
		markerType = 	27, 
		markerR = 		255, 
		markerG = 		216, 
		markerB = 		0, 
		markerA = 		100, 
		inText = 		"Enter FIB", 	
		outText = 		"Exit Lobby", 
		allowVehicle = 	false, 
		markerDir = 	vec3(0.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.5, 1.5, 1.5)
	},
	{	-- Union Depository
		inVec = 		vec3(10.0935, -667.652, 32.6692), 	
		outVec = 		vec3(1.13106, -702.7, 15.351), 		
		inHead = 		321.7075,	
		outHead = 		234.62, 
		markerType = 	27, 
		markerR = 		255, 
		markerG = 		216, 
		markerB = 		0, 
		markerA = 		0, 
		inText = 		"Enter Union Depository", 	
		outText = 		"Exit", 
		allowVehicle = 	false, 
		powerOffOnly = 	true,
		AlertPolice	 =  true,
		markerDir = 	vec3(0.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.5, 1.5, 1.5)
	}, 
	{	-- Split Sides
		inVec = 		vec3(-430.015, 261.56, 83.2053), 	
		outVec = 		vec3(-458.531, 284.753, 78.7215), 	
		inHead = 		321.7075,	
		outHead = 		234.62, 
		markerType = 	27, 
		markerR = 		255, 
		markerG = 		216, 
		markerB = 		0, 
		markerA = 		100, 
		inText = 		"Enter Split Sides", 			
		outText = 		"Exit", 
		allowVehicle = 	false, 
		markerDir = 	vec3(0.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.5, 1.5, 1.5)
	}, 
	{	-- Document Office
		inVec = 		vec3(-1568.72, -3224.48, 26.34), 	
		outVec = 		vec3(1173.26, -3196.56, -39.7479), 	
		inHead = 		145.7075,	
		outHead = 		234.62, 
		markerType = 	27, 
		markerR = 		255, 
		markerG = 		216, 
		markerB = 		0, 
		markerA = 		100, 
		inText = 		"Authorized Personnel Only", 		
		outText = 		"Exit", 
		allowVehicle = 	false, 
		AlertPolice	 =  false,
		markerDir = 	vec3(0.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.5, 1.5, 1.5) 
	}, 
	{ 	-- Bus Bunker
		inVec = 		vec3(-488.91, 2234.02, 151.2), -- Going in vec3(x, y, z - 0.95)
		outVec = 		vec3(-484.74, 2232.64, 143), 	-- Going out vec3(x, y, z - 0.95)
		inHead = 		176.96, -- Heading on outside (leaving) 		
		outHead = 		186.91, 	-- Heading on inside (coming in)
		markerType = 	-1, -- Marker type 27 for visible marker (RGB to give it a color)
		markerR = 		128, 
		markerG = 		0, 
		markerB = 		128, 
		markerA = 		0, -- if visible this is 100
		inText = 		"Enter", -- can change
		outText = 		"Exit", -- can change
		allowVehicle = 	false, -- can change
		illegalSite = 	true,
		markerDir = 	vec3(0.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.0, 1.0, 1.0)
	},
	{ 	-- Casino Hotel Roof
		inVec = 		vec3(976.14, 27.72, 106.45), -- Going in vec3(x, y, z - 0.95)
		outVec = 		vec3(985.19, 73.16, 111.28), 	-- Going out vec3(x, y, z - 0.95)
		inHead = 		176.96, -- Heading on outside (leaving) 		
		outHead = 		186.91, 	-- Heading on inside (coming in)
		markerType = 	-1, -- Marker type 27 for visible marker (RGB to give it a color)
		markerR = 		128, 
		markerG = 		0, 
		markerB = 		128, 
		markerA = 		0, -- if visible this is 100
		inText = 		"Roof", -- can change
		outText = 		"Casino Service Area", -- can change
		allowVehicle = 	false, -- can change
		illegalSite = 	false,
		markerDir = 	vec3(0.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.0, 1.0, 1.0)
	},
	{ 	-- Casino Hotel
		inVec = 		vec3(976.39, 34.24, 70.96), -- Going in vec3(x, y, z - 0.95)
		outVec = 		vec3(971.65, 43.87, 91.44), 	-- Going out vec3(x, y, z - 0.95)
		inHead = 		176.96, -- Heading on outside (leaving) 		
		outHead = 		186.91, 	-- Heading on inside (coming in)
		markerType = 	-1, -- Marker type 27 for visible marker (RGB to give it a color)
		markerR = 		128, 
		markerG = 		0, 
		markerB = 		128, 
		markerA = 		0, -- if visible this is 100
		inText = 		"Casino Floor", -- can change
		outText = 		"Hotel Floor", -- can change
		allowVehicle = 	false, -- can change
		illegalSite = 	false,
		markerDir = 	vec3(0.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.0, 1.0, 1.0)
	},
	{	-- Movie Office
		inVec = 		vec3(-1007.85, -486.928, 40.1697), 
		outVec = 		vec3(-1002.7, -477.919, 50.2273), 	
		inHead = 		321.7075,	
		outHead = 		234.62, 
		markerType = 	-1, 
		markerR = 		255, 
		markerG = 		216, 
		markerB = 		0, 
		markerA = 		100, 
		inText = 		"Enter", 		
		outText = 		"Exit", 
		allowVehicle = 	false, 
		markerDir = 	vec3(0.0, 0.0, 0.0), 
		markerRot = 	vec3(0.0, 0.0, 0.0), 
		markerScale = 	vec3(1.5, 1.5, 1.5)
	},
}