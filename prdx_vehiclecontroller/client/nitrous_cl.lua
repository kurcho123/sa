NitroEnabled = false
local NitrousData = nil
local Running = false
local tunerData = {}
local vehicles = {}
local particles = {}
local Purge = false
local Nitrofuel = 0
local lastUpdate = 0
local held = 1000
local shake = false

CreateThread(function() -- Load PTFX dictionary for NOS once on every client since every client needs it
    local dictionary = 'veh_xs_vehicle_mods'
    if not HasPtfxAssetLoaded(dictionary) then
        RequestNamedPtfxAsset(dictionary)
        while not HasNamedPtfxAssetLoaded(dictionary) do
            Wait(0)
        end
    end
end)

function GetNitrousFuel()
    return Nitrofuel
end

exports("GetNitrousFuel", GetNitrousFuel)

function SetupNitrous(data)
    if not data then 
        TriggerEvent('hud:client:UpdateNitrous', false) -- No nitrous system installed, disabled nitro hud and skip this entire script
        NitrousData = nil
        Nitrofuel = 0
        lastUpdate = 0
        return 
    end
    NitrousData = data
    Nitrofuel = NitrousData.fuel
    lastUpdate = Nitrofuel
    TriggerEvent('hud:client:UpdateNitrous', true, Nitrofuel, false)
end

local function NitrousMode()
    if NitrousData and inVehicle then
        Purge = not Purge
        if Purge then
            QBCore.Functions.Notify('Nitrous mode: PURGE', 'inform', 500)
        else
            QBCore.Functions.Notify('Nitrous mode: SPRAY', 'inform', 500)
        end
    end
end

local function EnableNitrous()
    if NitrousData and Nitrofuel > 0 then
        if not Purge and not IsDisabledControlPressed(0, 71) then return end
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped)
        NitroEnabled = true
        TriggerEvent('hud:client:UpdateNitrous', true, Nitrofuel, true)
        QBCore.Functions.SetStateBag(vehicle, 'syncNitro', {enable = true, purge = Purge})
        --Entity(vehicle).state:set('syncNitro', {enable = true, purge = Purge}, true) -- Try local state setting
        Wait(250)
    end
end

local function DisableNitrous()
    if NitrousData and NitroEnabled then
        Running = false
        held = 1000
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped)
        TriggerEvent('hud:client:UpdateNitrous', true, Nitrofuel, false)
        QBCore.Functions.SetStateBag(vehicle, 'syncNitro', {enable = false, purge = Purge})
        --Entity(vehicle).state:set('syncNitro', {enable = false, purge = Purge}, true) -- Try local state setting
        NitrousData.fuel = Nitrofuel
        Wait(5)
        NitroEnabled = false
        --Entity(vehicle).state:set('nitrousData', NitrousData, true) -- Try local state setting
        QBCore.Functions.SetStateBag(vehicle, 'nitrousData', NitrousData)
        Wait(250)
    end
end

local function IsVehicleNitroPurgeEnabled(vehicle)
    return vehicles[vehicle] == true
end

local function CreateVehiclePurgeSpray(vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale)
    UseParticleFxAssetNextCall('core')
    return StartParticleFxLoopedOnEntity('exp_sht_steam', vehicle, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, false, false, false)
end
local savedVeh = nil

