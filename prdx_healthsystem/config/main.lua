Config = Config or {}
Config.DisableHealthLoop = true -- Main loop disabler (starts true then checks login to enable)
Config.DeathTimer = 300 -- Seconds of timer before bleed out (Cut in half when no EMS online)
Config.UnconciousTimer = 30
Config.OverdoseTimer = Config.DeathTimer * 2
Config.NotifyDelay = 15 -- Seconds before they are allowed to notify EMS if online
Config.MinimumEMS = 1 -- minimum EMS required online and available at time of downing
Config.DefaultHospitalTime = 90 -- When not specified this time is how long they will be in hospital (Seconds)
Config.BleedingHealItem = 'quikclot'
Config.BillCost = 250

Config.Hospitals = {
    ['pillbox'] = {
        id = 'pillbox',
        label = 'Pillbox Hill Medical Center',
        coords = vector3(312.16, -592.68, 43.28),
        heading = 165.0,
        beds = {
            {coords = vector4(309.51, -577.21, 44.20, 160.03), taken = false, model = 2117668672},
            {coords = vector4(313.97, -578.97, 44.20, 160.03), taken = false, model = 2117668672},
            {coords = vector4(319.42, -581.10, 44.20, 160.03), taken = false, model = 2117668672},
            {coords = vector4(324.31, -583.02, 44.20, 160.03), taken = false, model = 2117668672},
            {coords = vector4(322.72, -587.06, 44.20, 339.51), taken = false, model = 2117668672},
            {coords = vector4(317.69, -585.09, 44.20, 339.51), taken = false, model = 2117668672},
            {coords = vector4(314.48, -583.83, 44.20, 339.51), taken = false, model = 2117668672},
            {coords = vector4(310.99, -582.46, 44.20, 339.51), taken = false, model = 2117668672},
            {coords = vector4(307.79, -581.65, 44.20, 339.51), taken = false, model = 2117668672},
        }
    },
    ['sandy'] = {
        id = 'sandy',
        label = 'Sandy Shores Medical Center',
        coords = vector3(1831.37, 3675.12, 34.27),
        heading = 24.35,
        beds = {
            {coords = vector4(1820.06, 3669.58, 35.2, 300.48), taken = false, model = 2117668672},
            {coords = vector4(1819.13, 3671.26, 35.2, 300.48), taken = false, model = 2117668672},
            {coords = vector4(1818.01, 3672.77, 35.2, 300.48), taken = false, model = 2117668672},
            {coords = vector4(1817.23, 3674.71, 35.2, 300.48), taken = false, model = 2117668672},
            {coords = vector4(1818.25, 3677.87, 35.2, 209.97), taken = false, model = 2117668672},
            {coords = vector4(1819.89, 3678.79, 35.2, 209.97), taken = false, model = 2117668672},
            {coords = vector4(1821.55, 3679.91, 35.2, 209.97), taken = false, model = 2117668672},
            {coords = vector4(1823.35, 3680.75, 35.2, 209.97), taken = false, model = 2117668672},
            {coords = vector4(1822.24, 3674.18, 35.2, 119.88), taken = false, model = 2117668672},
            {coords = vector4(1823.29, 3672.34, 35.2, 119.88), taken = false, model = 2117668672},
        }
    },
    ['paleto'] = {
        id = 'paleto',
        label = 'Paleto Bay Medical Center',
        coords = vector3(-254.0, 6331.23, 32.43),
        heading = 125.0,
        beds = {
            {coords = vector4(-247.07, 6318.05, 32.34, 135.32), taken = false, model = 2117668672},
            {coords = vector4(-245.25, 6316.36, 32.34, 135.32), taken = false, model = 2117668672},
            {coords = vector4(-250.98, 6310.46, 32.34, 314.74), taken = false, model = 2117668672},
            {coords = vector4(-252.55, 6312.09, 32.34, 314.74), taken = false, model = 2117668672},
            {coords = vector4(-254.42, 6313.80, 32.34, 314.74), taken = false, model = 2117668672},
            {coords = vector4(-256.08, 6315.44, 32.34, 314.74), taken = false, model = 2117668672},
            {coords = vector4(-251.86, 6323.19, 32.34, 314.74), taken = false, model = 2117668672},
        }
    },
}

Config.PrisonHospital = {
    lable = 'Boilingproke Penetentiary Medical',
    coords = vector3(1768.74, 2570.58, 45.73),
    heading = 319.22,
    beds = {
        {coords = vector4(1761.94, 2591.55, 46.66, 270.29), taken = false, model = 2117668672},
        {coords = vector4(1761.68, 2594.53, 46.66, 270.29), taken = false, model = 2117668672},
        {coords = vector4(1761.94, 2597.64, 46.66, 270.29), taken = false, model = 2117668672},
        {coords = vector4(1772.19, 2598.05, 46.66, 90.94), taken = false, model = 2117668672},
        {coords = vector4(1772.15, 2594.98, 46.66, 90.94), taken = false, model = 2117668672},
        {coords = vector4(1772.19, 2591.85, 46.66, 90.94), taken = false, model = 2117668672},
    },
}

Config.VehAnim = { -- Dead animation when in vehicle
    dict = 'veh@low@front_ps@idle_duck',
    anim = 'sit',
}

Config.DeadAnim = { -- Dead animation when in vehicle
    dict = 'dead',
    anim = 'dead_a',
}

Config.UnconciousAnim = { -- Dead animation when in vehicle
    dict = 'dead',
    anim = 'dead_c',
}

Config.HospitalAnimation = { -- Animation when lying in hospital bed
    dict = 'anim@gangops@morgue@table@',
    anim = 'body_search',
}

Config.PickupAnimation = { -- Animation when getting up from being downed
    dict = 'mini@cpr@char_b@cpr_str',
    anim = 'cpr_success',
}

Config.WakeupAnimation = { -- Animation when getting up from being downed
    dict = 'missheist_jewel',
    anim = '2b_guard_getup',
}