local QBCore = exports['qb-core']:GetCoreObject()
Config = Config or {}
Config.Debug = false
Config.MaxToxicity = 5.0
Config.Effects = {
    ['health'] = {
        canCompound = true,
        decreaseAmount = true, -- decrease amount over time
        DoEffect = function(ped, amount, time)
            debug('Add health:', math.ceil(amount))
            exports['prdx_healthsystem']:ModifyPlayerHealth(ped, math.ceil(amount))
        end
    },
    ['armor'] = {
        canCompound = true,
        decreaseAmount = true, -- decrease amount over time
        DoEffect = function(ped, amount, time)
            debug('Add armor:', math.ceil(amount))
            local currentArmor = GetPedArmour(ped)
            if currentArmor + amount < 100 then
                SetPedArmour(ped, math.ceil(currentArmor + amount))
            else
                SetPedArmour(ped, 100)
            end
        end
    },
    ['stamina'] = {
        isToggle = true,
        DoEffect = function(ped, amount, toggle)
            Config.Effects['stamina'].toggledOn = toggle
            CreateThread( function()
                while Config.Effects['stamina'].toggledOn do
                    RestorePlayerStamina(PlayerId(), 1.0)
                    Wait(500)
                end
            end)
        end
    },
    ['speed'] = {
        isToggle = true,
        DoEffect = function(ped, amount, toggle)
            Config.Effects['speed'].toggledOn = toggle
            if toggle then
                SetRunSprintMultiplierForPlayer(PlayerId(), amount)
            else
                SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
            end
        end
    },
    ['stress'] = {
        canCompound = true,
        decreaseAmount = true, -- decrease amount over time
        DoEffect = function(ped, amount, toggle)
            debug('Modify stress:', amount, amount > 0)
            TriggerServerEvent('prdx_buffs:changeStress', amount, amount > 0)
        end
    },
    ['food'] = {
        canCompound = true,
        decreaseAmount = true, -- decrease amount over time
        DoEffect = function(ped, amount, toggle)
            debug('Modify food:', amount, amount > 0)
            TriggerServerEvent('prdx_buffs:changeFood', amount, amount > 0)
        end
    },
    ['water'] = {
        canCompound = true,
        decreaseAmount = true, -- decrease amount over time
        DoEffect = function(ped, amount, toggle)
            debug('Modify water:', amount, amount > 0)
            TriggerServerEvent('prdx_buffs:changeWater', amount, amount > 0)
        end
    },
    ['strength'] = {
        isToggle = true,
        DoEffect = function(ped, amount, toggle)
            debug('Super Strength:', amount, toggle)
            Config.Effects['strength'].toggledOn = toggle
            if toggle then
                SetPlayerMeleeWeaponDamageModifier(PlayerId(), amount)
            else
                SetPlayerMeleeWeaponDamageModifier(PlayerId(), 1.0)
            end
        end
    },
    ['resistence'] = {
        isToggle = true,
        DoEffect = function(ped, amount, toggle)
            debug('Super resistence:', amount, toggle)
            Config.Effects['strength'].toggledOn = toggle
            if toggle then
                SetPlayerMeleeWeaponDefenseModifier(PlayerId(), amount)
            else
                SetPlayerMeleeWeaponDefenseModifier(PlayerId(), 1.0)
            end
        end
    },
    ['notaze'] = {
        isToggle = true,
        DoEffect = function(ped, amount, toggle)
            debug('Tazer resistence:', amount, toggle)
            Config.Effects['notaze'].toggledOn = toggle
            CreateThread(function()
                while Config.Effects['notaze'].toggledOn do
                    if IsPedBeingStunned(ped) then
                        ClearPedTasksImmediately(ped)
                    end
                    Wait(0)
                end
            end)
        end
    },
    ['specialaudio'] = {
        isToggle = true,
        DoEffect = function(ped, amount, toggle)
            debug('Special Audio:', amount, toggle)
            Config.Effects['specialaudio'].toggledOn = toggle
            CreateThread(function()
                local audio = amount or 2
                while Config.Effects['specialaudio'].toggledOn do
                    Wait(0) 
                    SetAudioSpecialEffectMode(audio)
                end
            end)
        end
    },
}