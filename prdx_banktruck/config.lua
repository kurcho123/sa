Config = {}
Config.Debug = true
Config.MinimumPoliceRequired = 4  --<< needed police to activate the mission
Config.ThermiteTime = 30 * 1000 -- 30 seconds
Config.LockboxTimer = 60 -- * 5000 = total time in MS (5 minutes)
Config.RotationTimer = math.random(35, 45) -- randomize bank truck spawns

--Reward / Cost for the mission
Config.Bags = 5        --<<Bags you can get from a robbery
Config.BillsA = 10        --<<Minimum bills you can get from a robbery
Config.BillsB = 20        --<< maximum Bills you can get from a robbery

--Models
Config.TruckModel = 'stockade'              --<< Model of the truck
Config.GuardModel = "s_m_m_security_01"          --<< Model of the guards
Config.GuardWeapon = "WEAPON_PUMPSHOTGUN_MK2"

--<< coordinates of the truck's spawn (picked randomly)
Config.SpawnLocations = {
    vector4(9.27, 6648.56, 31.01, 109.01), -- Paleto 1
    vector4(-149.83, 6328.63, 31.1, 226.23), -- Paleto 2
    vector4(-2286.7, 4234.61, 42.12, 170.93), -- Great Ocean Highway
    vector4(-1088.0, 2679.71, 19.25, 309.74), -- Route 68 1
    vector4(928.07, 2717.62, 40.14, 176.82), -- Route 68 2
    vector4(1426.78, 3586.45, 34.51, 288.02), -- Sandy Shores
    vector4(2664.54, 3222.01, 53.38, 183.23), -- Senora Fwy South
    vector4(2602.04, 403.0, 107.98, 323.37), -- Palamino Fwy North
}

