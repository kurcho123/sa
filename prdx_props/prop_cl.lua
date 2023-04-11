local dropkey 	= 246 -- Key to drop/get the props
local QBCore = exports['qb-core']:GetCoreObject()
local RagDolled = false

function AttachProp(name, entity)
	local PropData = Config.PropList[name]
	if PropData then
		local coords = GetEntityCoords(PlayerPedId())
		local NetID = NetworkGetNetworkIdFromEntity(entity)

		if entity and NetworkDoesNetworkIdExist(NetID) then -- networked entity
			local prop = entity
			StartAnimation(PropData.anim)
			QBCore.Functions.TakeControl(prop)
			AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), PropData.bone), PropData.offset.x, PropData.offset.y, PropData.offset.z, PropData.rotation.x, PropData.rotation.y, PropData.rotation.z, true, true, false, 0, 2, true)
			LocalPlayer.state:set('HoldingProp', NetID, true)
			if Entity(prop).state.hasParticles then
				TriggerServerEvent('prdx_props:removeParticles', GetEntityCoords(prop))
			end
			if Entity(prop).state.sceneList then
				for k,v in pairs(Entity(prop).state.sceneList) do
					if NetworkDoesEntityExistWithNetworkId(v) then
						local entity = NetToEnt(v)
						if entity and entity ~= 0 then
							QBCore.Functions.DeleteEntity(entity)
							Wait(0)
						end
					end
				end
			end
			return NetID
		elseif not entity or (entity and not PropData.item) then
			if entity then 
				if PropData.item then 
					QBCore.Functions.Notify('Not a placed prop (Un-networked)', 'error')
					return 
				end -- prevent non-networked props from becoming items
				DeleteEntity(entity) 
			end -- local only delete just for niceness
			if not IsModelInCdimage(PropData.model) then
				return
			end
			RequestModel(PropData.model)
			while not HasModelLoaded(PropData.model) do
				Wait(0)
			end
			local prop = CreateObject(PropData.model, coords.x, coords.y, coords.z-50.0, true, true, false)
			local NetID = NetworkGetNetworkIdFromEntity(prop)
			if not NetworkDoesNetworkIdExist(NetID) then
				print("ERROR: NOT A NETWORKED OBJ")
				NetworkRegisterEntityAsNetworked(prop)
				NetID = NetworkGetNetworkIdFromEntity(prop)
			end
			StartAnimation(PropData.anim)
			QBCore.Functions.TakeControl(prop)
			SetNetworkIdCanMigrate(NetID, false)
			AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), PropData.bone), PropData.offset.x, PropData.offset.y, PropData.offset.z, PropData.rotation.x, PropData.rotation.y, PropData.rotation.z, true, true, false, 0, 2, true)
			LocalPlayer.state:set('HoldingProp', NetID, true)
			return NetID
		end
	end   
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

function StartAnimation(anim)
	if anim == 'pick' then
	    LoadAnimDict('random@domestic')
		LoadAnimDict( "move_weapon@jerrycan@generic" )
    	TaskPlayAnim(PlayerPedId(), 'random@domestic', 'pickup_low', 5.0, 1.0, 1.0, 48, 0.0, 0, 0, 0)
		Wait(1500)
	elseif anim == 'hold' then
		LoadAnimDict( "anim@heists@box_carry@" )
		TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 4.0, 1.0, -1, 49, 0.0, 0, 0, 0)
		Wait(250)
	elseif anim == 'holdhand' then
		LoadAnimDict( "anim@heists@humane_labs@finale@keycards" )
		TaskPlayAnim(PlayerPedId(), 'anim@heists@humane_labs@finale@keycards', 'ped_a_enter_loop', 4.0, 1.0, -1, 49, 0.0, 0, 0, 0)
		Wait(250)
	end
	LocalPlayer.state:set('HoldingPropAnim', anim, true)
end

function ChatMessage(args)
	TriggerEvent("chatMessage", "Prop List", 2, string.format(""..args..""))
end

