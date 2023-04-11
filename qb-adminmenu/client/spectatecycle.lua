QBCore = exports['qb-core']:GetCoreObject()

InSpectatorModeCycle = false
LastPosition = nil
targetPlayerId = nil
tgtPlayerName = nil
setup = false

CreateThread(function()
	while true do
		Wait(0)
		if InSpectatorModeCycle == true then
			setup = true
			while not tgtPlayerName do
				Wait(0)
			end
            SetTextComponentFormat("STRING")
            AddTextComponentString("Spectating (" .. targetPlayerId .. ") " .. tgtPlayerName .. ". Use left and right arrow to cycle.")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			SetEntityVisible(cache.ped, false, 0)
			DisplayRadar(true)
			if IsControlJustReleased(0, 175) then 
				NextTarget('add')
			elseif IsControlJustReleased(0, 174) then
				NextTarget('minus')
			end
		elseif setup then
			setup = false
			DisplayRadar(false)
		end
	end
end)

local previousCoords = nil
CreateThread(function()
	while true do
		Wait(250)
		if InSpectatorModeCycle and currentSpectatedPed and currentSpectatedPed > 0 then
			local coords = GetEntityCoords(currentSpectatedPed)
			if coords ~= previousCoords then
				previousCoords = coords
				SetEntityCoordsNoOffset(cache.ped, coords.x, coords.y, coords.z - 50.0)
				FreezeEntityPosition(cache.ped, true)
			end
		end
	end
end)

function cyclespectate(playerServerId)
	timeout = 0
	targetPlayerId = playerServerId
	local ped = PlayerPedId()
	if InSpectatorModeCycle == false then
		LastPosition = GetEntityCoords(ped)
	end
	DoScreenFadeOut(250)
	Wait(250)
	FreezeEntityPosition(ped,  true)
	SetEntityCollision(ped, false, false)
	--SetEntityCoords(localPlayerPed, 15000.0, -15000.0, 100.0, 0, 0, 0, false)
	-- UNLOAD AREA --
	if playerServerId ~= nil then
		if tonumber(playerServerId) == GetPlayerServerId(PlayerId()) then
			NextTarget('add')
		end
		NetworkSetInSpectatorModeExtended(false, ped, false)
		QBCore.Functions.TriggerCallback('ParadoxAdmin:GetPlayerCoords', function(tgtCoords, bucket)
			if tgtCoords then
				if bucket and LocalPlayer.state.bucket ~= bucket then
					TriggerServerEvent('qb-apartments:setBucket', bucket)
					QBCore.Functions.Notify('Entered bucket for spectate: #'..bucket, 'inform')
				else
					TriggerServerEvent("qb-apartments:returnBucket")
				end
				RequestCollisionAtCoord(tgtCoords.x, tgtCoords.y, tgtCoords.z)
				FreezeEntityPosition(ped, true)
				SetEntityCollision(ped, false, false)
				SetPedCoordsKeepVehicle(ped, tgtCoords.x, tgtCoords.y, tgtCoords.z - 15.0)
				Wait(250)
				local tgtplayerId = GetPlayerFromServerId(playerServerId)
				local targetPedCiv = nil
				repeat
					Wait(100)
					if timeout > 25 then
						break
					end
					timeout = timeout + 1
					for _, i in ipairs(GetActivePlayers()) do
						if i ~= PlayerId() then
							if tonumber(GetPlayerServerId(i)) == tonumber(playerServerId) then
								--tgtplayerId = GetPlayerFromServerId(playerServerId)
								targetPedCiv = GetPlayerPed(i)
								tgtPlayerName = GetPlayerName(NetworkGetPlayerIndexFromPed(targetPedCiv))
							end
						end
					end
				until((targetPedCiv and targetPedCiv > 0))
				if timeout > 25 and not targetPedCiv then
					QBCore.Functions.Notify('Failed to spectate that player', "error")
					NextTarget('add')
				end
				DoScreenFadeIn(250)
				NetworkSetInSpectatorModeExtended(true, targetPedCiv, true)
				InSpectatorModeCycle = true
				Wait(250)
				currentSpectatedPed = targetPedCiv
			end
		end, playerServerId)
    else
        DoScreenFadeIn(250)
        QBCore.Functions.Notify('No other players to spectate', "error")
	end
