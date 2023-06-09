local alcoholCount = 0
local onWeed = false
CreateThread(function()
    while true do 
        Wait(10)
        if alcoholCount > 0 then
            Wait(1000 * 60 * 15)
            alcoholCount = alcoholCount - 1
        else
            Wait(2000)
        end
    end
end)

RegisterNetEvent('playercontroller:doYoga', function(data)
    if LocalPlayer.state.inv_busy then return end
    local ped = PlayerPedId()
    local mat = data.entity
    local cancel = false
    if DoesEntityExist(mat) then
        local coords = GetEntityCoords(mat)
        local heading = GetEntityHeading(mat)
        if #coords ~= vec3(0.0, 0.0, 0.0) then
            TaskStartScenarioAtPosition(PlayerPedId(), 'WORLD_HUMAN_YOGA', coords.x, coords.y, coords.z, heading, -1, false, true)
            local time = math.random(15000,35000)
            local gradual = time / 10 -- divide the stress relief into 10 sections of time
            local timer = 0
            -- Run parallel to progress bar --
            CreateThread(function ()
                while true do
                    if timer < 10 and not cancel then
                        Wait(gradual)
                        timer = timer + 1
                        TriggerServerEvent('hud:server:RelieveStress', math.random(4, 6))
                    else
                        break
                    end
                end
            end)
            -- --
            QBCore.Functions.Progressbar("do_yoga", "Doing yoga...", time, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                cancel = true
                QBCore.Functions.Notify("Failed", "error")
            end)
        else
            QBCore.Functions.Notify("Failed", "error")
        end
    else
        QBCore.Functions.Notify("Failed", "error")
    end
end)

RegisterNetEvent('consumables:client:UseJoint', function(item)
    QBCore.Functions.Progressbar("smoke_joint", "Lighting joint..", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("comsumables:server:useJoint", item)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerEvent('animations:client:EmoteCommandStart', {"smoke3"})
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"smokeweed"})
        end
        TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
        TriggerEvent('animations:client:SmokeWeed')
    end)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")        
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

local ParachuteEquiped = false

RegisterNetEvent('consumables:client:UseParachute', function()
    EquipParachuteAnim()
    QBCore.Functions.Progressbar("use_parachute", "parachute using..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local ped = PlayerPedId()
        GiveWeaponToPed(ped, `GADGET_PARACHUTE`, 1, false)
        SetPedParachuteTintIndex(ped, 6)
        local ParachuteData = {
            outfitData = {
                ["bag"]   = { item = 7, texture = 0},  -- Adding Parachute Clothing
            }
        }
        TriggerEvent('raid_clothes:client:loadOutfit', ParachuteData)
        ParachuteEquiped = true
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)
end)

RegisterNetEvent('consumables:client:ResetParachute', function()
    if ParachuteEquiped then 
        EquipParachuteAnim()
        QBCore.Functions.Progressbar("reset_parachute", "Packing parachute..", 40000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local ped = PlayerPedId()
            local ParachuteRemoveData = { 
                outfitData = { 
                    ["bag"] = { item = 0, texture = 0} -- Removing Parachute Clothing
                }
            }
            TriggerEvent('raid_clothes:client:loadOutfit', ParachuteRemoveData)
            TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            TriggerServerEvent("qb-smallpenis:server:AddParachute")
            ParachuteEquiped = false
        end)
    else
        QBCore.Functions.Notify("You dont have a parachute!", "error")
    end
end)

-- RegisterNetEvent('consumables:client:UseRedSmoke', function()
--     if ParachuteEquiped then
--         local ped = PlayerPedId()
--         SetPlayerParachuteSmokeTrailColor(ped, 255, 0, 0)
--         SetPlayerCanLeaveParachuteSmokeTrail(ped, true)
--     else
--         QBCore.Functions.Notify("You need to have a paracute to activate smoke!", "error")    
--     end
-- end)

