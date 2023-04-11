-----------------------
----   Variables   ----
-----------------------
local QBCore = exports['qb-core']:GetCoreObject()
local KeysList = {}

local isTakingKeys = false
local isCarjacking = false
local canCarjack = true
local AlertSend = false
local lastPickedVehicle = nil
local usingAdvanced = false
local busy = false
local HotwireNotify = false
local inVehicle = false
local CurrentJob = 'unemployed'
local needsHotwire = false
local isPullingOut = false
-----------------------
----   Functions   ----
-----------------------

function GiveKeys(id, plate)
    local distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(id))))
    if distance < 10.5 and distance > 0.0 then
        TriggerServerEvent('qb-vehiclekeys:server:GiveVehicleKeys', id, plate)
    else
        QBCore.Functions.Notify('There is nobody nearby to hand keys to.','error')
    end
end

function GetKeys()
    QBCore.Functions.TriggerCallback('qb-vehiclekeys:server:GetVehicleKeys', function(keysList)
        KeysList = keysList
        if IsPedInAnyVehicle(PlayerPedId()) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            local plate = QBCore.Functions.GetPlate(vehicle)
            if KeysList[plate] then
                TriggerServerEvent("qb-vehiclekeys:server:AcquireVehicleKeys", plate)
            end
        end
    end)
end

function HasKeys(plate)
    return KeysList[plate]
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

function GetPlayerFromPed(ped)
	for _, playerId in ipairs(GetActivePlayers()) do
		if ped == GetPlayerPed(playerId) then
			return playerId
		end
	end

	return nil
end

function GetVehicleInDirection(coordFromOffset, coordToOffset)
    local ped = PlayerPedId()
    local coordFrom = GetOffsetFromEntityInWorldCoords(ped, coordFromOffset.x, coordFromOffset.y, coordFromOffset.z)
    local coordTo = GetOffsetFromEntityInWorldCoords(ped, coordToOffset.x, coordToOffset.y, coordToOffset.z)

    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

-- If in vehicle returns that, otherwise tries 3 different raycasts to get the vehicle they are facing.
-- Raycasts picture: https://i.imgur.com/FRED0kV.png
function GetVehicle()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())

    local RaycastOffsetTable = {
        { ['fromOffset'] = vector3(0.0, 0.0, 0.0), ['toOffset'] = vector3(0.0, 20.0, -10.0) }, -- Waist to ground 45 degree angle
        { ['fromOffset'] = vector3(0.0, 0.0, 0.7), ['toOffset'] = vector3(0.0, 10.0, -10.0) }, -- Head to ground 30 degree angle
        { ['fromOffset'] = vector3(0.0, 0.0, 0.7), ['toOffset'] = vector3(0.0, 10.0, -20.0) }, -- Head to ground 15 degree angle
    }

    local count = 0
    while vehicle == 0 and count < #RaycastOffsetTable do
        count = count + 1
        vehicle = GetVehicleInDirection(RaycastOffsetTable[count]['fromOffset'], RaycastOffsetTable[count]['toOffset'])
    end

    if not IsEntityAVehicle(vehicle) then vehicle = nil end
    return vehicle
end

function ToggleVehicleLocks(veh)
    if veh then
        local ped = PlayerPedId()
        if GetVehiclePedIsIn(ped) == veh or HasKeys(QBCore.Functions.GetPlate(veh)) then
            local stateLocks = Entity(veh).state.stateLocks
            if not stateLocks then
                stateLocks = GetVehicleDoorLockStatus(veh)
            end
            TriggerEvent('animations:client:EmoteCommandStart', {"keyfob"})
            TriggerEvent('InteractSound_CL:PlayOnOne', 'carlock', 0.25)
            if stateLocks <= 1 then
                SetVehicleDoorsLocked(veh, 2)
                QBCore.Functions.Notify("Vehicle locked!", "inform")
                QBCore.Functions.SetStateBag(veh, 'stateLocks', 2)
            else
                SetVehicleDoorsLocked(veh, 1)
                QBCore.Functions.Notify("Vehicle unlocked!", "success")
                QBCore.Functions.SetStateBag(veh, 'stateLocks', 1)
            end
            SetVehicleLights(veh, 2)
            Wait(250)
            SetVehicleLights(veh, 1)
            Wait(200)
            SetVehicleLights(veh, 0)
            SetVehicleHasBeenOwnedByPlayer(veh, true)
        else
            QBCore.Functions.Notify("You don't have keys to this vehicle.", 'error')
        end
    end
