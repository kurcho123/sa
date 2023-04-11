local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	local bones = {
        'wheel_lf',
        'wheel_rf',
        'wheel_lr',
        'wheel_rr',
	}
	exports['qb-target']:AddTargetBone(bones, {
		options = {
		{
			type = "client",
			event = "PopTyre",
			label = "Pop Tyre/Tire",
			canInteract = function()
                local ped = PlayerPedId()
                local _, currentWeapon = GetCurrentPedWeapon(ped)
				return currentWeapon == `WEAPON_KNIFE`
			end
		}
	},
		distance = 1.0,
	})
end)

AddEventHandler('PopTyre', function(data)
    DoPop(data.entity)
end)

function DoPop(entity)
	local ped = PlayerPedId()
    local myCoords = GetEntityCoords(ped)
    local veh = entity
    local wheelPosFL = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "wheel_lf"))
    local wheelPosFR = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "wheel_rf"))
    local wheelPosRL = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "wheel_lr"))
    local wheelPosRR = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "wheel_rr"))
    
    if #(myCoords - wheelPosFL) < 1.5 and not IsVehicleTyreBurst(veh, 0, false) then
        PopTyre(0, wheelPosFL, veh)
    elseif #(myCoords - wheelPosFR) < 1.5 and not IsVehicleTyreBurst(veh, 1, false) then
        PopTyre(1, wheelPosFR, veh)
    elseif #(myCoords - wheelPosRL) < 1.5 and not IsVehicleTyreBurst(veh, 4, false) then
        PopTyre(4, wheelPosRL, veh)
    elseif #(myCoords - wheelPosRR) < 1.5 and not IsVehicleTyreBurst(veh, 5, false) then
        PopTyre(5, wheelPosRR, veh)
    end
end

local animations = {dict = "move_crouch_proto", anim = "idle"}
function PopTyre(tyre, tyrePos, veh)
	local ped = PlayerPedId()
	TaskTurnPedToFaceCoord(ped, tyrePos, 1000)
	Wait(1000)
	QBCore.Functions.RequestAnimDict(animations.dict)
	TaskPlayAnim(ped, animations.dict, animations.anim, 8.0, 5.0, -1, true, 1, 0, 0, 0)
    QBCore.Functions.Progressbar("pop_tyre", "Popping Tyre", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        SetVehicleTyreBurst(veh, tyre, true, 1000.0)
        ClearPedTasks(ped)
        RemoveAnimDict(animations.dict)    
    end, function() -- Cancel
    end)
end