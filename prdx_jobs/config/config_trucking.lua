-- -- -- -- -- -- -- -- -- -- -- -- -- --
--          TRUCKING CONFIG            --
-- -- -- -- -- -- -- -- -- -- -- -- -- --
Config = Config or {}
Config.Trucking = {  
    depotLocation = vector3(-416.67, -2763.8, 6.0),
    
    -- possible spawn locations for trailers at the depot
    trailerSpawns = {
        vector4(-446.05, -2789.72, 6.0, 44.99),
        vector4(-450.61, -2789.72, 6.0, 44.99),
        vector4(-452.76, -2792.17, 6.0, 44.99), 
        vector4(-454.80, -2794.86, 6.0, 44.99), 
        vector4(-457.06, -2796.75, 6.0, 44.99), 
    },

    truckSpawns = {
        vector4(-434.09, -2763.57, 6.0, 179.04),
        vector4(-428.69, -2763.52, 6.0, 183.76),
        vector4(-423.31, -2763.24, 6.0, 186.53)
    },

    -- format: cargo = a string of whatever the player is delivering,
    -- payout = the payout for the delivery, location = a vector4 containing the delivery location,
    -- trailer = the vehicle hash for the trailer used on the job, icon = the icon to display in the menu
    jobs = {
        -- New Routes by distance
        {cargo = "Fuel",             payout = 80,  location = vector4(2565.92, 385.92, 108.46, 357.97),  trailer = 'tanker',      icon = "fas fa-gas-pump"},
        {cargo = "General Supplies", payout = 80,  location = vector4(-2961.0, 61.52, 11.64, 60.9),      trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Stage Equipment",  payout = 85,  location = vector4(228.71, 1176.36, 225.87, 12.2),    trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Fruit & Veg",      payout = 85,  location = vector4(-67.45, 1899.12, 196.23, 166.78),  trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Grains",           payout = 90,  location = vector4(1458.69, 1128.85, 114.33, 86.48),  trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "General Supplies", payout = 95,  location = vector4(1156.2, 2104.11, 56.0, 0.42),      trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "General Supplies", payout = 105, location = vector4(-3172.86, 1110.49, 20.84, 335.94), trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Fuel",             payout = 105, location = vector4(1058.55, 2667.45, 39.56, 0.85),    trailer = 'tanker',      icon = "fas fa-gas-pump"},
        {cargo = "Unmarked Shipment",payout = 105, location = vector4(1874.42, 284.41, 164.31, 146.71),  trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "General Supplies", payout = 110, location = vector4(193.69, 2759.38, 43.43, 197.9),    trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Fruit & Veg",      payout = 115, location = vector4(-1156.81, 2666.47, 18.09, 223.55), trailer = 'trailers3',   icon = "fas fa-pallet"  },
        {cargo = "Car Parts",        payout = 115, location = vector4(1773.28, 3306.8, 41.19, 267.06),   trailer = 'trailers4',   icon = "fas fa-pallet"  }, 
        {cargo = "Generic Cargo",    payout = 115, location = vector4(2828.2, 1585.18, 24.56, 77.34),    trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Steel",            payout = 115, location = vector4(285.87, 2829.41, 43.43, 300.68),   trailer = 'trailers4',   icon = "fas fa-pallet"  },     
        {cargo = "General Supplies", payout = 115, location = vector4(562.22, 2727.23, 42.06, 271.19),   trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Fuel",             payout = 120, location = vector4(229.78, 2600.0, 45.49, 13.42),     trailer = 'tanker',      icon = "fas fa-gas-pump"},
        {cargo = "Fruit & Veg",      payout = 120, location = vector4(348.85, 3414.63, 36.51, 289.83),   trailer = 'trailers3',   icon = "fas fa-pallet"  },
        {cargo = "Fuel",             payout = 130, location = vector4(-2530.11, 2340.5, 33.06, 212.75),  trailer = 'tanker',      icon = "fas fa-gas-pump"},
        {cargo = "Fruit & Veg",      payout = 130, location = vector4(2534.43, 2634.65, 37.94, 88.38),   trailer = 'trailers3',   icon = "fas fa-pallet"  },
        {cargo = "Generic Cargo",    payout = 130, location = vector4(2677.13, 3525.95, 52.53, 339.85),  trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Fruit & Veg",      payout = 135, location = vector4(2901.06, 4385.45, 50.33, 294.13),  trailer = 'trailers3',   icon = "fas fa-pallet"  },
        {cargo = "Boat Parts",       payout = 140, location = vector4(1363.96, 4365.22, 44.34, 267.93),  trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Off Road Trucks",  payout = 145, location = vector4(2543.29, 4669.82, 34.08, 319.23),  trailer = 'tr4',         icon = "fas fa-car"     },
        {cargo = "Lab Equipment",    payout = 155, location = vector4(3568.31, 3658.37, 33.92, 262.13),  trailer = 'trailers4',   icon = "fas fa-pallet"  },        
        {cargo = "Fruit & Veg",      payout = 160, location = vector4(-2199.71, 4260.01, 47.94, 34.28),  trailer = 'trailers3',   icon = "fas fa-pallet"  },
        {cargo = "Chemicals",        payout = 175, location = vector4(-2133.54, 3423.43, 31.51, 352.06), trailer = 'trailers4',   icon = "fas fa-gas-pump"},
        {cargo = "Logs",             payout = 220, location = vector4(-580.11, 5253.79, 70.47, 154.95),  trailer = 'TrailerLogs', icon = "fas fa-pallet"  },
        {cargo = "Hunting Supplies", payout = 245, location = vector4(-696.57, 5770.1, 17.33, 59.18),    trailer = 'trailers',    icon = "fas fa-pallet"  },
        {cargo = "Generic Cargo",    payout = 270, location = vector4(-322.02, 6097.13, 31.46, 226.87),  trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Livestock",        payout = 275, location = vector4(67.54, 6330.26, 31.23, 22.36),     trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Fruit & Veg",      payout = 300, location = vector4(-54.77, 6531.48, 31.49, 222.05),   trailer = 'trailers4',   icon = "fas fa-pallet"  },
        {cargo = "Sports Cars",      payout = 300, location = vector4(-219.11, 6211.14, 31.49, 315.0),   trailer = 'tr4',         icon = "fas fa-car"     },        
    },
}