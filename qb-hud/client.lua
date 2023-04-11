local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local config = Config
local speedMultiplier = config.UseMPH and 2.23694 or 3.6
local seatbeltOn = false
local cruiseOn = false
local showAltitude = false
local showSeatbelt = false
local nos = 0
local stress = 0
local hunger = 100
local thirst = 100
local cashAmount = 0
local bankAmount = 0
local nitroActive = 0
local harness = 0
local hp = 100
local armed = 0
local parachute = -1
local oxygen = 100
local engine = 0
local dev = false
local playerDead = false
local showMenu = false
local showCircleB = false
local showSquareB = false
local isRadioTalking = false
local Menu = config.Menu
local CinematicHeight = 0.2
local CinematicToggle = false
local HideHud = false
local w = 0
local bleedLevel = 0

DisplayRadar(false)

local function CinematicShow(bool)
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    if bool then
        for i = CinematicHeight, 0, -1.0 do
            Wait(10)
            w = i
        end
    else
        for i = 0, CinematicHeight, 1.0 do
            Wait(10)
            w = i
        end
    end
end

local function loadSettings(settings)
    for k,v in pairs(settings) do
        if k == 'isToggleMapShapeChecked' then
            Menu.isToggleMapShapeChecked = v
            SendNUIMessage({ test = true, event = k, toggle = v})
        elseif k == 'isCineamticModeChecked' then
            Menu.isCineamticModeChecked = v
            CinematicShow(v)
            SendNUIMessage({ test = true, event = k, toggle = v})
        elseif k == 'isChangeFPSChecked' then
            Menu[k] = v
            local val = v and 'Optimized' or 'Synced'
            SendNUIMessage({ test = true, event = k, toggle = val})
        else
            Menu[k] = v
            SendNUIMessage({ test = true, event = k, toggle = v})
        end
    end
    QBCore.Functions.Notify(Lang:t("notify.hud_settings_loaded"), "success")
    Wait(1000)
    TriggerEvent("hud:client:LoadMap")
end

local function saveSettings()
    SetResourceKvp('hudSettings', json.encode(Menu))
end

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    Wait(2000)
    local hudSettings = GetResourceKvpString('hudSettings')
    if hudSettings then loadSettings(json.decode(hudSettings)) end
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent("QBCore:Client:OnPlayerUnload", function()
    PlayerData = {}
end)

RegisterNetEvent("QBCore:Player:SetPlayerData", function(val)
    PlayerData = val
end)

RegisterNetEvent("hud:client:CimenaticToggle", function()
    CinematicToggle = not CinematicToggle
    Menu.isCineamticModeChecked = CinematicToggle
    CinematicShow(CinematicToggle)
end)

RegisterNetEvent("hud:client:ToggleHud", function()
    SendNUIMessage({
        action = 'hideHud',
        hidden = HideHud,
    })
    HideHud = not HideHud 
    exports.npwd:setPhoneDisabled(HideHud)
end)

RegisterNetEvent("hud:client:HideHud", function(toggle)
    HideHud = not toggle
    exports.npwd:setPhoneDisabled(HideHud)
    SendNUIMessage({
        action = 'hideHud',
        hidden = HideHud,
    })
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    Wait(2000)
    local hudSettings = GetResourceKvpString('hudSettings')
    if hudSettings then loadSettings(json.decode(hudSettings)) end
end)

-- Callbacks & Events
RegisterCommand('hud', function()
    Wait(50)
    if showMenu then return end
    TriggerEvent("hud:client:playOpenMenuSounds")
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open"})
    showMenu = true
end)

RegisterNUICallback('closeMenu', function()
    Wait(50)
    TriggerEvent("hud:client:playCloseMenuSounds")
    showMenu = false
    SetNuiFocus(false, false)
end)