end

function GetOtherPlayersInVehicle(vehicle)
    local otherPeds = {}
    for seat=-1,GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))-2 do
        local pedInSeat = GetPedInVehicleSeat(vehicle, seat)
        if IsPedAPlayer(pedInSeat) and pedInSeat ~= PlayerPedId() then
            otherPeds[#otherPeds+1] = pedInSeat
        end
    end
    return otherPeds
end

function LockpickDoor(isAdvanced, slot)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehicle = QBCore.Functions.GetClosestVehicle(pos)
    if vehicle ~= nil and vehicle ~= 0 then
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 3.0 and not IsThisModelATrain(GetEntityModel(vehicle)) and not Entity(vehicle).state.isDisabled then -- No lockpicking trains
            local vehLockStatus = GetVehicleDoorLockStatus(vehicle)
            if (vehLockStatus > 0) then
                if isAdvanced then
                    TriggerServerEvent("QBCore:Server:RemoveItemDurability", "advancedlockpick", 15, slot)
                else
                    TriggerServerEvent("QBCore:Server:RemoveItemDurability", "lockpick", 25, slot)
                end
                if Config.ClassList[GetVehicleClass(vehicle)] == 'easy' then
                    doAnim = true
                    if isAdvanced then
                        -- lockpickFinish(exports["skillcheck"]:StartCheck(6, 2))
                        lockpickFinish(lib.skillCheck({{ areaSize = 60, speedMultiplier = 0.8 }, { areaSize = 60, speedMultiplier = 0.8 }}))
                    else
                        -- lockpickFinish(exports["skillcheck"]:StartCheck(4, 3))
                        lockpickFinish(lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'medium'}))
                    end
                elseif Config.ClassList[GetVehicleClass(vehicle)] == 'med' then
                    doAnim = true
                    if isAdvanced then
                        -- lockpickFinish(exports["skillcheck"]:StartCheck(3, 3))
                        lockpickFinish(lib.skillCheck({'easy', 'easy', 'easy'}))
                    else
                        -- lockpickFinish(exports["skillcheck"]:StartCheck(2, 5))
                        lockpickFinish(lib.skillCheck({'easy', 'medium', 'medium', 'medium'}))
                    end
                elseif Config.ClassList[GetVehicleClass(vehicle)] == 'hard' then
                    doAnim = true
                    if isAdvanced then
                        -- lockpickFinish(exports["skillcheck"]:StartCheck(2, 3))
                        lockpickFinish(lib.skillCheck({'easy', 'medium', 'medium'}))
                    else
                        lockpickFinish(lib.skillCheck({'medium', 'medium', 'medium', 'hard'}))
                    end  
                elseif Config.ClassList[GetVehicleClass(vehicle)] == 'codebreaker' then
                    QBCore.Functions.Notify("Your lockpick does not appear to work...", 'error')
                end
            end
        end
    end
end

function lockpickFinish(success)
    doAnim = false
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate = QBCore.Functions.GetPlate(vehicle)
    if not vehicle or vehicle == 0 then return end
    local chance = math.random()
    StopAnimPlayback(PlayerPedId())
    if success then
        QBCore.Functions.SetStateBag(vehicle, 'stateLocks', 1)
        TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
        QBCore.Functions.Notify('You managed to pick the door lock open!', 'success')
        SetVehicleDoorsLocked(vehicle, 1)
    else
        TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
        AttemptPoliceAlert("steal")
    end
end

