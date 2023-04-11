local QBCore = exports['qb-core']:GetCoreObject()
local Started = false
local Blackout = false

function SetupStory()
    for k,v in pairs(Config.StoryHints) do
        exports['qb-target']:RemoveZone(k .. ".Hint.")
        exports['qb-target']:AddBoxZone(k .. ".Hint.", v.coords, 1.5, 1.5, {
            name = k .. ".Hint.",
            heading = 0.0,
            debugPoly = false,
            minZ = v.coords.z-1.0,
            maxZ = v.coords.z+1.0
            }, {
                options = {
                    {
                        type = "client",
                        event = "Story:client:Investigate",
                        icon = 'fas fa-question',
                        label = "Investigate",
                        hint = k,
                    },
                },
                distance = 1.5
            }
        )
    end
    Wait(250)
    for k,v in pairs(Config.StoryHacks) do
        exports['qb-target']:RemoveZone(k .. ".Hack.")
        exports['qb-target']:AddBoxZone(k .. ".Hack.", v.coords, 1.5, 1.5, {
            name = k .. ".Hack.",
            heading = 0.0,
            debugPoly = false,
            minZ = v.coords.z-1.0,
            maxZ = v.coords.z+1.0
            }, {
                options = {
                    {
                        type = "client",
                        event = "Story:client:Hack",
                        icon = 'fab fa-usb',
                        label = "Interact",
                        hack = k,
                    },
                },
                distance = 1.5
            }
        )
    end
end

AddEventHandler('Story:client:Hack', function(data)
    if Config.StoryHacks[data.hack] then
        local HackData = Config.StoryHacks[data.hack]
        print('Start hack:', HackData.countDownDone)

        if HackData.requireditem then
            if QBCore.Functions.HasItem(HackData.requireditem) then
                if HackData.countDown and not HackData.countDownDone then
                    TriggerServerEvent('Story:server:startCountdown', data.hack)
                elseif HackData.countDown and HackData.countDownDone then
                    DoHack(data.hack)
                elseif not HackData.countDown then
                    DoHack(data.hack)
                end
            else
                QBCore.Functions.Notify('Something seems to be missing...', 'error')
            end
        else
            if HackData.countDown and not HackData.countDownDone then
                print('Start countdown')
                TriggerServerEvent('Story:server:startCountdown', data.hack)
            elseif HackData.countDown and HackData.countDownDone then
                DoHack(data.hack)
            elseif not HackData.countDown then
                DoHack(data.hack)
            end
        end
    end
end)

function DoHack(hack)
    if hack and Config.StoryHacks[hack] then
        local HackData = Config.StoryHacks[hack]
        QBCore.Functions.TriggerCallback("Story:server:HackStatus", function(cooldown) 
            if cooldown == false then
                if HackData.hacktype == 'code' then
                    local result = exports['boostinghack']:StartHack()
                    if result then
                        TriggerServerEvent('Story:server:HackDone', hack)
                    else
                        QBCore.Functions.Notify('Hack failed', 'error')
                        TriggerServerEvent('Story:server:HackFail', hack)
                    end
                elseif HackData.hacktype == 'colormatch' then
                    local pass = false
                    if HackData.difficulty == 1 then
                        pass = exports['hackgreen']:Begin(3, 8000) -- Icons and timeout
                    elseif HackData.difficulty == 2 then
                        print('begin')
                        pass = exports['hackgreen']:Begin(4, 5000) -- Icons and timeout
                    elseif HackData.difficulty == 3 then
                        pass = exports['hackgreen']:Begin(5, 4000) -- Icons and timeout
                    end

                    if pass then
                        TriggerServerEvent('Story:server:HackDone', hack)
                        QBCore.Functions.Notify('Hack complete', 'success')
                    else
                        QBCore.Functions.Notify('Hack failed', 'error')
                        TriggerServerEvent('Story:server:HackFail', hack)
                    end
                elseif HackData.hacktype == 'lockpick' then
                    local pass = false
                    if HackData.difficulty == 1 then
                        -- pass = exports["skillcheck"]:StartCheck(4, 5)
                        pass = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'})
                    elseif HackData.difficulty == 2 then
                        -- pass = exports["skillcheck"]:StartCheck(3, 4)
                        pass = lib.skillCheck({'medium', 'medium', 'medium', 'medium'})
                    elseif HackData.difficulty == 3 then
                        -- pass = exports["skillcheck"]:StartCheck(1, 3)
                        pass = lib.skillCheck({'hard', 'hard', 'hard'})
                    end

                    if pass then
                        TriggerServerEvent('Story:server:HackDone', hack)
                        QBCore.Functions.Notify('Hack complete', 'success')
                    else
                        QBCore.Functions.Notify('Hack failed', 'error')
                        TriggerServerEvent('Story:server:HackFail', hack)
                    end
                end

                if HackData.policealert then
                    local data = exports['cd_dispatch']:GetPlayerInfo()
                    TriggerServerEvent('cd_dispatch:StoryAlert', data)
                end
            else
                QBCore.Functions.Notify('Can not do that right now', 'error')
            end
        end, hack)
    end
