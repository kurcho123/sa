local QBCore = exports['qb-core']:GetCoreObject() -- We've ALWAYS got to grab our core object
local cayoOffset = vec(-5757.178, -6489.789, 0)
local cayoBlip = nil
local blipLocation = vec(11063, 908, 0)
local blipID = 310
local blipColour = 5
local blipText = "Cayo Perico: Certain Death"

CreateThread(function() -- Setup
	cayoBlip = AddBlipForCoord(blipLocation)
	SetBlipSprite(cayoBlip, blipID)
	SetBlipColour(cayoBlip, blipColour)
	SetBlipDisplay(cayoBlip, 3)
	SetBlipScale(cayoBlip, 0.65)
	AddTextEntry("CayoPericoBlip", blipText)
	BeginTextCommandSetBlipName("CayoPericoBlip")
	EndTextCommandSetBlipName(cayoBlip)
	exports['polyzonehelper']:DeletePolyZone("CayoPericoEnter")
	exports['polyzonehelper']:DeletePolyZone("CayoPericoExit")
	Wait(250)
	exports['polyzonehelper']:AddCircleZone("CayoPericoEnter", vector3(11063.0, 908.0, 2.0), 4000.0, {
		name="CayoPericoEnter",
		debugPoly = Config.Debug,
	})
	SetZoneEnabled(GetZoneFromNameId("PrLog"), false) -- Disables snow effect from the ungodly map above Cayo Perico
	ExtendWorldBoundaryForPlayer(-15000.0, -15000.0, -100.0)
	ExtendWorldBoundaryForPlayer(15000.0, 15000.0, 200.0)
end)

RegisterCommand('loadperico', function(source, args)
	LoadCayoPerico(true)
end)

RegisterCommand('unloadperico', function(source, args)
	UnloadCayoPerico()
end)

function LoadCayoPerico(skipCutscene)
	LocalPlayer.state:set('inCayoPerico', true, true)
	exports['polyzonehelper']:DeletePolyZone("CayoPericoEnter")
	exports['polyzonehelper']:AddCircleZone("CayoPericoExit", vector3(5165.83, -4968.83, 2.0), 4500.0, {
		name="CayoPericoExit",
		debugPoly = Config.Debug,
	})
	if not skipCutscene then
		DoCamTransition()
	end
	SetIslandHopperEnabled('HeistIsland', true)
	SetToggleMinimapHeistIsland(true)
	SetAiGlobalPathNodesType(true)
	SetScenarioGroupEnabled('Heist_Island_Peds', true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
	SetDeepOceanScaler(0.0)
	LoadGlobalWaterType(1)
	SetBlipHiddenOnLegend(cayoBlip, true)
	SetBlipAlpha(cayoBlip, 0)
	SetAudioFlag('PlayerOnDLCHeist4Island', true)
	for _, v in ipairs(Config.LoadOnEnter) do
		RequestIpl(v)
	end
	for _, v in ipairs(Config.UnloadOnEnter) do
		RemoveIpl(v)
	end
	TriggerEvent("IsInCayoPerico", true)
	TriggerServerEvent("IsInCayoPerico", true)
end

function UnloadCayoPerico()
	LocalPlayer.state:set('inCayoPerico', false, true)
	exports['polyzonehelper']:DeletePolyZone("CayoPericoExit")
	exports['polyzonehelper']:AddCircleZone("CayoPericoEnter", vector3(11063.0, 908.0, 2.0), 4000.0, {
		name="CayoPericoEnter",
		debugPoly = Config.Debug,
	})
	DoCamTransition()
	SetIslandHopperEnabled('HeistIsland', false)
	SetToggleMinimapHeistIsland(false)
	SetAiGlobalPathNodesType(false)
	SetScenarioGroupEnabled('Heist_Island_Peds', false)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', false, false)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', true, false)
	ResetDeepOceanScaler()
	LoadGlobalWaterType(0)
	SetAudioFlag('PlayerOnDLCHeist4Island', false)
	SetBlipHiddenOnLegend(cayoBlip, false)
	SetBlipAlpha(cayoBlip, 255)
	for _, v in ipairs(Config.UnloadOnEnter) do
		RequestIpl(v)
	end
	for _, v in ipairs(Config.LoadOnEnter) do
		RemoveIpl(v)
	end
	if cache.vehicle then
		QBCore.Functions.SetStateBag(cache.vehicle, 'pericoAllowed', false)
	end
	TriggerEvent("IsInCayoPerico", false)
	TriggerServerEvent("IsInCayoPerico", false)
