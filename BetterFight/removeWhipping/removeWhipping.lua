Citizen.CreateThread(function()

    while(Config.RemovePistolWhipping)do
            if globalIsPedArmed then
                DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
            else
                Citizen.Wait(200)
            end
        Citizen.Wait(4)
    end

end)

local Blocking = 0 
local Cooldown = 0

CreateThread(function()
    while true do
        Wait(0)
        if IsPedInMeleeCombat(PlayerPedId()) then
            if IsControlPressed(0, 143) and Blocking <= 150 then -- Melee block
                Blocking = Blocking + 1
                Cooldown = 0
            elseif Blocking ~= 0 then
                Cooldown = Cooldown + 1
                if Cooldown == 125 then
                    Blocking = 0
                end
                DisableControlAction(0, 143, true)
            end
        end
    end
end)