local QBCore = exports["qb-core"]:GetCoreObject()

local function findVehFromPlateAndLocate(plate)
	local gameVehicles = QBCore.Functions.GetVehicles()
	for i = 1, #gameVehicles do
		local vehicle = gameVehicles[i]
		if DoesEntityExist(vehicle) then
			if QBCore.Functions.GetPlate(vehicle) == plate then
				local vehCoords = GetEntityCoords(vehicle)
				SetNewWaypoint(vehCoords.x, vehCoords.y)
				return true
			end
		end
	end
end

RegisterNUICallback("npwd:qb-garage:getVehicles", function(_, cb)
	TriggerServerEvent("npwd:qb-garage:getVehicles")

	RegisterNetEvent("npwd:qb-garage:sendVehicles", function(vehicles)
		for _, v in pairs(vehicles) do
			local vehicleModel = v.vehicle
			local type = GetVehicleClassFromName(vehicleModel)
			if type == 15 or type == 16 then
				v.type = "aircraft"
			elseif type == 14 then
				v.type = "boat"
			elseif type == 13 or type == 8 then
				v.type = "bike"
			else
				v.type = "car"
			end
			if v.state == 0 then
				v.state = "out"
			elseif v.state == 1 then
				v.state = "garaged"
			elseif v.state == 2 then
				v.state = "impounded"
			end
			if (QBCore.Shared.Vehicles[vehicleModel] ~= nil) and (Garages[v.garage] ~= nil) then
				v.garageLabel = Garages[v.garage].label
				v.vehicle = QBCore.Shared.Vehicles[vehicleModel].name
				v.brand = QBCore.Shared.Vehicles[vehicleModel].brand
			end
		end

		cb({ status = "ok", data = vehicles })
	end)
end)

RegisterNUICallback("npwd:qb-garage:requestWaypoint", function(data, cb)
	local plate = data.plate
	local state = data.state
	local garage = data.garage
	if findVehFromPlateAndLocate(plate) then
		QBCore.Functions.Notify("Your vehicle has been marked", "success")
	else
		if state == "garaged" then
			QBCore.Functions.Notify("This vehicle is located at the marked garage", "info")
			SetNewWaypoint(Garages[garage]['ParkingSpots'][1].x, Garages[garage]['ParkingSpots'][1].y)
		elseif state == "impounded" then
			QBCore.Functions.Notify("This vehicle is located at the impound", "info")
		else
			QBCore.Functions.Notify("This vehicle is not close enough to locate! You could also check the impound!", "error")
		end
	end
	cb({})
end)

RegisterNUICallback("npwd:qb-garage:reportStolen", function(data, cb)
	local plate = data.plate
	TriggerServerEvent("npwd:qb-garage:getVehicles")
	RegisterNetEvent("npwd:qb-garage:sendVehicles", function(vehicles)
		local found = false
		for k,v in pairs(vehicles) do
			if v.plate == plate then
				found = v.vehicle
				break
			end
		end
		if found then
			local hash = tostring(joaat(found))
			local img = exports.vImageCreator:GetModelImage(hash)
			TriggerServerEvent('npwd:qb-garage:reportStolen', plate, img)
		end
		cb({})
	end)
end)