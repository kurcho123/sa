-- Toggle Duty Zones

exports.ox_target:addBoxZone({ -- MRPD
    coords = vector3(441.7989, -982.0529, 30.8),
    size = vector3(0.45, 0.45, 0.1),
    rotation = 11.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'MRPDToggleDuty',
            serverEvent = 'QBCore:jobs:ToggleDuty',
            icon = 'fas fa-sign-in-alt',
            label = 'Go on/off duty (Police)',
            dutyJob = 'police',
            distance = 2.5
        },
        {
            name = 'MRPDToggleDutyLawyer',
            serverEvent = 'QBCore:jobs:ToggleDuty',
            icon = 'fas fa-sign-in-alt',
            label = 'Clock in/out (Lawyer)',
            dutyJob = 'lawyer',
            distance = 2.5
        },
    },
}) 


-- Uniform Zones

exports.ox_target:addBoxZone({ -- MRPD
    coords = vector3(461.93, -1000.5, 30.69),
    size = vector3(4.6, 1.0, 2.8),
    rotation = 179.47,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'MRPDUniformLocker1',
            event = 'raid_clothes:client:openJobClothing',
            icon = 'fas fa-user-tie',
            label = 'Open Uniform Locker',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        },
        {
            name = 'MRPDUniformLocker2',
            event = 'raid_clothes:outfitsMenu',
            icon = 'fas fa-tshirt',
            label = 'Open Personal Outfits',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Sandy
    coords = vector3(1852.91, 3689.82, 29.82),
    size = vector3(2.8, 0.8, 2.8),
    rotation = 30.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SandyUniformLocker1',
            event = 'raid_clothes:client:openJobClothing',
            icon = 'fas fa-user-tie',
            label = 'Open Uniform Locker',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        },
        {
            name = 'SandyUniformLocker2',
            event = 'raid_clothes:outfitsMenu',
            icon = 'fas fa-tshirt',
            label = 'Open Personal Outfits',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Davis
    coords = vector3(360.7, -1592.16, 25.45),
    size = vector3(0.7, 4.8, 2.2),
    rotation = 320.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'DavisUniformLocker1',
            event = 'raid_clothes:client:openJobClothing',
            icon = 'fas fa-user-tie',
            label = 'Open Uniform Locker',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        },
        {
            name = 'DavisUniformLocker2',
            event = 'raid_clothes:outfitsMenu',
            icon = 'fas fa-tshirt',
            label = 'Open Personal Outfits',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        }
    },
}) 

-- Boss Computer Zones

exports.ox_target:addBoxZone({ -- Sandy
    coords = vector3(1849.15, 3694.2, 38.22),
    size = vector3(0.6, 0.2, 0.6),
    rotation = 210.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SandyBossComputer1',
            serverEvent = 'mdt:server:openMDT',
            icon = 'fas fa-tablet-alt',
            label = 'Open MDT',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            noAnim = true,
            distance = 2.5
        },
        {
            name = 'SandyBossComputer2',
            event = 'prdx_bossmenu:client:openMenu',
            icon = 'fas fa-users',
            label = 'Boss Actions',
            groups = {["marshalls"] = 0, ["lspd"] = 4, ["bcso"] = 4, ["sast"] = 4, ["pd_cid"] = 4, ["hc"] = 0},
            distance = 2.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Davis
    coords = vector3(359.6, -1591.12, 31.05),
    size = vector3(2.25, 1.0, 1.2),
    rotation = 50.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'DavisBossComputer1',
            serverEvent = 'mdt:server:openMDT',
            icon = 'fas fa-tablet-alt',
            label = 'Open MDT',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            noAnim = true,
            distance = 2.5
        },
        {
            name = 'DavisBossComputer2',
            event = 'prdx_bossmenu:client:openMenu',
            icon = 'fas fa-users',
            label = 'Boss Actions',
            groups = {["marshalls"] = 0, ["lspd"] = 4, ["bcso"] = 4, ["sast"] = 4, ["pd_cid"] = 4, ["hc"] = 0},
            distance = 2.5
        }
    },
}) 

-- Fingerprint Zones

exports.ox_target:addBoxZone({ -- Davis
    coords = vector3(380.45, -1603.24, 25.45),
    size = vector3(1.5, 0.55, 1.4),
    rotation = 50.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'DavisFingerprint',
            serverEvent = 'police:client:RunPrints',
            icon = 'fas fa-fingerprint',
            label = 'Run Fingerprint Ink Test',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        }
    },
}) 


-- Trash Zones
    
exports.ox_target:addBoxZone({ -- MRPD
    coords = vector3(474.32, -988.86, 25.7),
    size = vector3(0.45, 0.45, 1.0),
    rotation = 89.97,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'MRPDTrash',
            event = 'police:client:OpenTrash',
            icon = 'fas fa-trash',
            label = 'Trash Can',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Sandy
    coords = vector3(1849.46, 3689.39, 34.22),
    size = vector3(0.5, 0.45, 0.9),
    rotation = 50.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'SandyTrash',
            event = 'police:client:OpenTrash',
            icon = 'fas fa-trash',
            label = 'Trash Can',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        }
    },
}) 

exports.ox_target:addBoxZone({ -- Davis
    coords = vector3(367.86, -1588.0, 31.05),
    size = vector3(0.3, 0.3, 0.8),
    rotation = 50.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'DavisTrash',
            event = 'police:client:OpenTrash',
            icon = 'fas fa-trash',
            label = 'Trash Can',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        }
    },
}) 


-- Personal Storage

exports.ox_target:addBoxZone({ -- Davis
    coords = vector3(361.44, -1601.58, 30.05),
    size = vector3(2.9, 0.75, 1.8),
    rotation = 50.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'DavisPersonalStorage',
            serverEvent = 'police:client:openPersonal',
            icon = 'fas fa-box',
            label = 'Personal Storage',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
            distance = 2.5
        }
    },
}) 