Config = {}

Config.ShowTargetZones = false

Config.Jobs = {
    ["electrician"] = "Electrician"
}

Config.Locations = {
    -- jobs = {
    --     ["electrician"] = {
    --         [1] = {
    --             coords = vector4(1761.46, 2540.41, 45.56, 272.249)
    --         },
    --         [2] = {
    --             coords = vector4(1718.54, 2527.802, 45.56, 272.249)
    --         },
    --         [3] = {
    --             coords = vector4(1700.199, 2474.811, 45.56, 272.249)
    --         },
    --         [4] = {
    --             coords = vector4(1664.827, 2501.58, 45.56, 272.249)
    --         },
    --         [5] = {
    --             coords = vector4(1621.622, 2509.302, 45.56, 272.249)
    --         },
    --         [6] = {
    --             coords = vector4(1627.936, 2538.393, 45.56, 272.249)
    --         },
    --         [7] = {
    --             coords = vector4(1625.1, 2575.988, 45.56, 272.249)
    --         }
    --     }
    -- },
    ["freedom"] = {
        coords = vector4(1828.77, 2580.11, 46.01, 180.55)
    },
    ["outside"] = {
        coords = vector4(1848.13, 2586.05, 45.67, 269.5)
    },
    ["yard"] = {
        coords = vector4(1758.82, 2493.74, 45.74, 206.88)
    },
    ["middle"] = {
        coords = vector4(1693.33, 2569.51, 45.55, 123.5)
    },
    ["shop"] = {
        coords = vector4(1779.42, 2558.98, 45.67, 357.1)
    },
    spawns = {
        [1] = {
            animation = "bumsleep",
            coords = vector4(1661.046, 2524.681, 45.564, 260.545)
        },
        [2] = {
            animation = "lean",
            coords = vector4(1650.812, 2540.582, 45.564, 230.436)
        },
        [3] = {
            animation = "lean",
            coords = vector4(1654.959, 2545.535, 45.564, 230.436)
        },
        [4] = {
            animation = "lean",
            coords = vector4(1697.106, 2525.558, 45.564, 187.208)
        },
        [5] = {
            animation = "sitchair4",
            coords = vector4(1673.084, 2519.823, 45.564, 229.542)
        },
        [6] = {
            animation = "sitchair",
            coords = vector4(1666.029, 2511.367, 45.564, 233.888)
        },
        [7] = {
            animation = "sitchair4",
            coords = vector4(1691.229, 2509.635, 45.564, 52.432)
        },
        [8] = {
            animation = "finger2",
            coords = vector4(1770.59, 2536.064, 45.564, 258.113)
        },
        [9] = {
            animation = "smoke",
            coords = vector4(1792.45, 2584.37, 45.56, 276.24)
        },
        [10] = {
            animation = "smoke",
            coords = vector4(1768.33, 2566.08, 45.56, 176.83)
        },
        [11] = {
            animation = "smoke",
            coords = vector4(1696.09, 2469.4, 45.56, 1.4)
        }
    }
}

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 4,
        amount = 50,
    },
    [2] = {
        name = "water_bottle",
        price = 4,
        amount = 50,
    },
    [3] = {
        name = "slushy",
        price = 15,
        amount  = 999999,
    },
}

---- New Job Stuff ----

-- Enable Job System
Config.DynamicJobsEnabled = true -- Set true to enable jobs

