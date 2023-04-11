PlayerInjuries = {} -- Master list of injuries
PlayerEffects = {} -- Master of current effects 
PlayerBleedAmount = 0 -- Master Bleed Level 

function AddInjuryEffects(effect, maxData, damage)
    TriggerEvent('scully_emotemenu:injuryWalk', 'move_m@injured')
    if type(maxData) == "table" then
        local min,max = maxData[1], maxData[2]
        if not PlayerEffects[effect] then
            local scaler = math.floor((damage/200) * max)
            PlayerEffects[effect] = scaler
        else
            PlayerEffects[effect] = PlayerEffects[effect] + 1
            if PlayerEffects[effect] > max then
                PlayerEffects[effect] = max
            elseif PlayerEffects[effect] < min then
                PlayerEffects[effect] = min
            end
        end
    else
        local EffectData = Config.InjuryEffects[effect]
        if EffectData.isToggle then
            EffectData.DoEffect(cache.ped, maxData)
        end
        PlayerEffects[effect] = true
    end
    return effect, PlayerEffects[effect]
end

function ApplyInjuryToPlayer(injuryID, damage, damageBone)
    local injury = Config.Injuries[injuryID]
    local playerEffect, effectAmt
    if injury.effectPack then
        for effect, maxData in pairs(injury.effectPack) do -- apply effect pack
            playerEffect, effectAmt = AddInjuryEffects(effect, maxData, damage)
        end
    elseif injury.BoneData then
        for _,effectData in pairs(injury.BoneData) do
            if effectData.bones[damageBone] and effectData.effects then
                for effect2, maxData2 in pairs(effectData.effects) do
                    playerEffect, effectAmt = AddInjuryEffects(effect2, maxData2, damage)
                end
            end
        end
    end
    if PlayerInjuries[damageBone] then
        PlayerInjuries[damageBone].damage = PlayerInjuries[damageBone].damage + damage
        if playerEffect and PlayerInjuries[damageBone].injuryEffects[playerEffect] then
            if type(PlayerInjuries[damageBone].injuryEffects[playerEffect]) == "number" then
                PlayerInjuries[damageBone].injuryEffects[playerEffect] = PlayerInjuries[damageBone].injuryEffects[playerEffect] + effectAmt
            end 
        end

        if PlayerInjuries[damageBone].injuries[injuryID] then
            PlayerInjuries[damageBone].injuries[injuryID] += 1
        else
            PlayerInjuries[damageBone].injuries[injuryID] = 1
        end
    else
        PlayerInjuries[damageBone] = {
            damage = damage,
            injuryEffects = {},
            injuries = {[injuryID] = 1}
        }
        if playerEffect then
            PlayerInjuries[damageBone].injuryEffects[playerEffect] = effectAmt
        end 
    end
end

function AddPlayerBleed(amt)
    if amt == 0 then
        PlayerBleedAmount = 0
    else
        PlayerBleedAmount += amt
    end
    if PlayerBleedAmount > 5 then PlayerBleedAmount = 5 end
    TriggerEvent('prdx_healthsystem:client:bleedingSync', PlayerBleedAmount)
end

function RemovePlayerBleed(amt)
    if amt == 0 then
        PlayerBleedAmount = 0
    else
        PlayerBleedAmount -= amt
    end
    if PlayerBleedAmount < 0 then PlayerBleedAmount = 0 end
    TriggerEvent('prdx_healthsystem:client:bleedingSync', PlayerBleedAmount)
end

function ForceEmote(ped, animData)
    lib.requestAnimDict(animData.dict, 1000)
    local duration = GetAnimDuration(animData.dict, animData.anim)
    forceAnim = true
    SetTimeout(duration, function ()
        forceAnim = false
    end)
    FreezeEntityPosition(ped, true)
    exports.ox_target:disableTargeting(true)
    exports.ox_inventory:setInvBusy(true)
    while true do
        Wait(10)
        if not IsEntityPlayingAnim(ped, animData.dict, animData.anim, 3) then
            TaskPlayAnim(ped, animData.dict, animData.anim, 8.0, 8.0, -1, 50, 1, 0, 0, 0)
        end
        DisablePlayerFiring(cache.playerId, true)
    end
    FreezeEntityPosition(ped, false)
    exports.ox_target:disableTargeting(false)
    exports.ox_inventory:setInvBusy(false)
end

function HealAllInjuries(removeBleed)
    if removeBleed then
        PlayerBleedAmount = 0
        TriggerEvent('prdx_healthsystem:client:bleedingSync', PlayerBleedAmount)
    end
    for effect, amount in pairs(PlayerEffects) do -- Untoggle toggled effects
        local EffectData = Config.InjuryEffects[effect]
        if EffectData.isToggle then
            if EffectData.defaultValue then
                EffectData.DoEffect(cache.ped, EffectData.defaultValue)
            else -- Must be a boolean
                EffectData.DoEffect(cache.ped, not amount)
            end
        end
    end
    PlayerInjuries = {}
    PlayerEffects = {}
end