-- Reset hud
local function restartHud()
    TriggerEvent("hud:client:playResetHudSounds")
    QBCore.Functions.Notify(Lang:t("notify.hud_restart"), "error")
    if IsPedInAnyVehicle(PlayerPedId()) then
        Wait(2600)
        SendNUIMessage({ action = 'car', show = false })
        SendNUIMessage({ action = 'car', show = true })
    end
    Wait(2600)
    SendNUIMessage({ action = 'hudtick', show = false })
    SendNUIMessage({ action = 'hudtick', show = true })
    Wait(2600)
    QBCore.Functions.Notify(Lang:t("notify.hud_start"), "success")
end

RegisterNUICallback('restartHud', function()
    Wait(50)
    restartHud()
end)

RegisterCommand('resethud', function()
    Wait(50)
    restartHud()
end)

RegisterNUICallback('resetStorage', function()
    Wait(50)
    TriggerEvent("hud:client:resetStorage")
end)

RegisterNetEvent("hud:client:resetStorage", function()
    Wait(50)
    if Menu.isResetSoundsChecked then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.1)
    end
    QBCore.Functions.TriggerCallback('hud:server:getMenu', function(menu) loadSettings(menu); SetResourceKvp('hudSettings', json.encode(menu)) end)
end)

-- Notifications
RegisterNUICallback('openMenuSounds', function()
    Wait(50)
    Menu.isOpenMenuSoundsChecked = not Menu.isOpenMenuSoundsChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNetEvent("hud:client:playOpenMenuSounds", function()
    Wait(50)
    if not Menu.isOpenMenuSoundsChecked then return end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "monkeyopening", 0.5)
end)

RegisterNetEvent("hud:client:playCloseMenuSounds", function()
    Wait(50)
    if not Menu.isOpenMenuSoundsChecked then return end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "catclosing", 0.05)
end)

RegisterNUICallback('resetHudSounds', function()
    Wait(50)
    Menu.isResetSoundsChecked = not Menu.isResetSoundsChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNetEvent("hud:client:playResetHudSounds", function()
    Wait(50)
    if not Menu.isResetSoundsChecked then return end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.1)
end)

RegisterNUICallback('checklistSounds', function()
    Wait(50)
    TriggerEvent("hud:client:checklistSounds")
end)

RegisterNetEvent("hud:client:checklistSounds", function()
    Wait(50)
    Menu.isListSoundsChecked = not Menu.isListSoundsChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNetEvent("hud:client:playHudChecklistSound", function()
    Wait(50)
    if not Menu.isListSoundsChecked then return end
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "shiftyclick", 0.5)
end)

