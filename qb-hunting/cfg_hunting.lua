AOD = {}

AOD.HuntAnimals = {'a_c_deer', 'a_c_coyote', 'a_c_boar'}
AOD.SpawnDistanceRadius = math.random(50,65) --disance animal spawns from bait
AOD.HuntingZones = {'CMSW' , 'MTJOSE', 'PALFOR'} --add valid zones here
AOD.SpawnChance = 100 -- 0-100 percentage
AOD.DistanceFromBait = 25.0 -- distance from player to spawn bait
AOD.DistanceTooCloseToAnimal = 15.0
AOD.HuntingWeapon = nil --set to nil for no requirement
AOD.HuntAnyWhere = false
AOD.UseBlip = true -- set to true for the animal to have a blip on the map
AOD.BlipText = 'Prey'

AOD.Strings = {
    QBClient = 'QBCore:GetObject',
    QBServer = 'QBCore:GetObject',
    NotValidZone = 'This isn\'t an area for hunting!',
    ExploitDetected = 'ERROR',
    DontSpam = 'You were charged one bait for spamming',
    WaitToBait = 'You need to wait longer to place bait',
    PlacingBait = 'Placing Bait',
    BaitPlaced = 'Bait placed... now time to wait',
    Roadkill = 'Looks more like roadkill now',
    NoAnimal = 'No Animal nearby',
    NotDead = 'Animal not dead',
    NotYours = 'Not your animal',
    WTF = 'What are you doing?',
    Harvest = 'Butchering animal',
    Butchered = 'Animal butchered'
}

AOD.SellItems = { -- Selling Prices
	['animalcarcassc'] = 125,
	['animalcarcassb'] = 150,
	['animalcarcassa'] = 200,
	['animalcarcasss'] = 325,
}