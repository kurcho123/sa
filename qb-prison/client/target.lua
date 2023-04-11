exports.ox_target:addBoxZone({ -- Alarm
    coords = vector3(1839.41, 2573.82, 46.01),
    size = vector3(2.6, 1.2, 1.8),
    rotation = 0.0,
    debug = Config.ShowTargetZones,
    options = {
        {
            name = 'PrisonAlarm1',
            serverEvent = 'prison:server:JailAlarmOn',
            icon = 'far fa-bell',
            label = 'Alarm Activate',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"}
        },
        {
            name = 'PrisonAlarm2',
            serverEvent = 'prison:server:JailAlarmOff',
            icon = 'far fa-bell',
            label = 'Alarm Silence',
            groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"}
        }
    },
}) 