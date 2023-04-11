local QBCore = exports['qb-core']:GetCoreObject()
local currentRegister = 0
local currentSafe = 0
local copsCalled = false
local CurrentCops = 0
local PlayerJob = {}
local onDuty = false
local usingAdvanced = false
local ChosenStore = false
local blip 

CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData().job ~= nil and next(QBCore.Functions.GetPlayerData().job) then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

CreateThread(function()
    Wait(1000)
    setupRegister()
    setupSafes()
    while true do
        local ped = cache.ped
        local pos = GetEntityCoords(ped)
        local inRange = false
        for k in pairs(Config.Registers) do
            local dist = #(pos - Config.Registers[k][1].xyz)
            if dist <= 1 and Config.Registers[k].robbed then
                inRange = true
                DrawText3Ds(Config.Registers[k][1].xyz, Lang:t("text.the_cash_register_is_empty"))
            end
        end
        if not inRange then
            Wait(2000)
        end
        Wait(3)
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        local inRange = false
        if ChosenStore then
            local pos = GetEntityCoords(cache.ped)
            for safe,_ in pairs(Config.Safes) do
                local dist = #(pos - Config.Safes[safe][1].xyz)
                if dist < 3 then
                    inRange = true
                    if dist < 1.0 then
                        if not Config.Safes[safe].robbed then
                            DrawText3Ds(Config.Safes[safe][1].xyz, Lang:t("text.try_combination"))
                            if IsControlJustPressed(0, 38) then
                                currentSafe = safe
                                if math.random(1, 100) <= 65 and not IsWearingHandshoes() then
                                    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                                end
                                if math.random(100) <= 50 then
                                    TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                                end
                                if Config.Safes[safe].type == "keypad" then
                                    SendNUIMessage({
                                        action = "openKeypad",
                                    })
                                    SetNuiFocus(true, true)
                                else
                                    QBCore.Functions.TriggerCallback('prdx_storerobbery:server:getPadlockCombination', function(combination)
                                        TriggerEvent("SafeCracker:StartMinigame", combination)
                                    end, safe)
                                end
                            end
                        else
                            DrawText3Ds(Config.Safes[safe][1].xyz, Lang:t("text.safe_opened"))
                        end
                    end
                end
            end
        end

        if not inRange then
            Wait(2000)
        end
    end
end)


function StoreBlip(coords)
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 66)
    SetBlipColour(blip, 47)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Information")
    EndTextCommandSetBlipName(blip)
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    onDuty = true
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = true
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced, slot)
    if not ChosenStore then return end
    usingAdvanced = isAdvanced
    for k in pairs(Config.Registers) do
        local ped = cache.ped
        local pos = GetEntityCoords(ped)
        local dist = #(pos - Config.Registers[k][1].xyz)
        if dist <= 1 and not Config.Registers[k].robbed then
            if usingAdvanced then
                TriggerServerEvent("QBCore:Server:RemoveItemDurability", "advancedlockpick", 10, slot)
                -- local result = exports["skillcheck"]:StartCheck(3, 3)
                local result = lib.skillCheck({'easy', 'medium', 'medium'})
                currentRegister = k
                if result then
                    RobRegister()
                else
                    QBCore.Functions.Notify('Failed to lockpick register', 'error')
                end
                if not IsWearingHandshoes() then
                    TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
                end
                if not copsCalled then
                    TriggerServerEvent('RobberyTimer:RobberyStarted', 'StoreRobbery')
                    local data = exports['cd_dispatch']:GetPlayerInfo()
                    TriggerServerEvent('cd_dispatch:AddNotification', {
                        job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'}, --{'police', 'sheriff} 
                        coords = data.coords,
                        title = '10-68 - Commercial Alarm',
                        message = 'A '..data.sex..' was reported breaking into registers at a store on '..data.street, 
                        flash = 1, 
                        unique_id = tostring(math.random(0000000,9999999)),
                        blip = {
                            sprite = 459, 
                            scale = 1.5, 
                            colour = 1,
                            flashes = false, 
                            text = '10-68 - Commercial Alarm',
                            sound = 1,
                        }
                    })
                    copsCalled = true
                end
            end
        end
    end