function Hotwire(vehicle, plate)
    local vehicle = vehicle
    local plate = plate
    local hotwireTime = math.random(Config.minHotwireTime, Config.maxHotwireTime)
    local ped = PlayerPedId()
    if not vehicle then
        vehicle = GetVehiclePedIsIn(ped)
    end
    if not plate then
        plate = QBCore.Functions.GetPlate(vehicle)
    end
    if not vehicle or not plate then return end
    if Config.ImmuneVehicles[GetEntityModel(vehicle)] then return end -- Immune to being hotwired
    if math.random(0,3) == 1 then
        SetVehicleAlarm(vehicle, true)
        SetVehicleAlarmTimeLeft(vehicle, hotwireTime)
    end
    QBCore.Functions.Progressbar("hotwire_vehicle", "Searching for the car keys...", hotwireTime, false, true, {
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
        TriggerServerEvent('hud:server:GainStress', math.random(1, 4))
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', QBCore.Functions.GetPlate(vehicle))
        if GetPedInVehicleSeat(vehicle, -1) == ped then
            TriggerServerEvent('wk:addBoloPlate', QBCore.Functions.GetPlate(vehicle), GetEntityModel(vehicle))
        end
        needsHotwire = false
        lib.removeRadialItem('hotwire')
        Wait(Config.TimeBetweenHotwires)
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
    end)
end

function AttemptPoliceAlert(type)
    if not AlertSend then
        local chance = Config.PoliceAlertChance
        if GetClockHours() >= 1 and GetClockHours() <= 6 then
            chance = Config.PoliceNightAlertChance
        end
        if math.random() <= chance then
            TriggerServerEvent('cd_dispatch:pdalerts:Stolencar', exports['cd_dispatch']:GetPlayerInfo())
        end
        AlertSend = true
        SetTimeout(Config.AlertCooldown, function()
            AlertSend = false
        end)
    end
end


-----------------------
----   Threads     ----
-----------------------
CreateThread(function()
    while true do
        local sleep = 100
        local ped = PlayerPedId()
        local enteringVeh = GetVehiclePedIsTryingToEnter(ped)
        if enteringVeh > 0 then
            sleep = 5000
            local vehicleClass = GetVehicleClass(enteringVeh)
            if Config.ImmuneClasses[vehicleClass] then
                SetVehicleDoorsLocked(enteringVeh, Config.ImmuneClasses[vehicleClass]) -- Class based locked
            else
                local hasDriver = GetPedInVehicleSeat(enteringVeh, -1)
                local stateLocks = Entity(enteringVeh).state.stateLocks
                if hasDriver == 0 then -- EMPTY
                    if stateLocks then
                        SetVehicleDoorsLocked(enteringVeh, tonumber(stateLocks))
                    else
                        SetVehicleDoorsLocked(enteringVeh, 2)
                    end
                    sleep = 500 
                else -- Has Driver
                    if (IsPedDeadOrDying(hasDriver) or Entity(hasDriver).state.isDead) and Config.ClassList[vehicleClass] ~= 'codebreaker' then -- free keys!
                        if IsPedAPlayer(hasDriver) then
                            TriggerServerEvent('qb-vehiclekeys:server:pullOutOfCar', GetPlayerServerId(GetPlayerFromPed(hasDriver)))
                            Wait(1)
                            stateLocks = 1
                            SetVehicleDoorsLocked(enteringVeh, 0)
                            ClearPedTasksImmediately(ped)
                            TaskEnterVehicle(ped, enteringVeh, -1, -1, 1.0, 8)
                            SetRelationshipBetweenGroups(3, `player`, `player`)
                            SetTimeout(5000, function()
                                SetRelationshipBetweenGroups(1, `player`, `player`)
                            end)
                        else
                            SetVehicleDoorsLocked(enteringVeh, 1)
                            QBCore.Functions.Progressbar("steal_keys", "Taking keys from body...", 2500, false, false, {
                                disableMovement = false,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true
                            }, {}, {}, {}, function() -- Done
                                AttemptPoliceAlert("steal")
                                TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', QBCore.Functions.GetPlate(enteringVeh))
                            end, function()
                            end)
                        end
                    else
                        if IsDisabledControlPressed(0, 23) then -- Hold F with nightstick == fun
                            if not isPullingOut then -- lol
                                isPullingOut = true -- Prevents infinite timeouts!
                                SetTimeout(250, function() -- THREAD!
                                    if IsDisabledControlPressed(0, 23) then -- Hold F with nightstick == fun
                                        if CurrentJob == 'marshalls' or CurrentJob == 'lspd' or CurrentJob == 'sast' or CurrentJob == 'bcso' or CurrentJob == 'hc' or CurrentJob == 'pd_cid' then
                                            local retval, weapon = GetCurrentPedWeapon(ped, 1)
                                            if weapon == joaat('weapon_nightstick') then
                                                sleep = 250
                                                TriggerServerEvent('qb-vehiclekeys:server:pullOutOfCar', GetPlayerServerId(GetPlayerFromPed(hasDriver)))
                                                Wait(1)
                                                stateLocks = 1
                                                SetVehicleDoorsLocked(enteringVeh, 0)
                                                ClearPedTasksImmediately(ped)
                                                TaskEnterVehicle(ped, enteringVeh, -1, -1, 1.0, 8)
                                                SetRelationshipBetweenGroups(3, `player`, `player`)
                                                SetTimeout(5000, function()
                                                    SetRelationshipBetweenGroups(1, `player`, `player`)
                                                    isPullingOut = false
                                                end)
                                            end
                                        end
                                    else
                                        isPullingOut = false
                                    end
                                end)
                            end
                        end
                        if stateLocks then
                            SetVehicleDoorsLocked(enteringVeh, tonumber(stateLocks))
                        else
                            SetVehicleDoorsLocked(enteringVeh, 2)
                        end 
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if inVehicle and needsHotwire then
           sleep = 100
           SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), false, false, true)
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        if doAnim == true then
            if HasAnimDictLoaded('veh@break_in@0h@p_m_one@') then
                TaskPlayAnim(PlayerPedId(), 'veh@break_in@0h@p_m_one@', 'low_force_entry_ds', 1.0, -1.0, 1000, 49, 1, false, false, false)
                Wait(850)
            else
                RequestAnimDict('veh@break_in@0h@p_m_one@')
            end
        end
        Wait(0)
    end
