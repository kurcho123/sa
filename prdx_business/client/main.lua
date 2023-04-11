QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}
PrevJob = {}

function DrawBlips()
    for k,v in pairs(Config.MapBlips) do
        if v.enabled then
            blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, v.sprite)
            SetBlipDisplay(blip, 2)
            SetBlipAsShortRange(blip, true)
            SetBlipScale(blip, 0.65)
            SetBlipColour(blip, v.color)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    print("PAYCHECK BUG (Player Loaded)", PlayerJob.name, PlayerJob.grade.name, PlayerJob.payment)
    Wait(1000)
    DrawBlips()
    -- SetupCrafting()
    SetupRegisters()
    SetupStorage()
    SetupClothing()
    SetupSeating()
    SetupBossMenus()
    SetupDutyLocations()
    SpawnRegisterProps()
    SetupElevators()
    SetupMobileOptions()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PrevJob = PlayerJob
    PlayerJob = JobInfo
    print("PAYCHECK BUG (Job Update)", PlayerJob.name, PlayerJob.grade.name, PlayerJob.payment)
    -- SetupCrafting()
end)

CreateThread(function() -- Live reboot
    if LocalPlayer.state['isLoggedIn'] and not Started then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        Wait(1000)
        DrawBlips()
        -- SetupCrafting()
        SetupRegisters()
        SetupStorage()
        SetupClothing()
        SetupSeating()
        SetupBossMenus()
        SetupDutyLocations()
        SpawnRegisterProps()
        SetupElevators()
        SetupMobileOptions()
    end
end)