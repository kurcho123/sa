local SnowEnabled = false
local IsPlowing = false
local plowedNodes = {}
Config.SnowPlowVehicles = {
    [`20ramdot`] = true, 
    [`plow`] = true, 
    [`03sierraplowlb`] = true, 

}
function StartPlowLoop()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if vehicle > 0 then
        local model = GetEntityModel(vehicle)
        if Config.SnowPlowVehicles[model] then
            IsPlowing = true
            QBCore.Functions.Notify('Started snowplowing...', 'success')
            while IsPlowing do
                Wait(500)
                local coords = GetEntityCoords(vehicle)
                for k,v in pairs(Config.SnowPlowNodes) do
                    if not plowedNodes[v] and #(coords - vec3(v.x, v.y, v.z)) < 20.0 then
                        plowedNodes[v] = true
                        TriggerServerEvent('prdx_smallmissions:server:snowPlowedNode', vec3(v.x, v.y, v.z))
                        QBCore.Functions.Notify("Plowed area!", 'inform')
                    elseif plowedNodes[v] and #(coords - vec3(v.x, v.y, v.z)) < 20.0 then
                        Wait(2500) -- extra long wait in case we are stopped
                    end
                end
            end
        else
            QBCore.Functions.Notify("Must be in a plow vehicle to do that!", 'error')
        end
    else
        QBCore.Functions.Notify("Must be in a vehicle to do that!", 'error')
    end
end

RegisterNetEvent('QBCore:leftVehicle', function ()
    if IsPlowing then
        QBCore.Functions.Notify("Stopped plowing!", 'error')
    end
	IsPlowing = false
end)

RegisterNetEvent('ParadoxWeather:client:snowToggled', function (status)
    SnowEnabled = status
end)

RegisterNetEvent('prdx_smallmissions:client:startSnowPlowing', function()
    StartPlowLoop()
end)

RegisterNetEvent('prdx_smallmissions:client:stopSnowPlowing', function()
    IsPlowing = false
end)

RegisterNetEvent('prdx_smallmissions:client:openSnowplowMenu', function(data)
    QBCore.Functions.TriggerCallback('prdx_smallmissions:server:getPlowedStatus', function(ratio)
        if not SnowEnabled then
            local menu = {
                {
                    title = 'Current Status: No Snow',
                    disabled = true
                }
            }
            lib.registerContext({
                id = 'snowplow_menu',
                title = 'SADOT Snowplowing Menu',
                options = menu,
            })
            lib.showContext('snowplow_menu')
        else
            local menu = {
                {
                    title = 'Current Status: '..ratio..'% Snow Cover',
                    disabled = true
                }
            }
            if not IsPlowing then
                menu[#menu+1] = {
                    title = "Start Plowing", 
                    event = "prdx_smallmissions:client:startSnowPlowing"
                }
            else
                menu[#menu+1] = {
                    title = "Stop Plowing", 
                    event = "prdx_smallmissions:client:stopSnowPlowing"
                }
            end
            lib.registerContext({
                id = 'snowplow_menu',
                title = 'SADOT Snowplowing Menu',
                options = menu,
            })
            lib.showContext('snowplow_menu')
        end

    end)
end)

CreateThread(function()
    QBCore.Functions.TriggerCallback('prdx_smallmissions:server:getPlowNodes', function(nodes)
        Config.SnowPlowNodes = nodes
    end)
end)