Citizen.CreateThread(function()

    while Config.RemoveHeadshots == false do
            Citizen.Wait(2000)
            SetPedSuffersCriticalHits(globalPed, false)
    end

end)