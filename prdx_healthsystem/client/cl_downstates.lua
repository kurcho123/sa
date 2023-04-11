DeathEMS = 0 -- Set ems amount on death to prevent race conditions (when ems comes online)
DownTimer = 0 -- Global down timer
AlertSent = false -- Has alert been sent to EMS

local function PlayDeadAnimation(ped)
    if cache.vehicle then
        if not IsEntityPlayingAnim(ped, Config.VehAnim.dict, Config.VehAnim.anim, 3) then
            lib.requestAnimDict(Config.VehAnim.dict)
            TaskPlayAnim(ped, Config.VehAnim.dict, Config.VehAnim.anim, 8.0, 8.0, -1, 1, 0, false, false, false)
        end
    else
        if not IsEntityAttachedToAnyPed(ped) and not IsEntityAttachedToAnyVehicle(ped) then -- if carried then ignore
            if PlayerDead then
                if not IsEntityPlayingAnim(ped, Config.DeadAnim.dict, Config.DeadAnim.anim, 3) then
                    lib.requestAnimDict(Config.DeadAnim.dict)
                    TaskPlayAnim(ped, Config.DeadAnim.dict, Config.DeadAnim.anim, 8.0, 8.0, -1, 1, 0, false, false, false)
                end
            elseif PlayerUnconcious then
                if not IsEntityPlayingAnim(ped, Config.UnconciousAnim.dict, Config.UnconciousAnim.anim, 3) then
                    lib.requestAnimDict(Config.UnconciousAnim.dict)
                    TaskPlayAnim(ped, Config.UnconciousAnim.dict, Config.UnconciousAnim.anim, 8.0, 8.0, -1, 1, 0, false, false, false)
                end
            elseif PlayerOverdosed then
                if not IsPedInWrithe(ped) then
                    TaskWrithe(ped, ped, -1, 0)
                end
            end
        elseif IsEntityInAir(ped) then
            ClearPedTasks(ped)
        end
    end
end

function SetPlayerHealth(ped, amt)
    if IsPedMale(ped) then
        local finalHealth = amt + 100
        SetEntityHealth(ped, finalHealth)
    else
        SetEntityHealth(ped, amt)
    end
    Wait(250)
    UpdatePedHealthData(ped)
end

function ModifyPlayerHealth(ped, amt)
    PlayerHealth = PlayerHealth + amt
    if PlayerHealth < 0 then PlayerHealth = 0 end
    if PlayerHealth > 200 then PlayerHealth = 200 end
    SetEntityHealth(ped, PlayerHealth)
end

function RevivePlayer(setHealth, doAnim, knockoutAnim)
    local ped = cache.ped
    local player = cache.playerId
    local vehicle = cache.vehicle
    local seat = cache.seat
    if not PlayerDead and not PlayerUnconcious and not PlayerOverdosed then
        doAnim = false -- Never do animation if not dead or down so that EMS can heal people standing up
    end
    PlayerDead = false
    PlayerUnconcious = false
    PlayerOverdosed = false
    FreezeEntityPosition(ped, false)
    if IsPedDeadOrDying(ped) then
        local pos = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.15, heading, true, false) -- Revive player
        if vehicle then
            SetPedIntoVehicle(ped, vehicle, seat)
        end
    end
    if doAnim and not vehicle then
        if knockoutAnim then
            UnconciousWakeup(ped)
        else
            NormalWakeup(ped)
        end
    elseif not vehicle then
        ClearPedTasksImmediately(ped)
    end
    SetPlayerHealth(ped, setHealth or 100)
    SetEntityMaxHealth(ped, 200)
    SetEntityHealth(ped, 200)
    ClearPedBloodDamage(ped)
    ToggleInvincibility(false)
    -- GLOBAL SETTERS --
    LocalPlayer.state:set("isDead", false, true)
    TriggerServerEvent('prdx_healthsystem:server:syncInjuries', false, PlayerArmor)
    TriggerEvent('prdx_healthsystem:client:syncInjuries', false)
    exports.npwd:setPhoneDisabled(false)
    --------------------
end

