-- Get freecam object
local freecam = exports.freecam
local deleteCamActive = false
local maxDistance = 500
local maxDeleteTime = 5000
local FreeCamEnable = false

RegisterNetEvent("deletecam:toggle")
AddEventHandler("deletecam:toggle", function(freeCam)
	if freeCam then
		FreeCamEnable = not FreeCamEnable
		LocalPlayer.state:set("inv_busy", FreeCamEnable, true)
		freecam:SetEnabled(FreeCamEnable)
	else
		deleteCamActive = not deleteCamActive
		LocalPlayer.state:set("inv_busy", deleteCamActive, true)
		freecam:SetEnabled(deleteCamActive)
		clearActiveEntity()
	end
end)

Citizen.CreateThread(function()
	while true do Citizen.Wait(50)
		if deleteCamActive then
			local _, didHit, pos, surfaceNormal, entity = WhatAmILookingAt(maxDistance)
			if didHit and DoesEntityExist(entity) and GetEntityType(entity) ~= 0 then
				setActiveEntity(entity)
			else
				clearActiveEntity()
			end
		end
	end
end)

AddTextEntry("DELCAMH", "Delete Cam\nPress ~INPUT_CONTEXT~ to ~r~delete~w~ the selected object.\nPress ~INPUT_CHARACTER_WHEEL~ to move slowly.\nPress ~INPUT_JUMP~ to return to your character.")

-- Always be drawing the entity
Citizen.CreateThread(function()
	local screenX, screenY = GetActiveScreenResolution()
	local crosshairRes = GetTextureResolution("hud_reticle", "reticle_ar")
	local scaleX = crosshairRes.x/screenX
	local scaleY = crosshairRes.y/screenY

	while true do Citizen.Wait(0)
		if deleteCamActive then
			
			BeginTextCommandDisplayHelp("DELCAMH")
			EndTextCommandDisplayHelp(0, false, false, -1)

			if getActiveEntity() then
				DrawSprite("hud_reticle", "reticle_ar", 0.5, 0.5, scaleX, scaleY, 0.0, 255, 0, 0, 255)
			else
				DrawSprite("hud_reticle", "reticle_ar", 0.5, 0.5, scaleX, scaleY, 0.0, 255, 255, 255, 255)
			end
			doEntityDraw()
		end
	end
end)

-- Do delete on INPUT_CONTEXT
Citizen.CreateThread(function()
	local startedDeleting = false

	while true do Citizen.Wait(0)
		if deleteCamActive then
			if not startedDeleting and IsDisabledControlJustReleased(1, 51) then
				local ent = getActiveEntity()
				if ent then
					local id = NetworkGetNetworkIdFromEntity(ent)
					SetEntityAsMissionEntity(ent, true, true)
					DeleteEntity(ent)
					TriggerServerEvent('Deletecam:Delete', id)
				end
			end

			if IsDisabledControlJustPressed(1, 22) then
				ExecuteCommand("deletecam")
			end
		elseif FreeCamEnable then
			if IsDisabledControlJustPressed(1, 22) then
				ExecuteCommand("freecam")
			end
		end
	end
end)