function ResetAllHealthValues()
    for effect, amount in pairs(PlayerEffects) do -- Untoggle toggled effects
        local EffectData = Config.InjuryEffects[effect]
        if EffectData.isToggle then
            if EffectData.defaultValue then
                EffectData.DoEffect(cache.ped, EffectData.defaultValue)
            else -- Must be a boolean
                EffectData.DoEffect(cache.ped, not amount)
            end
        end
    end
    PlayerInjuries = {}
    PlayerEffects = {}
    PlayerBleedAmount = 0
    PlayerDead = false
    PlayerUnconcious = false
    PlayerOverdosed = false
    TriggerEvent('scully_emotemenu:injuryWalk')
    TriggerEvent('scully_emotemenu:resetWalk')
    TriggerEvent('prdx_healthsystem:client:bleedingSync', PlayerBleedAmount)
end

function HealInjury(bone, name)
    if PlayerInjuries[bone] then
        for effectID, amount in pairs(PlayerInjuries[bone].injuryEffects) do
            for id,data in pairs(PlayerEffects) do
                if id == effectID then
                    if type(data) == 'number' then
                        PlayerEffects[id] = PlayerEffects[id] - amount
                        if PlayerEffects[id] <= 0 then
                            local EffectData = Config.InjuryEffects[id]
                            if EffectData.isToggle then -- Heal toggle injury
                                if EffectData.defaultValue then
                                    EffectData.DoEffect(cache.ped, EffectData.defaultValue)
                                else -- Must be a boolean
                                    EffectData.DoEffect(cache.ped, not amount)
                                end
                            end
                            PlayerEffects[id] = nil
                        end
                    else
                        PlayerEffects[id] = nil
                        local EffectData = Config.InjuryEffects[id]
                        if EffectData.isToggle then -- Heal toggle injury
                            if EffectData.defaultValue then
                                EffectData.DoEffect(cache.ped, EffectData.defaultValue)
                            else -- Must be a boolean
                                EffectData.DoEffect(cache.ped, not amount)
                            end
                        end
                    end
                end
            end 
        end
        PlayerInjuries[bone].injuries[name] = nil
        local count = 0
        for k,v in pairs(PlayerInjuries[bone].injuries) do
            count += 1
        end
        if count == 0 then
            PlayerInjuries[bone] = nil -- Bone healed completely
        end
    end
end

RegisterNetEvent('prdx_healthsystem:client:healInjury', function(bone, injuryName)
    HealInjury(bone, injuryName)
end)

RegisterNetEvent('prdx_healthsystem:client:setBleedLevel', function(bleedLevel)
    PlayerBleedAmount = tonumber(bleedLevel) or 0
    TriggerEvent('prdx_healthsystem:client:bleedingSync', PlayerBleedAmount)
end)

