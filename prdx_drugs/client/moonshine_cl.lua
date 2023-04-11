local QBCore = exports['qb-core']:GetCoreObject()
local ClientStillList = {}
local LinkPump = nil

-- Functions --
function TimeFormat(timestamp)
    local time = (timestamp - GetNetworkTimeAccurate()) / 1000
    local minutes = '00'
    if time > 60 then minutes = math.floor(time/60) end
    if time <= 0 then return false end
    local seconds = math.floor(time - (minutes * 60))
    if seconds < 10 then
        return tostring(minutes..':0'..seconds)
    else
        return tostring(minutes..':'..seconds)
    end
end

CreateThread(function ()
    local options1 = {
        {
            name = 'prdx_moonshine:client:stillStatusMenu',
            event = 'prdx_moonshine:client:stillStatusMenu',
            icon = 'fas fa-fire-burner',
            label = 'Still Options',
            canInteract = function(entity, distance, coords, name, bone)
                if not Entity(entity).state.stillID then return false end
                return true
            end,
            distance = 1.25
        },
        {
            name = 'prdx_moonshine:client:linkStill',
            icon = 'fas fa-faucet',
            label = 'Hookup Water Line -Complete Link-',
            onSelect = function(data)
                local entity = data.entity
                local netid = NetworkGetNetworkIdFromEntity(entity)
                local pumpEnt = NetworkGetEntityFromNetworkId(LinkPump)
                local pumpCoords, entCoords = GetEntityCoords(pumpEnt), GetEntityCoords(entity)
                local waterModel = GetEntityModel(pumpEnt)
                local distance = 0
                local waterType
                if (waterModel == Config.Moonshine.PumpModel) then
                    waterType = 'pump'
                    distance = Config.Moonshine.WaterDistancePump
                elseif (waterModel == Config.Moonshine.TankModel) then
                    waterType = 'tank'
                    distance = Config.Moonshine.WaterDistanceTank
                end
                if #(pumpCoords - entCoords) > distance then QBCore.Functions.Notify('Error: Too far: '..math.ceil(#(pumpCoords - entCoords))..'/'..distance..'m', 'error') return end
                TriggerServerEvent('prdx_moonshine:server:linkWaterSource', netid, LinkPump, waterType)
                LinkPump = nil
            end,
            canInteract = function(entity, distance, coords, name, bone)
                if not LinkPump then return false end
                return true
            end,
            distance = 1.25
        }
    }
    exports.ox_target:addModel(joaat('prop_still'), options1)

    local options2 = {
        {
            name = 'prdx_moonshine:client:linkWaterEnt',
            event = 'prdx_moonshine:client:linkWaterEnt',
            icon = 'fas fa-faucet',
            label = 'Hookup Pump -Start Link-',
            canInteract = function(entity, distance, coords, name, bone)
                if not Entity(entity).state.waterEntReady then return false end
                return true
            end,
            distance = 1.25
        }
    }
    exports.ox_target:addModel(joaat(Config.Moonshine.PumpModel), options2)

    local options3 = {
        {
            name = 'prdx_moonshine:client:waterTankMenu',
            event = 'prdx_moonshine:client:waterTankMenu',
            icon = 'fas fa-faucet',
            label = 'Water Tank Status',
            canInteract = function(entity, distance, coords, name, bone)
                if not Entity(entity).state.waterTank then return false end
                return true
            end,
            distance = 1.25
        },
        {
            name = 'prdx_moonshine:client:linkWaterEnt',
            event = 'prdx_moonshine:client:linkWaterEnt',
            icon = 'fas fa-faucet',
            label = 'Hookup Water Tank -Start Link-',
            canInteract = function(entity, distance, coords, name, bone)
                if not Entity(entity).state.waterEntReady then return false end
                return true
            end,
            distance = 1.25
        }
    }
    exports.ox_target:addModel(joaat(Config.Moonshine.TankModel), options3)
end)

AddEventHandler('prdx_moonshine:client:linkWaterEnt', function(data)
    local pumpEnt = data.entity
    LinkPump = NetworkGetNetworkIdFromEntity(pumpEnt)
    QBCore.Functions.Notify('Started water line link!', 'info')
end)