end

AddEventHandler('polyzonehelper:enter', function(name)
	if LocalPlayer.state["isLoggedIn"] then
		if name == "CayoPericoEnter" then
			if PericoPerms() then
				LoadCayoPerico()
			end
		end  
	end
end)

AddEventHandler('polyzonehelper:exit', function(name)
	if LocalPlayer.state["isLoggedIn"] then
		if name == "CayoPericoExit" then
			UnloadCayoPerico()
		end
	end
end)

function PericoPerms()
	if QBCore.Functions.HasItem("pericopapers") then
		if cache.vehicle then
			QBCore.Functions.SetStateBag(cache.vehicle, 'pericoAllowed', true)
		end
		return true
	else
		Wait(2000) -- Grace period to check others
		if cache.vehicle then
			if Entity(cache.vehicle).state.pericoAllowed then
				return true
			else
				if cache.seat == -1 then
					SetVehicleOutOfControl(cache.vehicle, false, false)
					SetBoatIsSinking(cache.vehicle)
					SetVehicleDoorsLocked(cache.vehicle, 4)
					Wait(1000)
					SetVehicleDoorsLocked(cache.vehicle, 4)
					local coords = GetEntityCoords(cache.vehicle)
					AddExplosion(coords.x, coords.y, coords.z, 81, 25, true, false, 10)
				end
				SetEntityHealth(cache.ped, 0.0)
			end
		else
			local coords = GetEntityCoords(cache.ped)
			AddExplosion(coords.x, coords.y, coords.z, 81, 25, true, false, 10)
			SetEntityHealth(cache.ped, 0.0)
			return false
		end
	end
end

function DoCamTransition()
	local inCayoPerico = LocalPlayer.state.inCayoPerico or false
	local offset = inCayoPerico and cayoOffset or -cayoOffset
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		StopCamShaking(cam, true)
	end
	local seat = -2
	local entity = cache.vehicle or cache.ped
	local coords = GetEntityCoords(entity)
	local velocity = GetEntityVelocity(entity)
	local heading = GetEntityHeading(entity)
	local camOffset = GetOffsetFromEntityInWorldCoords(entity, 20.0, 50.0, 5.0)
	SetCamCoord(cam, camOffset)
	PointCamAtCoord(cam, coords)
	if cache.vehicle then -- If driver
		if cache.seat == -1 then
			TaskVehicleTempAction(cache.ped, cache.vehicle, 23, 5000)	
		end
	end
	DoScreenFadeOut(2000)
	Wait(2000)
	DetachCam(cam)
	SetCamActive(cam, false)
	RenderScriptCams(false, false, 0, 1, 0)
	DestroyCam(cam, false)
	if seat <= -1 then
		SetEntityCoordsNoOffset(entity, coords + offset)
		SetEntityHeading(heading)
		SetEntityVelocity(entity, velocity)
	end
	SetGameplayCamRelativeHeading(0.0)
	Wait(1000)
	ClearPedTasks(cache.ped)
	DoScreenFadeIn(2000)
	return true
end

RegisterNetEvent('prdx_perico:client:sendToPerico', function()
	LoadCayoPerico(true)
	FreezeEntityPosition(cache.ped, true)
	SetEntityCoords(cache.ped, 4442.47, -4467.95, 4.33)
	TriggerServerEvent("qb-apartments:returnBucket")
	Wait(1000)
	FreezeEntityPosition(cache.ped, false)
end)