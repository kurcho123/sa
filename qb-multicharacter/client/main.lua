local cam = nil
local charPed = nil
local QBCore = exports['qb-core']:GetCoreObject()

-- Main Thread

CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsSessionStarted() and not LocalPlayer.state.isLoggedIn then
			TriggerEvent('qb-multicharacter:client:chooseChar')
            StartAudioScene('MP_MENU_SCENE')
			return
		end
	end
end)

-- Functions

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Wait(1)
	end
end

local function skyCam(bool)
    TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999})
    TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(PlayerPedId(), false)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", Config.CamCoords.x, Config.CamCoords.y, Config.CamCoords.z, 0.0 ,0.0, Config.CamCoords.w, 60.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    else
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
    end
end

local function openCharMenu(bool)
    SetNuiFocus(bool, bool)
    QBCore.Functions.TriggerCallback("qb-multi:server:GetCurrentPlayers", function(Players)
        SendNUIMessage({
            action = "ui",
            toggle = bool,
            players = Players,
        })
        skyCam(bool)
    end)
end

-- Events

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    SendNUIMessage({
        action = "stopMusic"
    })
    StopAudioScenes()
end)

RegisterNetEvent('qb-multicharacter:client:closeNUIdefault', function() -- This event is only for no starting apartments
    DeleteEntity(charPed)
    SetNuiFocus(false, false)
    DoScreenFadeOut(500)
    Wait(2000)
    SetEntityCoords(PlayerPedId(), Config.DefaultSpawn.x, Config.DefaultSpawn.y, Config.DefaultSpawn.z)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
    TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    Wait(500)
    openCharMenu()
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
    TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
    TriggerEvent('qb-clothes:client:CreateFirstCharacter')
end)

RegisterNetEvent('qb-multicharacter:client:closeNUI', function()
    DeleteEntity(charPed)
    SetNuiFocus(false, false)
end)

RegisterNetEvent('qb-multicharacter:client:chooseChar', function()
	TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999}) -- Set time to night (activate lights), and weather to clear
    TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
    SetNuiFocus(false, false)
    DoScreenFadeOut(10)
    Wait(1000)
    local interior = GetInteriorAtCoords(Config.Interior.x, Config.Interior.y, Config.Interior.z - 18.9)
    LoadInterior(interior)
    while not IsInteriorReady(interior) do
        Wait(1000)
    end
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), Config.HiddenCoords.x, Config.HiddenCoords.y, Config.HiddenCoords.z)
    Wait(1500)
    openCharMenu(true)
    Wait(500)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    LoadAnim("timetable@reunited@ig_10")
    TriggerEvent('prdx_loading:disableLoading')
end)

-- NUI Callbacks

RegisterNUICallback('closeUI', function()
    openCharMenu(false)
end)

RegisterNUICallback('disconnectButton', function()
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    TriggerServerEvent('qb-multicharacter:server:disconnect')
end)

RegisterNUICallback('selectCharacter', function(data)
    if not chosen then
        chosen = true
        local cData = data.cData
        DoScreenFadeOut(500)
        Wait(500)
        TriggerServerEvent('qb-multicharacter:server:loadUserData', cData)
        openCharMenu(false)
        SetEntityAsMissionEntity(charPed, true, true)
        DeleteEntity(charPed) 
    end
end)

RegisterNUICallback('cDataPed', function(data)
    local cData = data.cData  
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    if cData ~= nil then
        QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(data)
            model = data.model ~= nil and tonumber(data.model) or false
            if model ~= nil then
                CreateThread(function()
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(0)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 5.98, Config.PedCoords.w, false, true)
                    FreezeEntityPosition(charPed, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    TriggerEvent('raid_clothes:setclothes', data, 1, charPed, cData.citizenid)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                    SetEntityInvincible(charPed, true)
                    --TaskPlayAnim(charPed, "timetable@reunited@ig_10", "base_amanda", 1000.0, 1000.0, -1, 1, 0, false, false, false)
                    Wait(300)
                    SetEntityCoords(charPed, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98)
                    TaskStartScenarioInPlace(charPed, 'WORLD_HUMAN_HANG_OUT_STREET', 0, true)
                end)
            else
                CreateThread(function()
                    local randommodels = {
                        "mp_m_freemode_01",
                        "mp_f_freemode_01",
                    }
                    local model = joaat(randommodels[math.random(1, #randommodels)])
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(0)
                    end
                    charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
                    SetPedComponentVariation(charPed, 0, 0, 0, 2)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    PlaceObjectOnGroundProperly(charPed)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                end)
            end
        end, cData.citizenid)
    else
        CreateThread(function()
            local randommodels = {
                "mp_m_freemode_01",
                "mp_f_freemode_01",
            }
            local model = joaat(randommodels[math.random(1, #randommodels)])
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            charPed = CreatePed(2, model, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z - 0.98, Config.PedCoords.w, false, true)
            SetPedComponentVariation(charPed, 0, 0, 0, 2)
            FreezeEntityPosition(charPed, false)
            SetEntityInvincible(charPed, true)
            PlaceObjectOnGroundProperly(charPed)
            SetBlockingOfNonTemporaryEvents(charPed, true)
        end)
    end
end)

RegisterNUICallback('setupCharacters', function()
    chosen = false
    QBCore.Functions.TriggerCallback("qb-multicharacter:server:setupCharacters", function(result)
        Wait(250)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
    end)
end)

RegisterNUICallback('removeBlur', function()
    SetTimecycleModifier('default')
end)

RegisterNUICallback('createNewCharacter', function(data)
    local cData = data
    DoScreenFadeOut(150)
    if cData.gender == "Male" then
        cData.gender = 0
    elseif cData.gender == "Female" then
        cData.gender = 1
    end
    TriggerServerEvent('qb-multicharacter:server:createCharacter', cData)
    Wait(500)
end)

RegisterNUICallback('removeCharacter', function(data)
    TriggerServerEvent('qb-multicharacter:server:deleteCharacter', data.citizenid)
    TriggerEvent('qb-multicharacter:client:chooseChar')
end)

RegisterCommand('campos', function(source, args)
    local camPos = GetGameplayCamCoords()
    local camRot = GetGameplayCamRot_2()
    print(camPos, camRot)
end, false)