RegisterNetEvent('consumables:client:UseBikeLock', function(item)
    if IsPedInAnyVehicle(PlayerPedId()) then QBCore.Functions.Notify("You cannot use this in a vehicle.", "error") return end
    local closestVehicle, distance = QBCore.Functions.GetClosestVehicle(GetEntityCoords(PlayerPedId()))
    if GetVehicleClass(closestVehicle) == 13 and distance < 2.0 then
        local hasKeys = exports['qb-vehiclekeys']:HasKeys(QBCore.Functions.GetPlate(closestVehicle))
        if hasKeys then
            local statelock = Entity(closestVehicle).state.stateLocks
            TriggerEvent('animations:client:EmoteCommandStart', {"kneel3"})
            if statelock and statelock >= 2 then
                QBCore.Functions.Progressbar("unlock_bike", "Unlocking bike...", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    FreezeEntityPosition(closestVehicle, false)
                    QBCore.Functions.SetStateBag(closestVehicle, 'stateLocks', 2)
                    QBCore.Functions.Notify("Bicycle unlocked!", "success")
                    TriggerServerEvent("smallresources:server:setBikeLockMeta", item, false)
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                end)
            else
                if item.info.inUse then QBCore.Functions.Notify("This bike lock is already in use!", "error") return end
                QBCore.Functions.Progressbar("lock_bike", "Locking bike...", 5000, false, true, {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    FreezeEntityPosition(closestVehicle, true)
                    QBCore.Functions.SetStateBag(closestVehicle, 'stateLocks', 1)
                    QBCore.Functions.Notify("Bicycle locked!", "success")
                    TriggerServerEvent("smallresources:server:setBikeLockMeta", item, true)
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                end)
            end
        else
            QBCore.Functions.Notify("You do not own this bicycle!", "error")
        end
    else
        QBCore.Functions.Notify("No bicycle in range to lock!", "error")
    end
end)

RegisterNetEvent('consumables:client:UseArmor', function()
    if GetPedArmour(PlayerPedId()) >= 75 then QBCore.Functions.Notify('You already have enough armor on!', 'error') return end
    QBCore.Functions.Progressbar("use_armor", "Putting on the body armour..", 8000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    },{
        animDict = "clothingtie",
        anim = "try_tie_negative_a",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('prdx_healthsystem:server:SetArmor', 75)
        TriggerServerEvent("consumables:server:removeArmor")
        SetPedArmour(PlayerPedId(), 75)
    end)
end)

RegisterNetEvent('consumables:client:UseVest', function()
    if GetPedArmour(PlayerPedId()) >= 75 then QBCore.Functions.Notify('You already have a vest on!', 'error') return end
    QBCore.Functions.Progressbar("use_vest", "Putting on the vest..", 8000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    },{
        animDict = "clothingtie",
        anim = "try_tie_negative_a",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('prdx_healthsystem:server:SetArmor', 75)
        TriggerServerEvent("consumables:server:removeVest")
        SetPedArmour(PlayerPedId(), 75)
    end)
end)

local currentVest = nil
local currentVestTexture = nil

RegisterNetEvent('consumables:client:UseHeavyArmor', function()
    if GetPedArmour(PlayerPedId()) == 100 then QBCore.Functions.Notify('You already have enough armor on!', 'error') return end
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("use_heavyarmor", "Putting on body armour..", 8000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
        animDict = "clothingtie",
        anim = "try_tie_negative_a",
        flags = 49,
    }, {}, {}, function() -- Done
        TriggerServerEvent('prdx_healthsystem:server:SetArmor', 100)
        TriggerServerEvent("consumables:server:removeHeavyArmor")
        SetPedArmour(ped, 100)
    end)
end)

RegisterNetEvent('consumables:client:ResetArmor', function()
    local ped = PlayerPedId()
    if (currentVest ~= nil and currentVestTexture ~= nil) or GetPedArmour(PlayerPedId()) > 0 then 
        local vestStatus = GetPedArmour(PlayerPedId())
        if vestStatus < 80 then QBCore.Functions.Notify("Your vest is too damaged and would be lost..", "error") return end  
        QBCore.Functions.Progressbar("remove_armor", "Removing the body armour..", 5000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            SetPedArmour(ped, 0)
            TriggerServerEvent('prdx_healthsystem:server:SetArmor', 0)
            TriggerServerEvent("consumables:server:ResetArmor")
        end)
    else
        QBCore.Functions.Notify("You\'re not wearing a vest..", "error")
    end
end)

RegisterNetEvent('consumables:client:DrinkAlcohol', function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"whiskey"})
    QBCore.Functions.Progressbar("snort_coke", "Drinking liquor..", math.random(3000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("consumables:server:drinkAlcohol", itemName)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumablesAlcohol[itemName])
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        end
        
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end)

