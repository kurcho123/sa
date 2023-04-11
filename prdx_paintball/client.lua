-- #region Global Variables
QBCore = exports['qb-core']:GetCoreObject()
local Team
local inProgress = false
local out = false
local FullOut = false
local scoreBoardEnabled = false
local inArena = false

local MainZone
local SetupZone
local RespawnZone

-- #endregion

-- #region Functions

function SetupZones()
    -- Destroy zones if they exist already
    if MainZone then MainZone:destroy() end
    if SetupZone then SetupZone:destroy() end
    if RespawnZone then RespawnZone:destroy() end

    MainZone = PolyZone:Create(Config.PaintballZone, 
    {
        name = "PaintballMain",
        debugPoly = Config.Debug,
        minZ = 200.0,
        maxZ = 237.0
    })

    SetupZone = PolyZone:Create(Config.SetupZone, 
    {
        name = "PaintballSetup",
        debugPoly = Config.Debug,
        minZ = 211.0,
        maxZ = 215.0
    })

    RespawnZone = PolyZone:Create(Config.RespawnZone, 
    {
        name= "PaintballRespawn",
        debugPoly = Config.Debug,
        minZ = 201.0,
        maxZ = 250.0
    })

    MainZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inArena = true
        else
            LeaveArea()
            inArena = false
        end
    end)
    
    SetupZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            AddRadialMenuOptions()
        else
            RemoveRadialMenuOptions()
        end
    end)
    
    RespawnZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            if Team and inProgress then
                TriggerServerEvent('prdx_paintball:server:playerRespawned')
            end
            out = false
            Wait(2000)
            if IsEntityPlayingAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_base', 3) then
                ClearPedTasks(PlayerPedId())
            end
        end
    end)
end

function DestroyZones()
    if MainZone then MainZone:destroy() end
    if SetupZone then SetupZone:destroy() end
    if RespawnZone then RespawnZone:destroy() end
end

function AddRadialMenuOptions()
    local items = {}
    if not inProgress then
        items = {
            {
                label = 'Join Green Team',
                icon = 'people-group',
                onSelect = function()
                    TriggerEvent('prdx_paintball:client:joinTeam', 'green')
                end
            },
            {
                label = 'Join Blue Team',
                icon = 'people-group',
                onSelect = function()
                    TriggerEvent('prdx_paintball:client:joinTeam', 'blue')
                end
            },
            {
                label = 'Join Red Team',
                icon = 'people-group',
                onSelect = function()
                    TriggerEvent('prdx_paintball:client:joinTeam', 'red')
                end
            },
            {
                label = 'Join White Team',
                icon = 'people-group',
                onSelect = function()
                    TriggerEvent('prdx_paintball:client:joinTeam', 'white')
                end
            },
            {
                label = 'Leave Team',
                icon = 'door-open',
                onSelect = function()
                    TriggerEvent('prdx_paintball:client:leaveTeam')
                end
            },
        }
    else
        items = {
            {
                label = 'Leave Team',
                icon = 'door-open',
                onSelect = function()
                    TriggerEvent('prdx_paintball:client:leaveTeam')
                end
            }
        }
    end
    lib.addRadialItem({
        {
          id = 'paintball',
          label = 'Paintball Options',
          icon = 'baseball',
          menu = 'paintball_options_menu'
        }
    })
    lib.registerRadial({
        id = 'paintball_options_menu',
        items = items
    })
end

function RemoveRadialMenuOptions()
    lib.removeRadialItem('paintball')
end

function AddToTeam(team)
    Team = team
    local gender = "male"
    if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then gender = "female" end
    TriggerEvent('raid_clothes:client:loadOutfit', exports["raid_clothes"]:GetOutfit("paintball", gender, team))
    TriggerServerEvent('prdx_paintball:server:initializePlayer', team)
end

function RemoveFromTeam()
    if Team then
        QBCore.Functions.Notify('You left the arena!', "error")
        Team = nil
        TriggerServerEvent('raid_clothes:get_character_current')
        TriggerServerEvent('prdx_paintball:server:terminatePlayer')
    end
end

function LeaveArea()
    Wait(2000)
    if IsEntityPlayingAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_base', 3) then
        ClearPedTasks(PlayerPedId())
    end
    RemoveFromTeam()
end

function DoCountdown()
	local canceled = false
    local countFrom = 3
	CreateThread(function()
        local scaleform = RequestScaleformMovie("COUNTDOWN")
        while not HasScaleformMovieLoaded(scaleform) do
            Wait(0)
        end
        
        for i=countFrom,1,-1 do
            PlaySoundFrontend(-1, "Countdown_1", "DLC_Stunt_Race_Frontend_Sounds", false)
            PushScaleformMovieFunction(scaleform, "SET_MESSAGE")
            PushScaleformMovieFunctionParameterString(tostring(i))
            PushScaleformMovieFunctionParameterInt(240)
            PushScaleformMovieFunctionParameterInt(200)
            PushScaleformMovieFunctionParameterInt(80)
            PushScaleformMovieFunctionParameterBool(true) -- isMP
            PopScaleformMovieFunctionVoid()
            local starttime = GetNetworkTime()
            while GetNetworkTime() - starttime < 1000 do
                DrawScaleformMovieFullscreen(scaleform, 255,255,100,20)
                Wait(0)
            end
        end
        local r, g, b, _ = GetHudColour(18)
        PlaySoundFrontend(-1, "Checkpoint_Finish", "DLC_Stunt_Race_Frontend_Sounds", true)
        PushScaleformMovieFunction(scaleform, "SET_MESSAGE")
        PushScaleformMovieFunctionParameterString("CNTDWN_GO")
        PushScaleformMovieFunctionParameterInt(r)
        PushScaleformMovieFunctionParameterInt(g)
        PushScaleformMovieFunctionParameterInt(b)
        PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunctionVoid()
        local starttime = GetNetworkTime()
        while GetNetworkTime() - starttime < 1000 and not canceled do
            DrawScaleformMovieFullscreen(scaleform, 255,255,100,20)
            Wait(0)
        end
        inProgress = true
        RemoveRadialMenuOptions()
        AddRadialMenuOptions()
        return
	end)
