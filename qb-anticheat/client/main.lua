local QBCore = exports['qb-core']:GetCoreObject()
local group = Config.Group

-- Check if is decorating --

local IsDecorating = false

RegisterNetEvent('qb-anticheat:client:ToggleDecorate', function(bool)
  IsDecorating = bool
end)

-- Few frequently used locals --

local flags = 0

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-anticheat:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    IsDecorating = false
    flags = 0
end)

-- Superjump --

CreateThread(function()
	while true do
        Wait(500)

        local ped = PlayerPedId()
        local player = PlayerId()

        if group == Config.Group and LocalPlayer.state.isLoggedIn then
            if IsPedJumping(ped) then
                local firstCoord = GetEntityCoords(ped)

                while IsPedJumping(ped) do
                    Wait(0)
                end

                local secondCoord = GetEntityCoords(ped)
                local lengthBetweenCoords = #(firstCoord - secondCoord)

                if (lengthBetweenCoords > Config.SuperJumpLength) then
                    flags = flags + 1
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "**" .. GetPlayerName(player) .. "** is flagged from anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Superjump)**", false, GetPlayerServerId(player))
                end
            end
        end
    end
end)

-- Speedhack --

CreateThread(function()
	while true do
        Wait(500)

        local ped = PlayerPedId()
        local player = PlayerId()
        local speed = GetEntitySpeed(ped)
        local inveh = IsPedInAnyVehicle(ped, false)
        local ragdoll = IsPedRagdoll(ped)
        local jumping = IsPedJumping(ped)
        local falling = IsPedFalling(ped)

        if group == Config.Group and LocalPlayer.state.isLoggedIn then
            if not inveh then
                if not ragdoll then
                    if not falling then
                        if not jumping then
                            if speed > Config.MaxSpeed then
                                flags = flags + 1
                                TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "**" ..GetPlayerName(player).. "** is flagged from anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Speedhack)**", false, GetPlayerServerId(player))
                            end
                        end
                    end
                end
            end
        end
    end
end)


-- Nightvision --

-- CreateThread(function()
--     while true do
--         Wait(2000)

--         local ped = PlayerPedId()
--         local player = PlayerId()

--         if group == Config.Group and LocalPlayer.state.isLoggedIn then
--             if GetUsingnightvision(true) then
--                 if not IsPedInAnyHeli(ped) then
--                     flags = flags + 1
--                     TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "**" ..GetPlayerName(player).. "** is flagged from anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Nightvision)**", false, GetPlayerServerId(player))
--                 end
--             end
--         end
--     end
--end)

-- Thermalvision --

CreateThread(function()
    while true do
        Wait(2000)

        local ped = PlayerPedId()

        if group == Config.Group and LocalPlayer.state.isLoggedIn then
            if GetUsingseethrough(true) then
                if not IsPedInAnyHeli(ped) then
                    flags = flags + 1
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheat detected!", "orange", "**" ..GetPlayerName(player).. "** is flagged from anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Thermalvision)**", false, GetPlayerServerId(player))
                end
            end
        end
    end
end)

-- Spawned car --

local function trim(plate)
    if not plate then return nil end
    return (string.gsub(plate, '^%s*(.-)%s*$', '%1'))
end

-- Check if ped has weapon in inventory --
--[[ local cooldown = false
CreateThread(function()
    while true do
        Wait(30000)
        if LocalPlayer.state.isLoggedIn then
            local PlayerPed = PlayerPedId()
            local player = PlayerId()
            local CurrentWeapon = GetSelectedPedWeapon(PlayerPed)
            local WeaponInformation = QBCore.Shared.Weapons[CurrentWeapon]
            if WeaponInformation then
                if WeaponInformation["name"] ~= "weapon_unarmed" and WeaponInformation["name"] ~= "weapon_animal" and WeaponInformation["name"] ~= "weapon_cougar" then
                    QBCore.Functions.TriggerCallback('qb-anticheat:server:HasWeaponInInventory', function(HasWeapon)
                        if not HasWeapon then
                            RemoveAllPedWeapons(PlayerPed, false)
                            Wait(5000)
                        end
                    end, WeaponInformation)
                end
            end
        end
    end
end) ]]

-- Max flags reached = ban, log, explosion & break --

CreateThread(function()
    while true do
        Wait(500)
        local player = PlayerId()
        if flags >= Config.FlagsForBan then
            -- TriggerServerEvent("qb-anticheat:server:banPlayer", "Cheating")
            -- AddExplosion(coords, EXPLOSION_GRENADE, 1000.0, true, false, false, true)
            TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Player banned! (Not really of course, this is a test duuuhhhh)", "red", "** @everyone " ..GetPlayerName(player).. "** Too often has been flagged by the anti-cheat and preemptively banned from the server", false, GetPlayerServerId(player))
            flags = 0
        end
    end
end)

RegisterNetEvent('qb-anticheat:client:NonRegisteredEventCalled', function(reason, CalledEvent)
    local player = PlayerId()

    TriggerServerEvent('qb-anticheat:server:banPlayer', reason)
    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Player banned! (Not really of course, this is a test duuuhhhh)", "red", "** @everyone " ..GetPlayerName(player).. "** has event **"..CalledEvent.."tried to trigger (LUA injector!)", false, GetPlayerServerId(player))
end)
