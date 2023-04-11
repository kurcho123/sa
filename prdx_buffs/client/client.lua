local QBCore = exports['qb-core']:GetCoreObject()
local bloodToxicity = 0
local visualsActive = false
local visualID = 0
local activeEffects = {}

function debug(...)
    if Config.Debug then
        print('[Paradox Buffs]',...)
    end
end

local function ResetVisuals()
    visualsActive = false
    ClearTimecycleModifier()
    ClearExtraTimecycleModifier()
end

local function ResetEffects()
    for k,v in pairs(activeEffects) do
        if Config.Effects[k].isToggle then
            Config.Effects[k].DoEffect(ped, v.strength, false)
        end
    end 
    activeEffects = {}
    bloodToxicity = 0
    TriggerEvent('hud:client:updateToxicity', bloodToxicity)
end

local function VisualEffect(name, effects, time)
    if visualsActive then
        ResetVisuals()
        Wait(1)
    end
    local id = visualID + 1
    visualsActive = true
    visualID = id
    SetTimeout(time * 1000, function()
        if visualID == id then -- prevents cancelling one made after if this expires
            ResetVisuals()
        end
    end)

    local index = 0
    for k,v in pairs(effects) do
        index = index + 1
        if index == 1 then
            SetTimecycleModifier(k)
            SetTimecycleModifierStrength(v)
        elseif index == 2 then
            SetExtraTimecycleModifier(k)
            SetExtraTimecycleModifierStrength(v)
        end
    end
end

local function AddBuff(name, seconds, playerEffects, visualEffects, toxicity)
    if name then
        local finalTime = seconds    
        if playerEffects then
            for effect, value in pairs(playerEffects) do
                if Config.Effects[effect] then
                    if activeEffects[effect] then
                        if Config.Effects[effect].canCompound then
                            activeEffects[effect].strength = activeEffects[effect].strength + value
                        end
                        activeEffects[effect].toxicity = activeEffects[effect].toxicity + toxicity
                        print('Adding time:', seconds, activeEffects[effect].time)
                        activeEffects[effect].time = activeEffects[effect].time + seconds
                        print('New Time:', effect, activeEffects[effect].time)
                        if finalTime < activeEffects[effect].time then
                            finalTime = activeEffects[effect].time
                        end
                    else
                        activeEffects[effect] = {
                            time = seconds,
                            strength = value,
                            toxicity = toxicity,
                        }
                    end
                else 
                    print('Non-configured buff effect:', effect)
                end
            end
        end    
        if visualEffects then
            VisualEffect(name, visualEffects, finalTime)
        end
        
        bloodToxicity = bloodToxicity + toxicity
        if bloodToxicity >= Config.MaxToxicity then
            exports['prdx_healthsystem']:DoPlayerOverdose()
            QBCore.Functions.Notify('You overdosed out...', 'inform')
        else
            TriggerEvent('hud:client:updateToxicity', bloodToxicity)
        end
    end
end

RegisterNetEvent('prdx_buffs:client:doBuff', function(name, amount, time)
    AddBuff('testBuff', time, {
        [name] = amount or 1,
    },{}, 0.0)
end)

RegisterNetEvent('prdx_healthsystem:client:syncInjuries', function()
    ResetEffects()
    ResetVisuals()
end)

-- Master loop --
-- I decided to do it this way because of ease of use and to allow compoundation of effects--
CreateThread(function()
    while true do
        local ped = cache.ped
        if not LocalPlayer.state.isDead then
            for k,v in pairs(activeEffects) do
                if Config.Effects[k].decreaseAmount then
                    Config.Effects[k].DoEffect(ped, v.strength/v.time)
                    v.strength = v.strength - v.strength/v.time
                elseif Config.Effects[k].isToggle and not Config.Effects[k].toggledOn then
                    Config.Effects[k].DoEffect(ped, v.strength, true)
                end
                activeEffects[k].time = v.time - 1
                if activeEffects[k].time == 0 then
                    if Config.Effects[k].isToggle then
                        Config.Effects[k].DoEffect(ped, v.strength, false)
                    end
                    bloodToxicity = bloodToxicity - activeEffects[k].toxicity
                    if bloodToxicity < 0 then bloodToxicity = 0 end
                    TriggerEvent('hud:client:updateToxicity', bloodToxicity)
                    activeEffects[k] = nil
                end
            end 
        else
            ResetEffects()
            ResetVisuals()
            Wait(5000)
        end
        Wait(1000) -- All effects go by seconds
    end
end)


exports('AddBuff', AddBuff)