end)

function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(cache.ped, 3)
    local model = GetEntityModel(cache.ped)
    local retval = true

    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

function setupRegister()
    QBCore.Functions.TriggerCallback('prdx_storerobbery:server:getRegisterStatus', function(Registers)
        for k in pairs(Registers) do
            Config.Registers[k].robbed = Registers[k].robbed
        end
    end)
end

function setupSafes()
    QBCore.Functions.TriggerCallback('prdx_storerobbery:server:getSafeStatus', function(Safes)
        for k in pairs(Safes) do
            Config.Safes[k].robbed = Safes[k].robbed
        end
    end)
end

DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(coords, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function lockpick(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    SetCursorLocation(0.5, 0.2)
end

function takeAnim()
    local ped = cache.ped
    lib.requestAnimDict("amb@prop_human_bum_bin@idle_b")
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
    Wait(2500)
    TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end

local openingDoor = false

function RobRegister()
    if currentRegister ~= 0 then
        TriggerServerEvent('prdx_storerobbery:server:setRegisterStatus', currentRegister)
        local lockpickTime = 25000
        LockpickDoorAnim(lockpickTime)
        QBCore.Functions.Progressbar("search_register", Lang:t("text.emptying_the_register"), lockpickTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "veh@break_in@0h@p_m_one@",
            anim = "low_force_entry_ds",
            flags = 16,
        }, {}, {}, function() -- Done
            openingDoor = false
            ClearPedTasks(cache.ped)
            TriggerServerEvent('prdx_storerobbery:server:takeMoney', currentRegister, true)
        end, function() -- Cancel
            openingDoor = false
            ClearPedTasks(cache.ped)
            QBCore.Functions.Notify(Lang:t("error.process_canceled"), "error")
            currentRegister = 0
        end)
        CreateThread(function()
            while openingDoor do
                TriggerServerEvent('hud:server:GainStress', math.random(1, 2))
                Wait(10000)
            end
        end)
    end
end

function LockpickDoorAnim(time)
    time = time / 1000
    lib.requestAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(cache.ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(cache.ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            TriggerServerEvent('prdx_storerobbery:server:takeMoney', currentRegister, false)
            if time <= 0 then
                openingDoor = false
                StopAnimTask(cache.ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
        currentRegister = 0
    end)
end

RegisterNUICallback('callcops', function(_, cb)
    local data = exports['cd_dispatch']:GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'}, --{'police', 'sheriff} 
        coords = data.coords,
        title = '10-68 - Commercial Alarm',
        message = 'A '..data.sex..' was reported breaking into registers at a store on '..data.street, 
        flash = 1, 
        unique_id = tostring(math.random(0000000,9999999)),
        blip = {
            sprite = 459, 
            scale = 1.5, 
            colour = 1,
            flashes = false, 
            text = '10-68 - Commercial Alarm',
            sound = 1,
        }
    })
    cb('ok')
end)

RegisterNetEvent('SafeCracker:EndMinigame', function(won)
    if currentSafe ~= 0 then
        if won then
            if currentSafe ~= 0 then
                if not Config.Safes[currentSafe].robbed then
                    SetNuiFocus(false, false)
                    TriggerServerEvent("prdx_storerobbery:server:SafeReward", currentSafe)
                    TriggerServerEvent("prdx_storerobbery:server:setSafeStatus", currentSafe)
                    currentSafe = 0
                    takeAnim()
                end
            else
                SendNUIMessage({
                    action = "kekw",
                })
            end
        end
    end
    copsCalled = false
end)

RegisterNUICallback('PadLockSuccess', function(_, cb)
    if currentSafe ~= 0 then
        if not Config.Safes[currentSafe].robbed then
            SendNUIMessage({
                action = "kekw",
            })
        end
    else
        SendNUIMessage({
            action = "kekw",
        })
    end
    cb('ok')
end)