end

AddEventHandler('Story:client:Investigate', function(data)
    if Config.StoryHints[data.hint] then
        local HintData = Config.StoryHints[data.hint]
        if HintData.requireditem then
            if QBCore.Functions.HasItem(HintData.requireditem) then
                if HintData.timer then
                    TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
                    QBCore.Functions.Progressbar("story_investigate", "Searching...", HintData.timer or 5000, false, true, {
                            disableMovement = true, disableCarMovement = true, disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
                            TriggerServerEvent('Story:server:Investigate', data.hint)
                            if HintData.policealert then
                                local data = exports['cd_dispatch']:GetPlayerInfo()
                                TriggerServerEvent('cd_dispatch:StoryAlert', data.hint)
                            end
                    end, function() -- Cancel
                        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    end)
                elseif HintData.policealert then
                    local data = exports['cd_dispatch']:GetPlayerInfo()
                    TriggerServerEvent('cd_dispatch:StoryAlert', data)
                end
            else
                QBCore.Functions.Notify('Something seems to be missing...', 'error')
            end
        else
            if HintData.timer then
                TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
                QBCore.Functions.Progressbar("story_investigate", "Searching...", HintData.timer or 5000, false, true, {
                        disableMovement = true, disableCarMovement = true, disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
                        TriggerServerEvent('Story:server:Investigate', data.hint)
                        if HintData.policealert then
                            local data = exports['cd_dispatch']:GetPlayerInfo()
                            TriggerServerEvent('cd_dispatch:StoryAlert', data.hint)
                        end
                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                end)
            elseif HintData.policealert then
                local data = exports['cd_dispatch']:GetPlayerInfo()
                TriggerServerEvent('cd_dispatch:StoryAlert', data)
            end
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback("Story:server:syncHacks", function(hacks) 
        Config.StoryHacks = hacks
        Wait(1000)
        SetupStory()
        Started = true
    end)
end)

CreateThread(function() -- Live reboot
    if LocalPlayer.state['isLoggedIn'] and not Started then
        QBCore.Functions.TriggerCallback("Story:server:syncHacks", function(hacks) 
            Config.StoryHacks = hacks
            Wait(1000)
            SetupStory()
            Started = true
        end)
    end
end)

AddStateBagChangeHandler('currentBlackout' --[[key filter]], nil --[[bag filter]], function(bagName, key, value, _unused, replicated)
    if value == nil or BlackoutOveride or inBucket then return end
    Blackout = value
end)

RegisterNetEvent('Story:client:syncHacks', function(hacks)
    Sync = true
    Config.StoryHacks = hacks
end)

CreateThread(function()
	while true do
		local pos = GetEntityCoords(PlayerPedId())
		local inRange = false
        if Sync then
            Wait(500)
            Sync = false
        end
        for k,v in pairs(Config.StoryHacks) do
            if v.countDown and v.timeStamp then
                local distance = #(pos - v.coords)
                if distance < 10 then
                    inRange = true
                    if distance < 10.0 then
                        local time = (v.timeStamp - GetNetworkTimeAccurate()) / 1000
                        if time > 60 then
                            local minutes = math.floor(time/60)
                            local seconds = math.floor(time - (minutes * 60))
                            if seconds < 10 then
                                DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.5, 'Timer: '..minutes..':0'..seconds)
                            else
                                DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.5, 'Timer: '..minutes..':'..seconds)
                            end
                        elseif time > 0 then
                            local seconds = math.floor(time)
                            DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.5, 'Timer: 00:'..seconds)
                        else
                            DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.5, 'COMPLETE')
                        end
                    end
                end
                if not inRange then
                    Wait(1000)
                end  
            end
        end
		Wait(0)
	end
end)