end

function NextTarget(method)
	currentSpectatedPed = nil
	QBCore.Functions.TriggerCallback('ParadoxStaff:GetPlayers', function(players)
		local list = players
		local index = getPlayerIndex(players, targetPlayerId, GetPlayerServerId(PlayerId())) 
		if method == 'add' then
			index = index + 1
			if list[index] == nil then 
				-- Can't go forwards anymore 
				index = 1
			end
		else
			index = index - 1
			if list[index] == nil then 
				-- Can't go backwards anymore 
				index = #list
			end
		end
		QBCore.Functions.Notify('Trying to spectate ID #: ' .. tostring(list[index]), "inform")
		cyclespectate(list[index])
	end)
end

function resetNormalCamera()
	currentSpectatedPed = nil
	InSpectatorModeCycle = false
	TargetSpectate  = nil
	local playerPed = PlayerPedId()

	SetCamActive(cam,  false)
	RenderScriptCams(false, false, 0, true, true)

	SetEntityCollision(playerPed, true, true)
	SetEntityVisible(playerPed, true)
	SetEntityCoords(playerPed, LastPosition.x, LastPosition.y, LastPosition.z)
end

function getPlayersList()

	local players = QBCore.Functions.GetPlayers()
	local data = {}

	for i=1, #players, 1 do

		local _data = {
			id = GetPlayerServerId(players[i]),
			name = GetPlayerName(players[i])
		}
		table.insert(data, _data)
	end

	return data
end

function getPlayers()
	QBCore.Functions.TriggerCallback('ParadoxStaff:GetPlayers', function(players)
		return players
	end)
end

function getPlayerIndex(list, id, skipMe) 
	local counter = 0;
	for _, i in ipairs(list) do
        if i ~= skipMe then 
            counter = counter + 1;
        end
        if tonumber(i) == tonumber(id) then
            return counter;
        end
    end
    return nil;
end

RegisterNetEvent("spectatecycle", function()
    if not InSpectatorModeCycle then
        QBCore.Functions.TriggerCallback('ParadoxStaff:GetPlayers', function(players)
            TargetSpectate = players[1]
            targetPlayerId = players[1]
            Wait(50)
            cyclespectate(players[1])
        end)
    else
		TriggerServerEvent("qb-apartments:returnBucket")
        SetPedCoordsKeepVehicle(PlayerPedId(), LastPosition.x, LastPosition.y, LastPosition.z)
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityInvincible(PlayerPedId(), false)
        SetEntityVisible(PlayerPedId(), true, 0)
        SetEntityCollision(PlayerPedId(),  true, true)
        FreezeEntityPosition(PlayerPedId(),  false)
        InSpectatorModeCycle = false
    end
end)

RegisterNetEvent('qb-admin:client:spectate', function(playerServerId)
	if not InSpectatorModeCycle then
		QBCore.Functions.TriggerCallback('ParadoxStaff:GetPlayers', function(players)
			TargetSpectate = playerServerId
			targetPlayerId = playerServerId
			Wait(50)
			cyclespectate(playerServerId)
		end)
    else
		TriggerServerEvent("qb-apartments:returnBucket")
        SetPedCoordsKeepVehicle(PlayerPedId(), LastPosition.x, LastPosition.y, LastPosition.z)
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityInvincible(PlayerPedId(), false)
        SetEntityVisible(PlayerPedId(), true, 0)
        SetEntityCollision(PlayerPedId(),  true, true)
        FreezeEntityPosition(PlayerPedId(),  false)
        InSpectatorModeCycle = false
    end
end)