function DoPlayerDeath()
    local ped = cache.ped
    local player = cache.playerId

    -- GLOBAL SETTERS --
    LocalPlayer.state:set("isDead", true, true)
    TriggerServerEvent('prdx_healthsystem:server:syncInjuries', true, PlayerArmor)
    TriggerEvent('prdx_healthsystem:client:syncInjuries', true)
    exports.npwd:setPhoneVisible(false)
    exports.npwd:setPhoneDisabled(true)
    --------------------
    while GetEntitySpeed(ped) > 2.5 or IsEntityInAir(ped) do
        Wait(0)
        DisableAllControlActions(0)
        DisablePlayerFiring(cache.playerID, true)
        ActivatePhysics(ped)
    end
    --------------------
    local pos = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local vehicle = cache.vehicle
    local seat = cache.seat

    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.15, heading, true, false) -- Revive player
    ClearPedTasksImmediately(ped)
    if vehicle then
        SetPedIntoVehicle(ped, vehicle, seat)
    end
    SetPlayerHealth(ped, 100)
    ToggleInvincibility(true) -- engage invicibility measures to prevent double-death

    DeathEMS = CurrentEMS
    CallCancelled = false
    AlertSent = false
    if DeathEMS >= Config.MinimumEMS then
        DownTimer = Config.DeathTimer
    else
        DownTimer = Config.DeathTimer / 2
    end
    PlayerOverdosed = false
    PlayerUnconcious = false
    PlayerDead = true -- enable script checks
end

function DoPlayerUnconcious()
    local ped = cache.ped
    local player = cache.playerId

    -- GLOBAL SETTERS --
    LocalPlayer.state:set("isDead", true, true)
    TriggerServerEvent('prdx_healthsystem:server:syncInjuries', true, PlayerArmor)
    TriggerEvent('prdx_healthsystem:client:syncInjuries', true)
    exports.npwd:setPhoneVisible(false)
    exports.npwd:setPhoneDisabled(true)
    --------------------
    while GetEntitySpeed(ped) > 2.5 or IsEntityInAir(ped) do
        Wait(100)
        ActivatePhysics(ped)
    end
    --------------------


    local pos = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local vehicle = cache.vehicle
    local seat = cache.seat

    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.15, heading, true, false) -- Revive player
    if vehicle then
        SetPedIntoVehicle(ped, vehicle, seat)
    end
    SetPlayerHealth(ped, 100)
    ToggleInvincibility(false) -- allow double-death
    ClearPedTasksImmediately(ped)
    SetPedCanRagdoll(ped, false)
    DeathEMS = CurrentEMS
    CallCancelled = false
    AlertSent = false
    DownTimer = Config.UnconciousTimer
    PlayerUnconcious = true -- enable script checks
end

function DoPlayerOverdose()
    local ped = cache.ped
    local player = cache.playerId

    -- GLOBAL SETTERS --
    LocalPlayer.state:set("isDead", true, true)
    TriggerServerEvent('prdx_healthsystem:server:syncInjuries', true, PlayerArmor)
    TriggerEvent('prdx_healthsystem:client:syncInjuries', true)
    exports.npwd:setPhoneVisible(false)
    exports.npwd:setPhoneDisabled(true)
    --------------------
    while GetEntitySpeed(ped) > 2.5 or IsEntityInAir(ped) do
        Wait(100)
        ActivatePhysics(ped)
    end
    --------------------
    ToggleInvincibility(true) -- disable invicibility measures to allow  full death
    --------------------

    local pos = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local vehicle = cache.vehicle
    local seat = cache.seat

    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.15, heading, true, false) -- Revive player
    ClearPedTasksImmediately(ped)
    if vehicle then
        SetPedIntoVehicle(ped, vehicle, seat)
    end

    SetPlayerHealth(ped, 100)
    ToggleInvincibility(true) -- engage invicibility measures to prevent double-death

    DeathEMS = CurrentEMS
    CallCancelled = false
    AlertSent = false
    if DeathEMS >= Config.MinimumEMS then
        DownTimer = Config.OverdoseTimer
    else
        DownTimer = Config.OverdoseTimer / 2
    end
    PlayerUnconcious = false
    PlayerOverdosed = true -- enable script checks
end

function UnconciousWakeup(ped)
    lib.requestAnimDict(Config.WakeupAnimation.dict)
    local isUp = false
    SetTimeout(2700, function()
        isUp = true
    end)
    ClearPedTasksImmediately(ped)
    TaskPlayAnim(ped, Config.WakeupAnimation.dict, Config.WakeupAnimation.anim, 8.0, 8.0, 2900, 0, 0, false, false, false)
    while not isUp do
        Wait(10)
        if not IsEntityPlayingAnim(ped, Config.WakeupAnimation.dict, Config.WakeupAnimation.anim, 3) then
            TaskPlayAnim(ped, Config.WakeupAnimation.dict, Config.WakeupAnimation.anim, 8.0, 8.0, 2900, 0, 0, false, false, false)
        end
    end
end

