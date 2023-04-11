QBCore = exports['qb-core']:GetCoreObject()
local pedInSameVehicleLast = false
local vehicle
local lastVehicle
local vehicleClass
local currentSeatSaved
local inVehicle
local fCollisionDamageMult = 0.0
local fDeformationDamageMult = 0.0
local fEngineDamageMult = 0.0
local fBrakeForce = 1.0
local isBrakingForward = false
local isBrakingReverse = false
local healthEngineLast = 1000.0
local healthEngineCurrent = 1000.0
local healthEngineNew = 1000.0
local healthEngineDelta = 0.0
local healthEngineDeltaScaled = 0.0
local healthBodyLast = 1000.0
local healthBodyCurrent = 1000.0
local healthBodyNew = 1000.0
local healthBodyDelta = 0.0
local healthBodyDeltaScaled = 0.0
local healthPetrolTankLast = 1000.0
local healthPetrolTankCurrent = 1000.0
local healthPetrolTankNew = 1000.0
local healthPetrolTankDelta = 0.0
local healthPetrolTankDeltaScaled = 0.0
local DisableCar = false
local DisableLoop = false
local PermsGroup
local curbrk = 0
-- Functions
local function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces>0 then
      local mult = 10^numDecimalPlaces
      return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

function IsBackEngine(vehModel)
    for _, model in pairs(Config.BackEngineVehicles) do
        if GetHashKey(model) == vehModel then
            return true
        end
    end
    return false
end

function PauseDamageLoop()
	DisableLoop = true
	SetTimeout(1000, function()
		local veh = GetVehiclePedIsIn(PlayerPedId())
		if veh and veh ~= 0 then
			healthBodyLast = GetVehicleBodyHealth(veh)
			healthEngineLast = GetVehicleEngineHealth(veh)
			healthPetrolTankLast = GetVehiclePetrolTankHealth(veh)
		end
		DisableLoop = false
	end)
end

local function RepairVehicle(vehicle, full, item)
	if (IsBackEngine(GetEntityModel(vehicle))) then
        SetVehicleDoorOpen(vehicle, 5, false, false)
    else
        SetVehicleDoorOpen(vehicle, 4, false, false)
    end
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic2"})
	QBCore.Functions.Progressbar("repair_vehicle", "Repairing vehicle..", math.random(15000, 20000), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
        PauseDamageLoop()
        QBCore.Functions.SetStateBag(vehicle, 'damageStalls', 0)
        Wait(250)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if full then
            SetVehicleFixed(vehicle)
        else
            SetVehicleEngineHealth(vehicle, 600.0)
            SetVehiclePetrolTankHealth(vehicle, 700.0)
            SetVehicleBodyHealth(vehicle, 600.0)
        end
        SetVehicleEngineOn(vehicle, true, false, false)
        TriggerServerEvent('prdx_vehiclecontroller:useRepairKit', item)
        QBCore.Functions.Notify("Vehicle repaired!")
	end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		QBCore.Functions.Notify("Failed!", "error")
		if (IsBackEngine(GetEntityModel(vehicle))) then
			SetVehicleDoorShut(vehicle, 5, false)
		else
			SetVehicleDoorShut(vehicle, 4, false)
		end
	end)
end

local function fscale(inputValue, originalMin, originalMax, newBegin, newEnd, curve)
	local OriginalRange = 0.0
	local NewRange = 0.0
	local zeroRefCurVal = 0.0
	local normalizedCurVal = 0.0
	local rangedValue = 0.0
	local invFlag = 0

	if (curve > 10.0) then curve = 10.0 end
	if (curve < -10.0) then curve = -10.0 end

	curve = (curve * -.1)
	curve = 10.0 ^ curve

	if (inputValue < originalMin) then
	  inputValue = originalMin
	end
	if inputValue > originalMax then
	  inputValue = originalMax
	end

	OriginalRange = originalMax - originalMin

	if (newEnd > newBegin) then
		NewRange = newEnd - newBegin
	else
	  NewRange = newBegin - newEnd
	  invFlag = 1
	end

	zeroRefCurVal = inputValue - originalMin
	normalizedCurVal  =  zeroRefCurVal / OriginalRange

	if (originalMin > originalMax ) then
	  return 0
	end

	if (invFlag == 0) then
		rangedValue =  ((normalizedCurVal ^ curve) * NewRange) + newBegin
	else
		rangedValue =  newBegin - ((normalizedCurVal ^ curve) * NewRange)
	end

	return rangedValue
