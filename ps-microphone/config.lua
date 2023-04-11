Config = {}

Config.Showzone = false

Config.MicrophoneZones = {
    [1] = {
        name = "vinewood_bowl", 
        coords = vector3(683.37, 569.31, 130.46),
        length = 3.4,
        width = 3.6,
        spawnProp = true, -- if set to true, it will let you spawn the prop at location
        data = {
            debugPoly = Config.Showzone,
            heading = 340,
            minZ = 127.86,
            maxZ = 131.86,
            data = {
                range = 50.0 -- range for the voice
            }
        }
    },
    [2] = {
        name = "CourtHouse", 
        coords = vector3(-574.2, -209.0, 38.23),
        length = 11.4,
        width = 11.8,
        spawnProp = false, -- if set to true, it will let you spawn the prop at location
        data = {
            debugPoly = Config.Showzone,
            heading = 30,
            minZ = 37.23,
            maxZ = 41.23,
            data = {
                range = 20.0 -- range for the voice
            }
        }
    },
}
