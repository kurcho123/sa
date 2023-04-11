-- -- -- -- -- -- -- -- -- -- -- -- -- --
--          Ranching CONFIG            --
-- -- -- -- -- -- -- -- -- -- -- -- -- --
Config = Config or {}
Config.Ranching = {
    MaxCattle = 5, -- Max cattle per player
    UpdateTickTime = 2, -- Minutes that the script updates (Default 10 minutes)
    Costs = {
        Pig = 10,
        Cow = 10,
        Chicken = 10 
    },
    WaterConsumption = 0.11, -- Per update interval time this will be remove from water
    FoodConsumption = 0.09, -- Per update interval time this will be remove from food
    SpawnPoints = {
        Pig = {
            vector4(2242.43, 4875.93, 40.83, 307.45),
            vector4(2229.52, 4888.24, 40.6, 317.05),
            vector4(2225.78, 4891.63, 40.67, 317.93),
            vector4(2221.12, 4896.02, 40.69, 319.84),
            vector4(2209.56, 4907.33, 40.76, 313.06),
            vector4(2204.95, 4912.62, 40.62, 308.99)
        },

        Cow = {
            vector4(2222.06, 4935.63, 40.9, 139.63),
            vector4(2225.69, 4932.65, 40.81, 136.02),
            vector4(2231.25, 4928.48, 40.72, 126.44),
            vector4(2239.44, 4920.44, 40.7, 136.84),
            vector4(2242.73, 4917.41, 40.69, 135.7),
            vector4(2247.88, 4913.3, 40.72, 143.85),
            vector4(2255.53, 4904.46, 40.77, 132.09),
            vector4(2258.6, 4900.5, 40.8, 132.52),
            vector4(2262.21, 4895.76, 40.85, 123.9)
        },

        Chicken = {
            vector4(2259.22, 4832.45, 40.66, 135.07),
            vector4(2257.11, 4834.87, 40.66, 44.67),
            vector4(2252.18, 4835.53, 40.66, 96.54),
            vector4(2254.39, 4830.48, 40.66, 325.85),
            vector4(2247.33, 4837.88, 40.66, 322.16),
            vector4(2245.38, 4839.84, 40.66, 328.71),
            vector4(2247.0, 4842.54, 40.66, 150.47),
            vector4(2249.12, 4840.48, 40.66, 158.5),
            vector4(2243.32, 4848.5, 40.71, 115.91),
            vector4(2241.72, 4851.47, 40.77, 23.27),
            vector4(2238.26, 4847.35, 40.71, 269.53),
            vector4(2242.05, 4842.94, 40.66, 232.93)
        },
    },
    Animals = {
        Cow = {
            animal = 'Cow', --Used for script calls
            model = `a_c_cow`, --Prop model of the plant
            rewardItem = 'raw_beef', --Which item player gets when plant is harvested
            foodItem = 'cattle_feed', --Which item is needed to plant
            maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        },
        Chicken = {
            animal = 'Chicken', --Used for script calls
            model = `a_c_hen`, --Prop model of the plant
            rewardItem = 'raw_chicken', --Which item player gets when plant is harvested
            foodItem = 'cattle_feed', --Which item is needed to plant
            maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        },
        Pig = {
            animal = 'Pig', --Used for script calls
            model = `a_c_pig`, --Prop model of the plant
            rewardItem = 'raw_pork', --Which item player gets when plant is harvested
            foodItem = 'cattle_feed', --Which item is needed to plant
            maxRewardCount = 10, --Maximum product yield from plant (based on health and growth)
        },
    }
}