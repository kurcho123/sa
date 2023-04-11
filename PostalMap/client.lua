local inVehicle = false

CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)

CreateThread(function()
    while true do
		Wait(0)
		if inVehicle then 
			SetRadarZoom(1200)
		else 
			SetRadarZoom(1100)
		end
    end
end)

AddEventHandler('QBCore:enteredVehicle', function (currentVehicle, currentSeat)
	if inVehicle then return end -- prevent duplicate loops
	inVehicle = true
end)

AddEventHandler('QBCore:leftVehicle', function ()
	inVehicle = false
end)