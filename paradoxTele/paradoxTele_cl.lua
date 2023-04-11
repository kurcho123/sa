local illegalbanned = false
local loaded = true
local FromLocation = nil
local QBCore = exports['qb-core']:GetCoreObject()
local blackout = false
TriggerServerEvent('ParadoxTele:RequestBans')

RegisterNetEvent('prdx_staff:safety')
AddEventHandler('prdx_staff:safety', function(g)
	local ped = PlayerPedId()
	SetEntityCoords(ped, 374.97, -1611.75, 29.29, false, false, false, true)
end)

RequestIpl("apa_v_mp_h_05_a_purpside")

local LSRInterior = GetInteriorAtCoords(vec(995.53, -1848.83, -110.8))
ActivateInteriorEntitySet(LSRInterior, "door_blocker")
ActivateInteriorEntitySet(LSRInterior, "branded_style_set")
RefreshInterior(LSRInterior)

local function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    PushScaleformMovieMethodParameterButtonName(ControlButton)
end

local function setupScaleform(scaleform, itemString, button)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
	if button ~= nil then
		Button(GetControlInstructionalButton(2, 38, true))
	end
    ButtonMessage(itemString)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

function EnterExitInt(intLoc, intHead, veh)
	local tpMe = nil
	if veh then
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			tpMe = GetVehiclePedIsUsing(PlayerPedId())
		else
			tpMe = PlayerPedId()
		end
	else
		tpMe = PlayerPedId()
	end
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	BeginTextCommandBusyString("FMMC_PLYLOAD")
	EndTextCommandBusyString(4)
	DoScreenFadeOut(1000)
	LoadInterior(GetInteriorAtCoords(intLoc))
	Wait(1000)
	SetEntityCoords(tpMe, intLoc)
	SetEntityHeading(tpMe, intHead)
	PlaceObjectOnGroundProperly(tpMe)
	SetGameplayCamRelativeHeading(0.0)
	Wait(1000)
	RemoveLoadingPrompt()
	DoScreenFadeIn(2000)
	Wait(1000)
end

local whitelistJobs = {}
RegisterNetEvent('smalloRandom:Result')
AddEventHandler('smalloRandom:Result', function(Result)
    local usefulInfo = Result
    if usefulInfo ~= nil then
		whitelistJobs = usefulInfo
    end
end)

local createdBlips = {
	nil, nil, nil, nil, nil, nil, nil, nil
}

RegisterNetEvent('ParadoxTele:FromLocation')
AddEventHandler('ParadoxTele:FromLocation', function(Result)
	FromLocation = Result
end)

RegisterNetEvent('ParadoxTele:BannedPlayer')
AddEventHandler('ParadoxTele:BannedPlayer', function()
	illegalbanned = true
end)

function CreateBlips()
	for i = 1, #Config.DrugBlips do
		if not DoesBlipExist(createdBlips[i]) then
			createdBlips[i] = AddBlipForCoord(Config.DrugBlips[i])
			SetBlipSprite(createdBlips[i], 465)
			SetBlipDisplay(createdBlips[i], 9)
			SetBlipScale(createdBlips[i], 0.5)
			SetBlipColour(createdBlips[i], 1)
			SetBlipAsShortRange(createdBlips[i], true)
			BeginTextCommandSetBlipName("DrugsUnknown")
			EndTextCommandSetBlipName(createdBlips[i])
		end
	end
end

function DeleteBlips()
	for _, v in ipairs(createdBlips) do
		if v ~= nil then
			if DoesBlipExist(v) then
				RemoveBlip(v)
				v = nil
			end
		end
	end
end

CreateThread(function()
	AddTextEntry("DrugsUnknown", "Unknown")
    while true do
		Wait(3000)
		if next(whitelistJobs) ~= nil then
			if whitelistJobs.ems or whitelistJobs.leo then
				DeleteBlips()
			elseif illegalbanned == true then
				DeleteBlips()
			else
				CreateBlips()
			end
		end
	end
end)

AddStateBagChangeHandler('currentBlackout' --[[key filter]], nil --[[bag filter]], function(bagName, key, value, _unused, replicated)
    if value == nil or BlackoutOveride or inBucket then return end
    Blackout = value
end)

CreateThread(function()
	Wait(500)
	while true do Wait(0)
		for _, v in pairs(Config.telePoints) do
			if v.powerOffOnly and not blackout then goto skip_loop end
			-- Outside marker
			if not v.noOutsideMarker and #(GetEntityCoords(PlayerPedId()) - v.outVec) < 100.0 then
				if v.markerType ~= -1 then
					DrawMarker(v.markerType, v.outVec, v.markerDir, v.markerRot, v.markerScale, v.markerR, v.markerG, v.markerB, v.markerA, false, true, 2, false, false, false, false)
				end
				if #(GetEntityCoords(PlayerPedId()) - v.outVec) < v.markerScale.x then
					if not v.allowVehicle and IsPedInAnyVehicle(PlayerPedId(), true) then
						enterForm = setupScaleform("instructional_buttons", "You cannot use this in a vehicle")
					else
						enterForm = setupScaleform("instructional_buttons", v.outText, 38)
						if IsControlJustReleased(2, 38) then
							if v.AlertPolice then
								local data = exports['cd_dispatch']:GetPlayerInfo()
								TriggerServerEvent('cd_dispatch:TeleportAlert', data, v.outVec)
							end
							EnterExitInt(v.inVec, v.inHead, v.allowVehicle)
						end
					end
					DrawScaleformMovieFullscreen(enterForm, 255, 255, 255, 255, 0)
				end
			end

			-- Inside marker
			if #(GetEntityCoords(PlayerPedId()) - v.inVec) < 100.0 then
				----print('I am inside')
				if v.markerType ~= -1 then
					DrawMarker(v.markerType, v.inVec, v.markerDir, v.markerRot, v.markerScale, v.markerR, v.markerG, v.markerB, v.markerA, false, false, 2, false, false, false, false)
				end
				if #(GetEntityCoords(PlayerPedId()) - v.inVec) < 2.0 then
					if not v.allowVehicle and IsPedInAnyVehicle(PlayerPedId(), true) then
						enterForm = setupScaleform("instructional_buttons", "You cannot use this in a vehicle")
					else
						enterForm = setupScaleform("instructional_buttons", v.inText, 38)
						if IsControlJustReleased(2, 38) then
							EnterExitInt(v.outVec, v.outHead, v.allowVehicle)
						end
					end
					DrawScaleformMovieFullscreen(enterForm, 255, 255, 255, 255, 0)
				end
			end

			::skip_loop::
			
		end
	end
end)

-- Swanson Officer Interior and other IPLs
CreateThread(function()
	RequestIpl("server_farm_milo_")
	local interiorProps = {"interior_upgrade", "equipment_upgrade", "security_high", "chair01", "chair02", "chair03", "chair04", "chair05", "chair06", "chair07"}
	local interior1 = GetInteriorAtCoords(vec3(-183.33, 6255.54, -110.45))
	local interior2 = GetInteriorAtCoords(vec3(915.15, -1496.13, -18.6))

	for k, v in ipairs(interiorProps) do
		EnableInteriorProp(interior1, v)
		EnableInteriorProp(interior2, v)
	end

	RefreshInterior(interior1)
	RefreshInterior(interior2)
end)