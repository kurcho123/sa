local QBCore = exports['qb-core']:GetCoreObject()
local sitAnimDict
local sitAnimClip
local presitPosition = nil
local currentSeat = nil
local isSitting = false

CreateThread(function()
	Wait(1000)
    for v, chairmodel in pairs(Config.ChairModels) do
        exports['qb-target']:AddTargetModel(Config.ChairModels[v].modelName, 
            {
			options = 
			{
				{
					type = "client",
					event = "prdx_sit:client:sit",
					icon = 'fas fa-chair',
					label = "Sit",
					modelName = Config.ChairModels[v].modelName,
					offset = Config.ChairModels[v].sittingOffset,
					ispoly = false,
					zoffset = Config.ChairModels[v].zoffset,
				},
			},
			distance = 1.5 
		})
    end
end)

RegisterNetEvent('prdx_sit:client:sit', function(data)
	if data then
		local ped = PlayerPedId()
		presitPosition = GetEntityCoords(ped)
		if data.ispoly then --Polyzone
			QBCore.Functions.Tableprint(data)
			print('Pass 2')
			SetEntityHeading(ped, data.heading)
			SetEntityCollision(ped, false, true)
			SetEntityCoords(ped, data.seatingPos.x, data.seatingPos.y, data.seatingPos.z - 1, false) 
			FreezeEntityPosition(ped, true)
			if data.sitanim == 'lapdance' then
				print('Pass 3.1')
				local dancenum = ""	if data.sitanim == "lapdance" then dancenum = tostring(math.random(1,6)) if dancenum == "1" then dancenum = "" 	end end	
				TriggerEvent('animations:client:EmoteCommandStart', {data.sitanim .. tostring(dancenum), 0})
			elseif data.sitanim and data.sitclip then
				print('Pass 3.2')
				sitAnimDict = data.sitanim
				sitAnimClip = data.sitclip
				lib.requestAnimDict(sitAnimDict)
				TaskPlayAnim(PlayerPedId(), sitAnimDict, sitAnimClip, 2.0, 2.0, -1, 1, 0.0, 0, 0, 0)
				Wait(500)
				isSitting = true
			else
				local BehindPlayer = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5)
				SetEntityCoords(ped, BehindPlayer.x, BehindPlayer.y, BehindPlayer.z - 1, false) 
				sitAnimDict = 'amb@prop_human_seat_chair@male@generic@idle_a'
				sitAnimClip = 'idle_a'
				lib.requestAnimDict(sitAnimDict)
				TaskPlayAnim(PlayerPedId(), sitAnimDict, sitAnimClip, 2.0, 2.0, -1, 1, 0.0, 0, 0, 0)
				Wait(500)
				isSitting = true
			end
		elseif data.modelName then -- Chair Model
			local objectId = GetClosestObjectOfType(presitPosition, 5.0, joaat(data.modelName), false)
			if objectId > 0 then
				local chairCoords = GetEntityCoords(objectId)
				local chairheading = (GetEntityHeading(objectId) + 180)
				local unloadLocation = GetEntityForwardVector(objectId)          
				local sitpos = chairCoords - (unloadLocation * data.offset)
				local finpos = vector3(chairCoords.x, chairCoords.y, chairCoords.z - data.zoffset)
				SetEntityHeading(ped, chairheading)
				SetEntityCollision(ped, false, true)
				SetEntityCoords(ped, finpos.x, finpos.y, finpos.z - 0.5, false) 
				FreezeEntityPosition(ped, true)     
				sitAnimDict = 'amb@prop_human_seat_chair@male@generic@idle_a'
				sitAnimClip = 'idle_a'
				lib.requestAnimDict(sitAnimDict)
				TaskPlayAnim(PlayerPedId(), sitAnimDict, sitAnimClip, 2.0, 2.0, -1, 1, 0.0, 0, 0, 0)
				Wait(500)
				isSitting = true
			else
				QBCore.Functions.Notify('Can\'t sit here', 'error')
			end
		end
	end
end)

CreateThread(function()
	while true do
		local sleep = 5000
		if isSitting then
			sleep = 150
			if sitAnimDict then
				if not IsEntityPlayingAnim(PlayerPedId(), sitAnimDict, sitAnimClip, 3) then
					TaskPlayAnim(PlayerPedId(), sitAnimDict, sitAnimClip, 2.0, 2.0, -1, 1, 0, false, false, false)
				end
			end
		end
		Wait(sleep)
	end
end)

RegisterNetEvent('prdx_playercontroller:actionCancelled', function ()
	if isSitting then
		local ped = PlayerPedId()
		isSitting = false
		if presitPosition then
			SetEntityCoordsNoOffset(ped, presitPosition.x, presitPosition.y, presitPosition.z)
		end
		ClearPedTasks(ped)
		SetEntityCollision(ped, true, true)
		FreezeEntityPosition(ped, false)     
	end
end)