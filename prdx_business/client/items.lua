local QBCore = exports['qb-core']:GetCoreObject()
local playerInRange = false

--#region functions

function ItemEmote(propname, bone, dict, anim, x, y, z, a, b, c, tooltip, duration, canmove, hasSecondProp, boneb, propb, pxb,  pyb, pzb,  rxb,  ryb, rzb, cb)
    local proptwo
    local enttwo
    local hash = joaat(propname)
    local hashtwo = hasSecondProp and joaat(propb)
    lib.requestAnimDict(dict)
    lib.requestModel(hash)
    local prop = CreateObject(hash, GetEntityCoords(cache.ped), true, true, true)
    AttachEntityToEntity(prop, cache.ped, GetPedBoneIndex(cache.ped, bone), x, y, z, a, b, c, true, true, false, true, 1, true)
    if hasSecondProp then
        lib.requestModel(hashtwo)
        proptwo = CreateObject(hashtwo, GetEntityCoords(cache.ped), true, true, true)
        AttachEntityToEntity(proptwo, cache.ped, GetPedBoneIndex(cache.ped, boneb), pxb, pyb, pzb, rxb, ryb, rzb, true, true, false, true, 1, true)
    end 
    TaskPlayAnim(cache.ped, dict, anim, 8.0, 8.0, -1, 51, 0, false, false, false)
    QBCore.Functions.Progressbar("using_item", tooltip, duration, false, true, {disableMovement = canmove, disableCarMovement = false, disableMouse = false, disableCombat = true}, {}, {}, {}, function() 
        Wait(300)
        StopAnimTask(cache.ped, dict, anim, 1.0)
        --Check if sitting and if sitting just play a different animation for the hands and don't touch the feet.
        QBCore.Functions.DeleteEntity(prop)
        if proptwo then 
            QBCore.Functions.DeleteEntity(proptwo)
        end
        prop = nil 
        proptwo = nil
        cb(false)
    end, function()
        QBCore.Functions.Notify("Cancelled", "error")
        QBCore.Functions.DeleteEntity(prop)
        if proptwo then 
            QBCore.Functions.DeleteEntity(proptwo)
        end
        prop = nil 
        proptwo = nil
        cb(true)
    end)
end

function AddArmor(amt)
    SetPedArmour(cache.ped, amt)
end

function SetStrength(amt)
    local isStronk = true
    local isWeak = false
    CreateThread(function() 
        SetTimeout(amt, function() isStronk = false end)          
        while isStronk do 
            N_0x4757f00bc6323cfe(joaat("WEAPON_UNARMED"), 0.92) 
            Wait(0) 
        end 
        SetTimeout((amt/2), function() isWeak = false end)
        isWeak = true
        Wait(1000)
        while isWeak do
            N_0x4757f00bc6323cfe(joaat("WEAPON_UNARMED"), 0.12) 
            Wait(0)
        end        
        Wait(1000)        
        N_0x4757f00bc6323cfe(joaat("WEAPON_UNARMED"), 0.62) 
    end)
end

function DoFalling(amt)
    Wait(12000)
    QBCore.Functions.Notify("You begin to feel unstable...", "inform")
    local isFalling = true
    CreateThread(function()
        SetTimeout(amt, function() isFalling = false end)          
        while isFalling do 
            SetPedToRagdoll(cache.ped, math.random(1000, 3000), math.random(1000, 3000), 0, 0, 0, 0) 	
            Wait(math.random(5000, 10000)) 
        end 
    end)
end

-- Increase Stamina
local hasBoostedStamina = false
function ModifyStamina(duration)
    hasBoostedStamina = true
    SetTimeout(duration, function()
        hasBoostedStamina = false
      end)
    CreateThread( function()
        while hasBoostedStamina do
           Wait(0)
           RestorePlayerStamina(cache.playerId, 1.0)
           end
       end)
end

-- Increase Movement Speed
local hasBoostedSpeed = false
function ModifyMovementSpeed(speed, duration)
    hasBoostedSpeed = true
    SetTimeout(duration, function()
        hasBoostedSpeed = false
        SetRunSprintMultiplierForPlayer(cache.playerId, 1.00)
    end)
    SetRunSprintMultiplierForPlayer(cache.playerId, speed)
    CreateThread(function()
        while hasBoostedSpeed do  
        Wait(0)  
        SetPedMoveRateOverride(cache.ped, speed)
        end
    end)
end

