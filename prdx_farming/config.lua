Config = Config or {}
Config.CustomFont = true --DO NOT TOUCH! Currently keep this on if you are streaming font Fira Sans (in stream folder)
Config.ButtonInspectPlant = 'E' --DO NOT TOUCH! Currently used only for 3d text label

--Allows debug prints to F8 console
Config.Debug = false

--Are you using Onesync or not?
Config.Onesync = true

--How often are plants synced from server to client (in ms)
Config.ServerSyncTime = 5000

--FloatingHelp/3DText
Config.Display3DTextType = 'FloatingHelp'

--Distance to start drawing 3d text
Config.PlayerToPlantCloseDist = 3.0

--Distance to interact with closest plant (must be lower than PlayerToPlantCloseDist)
Config.PlayerToPlantInteractionDist = 1.7

--Language and localisations
Config.Language = 'en_GB'

--Set FontID that is shown when you start script with debug set to true
Config.TextFont = 13

--How much water is added to the plant when watering plant
Config.WaterIncrease = 1.0

--How much of fertilizer is added to the plant when fertilizing plant
Config.FertilizerIncrease = 0.85

--How much water is removed each tick
Config.WaterConsumption = 0.17 -- 0.23

--How much of fertilizer ir removed each tick
Config.FertilizerConsumption = 0.14 -- 0.12

--Server side tick of plant (how fast are plants growing) in minutes. Plant is fully grown in 10 ticks.
Config.UpdateTickTime = 2 -- 20 minutes 

Config.IllegalUpdateTickTime = 8 -- x Config.UpdateTickTime  x 10 = total time

--Client side distance to pool plants
Config.ChunkDist = 500.0

--Client side distance to render (spawn) plant objects
Config.PlantRenderDist = 350.0

--Minimum distance between each plant
Config.MinimumDistanceBetweenPlants = 2.0

--Maximum count of plants per each player
Config.MaxPlantedPlantsPerPlayer = 20

