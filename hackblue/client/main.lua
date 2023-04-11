local resultReceived = false
local passed = false 

RegisterNUICallback('callback', function(data, cb)
    SetNuiFocus(false, false)
    resultReceived = true
    if data.success then
        passed = true
    else
        passed = false
    end
    cb('ok')
end)

exports('StartHack', function(success, fail)
    resultReceived = false
    passed = false
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open"
    })
    while not resultReceived do
        Wait(0)
    end
    return passed
end)