AddEventHandler('prdx_moonshine:client:openStill', function(stillID)
    if not stillID then print('Fail to get still ID: Stash open') return end
    QBCore.Functions.TriggerCallback('prdx_moonshine:server:registerStillStash', function(success)
        if not success then print('Failed to create stash with ID:', stillID) return end
        exports.ox_inventory:openInventory('stash', 'still_'..stillID)
    end, stillID) 
end)


AddEventHandler('prdx_moonshine:client:waterTankMenu', function(data)
    local tankNumber = Entity(data.entity).state.waterTank
    if not tankNumber then print('No tank number') return end
    QBCore.Functions.TriggerCallback('prdx_moonshine:server:getStillData', function(stillData)
        if not stillData?.waterSupply then print('No Still Number') return end
        local menu = {
            {
                title = "Status", 
                description = 'Fill Level: '..stillData.waterSupply.fill..'%',
                disabled = true
            },
            {
                title = "Add Water", 
                serverEvent = "prdx_moonshine:server:addWater",
                args = tankNumber
            },     
        }
        lib.registerContext({
            id = 'water_status_menu',
            title = 'Water Tank #'..tankNumber,
            options = menu,
        })
        lib.showContext('water_status_menu') 
    end, tankNumber)
end)

AddEventHandler('prdx_moonshine:client:stillStatusMenu', function(data)
    local entity = data.entity or 0
    if entity <= 0 then return end
    local stillID = Entity(entity).state.stillID
    QBCore.Functions.TriggerCallback('prdx_moonshine:server:getStillData', function(stillData)
        if not stillData then QBCore.Functions.Notify('Error: No still data', 'error') return end
        local readableData = {}
        if stillData.status then readableData.status = 'Lit' else readableData.status = 'Out' end
        if not stillData.waterSupply or not stillData.waterSupply.netid then 
            readableData.water = 'No Water Source' 
        elseif stillData.waterSupply and stillData.waterSupply.fill == false then
            readableData.water = 'Pump Linked' 
        else
            readableData.water = QBCore.Shared.Round(stillData.waterSupply.fill, 2)..'%' 
        end
        if stillData.batchStartTime then
            if not stillData.status and stillData.stopTime then
                readableData.timer = 'Interupted'
            else
                local timeRemaining = TimeFormat(stillData.batchStartTime + Config.Moonshine.MainTimer)
                if not timeRemaining then
                    readableData.timer = 'Complete'
                else
                    readableData.timer = timeRemaining
                end
            end
        else
            readableData.timer = 'None'
        end
        
        local menu = {
            {
                title = "Status", 
                description = "Fire: "..readableData.status.."\n\rBatch Time: "..readableData.timer.."\n\rWater: "..readableData.water.."\n\rFuel: "..QBCore.Shared.Round(stillData.fuel, 2)..'%',
                disabled = true
            },     
        }
        if stillData.status then
            menu[#menu+1] = {
                title = "Batch in Progress", 
                disabled = true,
            } 
            menu[#menu+1] = {
                title = "Smother Fire", 
                serverEvent = "prdx_moonshine:server:stopStill",
                args = stillID
            }
        else
            menu[#menu+1] = {
                title = "Open Still", 
                event = "prdx_moonshine:client:openStill",
                disabled = stillData.status,
                args = stillID       
            }
            menu[#menu+1] = {
                title = "Light Fire", 
                serverEvent = "prdx_moonshine:server:startStill",
                args = stillID
            }
        end

        if stillData.fuel < 100 then
            menu[#menu+1] = {
                title = "Add Fuel", 
                serverEvent = "prdx_moonshine:server:addFuel",
                args = stillID
            }
        end

        menu[#menu+1] = {
            title = "Pickup Still",
            serverEvent = 'prdx_moonshine:server:removeStill',
            args = stillID,
        }

        lib.registerContext({
            id = 'still_status_menu',
            title = 'Still #'..stillID,
            options = menu,
        })
        lib.showContext('still_status_menu') 
    end, stillID) 
end)