function NitrousLoop(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    local TuningData = Config.TuningData[Entity(vehicle).state.tunerData]
    local resetNos = false
    -- Setup Max Boost Levels --
    local maxNOSSpeed = 0.0
    local maxSpeed = 0.0
    local NormalDrag = GetVehicleHandlingFloat(vehicle, "CHandlingData", 'fInitialDragCoeff')
    if NitrousData and Config.NOSMPHBoostTable[NitrousData.level] then -- Valid NOS
        NOSDrag = NormalDrag/3
        if NOSDrag < 1.0 then NOSDrag = 1.0 end
        if TuningData and TuningData.MaxSpeed then
            maxSpeed = TuningData.MaxSpeed/2.236936
            maxNOSSpeed = (TuningData.MaxSpeed + Config.NOSMPHBoostTable[NitrousData.level])/2.236936
        elseif vehicleClass ~= 15 and vehicleClass ~= 16 and  vehicleClass ~= 18 then
            maxSpeed = Config.MaxVehicleSpeed/2.236936
            maxNOSSpeed = (Config.MaxVehicleSpeed + Config.NOSMPHBoostTable[NitrousData.level])/2.236936
        end
        -- Start NOS Loop --
        while inVehicle do
            local idle = 0
            if NitrousData and NitrousData.level > 0 then
                if NitroEnabled == true then
                    -- Boost logic + burn fuel --
                    if not Purge then
                        resetNos = true
                        SetVehicleMaxSpeed(vehicle, maxNOSSpeed)
                        SetVehicleHandlingFloat(vehicle, "CHandlingData", 'fInitialDragCoeff', NOSDrag) 
                        SetVehicleEngineTorqueMultiplier(vehicle, (1.0 + (NitrousData.level/4)))
                        Nitrofuel = Nitrofuel - ((Config.Nitrous.FuelBurn * 0.001) + (NitrousData.level * 0.01))
                    else -- purge fuel burn
                        Nitrofuel = Nitrofuel - (Config.Nitrous.FuelBurnPurge * 0.001)
                    end
                    -- Disable if fuel is 0 --
                    if Nitrofuel <= 0 then
                        Nitrofuel = 0
                        idle = 2500
                        DisableNitrous()
                    elseif not IsDisabledControlPressed(0, 71) and not Purge then
                        idle = 2500
                        DisableNitrous()
                    end
                    -- Update HUD + data --
                    if lastUpdate - Nitrofuel > 5 then
                        lastUpdate = Nitrofuel
                        NitrousData.fuel = math.ceil(Nitrofuel)
                        Reset = false
                        TriggerEvent('hud:client:UpdateNitrous', true, Nitrofuel, true)
                    end
                    if not Purge then
                        held = held - 1
                        if held < 1 then held = 1 end
                        if held < 550 then
                            if math.random(0, held) == 1 then
                                RandomFailLoop(vehicle)
                            end
                        end
                    end
                elseif not NitroEnabled and resetNos then
                    resetNos = false
                    SetVehicleMaxSpeed(vehicle, maxSpeed) 
                    SetVehicleHandlingFloat(vehicle, "CHandlingData", 'fInitialDragCoeff', NormalDrag) 
                    SetVehicleEngineTorqueMultiplier(vehicle, 1.0)
                end
            else
                if not Reset then
                    TriggerEvent('hud:client:UpdateNitrous', true, Nitrofuel, true)
                    Reset = true
                end 
                NitrousData = nil
                Nitrofuel = 0
                lastUpdate = 0
                idle = 10000
                held = 1000
            end
            Wait(idle) 
        end
    end
end

RegisterNetEvent('QBCore:drivingVehicle', function(isDriving, currentVehicle)
    if inVehicle and isDriving then return end -- prevent duplicate loops
    inVehicle = isDriving
    if inVehicle then
        NitrousLoop(currentVehicle)
    else
        if NitroEnabled == false and NitrousData and NitrousData.level > 0 then
            idle = 150
            held = 1000
            NitroEnabled = nil -- pauses loop
            NitrousData.fuel = math.ceil(Nitrofuel)
            QBCore.Functions.SetStateBag(currentVehicle, 'nitrousData', NitrousData) -- Leave as server set 
            SetVehicleEngineTorqueMultiplier(currentVehicle, 1.0)
            Reset = false
            TriggerEvent('hud:client:UpdateNitrous', true, Nitrofuel, false)
        end
        SetVehicleBoostActive(currentVehicle, false)
        SetVehicleNitroEnabled(currentVehicle, false)
        StopGameplayCamShaking(true)
    end
end)

AddStateBagChangeHandler('syncNitro' --[[key filter]], nil --[[bag filter]], function(bagName, key, value, _unused, replicated)
    if not value then return end
    local entNet = tonumber(bagName:gsub('entity:', ''), 10)
    local vehicle = NetworkGetEntityFromNetworkId(entNet)
    if not DoesEntityExist(vehicle) then return end
    local enable, purge = value.enable, value.purge
    if enable then
        if purge then  
            if not particles[vehicle] then particles[vehicle] = {} end         
            local bone = GetEntityBoneIndexByName(vehicle, 'engine')
            local pos = GetWorldPositionOfEntityBone(vehicle, bone)
            local off = GetOffsetFromEntityGivenWorldCoords(vehicle, pos.x, pos.y, pos.z)
            UseParticleFxAssetNextCall('core')
            local leftPurge = StartParticleFxLoopedOnEntity('exp_sht_steam', vehicle, off.x - 0.2, off.y + 0.05, off.z, 40.0, -20.0, 0.0, 0.25, false, false, false)
            UseParticleFxAssetNextCall('core')
            local rightPurge = StartParticleFxLoopedOnEntity('exp_sht_steam', vehicle, off.x + 0.2, off.y + 0.05, off.z, 40.0, 20.0, 0.0, 0.25, false, false, false)
            table.insert(particles[vehicle], leftPurge)
            table.insert(particles[vehicle], rightPurge)
            vehicles[vehicle] = true
        else
            if inVehicle and IsPedInVehicle(PlayerPedId(), vehicle) then
                ShakeGameplayCam('SKY_DIVING_SHAKE', 0.5)
                SetVehicleBoostActive(vehicle, enable)
                shake = true
            end
            SetVehicleNitroEnabled(vehicle, enable)
        end
    else
        if inVehicle and IsPedInVehicle(PlayerPedId(), vehicle) then
            SetVehicleBoostActive(vehicle, false)
            StopGameplayCamShaking(true)
            shake = false
        end
        SetVehicleNitroEnabled(vehicle, false)
        if particles[vehicle] and #particles[vehicle] > 0 then
            for _, particleId in ipairs(particles[vehicle]) do
                StopParticleFxLooped(particleId)
            end
        end
        vehicles[vehicle] = nil
        particles[vehicle] = nil
    end
end)

RegisterNetEvent('prdx_vehcontroller:client:refillNitro', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    local data = Entity(vehicle).state.nitrousData
    if not data then
        QBCore.Functions.Notify('No nitrous system installed!', 'error')
    end
    if GetPedInVehicleSeat(vehicle, -1) == ped then
        QBCore.Functions.Progressbar("install_nitrous", "Refilling nitrous system...", math.random(5000, 8000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)   
            data.fuel = 100
            SetupNitrous(data)
            QBCore.Functions.SetStateBag(vehicle, 'nitrousData', data)
            --Entity(vehicle).state:set('nitrousData', data, true) -- Try local state setting
            TriggerEvent('hud:client:UpdateNitrous', true, Nitrofuel, false)
            QBCore.Functions.Notify('Installed new nitrous bottle')
        end, function() -- Cancel
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
        end)
    else
        QBCore.Functions.Notify('Must be in driver seat', 'error')
    end
end)

RegisterNetEvent('prdx_vehcontroller:client:installNitro', function(data)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    if GetPedInVehicleSeat(vehicle, -1) == ped then
        QBCore.Functions.Progressbar("install_nitrous", "Installing nitrous system...", math.random(5000, 8000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)   
            QBCore.Functions.SetStateBag(vehicle, 'nitrousData', data) -- Leave as server set for JIC
            SetupNitrous(data)
            QBCore.Functions.Notify('Installed nitrous level: '..data.level)
        end, function() -- Cancel
            StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
        end)
    else
        QBCore.Functions.Notify('Must be in driver seat', 'error')
    end
end)

RegisterNetEvent('prdx_vehcontroller:client:cheatInstallNitro', function(reclevel)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    local data = {
        fuel = 100,
        level = tonumber(reclevel) or 1,
    }
    QBCore.Functions.SetStateBag(vehicle, 'nitrousData', data)
    --Entity(vehicle).state:set('nitrousData', data, true) -- Try local state setting
    SetupNitrous(data)
    QBCore.Functions.Notify('Installed nitrous level: '..reclevel)
end)

-- Keys --
RegisterCommand('+nitrousMode', NitrousMode, false)
RegisterCommand('+nitrousButton', EnableNitrous, false)
RegisterCommand('-nitrousButton', DisableNitrous, false)
RegisterKeyMapping("+nitrousButton", "Engage vehicle nitrous", "keyboard", 'LMENU')
RegisterKeyMapping("+nitrousMode", "Cycle nitrous mode", "keyboard", 'x')
---