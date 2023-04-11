local cruiseOn = false
local thisSpeed = 0.0
local OGSpeed = 0.0

RegisterCommand("limit", function(source, args)
	if IsPedInAnyVehicle(PlayerPedId()) then
		local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
		if GetVehicleClass(playerVeh) ~= 13 and GetVehicleClass(playerVeh) ~= 15 and GetVehicleClass(playerVeh) ~= 16 then
			if args[1] == nil then
				if cruiseOn == true then
					cruiseOn = false
					local tunedata = Entity(playerVeh).state.tunerData
                    if tunedata and tunedata ~= 'stock' and Config.TuningData[tunedata] then
                        SetVehicleMaxSpeed(playerVeh, Config.TuningData[tunedata].MaxSpeed/2.236936)
                    else
                        SetVehicleMaxSpeed(playerVeh, Config.MaxVehicleSpeed/2.236936)
                    end
					QBCore.Functions.Notify('Speed limiter removed!', "error")
				else
                    thisSpeed = GetEntitySpeed(playerVeh)
                    if thisSpeed * 2.236936 < 101 and thisSpeed > 0 then
                        cruiseOn = true
                        SetVehicleMaxSpeed(playerVeh, thisSpeed)
                        QBCore.Functions.Notify('Speed limiter set to ' .. math.ceil(thisSpeed * 2.236936) .. ' MPH', "success")
                    else
                        QBCore.Functions.Notify("You can only set the speed limiter from 1 - 100MPH", "error")
                    end
                end
			elseif (args[1] + 0) < 101 and (args[1] + 0) > 0 then
				cruiseOn = true
				thisSpeed = (args[1] - 0.6) / 2.2369
                SetVehicleMaxSpeed(playerVeh, thisSpeed)
				QBCore.Functions.Notify('Speed limiter set to: ' .. args[1] .. ' MPH', "success")
			elseif (args[1] + 0) > 101 or (args[1] + 0) < 0 then
				QBCore.Functions.Notify("You can only set the speed limiter from 1 - 100MPH", "error")
			end
		else
			QBCore.Functions.Notify("Speed limiter not available in this vehicle", "error")
		end
	end
end, false)

CreateThread(function()
    while true do
        Wait(0)
        if cruiseOn then
            -- reset when siren on or not in driver
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            if IsVehicleSirenOn(veh) or (GetPedInVehicleSeat(veh, -1) ~= PlayerPedId()) then
                cruiseOn = false
                local tunedata = Entity(veh).state.tunerData
                if tunedata and tunedata ~= 'stock' and Config.TuningData[tunedata] then
                    SetVehicleMaxSpeed(veh, Config.TuningData[tunedata].MaxSpeed/2.236936)
                else
                    SetVehicleMaxSpeed(veh, Config.MaxVehicleSpeed/2.236936)
                end
                QBCore.Functions.Notify('Speed limiter removed!', "error")
            else
                Wait(1000)
            end
            -- reset when leaving vehicle
            if not IsPedInAnyVehicle(PlayerPedId()) then
                cruiseOn = false
                local tunedata = Entity(veh).state.tunerData
                if tunedata and tunedata ~= 'stock' and Config.TuningData[tunedata] then
                    SetVehicleMaxSpeed(veh, Config.TuningData[tunedata].MaxSpeed/2.236936)
                else
                    SetVehicleMaxSpeed(veh, Config.MaxVehicleSpeed/2.236936)
                end
                QBCore.Functions.Notify('Speed limiter removed!', "error")
            else
                Wait(1000)
            end
        else
            Wait(1000)
        end
    end
end)

RegisterKeyMapping('limit', 'Toggle Speed Limiter', 'keyboard', 'Y')