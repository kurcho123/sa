local QBCore = exports['qb-core']:GetCoreObject()
SetDefaultVehicleNumberPlateTextPattern(-1, 'AAAA1111')
CreateThread(function()
	for i, v in pairs(QBCore.Shared.Vehicles) do
		local text
		if v["brand"] then
			text = v["brand"] .. " " .. v["name"]
		else
			text = v["name"]
		end
		AddTextEntryByHash(v["hash"],text)
	end
end)

local inPlane = false

RegisterNetEvent('QBCore:enteredVehicle', function (currentVehicle, currentSeat)
    if IsPedInAnyPlane(cache.ped) then
        inPlane = true
        while inPlane do
            SetPlaneTurbulenceMultiplier(currentVehicle, 0.0)
            if GetEntityHeightAboveGround(currentVehicle) > 1.0 then
                if IsControlPressed(0, 88) then SetVehicleEngineOn(GetVehiclePedIsIn(ped, false), true, true, true) end
            end
            Wait(5) 
        end
    end
end)

RegisterNetEvent('QBCore:leftVehicle', function() -- Remove blips
    inPlane = false
end)