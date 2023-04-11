Config = {}

Config.UseESX = false
Config.UseQBCore = true

Config.TrailerShop = {
    [1] ={
        npccoords = vector3(-247.51, 6213.35, 31.94), 
        heading = 120.0, 
        ped = 'a_f_m_downtown_01', 
        job = 'none',
        trailertobuy = {
            {label = 'une remorque bateau', name = 'boattrailer', price = 250, coordsspawn = vector3(-251.8, 6223.12, 31.49), heading = 311.34}, 
            {label = 'une remorque voiture', name = 'trailersmall', price = 250, coordsspawn = vector3(-251.09, 6223.35, 32.49), heading =  311.34}
        }
    },
}

Config.VehicleCanTrail = {
    {name = `GUARDIAN`, class = {8, 9, 13}},
    {name = `SQUADDIE`, class = {8, 9, 13}},
    {name = `BENSON`, class = {8, 9, 13}},
    {name = `EVERON`, class = {8, 9, 13}},
    {name = `SANDKING`, class = {8, 9, 13}},
    {name = `SANDKING2`, class = {8, 9, 13}},
    {name = `DUBSTA3`, class = {8, 9, 13}},
    {name = `BOBCATXL`, class = {8, 9, 13}},
    {name = `BOATTRAILER`, class = {14}},
    {name = `TITAN`, class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}}, -- CAR HAULER
    {name = `TRAILERSMALL`, class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}}, -- CAR HAULER
    {name = `TRAILER`, class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 18, 19, 20}},
    {name = `WASTELANDER`, class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}},
    {name = `SLAMTRUCK`, class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}},
    {name = `TR2`, class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}}, -- CAR HAULER
    {name = `TVTRAILER`, class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}}, -- CAR HAULER
    {name = `TRFLAT`, class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20}}, -- CAR HAULER
}

Config.Presets = {
    [`suntrap`] = {ypos = -0.6 , zpos = 0.3},--suntrap
    [`tropic`] = {ypos = -0.9, zpos = 0.7 },--tropic
    [`tropic2`] = {ypos = -0.9, zpos = 0.7 },--tropic2
    [`toro`] = {ypos = -1.3, zpos = 0.7 },--toro
    [`toro2`] = {ypos = -1.3, zpos = 0.7 },--toro2
    [`speeder`] = {ypos = -2.1, zpos = 0.4 },--speeder
    [`speeder2`] = {ypos = -2.1, zpos = 0.4 },--speeder2
    [`squalo`] = {ypos = -1.2, zpos = 0.8 },--squalo
    [`jetmax`] = {ypos = -2.0, zpos = 0.6 },--jetmax
    [`dinghy`] = {ypos = -1.1, zpos = 0.3 },--Dinghy
    [`dinghy2`] = {ypos = -1.1, zpos = 0.3 },--Dinghy2
    [`dinghy3`] = {ypos = -1.1, zpos = 0.3 },--Dinghy3
    [`dinghy4`] = {ypos = -1.1, zpos = 0.3 },--Dinghy4
    [`seashark`] = {ypos = -1.1, zpos = 0.0 },--Seashark
    [`seashark2`] = {ypos = -1.1, zpos = 0.0 },--Seashark2
    [`seashark3`] = {ypos = -1.1, zpos = 0.0 },--Seashark3
	[`predator`] = {ypos = -1.0, zpos = 0.6 },--predator
}

Config.Lang = {    
    ["TrailerNotFind"] = 'Trailer not found',
    ["RampeAlreadySet"] = 'A ramp is already attached',
    ["NoVehicleSet"] = 'No vehicle attached found',
    ["CantSetThisType"] = 'You cannot attach this type of vehicle to this trailer',
    ["NotGoodJob"] = 'You are not in the targeted trade',
    ["PressToOpen"] = 'Press E to open the menu',
    ["YouBuy"] = 'You have rented: ',
    ["For"] = 'For: ',
    ["CantBuy"] = 'You can\'t buy that',
    ["BuyFor"] = 'Rent for: ',
    ["Blip"] = 'Rent a trailer',
    ["TrailerNotFind"] = 'Trailer not found',
    ["NotInVehicle"] = 'You are not in a vehicle'
}

Config.AttachCommand = 'attachveh'
Config.DetachCommand = 'detachveh'

Config.TrailerRentals = {
	[`trailers`] = {
        name = 'Covered Box Trailer (Semi)',
        price = 550,
        trailerType = 'semi'
    },
    [`trailerlogs`] = {
        name = 'Logging Trailer (Semi)',
        price = 550,
        trailerType = 'semi'
    },
    [`tvtrailer`] = {
        name = 'Lowboy Trailer w/Oversize (Semi)',
        price = 550,
        trailerType = 'semi'
    },
    [`trailers2`] = {
        name = 'Standard Trailer (Semi)',
        price = 550,
        trailerType = 'semi'
    },
    [`trailers`] = {
        name = 'Covered Box Trailer (Semi)',
        price = 550,
        trailerType = 'semi'
    },
    [`trflat`] = {
        name = 'Flatbed Trailer (Semi)',
        price = 550,
        trailerType = 'semi'
    },
    [`docktrailer`] = {
        name = 'Smaller Shipping Contrailer Trailer (Semi)',
        price = 550,
        trailerType = 'semi'
    },
    [`trailers4`] = {
        name = 'Larger Shipping Contrailer Trailer (Semi)',
        price = 550,
        trailerType = 'semi'
    },
    [`boattrailer`] = {
        name = 'Small boat trailer (truck)',
        price = 250,
        trailerType = 'truck'
    },
    [`trailersmall`] = {
        name = 'Small flatbed trailer (truck)',
        price = 250,
        trailerType = 'truck'
    },
    [`graintrailer`] = {
        name = 'Small grain trailer (tractor)',
        price = 150,
        trailerType = 'tractor'
    },
    [`baletrailer`] = {
        name = 'Small bale trailer (tractor)',
        price = 150,
        trailerType = 'tractor'
    },
}

Config.TrailerSpawns = {
	vector4(-341.96, 6075.71, 31.34, 221.41),
    vector4(315.61, 3384.12, 36.4, 351.95),
    vector4(929.44, -1224.83, 25.61, 92.37),
    vector4(54.98, 99.89, 78.9, 157.59),
    vector4(-1226.45, -2317.33, 13.94, 240.52)
}