RegisterNetEvent('consumables:client:Cokebaggy', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("snort_coke", "Quick sniff..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("consumables:server:removeCokeBaggy")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
        CokeBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('consumables:client:Crackbaggy', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("snort_coke", "Smoking crack..", math.random(7000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("consumables:server:removeCrackBaggy")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        CrackBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('consumables:client:EcstasyBaggy', function()
    QBCore.Functions.Progressbar("use_ecstasy", "Pops Pills", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("consumables:server:removeXtcBaggy")
        EcstasyEffect()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:oxy', function()
    QBCore.Functions.Progressbar("use_oxy", "Healing", 2000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("consumables:server:removeOxy")
        ClearPedBloodDamage(PlayerPedId())
		HealOxy()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

function HealOxy()
    if not healing then
        healing = true
    else
        return
    end
    
    local count = 9
    while count > 0 do
        Wait(1000)
        count = count - 1
        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 6) 
    end
    healing = false
end

RegisterNetEvent('consumables:client:meth', function()
    QBCore.Functions.Progressbar("snort_meth", "Smoking Ass Meth", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("consumables:server:removeMeth")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
		TriggerEvent("evidence:client:SetStatus", "agitated", 300)
        MethBagEffect()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
	end)
end)

RegisterNetEvent('consumables:client:slushie', function()
    local ped = PlayerPedId()
    TriggerEvent('animations:client:EmoteCommandStart', {"cup"})
    QBCore.Functions.Progressbar("use_slushie", "Drinking slushie", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        StopAnimTask(ped, "mp_suicide", "pill", 1.0)
        TriggerServerEvent('hud:server:RelieveStress', math.random(40, 60))
        TriggerServerEvent("consumables:server:removeSlushy")
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumablesDrink['slushie'])
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

function MethBagEffect()
    local startStamina = 8
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do 
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

RegisterNetEvent('consumables:client:Drink', function(item)
    TriggerEvent('animations:client:EmoteCommandStart', {"water"})
    QBCore.Functions.Progressbar("drink_something", "Drinking..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("consumables:server:drink", item)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + ConsumablesDrink[item.name])
    end)
end)

RegisterNetEvent('consumables:client:DoFillWater', function(item)
    if IsEntityInWater(PlayerPedId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) then
        TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
        QBCore.Functions.Progressbar("drink_something", "Filling bottle..", 3000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("consumables:server:doWaterFill")
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    else
        QBCore.Functions.Notify('Unable to complete action', 'error')
    end
end)

RegisterNetEvent('consumables:client:DoFillWateringCan', function(item)
    if IsEntityInWater(PlayerPedId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) then
        TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
        QBCore.Functions.Progressbar("drink_something", "Filling Water Can..", 7000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent('QBCore:Server:SetItemDurability', item.name, 100, item.slot)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end)
    else
        QBCore.Functions.Notify('Unable to fill can...', 'error')
    end
end)

RegisterNetEvent('consumables:client:DoShakeSnowGlobe', function()
    if not IsEntityInWater(PlayerPedId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) then
        local hash = GetHashKey("paradox_snowglobe")
        QBCore.Functions.RequestModel(hash)
        local prop
        QBCore.Functions.SpawnObject(hash, function(snowglobe)
            prop = snowglobe
            AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.14, 0.1, 0.05, -100.0, -50.0, 10.0, true, true, false, false, 1, true)
        end, GetEntityCoords(PlayerPedId()), true) 
        loadAnimDict("impexp_int-0")        
        TaskPlayAnim(PlayerPedId(), "impexp_int-0", "mp_m_waremech_01_dual-0", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
        exports['qb-core']:DrawText('[E] Put away snowglobe', 'top')
        CreateThread(function()
            while true do
                Wait(0)
                if IsControlJustReleased(0, 38) then
                    exports['qb-core']:KeyPressed()
                    StopAnimTask(PlayerPedId(),"impexp_int-0", "mp_m_waremech_01_dual-0", 1.0)
                    QBCore.Functions.DeleteEntity(prop)
                end
            end
        end)
    else
        QBCore.Functions.Notify('Unable to shake Snow Globe...', 'error')
    end
end)

RegisterNetEvent('consumables:client:HoldPlushie', function()
   if not IsEntityInWater(PlayerPedId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) then
        local hash = GetHashKey("ch_prop_arcade_claw_plush_06a")
        QBCore.Functions.RequestModel(hash)
        local prop
        QBCore.Functions.SpawnObject(hash, function(plushie)
            prop = plushie
            AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.12, 0.09, 0.06, -102.0, 117.0, -12.0, true, true, false, false, 1, true)
        end, GetEntityCoords(PlayerPedId()), true) 
        loadAnimDict("impexp_int-0")        
        TaskPlayAnim(PlayerPedId(), "impexp_int-0", "mp_m_waremech_01_dual-0", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
        exports['qb-core']:DrawText('[E] Put away Plushie', 'top')
        CreateThread(function()
            while true do
                Wait(0)
                if IsControlJustReleased(0, 38) then
                    exports['qb-core']:KeyPressed()
                    StopAnimTask(PlayerPedId(),"impexp_int-0", "mp_m_waremech_01_dual-0", 1.0)
                    QBCore.Functions.DeleteEntity(prop)
                end
            end
        end)
    else
        QBCore.Functions.Notify('Unable to throw plushies...', 'error')
    end
end)

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do 
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
end

function JointEffect()
    -- if not onWeed then
    --     local RelieveOdd = math.random(35, 45)
    --     onWeed = true
    --     local weedTime = Config.JointEffectTime
    --     CreateThread(function()
    --         while onWeed do 
    --             SetPlayerHealthRechargeMultiplier(PlayerId(), 1.8)
    --             Wait(1000)
    --             weedTime = weedTime - 1
    --             if weedTime == RelieveOdd then
    --                 TriggerServerEvent('hud:Server:RelieveStress', math.random(14, 18))
    --             end
    --             if weedTime <= 0 then
    --                 onWeed = false
    --             end
    --         end
    --     end)
    -- end
end

function CrackBaggyEffect()
    local startStamina = 8
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do 
        Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 60 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 2000), math.random(1000, 2000), 3, 0, 0, 0)
        end
        if math.random(1, 100) < 51 then
            AlienEffect()
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do 
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

