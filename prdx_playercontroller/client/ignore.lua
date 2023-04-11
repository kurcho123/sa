local PermsGroup = nil
local maxTaserCarts = 2 -- The amount of taser cartridges a person can have.
local PlayerJob = nil
local taserCartsLeft = 2
local inVehicle = false
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent("FillTaser")
AddEventHandler("FillTaser",function(source, args, rawCommand)
	QBCore.Functions.Progressbar("load_tazer", "Reloading Taser..", 2000, false, true, {
		disableMovement = false,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "anim@weapons@pistol@singleshot_str",
		anim = "reload_aim",
		flags = 48,
	}, {}, {}, function() -- Done
	
		
		taserCartsLeft = maxTaserCarts
		TriggerServerEvent("prdx_playercontroller:server:removeTaserAmmo")
	end)
end)  

local taserModel = joaat("WEAPON_STUNGUN")

CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        if GetSelectedPedWeapon(ped) == taserModel then
			DisplayAmmoThisFrame(true)
            if IsPedShooting(ped) then
                taserCartsLeft = taserCartsLeft - 1
            end
        end
		DistantCopCarSirens(false)
        if taserCartsLeft <= 0 then
            if GetSelectedPedWeapon(ped) == taserModel then
				DisplayAmmoThisFrame(false)
                SetPlayerCanDoDriveBy(PlayerId(), false)
                DisablePlayerFiring(PlayerId(), true)
                if IsControlJustPressed(0, 106) then
                    QBCore.Functions.Notify("You need to reload your taser!", "error")
                end
            end
        end

    end
end)

CreateThread(function() -- all these should only need to be called once
	local player = PlayerId()
	local ped = PlayerPedId()
	StopAudioScenes()
	StatSetInt('MP0_STAMINA', 25, true)
	StatSetInt('MP0_LUNG_CAPACITY', 75, true)
	SetAudioFlag("DisableFlightMusic", true)
    SetAudioFlag("PoliceScannerDisabled", true)
	SetGarbageTrucks(false)
	SetCreateRandomCops(false)
	SetCreateRandomCopsNotOnScenarios(false)
	SetCreateRandomCopsOnScenarios(false)
	SetDispatchCopsForPlayer(player, false)
	RemoveVehiclesFromGeneratorsInArea(335.2616 - 300.0, -1432.455 - 300.0, 46.51 - 300.0, 335.2616 + 300.0, -1432.455 + 300.0, 46.51 + 300.0) -- central los santos medical center
	RemoveVehiclesFromGeneratorsInArea(441.8465 - 500.0, -987.99 - 500.0, 30.68 -500.0, 441.8465 + 500.0, -987.99 + 500.0, 30.68 + 500.0) -- police station mission row
	RemoveVehiclesFromGeneratorsInArea(316.79 - 300.0, -592.36 - 300.0, 43.28 - 300.0, 316.79 + 300.0, -592.36 + 300.0, 43.28 + 300.0) -- pillbox
	RemoveVehiclesFromGeneratorsInArea(-2150.44 - 500.0, 3075.99 - 500.0, 32.8 - 500.0, -2150.44 + 500.0, -3075.99 + 500.0, 32.8 + 500.0) -- military
	RemoveVehiclesFromGeneratorsInArea(-1108.35 - 300.0, 4920.64 - 300.0, 217.2 - 300.0, -1108.35 + 300.0, 4920.64 + 300.0, 217.2 + 300.0) -- nudist
	RemoveVehiclesFromGeneratorsInArea(-458.24 - 300.0, 6019.81 - 300.0, 31.34 - 300.0, -458.24 + 300.0, 6019.81 + 300.0, 31.34 + 300.0) -- police station paleto
	RemoveVehiclesFromGeneratorsInArea(1854.82 - 300.0, 3679.4 - 300.0, 33.82 - 300.0, 1854.82 + 300.0, 3679.4 + 300.0, 33.82 + 300.0) -- police station sandy
	RemoveVehiclesFromGeneratorsInArea(-724.46 - 300.0, -1444.03 - 300.0, 5.0 - 300.0, -724.46 + 300.0, -1444.03 + 300.0, 5.0 + 300.0) -- REMOVE CHOPPERS WOW
	RemoveVehiclesFromGeneratorsInArea(-1919.64 - 10.0, 3035.57 - 10.0, 47.03 - 10.0, -1919.64 + 10.0, 3035.57 + 10.0, 47.03 + 10.0)
	RemoveVehiclesFromGeneratorsInArea(555.18, -131.03, 65.0, 501.18, -242.54, 45.0, 0)
	RemoveVehiclesFromGeneratorsInArea(-29.68, -927.0, 90.0, -166.61, -1002.0, 0.00)
	RemoveVehiclesFromGeneratorsInArea(1083.88, 2676.09, 52.63, 1160.16, 2621.43, 34.34, 0) -- Harmony PD
	RemoveVehiclesFromGeneratorsInArea(1205.85, -1509.13, 32.55, 1239.52, -1535.46, 55.35, 0) -- ELS FD
	RemoveVehiclesFromGeneratorsInArea(2306.6526, 4660.7344, 302.4035, 207.1569, 3463.5022, -191.3075) -- ALAMO ICE
	RemoveVehiclesFromGeneratorsInArea(-582.98, 177.85, 62.35, -638.29, 204.39, 76.61) -- Chaotek
	for i = 1, 15 do
		EnableDispatchService(i, false)
	end
	SetMaxWantedLevel(0)
	DisableIdleCamera(true)
	for pedmdl, v in pairs(QBCore.Shared.BlacklistedPeds) do
		SetPedModelIsSuppressed(pedmdl, true)
	end
	Wait(250)
	for carmdl, v in pairs(QBCore.Shared.BlockedSpawns) do
		SetVehicleModelIsSuppressed(carmdl, true)
	end
	Wait(250)
	for _, sctyp in next, Config.BlacklistedScenarios['TYPES'] do
		SetScenarioTypeEnabled(sctyp, false)
	end
	Wait(250)
	for _, scgrp in next, Config.BlacklistedScenarios['GROUPS'] do
		SetScenarioGroupEnabled(scgrp, false)
	end
	Wait(250)
	for _, pickup in pairs(Config.Pickups) do
		ToggleUsePickupsForPlayer(player, pickup, false)
	end
end)