-- Job Types + Settings
Config.PrisonJobTypes = {
    ["canteen"] = --[38 Tasks] -- Average time 6-8 mins
    {   
        -- Locations for tasks
        sites = {
            {  action = "clean",       label = "Clean Table",  markerOffset = 1.25, fastTime = 9000,  slowTime = 14000, location = vector3(1787.12, 2554.52, 45.17), minZ = 45.17, maxZ = 45.67, heading = 270.40, length = 2.7, width = 1.4 },
            {  action = "clean",       label = "Clean Table",  markerOffset = 1.25, fastTime = 9000,  slowTime = 14000, location = vector3(1787.12, 2550.83, 45.17), minZ = 45.17, maxZ = 45.67, heading = 270.40, length = 2.7, width = 1.4 },
            {  action = "clean",       label = "Clean Table",  markerOffset = 1.25, fastTime = 9000,  slowTime = 14000, location = vector3(1787.12, 2547.27, 45.17), minZ = 45.17, maxZ = 45.67, heading = 270.40, length = 2.7, width = 1.4 },
            {  action = "clean",       label = "Clean Table",  markerOffset = 1.25, fastTime = 9000,  slowTime = 14000, location = vector3(1781.28, 2554.52, 45.17), minZ = 45.17, maxZ = 45.67, heading = 270.40, length = 2.7, width = 1.4 },
            {  action = "clean",       label = "Clean Table",  markerOffset = 1.25, fastTime = 9000,  slowTime = 14000, location = vector3(1781.28, 2550.83, 45.17), minZ = 45.17, maxZ = 45.67, heading = 270.40, length = 2.7, width = 1.4 },
            {  action = "clean",       label = "Clean Table",  markerOffset = 1.25, fastTime = 9000,  slowTime = 14000, location = vector3(1781.28, 2547.27, 45.17), minZ = 45.17, maxZ = 45.67, heading = 270.40, length = 2.7, width = 1.4 },
            {  action = "clean2",      label = "Clean Glass",  markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1779.61, 2560.00, 45.67), minZ = 45.60, maxZ = 46.20, heading = 270.40, length = 1.3, width = 0.5 },
            {  action = "clean2",      label = "Clean Glass",  markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1781.01, 2560.00, 45.67), minZ = 45.60, maxZ = 46.20, heading = 270.40, length = 1.5, width = 0.5 },
            {  action = "clean2",      label = "Clean Glass",  markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1782.31, 2560.00, 45.67), minZ = 45.60, maxZ = 46.20, heading = 270.40, length = 1.2, width = 0.5 },
            {  action = "clean2",      label = "Scrub Hob",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1780.89, 2565.01, 46.00), minZ = 45.20, maxZ = 46.00, heading = 270.40, length = 1.3, width = 0.9 },
            {  action = "clean",       label = "Clean Counter",markerOffset = 0.40, fastTime = 9000,  slowTime = 14000, location = vector3(1776.78, 2563.75, 45.67), minZ = 45.20, maxZ = 46.00, heading = 270.40, length = 1.2, width = 1.7 },
            {  action = "bumbin",      label = "Empty Trash",  markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1784.19, 2560.74, 44.67), minZ = 44.20, maxZ = 45.60, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "bumbin",      label = "Empty Trash",  markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1776.83, 2560.91, 44.67), minZ = 44.20, maxZ = 45.90, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic4",   label = "Fix Sink",     markerOffset = 1.25, fastTime = 10000, slowTime = 18000, location = vector3(1778.99, 2565.04, 44.85), minZ = 44.20, maxZ = 45.90, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic4",   label = "Fix Sink",     markerOffset = 1.25, fastTime = 10000, slowTime = 16000, location = vector3(1778.17, 2565.07, 44.85), minZ = 44.20, maxZ = 45.90, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic5",   label = "Fix Light",    markerOffset = 1.25, fastTime = 10000, slowTime = 16000, location = vector3(1776.46, 2558.77, 46.50), minZ = 46.60, maxZ = 47.40, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic5",   label = "Fix Light",    markerOffset = 1.25, fastTime = 10000, slowTime = 16000, location = vector3(1776.47, 2550.49, 46.50), minZ = 46.60, maxZ = 47.40, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic5",   label = "Fix Light",    markerOffset = 1.25, fastTime = 10000, slowTime = 17000, location = vector3(1780.68, 2545.33, 46.50), minZ = 46.60, maxZ = 47.40, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic5",   label = "Fix Light",    markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1787.71, 2545.19, 46.50), minZ = 46.60, maxZ = 47.40, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic5",   label = "Fix Light",    markerOffset = 1.25, fastTime = 10000, slowTime = 18000, location = vector3(1787.71, 2545.19, 46.50), minZ = 46.60, maxZ = 47.40, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic5",   label = "Fix Light",    markerOffset = 1.25, fastTime = 10000, slowTime = 16000, location = vector3(1791.23, 2550.36, 46.50), minZ = 46.60, maxZ = 47.40, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mechanic5",   label = "Fix Light",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1789.86, 2558.44, 46.50), minZ = 46.60, maxZ = 47.40, heading = 180.00, length = 1.0, width = 1.0 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 14000, location = vector3(1777.73, 2547.30, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 17000, location = vector3(1778.46, 2550.66, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 16000, location = vector3(1778.42, 2555.69, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 18000, location = vector3(1779.96, 2558.75, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1784.18, 2556.85, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 17000, location = vector3(1782.14, 2552.80, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1786.04, 2552.58, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1786.09, 2558.41, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1785.63, 2563.51, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 16000, location = vector3(1778.82, 2563.30, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1788.90, 2556.24, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 18000, location = vector3(1789.72, 2553.24, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1789.79, 2547.32, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 16000, location = vector3(1786.85, 2549.28, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 17000, location = vector3(1784.14, 2547.44, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
            {  action = "mop2",        label = "Mop Floor",    markerOffset = 1.25, fastTime = 10000, slowTime = 19000, location = vector3(1782.15, 2562.29, 44.67), minZ = 44.20, maxZ = 45.00, heading = 180.00, length = 2.5, width = 2.5 },
        },
        -- Starting Spot for jobs
        supplyzone = {zonename = "canteen", location = vector3(1778.25, 2545.54, 45.67), label = "Canteen Job", minZ = 44.67, maxZ = 46.07, heading = 270.40, length = 1.1, width = 0.8},
        -- Job Settings
        jobconfig = {taskcount = 15, minTimeReduction = 2, maxTimeReduction = 5, jobCooldown = 600000},
        -- Rewards probabilities
        rewardTable = 
        {
            ['prison_plastic'] = 50,
            ['prison_kitchenoil'] = 20,
            ['prison_varnish'] = 15,
            ['prison_metal_wire'] = 25,
            ['prison_broken_circuit'] = 20,
            ['prison_broken_tablet'] = 3,
        }
    },
    ["bunks"] = --[79 Tasks] -- Average time 9-10 mins
    {   
        -- Locations for tasks
        sites = {
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1778.39, 2484.08, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1775.41, 2482.36, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1771.97, 2480.29, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1768.71, 2478.69, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1765.82, 2476.76, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1762.82, 2474.76, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1759.34, 2473.21, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1778.39, 2484.08, 49.74), minZ = 49.17, maxZ = 49.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1775.41, 2482.36, 49.74), minZ = 49.17, maxZ = 49.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1771.97, 2480.29, 49.74), minZ = 49.17, maxZ = 49.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1768.71, 2478.69, 49.74), minZ = 49.17, maxZ = 49.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1765.82, 2476.76, 49.74), minZ = 49.17, maxZ = 49.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1762.82, 2474.76, 49.74), minZ = 49.17, maxZ = 49.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1759.34, 2473.21, 49.74), minZ = 49.17, maxZ = 49.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1747.34, 2489.39, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1750.62, 2491.20, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1753.52, 2493.03, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1760.04, 2496.70, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1763.22, 2498.34, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1766.34, 2500.13, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1747.34, 2489.39, 45.74), minZ = 45.17, maxZ = 46.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1747.34, 2489.39, 49.74), minZ = 49.17, maxZ = 50.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1750.62, 2491.20, 49.74), minZ = 49.17, maxZ = 50.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1753.52, 2493.03, 49.74), minZ = 49.17, maxZ = 50.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1760.04, 2496.70, 49.74), minZ = 49.17, maxZ = 50.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1763.22, 2498.34, 49.74), minZ = 49.17, maxZ = 50.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1766.34, 2500.13, 49.74), minZ = 49.17, maxZ = 50.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1747.34, 2489.39, 49.74), minZ = 49.17, maxZ = 50.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "bumbin",     label = "Clean Bunk",    markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1756.79, 2494.90, 49.69), minZ = 49.17, maxZ = 50.67, heading = 30.50,  length = 2.7, width = 1.2 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1773.29, 2488.12, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1773.42, 2491.40, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1769.54, 2492.41, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1769.24, 2495.56, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1763.46, 2491.06, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1767.17, 2486.04, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1761.22, 2485.33, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1761.23, 2481.31, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1765.82, 2488.67, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1756.59, 2485.91, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1751.72, 2486.24, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1758.23, 2477.82, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1756.46, 2480.46, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1753.02, 2483.04, 44.90), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1775.44, 2489.87, 49.67), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1776.07, 2487.15, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1772.06, 2484.79, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1765.79, 2481.18, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1760.65, 2478.96, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1754.91, 2476.55, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1752.29, 2481.40, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1749.78, 2485.97, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1752.86, 2488.08, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1756.96, 2490.36, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1760.28, 2490.92, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1763.35, 2494.13, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1769.56, 2497.77, 49.69), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1773.10, 2492.78, 49.67), minZ = 48.60, maxZ = 49.25, heading = 209.99, length = 2.0, width = 2.0 },
            {  action = "twerk",      label = "Turn On",       markerOffset = 0.25, fastTime = 15000, slowTime = 20000, location = vector3(1754.09, 2474.08, 46.94), minZ = 43.60, maxZ = 46.65, heading = 245.92, length = 1.5, width = 1.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1751.32, 2477.51, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 1.5, width = 1.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1748.54, 2476.77, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 1.5, width = 1.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1750.52, 2474.05, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 1.5, width = 1.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1746.86, 2472.76, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 1.5, width = 1.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1748.72, 2471.21, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 1.5, width = 1.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1746.53, 2475.60, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 1.5, width = 1.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1751.32, 2477.51, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1748.54, 2476.77, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1750.52, 2474.05, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1746.86, 2472.76, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1748.72, 2471.21, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1746.53, 2475.60, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1748.43, 2481.75, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1745.79, 2483.22, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1745.75, 2479.85, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mop2",       label = "Mop Floor",     markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1742.83, 2481.63, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1748.43, 2481.75, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1745.79, 2483.22, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1745.75, 2479.85, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "broom",      label = "Sweep Floor",   markerOffset = 0.25, fastTime = 10000, slowTime = 15000, location = vector3(1742.83, 2481.63, 44.74), minZ = 44.24, maxZ = 45.24, heading = 30.50,  length = 2.5, width = 2.5 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1767.80, 2502.88, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1764.66, 2501.06, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1761.52, 2499.22, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1755.21, 2495.62, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1752.12, 2493.67, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1748.91, 2491.90, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1758.08, 2470.56, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1761.17, 2472.43, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1764.32, 2474.12, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1767.43, 2476.13, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1770.59, 2477.88, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1773.76, 2479.64, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1776.90, 2481.48, 45.06), minZ = 44.67, maxZ = 46.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1767.86, 2502.77, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1764.71, 2501.06, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1761.54, 2499.19, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1758.46, 2497.34, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1755.26, 2495.61, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1752.12, 2493.76, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1748.99, 2491.88, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1757.98, 2470.63, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1761.15, 2472.43, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1764.28, 2474.21, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1767.45, 2475.99, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1770.58, 2477.85, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },          
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1773.77, 2479.62, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },          
            {  action = "mechanic4",  label = "Clean Toilet",  markerOffset = 1.25, fastTime = 10000, slowTime = 15000, location = vector3(1776.88, 2481.47, 49.11), minZ = 48.67, maxZ = 50.17, heading = 30.50,  length = 1.0, width = 1.0 },                                
        },  
        -- Starting Spot for jobs    
        supplyzone = {zonename = "bunks", location = vector3(1759.13, 2484.31, 45.74), label = "Cell Block Job", minZ = 44.67, maxZ = 46.07, heading = 270.40, length = 1.1, width = 0.8},
        -- Job Settings
        jobconfig = {taskcount = 20, minTimeReduction = 2, maxTimeReduction = 5, jobCooldown = 600000}, 
        -- Rewards probabilities
        rewardTable = 
        {
            ['prison_plastic'] = 50,
            ['prison_fabric'] = 25,
            ['prison_laces'] = 20,
            ['prison_elec_wires'] = 10,
            ['prison_elec_comps'] = 10,
            ['prison_broken_boombox'] = 2,
        },
    },    
    ["yardwork"] = --[66 tasks] -- Average time 10-13 minutes
    {   
        -- Locations for tasks
        sites = {
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1664.79, 2548.57, 44.55), minZ = 44.56, maxZ = 45.56, heading = 45.12,  length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1662.03, 2551.42, 44.55), minZ = 44.56, maxZ = 45.56, heading = 45.12,  length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1658.97, 2553.78, 44.55), minZ = 44.56, maxZ = 45.56, heading = 45.12,  length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1667.62, 2551.52, 44.55), minZ = 44.56, maxZ = 45.56, heading = 45.12,  length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1667.62, 2551.52, 44.55), minZ = 44.56, maxZ = 45.56, heading = 45.12,  length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1670.61, 2554.07, 44.55), minZ = 44.56, maxZ = 45.56, heading = 45.12,  length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1628.64, 2546.51, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1630.92, 2549.34, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1633.25, 2551.77, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1632.47, 2546.25, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1634.77, 2548.96, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 0.75, width = 1.6 },
            {  action = "clean",       label = "Clean Bench",   fastTime = 9000,  slowTime = 14000,  markerOffset = 0.75, location = vector3(1637.26, 2551.51, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 0.75, width = 1.6 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1695.24, 2536.03, 44.55), minZ = 44.67, maxZ = 46.67, heading = 87.31,  length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1761.22, 2519.03, 44.55), minZ = 44.67, maxZ = 46.87, heading = 254.40, length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1737.17, 2503.96, 44.55), minZ = 44.67, maxZ = 46.87, heading = 164.81, length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1707.42, 2480.51, 44.55), minZ = 44.67, maxZ = 46.87, heading = 224.70, length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1700.51, 2474.27, 44.55), minZ = 44.67, maxZ = 46.87, heading = 224.70, length = 1.0,  width = 3.7 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1679.13, 2479.71, 44.55), minZ = 44.67, maxZ = 46.87, heading = 134.78, length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1644.02, 2490.29, 44.55), minZ = 44.67, maxZ = 46.87, heading = 184.46, length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1621.95, 2507.63, 44.55), minZ = 44.67, maxZ = 46.87, heading = 94.98,  length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1609.40, 2539.28, 44.55), minZ = 44.67, maxZ = 46.87, heading = 134.96, length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1608.48, 2567.26, 44.55), minZ = 44.67, maxZ = 46.87, heading = 45.00,  length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1624.98, 2577.47, 44.55), minZ = 44.67, maxZ = 46.87, heading = 269.72, length = 1.0,  width = 2.5 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1629.81, 2565.04, 44.55), minZ = 44.67, maxZ = 46.87, heading = 359.68, length = 1.0,  width = 3.7 },
            {  action = "mechanic2",   label = "Fix Electrics", fastTime = 12000, slowTime = 17000,  markerOffset = 2.5,  location = vector3(1652.46, 2565.12, 44.55), minZ = 44.67, maxZ = 46.87, heading = 359.68, length = 1.0,  width = 3.7 },            
            {  action = "mechanic5",   label = "Fix AC Unit",   fastTime = 12000, slowTime = 17000,  markerOffset = 0.75, location = vector3(1757.07, 2569.30, 44.55), minZ = 46.25, maxZ = 48.05, heading = 360.01, length = 0.75, width = 1.5 },
            {  action = "rake",        label = "Rake Leaves",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1701.49, 2485.93, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "rake",        label = "Rake Leaves",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1704.42, 2500.71, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "rake",        label = "Rake Leaves",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1702.31, 2520.31, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "rake",        label = "Rake Leaves",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1705.23, 2548.43, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "rake",        label = "Rake Leaves",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1672.34, 2526.94, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "rake",        label = "Rake Leaves",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1633.95, 2508.83, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1665.09, 2551.30, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1761.36, 2559.47, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1651.86, 2513.07, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1661.63, 2511.09, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1654.49, 2501.88, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1688.01, 2492.88, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1714.90, 2508.09, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1654.49, 2501.88, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1736.53, 2518.77, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1757.69, 2532.34, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "leafblower",  label = "Clear Leaves",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1737.29, 2557.52, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "broom",       label = "Sweep Trash",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1719.02, 2556.34, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "broom",       label = "Sweep Trash",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1713.62, 2519.20, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "broom",       label = "Sweep Trash",   fastTime = 11000, slowTime = 16000,  markerOffset = 0.75, location = vector3(1719.02, 2556.34, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 3.0,  width = 3.0 },
            {  action = "broom",       label = "Sweep Trash",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1677.90, 2506.39, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 5.0,  width = 5.0 },
            {  action = "broom",       label = "Sweep Trash",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1690.41, 2517.35, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 5.0,  width = 5.0 },
            {  action = "broom",       label = "Sweep Trash",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1683.50, 2525.56, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 5.0,  width = 5.0 },
            {  action = "broom",       label = "Sweep Trash",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1680.30, 2517.63, 44.55), minZ = 44.56, maxZ = 45.56, heading = 225.50, length = 5.0,  width = 5.0 },
            {  action = "garden",      label = "Tend Garden",   fastTime = 12000, slowTime = 17000,  markerOffset = 1.25, location = vector3(1772.02, 2548.47, 44.55), minZ = 44.25, maxZ = 46.56, heading = 225.50, length = 2.5,  width = 2.5 },
            {  action = "garden",      label = "Tend Garden",   fastTime = 12000, slowTime = 17000,  markerOffset = 1.25, location = vector3(1771.88, 2542.59, 44.55), minZ = 44.55, maxZ = 46.56, heading = 225.50, length = 2.5,  width = 2.5 },
            --{  action = "dig",         label = "Dig Weeds",     fastTime = 12000, slowTime = 17000,  markerOffset = 0.75, location = vector3(1758.37, 2509.95,45.07), minZ = 44.55, maxZ = 46.56, heading = 225.50, length = 2.5,  width = 2.5 },
            --{  action = "dig",         label = "Dig Weeds",     fastTime = 12000, slowTime = 17000,  markerOffset = 0.75, location = vector3(1757.66, 2506.05,45.07), minZ = 44.55, maxZ = 46.56, heading = 225.50, length = 2.5,  width = 2.5 },
            --{  action = "garden",      label = "Dig Weeds",     fastTime = 12000, slowTime = 17000,  markerOffset = 0.75, location = vector3(1757.78, 2507.99,45.07), minZ = 44.55, maxZ = 46.56, heading = 225.50, length = 2.5,  width = 2.5 },
            --{  action = "watering",    label = "Water Plants",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1757.66, 2506.05,45.07), minZ = 44.55, maxZ = 46.56, heading = 225.50, length = 2.5,  width = 2.5 },
            {  action = "watering",    label = "Water Plants",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1772.51, 2556.30, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },
            {  action = "dig",         label = "Dig Weeds",     fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1772.51, 2556.30, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },
            {  action = "garden",      label = "Tend Garden",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1772.51, 2556.30, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },
            {  action = "watering",    label = "Water Plants",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1772.06, 2559.76, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },
            {  action = "dig",         label = "Dig Weeds",     fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1772.06, 2559.76, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },
            {  action = "garden",      label = "Tend Garden",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1772.06, 2559.76, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },
            {  action = "watering",    label = "Water Plants",  fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1771.07, 2563.53, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },
            {  action = "dig",         label = "Dig Weeds",     fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1771.07, 2563.53, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },
            {  action = "garden",      label = "Tend Garden",   fastTime = 10000, slowTime = 15000,  markerOffset = 0.75, location = vector3(1771.07, 2563.53, 44.55), minZ = 44.55, maxZ = 46.56, heading = 270.26, length = 2.5,  width = 2.5 },

        },       
        -- Starting Spot for jobs 
        supplyzone = {zonename = "yardwork", location = vector3(1688.45, 2552.32, 45.56), label = "Yard Job", minZ = 44.56, maxZ = 46.56, heading = 90.23, length = 4.0, width = 4.0,},
        -- Job Settings
        jobconfig = {taskcount = 20, minTimeReduction = 2, maxTimeReduction = 5, jobCooldown = 600000},        
        -- Rewards probabilities
        rewardTable = 
        {
            ['prison_plastic'] = 45,
            ['prison_varnish'] = 30,
            ['prison_broken_circuit'] = 15,
            ['prison_elec_comps'] = 10,
            ['prison_elec_wires'] = 10,   
            ['prison_broken_phone'] = 1,    
        },
    },
}
-- Items craftable in prison
Config.PrisonCraftingItems = {
    -- Craftables
    [1] = {
        name = "prison_plate",
        amount = 50,
        info = {},
        costs = {
            ["prison_plastic"] = 5,
            ["prison_varnish"] = 1,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        perCraft = 1,
        points = 1,
    },
    [2] = {
        name = "prison_uniform",
        amount = 50,
        info = {},
        costs = {
            ["prison_fabric"] = 5,
            ["prison_thread"] = 3,
            ["prison_sewing_needle"] = 1,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        perCraft = 1,
        points = 1,
    },
    [3] = {
        name = "prison_lingerie",
        amount = 50,
        info = {},
        costs = {
            ["prison_fabric"] = 3,
            ["prison_laces"] = 3,
            ["prison_sewing_needle"] = 1,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        perCraft = 1,
        points = 1,
    },
    [4] = {
        name = "prison_circuit_board",
        amount = 50,
        info = {},
        costs = {
            ["prison_broken_circuit"] = 1,
            ["prison_elec_comps"] = 2,
            ["prison_plastic"] = 3,
            ["prison_kitchenoil"] = 1,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        perCraft = 1,
        points = 1,
    },
    [5] = {
        name = "prison_boombox",
        amount = 50,
        info = {},
        costs = {
            ["prison_broken_boombox"] = 1,
            ["prison_elec_wires"] = 3,
            ["prison_circuit_board"] = 1,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        perCraft = 1,
        points = 1,
    },
    [6] = {
        name = "prison_tablet",
        amount = 50,
        info = {},
        costs = {
            ["prison_broken_tablet"] = 1,
            ["prison_circuit_board"] = 1,
            ["prison_elec_wires"] = 3,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        perCraft = 1,
        points = 1,
    },
    [7] = {
        name = "prison_phone",
        amount = 50,
        info = {},
        costs = {
            ["prison_broken_phone"] = 1,
            ["prison_circuit_board"] = 2,
            ["prison_elec_wires"] = 2,
            ["prison_metal_wire"] = 2,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        perCraft = 1,
        points = 1,
    },
    [8] = {
        name = "prison_thread",
        amount = 50,
        info = {},
        costs = {
            ["prison_sewing_needle"] = 1,
            ["prison_fabric"] = 1,
        },
        type = "item",
        slot = 1,
        threshold = 0,
        perCraft = 1,
        points = 1,
    },
    [9] = {
        name = "prison_sewing_needle",
        amount = 50,
        info = {},
        costs = {
            ["prison_metal_wire"] = 1,
        },
        type = "item",
        slot = 1,
        threshold = 0,
            perCraft = 1,
        points = 1,
    },
    [10] = {
        name = "plastic",
        amount = 50,
        info = {},
        costs = {
            ["prison_plastic"] = 5,
        },
        type = "item",
        slot = 1,
        threshold = 0,
            perCraft = 1,
        points = 1,
    },
    -- [11] = {
    --     name = "weapon_switchblade",
    --     amount = 50,
    --     info = {},
    --     costs = {
    --         ["prison_plastic"] = 50,
    --         ["prison_metal_wire"] = 50,
    --         ["prison_fabric"] = 50,
    --         ["prison_laces"] = 50,
    --         --["prison_varnish"] = 50,
    --     },
    --     type = "item",
    --     slot = 1,
    --     threshold = 0,
    --         perCraft = 1,
    --     points = 1,
    -- },
}

Config.PrisonSellPrices = 
{
    -- Raw Components
    ['prison_plastic'] = 1,
    ['prison_kitchenoil'] = 5,
    ['prison_metal_wire'] = 5,
    ['prison_fabric'] = 5,
    ['prison_laces'] = 5,
    ['prison_elec_wires'] = 5,
    ['prison_elec_comps'] = 5,
    ['prison_varnish'] = 5,
    ['prison_broken_circuit'] = 5,
    ['prison_broken_boombox'] = 15, 
    ['prison_broken_phone'] = 15,  
    ['prison_broken_tablet'] = 15,
    
    -- Crafted/Multi Step items [Second Ped for these?]
    ['prison_tablet'] = 65, 
    ['prison_boombox'] = 75, 
    ['prison_phone'] = 50, 
    ['plastic'] = 6,
    ["prison_plate"] = 35,
    ["prison_uniform"] = 55,
    ["prison_lingerie"] = 45,
    ["prison_circuit_board"] = 35,
    ["prison_thread"] = 15,
    ["prison_sewing_needle"] = 10,
}