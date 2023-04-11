local DriftActive = false

RegisterNetEvent('QBCore:Client:SetTunerData', function(tunerData, engineSerial, nitrousData, powerDecrease, vehicle, hasEngine)
    local ped = PlayerPedId()
    local veh = vehicle
    if not DoesEntityExist(veh) then
        veh = GetVehiclePedIsIn(ped)
        if veh and veh ~= 0 then
            SetTune(veh, tunerData)
        end
    else
        SetTune(veh, tunerData)
    end
    SetLaunchControlEnabled(false) -- Godmode somehow but only used during launches on drag
    -- Sync Tune --
    TriggerServerEvent('prdx_vehiclecontroller:server:TuningSet', NetworkGetNetworkIdFromEntity(veh), tunerData, engineSerial, nitrousData, powerDecrease, hasEngine or true)
end)

RegisterNetEvent('prdx_vehiclecontroller:client:syncAudio', function(netid, audio)
    if NetworkDoesEntityExistWithNetworkId(netid) then
        local veh = NetToVeh(netid)
        ForceVehicleEngineAudio(veh, audio)
    end
end)

-- Keep audio synced --
AddStateBagChangeHandler('tunerData' --[[key filter]], nil --[[bag filter]], function(bagName, key, value, _unused, replicated)
    Wait(250)
    if not value then return end
    local entNet = tonumber(bagName:gsub('entity:', ''), 10)
    local vehicle = NetworkGetEntityFromNetworkId(entNet)
    if Config.TuningData[value] and vehicle and vehicle ~= 0 then
        ForceVehicleEngineAudio(vehicle, Config.TuningData[value].Audio)
    end
end)