-- Short Term Tazer Immunity
local blockingTazeEffect = false
function BlockTazer(duration)
    blockingTazeEffect = true
    SetTimeout(duration, function()
        blockingTazeEffect = false
    end)
    while blockingTazeEffect do
    Wait(0)
    local retval = IsPedBeingStunned(cache.ped, 0)
        if retval then
            ClearPedTasksImmediately(cache.ped)
        end
    end
end

-- Weed Effects
local onWeed = nil
function JointEffects(time, potency)
    if not onWeed then
        local ped = cache.ped
        onWeed = true
        local weedTime = time
        TriggerEvent('evidence:client:SetStatus', 'weedsmell', time * 3)
        CreateThread(function()
            while onWeed do 
                local currentHealth = GetEntityHealth(ped)
                if currentHealth < 200 then
                SetEntityHealth(ped, currentHealth + potency)
                end
                Wait(5000)
                weedTime = weedTime - 5
                if weedTime <= 0 then
                    onWeed = false
                end
            end
        end)
    end
end

-- Attempt to remove cuffs
function BreakCuffs(item) 
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 1.5 then
        playerInRange = true
        local playerId = GetPlayerServerId(player)
        if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(GetPlayerPed(cache.ped)) then
            TriggerServerEvent("police:server:CuffPlayer", playerId, true)
            local breakchance = math.random(0,100)
            Wait(100)
            if breakchance < 40 then  
                TriggerServerEvent("prdx_business:items:removeitem", item)
                QBCore.Functions.Notify("The Unicorn Charm Breaks", "error")
            end
        else
            QBCore.Functions.Notify("You cant uncuff someone in a vehicle", "error")
        end
    else
        QBCore.Functions.Notify("There was nobody close enough to uncuff", "error")
        playerInRange = false
    end
    playerInRange = false
end

