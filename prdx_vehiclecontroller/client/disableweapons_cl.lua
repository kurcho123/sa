-- Disable weapons on specified vehicles
-- Add vehicle + weapon in Config.DisableWeapons table
-- https://wiki.rage.mp/index.php?title=Weapons#Vehicle_weapon_names
CreateThread(function()
    local ped = PlayerPedId()
    while true do
        Wait(0)
        local vehicle = GetVehiclePedIsIn(ped)
        if vehicle and vehicle ~= 0 then
           for i=1, 5 do
                SetVehicleWeaponsDisabled(vehicle, i)
           end
        else
            Wait(700)
        end

    end
end)