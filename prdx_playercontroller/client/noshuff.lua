local disableShuffle = true
local inVehicle = false
local currentSeat = -2

function ShuffThread(veh)
    while inVehicle and currentSeat == 0 do
        Wait(0)
        local ped = PlayerPedId()
        if GetIsTaskActive(ped, 165) and disableShuffle then
            SetPedConfigFlag(ped, 184, true)
            SetPedIntoVehicle(ped, veh, 0)
        end
    end
end

RegisterNetEvent('QBCore:enteredVehicle', function (currentVehicle, updatedSeat)
    if inVehicle then return end
    inVehicle = true
    currentSeat = updatedSeat
    if currentSeat == 0 then
        ShuffThread(currentVehicle)
    end
end)

RegisterNetEvent('QBCore:leftVehicle', function ()
	inVehicle = false
    currentSeat = -2
end)

RegisterNetEvent('QBCore:vehicleChangedSeat', function(currentVehicle, seat, PreviousSeat)
    if not inVehicle then return end -- prevent duplicate loops
    currentSeat = seat
    if currentSeat == 0 then
        ShuffThread(currentVehicle, seat)
    end
end)

RegisterCommand("shuff", function(source, args, raw)
    disableShuffle = false
    Wait(10)
    SetPedConfigFlag(PlayerPedId(), 184, false)
    SetTimeout(3000, function()
        disableShuffle = true
    end)
end)