end)

-----------------------
---- Client Events ----
-----------------------

RegisterNetEvent('QBCore:drivingVehicle', function(isDriving, currentVehicle)
    if inVehicle and isDriving then return end -- prevent duplicate loops
	inVehicle = isDriving
    needsHotwire = false
	if inVehicle then
        Wait(1500) -- Delay for key giving
        local plate = QBCore.Functions.GetPlate(currentVehicle)
        local hasKeys = HasKeys(plate)
        if not hasKeys and Config.ClassList[vehicleClass] == 'codebreaker' then
            needsHotwire = true
            SetVehicleEngineOn(currentVehicle, false, false, true)
        elseif not hasKeys then
            QBCore.Functions.Notify('You do not have keys to this car', 'inform')
            lib.addRadialItem({
                {
                  id = 'hotwire',
                  label = 'Hotwire Vehicle',
                  icon = 'bolt',
                  onSelect = function()
                    TriggerEvent('qb-vehiclekeys:client:Hotwire')
                  end
                }
            })
            needsHotwire = true
            SetVehicleEngineOn(currentVehicle, false, false, true)
        end
    else
        needsHotwire = false
        lib.removeRadialItem('hotwire')
    end
end)

RegisterNetEvent('QBCore:leftVehicle', function(currentVehicle)
    needsHotwire = false
    inVehicle = false
    lib.removeRadialItem('hotwire')
end)