end

function EnteredVehicleSetup(vehicle)
    SetTune(vehicle, Entity(vehicle).state.tunerData)
    for i=1, 15 do
        SetVehicleWeaponsDisabled(vehicle, i)
    end
    local BlackListed = false
    -- Check for blacklisted vehicle --
    if QBCore.Shared.BlacklistedVehs[GetEntityModel(vehicle)] then
        if not PermsGroup then
            QBCore.Functions.TriggerCallback('prdx_playercontroller:server:GetPermissions', function(UserGroup)
                PermsGroup = UserGroup
                if PermsGroup.staff.admin or PermsGroup.staff.headadmin or PermsGroup.staff.director then
                    --nada
                else
                    QBCore.Functions.DeleteEntity(vehicle)
                    QBCore.Functions.Notify('Blacklisted vehicle', 'error')
                    BlackListed = true
                end
            end)
        else
            if PermsGroup.staff.admin or PermsGroup.staff.headadmin or PermsGroup.staff.director then
                --nada
            else
                QBCore.Functions.DeleteEntity(vehicle)
                QBCore.Functions.Notify('Blacklisted vehicle', 'error')
                BlackListed = true
            end
        end
    end
    if BlackListed then return end
    -- Resync Damages --
    -- PREVENT DAMAGES ON ENTER --
    healthEngineLast = GetVehicleEngineHealth(vehicle)
    healthBodyLast = GetVehicleBodyHealth(vehicle)
    healthPetrolTankLast = GetVehiclePetrolTankHealth(vehicle)
        
    if healthBodyLast < Config.Failure.engineSafeGuard then
        healthBodyLast = Config.Failure.engineSafeGuard
        SetVehicleBodyHealth(vehicle, Config.Failure.engineSafeGuard)
    end

    if healthEngineLast < Config.Failure.engineSafeGuard then
        healthEngineLast = Config.Failure.engineSafeGuard
        SetVehicleEngineHealth(vehicle, Config.Failure.engineSafeGuard)
    end
    
    -- Set vehicle handling data
    fDeformationDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult')
    fBrakeForce = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
    local newFDeformationDamageMult = fDeformationDamageMult ^ Config.Failure.deformationExponent	-- Pull the handling file value closer to 1
    if Config.Failure.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fDeformationDamageMult', newFDeformationDamageMult * Config.Failure.deformationMultiplier) end  -- Multiply by our factor
    if Config.Failure.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fWeaponDamageMult', Config.Failure.weaponsDamageMultiplier/Config.Failure.damageFactorBody) end -- Set weaponsDamageMultiplier and compensate for damageFactorBody

    --Get the CollisionDamageMultiplier
    fCollisionDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult')
    --Modify it by pulling all number a towards 1.0
    local newFCollisionDamageMultiplier = fCollisionDamageMult ^ Config.Failure.collisionDamageExponent	-- Pull the handling file value closer to 1
    SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fCollisionDamageMult', newFCollisionDamageMultiplier)

    --Get the EngineDamageMultiplier
    fEngineDamageMult = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult')
    --Modify it by pulling all number a towards 1.0
    local newFEngineDamageMult = fEngineDamageMult ^ Config.Failure.engineDamageExponent	-- Pull the handling file value closer to 1
    SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fEngineDamageMult', newFEngineDamageMult)
    Wait(10)
    BrakesLoop(vehicle)
    CreateThread(function ()
        DamageLoop(vehicle)
    end)
end

