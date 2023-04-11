exports.ox_target:addBoxZone({ -- License Computer
    coords = vector3(-541.39, -195.27, 38.23),
    size = vector3(0.6, 0.4, 0.6),
    rotation = 25,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'TownHallLicense2',
            serverEvent = 'QBCore:jobs:ToggleDuty',
            icon = 'fas fa-business-time',
            label = 'Clock In (Government Employees)',
            dutyJob = "government"
        },
        {
            name = 'TownHallLicense3',
            serverEvent = 'QBCore:jobs:ToggleDuty',
            icon = 'fas fa-business-time',
            label = 'Clock In (Lawyer)',
            dutyJob = "lawyer"
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Public Records
    coords = vector3(-550.9, -202.4, 38.24),
    size = vector3(0.8, 0.3, 0.6),
    rotation = 325.25,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'PublicRecords',
            event = 'prdx_mdt:client:openpublic',
            icon = 'fas fa-tablet-alt',
            label = 'Access Public Records',
            distance = 2.5
        },
        {
            name = 'TownHallLicense1',
            serverEvent = 'qb-cityhall:server:requestIdtgt',
            icon = 'fas fa-id-card',
            label = 'Print new state ID $50'
        },
    },
}) 


-- Government Job Locations

exports.ox_target:addBoxZone({ -- Clothing
    coords = vector3(-531.43, -180.96, 43.37),
    size = vector3(2.4, 0.7, 2.0),
    rotation = 211.05,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'GovernmentClothing',
            event = 'raid_clothes:outfitsMenu',
            icon = 'fas fa-tshirt',
            label = 'Open Personal Outfits',
            groups = {"government"},
            distance = 2.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Storage
    coords = vector3(-533.62, -182.26, 43.37),
    size = vector3(2.6, 0.7, 2.0),
    rotation = 211.05,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'GovernmentStorage',
            event = 'target:client:openStash',
            icon = 'fas fa-box-open',
            label = 'Open Government Locker',
            groups = {"government"},
            args = {"government", "government"},
            distance = 2.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Boss
    coords = vector3(-528.29, -189.39, 43.37),
    size = vector3(0.5, 0.35, 0.6),
    rotation = 144.67,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'GovernmentBoss',
            event = 'prdx_bossmenu:client:openMenu',
            icon = 'fas fa-users',
            label = 'Boss Actions',
            groups = {["government"] = 3},
            distance = 2.5
        }
    },
}) 

-- Judge Job Locations

exports.ox_target:addBoxZone({ -- Clothing
    coords = vector3(-531.43, -180.96, 43.37),
    size = vector3(2.4, 0.7, 2.0),
    rotation = 211.05,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'JudgeClothing',
            event = 'raid_clothes:outfitsMenu',
            icon = 'fas fa-tshirt',
            label = 'Open Personal Outfits',
            groups = {"judge"},
            distance = 2.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Storage
    coords = vector3(-533.62, -182.26, 43.37),
    size = vector3(2.6, 0.7, 2.0),
    rotation = 211.05,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'JudgeStorage',
            event = 'target:client:openStash',
            icon = 'fas fa-box-open',
            label = 'Open Judge Locker',
            groups = {"judge"},
            args = {"judge", "judge"},
            distance = 2.5
        }
    },
}) 