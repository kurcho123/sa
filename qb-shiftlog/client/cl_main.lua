local QBCore = exports['qb-core']:GetCoreObject() -- We've ALWAYS got to grab our core object

local currentjob = {}

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	local Player = QBCore.Functions.GetPlayerData()
    local job = Player.job.name
    currentjob = job
    if Config.ShiftJobs[job] then
        TriggerServerEvent("qb-shiftlog:userjoined", job)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    if Config.ShiftJobs[currentjob] then
        TriggerServerEvent("qb-shiftlog:jobchanged")
    end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    Wait(100)
    if currentjob ~= job.name then
        TriggerServerEvent("qb-shiftlog:jobchanged", job.name)
        currentjob = job.name
    end
end)


AddEventHandler('onResourceStart', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        Wait(2500)
        if LocalPlayer.state.isLoggedIn then
            local Player = QBCore.Functions.GetPlayerData()
            local job = Player.job.name
            currentjob = job
            if Config.ShiftJobs[job] then
                TriggerServerEvent("qb-shiftlog:userjoined", job)
            end
        end
    end
end)