-- Threads
function BrakesLoop(vehicle)
    local model = GetEntityModel(vehicle)
    local disableRoll = true
    if vehicle and vehicle ~= 0 then
        if IsThisModelABike(model) or model ~= `deluxo` then
            disableRoll = false
        end
        vehicleClass = GetVehicleClass(vehicle)
        local powerDecrease = Entity(vehicle).state.powerDecrease
        if vehicleClass == 8 or vehicleClass == 13 or vehicleClass == 14 or vehicleClass == 15 or vehicleClass == 16 then return end  
        CreateThread(function ()
            while inVehicle do
                Wait(0)
                local factor = 1.0
                if healthEngineNew < 700 then
                    factor = (healthEngineNew+200.0) / 1100
                end
                local accelerator = GetControlValue(2, 71)
                local brake = GetControlValue(2, 72)
                local speed = GetEntitySpeedVector(vehicle, true)['y']
                -- Change Braking force
                local brk = fBrakeForce

                if speed >= 1.0 then
                    -- Going forward
                    if accelerator > 127 then
                        -- Forward and accelerating
                        local acc = fscale(accelerator, 127.0, 254.0, 0.1, 1.0, 10.0-(Config.Failure.sundayDriverAcceleratorCurve*2.0))
                        factor = factor * acc
                    end
                    if brake > 127 then
                        -- Forward and braking
                        isBrakingForward = true
                        brk = fscale(brake, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(Config.Failure.sundayDriverBrakeCurve*2.0))
                    end
                elseif speed <= -1.0 then
                    -- Going reverse
                    if brake > 127 then
                        -- Reversing and accelerating (using the brake)
                        local rev = fscale(brake, 127.0, 254.0, 0.1, 1.0, 10.0-(Config.Failure.sundayDriverAcceleratorCurve*2.0))
                        factor = factor * rev
                    end
                    if accelerator > 127 then
                        -- Reversing and braking (Using the accelerator)
                        isBrakingReverse = true
                        brk = fscale(accelerator, 127.0, 254.0, 0.01, fBrakeForce, 10.0-(Config.Failure.sundayDriverBrakeCurve*2.0))
                    end
                else
                    -- Stopped or almost stopped or sliding sideways
                    local entitySpeed = GetEntitySpeed(vehicle)
                    if entitySpeed < 1 then
                        -- Not sliding sideways
                        if isBrakingForward == true then
                            --Stopped or going slightly forward while braking
                            DisableControlAction(2, 72, true) -- Disable Brake until user lets go of brake
                            SetVehicleForwardSpeed(vehicle, speed*0.98)
                            SetVehicleBrakeLights(vehicle, true)
                        end
                        if isBrakingReverse == true then
                            --Stopped or going slightly in reverse while braking
                            DisableControlAction(2, 71, true) -- Disable reverse Brake until user lets go of reverse brake (Accelerator)
                            SetVehicleForwardSpeed(vehicle, speed*0.98)
                            SetVehicleBrakeLights(vehicle, true)
                        end
                        if isBrakingForward == true and GetDisabledControlNormal(2, 72) == 0 then
                            -- We let go of the brake
                            isBrakingForward = false
                        end
                        if isBrakingReverse == true and GetDisabledControlNormal(2, 71) == 0 then
                            -- We let go of the reverse brake (Accelerator)
                            isBrakingReverse = false
                        end
                        if entitySpeed <= 0.05 then
                            SetVehicleBrakeLights(vehicle, true)
                        end
                    end
                end
                if brk > fBrakeForce - 0.02 then brk = fBrakeForce end -- Make sure we can brake max.

                if curbrk ~= brk then
                    curbrk = brk
                    SetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce', brk)  -- Set new Brake Force multiplier
                end                

                if tonumber(powerDecrease) then
                    factor = factor - (factor * (tonumber(powerDecrease) / 60)) 
                end

                if factor < 0.2 then factor = 0.2 end
                if not NitroEnabled then
                    SetVehicleEngineTorqueMultiplier(vehicle, factor)
                end
                if not disableRoll then
                    local roll = GetEntityRoll(vehicle)
                    if (roll > 75.0 or roll < -75.0) or (GetEntityHeightAboveGround(vehicle) >= 5.0) then
                        DisableControlAction(2,59,true) -- Disable left/right
                        DisableControlAction(2,60,true) -- Disable up/down
                    end 
                end
            end
        end)
    end
end

function EngineStall(vehicle)

end

