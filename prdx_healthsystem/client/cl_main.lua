QBCore = exports['qb-core']:GetCoreObject()
-- @global Player Health and Armor
PlayerArmor = 0
PlayerHealth = 200
PlayerInvicible = false
-- @global Player states
PlayerDead = false
PlayerUnconcious = false
PlayerOverdosed = false
-- @global Current EMS available
CurrentEMS = 0

function ToggleInvincibility(toggle)
    local maintainHealth = PlayerHealth
    local ped = cache.ped
    local player = PlayerId()
    if toggle ~= nil then
        PlayerInvicible = toggle
    else
        PlayerInvicible = not PlayerInvicible
    end
    Config.DisableHealthLoop = PlayerInvicible
    SetPedCanBeTargetted(ped, not PlayerInvicible)
    SetEntityCanBeDamaged(ped, not PlayerInvicible)
    SetEntityInvincible(ped, PlayerInvicible)
    SetEveryoneIgnorePlayer(player, PlayerInvicible)
    SetPlayerInvincible(player, PlayerInvicible)
    SetPedCanRagdoll(ped, not PlayerInvicible)
end

function ApplyHealthSystemDamage(damageHash, ArmorDmg, HealthDmg, damageBone)
    if not Config.Damages[damageHash] then return end
    if ArmorDmg > 0 then
        local bone = Config.Bones[damageBone]
        if bone and (bone ~= 'CHEST' and bone ~= 'TORSO' and bone ~= 'UPPER BODY') then -- Prevents unarmored areas
            local tmpArmor = GetPedArmour(cache.ped)
            local newArmor = math.floor(tmpArmor + (ArmorDmg))
            SetPedArmour(cache.ped, newArmor)
            SetEntityHealth(cache.ped, PlayerHealth - ArmorDmg)
        end
    end

    if HealthDmg > 0 then
        local bone = Config.Bones[damageBone]
        local Damage = Config.Damages[damageHash]
        local luck = math.random(100)
        -- Chance of applying injury 
        -- Checks if the damage type forces injury
        -- Checks if the damage amount is greater than the force injury amount (see config)
        -- Checks if the health damage is greater than a random number 1-100 
        if Damage.injuries and (Damage.forceInjury or (HealthDmg >= Config.ForceInjuryDamage) or (Damage.limbDamageChance*100) > luck) then
            local randomInjuryint = math.random(#Damage.injuries)
            local randomInjury = Damage.injuries[randomInjuryint]
            ApplyInjuryToPlayer(randomInjury, HealthDmg, bone)
        end

        if Damage.alwaysInjury then -- Forced injuries (so things like GSWs don't have a broken bone and no GSW)
            ApplyInjuryToPlayer(Damage.alwaysInjury, HealthDmg, bone)
        end
        
        if Damage.bleedChance * 100 > luck then
            AddPlayerBleed(1)
        end
    end
end

function GetPedLastDamageHash(ped)
    for k, v in pairs(Config.Damages) do
        if HasPedBeenDamagedByWeapon(ped, k, 0) then
            return k
        end
    end
end

function UpdatePedHealthData(ped)
    PlayerHealth = GetEntityHealth(ped) or 0
    PlayerArmor = GetPedArmour(ped) or 0
end

local function initHealthAndArmorIfNotSet(health, armor)
    if not PlayerHealth then
        PlayerHealth = health
    end

    if not PlayerArmor then
        PlayerArmor = armor
    end
end

local function CheckPedDamage(ped)
    local health = GetEntityHealth(ped)
    local armor = GetPedArmour(ped)

    initHealthAndArmorIfNotSet(health, armor)
    if not Config.DisableHealthLoop then
        local isHealthDamaged = (PlayerHealth ~= health) -- Players health was damaged
        if isHealthDamaged or health <= 0 then
            local damageHash = GetPedLastDamageHash(ped)       
            local ArmorDamageAmt = (PlayerArmor - armor)
            local HealthDamageAmt = (PlayerHealth - health)
            if HealthDamageAmt > Config.MinimumDamageCheck then
                local _,damagedBone = GetPedLastDamageBone(ped)
                ApplyHealthSystemDamage(damageHash, ArmorDamageAmt, HealthDamageAmt, damagedBone) 
            end
            if health <= 0 then
                CheckPlayerDeath(damageHash)
            end
        end
    end
    ClearEntityLastDamageEntity(ped)
    SetPlayerHealthRechargeMultiplier(cache.playerId, 0.0)
    SetPlayerHealthRechargeLimit(cache.playerId, 0.0)
    PlayerHealth = health
    PlayerArmor = armor
end

function DisableHealthSystem(toggle)
    if toggle then
        ToggleInvincibility(toggle)
    else
        ToggleInvincibility(not Config.DisableHealthLoop)
    end
end

RegisterNetEvent('ems:SetEmsCount', function(amount)
    CurrentEMS = amount
end)

RegisterNetEvent('prdx_healthsystem:client:RevivePlayer', function(healInjuries, doAnim)
    if healInjuries then
        ResetAllHealthValues()
    end
    RevivePlayer(100, doAnim)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    local ped = cache.ped
    local player = cache.player
    exports.spawnmanager:setAutoSpawn(false)
    SetEntityMaxHealth(ped, 200)
    SetEntityHealth(ped, 200)
    SetPlayerHealthRechargeMultiplier(player, 0.0)
    SetPlayerHealthRechargeLimit(player, 0.0)
    Wait(15000)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        local armorAmt = PlayerData.metadata["armor"] or 0
        SetPedArmour(cache.ped, armorAmt)
        PlayerArmor = armorAmt
    end)
    ToggleInvincibility(false)-- enable script
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    ToggleInvincibility(true)-- disable script
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    if LocalPlayer.state.isLoggedIn then
        ToggleInvincibility(false)
    else
        ToggleInvincibility(true) -- Invincibility at start
    end
end)

AddEventHandler('playerSpawned', function(spawn)
    local ped = cache.ped
    local player = cache.player
    SetEntityMaxHealth(ped, 200)
    SetPlayerHealthRechargeMultiplier(player, 0.0)
    SetPlayerHealthRechargeLimit(player, 0.0)
end)

CreateThread(function()
    while true do
        Wait(15)
        local ped = cache.ped
        CheckPedDamage(ped)
    end
end)

exports('DisableHealthSystem', DisableHealthSystem)