RegisterNUICallback('showOutMap', function()
    Wait(50)
    Menu.isOutMapChecked = not Menu.isOutMapChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('showOutCompass', function()
    Wait(50)
    Menu.isOutCompassChecked = not Menu.isOutCompassChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('showFollowCompass', function()
	Wait(50)
    Menu.isCompassFollowChecked = not Menu.isCompassFollowChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('showMapNotif', function()
    Wait(50)
    Menu.isMapNotifChecked = not Menu.isMapNotifChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('showFuelAlert', function()
    Wait(50)
    Menu.isLowFuelChecked = not Menu.isLowFuelChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('showCinematicNotif', function()
    Wait(50)
    Menu.isCinematicNotifChecked = not Menu.isCinematicNotifChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

-- Status
RegisterNUICallback('dynamicHealth', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleHealth")
end)

RegisterNetEvent("hud:client:ToggleHealth", function()
    Wait(50)
    Menu.isDynamicHealthChecked = not Menu.isDynamicHealthChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('dynamicArmor', function()
    Wait(50)
    Menu.isDynamicArmorChecked = not Menu.isDynamicArmorChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('dynamicHunger', function()
    Wait(50)
    Menu.isDynamicHungerChecked = not Menu.isDynamicHungerChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('dynamicThirst', function()
    Wait(50)
    Menu.isDynamicThirstChecked = not Menu.isDynamicThirstChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('dynamicStress', function()
    Wait(50)
    Menu.isDynamicStressChecked = not Menu.isDynamicStressChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('dynamicOxygen', function()
    Wait(50)
    Menu.isDynamicOxygenChecked = not Menu.isDynamicOxygenChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

-- Vehicle
RegisterNUICallback('changeFPS', function()
    Wait(50)
    Menu.isChangeFPSChecked = not Menu.isChangeFPSChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('HideMap', function()
    Wait(50)
    Menu.isHideMapChecked = not Menu.isHideMapChecked
    DisplayRadar(not Menu.isHideMapChecked)
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNetEvent("hud:client:LoadMap", function()
    Wait(50)
    -- Credit to Dalrae for the solve.
    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end
    if Menu.isToggleMapShapeChecked == "square" then
        RequestStreamedTextureDict("squaremap", false)
        if not HasStreamedTextureDictLoaded("squaremap") then
            Wait(150)
        end
        if Menu.isMapNotifChecked then
            QBCore.Functions.Notify(Lang:t("notify.load_square_map"))
        end
        SetMinimapClipType(0)
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
        -- 0.0 = nav symbol and icons left
        -- 0.1638 = nav symbol and icons stretched
        -- 0.216 = nav symbol and icons raised up
        SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)

        -- icons within map
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)

        -- -0.01 = map pulled left
        -- 0.025 = map raised up
        -- 0.262 = map stretched
        -- 0.315 = map shorten
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01 + minimapOffset, 0.025, 0.262, 0.300)
        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetRadarBigmapEnabled(true, false)
        SetMinimapClipType(0)
        Wait(50)
        SetRadarBigmapEnabled(false, false)
        if Menu.isToggleMapBordersChecked then
            showCircleB = false
            showSquareB = true
        end
        Wait(1200)
        if Menu.isMapNotifChecked then
            QBCore.Functions.Notify(Lang:t("notify.loaded_square_map"))
        end
    elseif Menu.isToggleMapShapeChecked == "circle" then
        RequestStreamedTextureDict("circlemap", false)
        if not HasStreamedTextureDictLoaded("circlemap") then
            Wait(150)
        end
        if Menu.isMapNotifChecked then
            QBCore.Functions.Notify(Lang:t("notify.load_circle_map"))
        end
        SetMinimapClipType(1)
        AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
        AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
        -- -0.0100 = nav symbol and icons left
        -- 0.180 = nav symbol and icons stretched
        -- 0.258 = nav symbol and icons raised up
        SetMinimapComponentPosition("minimap", "L", "B", -0.0100 + minimapOffset, -0.030, 0.180, 0.258)

        -- icons within map
        SetMinimapComponentPosition("minimap_mask", "L", "B", 0.200 + minimapOffset, 0.0, 0.065, 0.20)

        -- -0.00 = map pulled left
        -- 0.015 = map raised up
        -- 0.252 = map stretched
        -- 0.338 = map shorten
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.00 + minimapOffset, 0.015, 0.252, 0.338)
        SetBlipAlpha(GetNorthRadarBlip(), 0)
        SetMinimapClipType(1)
        SetRadarBigmapEnabled(true, false)
        Wait(50)
        SetRadarBigmapEnabled(false, false)
        if Menu.isToggleMapBordersChecked then
            showSquareB = false
            showCircleB = true
        end
        Wait(1200)
        if Menu.isMapNotifChecked then
            QBCore.Functions.Notify(Lang:t("notify.loaded_circle_map"))
        end
    end
end)

RegisterNUICallback('ToggleMapShape', function()
    Wait(50)
    if not Menu.isHideMapChecked then
        Menu.isToggleMapShapeChecked = Menu.isToggleMapShapeChecked == "circle" and "square" or "circle"
        Wait(50)
        TriggerEvent("hud:client:LoadMap")
    end
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('ToggleMapBorders', function()
    Wait(50)
    Menu.isToggleMapBordersChecked = not Menu.isToggleMapBordersChecked
    if Menu.isToggleMapBordersChecked then
        if Menu.isToggleMapShapeChecked == "square" then
            showSquareB = true
        else
            showCircleB = true
        end
    else
        showSquareB = false
        showCircleB = false
    end
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('dynamicEngine', function()
    Wait(50)
    Menu.isDynamicEngineChecked = not Menu.isDynamicEngineChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('dynamicNitro', function()
    Wait(50)
    Menu.isDynamicNitroChecked = not Menu.isDynamicNitroChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

-- Compass
RegisterNUICallback('showCompassBase', function()
	Wait(50)
    Menu.isCompassShowChecked = not Menu.isCompassShowChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('showStreetsNames', function()
	Wait(50)
    Menu.isShowStreetsChecked = not Menu.isShowStreetsChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('showPointerIndex', function()
	Wait(50)
    Menu.isPointerShowChecked = not Menu.isPointerShowChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('showDegreesNum', function()
	Wait(50)
    Menu.isDegreesShowChecked = not Menu.isDegreesShowChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('changeCompassFPS', function()
	Wait(50)
    Menu.isChangeCompassFPSChecked = not Menu.isChangeCompassFPSChecked
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNUICallback('cinematicMode', function()
    Wait(50)
    if Menu.isCineamticModeChecked then
        CinematicShow(false)
        Menu.isCineamticModeChecked = false
        if Menu.isCinematicNotifChecked then
            QBCore.Functions.Notify(Lang:t("notify.cinematic_off"), 'error')
        end
        DisplayRadar(1)
    else
        CinematicShow(true)
        Menu.isCineamticModeChecked = true
        if Menu.isCinematicNotifChecked then
            QBCore.Functions.Notify(Lang:t("notify.cinematic_on"))
        end
    end
    TriggerEvent("hud:client:playHudChecklistSound")
    saveSettings()
end)

RegisterNetEvent("hud:client:EngineHealth", function(newEngine)
    engine = newEngine
end)

RegisterNetEvent('hud:client:ToggleAirHud', function()
    showAltitude = not showAltitude
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst, newStress) -- Triggered in qb-core
    if newHunger then
        hunger = newHunger
    end
    if newThirst then
        thirst = newThirst
    end
    if newStress then
        stress = newStress
    end
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress) -- Add this event with adding stress elsewhere
    stress = newStress
end)

RegisterNetEvent('hud:client:ToggleShowSeatbelt', function()
    showSeatbelt = not showSeatbelt
end)

RegisterNetEvent('seatbelt:client:ToggleSeatbelt', function(isOn) -- Triggered in smallresources
    seatbeltOn = isOn
end)

RegisterNetEvent('seatbelt:client:ToggleHarness', function(isOn)
    seatbeltOn = isOn
    harness = isOn
end)


RegisterNetEvent('seatbelt:client:ToggleCruise', function() -- Triggered in smallresources
    cruiseOn = not cruiseOn
end)

RegisterNetEvent('hud:client:UpdateNitrous', function(hasNitro, nitroLevel, bool)
    if hasNitro then
        nos = nitroLevel
        nitroActive = bool
        Menu.isDynamicNitroChecked = false
    else
        nos = 0
        nitroActive = false
        Menu.isDynamicNitroChecked = true
    end
end)

RegisterNetEvent("qb-admin:client:ToggleDevmode", function()
    dev = not dev
    local ply = PlayerId()
    local ped = PlayerPedId()
    AnimpostfxStopAll()
    if dev then
        SetEveryoneIgnorePlayer(ply, true)
        SetPlayerInvincible(ply, true)
        SetPlayerMaxStamina(ply, 99999)
        SetPedCanRagdoll(ped, false)
        SetRunSprintMultiplierForPlayer(ply, 1.49)
        SetSwimMultiplierForPlayer(ply, 1.49)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 99999)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 99999)
        TriggerEvent('pausePopulation', true)
        SetEntityProofs(ped, true, true, true, true, true, true, true, true)
        QBCore.Functions.Notify('Developer Mode Enabled')
    else
        SetEveryoneIgnorePlayer(ply, false)
        SetPlayerInvincible(ply, false)
        SetPlayerMaxStamina(ply, 100)
        SetRunSprintMultiplierForPlayer(ply, 1.0)
        SetSwimMultiplierForPlayer(ply, 1.0)
        SetPedCanRagdoll(ped, true)
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 100)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 100)
        TriggerEvent('pausePopulation', false)
        SetEntityProofs(ped, false, false, false, false, false, false, false, false)
        QBCore.Functions.Notify('Developer Mode Disabled')
    end
end)

local function IsWhitelistedWeaponArmed(weapon)
    if weapon then
        for _, v in pairs(config.WhitelistedWeaponArmed) do
            if weapon == v then
                return true
            end
        end
    end
    return false
end

local prevPlayerStats = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }

local function updatePlayerHud(data)
    local shouldUpdate = false
    for k, v in pairs(data) do
        if prevPlayerStats[k] ~= v then
            shouldUpdate = true
            break
        end
    end
    prevPlayerStats = data
    if shouldUpdate then
        SendNUIMessage({
            action = 'hudtick',
            show = data[1],
            dynamicHealth = data[2],
            dynamicArmor = data[3],
            dynamicHunger = data[4],
            dynamicThirst = data[5],
            dynamicStress = data[6],
            dynamicOxygen = data[7],
            dynamicEngine = data[8],
            dynamicNitro = data[9],
            health = data[10],
            playerDead = data[11],
            armor = data[12],
            thirst = data[13],
            hunger = data[14],
            stress = data[15],
            voice = data[16],
            radio = data[17],
            talking = data[18],
            armed = data[19],
            oxygen = data[20],
            parachute = data[21],
            nos = data[22],
            cruise = data[23],
            nitroActive = data[24],
            harness = data[25],
            hp = data[26],
            speed = data[27],
            engine = data[28],
            cinematic = data[29],
            dev = data[30],
            isRadioTalking = data[31],
            bleed = data[32],
            toxicity = data[33]
        })
    end
end

local prevVehicleStats = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }

local function updateVehicleHud(data)
    local shouldUpdate = false
    for k, v in pairs(data) do
        if prevVehicleStats[k] ~= v then shouldUpdate = true break end
    end
    prevVehicleStats = data
    if shouldUpdate then
        SendNUIMessage({
            action = 'car',
            show = data[1],
            isPaused = data[2],
            seatbelt = data[3],
            speed = data[4],
            fuel = data[5],
            altitude = data[6],
            showAltitude = data[7],
            showSeatbelt = data[8],
            showSquareB = data[9],
            showCircleB = data[10],
        })
    end
end

local lastFuelUpdate = 0
local lastFuelCheck = {}

local function getFuelLevel(vehicle)
    local updateTick = GetGameTimer()
    if (updateTick - lastFuelUpdate) > 2000 then
        lastFuelUpdate = updateTick
        lastFuelCheck = math.floor(exports['ps-fuel']:GetFuel(vehicle))
    end
    return lastFuelCheck
end

AddEventHandler('pma-voice:radioActive', function(enabled)
    isRadioTalking = enabled
end)

-- HUD Update loop

CreateThread(function()
    local wasInVehicle = false
    while true do
        if Menu.isChangeFPSChecked then
            Wait(500)
        else
            Wait(50)
        end
        if LocalPlayer.state.isLoggedIn then
            local show = true
            local player = PlayerPedId()
            local playerId = PlayerId()
            local weapon = GetSelectedPedWeapon(player)
            -- Player hud
            if not Config.WhitelistedWeaponArmed[weapon] then
                if weapon ~= `WEAPON_UNARMED` then
                    armed = true
                else
                    armed = false
                end
            end
            playerDead = IsEntityDead(player) or Entity(player).state.isDead or false
            playerHealth = GetEntityHealth(player) - 100
            if playerDead then playerHealth = 0.0 end

            parachute = GetPedParachuteState(player)
            -- Oxygen
            if IsEntityInWater(player) then
                oxygen = (GetPlayerUnderwaterTimeRemaining(playerId) * 10) / 3
            end
            -- Player hud
            local talking = NetworkIsPlayerTalking(playerId)

            if not IsEntityInWater(player) then
                oxygen = 100
            end
            local voice = 0
            if LocalPlayer.state['proximity'] then
                voice = LocalPlayer.state['proximity'].distance
            end
            if IsPauseMenuActive() then
                show = false
            end

            local vehicle = GetVehiclePedIsIn(player)

            if not (IsPedInAnyVehicle(player) and not IsThisModelABicycle(vehicle)) then
                updatePlayerHud({
                    show,
                    Menu.isDynamicHealthChecked,
                    Menu.isDynamicArmorChecked,
                    Menu.isDynamicHungerChecked,
                    Menu.isDynamicThirstChecked,
                    Menu.isDynamicStressChecked,
                    Menu.isDynamicOxygenChecked,
                    Menu.isDynamicEngineChecked,
                    Menu.isDynamicNitroChecked,
                    playerHealth,
                    playerDead,
                    GetPedArmour(player),
                    thirst,
                    hunger,
                    stress,
                    voice,
                    LocalPlayer.state['radioChannel'],
                    talking,
                    armed,
                    oxygen,
                    GetPedParachuteState(player),
                    -1,
                    cruiseOn,
                    nitroActive,
                    harness,
                    hp,
                    math.floor(GetEntitySpeed(vehicle) * speedMultiplier),
                    -1,
                    Menu.isCineamticModeChecked,
                    dev,
                    isRadioTalking,
                    bleedLevel,
                    toxicityLevel,
                })
            end

            -- Vehicle hud
            if IsPedInAnyHeli(player) or IsPedInAnyPlane(player) then
                showAltitude = true
                showSeatbelt = false
            end
            if IsPedInAnyVehicle(player) and not IsThisModelABicycle(vehicle) then
                if not wasInVehicle then
                    DisplayRadar(true)
                end
                wasInVehicle = true
                updatePlayerHud({
                    show,
                    Menu.isDynamicHealthChecked,
                    Menu.isDynamicArmorChecked,
                    Menu.isDynamicHungerChecked,
                    Menu.isDynamicThirstChecked,
                    Menu.isDynamicStressChecked,
                    Menu.isDynamicOxygenChecked,
                    Menu.isDynamicEngineChecked,
                    Menu.isDynamicNitroChecked,
                    playerHealth,
                    playerDead,
                    GetPedArmour(player),
                    thirst,
                    hunger,
                    stress,
                    voice,
                    LocalPlayer.state['radioChannel'],
                    talking,
                    armed,
                    oxygen,
                    GetPedParachuteState(player),
                    nos,
                    cruiseOn,
                    nitroActive,
                    harness,
                    hp,
                    math.ceil(GetEntitySpeed(vehicle) * speedMultiplier),
                    (GetVehicleEngineHealth(vehicle) / 10),
                    Menu.isCineamticModeChecked,
                    dev,
                    isRadioTalking,
                    bleedLevel,
                    toxicityLevel,
                })
                updateVehicleHud({
                    show,
                    IsPauseMenuActive(),
                    seatbeltOn,
                    math.ceil(GetEntitySpeed(vehicle) * speedMultiplier),
                    getFuelLevel(vehicle),
                    math.ceil(GetEntityHeightAboveGround(vehicle)*3.281),
                    showAltitude,
                    showSeatbelt,
                    showSquareB,
                    showCircleB,
                })
                showAltitude = false
                showSeatbelt = true
            else
                if wasInVehicle then
                    wasInVehicle = false
                    SendNUIMessage({
                        action = 'car',
                        show = false,
                        seatbelt = false,
                        cruise = false,
                    })
                    seatbeltOn = false
                    cruiseOn = false
                    harness = false
                end
                DisplayRadar(false)
            end
        else
            SendNUIMessage({
                action = 'hudtick',
                show = false
            })
        end
    end
end)

-- Low fuel
CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                if exports['ps-fuel']:GetFuel(GetVehiclePedIsIn(ped, false)) <= 20 then -- At 20% Fuel Left
                    if Menu.isLowFuelChecked then
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "pager", 0.10)
                        QBCore.Functions.Notify(Lang:t("notify.low_fuel"), "error")
                        Wait(60000) -- repeats every 1 min until empty
                    end
                end
            end
        end
        Wait(10000)
    end
end)
-- Money HUD

RegisterNetEvent('prdx_healthsystem:client:bleedingSync', function(level)
    bleedLevel = level
end)

RegisterNetEvent('hud:client:updateToxicity', function(level)
    toxicityLevel = level
end)

RegisterNetEvent('hud:client:ShowAccounts', function(type, amount)
    if type == 'cash' then
        SendNUIMessage({
            action = 'show',
            type = 'cash',
            cash = amount
        })
    else
        SendNUIMessage({
            action = 'show',
            type = 'bank',
            bank = amount
        })
    end
end)

RegisterNetEvent('hud:client:OnMoneyChange', function(moneytype, amount, isMinus)
    if moneytype == 'cash' or moneytype == 'bank' then
        cashAmount = PlayerData.money['cash']
        bankAmount = PlayerData.money['bank']
        SendNUIMessage({
            action = 'updatemoney',
            cash = cashAmount,
            bank = bankAmount,
            amount = amount,
            minus = isMinus,
            type = moneytype
        })
    end
end)

-- Stress Gain

CreateThread(function() -- Speeding
    while true do
        if LocalPlayer.state.isLoggedIn then
            local PlayerData = QBCore.Functions.GetPlayerData()
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local veh = GetVehiclePedIsIn(ped, false)
                local speed = GetEntitySpeed(veh) * speedMultiplier
                local class = GetVehicleClass(veh)
                local stressSpeed = seatbeltOn and config.MinimumSpeed or config.MinimumSpeedUnbuckled
                if (speed >= stressSpeed) and (class ~= 8 and class ~= 13 and class ~= 14 and class ~= 15 and class ~= 16) then
                    if PlayerData.job.name == "lspd" or PlayerData.job.name == "bcso" or PlayerData.job.name == "sast" or PlayerData.job.name == "hc" or PlayerData.job.name == "marshalls" or PlayerData.job.name == "pd_cid" or harness then return end
                    TriggerServerEvent('hud:server:GainStress', math.random(1, 2))
                end
            end
        end
        Wait(15000)
    end
end)

local function IsWhitelistedWeaponStress(weapon)
    if weapon then
        for _, v in pairs(config.WhitelistedWeaponStress) do
            if weapon == v then
                return true
            end
        end
    end
    return false
end

local function IsWeaponRelivingStress(weapon)
    if weapon then
        for _, v in pairs(config.RelieveWeaponStress) do
            if weapon == v then
                return true
            end
        end
    end
    return false
end

CreateThread(function() -- Shooting
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local weapon = GetSelectedPedWeapon(ped)
            if weapon ~= `WEAPON_UNARMED` then
                if IsPedShooting(ped) and IsWeaponRelivingStress(weapon) then
                    if math.random(0,1) < config.StressChance then
                        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
                        Wait(5000)
                    end
                elseif IsPedShooting(ped) and not IsWhitelistedWeaponStress(weapon) then
                    if math.random(0,1) < config.StressChance then
                        TriggerServerEvent('hud:server:GainStress', math.random(2, 4))
                        Wait(5000)
                    end
                end
            else
                Wait(5000)
            end
        end
        Wait(8)
    end
end)

-- Stress Screen Effects

local function GetBlurIntensity(stresslevel)
    for k, v in pairs(config.Intensity['blur']) do
        if stresslevel >= v.min and stresslevel <= v.max then
            return v.intensity
        end
    end
    return 1500
end

local function GetEffectInterval(stresslevel)
    if stresslevel then
        for k, v in pairs(config.EffectInterval) do
            if stresslevel >= v.min and stresslevel <= v.max then
                return v.timeout
            end
        end
        return 60000
    else
        return 60000
    end
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local effectInterval = GetEffectInterval(stress)
        if stress >= 80 then
            local BlurIntensity = GetBlurIntensity(stress)
            local FallRepeat = math.random(2, 4)
            local RagdollTimeout = FallRepeat * 1750
            TriggerScreenblurFadeIn(1000.0)
            Wait(BlurIntensity)
            TriggerScreenblurFadeOut(1000.0)
            Wait(1000)
            for i = 1, FallRepeat, 1 do
                Wait(750)
                TriggerScreenblurFadeIn(1000.0)
                Wait(BlurIntensity)
                TriggerScreenblurFadeOut(1000.0)
            end
        elseif stress >= config.MinimumStress then
            local BlurIntensity = GetBlurIntensity(stress)
            TriggerScreenblurFadeIn(1000.0)
            Wait(BlurIntensity)
            TriggerScreenblurFadeOut(1000.0)
        end
        Wait(effectInterval)
    end
end)

-- Minimap update
CreateThread(function()
    while true do
        SetRadarBigmapEnabled(false, false)
        SetRadarZoom(4000)
        DontTiltMinimapThisFrame()
        
        Wait(0)
    end
end)

local function BlackBars()
    DrawRect(0.0, 0.0, 2.0, w, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, w, 0, 0, 0, 255)
end

CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    if not HasScaleformMovieLoaded(minimap) then
        RequestScaleformMovie(minimap)
        while not HasScaleformMovieLoaded(minimap) do
            Wait(1)
        end
    end
    while true do
        if w > 0 then
            BlackBars()
            DisplayRadar(false)
            SendNUIMessage({
                action = 'hudtick',
                show = false,
            })
            SendNUIMessage({
                action = 'car',
                show = false,
            })
        end
        Wait(0)
    end
end)

-- Compass
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num + 0.5 * mult)
end

local prevBaseplateStats = { nil, nil, nil, nil, nil, nil, nil}

local function updateBaseplateHud(data)
    local shouldUpdate = false
    for k, v in pairs(data) do
        if prevBaseplateStats[k] ~= v then shouldUpdate = true break end
    end
    prevBaseplateStats = data
    if shouldUpdate then
        SendNUIMessage ({
            action = 'baseplate',
            show = data[1],
            street1 = data[2],
            street2 = data[3],
            showCompass = data[4],
            showStreets = data[5],
            showPointer = data[6],
            showDegrees = data[7],
        })
    end
end

local lastCrossroadUpdate = 0
local lastCrossroadCheck = {}

local function getCrossroads(player)
    local updateTick = GetGameTimer()
    if updateTick - lastCrossroadUpdate > 1500 then
        local pos = GetEntityCoords(player)
        local street1, street2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
        lastCrossroadUpdate = updateTick
        lastCrossroadCheck = { GetStreetNameFromHashKey(street1), GetStreetNameFromHashKey(street2) }
    end
    return lastCrossroadCheck
end

-- Compass Update loop

CreateThread(function()
	local heading, lastHeading = 0, 1
	while true do
        if Menu.isChangeCompassFPSChecked then
            Wait(50)
        else
            Wait(0)
        end
        local show = true
        local player = PlayerPedId()
        local camRot = GetGameplayCamRot(0)
        if Menu.isCompassFollowChecked then
            heading = tostring(round(360.0 - ((camRot.z + 360.0) % 360.0)))
        else
            heading = tostring(round(360.0 - GetEntityHeading(player)))
        end
		if heading == '360' then heading = '0' end
            if heading ~= lastHeading then
			    if IsPedInAnyVehicle(player) then
                    local crossroads = getCrossroads(player)
                    SendNUIMessage ({ 
                        action = 'update', 
                        value = heading 
                    })
                    updateBaseplateHud({
                        show,
                        crossroads[1],
                        crossroads[2],
                        Menu.isCompassShowChecked,
                        Menu.isShowStreetsChecked,
                        Menu.isPointerShowChecked,
                        Menu.isDegreesShowChecked,
                    })
			    else
                    if Menu.isOutCompassChecked then
                        SendNUIMessage ({ 
                            action = 'update', 
                            value = heading 
                        })
                        SendNUIMessage ({
                            action = 'baseplate',
                            show = true,
                            showCompass = true,
                        })
                    else
                        SendNUIMessage ({
                            action = 'baseplate',
                            show = false,
                        })
                    end
			    end
	        end
		    lastHeading = heading
	    end
end)
