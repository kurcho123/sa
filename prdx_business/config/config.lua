Config = Config or {}

Config.Debug = false
Config.MaxExtraPrice = 25000

Config.Businesses = {
    ["gopostal"] = "GoPostal",
    ["yellowjack"] = "The Open Road",
    ["smokeonthewater"] = "Smoke On The Water",
    ["glazedandglorious"] = "Glazed and Glorious",
    ["vanillaunicorn"] = "Vanilla Unicorn Gentlements Club",
    ["tequilala"] = "Skull Island", 
    ["finnistaxi"] = "Finnis Taxi",
    ["tenfourtwo"] = "10-42",
    ["bikinitow"] = "Bikini Automotive",
    ["nismostuning"] = "Nismo\'s Tuning",
    ["realestate"] = "Wolfs Real Estate",
    ["slurpngo"] = "Slurp n Go",
    ["beaveraviation"] = "Flying Beaver Aviation",
    ["cardealer"] = "Kildare Autos",
    ["paintball"] = "Ball Breakers Paintball",
    ["maisonette"] = "Maisonette",
    ["knifeshop"] = "Scythe Smiths",
    ["glizzycomics"] = "Glizzy Comics",
    ["bikedealer"] = "Reapers Bike Shop", 
    ["koi"] = "KOI", 

    ["clinic"] = "Los Santos Clinic", 
    ["ambulance"] = "San Andreas Emergency Medical Services",
}

Config.MapBlips = {
    --Business Blips
    ["gopostal"] = {coords = vector3(76.84, 138.73, 80.53), sprite = 478, color = 3, name = Config.Businesses["gopostal"], enabled = true},
    ["yellowjack"] = {coords = vector3(2508.45, 4095.99, 38.54), sprite = 93, color = 2, name = Config.Businesses["yellowjack"], enabled = true},
    ["smokeonthewater"] = {coords = vector3(380.0, -831.83, 29.29), sprite = 496, color = 2, name = Config.Businesses["smokeonthewater"], enabled = true},
    ["glazedandglorious"] = {coords = vector3(-580.93, -1067.39, 22.34), sprite = 270,  color = 8, name = Config.Businesses["glazedandglorious"], enabled = true},
    ["vanillaunicorn"] = {coords = vector3(127.66, -1296.63, 29.27), sprite = 121,  color = 61, name = Config.Businesses["vanillaunicorn"], enabled = true},
    ["tequilala"] = {coords = vector3(-564.54, 277.36, 83.14), sprite = 310,  color = 62, name = Config.Businesses["tequilala"], enabled = true},
    ["finnistaxi"] = {coords = vector3(906.18, -151.77, 74.17), sprite = 198,  color = 5, name = Config.Businesses["finnistaxi"], enabled = true},
    ["tenfourtwo"] = {coords = vector3(1220.61, -417.18, 67.77), sprite = 511,  color = 7, name = Config.Businesses["tenfourtwo"], enabled = true},
    ["nismostuning"] = {coords = vector3(-1606.43, -855.21, 10.12), sprite = 483,  color = 1, name = Config.Businesses["nismostuning"], enabled = true},
    ["realestate"] = {coords = vector3(-589.25, -708.01, 36.28), sprite = 442,  color = 35, name = Config.Businesses["realestate"], enabled = true},
    ["beaveraviation"] = {coords = vector3(1731.19, 3309.15, 41.22), sprite = 90,  color = 81, name = Config.Businesses["beaveraviation"], enabled = true},
    ["paintball"] = {coords = vector3(-1057.73, 4917.87, 211.82), sprite = 491,  color = 25, name = Config.Businesses["paintball"], enabled = true},
    ["bikinitow"] = {coords = vector3(833.14, -823.19, 26.33), sprite = 446,  color = 38, name = Config.Businesses["bikinitow"], enabled = true},
    ["maisonette"] = {coords = vector3(-1391.17, -621.24, 31.3), sprite = 279,  color = 24, name = Config.Businesses["maisonette"], enabled = true},
    ["knifeshop"] = {coords = vector3(-676.31, 5837.13, 17.34), sprite = 154,  color = 37, name = Config.Businesses["knifeshop"], enabled = true},
    ["glizzycomics"] = {coords = vector3(-44.37, -82.87, 56.77), sprite = 409,  color = 81, name = Config.Businesses["glizzycomics"], enabled = true},
    ["clinic"] = {coords = vector3(321.71, -574.98, 43.28), sprite = 398,  color = 1, name = Config.Businesses["clinic"], enabled = true},
    ["koi"] = {coords = vector3(-1036.71, -1481.21, 5.3), sprite = 308,  color = 47, name = Config.Businesses["koi"], enabled = true},
    --Import/Export Blips
    ["farmingimports"] = {coords = vector3(-65.99, 6506.25, 31.24), sprite = 52,  color = 69, name = "Farmers Market", enabled = true},
    ["ranchingimports"] = {coords = vector3(-67.92, 6254.27, 31.34), sprite = 68,  color = 75, name = "Meat Market", enabled = true},
    ["commercialimports"] = {coords = vector3(814.2, -2982.5, 6.02), sprite = 478,  color = 31, name = "Commercial Imports", enabled = true},
}

Config.MobileBusiness = {
    {vehicle = "mrtasty", job = "slurpngo", showStorage = true, showBoss = true},
    {vehicle = "taxiespe", job = "finnistaxi", showStorage = false, showBoss = false}
}