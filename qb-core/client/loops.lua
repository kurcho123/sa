local parched

CreateThread(function()
    local timeout = QBCore.Config.StatusInterval
    while true do
        Wait(timeout)

        if IsLoggedIn then
            if (QBCore.PlayerData.metadata.hunger <= 0 or QBCore.PlayerData.metadata.thirst <= 0) and not QBCore.PlayerData.metadata.isdead then
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                parched = true
                SetEntityHealth(ped, currentHealth - 4) -- 60 seconds to die
                if QBCore.PlayerData.metadata['hunger'] <= 0 then
                    QBCore.Functions.Notify('You are starving, you should eat something!', 'error')
                    SetTimecycleModifier("damage")
                    SetTimecycleModifierStrength(1.0)
                else
                    QBCore.Functions.Notify('You are thirsty, you should drink something!', 'error')
                    SetTimecycleModifier("damage")
                    SetTimecycleModifierStrength(1.0)
                end
            else 
                --run this once with a check
                if parched then
                    parched = false
                    ClearTimecycleModifier("damage")
                end
            end
        end
    end
end)
