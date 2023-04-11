function StartHack(heistID, doorID)
    local pass = false
    local HackData = Config.Heists[heistID]["doors"][doorID]['hack']
    if not HackData then return false end
    if HackData.hacktype == 'code' then
        pass = exports['boostinghack']:StartHack()
    elseif HackData.hacktype == 'colormatch' then
        pass = exports['hackgreen']:Begin(HackData.options[1], HackData.options[2]) -- Icons and timeout
    elseif HackData.hacktype == 'lockpick' then
        -- pass = exports["skillcheck"]:StartCheck(HackData.options[1], HackData.options[2]) -- Time(single int) and icons
        pass = lib.skillCheck(HackData.options)
    elseif HackData.hacktype == 'blockmatch' then
        pass = exports["blockmatch"]:StartHack(HackData.options[1], HackData.options[2], HackData.options[3], HackData.options[4])  -- Correct blocks, allowed incorrect blocks, time to show (s), time to lose (s)
    elseif HackData.hacktype == 'advcolormatch' then
        pass = exports['hackblue']:StartHack()
    end 

    if Config.DebugMode then pass = true end

    if pass then
        if not Config.Heists[heistID]['active'] then
            QBCore.Functions.Notify('Hack complete', 'success')
            PoliceCall(Config.Heists[heistID]['label'], Config.Heists[heistID]["doors"][doorID].coords)

            Config.Heists[heistID]['active'] = true
            TriggerServerEvent('prdx_heists:server:heistStarted', heistID)
            TriggerServerEvent('RobberyTimer:RobberyStarted', Config.Heists[heistID]['cooldown'])
        end
        TriggerServerEvent('QBCore:Server:RemoveItemDurability', HackData.item, 50)
        TriggerServerEvent('prdx_heists:server:doorHacked', heistID, doorID)
    else
        QBCore.Functions.Notify('Hack failed', 'error')
    end 

    return true -- Stop any anim
end

function SetupDoorHackZone(heistID, doorID, options)
    exports.ox_target:addBoxZone({
        coords = vec3(options.coords.x, options.coords.y, options.coords.z),
        size = vec3(0.45, 0.35, (options.coords.z+0.25) - (options.coords.z-0.25)),
        rotation = options.coords.w,
        debug = Config.DebugMode,
        options = {
            {
                name = 'prdx_heist:startHack',
                event = 'prdx_heist:startHack',
                icon = 'fab fa-usb',
                label = 'Hack',
                args = {heistID, doorID},
                distance = 1.5
            }
        }
    })
end

function ConnectLaptop(heistID, doorID)
    if not Config.Heists[heistID]["doors"][doorID]['isOpened'] then
        local ped = cache.ped
        local pos = GetEntityCoords(ped)
        TaskAchieveHeading(ped, Config.Heists[heistID]["doors"][doorID]['hack'].coords.w, 1000)
        Wait(1000)
        if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        end
        QBCore.Functions.Progressbar('hack_gate', 'Connecting the laptop..', math.random(5000, 10000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
            DoHack(heistID, doorID, Config.Heists[heistID]["doors"][doorID].coords)
        end, function() -- Cancel
            StopAnimTask(ped, 'anim@gangops@facility@servers@', 'hotwire', 1.0)
            QBCore.Functions.Notify("Cancelled", 'error')
        end)
    else
        QBCore.Functions.Notify("Door Already Hacked", 'error', 5000)
    end
end

RegisterNetEvent('prdx_heist:startHack', function(data)
    local heistID, doorID = data.args[1], data.args[2]
    if Config.Heists[heistID]["doors"][doorID]["hack"].item then
        if QBCore.Functions.HasItem(Config.Heists[heistID]["doors"][doorID]["hack"].item) then 
            if not Config.Heists[heistID]['active'] then
                QBCore.Functions.TriggerCallback('RobberyTimer:CanStartRobbery', function(CanAccept)    
                    if CanAccept or Config.DebugMode then
                        ConnectLaptop(heistID, doorID)
                    else
                        QBCore.Functions.Notify("Door is locked on a timer...", 'error', 5000)
                    end
                end, Config.Heists[heistID]['cooldown'], true)
            else
                ConnectLaptop(heistID, doorID)
            end
        else
            QBCore.Functions.Notify("You seem to be missing something", 'error', 5000)
        end
    else
        ConnectLaptop(heistID, doorID)
    end
end)

RegisterNetEvent('prdx_heists:client:practiceLaptop', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"tablet2"})
    local dialog = lib.inputDialog("Practice Laptop Hacks",{
        { type = 'select', label = 'Select a hack', options = {
            { value = 'lockpick', label = 'lockpick' },
            { value = 'code', label = 'code' },
            { value = 'colormatch', label = 'colormatch'},
            { value = 'blockmatch', label = 'blockmatch'},
            { value = 'advcolormatch', label = 'advcolormatch'},
        }},
    })
    if not dialog then return end

    local pass = false
    if dialog[1] == 'code' then
        pass = exports['boostinghack']:StartHack()
    elseif dialog[1] == 'colormatch' then
        pass = exports['hackgreen']:Begin(5, 5000) -- Icons and timeout
    elseif dialog[1] == 'lockpick' then
        pass = lib.skillCheck({'hard', 'hard', 'hard', 'hard', 'hard'})
    elseif dialog[1] == 'blockmatch' then
        pass = exports["blockmatch"]:StartHack(10, 3, 2, 120)  -- Correct blocks, allowed incorrect blocks, time to show (s), time to lose (s)
    elseif dialog[1] == 'advcolormatch' then
        pass = exports['hackblue']:StartHack()
    end 
    
    if pass then
        QBCore.Functions.Notify('Hack complete', 'success')
    else
        QBCore.Functions.Notify('Hack failed', 'error')
    end 

    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)