function UnCuffAnimation()
    local ped = cache.ped
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
    QBCore.Functions.RequestAnimDict("mp_arrest_paired")
	Wait(100)
    TaskPlayAnim(ped, "mp_arrest_paired", "cop_p2_back_right", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
	Wait(3500)
    TaskPlayAnim(ped, "mp_arrest_paired", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end

-- Visual Effects: [Timecycles]
function ModifyVision(timecycle, duration)
    SetTimecycleModifier(timecycle)
    SetTimecycleModifierStrength(1.0)
    SetTimeout(duration, function()
        ClearTimecycleModifier(timecycle)
    end)
end

-- Headbag
local bag = nil
function DoHeadbag(duration)
    bag = CreateObject(joaat('prop_money_bag_01'), 0, 0, 0, true, true, true) -- Create head bag object!
    AttachEntityToEntity(bag, cache.ped, GetPedBoneIndex(cache.ped, 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
    SetTimecycleModifier('Glasses_BlackOut')
    SetTimecycleModifierStrength(1.0)
    QBCore.Functions.Notify('A bag was placed on your head...', 'inform')
    SetTimeout(duration, function()
        RemoveHeadbag()
    end)
end

function RemoveHeadbag()
    if bag then
        DeleteEntity(bag)
        ClearTimecycleModifier('Glasses_BlackOut')
        bag = nil
    end
end

--#endregion

--#region events

RegisterNetEvent('business:startUncuff', function(item)
    BreakCuffs(item) 
end)

RegisterNetEvent('prdx_business:client:breakCuffs', function(item)
    BreakCuffs(item)
end)

RegisterNetEvent('prdx_business:client:elevator', function(data)
    QBCore.Functions.Progressbar(data.name, data.tooltiptext, 500, false, true, 
    {        disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, }, 
    {        animDict = "gestures@f@standing@casual", anim = "gesture_point", flags = 0, task = nil, }, {}, {}, 
    function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetEntityCoords(cache.ped, data.exitCoords.x, data.exitCoords.y, data.exitCoords.z - 0.50, false)
        SetEntityHeading(cache.ped, data.exitCoords.w)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    end, function()
        QBCore.Functions.Notify("Failed!", "error")
    end)  
end)

local canUseItem = false
RegisterNetEvent('prdx_business:client:useitem', function(data) 
    canUseItem = true
    local ItemData = data
    if not ItemData then return end
    if ItemData.animation then 
        ItemEmote(ItemData.animation.prop, ItemData.animation.bone, ItemData.animation.dict, ItemData.animation.anim, ItemData.animation.px, ItemData.animation.py, ItemData.animation.pz, ItemData.animation.rx, ItemData.animation.ry, ItemData.animation.rz, ItemData.animation.tooltip, ItemData.animation.duration, ItemData.animation.isFrozen, ItemData.animation.hasSecondProp, ItemData.animation.boneb, ItemData.animation.propb, ItemData.animation.pxb,  ItemData.animation.pyb, ItemData.animation.pzb,  ItemData.animation.rxb,  ItemData.animation.ryb, ItemData.animation.rzb, function(hasCancelled)
            if not ItemData.effects and not ItemData.visualEffects then return end
            if hasCancelled then return end
            exports['prdx_buffs']:AddBuff(ItemData.item, ItemData.time or 30, ItemData.effects or {}, ItemData.visualEffects or {}, ItemData.toxicity or 0.0) 
            TriggerServerEvent("prdx_business:items:removeitem", ItemData.item)         
        end)
    else
        if not ItemData.effects and not ItemData.visualEffects then return end
        if hasCancelled then return end
        exports['prdx_buffs']:AddBuff(ItemData.item, ItemData.time or 30, ItemData.effects or {}, ItemData.visualEffects or {}, ItemData.toxicity or 0.0) 
        TriggerServerEvent("prdx_business:items:removeitem", ItemData.item)
    end
end)

RegisterNetEvent('business:icepack', function()
	local playerPed = cache.ped
    local currArmour = GetPedArmour(playerPed)

    -- Max obtainable armor the same as basic body armor
    if currArmour < 66 then
        QBCore.Functions.Progressbar("use_icepack", "Applying Icepack", 15000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
            anim = "weed_inspecting_high_base_inspector",
            flags = 49,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
            AddArmor(currArmour + 10)
            TriggerServerEvent("prdx_business:items:removeIcePack")          
        end, function() -- Cancel
            StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
            QBCore.Functions.Notify("Failed", "error")
        end)
    else
        QBCore.Functions.Notify("The icepack would have no effect", "error")
    end
end)

RegisterNetEvent('business:headbag', function()
    DoHeadbag(120000)
end)

RegisterNetEvent('business:startHeadbag', function(item)
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 1.5 then
        playerInRange = true
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("prdx_business:items:headbag", playerId, item)

    else
        QBCore.Functions.Notify("No one nearby", "error")
        playerInRange = false
    end
    playerInRange = false
end)

RegisterNetEvent('business:removeHeadbag', function()
    RemoveHeadbag()
end)

RegisterNetEvent('business:carflip', function(slot)
    local playerPed = cache.ped
    local inCar = cache.vehicle
    if inCar then QBCore.Functions.Notify("You cannot use that in a vehicle", "error") return end
    local playerPos = GetEntityCoords(playerPed)
    local closestCar = QBCore.Functions.GetClosestVehicle()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if not vehicle then QBCore.Functions.Notify("You are not close enough to a vehicle to use this", "error") return end
    local distanceFromCar = #(playerPos - GetEntityCoords(closestCar))
    if distanceFromCar >= 2 then QBCore.Functions.Notify("You are not close enough to a vehicle to use this", "error") return end
    QBCore.Functions.Notify("Attempting to flip vehicle....", "error")
    local closeCarCoords = GetEntityRotation(closestCar, 2)
    QBCore.Functions.Progressbar("flip_car", "Flipping Car...", 30000, false, true, {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "missfinale_c2ig_11",
        anim = "pushcar_offcliff_m",
        flags = 49,
    }, {}, {}, function() -- Done
        QBCore.Functions.TakeControl(closestCar)
        StopAnimTask(playerPed, "missfinale_c2ig_11", "pushcar_offcliff_m", 1.0)
        SetEntityRotation(closestCar, closeCarCoords[1], 0, closeCarCoords[3], 2, true)
        Wait(250)
        SetVehicleOnGroundProperly(closestCar)
        TriggerServerEvent("QBCore:Server:RemoveItemDurability", "comealong", 25, slot)         
    end, function() -- Cancel
        StopAnimTask(playerPed, "missfinale_c2ig_11", "pushcar_offcliff_m", 1.0)
        QBCore.Functions.Notify("Failed to flip car", "error")
    end)
end, false)

--#endregion

--#region commands

RegisterCommand('removebag', function(source, args)
    if DoesEntityExist(bag) then
        if QBCore.Functions.GetPlayerData().metadata["ishandcuffed"] then QBCore.Functions.Notify("Your hands are currently restrained!", "error") return end
        RemoveHeadbag()
    else
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 1.0 then
            TriggerServerEvent('prdx_business:items:removeHeadbag', GetPlayerServerId(player))
        end
    end
end)

--#endregion