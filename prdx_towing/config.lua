Config = {}

Config.InteractDistance         = 6.0   -- Distance to check if near a truck on foot
Config.CloseVehiclesDistance    = 20.0  -- Distance to check for nearby vehicles
Config.WinchSpeed               = 0.6   -- Winch Speed. HIGHLY suggest adjusting in 0.1 increments
Config.GetInDistance            = 2.5
Config.MaxWinchLength           = 20.0
Config.MinWindDistance          = 2.4
Config.MaxUnwindDistance        = 10.0
Config.Doublecheck              = true  -- Double locks the vehicle onto the bed to try and ensure its touching the bed

--NOTIFICATIONS--
Config.Notifications            = true

--TRANSLATIONS More customization in utils.lua including key controls
Config.NotiUnLoadCompleteMessage    = "Unload Complete"
Config.NotiLoadCompleteMessage      = "Loading Complete"
Config.NotiBlockedMessage           = "Unloading zone blocked"
Config.NotiFBBlockedMessage         = "Flatbed blocked or occupied"

Config.Trucks = {
    [joaat('tow')] = {
        type = 'rolling',
        boneName = 'misc_a',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.4, 0.0),
        carHeightOffset = 0.0,
        winchBone = 'misc_b',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 5.0 --How far backwards from the winch bone to check from
    },
    [joaat('flatbedm2')] = {
        type = 'rolling',
        boneName = 'misc_a',
        hasBedControl = true,
        BedControl = {vector3(-1.8,-4.5,-0.55),vector3(1.8,-4.5,-0.55)},
        unloadPos = {vector3(-2.0,-2.0,-0.55)},
        carPosition = vector3(0.0, 0.4, 0.0),
        carHeightOffset = 0.3,
        winchBone = 'misc_b',
        winchDistCheck = 5.0, -- How far from winchOffset to check for a vehicle
        winchOffset = 5.0 --How far backwards from the winch bone to check from
    },
}

