
Citizen.CreateThread(function() 

	local first = true
	SetFlashLightKeepOnWhileMoving(true)
	-- while Config.UseVehicleViewCamForcer or Config.UseDisable3rdPersonShooting do
	-- 	ped = globalPlayerPedId

	-- 	if IsPedInAnyVehicle(PlayerPedId(), false) then
	-- 		if(first)then
	-- 			print('First')
	-- 			SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
	-- 			first = false
	-- 			Citizen.Wait(500)
	-- 			print('Past wait')
	-- 		end
	-- 		if globalGetCurrentWeapon ~= `WEAPON_UNARMED` then
	-- 			SetPedCurrentWeaponVisible(PlayerPedId(), true, false)
	-- 			if IsPlayerFreeAiming(PlayerId()) then
	-- 				print('Aiming')
	-- 				viewcamforcer = true
	-- 				Citizen.Wait(50)
	-- 				if(not aiming)then
	-- 					savedCam = GetFollowVehicleCamViewMode()
	-- 					print('Saving cam: ' .. tostring(savedCam))
	-- 				end
	-- 				aiming = true
	-- 				Citizen.Wait(Config.ViewCamForcerStartTime)
	-- 				print('Setting view')
	-- 				DisableAimCamThisUpdate()
	-- 				SetFollowVehicleCamViewMode(4)
	-- 			else
	-- 				if aiming == true then
	-- 					print('RESET VIEW')
	-- 					viewcamforcer = false
	-- 					Citizen.Wait(250)
	-- 					DisableAimCamThisUpdate()
	-- 					SetFollowVehicleCamViewMode(savedCam)
	-- 					aiming = false
	-- 				end
	-- 			end
	-- 		else
	-- 			Citizen.Wait(100)
	-- 		end
	-- 	else
	-- 		Citizen.Wait(500)
	-- 		first = true
	-- 		aiming = false
	-- 	end
	-- 	Citizen.Wait(100)
	-- end
end)

Citizen.CreateThread(function() 

	local first = true

	while Config.UseDisable3rdPersonShooting do
			ped = globalPlayerPedId
				if(viewCam ~= 4)then
					if globalGetCurrentWeapon ~= `WEAPON_UNARMED` then
							SetFollowPedCamViewMode(4)
					end
				end
			Citizen.Wait(100)
	end
end)


Citizen.CreateThread(function() 
	local aiming = false
	while Config.UseViewCamForcer and not Config.UseDisable3rdPersonShooting do
			ped = globalPlayerId
					if(globalIsPlayerFreeAiming)then
						viewcamforcer = true
						Citizen.Wait(10)
						if(not aiming)then
							savedCam = GetFollowPedCamViewMode()
						end
						aiming = true
						Citizen.Wait(Config.ViewCamForcerStartTime)
						SetFollowPedCamViewMode(4)
					elseif(aiming)then
						viewcamforcer = false
						Citizen.Wait(Config.ViewCamForcerFinishTime)
						SetFollowPedCamViewMode(savedCam)
						aiming = false
					else
						Citizen.Wait(100)
					end
	end
end)


Citizen.CreateThread(function() 
	local aiming2 = false
	while Config.RemoveCrosshairOnFirstPerson do
					if(globalIsPlayerFreeAiming and viewCam == 4)then
						Citizen.Wait(10)
						viewcamforcer = true
						aiming2 = true
					elseif(aiming2)then
						viewcamforcer = false
						aiming2 = false
					else
						Citizen.Wait(10)
					end
	end
end)

Citizen.CreateThread(function() 
	while Config.UseFirstJoinViewCamForcer and (Config.UseViewCamForcer or Config.UseDisable3rdPersonShooting or Config.UseVehicleViewCamForcer) do
		SetFollowPedCamViewMode(Config.DefaultViewCamModeOnFirstJoin)
		Citizen.Wait(200)
	end
end)