function DamageLoop(vehicle)
    if vehicle and vehicle ~= 0 then
        vehicleClass = GetVehicleClass(vehicle)
        local model = GetEntityModel(vehicle)
        if model == `kawasaki` then vehicleClass = 8 end -- MOTO UNIT BYPASS
        while inVehicle do
            Wait(50)
            SetVehicleEngineCanDegrade(vehicle, true)
            local ent = Entity(vehicle)
            if DisableLoop then goto skip_loop end

            healthEngineCurrent = GetVehicleEngineHealth(vehicle)
            if healthEngineCurrent == 1000 then healthEngineLast = 1000.0 end
            healthEngineNew = healthEngineCurrent
            healthEngineDelta = healthEngineLast - healthEngineCurrent
            healthEngineDeltaScaled = healthEngineDelta * Config.Failure.damageFactorEngine * Config.Failure.classDamageMultiplier[vehicleClass]
            
            healthBodyCurrent = GetVehicleBodyHealth(vehicle)
            if healthBodyCurrent == 1000 then healthBodyLast = 1000.0 end
            healthBodyNew = healthBodyCurrent
            healthBodyDelta = healthBodyLast - healthBodyCurrent
            healthBodyDeltaScaled = healthBodyDelta * Config.Failure.damageFactorBody * Config.Failure.classDamageMultiplier[vehicleClass]
            
            healthPetrolTankCurrent = GetVehiclePetrolTankHealth(vehicle)
            if healthPetrolTankCurrent == 1000 then healthPetrolTankLast = 1000.0 end
            healthPetrolTankNew = healthPetrolTankCurrent
            healthPetrolTankDelta = healthPetrolTankLast-healthPetrolTankCurrent
            healthPetrolTankDeltaScaled = healthPetrolTankDelta * Config.Failure.damageFactorPetrolTank * Config.Failure.classDamageMultiplier[vehicleClass]
            if ent.state.isDisabled or (healthEngineCurrent and healthEngineCurrent <= Config.Failure.engineSafeGuard+5) then
                SetVehicleUndriveable(vehicle, true)
            else
                if not IsVehicleDriveable(vehicle) then
                    SetVehicleUndriveable(vehicle, false)
                end
            end
            -- Damage happened while in the car = can be multiplied
            -- Only do calculations if any damage is present on the car. Prevents weird behavior when fixing using trainer or other script
            if healthEngineCurrent ~= 1000.0 or healthBodyCurrent ~= 1000.0 or healthPetrolTankCurrent ~= 1000.0 then
                -- Combine the delta values (Get the largest of the three)
                local healthEngineCombinedDelta = math.max(healthEngineDeltaScaled, healthBodyDeltaScaled, healthPetrolTankDeltaScaled)
                if healthEngineCombinedDelta < 1.0 then
                    goto skip_loop
                end
                -- If complete damage, but not catastrophic (ie. explosion territory) pull back a bit, to give a couple of seconds og engine runtime before dying
                if healthEngineCurrent >= Config.Failure.cascadingFailureThreshold + 5 then
                    if not stall and healthEngineCombinedDelta > healthEngineCurrent then
                        healthEngineCombinedDelta = healthEngineCurrent - (Config.Failure.cascadingFailureThreshold / 5)
                        stall = true
                    end
    
                    if not stall and healthEngineCombinedDelta > 125.0 or healthEngineCombinedDelta > (healthEngineCurrent - Config.Failure.engineSafeGuard) then 
                        healthEngineCombinedDelta = (healthEngineCombinedDelta * (Config.Failure.classDamageMultiplier[vehicleClass]))
                        stall = true                  
                    end 
                end

                ------- Calculate new value
                healthEngineNew = healthEngineLast - healthEngineCombinedDelta



                ------- Sanity Check on new values and further manipulations

                -- If somewhat damaged, slowly degrade until slightly before cascading failure sets in, then stop

                if healthEngineNew > (Config.Failure.cascadingFailureThreshold + 5) and healthEngineNew < Config.Failure.degradingFailureThreshold then
                    healthEngineNew = healthEngineNew-(0.038 * Config.Failure.degradingHealthSpeedFactor)
                end

                -- If Damage is near catastrophic, cascade the failure
                if healthEngineNew < Config.Failure.cascadingFailureThreshold then
                    healthEngineNew = healthEngineNew- (0.1 * Config.Failure.cascadingFailureSpeedFactor)
                end

                -- Prevent Engine going to or below zero. Ensures you can reenter a damaged car.
                if healthEngineNew < Config.Failure.engineSafeGuard then
                    healthEngineNew = Config.Failure.engineSafeGuard
                end

                -- Prevent Explosions
                -- if Config.Failure.compatibilityMode == false and healthPetrolTankCurrent < 750 then
                -- 	healthPetrolTankNew = 750.0
                -- end

                -- Prevent negative body damage.
                if healthBodyNew < 0  then
                    healthBodyNew = 0.0
                end

                -- set the actual new values
                if healthEngineNew ~= healthEngineCurrent then
                    SetVehicleEngineHealth(vehicle, healthEngineNew)
                end
                
                if healthBodyNew ~= healthBodyCurrent then
                    SetVehicleBodyHealth(vehicle, healthBodyNew)
                end

                if stall then
                    stall = false
                    if Entity(vehicle).state.damageStalls then
                        QBCore.Functions.SetStateBag(vehicle, 'damageStalls', tonumber(Entity(vehicle).state.damageStalls) + 1)
                        if Entity(vehicle).state.damageStalls >= 3 then
                            healthEngineNew = Config.Failure.engineSafeGuard
                            SetVehicleEngineHealth(vehicle, Config.Failure.engineSafeGuard)
                        end
                    else
                        QBCore.Functions.SetStateBag(vehicle, 'damageStalls', 1) 
                    end
                    SetVehicleUndriveable(vehicle, true)
                    Wait(math.random(1750, 2250))
                    SetVehicleUndriveable(vehicle, false)
                end

            end
            ::skip_loop::
            -- Store current values, so we can calculate delta next time around
            healthEngineLast = healthEngineNew
            healthBodyLast = healthBodyNew
            healthPetrolTankLast = healthPetrolTankNew
            lastVehicle = vehicle
        end
    end
