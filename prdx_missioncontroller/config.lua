Config = Config or {}

-- Test routes for vehcile patrols
Config.VehiclePatrols = {
    test_route1 = {
        vehicleModel = joaat('squaddie'),
        driver = joaat('s_m_y_blackops_01'),
        spawnLocation = vector4(4530.73, -4527.97, 4.13, 108.76),
        route = {
            vector3(4510.14, -4508.72, 4.02),
            vector3(4491.51, -4499.42, 4.19),
            vector3(3946.0, -4699.96, 4.18), -- turnaround on end of the air strip
            vector3(3941.18, -4688.36, 4.18),
            vector3(4516.99, -4480.73, 4.18)
        }
    }
}

Config.AttackingGroups = {
    test_group = {
        peds = { -- Max 8 per group (spawn same group again for more peds of same type)
            {
                pedType = 'attacker',
                model = joaat('s_m_m_chemsec_01'),
                weapon = joaat('WEAPON_ASSAULTRIFLE')
            },
            {
                pedType = 'attacker',
                model = joaat('s_m_m_chemsec_01'),
                weapon = joaat('WEAPON_ASSAULTRIFLE')
            },
            {
                pedType = 'attacker',
                model = joaat('s_m_m_chemsec_01'),
                weapon = joaat('WEAPON_ASSAULTRIFLE')
            },
            {
                pedType = 'attacker',
                model = joaat('s_m_m_chemsec_01'),
                weapon = joaat('WEAPON_ASSAULTRIFLE')
            },
            {
                pedType = 'attacker',
                model = joaat('s_m_y_blackops_01'),
                weapon = joaat('WEAPON_ASSAULTRIFLE')
            },
            {
                pedType = 'attacker',
                model = joaat('s_m_y_blackops_02'),
                weapon = joaat('WEAPON_ASSAULTRIFLE')
            },
            {
                pedType = 'attacker',
                model = joaat('s_m_y_blackops_03'),
                weapon = joaat('WEAPON_ASSAULTRIFLE')
            },
            {
                pedType = 'breacher',
                model = joaat('u_m_y_juggernaut_01'),
                weapon = joaat('WEAPON_DBSHOTGUN')
            },
        },
    }   
}