RegisterNetEvent('prdx_healthsystem:client:doHealBleeding', function(args)
    local targetPlayerID, bleedLevel = args[1], args[2]
    if bleedLevel > 0 then
        local count = exports.ox_inventory:Search('count', Config.BleedingHealItem)
        if count > 0 then
            TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
            QBCore.Functions.Progressbar("healing_injury", "Packing wound with QuikClot...", math.random(7500,15000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerServerEvent('prdx_healthsystem:server:setBleedLevel', targetPlayerID, 0)
                Wait(500)
                TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
            end)     
        else
            QBCore.Functions.Notify('You are missing the proper treatment method', 'error')
            TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
        end 
    else
        QBCore.Functions.Notify('Person is not bleeding', 'error')
        TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
    end
end)


RegisterNetEvent('prdx_healthsystem:client:doHealInjury', function(args)
    local bone, injuryName, targetPlayerID = args[1], args[2], args[3]
    local injuryData = Config.Injuries[injuryName]
    if injuryData then
        if injuryData.itemRequirement then
            local count = exports.ox_inventory:Search('count', injuryData.itemRequirement)
            if count > 0 then
                TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
                QBCore.Functions.Progressbar("healing_injury", "Tending wound...", math.random(7500,15000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    TriggerServerEvent('prdx_healthsystem:server:healInjury', targetPlayerID, bone, injuryName)
                    Wait(500)
                    TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
                end, function() -- Cancel
                    TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                end)     
            else
                QBCore.Functions.Notify('You are missing the proper treatment method', 'error')
                TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
            end
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
            QBCore.Functions.Progressbar("healing_injury", "Tending wound...", math.random(7500,15000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerServerEvent('prdx_healthsystem:server:healInjury', targetPlayerID, bone, injuryName)
                Wait(500)
                TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
            end, function() -- Cancel
                TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', targetPlayerID)
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end)                
        end
    end
end)

RegisterNetEvent('prdx_healthsystem:client:doRevivePlayer', function(playerID)
    local currentJob = QBCore.Functions.GetPlayerData().job.name
    if currentJob == 'ambulance' or currentJob == 'fire' or currentJob == 'clinic' then
        TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
        QBCore.Functions.Progressbar("healing_injury", "Helping to feet...", math.random(7500,15000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('prdx_healthsystem:server:RevivePlayer', playerID)
            Wait(500)
            TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', playerID)
        end, function() -- Cancel
            TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', playerID)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    else
        TriggerServerEvent('prdx_healthsystem:server:GetPlayerInjuries', playerID)
    end   
end)

RegisterNetEvent('prdx_healthsystem:client:GetInjuries', function(target)
    local health = PlayerHealth
    local status = 'Alive'
    if IsPedMale(cache.ped) then
        health = health - 100
    end
    if health < 0 then health = 0 end
    if PlayerDead then
        status = 'Heavily injured'
    elseif PlayerUnconcious then
        status = 'Knocked out'
    elseif PlayerOverdosed then
        status = 'Overdosed'
    end
    TriggerServerEvent('prdx_healthsystem:server:RecieveInjuries', PlayerInjuries, PlayerBleedAmount, status, health, PlayerArmor, target)
end)

RegisterNetEvent('prdx_healthsystem:client:GetPlayerInjuries', function(playerID, injuries, bleedLevel, status, health, armor, hunger, thirst, stress)
    local bleedPercentage = math.ceil((bleedLevel/Config.MaxBleedAmount) * 100)
    local statusColor = '#37b24d'
    if status == 'Heavily injured' then
        statusColor = '#fa5252'
    elseif status == 'Knocked out' then
        statusColor = '#fcc419'
    elseif status == 'Overdosed' then
        statusColor = '#be4bdb'
    end
    local menu = {
        {
            title = "Status: ".. status, 
            icon = 'person',
            progress = 100,
            colorScheme = statusColor,
            event = "prdx_healthsystem:client:doRevivePlayer",
            args = playerID
        },
        {
            title = "Health: "..health, 
            icon = 'heart-pulse',
            progress = health,
            colorScheme = '#37b24d'

        },
        {
            title = "Bleed Level: ".. bleedLevel, 
            icon = 'droplet',
            progress = bleedPercentage,
            colorScheme = '#fa5252',
            event = "prdx_healthsystem:client:doHealBleeding",
            args = {playerID, bleedLevel}
        },
        {
            title = "Basic Statuses", 
            icon = 'info',
            menu = 'basic_stats_menu'
        },
        {
            title = "Injuries:", 
            icon = 'bandage',
        },
    }

    local statusMenu = {
        {
            title = "Nutrition", 
            icon = 'utensils',
            progress = hunger,
            colorScheme = '#ff922b'

        },
        {
            title = "Hydration", 
            icon = 'droplet',
            progress = thirst,
            colorScheme = '#4dabf7'

        },
        {
            title = "Stress", 
            icon = 'brain',
            progress = stress,
            colorScheme = '#fa5252'

        },
        {
            title = "Armor", 
            icon = 'shield-halved',
            progress = armor,
            colorScheme = '#1971c2'

        },
    }
    lib.registerContext({
        id = 'basic_stats_menu',
        title = 'Basic Statuses',
        options = statusMenu,
        menu = 'injuries_menu'
    })

    for bone,data in pairs(injuries) do
        local boneMenu = {}
        for name,amt in pairs(data.injuries) do
            local injuryLabel = Config.Injuries[name].label
            boneMenu[#boneMenu+1] = {
                title = injuryLabel..': '..amt, 
                icon = 'bandage',
                event = "prdx_healthsystem:client:doHealInjury",
                args = {bone, name, playerID}
            }
        end
        lib.registerContext({
            id = bone..'_menu',
            title = "Limb: ".. bone,
            options = boneMenu,
            menu = 'injuries_menu'
        })
        menu[#menu+1] = {
            title = bone, 
            description = 'Damage: '..data.damage,
            arrow = true,
            menu = bone..'_menu',
        }
    end

    lib.registerContext({
        id = 'injuries_menu',
        title = 'Citizen Injuries',
        options = menu,
    })
    lib.showContext('injuries_menu')
end)

-- Injury Effect Loop --
-- Triggers ailments from every effect --
CreateThread(function() 
    while true do
        Wait(0)
        if Config.DisableHealthLoop then 
            Wait(1000)  
        else
            local ped = cache.ped
            for effect, amount in pairs(PlayerEffects) do
                local EffectData = Config.InjuryEffects[effect]
                if not EffectData.isToggle then
                    EffectData.DoEffect(ped, amount)
                end
            end
        end     
    end
end)

-- Bleed Effect Loop --
-- Handles bleeding --
CreateThread(function()
    while true do
        Wait(0)
        if Config.DisableHealthLoop then 
            Wait(1000)  
        elseif PlayerBleedAmount > 0 then
            local timer = Config.BleedTimerMultiplier / PlayerBleedAmount
            local ped = cache.ped
            PlayerHealth = PlayerHealth - (Config.BleedMultiplier * PlayerBleedAmount)
            SetEntityHealth(ped, PlayerHealth)
            UpdatePedHealthData(ped)
            QBCore.Functions.Notify('You feel warm blood...', 'error')
            Wait(timer * 1000)
        end        
    end
end)

exports('getBleed', function()
    return PlayerBleedAmount
end)