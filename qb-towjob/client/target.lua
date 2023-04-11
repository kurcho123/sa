exports.ox_target:addBoxZone({ -- Clock On (City)
    coords = vector3(800.2, -824.75, 26.34),
    size = vector3(0.35, 0.3, 0.4),
    rotation = 90.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SADOTClockOnCity',
            serverEvent = 'QBCore:jobs:ToggleDuty',
            icon = 'fas fa-sign-in-alt',
            label = 'Go on/off duty',
            dutyJob = 'tow'
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Boss (City)
    coords = vector3(797.09, -829.37, 26.34),
    size = vector3(0.2, 0.6, 0.6),
    rotation = 91.1,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SADOTBossCity',
            event = 'prdx_bossmenu:client:openMenu',
            icon = 'fas fa-users',
            label = 'Boss Actions',
            groups = {['tow'] = 6}
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Boss/Duty (County)
    coords = vector3(803.44, -831.12, 26.33),
    size = vector3(1.2, 0.6, 1.15),
    rotation = 0.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SADOTShopCity',
            event = 'qb-tow:client:openShop',
            icon = 'as fa-shopping-cart',
            label = 'Tow Shop',
            groups = {'tow'}
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Clothes A
    coords = vector3(800.40, -830.26, 26.34),
    size = vector3(2.3, 0.6, 2.1),
    rotation = 90.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SADOTClothesA',
            event = 'raid_clothes:outfitsMenu',
            icon = 'fas fa-tshirt"',
            label = 'Change Outfits',
            distance = 1.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Clothes B
    coords = vector3(842.30, -824.57, 26.33),
    size = vector3(2.5, 0.75, 2.1),
    rotation = 90.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SADOTClothesB',
            event = 'raid_clothes:outfitsMenu',
            icon = 'fas fa-tshirt"',
            label = 'Change Outfits',
            distance = 1.5
        }
    },
})

exports.ox_target:addBoxZone({ -- Clothes harmony
    coords = vector3(1187.2, 2635.32, 38.4),
    size = vector3(0.4, 1.0, 2.1),
    rotation = 0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SADOTClothesHarmony',
            event = 'raid_clothes:outfitsMenu',
            icon = 'fas fa-tshirt"',
            label = 'Change Outfits',
            distance = 1.5
        }
    },
})