RegisterNetEvent('qb-policejob:client:laySpikes')
AddEventHandler('qb-policejob:client:laySpikes', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
	Wait(500)
	local heading = GetEntityHeading(PlayerPedId())
	local positions = {}
	for i = 1, 3 do
		positions[i] = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, -1.5+(3.5*i), 0.15)
	end
	TriggerServerEvent("qb-policejob:server:spikesAdd", positions, heading)
    QBCore.Functions.Notify('Spikes laid!', 'success')
end)


-- laying out objects

function loadSpikeModel(spike)
    RequestModel(spike)
    while not HasModelLoaded(spike) do
      Wait(1)
    end
end

RegisterNetEvent('qb-policejob:client:spikesAdd')
AddEventHandler('qb-policejob:client:spikesAdd', function(positions,h)
	local spike = `P_ld_stinger_s`
	loadSpikeModel(spike)
	for i = 1, 3 do
		local spikeObj = CreateObject(spike,positions[i].x,positions[i].y,positions[i].z, 0, 1, 1) -- x+1
		TriggerEvent("qb-policejob:client:spikesWatch",positions[i].x,positions[i].y,positions[i].z,spikeObj)
		PlaceObjectOnGroundProperly(spikeObj)
		SetEntityHeading(spikeObj,h)
		FreezeEntityPosition(spikeObj,true)
	end
end)

-- watching each object then deleting after 5s

--RegisterNetEvent('qb-policejob:client:spikesWatch')
AddEventHandler('qb-policejob:client:spikesWatch', function(x,y,z,obj)
	local spike = `P_ld_stinger_s`
	local pos = vector3(x,y,z)
	local ped = PlayerPedId()
	local timer = 0
	while timer < 250 do
		local veh = GetVehiclePedIsIn(ped, false)
		local driverPed = GetPedInVehicleSeat(veh, -1)
		local speed = math.ceil(GetEntitySpeed(veh) * 2.236936)
		timer = timer + 1
		Wait(1)	
		if driverPed and speed > 10.0 then
			local d1,d2 = GetModelDimensions(GetEntityModel(veh))
			local leftfront = GetOffsetFromEntityInWorldCoords(veh, d1["x"]-0.25,0.25,0.0)
			local rightfront = GetOffsetFromEntityInWorldCoords(veh, d2["x"]+0.25,0.25,0.0)
			local leftback = GetOffsetFromEntityInWorldCoords(veh, d1["x"]-0.25,-0.85,0.0)
			local rightback = GetOffsetFromEntityInWorldCoords(veh, d2["x"]+0.25,-0.85,0.0)
			local skip = false
			if #(pos - leftfront) < 2.0 and not IsVehicleTyreBurst(veh,0,true) then
				if IsEntityTouchingEntity(veh,GetClosestObjectOfType(x,y,z,5.0,spike,0,0,0)) then
					SetVehicleTyreBurst(veh, 0, true, 1000.0)
				end
			end
			if #(pos - rightfront) < 2.0 and not IsVehicleTyreBurst(veh,1,true) then
				if IsEntityTouchingEntity(veh,GetClosestObjectOfType(x,y,z,5.0,spike,0,0,0)) then
					SetVehicleTyreBurst(veh, 1, true, 1000.0)
				end
			end
			if #(pos - leftback) < 2.0 and not IsVehicleTyreBurst(veh,4,true) then
				if IsEntityTouchingEntity(veh,GetClosestObjectOfType(x,y,z,5.0,spike,0,0,0)) then
					SetVehicleTyreBurst(veh, 2, true, 1000.0)
					SetVehicleTyreBurst(veh, 4, true, 1000.0)	
				end		      		
			end
			if #(pos - rightback) < 2.0 and not IsVehicleTyreBurst(veh,5,true) then
				if IsEntityTouchingEntity(veh,GetClosestObjectOfType(x,y,z,5.0,spike,0,0,0)) then
					SetVehicleTyreBurst(veh, 3, true, 1000.0)
					SetVehicleTyreBurst(veh, 5, true, 1000.0) 
				end 		
			end
		end
	end
	DeleteObject(obj)
	SetEntityAsNoLongerNeeded(obj)	
end)

