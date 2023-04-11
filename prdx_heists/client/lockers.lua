local IsDrilling = false
local soundId = nil
local zones = {}

RegisterNetEvent('prdx_heists:client:lootLocker', function(data)
    local heistID, lockerID = data.heist, data.locker
    local ped = cache.ped
    local pedCo, pedRotation = GetEntityCoords(ped), GetEntityRotation(ped)
    local animDict = 'anim_heist@hs3f@ig9_vault_drill@laser_drill@'
    lib.requestAnimDict(animDict)
    local bagModel = 'hei_p_m_bag_var22_arm_s'
    lib.requestModel(bagModel)
    local laserDrillModel = 'hei_prop_heist_drill'
    lib.requestModel(laserDrillModel)
    soundId = GetSoundId()

    bag = CreateObject(joaat(bagModel), pedCo, 1, 0, 0)
    laserDrill = CreateObject(joaat(laserDrillModel), pedCo, 1, 0, 0)
    
    vaultPos = vec3(Config.Heists[heistID]['lockers'][lockerID]['coords'].x, Config.Heists[heistID]['lockers'][lockerID]['coords'].y, Config.Heists[heistID]['lockers'][lockerID]['coords'].z + 0.25)
    vaultRot = vec3(0, 0, Config.Heists[heistID]['lockers'][lockerID]['heading'])

    for i = 1, #LaserDrill['animations'] do
        LaserDrill['scenes'][i] = NetworkCreateSynchronisedScene(vaultPos, vaultRot, 2, true, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, LaserDrill['scenes'][i], animDict, LaserDrill['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(bag, LaserDrill['scenes'][i], animDict, LaserDrill['animations'][i][2], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(laserDrill, LaserDrill['scenes'][i], animDict, LaserDrill['animations'][i][3], 1.0, -1.0, 1148846080)
    end

    NetworkStartSynchronisedScene(LaserDrill['scenes'][1])
    Wait((GetAnimDuration(animDict, 'intro') * 1000) - 2000)
    NetworkStartSynchronisedScene(LaserDrill['scenes'][2])
    Wait((GetAnimDuration(animDict, 'drill_straight_start') * 1000) - 2000)
    NetworkStartSynchronisedScene(LaserDrill['scenes'][3])
    PlaySoundFromEntity(soundId, "Drill", laserDrill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)
    TriggerEvent('Drilling:Start',function(Success)
        if Success then
            StopSound(soundId)
            NetworkStartSynchronisedScene(LaserDrill['scenes'][5])
            Wait((GetAnimDuration(animDict, 'drill_straight_end') * 1000 - 5000))
            NetworkStartSynchronisedScene(LaserDrill['scenes'][6])
            Wait((GetAnimDuration(animDict, 'exit') * 1000) - 2000)
            ClearPedTasks(ped)
            QBCore.Functions.DeleteEntity(bag)
            QBCore.Functions.DeleteEntity(laserDrill)
            TriggerServerEvent('prdx_heists:server:setLockerState', heistID, lockerID, 'isOpened', true)
            QBCore.Functions.Notify("Successful!", "success")
        else
            StopSound(soundId)
            NetworkStartSynchronisedScene(LaserDrill['scenes'][4])
            Wait(GetAnimDuration(animDict, 'drill_straight_fail') * 1000 - 1500)
            ClearPedTasks(ped)
            QBCore.Functions.DeleteEntity(bag)
            QBCore.Functions.DeleteEntity(laserDrill)
            QBCore.Functions.Notify("Drilling failed..", "error")
            TriggerServerEvent('hud:server:GainStress', math.random(1, 2))
        end
    end)
end)

RegisterNetEvent('prdx_heists:client:setLockerState', function(heistID, lockerID, state, bool)
    if Config.Heists[heistID] then
        Config.Heists[heistID]["lockers"][lockerID][state] = bool
        if state == 'isOpened' and bool == true then -- Remove QB-Target
            exports.ox_target:removeZone(zones[heistID..'-'..lockerID])
            zones[heistID..'-'..lockerID] = nil
        end
    end
end)

RegisterNetEvent('prdx_heists:client:resetLockers', function(heistID)
    for k,v in ipairs(zones) do
        exports.ox_target:removeZone(v)
        zones = {}
    end
end)

RegisterNetEvent('prdx_heists:client:setupLockers', function(heistID)
    if Config.Heists[heistID] then
        for lockerID, data in ipairs(Config.Heists[heistID]["lockers"]) do
            local coords = vector3(data['coords'].x, data['coords'].y, data['coords'].z)
            zones[heistID..'-'..lockerID] = exports.ox_target:addBoxZone({
                coords = coords,
                size = vec3(0.7, 1.1, (data.coords.z+0.5) - (data.coords.z-0.5)),
                rotation = data.heading,
                debug = Config.DebugMode,
                options = {
                    {
                        name = 'prdx_heists:client:lootLocker',
                        event = 'prdx_heists:client:lootLocker',
                        icon = 'fas fa-hand-paper',
                        label = 'Grab',
                        locker = lockerID,
                        heist = heistID,
                        distance = 1.0
                    }
                }
            })
        end
    end
end)

CreateThread(function() -- Fleeca Drill Spots
--[[     for BankID, _ in pairs(Config.SmallBanks) do
        for k,v in ipairs(Config.SmallBanks[BankID]['lockers']) do
            exports['qb-target']:AddBoxZone('FleecaLockers'..BankID..'-'..k, vector3(Config.SmallBanks[BankID]['lockers'][k]['coords'].x, Config.SmallBanks[BankID]['lockers'][k]['coords'].y, Config.SmallBanks[BankID]['lockers'][k]['coords'].z), 1.00, 0.80, {
                name = 'FleecaLockers'..math.random(1,200), 
                heading = Config.SmallBanks[BankID]['lockers'][k]['heading'],
                debugPoly = Config.DebugPoly,
                minZ = Config.SmallBanks[BankID]['lockers'][k]['coords'].z-1,
                maxZ = Config.SmallBanks[BankID]['lockers'][k]['coords'].z+2,
                }, {
                options = {
                    { 
                        type = 'client',
                        event = 'prdx_heists:client:DrillSmallLocker',
                        icon = 'fas fa-bomb',
                        label = 'Drill Locker',
                        locker = k
                    }
                },
                distance = 1.5,
            })
        end
    end ]]
end)