CreateThread(function()
	while true do
		Wait(0)
		if LocalPlayer.state.HoldingProp then
			--DisableControlAction(0, 21)
			DisableControlAction(0, 140)
			DisablePlayerFiring(PlayerId(), true)
			if IsPedRagdoll(PlayerPedId()) then
				RagDolled = true
			elseif LocalPlayer.state.HoldingPropAnim == 'hold' then
				if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) or RagDolled then
					TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 4.0, 1.0, -1, 49, 0.0, 0, 0, 0)
				end
			elseif LocalPlayer.state.HoldingPropAnim == 'pick' then
				if not IsEntityPlayingAnim(PlayerPedId(), 'move_weapon@jerrycan@generic', 'idle', 3) or RagDolled then
					TaskPlayAnim(PlayerPedId(), 'move_weapon@jerrycan@generic', 'idle', 4.0, 1.0, -1, 49, 0.0, 0, 0, 0)
				end
			end
		end
	end
end)


RegisterCommand('DropProp', function()
    if LocalPlayer.state.HoldingProp then
		local prop = NetToEnt(LocalPlayer.state.HoldingProp)
		if prop then
			Wait(250)
			QBCore.Functions.TakeControl(prop)
			DetachEntity(prop, false, true)
			PlaceObjectOnGroundProperly(prop)
			FreezeEntityPosition(prop, true)
			local coords = GetEntityCoords(prop)
			LocalPlayer.state:set('HoldingProp', false, true)
			LocalPlayer.state:set('HoldingPropAnim', false, true)
			ClearPedTasks(PlayerPedId())
			TriggerEvent('scully_emotemenu:resetWalk')
			local PropData = LinkData(prop)
			if Config.PropList[PropData] then
				if Config.PropList[PropData].particles then
					if type(Config.PropList[PropData].particles[1]) == 'table' then
						for k,v in pairs(Config.PropList[PropData].particles) do
							if not v.rotation then v.rotation = vec3(0.0,0.0,0.0) end
							TriggerServerEvent('QBCore:Server:DoPTFXEntity', v.lib, v.dict, true, NetworkGetNetworkIdFromEntity(prop), nil, v.offset, v.rotation, v.scale or 1.0, 0.5, v.color or nil, false, 600000)
						end
					else
						local v = Config.PropList[PropData].particles
						if not v.rotation then v.rotation = vec3(0.0,0.0,0.0) end
						TriggerServerEvent('QBCore:Server:DoPTFXEntity', v.lib, v.dict, true, NetworkGetNetworkIdFromEntity(prop), nil, v.offset, v.rotation, v.scale or 1.0, 0.5, v.color or nil, false, 600000)
					end
					QBCore.Functions.SetStateBag(prop, 'hasParticles', true)
				end
				if Config.PropList[PropData].scene then
					local proprotation = GetEntityRotation(prop)
					local PropList = {}
					for k,data in pairs(Config.PropList[PropData].scene) do
						Wait(5)
						local model = data.model
						local offset = data.offset
						local rotation = data.rotation
						RequestModel(model)
						while not HasModelLoaded(model) do
							Wait(0)
						end
						local scenecoords = GetOffsetFromEntityInWorldCoords(prop, offset.x, offset.y, offset.z)
						local sceneprop = CreateObject(model, scenecoords.x, scenecoords.y, scenecoords.z, true, true, false)
						SetEntityRotation(sceneprop, proprotation.x + rotation.x, proprotation.y + rotation.y, proprotation.z + rotation.z, 1, 0)

						local NetID = NetworkGetNetworkIdFromEntity(sceneprop)
						if not NetworkDoesNetworkIdExist(NetID) then
							print("ERROR: NOT A NETWORKED OBJ")
							NetworkRegisterEntityAsNetworked(sceneprop)
							NetID = NetworkGetNetworkIdFromEntity(sceneprop)
						end
						PropList[#PropList+1] = NetID
						FreezeEntityPosition(sceneprop, true)
						PlaceObjectOnGroundProperly(sceneprop)
						if data.override then
							local overridecoords = GetEntityCoords(sceneprop)
							SetEntityCoords(sceneprop, overridecoords.x, overridecoords.y, overridecoords.z + data.override)
						end
					end
					QBCore.Functions.SetStateBag(prop, 'sceneList', PropList)
				end
				TriggerServerEvent("qb-log:server:CreateLog", "scenes", "Prop Placed", "blue", "`" .. GetPlayerName(PlayerId()) .. "` has placed a "..PropData.." at `("..coords.x..", "..coords.y..", "..coords.z..")`", false, GetPlayerServerId(PlayerId()))
				TriggerEvent('prdx_props:client:droppedProp', prop, PropData)
			end
		else
			LocalPlayer.state:set('HoldingProp', false, true)
			LocalPlayer.state:set('HoldingPropAnim', false, true)
		end
		SetNetworkIdCanMigrate(LocalPlayer.state.HoldingProp, true)
	else
		LocalPlayer.state:set('HoldingProp', false, true)
		LocalPlayer.state:set('HoldingPropAnim', false, true)
    end
end)
 
RegisterKeyMapping('DropProp', 'Drop carrying prop', 'keyboard', 'Y')

RegisterCommand('DeleteProp', function()
    if LocalPlayer.state.HoldingProp then
		local prop = NetToEnt(LocalPlayer.state.HoldingProp)
		if prop then
			Wait(250)
			if Entity(prop).state.hasParticles then
				TriggerServerEvent('prdx_props:removeParticles', GetEntityCoords(prop))
			end
			local model = GetEntityModel(prop)
			QBCore.Functions.TakeControl(prop)
			LocalPlayer.state:set('HoldingProp', false, true)
			LocalPlayer.state:set('HoldingPropAnim', false, true)
			DetachEntity(prop, false, true)
			ClearPedTasks(PlayerPedId())
			TriggerEvent('scully_emotemenu:resetWalk')
			PlaceObjectOnGroundProperly(prop)
			FreezeEntityPosition(prop, true)
			if Entity(prop).state.engineData then return end
			QBCore.Functions.DeleteEntity(prop)
			for k,v in pairs(Config.PropList) do
				if v.item and model == v.model then
					TriggerServerEvent('prdx_props:itemGive', k)
				end
			end
		end
    end
end)

RegisterKeyMapping('DeleteProp', 'Delete carrying prop', 'keyboard', 'R')


function LinkData(entity)
	local model = GetEntityModel(entity)
	local PropName = false
	for name,data in pairs(Config.PropList) do
		if data.model == model then PropName = name end
	end
	return PropName
end

RegisterCommand('p', function(source, args)
	QBCore.Functions.TriggerCallback('prdx_props:getVIP', function(isVIP)
		local prop = args[1]
		if prop then
			if Config.PropList[prop].vip and not isVIP then 
				QBCore.Functions.Notify('VIP ONLY', 'error', 2500)
				return 
			end
			if Config.PropList[prop] and not Config.PropList[prop].hidden then
				AttachProp(prop)
			end
		else
			local msg = ''
			for prop,data in pairs(Config.PropList) do
				if data.vip and not isVIP then return end
				if not data.hidden then
					msg = msg..prop..", "
				end
			end
			ChatMessage(msg)
		end
	end)
end)

RegisterNetEvent('prdx_propsystem:syncPartcles', function(coords)
	RemoveParticleFxInRange(coords.x, coords.y, coords.z, 1.0)
end)

RegisterNetEvent('prdx_propsystem:attachProp', function(data)
	local prop = LinkData(data.entity)
	if prop then
		AttachProp(prop, data.entity)
	end
end)

RegisterNetEvent('prdx_propsystem:attachPropItem', function(data)
	local prop = LinkData(data.entity)
	if prop then
		AttachProp(prop, data.entity)
	end
end)

RegisterNetEvent('prdx_propsystem:generateProp', function(name)
	if Config.PropList[name] then
		AttachProp(name)
	end
end)

RegisterNetEvent('prdx_propsystem:adminProp', function(name)
	if Config.PropList[name] then
		AttachProp(name)
	else
		Config.PropList[name] = {
			label = 'Admin Prop: '..name,
			model = joaat(name),
			bone = 28422,
			offset = vec3(0.0, -0.1, -0.1),
			rotation = vec3(0.0, 0.0, 0.0),
			anim = 'hold',
		}
		AttachProp(name)
	end
end)

exports("generateProp", AttachProp)

CreateThread(function()
	while not LocalPlayer.state.isLoggedIn do
		Wait(0)
	end
	QBCore.Functions.TriggerCallback('prdx_props:getVIP', function(isVIP)
		for name,prop in pairs(Config.PropList) do
			if prop.vip and isVIP then
				exports['qb-target']:AddTargetModel(prop.model, {
					options = {
						{
							event = "prdx_propsystem:attachProp",
							icon = "fas fa-boxes-packing",
							label = 'Pickup '..prop.label,
						},
					},
					distance = 2.0
				})
			else
				exports['qb-target']:AddTargetModel(prop.model, {
					options = {
						{
							event = "prdx_propsystem:attachProp",
							icon = "fas fa-boxes-packing",
							label = 'Pickup '..prop.label,
						},
					},
					distance = 2.0
				})
			end
			Wait(100)
	
		end
	end)
end)