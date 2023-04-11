Config = Config or {}
Config.InjuryEffects = {
    ['stability'] = {
        DoEffect = function(ped, amount)
            local chance = tonumber(amount) or 10
            if IsPedFalling(ped) then
                Wait(350)
                if IsPedFalling(ped) then
                    local luck = math.random(10)
                    if luck <= chance then
                        QBCore.Functions.Notify('Your feet fail as you hit the ground', 'error')
                        TriggerServerEvent('prdx_buffs:changeStress', math.random(1,3), true)
                        SetPedToRagdoll(ped, math.random(100, 150), math.random(100, 150), 0, 0, 0, 0) 	
                    end
                end
            end
        end
    },
    ['climbinhibit'] = {
        DoEffect = function(ped)
            if IsPedVaulting(ped) and IsPedClimbing(ped) and not IsPedJumping(ped) then
                Wait(950)
                if IsPedVaulting(ped) and IsPedClimbing(ped) and not IsPedJumping(ped) then
                    QBCore.Functions.Notify('Your arms fail as you put your weight on them', 'error')
                    TriggerServerEvent('prdx_buffs:changeStress', math.random(1,3), true)
                    ClearPedTasksImmediately(ped)
                    SetPedToRagdoll(ped, math.random(500, 750), math.random(500, 750), 0, 0, 0, 0) 	
                end
            end
        end
    },
    ['weaponfail'] = {
        DoEffect = function(ped, amount)
            local chance = tonumber(amount) or 1
            if IsPedArmed(ped, 4) and IsPedShooting(ped) then
                local luck = math.random(10)
                if luck <= chance then
                    QBCore.Functions.Notify('Your finger slips from trigger', 'error')
                    local jammed = true
                    SetTimeout(750, function()
                        jammed = false
                        DisablePlayerFiring(PlayerId(), false)
                    end)
                    while jammed do
                        Wait(0)
                        DisablePlayerFiring(PlayerId(), true)
                    end
                end                        
            end
        end
    },
    ['speed'] = {
        isToggle = true,
        defaultValue = 1.0,
        DoEffect = function(ped, amount)
            SetRunSprintMultiplierForPlayer(PlayerId(), amount)
        end
    },
    ['forcedemote'] = {
        isToggle = true,
        DoEffect = function(ped, animData)
            ForceEmote(ped, animData)
        end
    },
}