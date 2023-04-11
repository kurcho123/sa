Citizen.CreateThread( function()

	local resetcounter = 0
	local jumpDisabled = false
  	
	while Config.JumpSpamPrevention do 
		Citizen.Wait(100)
			if(not globalIsPedInAnyVehicle)then
				if jumpDisabled and resetcounter > 0 and IsPedJumping(globalPed) then
					if not IsPedClimbing(globalPed) then
						SetPedToRagdoll(globalPed, 1000, 1000, 3, 0, 0, 0)

						resetcounter = 0
					end
				end

				if not jumpDisabled and IsPedJumping(globalPed) then
					if not IsPedClimbing(globalPed) then
						jumpDisabled = true
						resetcounter = Config.JumpSpamPreventionTimer / 100
						Citizen.Wait(1000)
					end
				end

				if resetcounter > 0 then
					resetcounter = resetcounter - 1
				else
					if jumpDisabled then
						resetcounter = 0
						jumpDisabled = false
					end
				end
			else
				Citizen.Wait(500)
			end
	end
end)