local effect = false
CreateThread(function()
	while true do
		Wait(1)
		local ped = PlayerPedId()
		if IsPedBeingStunned(ped) then
			if not PlayerJob then
				PlayerJob = QBCore.Functions.GetPlayerData().job.name
			end
			if PlayerJob == "lspd" or PlayerJob == "bcso" or PlayerJob == "sast" or PlayerJob == "hc" or PlayerJob == "marshalls" or PlayerJob == "pd_cid" then 
				SetPedMinGroundTimeForStungun(ped, math.random(3000, 4000))
			else
				SetPedMinGroundTimeForStungun(ped, math.random(6000, 8000))
			end
		end
	end
end)

-- CreateThread(function()
--     while true do
--         local ped = PlayerPedId()
--         local weapon = GetSelectedPedWeapon(ped)
-- 		if weapon ~= `WEAPON_UNARMED` then
-- 			if IsPedArmed(ped, 6) then
-- 				DisableControlAction(1, 140, true)
-- 				DisableControlAction(1, 141, true)
-- 				DisableControlAction(1, 142, true)
-- 			end

-- 			if weapon == `WEAPON_FIREEXTINGUISHER` or  weapon == `WEAPON_PETROLCAN` then
-- 				if IsPedShooting(ped) then
-- 					SetPedInfiniteAmmo(ped, true, `WEAPON_FIREEXTINGUISHER`)
-- 					SetPedInfiniteAmmo(ped, true, `WEAPON_PETROLCAN`)
-- 				end
-- 			end
-- 		else
-- 			Wait(500)
-- 		end
--         Wait(7)
--     end
-- end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('prdx_playercontroller:server:GetPermissions', function(UserGroup)
        PermsGroup = UserGroup
		LocalPlayer.state:set('PermsGroup', UserGroup, false)
    end)
	DistantCopCarSirens(false)
	SetPlayerCanDoDriveBy(PlayerId(), true)
	StatSetInt('MP0_STAMINA', 25, true)
	StatSetInt('MP0_LUNG_CAPACITY', 75, true)
end)

RegisterNetEvent('QBCore:Client:OnPermissionUpdate')
AddEventHandler('QBCore:Client:OnPermissionUpdate', function(UserGroup)
    PermsGroup = UserGroup
	LocalPlayer.state:set('PermsGroup', UserGroup, false)
end)

RegisterNetEvent("prdx_playercontroller:client:CopyToClipboard", function(text)
	SendNUIMessage({
		text = text
	})
end)

CreateThread(function()
	while true do 
		if LocalPlayer.state['isLoggedIn'] then
			playerPed = PlayerPedId()
			if not PermsGroup then
				QBCore.Functions.TriggerCallback('prdx_playercontroller:server:GetPermissions', function(UserGroup)
					PermsGroup = UserGroup
					print('[Perms] Perm update requested')
				end)
			else
				if PermsGroup.staff.moderator or PermsGroup.staff.staff or PermsGroup.staff.admin or PermsGroup.staff.headadmin or PermsGroup.staff.director or PermsGroup.serverOne.vip2 or PermsGroup.serverOne.vip3 then
					--nada
				else
					for k, v in pairs(Config.BlacklistedWeapons) do
						if HasPedGotWeapon(playerPed, k, false) and not QBCore.Shared.DevMode then
							RemoveWeaponFromPed(playerPed, k)
							TriggerServerEvent('prdx_playercontroller:server:removeWeapon', QBCore.Shared.Weapons[k].name)
							TriggerServerEvent('PlayerController:HB:Detect', k)
						end
					end	
				end
			end
		end
		Wait(25000)

	end
end)


RegisterCommand('clearprops', function(source)
	local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	local object = nil
	local playerentity = GetPlayerPed(PlayerPedId())
	local Props = GetGamePool('CObject')
	for k, v in pairs(Props) do
		if IsEntityAttachedToAnyPed(v) then QBCore.Functions.DeleteEntity(v) end
	end
end)