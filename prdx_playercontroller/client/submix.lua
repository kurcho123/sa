function EnableSubmix()
    SetAudioSubmixEffectRadioFx(0, 0)
    SetAudioSubmixEffectParamInt(0, 0, `default`, 1)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_low`, 100.0)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_hi`, 5000.0)
    SetAudioSubmixEffectParamFloat(0, 0, `rm_mix`, 0.1)
    SetAudioSubmixEffectParamFloat(0, 0, `fudge`, 1.0)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_low`, 300.0)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_hi`, 5000.0)
end

function DisableSubmix()
    SetAudioSubmixEffectRadioFx(0, 0)
    SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
end

local inHelicopter = false

RegisterNetEvent('QBCore:enteredVehicle', function (currentVehicle, currentSeat)
    local class = GetVehicleClass(currentVehicle)
    if class == 15 or class == 16 then
        inHelicopter = true
        local soundmix = false
        CreateThread(function()
            while inHelicopter do
                Wait(1000)
                if not GetIsVehicleEngineRunning(currentVehicle) then
                    DisableSubmix()
                    soundmix = false
                elseif not soundmix then
                    EnableSubmix()
                    soundmix = true
                end
            end
        end)
    end
end)

RegisterNetEvent('QBCore:leftVehicle', function() -- Remove blips
    if inHelicopter then
        inHelicopter = false
        DisableSubmix()
    end
end)