end

RegisterNetEvent('QBCore:drivingVehicle', function(isDriving, currentVehicle)
    if inVehicle and isDriving then return end -- prevent duplicate loops
	inVehicle = isDriving
    if inVehicle then
        Wait(500)
        EnteredVehicleSetup(currentVehicle)
    elseif currentVehicle and DoesEntityExist(currentVehicle) then
        if Config.Failure.deformationMultiplier ~= -1 then SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fDeformationDamageMult', fDeformationDamageMult) end -- Restore deformation multiplier
        SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fBrakeForce', fBrakeForce)  -- Restore Brake Force multiplier
        if Config.Failure.weaponsDamageMultiplier ~= -1 then SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fWeaponDamageMult', Config.Failure.weaponsDamageMultiplier) end	-- Since we are out of the vehicle, we should no longer compensate for bodyDamageFactor
        SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fCollisionDamageMult', fCollisionDamageMult) -- Restore the original CollisionDamageMultiplier
        SetVehicleHandlingFloat(currentVehicle, 'CHandlingData', 'fEngineDamageMult', fEngineDamageMult) -- Restore the original EngineDamageMultiplier
    end
end)


AddEventHandler('prdx_vehiclefailure:client:pushCar', function(data)
    local vehicle = data.entity
    local Pushing = true
    local inFront = false
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local vehpos = GetEntityCoords(vehicle)
    local dimensions = GetModelDimensions(GetEntityModel(vehicle), vector3(0.0, 0.0, 0.0), vector3(5.0, 5.0, 5.0))
    local roll = GetEntityRoll(vehicle)
    if (roll > 75.0 or roll < -75.0) then
        QBCore.Functions.Notify('Vehicle has rolled over!', 'error')
        return
    end
    QBCore.Functions.TakeControl(vehicle)
    if #(vehpos + GetEntityForwardVector(vehicle) - pos) > #(vehpos + GetEntityForwardVector(vehicle) * -1 - pos) then
        AttachEntityToEntity(ped, vehicle, GetPedBoneIndex(6286), 0.0, dimensions.y - 0.3, dimensions.z + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
        inFront = false
    else
        inFront = true
        AttachEntityToEntity(ped, vehicle, GetPedBoneIndex(6286), 0.0, dimensions.y * -1 + 0.1, dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false, false, true, false, true)
    end

    RequestAnimDict('missfinale_c2ig_11')
    while not HasAnimDictLoaded('missfinale_c2ig_11') do
        Wait(1)
    end
    TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
    
    Wait(200)
    QBCore.Functions.Notify('Press X to stop pushing')
    Pushing = true
    cancelAction = false
    while Pushing do
        Wait(5)
        if IsDisabledControlPressed(0, 34) then -- left
            TaskVehicleTempAction(ped, vehicle, 11, 1000)
        end

        if IsDisabledControlPressed(0, 9) then -- right
            TaskVehicleTempAction(ped, vehicle, 10, 1000)
        end
        if IsDisabledControlPressed(0, 32) then -- fron/back
            if inFront then
                SetVehicleForwardSpeed(vehicle, -1.0)
            else
                SetVehicleForwardSpeed(vehicle, 1.0)
            end
        end
        if cancelAction then
            DetachEntity(ped, false, false)
            StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
            FreezeEntityPosition(ped, false)
            Wait(1000)
            cancelAction = false
            Pushing = false
            break
        end
    end
end)

RegisterNetEvent('prdx_playercontroller:actionCancelled', function ()
	cancelAction = true
end)


RegisterNetEvent('prdx_vehiclecontroller:client:SyncWash', function(veh)
	SetVehicleDirtLevel(veh, 0.1)
	local ent = Entity(vehicle)
	if not ent.state.isDisabled then
		SetVehicleUndriveable(veh, false)
	end
	WashDecalsFromVehicle(veh, 1.0)
end)

RegisterNetEvent('prdx_vehiclecontroller:client:CleanVehicle', function()
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if vehicle ~= nil and vehicle ~= 0 then
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 3.0 and not IsPedInAnyVehicle(ped) then
            SetVehicleDirtLevel(vehicle, 0.0)
            RemoveDecalsFromVehicle(vehicle)
		end
	end
end)

RegisterNetEvent('prdx_vehiclecontroller:client:AdminRepair', function(onlyEngine)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
	if vehicle ~= nil and vehicle ~= 0 then
        PauseDamageLoop()
        Wait(500)
        if onlyEngine then
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehiclePetrolTankHealth(vehicle, 1000.0)
            SetVehicleBodyHealth(vehicle, 1000.0)
        else
            SetVehicleFixed(vehicle)
            SetVehicleDirtLevel(vehicle, 0.0)
        end
        SetVehicleEngineOn(vehicle, true, true, false)
        QBCore.Functions.SetStateBag(vehicle, 'damageStalls', 0)
        QBCore.Functions.Notify('Fixed', 'success')        
    else
        QBCore.Functions.Notify('No car', 'error')        
	end
end)

RegisterNetEvent('prdx_vehiclecontroller:client:RepairVehicle', function(full, item)
	local vehicle = QBCore.Functions.GetClosestVehicle()
	if vehicle ~= nil and vehicle ~= 0 then
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local vehpos = GetEntityCoords(vehicle)
		if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            if item.name == "repairkit" and GetVehicleClass(vehicle) == 8 then
                QBCore.Functions.Notify('This repair kit wont work on this vehicle!', 'error')        
                return
            elseif item.name == "bike_repairkit" and GetVehicleClass(vehicle) ~= 8 then
                QBCore.Functions.Notify('This repair kit wont work on this vehicle!', 'error')        
                return
            end
			local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
			if (IsBackEngine(GetEntityModel(vehicle))) then
				drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
			end
			if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
				RepairVehicle(vehicle, full, item)
			else
                QBCore.Functions.Notify('Not close enough', 'error')        
				ShowEnginePos = true
			end
        else
            QBCore.Functions.Notify('No vehicle close enough', 'error')        
		end
    else
        QBCore.Functions.Notify('No vehicle nearby', 'error')        
	end
end)


exports("PauseDamageLoop", PauseDamageLoop)

CreateThread(function()
	exports['qb-target']:RemoveGlobalVehicle({'Push Vehicle'})
	exports['qb-target']:AddGlobalVehicle({
	  options = { 
		{
		  type = "client",
		  event = "prdx_vehiclefailure:client:pushCar",
		  icon = 'fas fa-person-walking-arrow-right',
		  label = 'Push Vehicle',
		  canInteract = function(entity, distance, data) 
            local state = Entity(entity).state
            if GetVehicleEngineHealth(vehicle, false) <= 200.0 then return true end
            if state.isDisabled then return true end
            if state.hasEngine and state.hasEngine == false then return true end
            return false
		  end,
		}
	  },
	  distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
	})
end)