end

-- #endregion

-- #region Events

-- #region load/unload
AddEventHandler('onResourceStop', function(resourcename)
    if GetCurrentResourceName() ~= resourcename then return end
    if not LocalPlayer.state['isLoggedIn'] then return end
    RemoveRadialMenuOptions()
    LeaveArea()
    inArena = false
    DestroyZones()
end)

AddEventHandler('onResourceStart', function(resourcename)
    if GetCurrentResourceName() ~= resourcename then return end
    if not LocalPlayer.state['isLoggedIn'] then return end
    RemoveRadialMenuOptions()
    LeaveArea()
    inArena = false
    SetupZones()
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    SetupZones()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    RemoveRadialMenuOptions()
    LeaveArea()
    inArena = false
    DestroyZones()
end)
-- #endregion

RegisterNetEvent('prdx_paintball:client:hit', function(attacker)
    if not inArena or out then return end
    out = true
    CreateThread(function()
        while out do
            Wait(1000)
            if not IsPedRagdoll(PlayerPedId()) then
                if not IsEntityPlayingAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_base', 3) then
                    TaskPlayAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_base', 8.0, 8.0, -1, 50, 0, false, false, false)
                end
            end
        end
    end)
    CreateThread(function()
        while out do
            Wait(0)
            DisablePlayerFiring(PlayerId(), true)
        end
    end)
end)

RegisterNetEvent('prdx_paintball:client:setLives', function(data)
    local result = lib.inputDialog("Paintball Match Lives",{
        { type = "number", label = "Number of lives per round", placeholder = '1' },
    })
    if result then
        TriggerServerEvent('prdx_paintball:server:setLives', result[1])
    end
    TriggerEvent('prdx_paintball:client:openArenaMenu')
end)

RegisterNetEvent('prdx_paintball:client:openArenaMenu', function()
    QBCore.Functions.TriggerCallback('prdx_paintball:server:getGameInformation', function(gameInformation)
        local statusColor = '#37b24d'
        local arenaStatus = 'No game active \nPlayers signed up: '..gameInformation.PlayerCount
        if gameInformation.Active then
            statusColor = '#fa5252'
            arenaStatus = 'Active Game \nPlayers in game: '..gameInformation.PlayerCount
        end
        local ArenaMenu = {
            {
                title = "Arena Status",
                description = arenaStatus, 
                colorScheme = statusColor,
            },
            {
                title = "Arena Settings",
                description = 'Lives per player: '..gameInformation.Lives, 
                event = 'prdx_paintball:client:setLives'
            },
        }

        if gameInformation.Active then
            ArenaMenu[#ArenaMenu+1] = {
                title = "Stop Game", 
                icon = 'ban',
                colorScheme = '#37b24d',
                serverEvent = 'prdx_paintball:server:stopPaintball'
            }
        else
            ArenaMenu[#ArenaMenu+1] = {
                title = "Start Game", 
                icon = 'check',
                colorScheme = '#fa5252',
                serverEvent = 'prdx_paintball:server:startPaintball'
            }          
        end

        lib.registerContext({
            id = 'paintball_main',
            title = 'Paradox Paintball Arena',
            options = ArenaMenu,
        })
        lib.showContext('paintball_main')
    end, false) 
end)

AddEventHandler('prdx_paintball:client:joinTeam', function(team)
    AddToTeam(team)
end)

AddEventHandler('prdx_paintball:client:leaveTeam', function()
    RemoveFromTeam()
end)

RegisterNetEvent('prdx_paintball:client:gameStarted', function()
    DoCountdown()
    out = false
    FullOut = false
end)

RegisterNetEvent('prdx_paintball:client:fullOut', function()
    FullOut = true
end)

RegisterNetEvent('prdx_paintball:client:gameEnded', function(scores)
    QBCore.Functions.Notify('The game has ended. You finished with a personal score of: ' .. scores[GetPlayerServerId(PlayerId())].score, 'inform')
    scoreBoardEnabled = true
    SendNUIMessage({
        type = 'show',
        players = scores
    })
    inProgress = false
    out = false
    FullOut = false
    Wait(2000)
    if IsEntityPlayingAnim(PlayerPedId(), 'missminuteman_1ig_2', 'handsup_base', 3) then
        ClearPedTasks(PlayerPedId())
    end
    RemoveFromTeam()
end)

RegisterNetEvent('prdx_paintball:client:showScoreboard', function(scores)
    scoreBoardEnabled = true
    SendNUIMessage({
        type = 'show',
        players = scores
    })
end)

-- #endregion

-- #region Threads

CreateThread(function()
    while true do
        Wait(0)
        if scoreBoardEnabled then
            if IsControlJustPressed(0, 177) then
                SendNUIMessage({
                    type = 'hide',
                })
                scoreBoardEnabled = false
            end
        end
    end
end)
-- #endregion