RegisterNetEvent('vehiclekeys:client:SetOwner', function(plate)
    local VehPlate = plate
    if not VehPlate then
        Wait(250)
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
        VehPlate = QBCore.Functions.GetPlate(veh)
    end
    if VehPlate then
        TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', VehPlate)
        if IsPedInAnyVehicle(PlayerPedId()) and plate == VehPlate then
            SetVehicleHasBeenOwnedByPlayer(GetVehiclePedIsIn(PlayerPedId(), true))
            SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), true), true, false, true)
            needsHotwire = false
            lib.removeRadialItem('hotwire')
        end
    end
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced, slot)
    if busy == false then 
        busy = true
        LockpickDoor(isAdvanced, slot)
        SetTimeout(3500, function()
            busy = false
        end)
    else
        QBCore.Functions.Notify("You're doing that too fast, wait a bit!", "error")
    end
end)

RegisterNetEvent('qb-vehiclekeys:client:AddKeys', function(plate)
    KeysList[plate] = true
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped)
        local vehicleplate = QBCore.Functions.GetPlate(vehicle)

        if plate == vehicleplate then
            needsHotwire = false
            lib.removeRadialItem('hotwire')
            SetVehicleEngineOn(vehicle, false, false, false)
        end
    end
end)

RegisterNetEvent('qb-vehiclekeys:client:Hotwire', function()
    Hotwire()
end)

RegisterNetEvent('qb-vehiclekeys:client:RemoveKeys', function(plate)
    KeysList[plate] = nil
end)

RegisterNetEvent('qb-vehiclekeys:client:startCarjacking', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then
        QBCore.Functions.SetStateBag(GetVehiclePedIsIn(ped), 'stateLocks', 0)
        SetVehicleDoorsLocked(GetVehiclePedIsIn(ped), 0)
    end
end)

RegisterNetEvent('qb-vehiclekeys:client:ToggleEngine', function()
    local EngineOn = GetIsVehicleEngineRunning(GetVehiclePedIsIn(PlayerPedId()))
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    if HasKeys(QBCore.Functions.GetPlate(vehicle)) then
        needsHotwire = false
        lib.removeRadialItem('hotwire')
        if EngineOn then
            SetVehicleEngineOn(vehicle, false, false, true)
        else
            SetVehicleEngineOn(vehicle, true, false, true)
        end
    end
end)

RegisterNetEvent('qb-vehiclekeys:client:GiveKeys', function(id)
    local targetVehicle = GetVehicle()
    if targetVehicle then
        local targetPlate = QBCore.Functions.GetPlate(targetVehicle)
        if HasKeys(targetPlate) then
            if id then -- Give keys to specific ID
                GiveKeys(tonumber(id), targetPlate)
            else
                if IsPedSittingInVehicle(PlayerPedId(), targetVehicle) then -- Give keys to everyone in vehicle
                    local otherOccupants = GetOtherPlayersInVehicle(targetVehicle)
                    for p=1,#otherOccupants do
                        TriggerServerEvent('qb-vehiclekeys:server:GiveVehicleKeys', GetPlayerServerId(NetworkGetPlayerIndexFromPed(otherOccupants[p])), targetPlate)
                    end
                else -- Give keys to closest player
                    GiveKeys(GetPlayerServerId(QBCore.Functions.GetClosestPlayer()), targetPlate)
                end
            end
        else
            QBCore.Functions.Notify("You don't have keys to this vehicle.", 'error')
        end
    end
end)

--- LOAD SEQUENCES --
exports('HasKeys', HasKeys)

RegisterKeyMapping('togglelocks', 'Toggle Vehicle Locks', 'keyboard', 'L')
RegisterCommand('togglelocks', function()
    ToggleVehicleLocks(GetVehicle())
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    KeysList = {}
    CurrentJob = 'unemployed'
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    CurrentJob = JobInfo.name
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CurrentJob = QBCore.Functions.GetPlayerData().job.name
    GetKeys()
end)

AddEventHandler('onResourceStart', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        if LocalPlayer.state['isLoggedIn'] then
            GetKeys()
            CurrentJob = QBCore.Functions.GetPlayerData().job.name
        end
    end
end)