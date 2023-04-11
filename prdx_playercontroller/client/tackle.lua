local QBCore = exports['qb-core']:GetCoreObject()
local isLoggedIn = LocalPlayer.state.isLoggedIn

local function TackleAnim()
    local ped = PlayerPedId()
    if not QBCore.Functions.GetPlayerData().metadata["ishandcuffed"] and not IsPedRagdoll(ped) then
        if not HasAnimDictLoaded("swimming@first_person@diving") then
            RequestAnimDict("swimming@first_person@diving")
            while not HasAnimDictLoaded("swimming@first_person@diving") do
                Wait(10)
            end
        end
        if IsEntityPlayingAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
            ClearPedTasksImmediately(ped)
        else
            TaskPlayAnim(ped, "swimming@first_person@diving", "dive_run_fwd_-45_loop" ,3.0, 3.0, -1, 49, 0, false, false, false)
            Wait(250)
            ClearPedTasksImmediately(ped)
            SetPedToRagdoll(ped, 150, 150, 0, false, false, false)
        end
    end
end
local cooldown = false
local function Tackle()
    if not cooldown then
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) and GetEntitySpeed(ped) > 2.5 then
            local closestPlayer, distance = QBCore.Functions.GetClosestPlayer()
            local plyID = GetPlayerServerId(closestPlayer)
            if distance ~= -1 and distance < 2 and plyID then
                cooldown = true
                TriggerServerEvent("tackle:server:TacklePlayer", plyID)
                TackleAnim()
                SetTimeout(3500, function()
                    cooldown = false
                end)
            end
        end
    else
        QBCore.Functions.Notify('Too quick!', 'error')
    end
end
 
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('tackle:client:GetTackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(1000, 6000), math.random(1000, 6000), 0, false, false, false)
    TimerEnabled = true
    SetTimeout(1500, function ()
        TimerEnabled = false
    end)
end)

-- Keys --
RegisterCommand('+tacklePlayer', Tackle, false)
RegisterKeyMapping("+tacklePlayer", "Tackle (sprinting)", "keyboard", 'LMENU')
---