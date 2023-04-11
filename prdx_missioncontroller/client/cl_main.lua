QBCore = exports['qb-core']:GetCoreObject()
local masterList = {}

function StartPatrol(patrolRoute) -- Do a ptrol route (prolly won't keep)
    if Config.PatrolRoutes[patrolRoute] then
        OpenPatrolRoute(patrolRoute)
        for id, coords in ipairs(Config.PatrolRoutes[patrolRoute]) do
            local random = math.random(1, #Config.PatrolScenarios)
            print('Add patrol node:', id, Config.PatrolScenarios[random], coords)
            AddPatrolRouteNode(tonumber(id), Config.PatrolScenarios[random].scenario, coords.x, coords.y, coords.z, coords.x, coords.y, coords.z, math.random(Config.PatrolScenarios[random].min,Config.PatrolScenarios[random].max))
            if Config.PatrolRoutes[patrolRoute][id-1] then
                AddPatrolRouteLink(id-1, id)
            end
        end
        ClosePatrolRoute()
        CreatePatrolRoute()
    end
end

function StartVehiclePatrol(group)
    if Config.VehiclePatrols[group] then
        local groupInfo = Config.VehiclePatrols[group]
        lib.requestModel(groupInfo.vehicleModel)
        lib.requestModel(groupInfo.driver)
        local veh = CreateVehicle(groupInfo.vehicleModel, groupInfo.spawnLocation.x, groupInfo.spawnLocation.y, groupInfo.spawnLocation.z, groupInfo.spawnLocation.w, true)
        local ped = CreatePed(4, pedData.model, groupInfo.spawnLocation.x, groupInfo.spawnLocation.y, groupInfo.spawnLocation.z, groupInfo.spawnLocation.w, true)
        while not DoesEntityExist(veh) and not DoesEntityExist(ped) do Wait(0) end
        --TaskVehicleDriveToCoord(pedDriver, veh, dropLocation, 100.00, 1, pedVehicle, 786468, 5.0, true) Old heli code

    end
end
local count = 0
RegisterNetEvent('prdx_missioncontroller:client:setupPed', function(pedNet, pedData, taskData)
    local ped = NetToPed(pedNet)
    if ped > 0 and pedData then
        Wait(100)
        -- Makes ped hate player and not suck at combat/setup for all peds to not suck --    
        SetEntityLoadCollisionFlag(ped, true)
        SetPedRelationshipGroupHash(ped, `HATES_PLAYER`)
        SetPedDropsWeaponsWhenDead(ped, false)
        SetPedCombatAttributes(ped, 0, true)
        SetPedCombatAttributes(ped, 5, true)
        SetPedCombatAttributes(ped, 46, true)
        SetPedPinnedDown(ped, false, -1)
        SetPedFleeAttributes(ped, 2, false)
        SetPedDropsWeaponsWhenDead(ped, false)
        SetPedTargetLossResponse(ped, 1)
        SetRagdollBlockingFlags(ped, 1)
        AddBlipForEntity(ped)
        if pedData.pedType == 'attacker' then
            SetPedSuffersCriticalHits(ped, false)
            SetPedArmour(ped, 50)  
        end
        SetPedCanSwitchWeapon(ped, false)
        if taskData then
            if taskData.type == 'attackarea' then
                print('Setup ped:', count+1)
                count = count + 1
                SetBlockingOfNonTemporaryEvents(ped, false)
                SetPedConfigFlag(ped, 188, false)
                SetPedCombatMovement(ped, 2)
                SetCombatFloat(ped, 3, 0.5)
                SetCombatFloat(ped, 4, 1000.0)
                SetCombatFloat(ped, 3, 0.0)              
                TaskCombatHatedTargetsInArea(ped, taskData.coords.x, taskData.coords.y, taskData.coords.z, 150.0, 0)
                SetPedKeepTask(ped, true)
            elseif taskData.type == 'guard' then
                TaskGuardCurrentPosition(ped, 35.0, 35.0, 1)
            elseif taskData.type == 'drivewander' then
                local vehicle = GetVehiclePedIsIn(ped)
                if vehicle > 0 then
                    TaskVehicleDriveWander(ped, vehicle, 25.0, 443)
                end
            elseif taskData.type == 'drivechase' then
                local vehicle = GetVehiclePedIsIn(ped)
                if vehicle > 0 then
                    TaskVehicleChase(ped, cache.ped)
                    SetTaskVehicleChaseBehaviorFlag(ped, 8, true)
                end
            end
        end
    end
end)

RegisterNetEvent('prdx_missioncontroller:client:cleanupPed', function(pedNet)
    local ped = NetToPed(pedNet)
    if ped > 0 then
        SetPedAsNoLongerNeeded(ped)
    end
end)

AddEventHandler('onResourceStart', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        
    end
end)
