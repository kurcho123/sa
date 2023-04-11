
local CurrentVehicle
local CurrentVehicleNet
local CurrentSeat
local CurrentlySpeeding
local TrailerRun = false

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		if vehicle > 0 then
			local retval, Trailer = GetVehicleTrailerVehicle(vehicle)
			if not CurrentSeat or GetPedInVehicleSeat(vehicle, CurrentSeat) ~= ped then
				for i = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
					if GetPedInVehicleSeat(vehicle, i) == ped then
						TriggerEvent('QBCore:vehicleChangedSeat', vehicle, i, CurrentSeat)
						if i == -1 then -- in drivers
							TriggerEvent('QBCore:drivingVehicle', true, vehicle)
						elseif CurrentSeat == -1 then -- was in drivers
							TriggerEvent('QBCore:drivingVehicle', false, vehicle)
						end
						CurrentSeat = i
						break
					end
				end
			end			
			
			if CurrentSeat and CurrentSeat == -1 and Trailer and Trailer > 0 and not NetworkHasControlOfEntity(Trailer) then
				NetworkRequestControlOfEntity(Trailer)
			end


			local currentSpeed = GetEntitySpeed(vehicle) -- * 2.236936
			if currentSpeed > 38 and not CurrentlySpeeding then -- ~85mph
				CurrentlySpeeding = true
				TriggerEvent('QBCore:vehicleSpeeding', true, vehicle, CurrentSeat, currentSpeed)
			elseif CurrentlySpeeding and currentSpeed < 38 then
				CurrentlySpeeding = false
				TriggerEvent('QBCore:vehicleSpeeding', false, vehicle, CurrentSeat, currentSpeed)
			end

			if not CurrentVehicle then
				CurrentVehicle = vehicle
				CurrentVehicleNet = VehToNet(CurrentVehicle)
				TriggerEvent('QBCore:enteredVehicle', CurrentVehicle, CurrentSeat, CurrentVehicleNet)
			end

		elseif CurrentVehicle then
			if CurrentSeat == -1 then -- was in drivers
				TriggerEvent('QBCore:drivingVehicle', false, CurrentVehicle)
			end
			TriggerEvent('QBCore:leftVehicle', CurrentVehicle, CurrentSeat, CurrentVehicleNet)
			CurrentlySpeeding = false
			CurrentVehicleNet = false
			CurrentVehicle = false
			CurrentSeat = false
			TrailerRun = false
			Wait(500) -- Wait 1/2 second for cleanup
		end

		Wait(100)
	end
end)