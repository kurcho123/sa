local FinishFunc

function OpenKeypad(finish)
    SendNUIMessage({
        action = "openKeypad",
    })
    SetNuiFocus(true, true)
    LocalPlayer.state:set("inv_busy", true, true) -- Busy
    FinishFunc = finish
end

RegisterNUICallback('TryCombination', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeKeypad",
        error = false,
    })
    if FinishFunc then
        FinishFunc(tonumber(data.combination))
    end
    LocalPlayer.state:set("inv_busy", false, true) -- Busy
end)

RegisterNUICallback('PadLockClose', function()
    SetNuiFocus(false, false)
    if FinishFunc then
        FinishFunc(false)
    end
end)

exports("OpenKeypad", OpenKeypad)