RegisterNetEvent('prdx_vehiclecontroller:client:resetChute', function(entity)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle and vehicle > 0 then
        TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
        QBCore.Functions.Progressbar("repack_chute", "Repacking parachute..", math.random(12000,20000), false, true, {
            disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.SetStateBag(vehicle, 'chuteDeployed', false)
                TriggerServerEvent('prdx_vehiclecontroller:server:repackChute', VehToNet(vehicle))
                QBCore.Functions.Notify('Parachute repacked!', 'success')
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        end) 
    else
        QBCore.Functions.Notify('Error: Vehicle not found', 'error')
    end
end)

function SetTune(vehicle, tunerData)
    local TuningData = {}
    local NitrousData = Entity(vehicle).state.nitrousData
    if vehicle and vehicle ~= 0 then
        local vehicleClass = GetVehicleClass(vehicle)
        local vehModel = GetEntityModel(vehicle)
        if vehicleClass ~= 15 and vehicleClass ~= 16 and  vehicleClass ~= 18 and not Config.BypassLimitModels[vehModel] then
            SetVehicleMaxSpeed(vehicle, Config.MaxVehicleSpeed/2.236936) -- Max civ speed set in config. Overwritten by Tuning Car!
        end
        if Config.TuningData[tunerData] then
            -- Set New Tune --
            TuningData = Config.TuningData[tunerData]
            -- Audio --

            for fieldName,value in pairs(TuningData.Tune) do
                SetVehicleHandlingFloat(vehicle, "CHandlingData", tostring(fieldName), value) 
                Wait(1)
            end
    
            if TuningData.Mass then
                SetVehicleHandlingVector(vehicle, 'CHandlingData', 'vecCentreOfMassOffset', TuningData.Mass)
            end
    
            if TuningData.Interia then
                SetVehicleHandlingVector(vehicle, 'CHandlingData', 'vecInertiaMultiplier', TuningData.Interia)
            end
    
            if TuningData.MaxSpeed then
                SetVehicleMaxSpeed(vehicle, TuningData.MaxSpeed/2.236936)
            end
    
            -- Max Speed --
            ModifyVehicleTopSpeed(vehicle, (TuningData.Speed * 0.1))
            SetVehicleCheatPowerIncrease(vehicle, (TuningData.Speed * 0.1) + 1)
            -- Gearing -- 
            SetVehicleHandlingInt(vehicle, "CHandlingData", 'nInitialDriveGears', TuningData.Gears)
            SetVehicleHighGear(vehicle, TuningData.Gears)
    
            if TuningData.Type == 'drift' then StartDriftLoop(vehicle, tunerData) end
            if TuningData.Type == 'drag' then StartDragLoop(vehicle, tunerData) end
        end

        -- Send Nitro Data --
        SetupNitrous(NitrousData)
    end
end

RegisterNetEvent('QBCore:Client:ResetTunerData', function(vehicle)
    local TuningData = Config.TuningData[Entity(vehicle).state.tunerData]
    if TuningData then
        -- Quite literally there are no getters for shit we do to a car so its easier to just delete it and spawn a new one, its nearly seemless keklul --
        local coords = GetEntityCoords(vehicle)
        local model = GetEntityModel(vehicle)
        local mods = QBCore.Functions.GetVehicleProperties(vehicle)
        mods.tunerData = 'stock'
        mods.engineSerial = nil
        local heading = GetEntityHeading(vehicle)
        QBCore.Functions.SpawnVehicle(model, function(newveh)
            FreezeEntityPosition(newveh, true)
            SetEntityCoordsNoOffset(coords.x, coords.y, coords.z-50.0)
            SetEntityHeading(newveh, heading)
            QBCore.Functions.SetVehicleProperties(newveh, mods)
            QBCore.Functions.DeleteEntity(vehicle)
            SetEntityCoordsNoOffset(newveh, coords.x, coords.y, coords.z)
            SetVehicleOnGroundProperly(newveh)
            FreezeEntityPosition(newveh, false)
            TriggerServerEvent('prdx_vehiclecontroller:server:saveProps', mods)
        end, vec3(coords.x, coords.y, coords.z-50.0), true)
    end
end)

function StartDriftLoop(vehicle, tunerData)
    local Active = false
    local netid = VehToNet(vehicle)
    local ped = PlayerPedId()
    local loopveh = GetVehiclePedIsIn(ped, false)
    SetReduceDriftVehicleSuspension(loopveh, true)
    SetDriftTyresEnabled(loopveh, false)
    TriggerEvent('ToggleQD', true)
    CreateThread(function()
        while true do
            Wait(0)
            if IsPedInAnyVehicle(ped) then
                if IsControlPressed(0, 21) and (GetEntitySpeed(loopveh) * 2.236936) < 105.0 and  GetCurrentAngle() > 1.0 and GetVehicleCurrentRpm(loopveh) < 0.95 then
                    SetVehicleCurrentRpm(loopveh, 1.1)
                end
            else
                TriggerEvent('ToggleQD', false)
                break
            end
        end
    end)
end

function RandomFailLoop(veh)
    local RandomDamage = GetVehicleEngineHealth(veh) - math.random(700,900)
    SetTimeout(math.random(250, 3000), function()
        PauseDamageLoop()
        Wait(10)
        SetVehicleEngineHealth(veh, RandomDamage)
    end)
end

function StartDragLoop()
    math.randomseed(GetGameTimer())
    local Active = false
    local ped = PlayerPedId()
    local loopveh = GetVehiclePedIsIn(ped, false)
    local DefaultTune = {}
    local RandomFail = false
    if Entity(loopveh).state.chuteDeployed == nil then
        QBCore.Functions.SetStateBag(loopveh, 'chuteDeployed', false)
    end
    local ParachuteDeployed = Entity(loopveh).state.chuteDeployed
    for fieldName,value in pairs(Config.DragTune) do
        DefaultTune[fieldName] = GetVehicleHandlingFloat(loopveh, "CHandlingData", tostring(fieldName), value) 
    end
    local BreakDown = math.random(0, 100)
    if BreakDown <= Config.DragRacing.EngineFailChance then RandomFail = true end
    CreateThread(function()
        while true do
            Wait(0)
            if IsPedInAnyVehicle(ped) then
                DisableControlAction(0, 76)
                SetVehicleWheelieState(loopveh, 1)
                if IsControlJustPressed(0, 210) and (GetEntitySpeed(loopveh) * 2.236936) < 8.0 then
                    Active = not Active
                    if not Active then
                        SetVehicleHandbrake(loopveh, false)
                        SetVehicleBrake(loopveh, false)
                        SetVehicleBrakeLights(loopveh, false)
                        if IsControlPressed(0, 71) then
                            SetTimeout(2000, function()
                                for fieldName,value in pairs(DefaultTune) do
                                    SetVehicleHandlingFloat(loopveh, "CHandlingData", tostring(fieldName), value) 
                                end
                            end)
                        else
                            for fieldName,value in pairs(DefaultTune) do
                                SetVehicleHandlingFloat(loopveh, "CHandlingData", tostring(fieldName), value) 
                            end
                        end
                    else
                        QBCore.Functions.Notify('Trans brake set')
                        for fieldName,value in pairs(Config.DragTune) do
                            SetVehicleHandlingFloat(loopveh, "CHandlingData", tostring(fieldName), value) 
                        end
                    end
                end	

                -- Trans Brake Bump --
                if Active and (GetEntitySpeed(loopveh) * 2.236936) > 60.0 then
                    Active = false
                    for fieldName,value in pairs(DefaultTune) do
                        SetVehicleHandlingFloat(loopveh, "CHandlingData", tostring(fieldName), value) 
                    end
                elseif Active and not IsDisabledControlPressed(0, 76) then
                    --SetVehicleCurrentRpm(loopveh, 1.1)
                    SetVehicleBrake(loopveh, true)
                    SetVehicleHandbrake(loopveh, true)
                    SetVehicleBrakeLights(loopveh, true)
                    SetLaunchControlEnabled(true)
                elseif Active and IsDisabledControlPressed(0, 76)  then
                    --SetVehicleCurrentRpm(loopveh, 1.0)
                    SetVehicleHandbrake(loopveh, false)
                    SetVehicleBrake(loopveh, false)
                    SetVehicleBrakeLights(loopveh, false)
                    SetLaunchControlEnabled(false)
                end

                if (GetEntitySpeed(loopveh) * 2.236936) > 110.0 and RandomFail then
                    RandomFailLoop(loopveh)
                    RandomFail = false
                end
 
                -- Parachute deploy -- 
                if IsDisabledControlPressed(0, 76) and not ParachuteDeployed and (GetEntitySpeed(loopveh) * 2.236936) > 130.0  then
                    local coords = GetEntityCoords(loopveh)
                    local chute = CreateObjectNoOffset(`p_cargo_chute_s`, coords.x, coords.y, coords.z - 20.0, true, true, false)
                    local chute2 = CreateObjectNoOffset(`p_cargo_chute_s`, coords.x, coords.y, coords.z - 20.0, true, true, false)
                    local minimum, maximum = GetModelDimensions(GetEntityModel(loopveh))
                    AttachEntityToEntity(chute2, loopveh, 0, 0.0, minimum.y, 0.2, 80.0, math.random(0,360), -30.0, false, false, false, false, 0, true)
                    AttachEntityToEntity(chute, loopveh, 0, 0.0, minimum.y, 0.2, 80.0, math.random(0,360), 30.0, false, false, false, false, 0, true)
                    SetVehicleHandbrake(loopveh, true)
                    QBCore.Functions.SetStateBag(loopveh, 'chuteDeployed', true)
                    ParachuteDeployed = true
                    while true do
                        Wait(10)
                        if GetEntitySpeed(loopveh) * 2.236936 < 10.0 then
                            break
                        end
                    end
                    SetVehicleHandbrake(loopveh, false)
                    QBCore.Functions.DeleteEntity(chute)
                    QBCore.Functions.DeleteEntity(chute2)
                end
            else
                break
            end
        end
    end)
end

function GetCurrentAngle()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local veh = GetVehiclePedIsIn(PlayerPedId())
        local vx,vy,_ = table.unpack(GetEntityVelocity(veh))
        local modV = math.sqrt(vx*vx + vy*vy)


        local _,_,rz = table.unpack(GetEntityRotation(veh,0))
        local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))

        if GetEntitySpeed(veh)* 3.6 < 25 or GetVehicleCurrentGear(veh) == 0 then return 0,modV end --speed over 25 km/h

        local cosX = (sn*vx + cs*vy)/modV
        return math.deg(math.acos(cosX))*0.5, modV
    else
        return 0
    end
end

function GetTuneData(name)
    return Config.TuningData[name] or false
end

function GetTunerConfig()
    return Config.TuningData
end

exports("GetTuneData", GetTuneData)
exports("GetTunerConfig", GetTunerConfig)

local bones = {
    "petroltank",
    "petroltank_l",
    "petroltank_r",
    "wheel_rf",
    "wheel_rr",
    "petrolcap ",
    'boot',
}

exports['qb-target']:AddTargetBone(bones, {
    options = {
    {
        id = -1,
        type = "client",
        event = "prdx_vehiclecontroller:client:resetChute",
        icon = "fas fa-parachute-box",
        label = "Repack Chute",
        canInteract = function(entity, distance, data)
            return Entity(entity).state.chuteDeployed 
        end
    }
},
    distance = 1.5,
})