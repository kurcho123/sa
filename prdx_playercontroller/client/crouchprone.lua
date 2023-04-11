local walkSet = "default"

RegisterNetEvent('crouchprone:client:SetWalkSet', function(clipset)
    walkSet = clipset
	SetPedMovementClipset(PlayerPedId(), clipset, 0.2)
end)

function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Wait(1)
    end 
end

CreateThread(function()
	local stage = 0
	local timer = 0

	local function notify(text)
		SetTextComponentFormat('STRING')
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, 0, 1, -1)
	end
	
	local function reset()
		TriggerEvent('scully_emotemenu:refreshWalk')
	end
	
	while true do
		Wait(1)
		local playerped = PlayerPedId()
		local player = GetPlayerIndex()
		if IsPedOnFoot(playerped) and not IsPedJumping(playerped) and not IsPedFalling(playerped) then
			if IsControlJustReleased(0,  36) then
				stage = stage + 1
				if stage >= 3 then
					stage = 0
                    reset()
				end
			end	
			
			if stage == 2 then
				SetPedCanPlayAmbientAnims(playerped, false)
				SetPedCanPlayAmbientBaseAnims(playerped, false)
				SetPedStealthMovement(playerped, false, "DEFAULT_ACTION")
				if (GetFollowPedCamViewMode() == 4) then
					SetFollowPedCamViewMode(0)
				end
				while not HasAnimSetLoaded('move_ped_crouched') do
					Wait(0)
					RequestAnimSet('move_ped_crouched')
				end
				SetPedUsingActionMode(playerped, false, -1, "DEFAULT_ACTION")
				SetPedMovementClipset(playerped, 'move_ped_crouched', 0.55)
				SetPedStrafeClipset(playerped, 'move_ped_crouched_strafing')
				SetWeaponAnimationOverride(playerped, "Ballistic")
				
				if IsPlayerFreeAiming(player) or IsAimCamActive() or IsAimCamThirdPersonActive() then
					SetPedMaxMoveBlendRatio(playerped, 0.2)
				else
					SetPedMaxMoveBlendRatio(playerped, 10.0)
				end
			else
				if IsPlayerFreeAiming(player) then
					SetPedMaxMoveBlendRatio(playerped, 1.0)
				else
					if IsAimCamActive() or IsAimCamThirdPersonActive() then
						SetPedMaxMoveBlendRatio(playerped, 10.0)
					else
						SetPedMaxMoveBlendRatio(playerped, 10.0)	
					end
				end
			end
		end
	end
end)