RegisterNetEvent('prdx_props:client:droppedProp', function(propEnt, propData)
    if propData == 'water_pump' then
        local state = Entity(propEnt).state.sceneList
        if not state or not state[1] then print('Fail state:', state) return end
        local pumpEnt = NetworkGetEntityFromNetworkId(state[1])
        local pumpCoords = GetEntityCoords(pumpEnt)
        local inWater, height = TestVerticalProbeAgainstAllWater(pumpCoords.x, pumpCoords.y, pumpCoords.z+2.5, 32)
        if not inWater or height < pumpCoords.z then QBCore.Functions.Notify('Pump out of water!', 'error') return end
        QBCore.Functions.Notify('Pump starting!', 'success')
        QBCore.Functions.SetStateBag(propEnt, 'waterEntReady', true)
    elseif propData == 'water_tank' then
        QBCore.Functions.Notify('Tank placed!', 'success') 
        QBCore.Functions.SetStateBag(propEnt, 'waterEntReady', true)
        QBCore.Functions.SetStateBag(propEnt, 'waterTank', nil)
    end
end)

RegisterNetEvent('prdx_moonshine:client:spawnStill', function()
    local coords = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.75, 0.0)
    local model = joaat('prop_still')
    if not IsModelInCdimage(model) then return end
    lib.requestModel(model)
    local prop = CreateObject(model, coords.x, coords.y, coords.z, false, true) -- temp model for placement
    SetEntityAlpha(prop, 115)
    SetEntityCompletelyDisableCollision(prop, true, false)
    FreezeEntityPosition(prop, true)
    local isPlacing = true
    local cancel = false
    while isPlacing do
        Wait(0)
        lib.showTextUI('[E] - Place Still')
        local offset = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 1.5, 0.5)
        SetEntityCoords(prop, offset.x, offset.y, offset.z)
        SetEntityHeading(prop, GetEntityHeading(cache.ped))
        if IsDisabledControlJustPressed(0, 46) then
            isPlacing = false
            PlaceObjectOnGroundProperly(prop)
        end
    end
    Wait(250)
    PlaceObjectOnGroundProperly(prop)
    lib.hideTextUI()
    Wait(1)    -- Allow ticks to pass to ensure proper placement
    TriggerServerEvent('prdx_moonshine:server:registerStill', GetEntityCoords(prop), GetEntityRotation(prop, 2))
    Wait(250)
    DeleteEntity(prop)
end)

RegisterNetEvent('prdx_moonshine:client:syncStills', function(method, stillData)
    if method == 'ptfxadd' then
        if ClientStillList[stillData.stillID] then
            RemoveParticleFx(ClientStillList[stillData.stillID], true)
        end
        local newZ = stillData.coords.z + 1.5
        stillData.coords = vec3(stillData.coords.x, stillData.coords.y, stillData.coords.z)
        QBCore.Functions.StartParticleAtCoord(Config.Moonshine.SmokePTFx.lib, Config.Moonshine.SmokePTFx.name, true, stillData.coords, vec3(0.0,0.0,0.0), 0.35, 10)
        ClientStillList[stillData.stillID] = stillData.coords
    elseif method == 'ptfxremove' then
        if ClientStillList[stillData.stillID] then
            RemoveParticleFxInRange(ClientStillList[stillData.stillID].x, ClientStillList[stillData.stillID].y, ClientStillList[stillData.stillID].z, 1.0)
            ClientStillList[stillData.stillID] = nil
        end
    end
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('prdx_moonshine:server:getAllStills', function(data)
        for id,stillData in pairs(data) do
            local newZ = stillData.coords.z + 1.5
            stillData.coords = vec3(stillData.coords.x, stillData.coords.y, stillData.coords.z)
            QBCore.Functions.StartParticleAtCoord(Config.Moonshine.SmokePTFx.lib, Config.Moonshine.SmokePTFx.name, true, stillData.coords, vec3(0.0,0.0,0.0), 0.35, 10)
            ClientStillList[stillData.stillID] = stillData.coords
            Wait(0)
        end
    end)
end)

-- This is to make sure the peds spawn on restart too instead of only when you load/log-in.
AddEventHandler('onResourceStart', function(resource)
    Wait(500)
	if resource ~= GetCurrentResourceName() or not LocalPlayer.state.isLoggedIn then return end
    QBCore.Functions.TriggerCallback('prdx_moonshine:server:getAllStills', function(data)
        for id,stillData in pairs(data) do
            ClientStillList[stillData.stillID] = QBCore.Functions.StartParticleAtCoord(Config.Moonshine.SmokePTFx.lib, Config.Moonshine.SmokePTFx.name, true, stillData.coords, nil, 1.0)
            Wait(0)
        end
    end)
end)

-- This is to make sure the peds remove on restart too.
AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for k,v in pairs(ClientStillList) do
        RemoveParticleFx(v, true)
    end
end)