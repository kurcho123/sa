local zones = {}

RegisterNetEvent('prdx_heists:client:setTrolleyState', function(heistID, trolleyID, state, bool)
    if Config.Heists[heistID] then
        Config.Heists[heistID]["trolleys"][trolleyID][state] = bool
        if state == 'isOpened' and bool == true then -- Remove QB-Target
            exports.ox_target:removeZone(zones[heistID..'-'..trolleyID])
        end
    end
end)

RegisterNetEvent('prdx_heists:client:setupTrolleys', function(heistID, Trolleys)
    local TrollyIDS = {}
    if Config.Heists[heistID] then
        Config.Heists[heistID]["trolleys"] = Trolleys
        for trolleyID,v in pairs(Trolleys) do
            local trolley 
            if v.lootType == 'money' then
                trolley = CreateObject(`hei_prop_hei_cash_trolly_01`, v['coords'].x, v['coords'].y, v['coords'].z, 1, 1, 0)
            elseif v.lootType == 'gold' then
                trolley = CreateObject(`ch_prop_gold_trolly_01a`, v['coords'].x, v['coords'].y, v['coords'].z, 1, 1, 0)
            end
            if trolley then
                SetEntityHeading(trolley, v['heading'])
                TrollyIDS[trolleyID] = NetworkGetNetworkIdFromEntity(trolley)
            end
        end
        TriggerServerEvent('prdx_heists:server:syncTrolleys', heistID, TrollyIDS)
    end
end)

RegisterNetEvent('prdx_heists:client:resetTrolleys', function(heistID)
    for k,v in pairs(zones) do
        exports.ox_target:removeZone(v)
    end
end)

RegisterNetEvent('prdx_heists:client:lootTrolley', function(data)
    local trolleyID = data.trolley
    local trolleyEnt = data.entity
    local heistID = data.heist
    if Config.Heists[heistID]['active'] then
        TriggerServerEvent('prdx_heists:server:setTrolleyState', heistID, trolleyID, 'isBusy', true)
        LootTrolley(heistID, trolleyID)
    else 
        QBCore.Functions.Notify('How did you get in here?', 'error', 4500) 
    end
end)

RegisterNetEvent('prdx_heists:client:syncTrolleys', function(heistID, trolleys)
    if Config.Heists[heistID] then
        Config.Heists[heistID]["trolleys"] = trolleys
        for trolleyID,v in ipairs(Config.Heists[heistID]["trolleys"]) do
            if v['entity'] and NetworkDoesEntityExistWithNetworkId(v['entity'])  then
                zones[heistID..'-'..trolleyID] = exports.ox_target:addBoxZone({
                    coords = v.coords,
                    size = vec3(0.7, 1.1, (v.coords.z+1.0) - (v.coords.z-1.0)),
                    rotation = v.heading,
                    debug = Config.DebugMode,
                    options = {
                        {
                            name = 'prdx_heists:client:lootTrolley',
                            event = 'prdx_heists:client:lootTrolley',
                            icon = 'fas fa-hand-paper',
                            label = 'Grab',
                            trolley = trolleyID,
                            heist = heistID,
                            distance = 2.0
                        }
                    }
                })
            end
        end
    else
        print('Error: no heist ID')
    end
end)