viewcamforcer = false

CreateThread(function()
    while true do
        Wait(60000)
        collectgarbage("collect")
    end 
end)

CreateThread(function()
    while true do
        globalPed = GetPlayerPed(-1)
        globalPlayerPedId = PlayerPedId()
        globalPlayerId = PlayerId()
        Wait(3000)
    end
end)

CreateThread(function()
    while true do
        vehicleViewCam = GetFollowVehicleCamViewMode()
        viewCam = GetFollowPedCamViewMode()
        globalIsPedArmed = IsPedArmed(globalPlayerPedId, 6)
        globalIsPlayerFreeAiming = IsAimCamActive()
        Wait(50)
    end
end)

CreateThread(function()
    while true do
    globalIsPedInAnyVehicle = IsPedInAnyVehicle(globalPed,false)
    Wait(1000)
    end
end)

CreateThread(function()
    while true do
    _, globalGetCurrentWeapon = GetCurrentPedWeapon(globalPed, true)
    Wait(200)
    end
end)

