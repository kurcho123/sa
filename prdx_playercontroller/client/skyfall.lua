local isWingsuit = false

function DisplayHelpText(message)
	SetTextComponentFormat("STRING")
	AddTextComponentString(message)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterCommand("wingsuit", function(source, args, string)
	TriggerEvent('Wingsuit:DoFall')
end)

RegisterNetEvent('wingsuit:activated')
AddEventHandler('wingsuit:activated', function()
	if not isWingsuit then
		isWingsuit = true
		CreateThread(function()
			local playerPed = PlayerPedId()
			local playerPos = GetEntityCoords(playerPed)
			local timeout = 0
			GiveWeaponToPed(playerPed, joaat('gadget_parachute'), 1, true, true)
			SetPedGadget(playerPed,  joaat('gadget_parachute'), true)
			SetPlayerParachuteTintIndex(PlayerId(), 6)
			SetPlayerParachutePackTintIndex(PlayerId(), 2)

			TaskSkyDive(playerPed)
			--ForcePedMotionState(playerPed, -1161760501, 0, 0, 0)
			while (not IsPedInParachuteFreeFall(playerPed)) and timeout < 5000 do 
				Wait(100)
				timeout = timeout + 1
			end
			Wait(500)
			DisplayHelpText('Wingsuit ~g~DEPLOYED')

			SetPlayerInvincible(playerPed, true)
			SetEntityProofs(playerPed, true, true, true, true, true, false, 0, false)

			while true do
				if isWingsuit then			
					if IsPedInParachuteFreeFall(playerPed) and GetEntityHeightAboveGround(playerPed) > 25.0 then
						ApplyForceToEntity(playerPed, true, 0.0, 100.0, 2.0, 0.0, 0.0, 0.0, false, true, false, false, false, true)
					else
						DisplayHelpText('Wingsuit ~r~RETRACTED')
						isWingsuit = false
					end
				else
					break
				end
				Wait(0)
			end
			Wait(50) -- Maybe help a lil
			SetPlayerInvincible(playerPed, false)
			SetEntityProofs(playerPed, false, false, false, false, false, false, 0, false)
		end)
	end
end)