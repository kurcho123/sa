local DefaultVehicleDensity = 0.8
local DefaultPedDensity = 1.0
--------------------------
local VehicleDensity = 0.8
local PedDensity = 1.0
local IsSpeeding = false
local IsDriver = false
local inVehicle = false
local inRace = false
AddScenarioBlockingArea(2306.6526, 4660.7344, 302.4035, 207.1569, 3463.5022, -191.3075, true, true, true, true) 
SetGarbageTrucks(false)

CreateThread(function()
	SetPedPopulationBudget(3)
	SetVehiclePopulationBudget(3)
	SetReducePedModelBudget(true)
	SetReduceVehicleModelBudget(true)
    while true do
		Wait(0)
		if inRace then
			PedDensity = 0.0
			VehicleDensity = 0.0		
		end
		SetPedDensityMultiplierThisFrame(PedDensity)
		SetScenarioPedDensityMultiplierThisFrame(PedDensity, PedDensity) -- Walking NPC Density
		SetParkedVehicleDensityMultiplierThisFrame(VehicleDensity)
		SetVehicleDensityMultiplierThisFrame(VehicleDensity)
		SetRandomVehicleDensityMultiplierThisFrame(VehicleDensity)
    end
end)

CreateThread(function()
    while true do
		Wait(50)
		ClearAreaOfPeds(-1103.57, 4919.67, 216.5, 50.0, 1)
		ClearAreaOfPeds(541.53, -177.12, 54.49, 20.0, 1)
		ClearAreaOfPeds(-1057.68, 4906.65, 211.14, 200.0, 1)
		ClearAreaOfPeds(1126.22, 2648.3, 46.75, 50.0, 1) -- Harmony PD
		ClearAreaOfPeds(-93.47, 981.96, 235.76, 50.0, 1) -- The Collective HQ
		ClearAreaOfPeds(1437.74, 1124.41, 178.15, 100.0, 1) -- Paintball
		ClearAreaOfPeds(1435.0, 1300.8, 113.14, 100.0, 1) -- Paintball
		ClearAreaOfPeds(288.51, -1601.22, 31.27, 50.0, 1) -- Davis Market Place
		ClearAreaOfPeds(-1385.08, -614.64, 43.3, 54.4, 1) -- Maisonette
		ClearAreaOfPeds(-626.07, 5833.23, 33.44, 300, 1) -- Sycthe smiths
		ClearAreaOfPeds(975.168, -118.142, 74.329, 208.16) -- The lost compound
	end
end)

AddEventHandler('pausePopulation', function(pause)
	if pause == true then
		SetPedPopulationBudget(0)
		SetVehiclePopulationBudget(0)
		PedDensity = 0.0
		VehicleDensity = 0.0
	else
		SetPedPopulationBudget(3)
		SetVehiclePopulationBudget(3)
		PedDensity = DefaultPedDensity
		VehicleDensity = DefaultVehicleDensity
	end
end)

RegisterNetEvent('QBCore:vehicleSpeeding', function (isSpeeding)
	if not IsDriver then return end -- Only driver changes
	if inRace then return end -- Race bypass
	if isSpeeding then
		PedDensity = 0.7
		VehicleDensity = 0.5
	else
		PedDensity = DefaultPedDensity
		VehicleDensity = DefaultVehicleDensity
	end
end)

RegisterNetEvent('QBCore:enteredVehicle', function (currentVehicle, currentSeat)
	IsSpeeding = false
	inVehicle = true
	IsDriver = currentSeat == -1
end)

RegisterNetEvent('QBCore:leftVehicle', function ()
	IsSpeeding = false
	inVehicle = false
	IsDriver = false
	PedDensity = DefaultPedDensity
	VehicleDensity = DefaultVehicleDensity
	SetPedPopulationBudget(3)
	SetVehiclePopulationBudget(3)
end)


RegisterNetEvent('QBCore:vehicleChangedSeat', function (currentVehicle, currentSeat)
	if not inVehicle then return end -- prevent duplicate loops
	IsSpeeding = false
	IsDriver = currentSeat == -1
end)

local toggle = false

RegisterNetEvent('rahe-racing:client:updateCountdown', function(count)
	if not inRace then
		inRace = true
	end
	if count <= 5 then
		local coords = GetEntityCoords(PlayerPedId())
		ClearAreaLeaveVehicleHealth(coords.x, coords.y, coords.z, 100.0, false, false, false, false)
	end
end)

RegisterNetEvent('rahe-racing:client:hideLeaderboard', function()
	inRace = false
end)