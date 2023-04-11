
local successCb
local failCb
local resultReceived = false
local passed = false
RegisterNUICallback('ThermiteResult', function(data, cb)
    SetNuiFocus(false, false)
    resultReceived = true
    if data.success then
        passed = true
    else
        passed = false
    end
    cb('ok')
end)

exports('StartHack', function(correctBlocks, incorrectBlocks, timetoShow, timetoLose, success, fail)
    -- correctBlocks = Number of correct blocks the player needs to click
    -- incorrectBlocks = number of incorrect blocks after which the game will fail
    -- timetoShow = time in secs for which the right blocks will be shown
    -- timetoLose = maximum time after timetoshow expires for player to select the right blocks
    resultReceived = false
    passed = false
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "Start",
        correct = correctBlocks,
        incorrect = incorrectBlocks,
        showtime = timetoShow,
        losetime = timetoLose + timetoShow,
    })
    while not resultReceived do
        Wait(0)
    end
    return passed
end)