-- Variables

local ObjectList = {}
local SpawnedSpikes = {}
local spikemodel = 'P_ld_stinger_s'
local ClosestSpike = nil

local SpikeConfig = {
    MaxSpikes = 5
}

-- Functions

local function GetClosestPoliceObject()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil

    for id, data in pairs(ObjectList) do
        local dist2 = #(pos - vector3(ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z))
        if current then
            if dist2 < dist then
                current = id
                dist = dist2
            end
        else
            dist = dist2
            current = id
        end
    end
    return current, dist
end

function GetClosestSpike()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil

    for id, data in pairs(SpawnedSpikes) do
        if current then
            if #(pos - vector3(SpawnedSpikes[id].coords.x, SpawnedSpikes[id].coords.y, SpawnedSpikes[id].coords.z)) < dist then
                current = id
            end
        else
            dist = #(pos - vector3(SpawnedSpikes[id].coords.x, SpawnedSpikes[id].coords.y, SpawnedSpikes[id].coords.z))
            current = id
        end
    end
    ClosestSpike = current
end

local function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

-- Events

RegisterNetEvent('police:client:spawnCone', function()
    QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "cone")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnBarier', function()
    QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "barier")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnSchotten', function()
    QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "schotten")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnTent', function()
    QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "tent")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:spawnLight', function()
    local coords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@narcotics@trash",
        anim = "drop_front",
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        TriggerServerEvent("police:server:spawnObject", "light")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('police:client:deleteObject', function()
    local objectId, dist = GetClosestPoliceObject()
    if dist < 5.0 then
        QBCore.Functions.Progressbar("remove_object", "Removing object..", 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
            anim = "plant_floor",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
            TriggerServerEvent("police:server:deleteObject", objectId)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
            QBCore.Functions.Notify("Canceled..", "error")
        end)
    end
end)

RegisterNetEvent('police:client:removeObject', function(objectId)
    if ObjectList[objectId] then
        QBCore.Functions.TakeControl(ObjectList[objectId].object)
        DeleteObject(ObjectList[objectId].object)
        ObjectList[objectId] = nil
    end
end)

RegisterNetEvent('police:client:spawnObject', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    QBCore.Functions.SpawnObject(Config.Objects[type].model, function(spawnedObj)
        PlaceObjectOnGroundProperly(spawnedObj)
        SetEntityHeading(spawnedObj, heading)
        FreezeEntityPosition(spawnedObj, Config.Objects[type].freeze)
        ObjectList[objectId] = {
            id = objectId,
            object = spawnedObj,
            coords = {
                x = x,
                y = y,
                z = z - 0.3,
            },
        }
    end, vec3(x, y, z), true)   
end)

RegisterNetEvent('police:client:SpawnSpikeStrip', function()
    if #SpawnedSpikes + 1 < SpikeConfig.MaxSpikes then
        local player = QBCore.Functions.GetPlayerData()
        PlayerJob = player.job
        if PlayerJob.onduty and (PlayerJob.name == "marshalls" or PlayerJob.name == "lspd" or PlayerJob.name == "bcso" or PlayerJob.name == "sast" or PlayerJob.name == "hc" or PlayerJob.name == "pd_cid") then
           
            local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
            QBCore.Functions.SpawnObject(spikemodel, function(spike)
                SetEntityHeading(spike, GetEntityHeading(PlayerPedId()))
                PlaceObjectOnGroundProperly(spike)
                SpawnedSpikes[#SpawnedSpikes+1] = {
                    coords = {
                        x = spawnCoords.x,
                        y = spawnCoords.y,
                        z = spawnCoords.z,
                    },
                    netid = recprop,
                    object = spike,
                }
                TriggerServerEvent('police:server:SyncSpikes', SpawnedSpikes)
            end, vec3(spawnCoords.x, spawnCoords.y, spawnCoords.z), true) 
        end
    else
        QBCore.Functions.Notify('There are no Spikestrips left..', 'error')
    end
end)

RegisterNetEvent('police:client:SyncSpikes', function(table)
    SpawnedSpikes = table
end)

-- Threads

Citizen.CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            GetClosestSpike()
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            --
            if ClosestSpike then
                --
                local tires = {
                    {bone = "wheel_lf", index = 0},
                    {bone = "wheel_rf", index = 1},
                    {bone = "wheel_lm", index = 2},
                    {bone = "wheel_rm", index = 3},
                    {bone = "wheel_lr", index = 4},
                    {bone = "wheel_rr", index = 5}
                }

                for a = 1, #tires do
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                    if #(tirePos - vec3(0,0,0)) > 1.0 then
                        local spikePos = vector3(SpawnedSpikes[ClosestSpike].coords.x, SpawnedSpikes[ClosestSpike].coords.y, SpawnedSpikes[ClosestSpike].coords.z)
                        local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)
                        
                        if distance < 1.8 then
                            
                            if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
                                
                                SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                            end
                        end
                    end
                end
            end
        end

        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            if ClosestSpike then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local dist = #(pos - vector3(SpawnedSpikes[ClosestSpike].coords.x, SpawnedSpikes[ClosestSpike].coords.y, SpawnedSpikes[ClosestSpike].coords.z))

                if dist < 2 then
                    if not IsPedInAnyVehicle(PlayerPedId()) then
                        if not PlayerJob then
                            local player = QBCore.Functions.GetPlayerData()
                            PlayerJob = player.job
                        end
                        if PlayerJob.onduty and (PlayerJob.name == "marshalls" or PlayerJob.name == "lspd" or PlayerJob.name == "bcso" or PlayerJob.name == "sast" or PlayerJob.name == "hc" or PlayerJob.name == "pd_cid") then
                            DrawText3D(pos.x, pos.y, pos.z, '[E] Delete Spike')
                            if IsControlJustPressed(0, 38) then
                                TriggerServerEvent('QBCore:Game:Delete', SpawnedSpikes[ClosestSpike].netid)
                                table.remove(SpawnedSpikes, ClosestSpike)
                                ClosestSpike = nil
                                TriggerServerEvent('police:server:SyncSpikes', SpawnedSpikes)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(3)
    end
end)