RegisterNUICallback('PadLockClose', function(_, cb)
    SetNuiFocus(false, false)
    copsCalled = false
    cb('ok')
end)

RegisterNUICallback("CombinationFail", function(_, cb)
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
    cb("ok")
end)

RegisterNUICallback('fail', function(_ ,cb)
    if usingAdvanced then
        if math.random(1, 100) < 20 then
            TriggerServerEvent("prdx_storerobbery:server:removeAdvancedLockpick")
        end
    else
        if math.random(1, 100) < 40 then
            TriggerServerEvent("prdx_storerobbery:server:removeLockpick")
        end
    end
    if (IsWearingHandshoes() and math.random(1, 100) <= 25) then
        local pos = GetEntityCoords(cache.ped)
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        QBCore.Functions.Notify(Lang:t("error.you_broke_the_lock_pick"))
    end
    lockpick(false)
    cb('ok')
end)

RegisterNUICallback('exit', function(_, cb)
    lockpick(false)
    cb('ok')
end)

RegisterNUICallback('TryCombination', function(data, cb)
    QBCore.Functions.TriggerCallback('prdx_storerobbery:server:isCombinationRight', function(combination)
        if tonumber(data.combination) ~= nil then
            if tonumber(data.combination) == combination then
                TriggerServerEvent("prdx_storerobbery:server:SafeReward", currentSafe)
                TriggerServerEvent("prdx_storerobbery:server:setSafeStatus", currentSafe)
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = false,
                })
                currentSafe = 0
                takeAnim()
            else
                SetNuiFocus(false, false)
                SendNUIMessage({
                    action = "closeKeypad",
                    error = true,
                })
                currentSafe = 0
            end
        end
        cb("ok")
    end, currentSafe)
end)

RegisterNetEvent('prdx_storerobbery:client:setRegisterStatus', function(batch, val)
    -- Has to be a better way maybe like adding a unique id to identify the register
    if(type(batch) ~= "table") then
        Config.Registers[batch] = val
    else
        for k in pairs(batch) do
            Config.Registers[k] = batch[k]
        end
    end
end)

RegisterNetEvent('prdx_storerobbery:client:setSafeStatus', function(safe, bool)
    Config.Safes[safe].robbed = bool
end)

RegisterNetEvent('prdx_storerobbery:client:resetStoreRobbery', function(safe, bool)
    for k in ipairs(Config.Registers) do
        Config.Registers[k].time = 0
        Config.Registers[k].robbed = false
    end
    for k in ipairs(Config.Safes) do
        Config.Safes[k].robbed = false
    end
    copsCalled = false
    if DoesBlipExist(blip) then
        RemoveBlip(blip)
    end
end)

RegisterNetEvent('storerobbery:RequestMission', function()
    QBCore.Functions.TriggerCallback('RobberyTimer:CanStartRobbery', function(CanAccept)	
        if CanAccept then
            TriggerServerEvent('RobberyTimer:RobberyReserved', 'StoreRobbery')
            TriggerEvent('QBCore:Notify', "Mission queued", 'success')
            ChosenStore = Config.Safes[math.random(1, #Config.Safes)][1].xyz
            Wait(math.random(1,3) * 60000)
            PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", true)
            local s1, s2 = GetStreetNameAtCoord(ChosenStore.x, ChosenStore.y, ChosenStore.z)
            local street1 = GetStreetNameFromHashKey(s1)
            StoreBlip(ChosenStore)
            TriggerServerEvent('qb-phone:server:sendNewMail', {
                sender = 'anon-mouse',
                subject = "Information",
                message = "Check the store on " .. street1,
                button = {}
            })
        else
            TriggerEvent('QBCore:Notify', "\"Hey dude, I got nothing for you right now\"", 'error')
        end
    end, 'StoreRobbery')
end)