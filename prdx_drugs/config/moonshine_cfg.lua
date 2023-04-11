Config = Config or {}
Config.Moonshine = {
    MainTimer = 60 * 60000,
    PumpModel = joaat('prop_generator_01a'),
    WaterDistancePump = 50.0,
    
    TankModel = joaat('prop_watercrate_01'),
    WaterDistanceTank = 15.0,

    FuelBurnRate = 3.25, -- per minute (3.3 = 30 minutes)
    WaterDrainRate = 1.66, --  per minute (1.66 = 1 hour)

    SmokePTFx = {
        lib = 'core',
        name = 'ent_amb_smoke_foundry_white',
    },
}