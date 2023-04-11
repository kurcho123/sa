exports.ox_target:addBoxZone({ -- Elevator
    coords = vector3(-141.84, -620.97, 168.82),
    size = vector3(0.4, 1.55, 2.4),
    rotation = 6.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'ArcadiusElevator',
            event = 'prdx_jobs:arcadius:openBusinessDirectory',
            icon = 'fas fa-list-ol',
            label = 'Business Directory',
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Clothes
    coords = vector3(-132.89, -634.84, 168.82),
    size = vector3(2.4, 0.25, 2.4),
    rotation = 276.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'ArcadiusClothes',
            event = 'raid_clothes:outfitsMenu"',
            icon = 'fas fa-tshirt',
            label = 'Change Outfits',
        }
    },
}) 