function NormalWakeup(ped)
    lib.requestAnimDict(Config.PickupAnimation.dict)
    local isUp = false
    SetTimeout(24000, function()
        isUp = true
    end)
    ClearPedTasksImmediately(ped)
    TaskPlayAnim(ped, Config.PickupAnimation.dict, Config.PickupAnimation.anim, 8.0, 8.0, 26500, 0, 0, false, false, false)
    while not isUp do
        Wait(10)
        if not IsEntityPlayingAnim(ped, Config.PickupAnimation.dict, Config.PickupAnimation.anim, 3) then
            TaskPlayAnim(ped, Config.PickupAnimation.dict, Config.PickupAnimation.anim, 8.0, 8.0, 26500, 0, 0, false, false, false)
        end
    end
end

function CheckPlayerDeath(lastDamage)
    local damageData = Config.Damages[lastDamage]
    if not PlayerDead then
        TriggerEvent('qb-logs:client:deathLog', cache.ped) -- Trigger death log
        if damageData?.unconcious then
            DoPlayerUnconcious()
        else
            DoPlayerDeath()
        end
    end
end

local holdTimer = 5
CreateThread(function()
    while true do
        Wait(1000)
        local canAlert = false
        if (PlayerDead or PlayerUnconcious or PlayerOverdosed) and not InHospitalBed then
            PlayDeadAnimation(cache.ped)
            local pos = GetEntityCoords(cache.ped)
            if DownTimer > 0 then
                DownTimer -= 1
            end

            if IsControlPressed(0, 38) then
                holdTimer -= 1
            else
                holdTimer = 5
            end

            if IsPedDeadOrDying(cache.ped) then
                NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.15, GetEntityHeading(cache.ped), true, false) -- Revive player
            end

            if PlayerDead or PlayerOverdosed then
                if DeathEMS >= Config.MinimumEMS then
                    if DownTimer > 0 and DownTimer >= (Config.DeathTimer - Config.NotifyDelay) then
                        drawTxt("YOU WILL SUCCUMB TO YOUR INJURIES IN: ~r~" .. math.ceil(DownTimer) .. "~w~ SECONDS ~n~~w~ EMS AVAILABLE IN ~r~" .. math.ceil(DownTimer - (Config.DeathTimer - Config.NotifyDelay)).. "~w~ SECONDS", 255, 255, 255)
                    elseif DownTimer > 0 and DownTimer <= (Config.DeathTimer - Config.NotifyDelay) and not AlertSent then
                        canAlert = true
                        drawTxt("YOU WILL SUCCUMB TO YOUR INJURIES IN: ~r~" .. math.ceil(DownTimer) .. "~w~ SECONDS ~n~~w~ HOLD ~r~[E] ("..holdTimer..")~w~ TO ALERT EMS")
                    elseif DownTimer > 0 and DownTimer <= (Config.DeathTimer - Config.NotifyDelay) and AlertSent then
                        drawTxt("YOU WILL SUCCUMB TO YOUR INJURIES IN: ~r~" .. math.ceil(DownTimer) .. "~w~ SECONDS ~n~~g~ EMS NOTIFIED")
                    elseif DownTimer <= 0 then
                        canAlert = true
                        drawTxt("~r~YOU HAVE BLED OUT ~n~~w~ HOLD ~r~[E] ("..holdTimer..")~w~ AIRLIFT TO NEAREST HOSPITAL")
                    end
                else
                    if DownTimer > 0 then
                        drawTxt("YOU WILL SUCCUMB TO YOUR INJURIES IN: ~r~" .. math.ceil(DownTimer) .. "~w~ SECONDS ~n~~r~EMS UNAVAILABLE~w~ | ~g~NO ITEM LOSS")
                    elseif DownTimer <= 0 then
                        canAlert = true
                        drawTxt("~r~YOU HAVE BLED OUT ~n~~w~ HOLD ~r~[E] ("..holdTimer..")~w~ AIRLIFT TO NEAREST HOSPITAL ~n~~g~NO ITEM LOSS")
                    end
                end
            elseif PlayerUnconcious then
                if DownTimer > 0 then
                    drawTxt("~r~YOU ARE UNCONCIOUS ~n~~w~ YOU CAN WAKE UP IN: ~r~" .. math.ceil(DownTimer) .. "~w~ SECONDS")
                elseif DownTimer <= 0 then
                    canAlert = true
                    drawTxt("~r~YOU ARE UNCONCIOUS ~n~~w~ HOLD ~r~[E] ("..holdTimer..")~w~ TO WAKE UP")
                end
            end
            
            if canAlert then
                if IsControlPressed(0, 38) and holdTimer <= 1 then
                    if PlayerDead then
                        if DownTimer > 0 then
                            if not AlertSent then
                                CallCancelled = false
                                local data = exports['cd_dispatch']:GetPlayerInfo()
                                TriggerServerEvent('cd_dispatch:AddNotification', {
                                    job_table = {'ambulance'}, --{'police', 'sheriff} 
                                    coords = data.coords,
                                    title = '10-52 - Person is injured',
                                    message = 'A '..data.sex..' was reported injured at '..data.street, 
                                    flash = 0, 
                                    unique_id = tostring(math.random(0000000,9999999)),
                                    blip = {
                                        sprite = 310, 
                                        scale = 1.2, 
                                        colour = 1,
                                        flashes = false, 
                                        text = '911 - Person is injured',
                                        time = (5*60*1000),
                                        sound = 1,
                                    }
                                })      
                                TriggerServerEvent("InteractSound_SV:PlayOnSource", "pager", 0.1)
                                AlertSent = data.coords
                                canAlert = false
                            end
                        else
                            RespawnPlayerAtHospital(false, DeathEMS)
                        end
                    elseif PlayerOverdosed then
                        if DownTimer > 0 then
                            if not AlertSent then
                                CallCancelled = false
                                local data = exports['cd_dispatch']:GetPlayerInfo()
                                TriggerServerEvent('cd_dispatch:AddNotification', {
                                    job_table = {'ambulance'}, --{'police', 'sheriff} 
                                    coords = data.coords,
                                    title = '10-52 - Overdose in progress',
                                    message = 'A '..data.sex..' was reported to be having an overdose at '..data.street, 
                                    flash = 0, 
                                    unique_id = tostring(math.random(0000000,9999999)),
                                    blip = {
                                        sprite = 310, 
                                        scale = 1.2, 
                                        colour = 1,
                                        flashes = false, 
                                        text = '911 - Overdose in progress',
                                        time = (5*60*1000),
                                        sound = 1,
                                    }
                                })      
                                TriggerServerEvent("InteractSound_SV:PlayOnSource", "pager", 0.1)
                                AlertSent = data.coords
                                canAlert = false
                            end
                        else
                            RespawnPlayerAtHospital(false, DeathEMS)
                        end
                    elseif PlayerUnconcious then
                        RevivePlayer(25, true, true)
                    end
                end
            end
    
            if AlertSent and not CallCancelled then
                --Check position and see if they have moved, if they have then send an alert to cancel the call.
                if #(AlertSent - pos) > 25 then 
                    CallCancelled = true
                    local data = exports['cd_dispatch']:GetPlayerInfo()
                    local streetHash,_ = GetStreetNameAtCoord(AlertSent.x, AlertSent.y, AlertSent.z)
                    local streetName = GetStreetNameFromHashKey(streetHash)
                    TriggerServerEvent('cd_dispatch:AddNotification', {
                        job_table = {'ambulance'}, --{'police', 'sheriff} 
                        coords = AlertSent,
                        title = 'Distress Signal Lost',
                        message = 'The distress signal near '..streetName .. ' has stopped broadcasting', 
                        flash = 0, 
                        unique_id = tostring(math.random(0000000,9999999)),
                        blip = {
                            sprite = 61, 
                            scale = 0.5, 
                            colour = 2,
                            flashes = false, 
                            text = 'Signal Lost',
                            time = (2*60*1000),
                            sound = 1,
                        }
                    })      
                end
            end
        end
    end        
end)

CreateThread(function()
    while true do
        Wait(0)
        if (PlayerDead or PlayerUnconcious or PlayerOverdosed) then
            DisablePlayerFiring(cache.playerID, true)
            DisableControlAction(0, 30, true)
            DisableControlAction(0, 31, true)
            DisableControlAction(0, 32, true)
            DisableControlAction(0, 33, true)
            DisableControlAction(0, 34, true)
            DisableControlAction(0, 35, true)
            DisableControlAction(0, 266, true)
            DisableControlAction(0, 267, true)
            DisableControlAction(0, 268, true)
            DisableControlAction(0, 269, true)
            DisableControlAction(0, 44, true)
            DisableControlAction(0, 48, true)
            DisableControlAction(0, 20, true)
            DisableControlAction(0, 74, true)
            DisableControlAction(0, 85, true)
        end
    end
end)

exports('DoPlayerUnconcious', DoPlayerUnconcious)
exports('DoPlayerDeath', DoPlayerDeath)
exports('DoPlayerOverdose', DoPlayerOverdose)
exports('SetPlayerHealth', SetPlayerHealth)
exports('ModifyPlayerHealth', ModifyPlayerHealth)
