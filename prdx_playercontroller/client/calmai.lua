SetRelationshipBetweenGroups(3, `AMBIENT_GANG_HILLBILLY`, `PLAYER`)
SetRelationshipBetweenGroups(1, `AMBIENT_GANG_BALLAS`, `PLAYER`)
SetRelationshipBetweenGroups(3, `AMBIENT_GANG_MEXICAN`, `PLAYER`)
SetRelationshipBetweenGroups(1, `AMBIENT_GANG_FAMILY`, `PLAYER`)
SetRelationshipBetweenGroups(2, `AMBIENT_GANG_MARABUNTE`, `PLAYER`)
SetRelationshipBetweenGroups(3, `AMBIENT_GANG_SALVA`, `PLAYER`)
SetRelationshipBetweenGroups(3, `AMBIENT_GANG_LOST`, `PLAYER`)
SetRelationshipBetweenGroups(3, `GANG_1`, `PLAYER`)
SetRelationshipBetweenGroups(3, `GANG_2`, `PLAYER`)
SetRelationshipBetweenGroups(2, `GANG_9`, `PLAYER`)
SetRelationshipBetweenGroups(3, `GANG_10`, `PLAYER`)
SetRelationshipBetweenGroups(2, `FIREMAN`, `PLAYER`)
SetRelationshipBetweenGroups(2, `MEDIC`, `PLAYER`)
SetRelationshipBetweenGroups(1, `PRIVATE_SECURITY`, `PLAYER`)
SetRelationshipBetweenGroups(4, `COP`, `PLAYER`)
SetRelationshipBetweenGroups(5, `HATES_PLAYER`, `PLAYER`)
SetRelationshipBetweenGroups(2, `PRISONER`, `PLAYER`)


SetScenarioTypeEnabled("WORLD_VEHICLE_AMBULANCE", false)
SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR", false)
SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE", false)
SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR", false)

-- Disable ambient noises
SetStaticEmitterEnabled("LOS_SANTOS_AMMUNATION_GUN_RANGE", false)
SetStaticEmitterEnabled("SE_AMMUNATION_CYPRESS_FLATS_GUN_RANGE", false)
SetStaticEmitterEnabled("collision_9qv4ecm", false) -- Tequilala