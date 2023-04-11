

local QBCore = exports['qb-core']:GetCoreObject()
local CD = CD or {}

CD.Scoreboard = {}
local forceDraw = false
local shouldDraw = false
local shouldOpenMenu = false
local TotalPlayers = 0
local isStaff = false
local RecentDisconnects = {}
--shouldDraw = true


CreateThread(function()
	local currentItemIndex = 1
	local selectedItemIndex = 1

	WarMenu.CreateMenu('scoreboard', 'Online Players')

	WarMenu.SetSubTitle("scoreboard", "Players")
	WarMenu.SetTitleColor("scoreboard", 135, 206, 250, 255)
    WarMenu.SetTitleBackgroundColor("scoreboard", 0 , 0, 0, 150)
    WarMenu.SetMenuBackgroundColor("scoreboard", 0, 0, 0, 100)
    WarMenu.SetMenuSubTextColor("scoreboard", 255, 255, 255, 255)

    WarMenu.CreateSubMenu('playeroptions', 'scoreboard', 'Player Info')

	while true do
		if WarMenu.IsMenuOpened('scoreboard') then
			if WarMenu.Button("Total:", TotalPlayers, {r = 135, g = 206, b = 250, a = 150}) then
				else
				local playerlist = GetActivePlayers()
                for i = 1, #playerlist do
                    local currPlayer = playerlist[i]
                    if IsEntityVisible(GetPlayerPed(currPlayer)) then
                        if WarMenu.MenuButton("ID: ~y~[" .. GetPlayerServerId(currPlayer) .. "] ~s~" .. GetPlayerName(currPlayer), 'playeroptions') then
                            selectedPlayer = currPlayer 
                        end
                    end
                end
			end

			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('playeroptions') then
			if WarMenu.Button("~p~Selected: " .. "~y~[" .. GetPlayerServerId(selectedPlayer) .. "] ~s~" .. GetPlayerName(selectedPlayer)) then
			elseif WarMenu.Button("ID: ~y~[" .. GetPlayerServerId(selectedPlayer) .. "] ~s~") then
			elseif WarMenu.Button("Name: ~y~[" .. GetPlayerName(selectedPlayer) .. "] ~s~") then
			end
			WarMenu.Display()
		end

		Wait(0)
	end
end)

AddEventHandler('playerSpawned', function(spawn)
    return count
end)

CreateThread(function()
    local animationState = false
    while true do
        Wait(0)
        if (IsControlJustPressed(0, Config.Button) or IsDisabledControlJustPressed(0, Config.Button)) and not shouldDraw then -- U by default
            QBCore.Functions.TriggerCallback("qb-multi:server:GetCurrentPlayers", function(Players)
                TotalPlayers = Players
            end)
            WarMenu.OpenMenu('scoreboard')
            shouldDraw = true
        elseif IsControlJustReleased(0, Config.Button) or IsDisabledControlJustReleased(0, Config.Button) then
            WarMenu.CloseMenu('scoreboard')
            shouldDraw = false
            Wait(500)
        end
    end
end)

--Draw Things
CreateThread(function()
    local animationState = false
    while true do
        Wait(0)
        if shouldDraw or forceDraw then
            local nearbyPlayers = GetNeareastPlayers()
            for k, v in pairs(nearbyPlayers) do
                if IsEntityVisible(GetPlayerPed(v.player)) or isStaff == true then
                    local x, y, z = table.unpack(v.coords)
                    if NetworkIsPlayerTalking(v.player) then
                        Draw3DText(x, y, z + 1.1, v.playerId, true)
                    else
                        Draw3DText(x, y, z + 1.1, v.playerId, false)
                    end
                end
            end
            for k,v in pairs(RecentDisconnects) do
                if #(vec3(v.coords.x, v.coords.y, v.coords.z) - GetEntityCoords(PlayerPedId())) <= 10.0 then
                    local time = (GetNetworkTimeAccurate() - v.leaveTime) / 1000
                    if time <= 600 then -- less than 10 mins old
                        local text = 'ID: [~y~'..v.playerId..'~s~] ~b~'..v.name..'~s~ has flown out\n~o~REASON:~s~ '..v.reason
                        if time > 60 then
                            local minutes = math.floor(time/60)
                            local seconds = math.floor(time - (minutes * 60))
                            if seconds < 10 then
                                text = text..'\n~o~Since:~s~ '..minutes..':0'..seconds
                                Draw3DText(v.coords.x, v.coords.y, v.coords.z, text, false)
                            else
                                text = text..'\n~o~Since:~s~ '..minutes..':'..seconds
                                Draw3DText(v.coords.x, v.coords.y, v.coords.z, text, false)
                            end
                        else
                            local seconds = math.floor(time)
                            if seconds < 10 then
                                text = text..'\n~o~Since:~s~ 0:0'..seconds
                                Draw3DText(v.coords.x, v.coords.y, v.coords.z, text, false)
                            else
                                text = text..'\n~o~Since:~s~ 0:'..seconds
                                Draw3DText(v.coords.x, v.coords.y, v.coords.z, text, false)
                            end
                        end
                    else
                        table.remove(RecentDisconnects, k)
                    end
                end
            end
        end
    end
end)

function Draw3DText(x, y, z, text, talking)
    -- Check if coords are visible and get 2D screen coords
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        -- Calculate text scale to use
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = 1.8 * (1 / dist) * (1 / GetGameplayCamFov()) * 100

        -- Draw text on screen
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        if talking then
            SetTextColour(67, 0, 138, 255)
        else
            SetTextColour(255, 255, 255, 255)
        end
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end


function GetNeareastPlayers()
	local playerPed = PlayerPedId()
	local playerlist = GetActivePlayers()
   --local players, _ = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), Config.DrawDistance)

    local players_clean = {}
    local found_players = false

    for _, player in ipairs(GetActivePlayers()) do
        found_players = true
        table.insert(players_clean, { playerName = GetPlayerName(player), playerId = GetPlayerServerId(player), coords = GetEntityCoords(GetPlayerPed(player)), player = player })
    end
    return players_clean
end

RegisterNetEvent('cd-scoreboard:client:recieveDisconnect', function(data)
    RecentDisconnects[#RecentDisconnects+1] = data
end)