--Different soil changes water consumption and plant growth rate of the plant (http://www.kronzky.info/fivemwiki/index.php/Materials)
Config.Soil = {
    [2128369009] = 1.30,
    [-1286696947] = 1.30,
    [-461750719] = 1.35,
    [1333033863] = 1.35,
    [3008270349] = 1.35,
    [3594309083] = 1.35,
    [2461440131] = 1.35,
    [1144315879] = 1.40,
    [2409420175] = 1.45,
    [3833216577] = 1.45,
    [4170197704] = 1.45,
    [223086562] = 1.45,
    [581794674] = 1.45,
    [2352068586] = 1.50,
    [1109728704] = 1.50,
}

Config.Plants = {
    {
        type = 'weed_legion_diesel', --Used for script calls
        minZ = -5.25, --Lower plant default location by Z
        maxZ = -3.1, --Currently not in use
        name = 'Marijuana: Legion Diesel Strain', --UI text label
        model = 'bkr_prop_weed_lrg_01b', --Prop model of the plant
        saplingModel = 'bkr_prop_weed_lrg_01b', --Currently not in use
        rewardItem = 'weed_legion_diesel', --Which item player gets when plant is harvested
        seedItem = 'weed_legion_diesel_seed', --Which item is needed to plant
        maxRewardCount = 6, --Maximum product yield from plant (based on health and growth)
        plantanywhere = true -- Don't require to be in farming zones
    },
    {
        type = 'weed_sparkplug', --Used for script calls
        minZ = -5.25, --Lower plant default location by Z
        maxZ = -3.1, --Currently not in use
        name = 'Marijuana: Hawick Haze Strain', --UI text label
        model = 'bkr_prop_weed_lrg_01b', --Prop model of the plant
        saplingModel = 'bkr_prop_weed_lrg_01b', --Currently not in use
        rewardItem = 'weed_sparkplug', --Which item player gets when plant is harvested
        seedItem = 'weed_sparkplug_seed', --Which item is needed to plant
        maxRewardCount = 6, --Maximum product yield from plant (based on health and growth)
        plantanywhere = true -- Don't require to be in farming zones
    },
    {
        type = 'weed_vss', --Used for script calls
        minZ = -5.25, --Lower plant default location by Z
        maxZ = -3.1, --Currently not in use
        name = 'Marijuana: Rockford OG Strain', --UI text label
        model = 'bkr_prop_weed_lrg_01b', --Prop model of the plant
        saplingModel = 'bkr_prop_weed_lrg_01b', --Currently not in use
        rewardItem = 'weed_vss', --Which item player gets when plant is harvested
        seedItem = 'weed_vss_seed', --Which item is needed to plant
        maxRewardCount = 6, --Maximum product yield from plant (based on health and growth)
        plantanywhere = true -- Don't require to be in farming zones
    },
    {
        type = 'weed_seebeedeebees', --Used for script calls
        minZ = -5.25, --Lower plant default location by Z
        maxZ = -3.1, --Currently not in use
        name = 'Marijuana: Seebeedeebees Strain', --UI text label
        model = 'bkr_prop_weed_lrg_01b', --Prop model of the plant
        saplingModel = 'bkr_prop_weed_lrg_01b', --Currently not in use
        rewardItem = 'weed_seebeedeebees', --Which item player gets when plant is harvested
        seedItem = 'weed_seebeedeebees_seed', --Which item is needed to plant
        maxRewardCount = 6, --Maximum product yield from plant (based on health and growth)
        plantanywhere = true -- Don't require to be in farming zones
    },
    {
        type = 'wet_weed', --Used for script calls
        minZ = -5.25, --Lower plant default location by Z
        maxZ = -3.1, --Currently not in use
        name = 'Marijuana: Unknown Strain', --UI text label
        model = 'bkr_prop_weed_lrg_01b', --Prop model of the plant
        saplingModel = 'bkr_prop_weed_lrg_01b', --Currently not in use
        rewardItem = 'wet_weed', --Which item player gets when plant is harvested
        seedItem = 'weed_seed', --Which item is needed to plant
        maxRewardCount = 1, --Maximum product yield from plant (based on health and growth)
        plantanywhere = true, -- Don't require to be in farming zones
        illegal = true, -- Drugszzzz
    },
    {
        type = 'coke_leaves', --Used for script calls
        minZ = -1.20, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Coca Plant', --UI text label
        model = 'h4_prop_bush_cocaplant_01', --Prop model of the plant
        saplingModel = 'h4_prop_bush_cocaplant_01', --Currently not in use
        rewardItem = 'coke_leaves', --Which item player gets when plant is harvested
        seedItem = 'coke_seed', --Which item is needed to plant
        maxRewardCount = 1, --Maximum product yield from plant (based on health and growth)
        plantanywhere = true, -- Don't require to be in farming zones
        illegal = true, -- Drugszzzz
    },
    -- {
    --     type = 'weed_purple_haze', --Used for script calls
    --     minZ = -5.25, --Lower plant default location by Z
    --     maxZ = -3.1, --Currently not in use
    --     name = 'Marijuana: Purple Haze', --UI text label
    --     model = 'bkr_prop_weed_lrg_01b', --Prop model of the plant
    --     saplingModel = 'bkr_prop_weed_lrg_01b', --Currently not in use
    --     rewardItem = 'weed_purple_haze', --Which item player gets when plant is harvested
    --     seedItem = 'weed_purple_haze_seed', --Which item is needed to plant
    --     maxRewardCount = 6, --Maximum product yield from plant (based on health and growth)
    --     plantanywhere = true -- Don't require to be in farming zones
    -- },
    -- {
    --     type = 'weed_og_kush', --Used for script calls
    --     minZ = -5.25, --Lower plant default location by Z
    --     maxZ = -3.1, --Currently not in use
    --     name = 'Marijuana: OG Kush', --UI text label
    --     model = 'bkr_prop_weed_lrg_01b', --Prop model of the plant
    --     saplingModel = 'bkr_prop_weed_lrg_01b', --Currently not in use
    --     rewardItem = 'weed_og_kush', --Which item player gets when plant is harvested
    --     seedItem = 'weed_og_kush_seed', --Which item is needed to plant
    --     maxRewardCount = 6, --Maximum product yield from plant (based on health and growth)
    --     plantanywhere = true -- Don't require to be in farming zones
    -- },
    -- Farming
    {
        type = 'wheat', --Used for script calls
        minZ = -0.65, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Wheat', --UI text label
        model = 'prop_bzzz_gardenpack_barley001', --Prop model of the plant
        saplingModel = 'prop_bzzz_gardenpack_barley001', --Currently not in use
        rewardItem = 'raw_grains', --Which item player gets when plant is harvested
        seedItem = 'wheat_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'corn', --Used for script calls
        minZ = -1.8, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Corn', --UI text label
        model = 'prop_bzzz_gardenpack_cornstalk001', --Prop model of the plant
        saplingModel = 'prop_bzzz_gardenpack_cornstalk001', --Currently not in use
        rewardItem = 'raw_corn', --Which item player gets when plant is harvested
        seedItem = 'corn_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'sugar_cane', --Used for script calls
        minZ = -1.8, --Lower plant default location by Z
        maxZ = -0.15, --Currently not in use
        name = 'Sugar Cane', --UI text label
        model = 'prop_plant_01a', --Prop model of the plant
        saplingModel = 'prop_plant_01a', --Currently not in use
        rewardItem = 'raw_sugar_cane', --Which item player gets when plant is harvested
        seedItem = 'sugar_cane_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'spices', --Used for script calls
        minZ = -1.0, --Lower plant default location by Z
        maxZ = -0.5, --Currently not in use
        name = 'Spices', --UI text label
        model = 'prop_veg_crop_04_leaf', --Prop model of the plant
        saplingModel = 'prop_veg_crop_04_leaf', --Currently not in use
        rewardItem = 'spices', --Which item player gets when plant is harvested
        seedItem = 'spices_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'onion', --Used for script calls
        minZ = -1.65, --Lower plant default location by Z
        maxZ = -1.5, --Currently not in use
        name = 'Onion', --UI text label
        model = 'prop_fbibombplant', --Prop model of the plant
        saplingModel = 'prop_fbibombplant', --Currently not in use
        rewardItem = 'onion', --Which item player gets when plant is harvested
        seedItem = 'onion_seed', --Which item is needed to plant
        maxRewardCount = 3, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'lettuce', --Used for script calls
        minZ = -0.225, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Lettuce', --UI text label
        model = 'prop_veg_crop_03_cab', --Prop model of the plant
        saplingModel = 'prop_veg_crop_03_cab', --Currently not in use
        rewardItem = 'lettuce', --Which item player gets when plant is harvested
        seedItem = 'lettuce_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'garlic', --Used for script calls
        minZ = -1.55, --Lower plant default location by Z
        maxZ = -1.2, --Currently not in use
        name = 'Garlic', --UI text label
        model = 'vw_prop_casino_art_plant_02a', --Prop model of the plant
        saplingModel = 'vw_prop_casino_art_plant_02a', --Currently not in use
        rewardItem = 'garlic', --Which item player gets when plant is harvested
        seedItem = 'garlic_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'tomato', --Used for script calls
        minZ = -1.75, --Lower plant default location by Z
        maxZ = -1.0, --Currently not in use
        name = 'Tomato', --UI text label
        model = 'prop_pot_plant_05b', --Prop model of the plant
        saplingModel = 'prop_pot_plant_05b', --Currently not in use
        rewardItem = 'tomato', --Which item player gets when plant is harvested
        seedItem = 'tomato_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'carrot', --Used for script calls
        minZ = -1.8, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Carrot', --UI text label
        model = 'prop_bzzz_gardenpack_cornstalk001', --Prop model of the plant
        saplingModel = 'prop_bzzz_gardenpack_cornstalk001', --Currently not in use
        rewardItem = 'carrot', --Which item player gets when plant is harvested
        seedItem = 'carrot_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'hops', --Used for script calls
        minZ = -1.8, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Hops', --UI text label
        model = 'prop_bzzz_gardenpack_hops001', --Prop model of the plant
        saplingModel = 'prop_bzzz_gardenpack_hops001', --Currently not in use
        rewardItem = 'hops', --Which item player gets when plant is harvested
        seedItem = 'hops_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'potato', --Used for script calls
        minZ = -1.8, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Potato', --UI text label
        model = 'prop_bzzz_gardenpack_cornstalk001', --Prop model of the plant
        saplingModel = 'prop_bzzz_gardenpack_cornstalk001', --Currently not in use
        rewardItem = 'potato', --Which item player gets when plant is harvested
        seedItem = 'potato_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
    {
        type = 'rubber', --Used for script calls
        minZ = -0.50, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Rubber Tree', --UI text label
        model = 'prop_tree_birch_03', --Prop model of the plant
        saplingModel = 'prop_tree_birch_03', --Currently not in use
        rewardItem = 'rubber', --Which item player gets when plant is harvested
        seedItem = 'rubber_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = true -- Don't require to be in farming zones
    },
    {
        type = 'poppy', --Used for script calls
        minZ = -0.50, --Lower plant default location by Z
        maxZ = -0.05, --Currently not in use
        name = 'Poppy Plant', --UI text label
        model = 'prop_bzzz_gardenpack_poppy001', --Prop model of the plant
        saplingModel = 'prop_bzzz_gardenpack_poppy001', --Currently not in use
        rewardItem = 'poppy', --Which item player gets when plant is harvested
        seedItem = 'poppyseed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = true -- Don't require to be in farming zones
    },
    {
        type = 'raw_tobacco', --Used for script calls
        minZ = -0.10, --Lower plant default location by Z
        maxZ = -0.08, --Currently not in use
        name = 'Tobacco Plant', --UI text label
        model = 'prop_bzzz_gardenpack_tabacco001', --Prop model of the plant
        saplingModel = 'prop_bzzz_gardenpack_tabacco001', --Currently not in use
        rewardItem = 'raw_tobacco', --Which item player gets when plant is harvested
        seedItem = 'tobacco_seed', --Which item is needed to plant
        maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        plantanywhere = false -- Don't require to be in farming zones
    },
}

--Localization
Lang = {
    ['en_GB'] = {
        Debug = {
            playerCloseToPlant = 'Player is close to plant.',
            playerFarFromPlant = 'Player is too far away from plant. (%s meters away).',
        },
        UI = {
            examinePlant = 'Press ~y~[%s]~w~ to examine the plant.',
            closeToPlant = 'There is some kind of plant',
            itLooksLike = 'It looks like %s',
            waterPlant = 'Water plant',
            fertilizePlant = 'Fertilize plant',
            harvest = 'Harvest plant',
            confirm = 'Confirm',
            harvestTooltip = 'Plant is %s %s grown.\nYou will get fewer products if the plant is not fully grown.',
            confirmNo = '~g~~h~No, let the plant grow!',
            confirmYes = '~r~~h~Yes, harvest plant anyway!',
            wateringLabel = 'Watering',
            wateringDesc = 'Plant needs water to stay healty. If water level is too low plant health level will decrease.',
            fertilizingLabel = 'Fertilizing',
            fertilizingDesc = 'Fertilizing plant increases its quality and yields more product when harvested.',
            health = 'Plant health',
            healthDesc = 'If plant health is too low it is destroyed.',
            soilQuality = 'Soil quality',
            soilQualityDesc = 'Soil quality increases growth rate and plant water consumption.',
            menuHeader = 'Plant Info'
        },
        Notification = {
            tooCloseToOtherPlant = 'You cannot plant this seed because it is too close to another plant.',
            notSuitableSoil = 'You cannot plant this seed on this soil. It won`t grow here.',
            tooSteepTerrain = 'Terrain is too steep for planting.',
            plantingObstructed = 'Planting location is obstructed.',
            planting_too_far = 'Planting location is too far away from you.',
            planting_in_vehicle = 'You cannot plant seeds from a vehicle.',
            not_inside_farm = 'You must plant this seed on a farm',
            maximumPlantCountReached = 'You have reached maximum count of planted plants.',
            noLicenseFound = 'Could not find your rockstar identifier.'
        }
    },
}
