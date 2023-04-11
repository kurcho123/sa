local seatbeltOn = false
local harnessOn = false
local harnessHp = 20
local handbrake = 0
local sleep = 0
local harnessData = {}
local SpeedBuffer = {}
local vehVelocity = {x = 0.0, y = 0.0, z = 0.0}
local newvehicleBodyHealth = 0
local newvehicleEngineHealth = 0
local currentvehicleEngineHealth = 0
local currentvehicleBodyHealth = 0
local frameBodyChange = 0
local frameEngineChange = 0
local lastFrameVehiclespeed = 0
local lastFrameVehiclespeed2 = 0
local thisFrameVehicleSpeed = 0
local tick = 0
local damagedone = false
local modifierDensity = true

-- Register Key

RegisterCommand('toggleseatbelt', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local class = GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId()))
        if class ~= 8 and class ~= 13 and class ~= 14 and not harnessOn then
            ToggleSeatbelt()
        end
    end
end, false)

RegisterKeyMapping('toggleseatbelt', 'Toggle Seatbelt', 'keyboard', 'B')

-- Events

RegisterNetEvent('seatbelt:client:UseHarness', function() -- On Item Use (registered server side)
    local ped = PlayerPedId()
    local inveh = IsPedInAnyVehicle(ped, false)
    local class = GetVehicleClass(GetVehiclePedIsUsing(ped))
    if inveh and class ~= 8 and class ~= 13 and class ~= 14 then
        if not harnessOn then
            LocalPlayer.state:set("inv_busy", true, true)
            QBCore.Functions.Progressbar("harness_equip", "Attaching Race Harness", 2500, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                LocalPlayer.state:set("inv_busy", false, true)
                ToggleHarness()
            end)
        else
            LocalPlayer.state:set("inv_busy", true, true)
            QBCore.Functions.Progressbar("harness_equip", "Removing Race Harness", 2500, false, true, {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                LocalPlayer.state:set("inv_busy", false, true)
                ToggleHarness()
            end)
        end
    else
        QBCore.Functions.Notify('You\'re not in a car.', 'error')
    end
end)

-- Functions

function ToggleSeatbelt()
    if seatbeltOn then
        seatbeltOn = false
        TriggerEvent("seatbelt:client:ToggleSeatbelt", false)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "carunbuckle", 0.25)
    else
        seatbeltOn = true
        TriggerEvent("seatbelt:client:ToggleSeatbelt", true)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "carbuckle", 0.25)
    end
end

function ToggleHarness()
    if harnessOn then
        harnessOn = false
        seatbeltOn = false 
        TriggerEvent("seatbelt:client:ToggleHarness", false)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "carunbuckle", 0.25)
    else
        harnessOn = true
        seatbeltOn = true
        TriggerEvent("seatbelt:client:ToggleHarness", true)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "carbuckle", 0.25)
    end
end

function ResetHandBrake()
    if handbrake > 0 then
        handbrake = handbrake - 1
    end
end

-- Export

function HasHarness()
    return harnessOn
end

-- Main Thread
--[[ Returns an int
Vehicle Classes:
0: Compacts
1: Sedans
2: SUVs
3: Coupes
4: Muscle
5: Sports Classics
6: Sports
7: Super
8: Motorcycles
9: Off-road
10: Industrial
11: Utility
12: Vans
13: Cycles
14: Boats
15: Helicopters
16: Planes
17: Service
18: Emergency
19: Military
20: Commercial
21: Trains
22: Open Wheel char buffer[128]; ]]

RegisterNetEvent('QBCore:enteredVehicle', function (currentVehicle, currentSeat)
	if inVehicle then return end -- prevent duplicate loops
	inVehicle = true
    local class = GetVehicleClass(currentVehicle)
    local model = GetEntityModel(currentVehicle)
    while inVehicle do
        if harnessOn then
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
            if IsDisabledControlJustPressed(0, 75) then
                QBCore.Functions.Notify('You have a harness on!')
            end
        end
        if class ~= 8 and class ~= 13 and class ~= 14 and class ~= 15 and class ~= 16 and IsEntityInAir(currentVehicle) and model ~= `deluxo` and model ~= `kawasaki` then
            DisableControlAction(0, 59) -- leaning left/right
            DisableControlAction(0, 60) -- leaning up/down
            DisableControlAction(2, 59, true) -- Disable left/right
            DisableControlAction(2, 60, true) -- Disable up/down
        end
        Wait(0)
    end
    seatbeltOn = false
    harnessOn = false
end)

