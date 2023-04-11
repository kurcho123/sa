RegisterNetEvent("checkEntity")
AddEventHandler("checkEntity", function(netId)
	if NetworkDoesEntityExistWithNetworkId(netId) then
		local entity = NetworkGetEntityFromNetworkId(netId)
		if DoesEntityExist(entity) then
			if GetEntityPopulationType(entity) == 7 then
				local ent = Entity(entity)
				if ent.state.key ~= 80001171 then
					TriggerServerEvent("entityCheckReturn", netId)
				end
			end
		end
	end
end)