RegisterNetEvent('QBCore:leftVehicle', function ()
	inVehicle = false
end)

-- Ejection Logic

-- Ejection Logic

CreateThread(function()
    while true do
        Wait(5)
        local playerPed = PlayerPedId()
        local currentVehicle = GetVehiclePedIsIn(playerPed, false)
        if currentVehicle ~= nil and currentVehicle ~= false and currentVehicle ~= 0 then
            SetPedHelmet(playerPed, false)
            lastVehicle = GetVehiclePedIsIn(playerPed, false)
            thisFrameVehicleSpeed = GetEntitySpeed(currentVehicle) * 2.236936
            currentvehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
            if currentvehicleBodyHealth == 1000 and frameBodyChange ~= 0 then
                frameBodyChange = 0
            end
            if frameBodyChange ~= 0 then
                if lastFrameVehiclespeed > 110 and thisFrameVehicleSpeed < (lastFrameVehiclespeed * 0.75) and not damagedone then
                    local Chance = math.random(math.ceil(lastFrameVehiclespeed))
                    Chance = math.random(0, 100)
                    if frameBodyChange > 88.0 then
                        if not seatbeltOn and not IsThisModelABike(currentVehicle) then
                            if Chance <= 75 then
                                if not harnessOn then
                                    EjectFromVehicle()
                                end
                            end
                        elseif seatbeltOn and not IsThisModelABike(currentVehicle) then
                            if lastFrameVehiclespeed > 95 then
                                if Chance <= 25 then
                                    if not harnessOn then
                                        EjectFromVehicle()
                                    end
                                end
                            end
                        end
                    end
                    damagedone = true
                end
                if currentvehicleBodyHealth < 350.0 and not damagedone then
                    damagedone = true
                    Wait(1000)
                end
            end
            if lastFrameVehiclespeed < 70 then
                Wait(100)
                tick = 0
            end
            frameBodyChange = newvehicleBodyHealth - currentvehicleBodyHealth
            if tick > 0 then
                tick = tick - 1
                if tick == 1 then
                    lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 2.236936
                end
            else
                if damagedone then
                    damagedone = false
                    frameBodyChange = 0
                    lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 2.236936
                end
                lastFrameVehiclespeed2 = GetEntitySpeed(currentVehicle) * 2.236936
                if lastFrameVehiclespeed2 > lastFrameVehiclespeed then
                    lastFrameVehiclespeed = GetEntitySpeed(currentVehicle) * 2.236936
                end
                if lastFrameVehiclespeed2 < lastFrameVehiclespeed then
                    tick = 25
                end

            end
            if tick < 0 then
                tick = 0
            end
            newvehicleBodyHealth = GetVehicleBodyHealth(currentVehicle)
            if not modifierDensity then
                modifierDensity = true
            end
            veloc = GetEntityVelocity(currentVehicle)
        else
            if lastVehicle ~= nil then
                SetPedHelmet(playerPed, true)
                Wait(200)
                newvehicleBodyHealth = GetVehicleBodyHealth(lastVehicle)
                if not damagedone and newvehicleBodyHealth < currentvehicleBodyHealth then
                    damagedone = true
                    Wait(1000)
                end
                lastVehicle = nil
            end
            lastFrameVehiclespeed2 = 0
            lastFrameVehiclespeed = 0
            newvehicleBodyHealth = 0
            currentvehicleBodyHealth = 0
            frameBodyChange = 0
            Wait(2000)
        end
    end
end)

function GetFwd(entity)
    local hr = GetEntityHeading(entity) + 90.0
    if hr < 0.0 then hr = 360.0 + hr end
    hr = hr * 0.0174533
    return { x = math.cos(hr) * 5.73, y = math.sin(hr) * 5.73 }
end

function EjectFromVehicle()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped,false)
    local coords = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, 1.0)
    SetEntityCoords(ped,coords)
    Wait(1)
    SetPedToRagdoll(ped, 5511, 5511, 0, 0, 0, 0)
    SetEntityVelocity(ped, veloc.x*2,veloc.y*2,veloc.z*2)
    local ejectspeed = math.ceil(GetEntitySpeed(ped) * 8)
    if(GetEntityHealth(ped) - ejectspeed) > 0 then
        SetEntityHealth(ped, (GetEntityHealth(ped) - ejectspeed) )
    elseif GetEntityHealth(ped) ~= 0 then
        SetEntityHealth(ped, 0)
    end
end
