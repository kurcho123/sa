local notfindtrailer = true
QBCore = exports['qb-core']:GetCoreObject()


function AttachVehicle()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    local havetobreak = false
    if veh ~= nil and veh ~= 0 then
        trailerfind = nil
        local belowFaxMachine = GetOffsetFromEntityInWorldCoords(veh, 1.0, 0.0, -1.0)
        local boatCoordsInWorldLol = GetEntityCoords(veh)
        havefindclass = false
        testnb = 0.0
        while notfindtrailer do
            GetVehicleInDirection(vector3(boatCoordsInWorldLol.x, boatCoordsInWorldLol.y, boatCoordsInWorldLol.z), vector3(belowFaxMachine.x, belowFaxMachine.y, belowFaxMachine.z - testnb))
            testnb = testnb + 0.1
            if not startdecompte then
                startdecompte = true
                SetTimeout(5000, function()
                    if trailerfind ~= 0 and trailerfind ~= nil then
                        startdecompte = false
                        QBCore.Functions.Notify(Config.Lang["TrailerNotFind"], "error")
                        havetobreak = true
                    end
                end)
            end
            if havetobreak then
                print('FAIL TO GET TRAILER')
                break
            end
            Wait(150)
        end
        if tonumber(trailerfind) ~= 0 and trailerfind ~= nil then
            for k, v in pairs(Config.VehicleCanTrail) do
                local attachHash = GetEntityModel(veh)
                local modelhash = GetEntityModel(trailerfind)
                if v.name == modelhash then
                    for x, w in pairs(v.class) do
                        if w == GetVehicleClass(veh) then
                            havefindclass = true
                        end
                    end
                    if havefindclass then
                        if Config.Presets[attachHash] then
                            AttachEntityToEntity(veh, trailerfind, 20, 0.0, Config.Presets[attachHash].ypos, Config.Presets[attachHash].zpos, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                            exports['qb-target']:AddTargetEntity(trailerfind, {
                                options = {
                                    {
                                        type = "client",
                                        event = "prdx_trailers:detachVehicle",
                                        icon = "fas fa-wrench",
                                        label = "Detach Vehicle",
                                        isTrailer = true,
                                    },
                                },
                                distance = 3.5
                            })
                            QBCore.Functions.SetStateBag(trailerfind, 'trailerNet', VehToNet(veh))
                            TaskLeaveVehicle(ped, veh, 0)
                        else
                            exports['qb-target']:AddTargetEntity(veh, {
                                options = {
                                    {
                                        type = "client",
                                        event = "prdx_trailers:detachVehicle",
                                        icon = "fas fa-wrench",
                                        label = "Detach Vehicle",
                                        isTrailer = false,
                                    },
                                },
                                distance = 1.5
                            })
                            local rotVeh = GetEntityRotation(veh, 2)
                            local rotTrailer = GetEntityRotation(trailerfind, 2)
                            local rotation = vec3(rotVeh.x - rotTrailer.x, rotVeh.y - rotTrailer.y, rotVeh.z - rotTrailer.z)
                            local boneIDX = GetEntityBoneIndexByName(trailerfind, 'chassis')
                            local offset = GetOffsetFromEntityGivenWorldCoords(trailerfind, GetEntityCoords(veh))
                            print(offset, rotation)
                            local matrix = GetEntityMatrix(veh)
                            AttachEntityToEntity(veh, trailerfind, boneIDX, offset.x, offset.y, offset.z, rotation.x, rotation.y, rotation.z, false, false, true, false, 2, true)
                            QBCore.Functions.Notify('Vehicle strapped down!', "success")
                        end
                    else
                        QBCore.Functions.Notify(Config.Lang["CantSetThisType"], "error")
                    end
                end
            end
            trailerfind = nil
            notfindtrailer = true
        else
            QBCore.Functions.Notify(Config.Lang["TrailerNotFind"], "error")
        end
    else
        QBCore.Functions.Notify(Config.Lang["NotInVehicle"], "error")
    end
end

function GetVehicleInDirection(cFrom, cTo)
    trailerfind = nil
    notfindtrailer = true
    local rayHandle = CastRayPointToPoint(cFrom.x, cFrom.y, cFrom.z, cTo.x, cTo.y, cTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    if vehicle == 0 then
        notfindtrailer = true
    else
        notfindtrailer = false
        trailerfind = vehicle
    end
end

function DetachVehicle(data)
    local vehicle
    if data then
        vehicle = data.entity
    else
        vehicle = GetVehiclePedIsIn(PlayerPedId())
    end
    if vehicle and DoesEntityExist(vehicle) then
        if data and data.isTrailer then
            local netid = Entity(vehicle).state.trailerNet
            if netid then
                local attachedVeh = NetToVeh(netid)
                if attachedVeh and DoesEntityExist(attachedVeh) then
                    DetachEntity(attachedVeh, true, true)
                    notfindtrailer = true
                    trailerfind = nil
                    QBCore.Functions.Notify('Vehicle unstrapped down!', "success")
                else
                    print('Couldnt find attached')
                end 
            else
                print('Couldnt find attached')
            end
            QBCore.Functions.SetStateBag(vehicle, 'trailerNet', nil)
        else
            DetachEntity(vehicle, true, true)
            notfindtrailer = true
            trailerfind = nil
        end
        exports['qb-target']:RemoveTargetEntity(vehicle)
    else
        QBCore.Functions.Notify(Config.Lang["NoVehicleSet"], "error")
    end
end

RegisterCommand(Config.DetachCommand, function()
    DetachVehicle()
end, false)

RegisterNetEvent('prdx_trailers:detachVehicle', function(data)
    DetachVehicle(data)
end)

RegisterCommand(Config.AttachCommand, function()
    AttachVehicle()
end, false)

RegisterNetEvent('prdx_trailers:attachVehicle', function(data)
    AttachVehicle()
end)

RegisterNetEvent('carhauler:reset', function(data)
    if not data.vehicle then return end
    if not NetworkHasControlOfEntity(data.vehicle) then
        QBCore.Functions.TakeControl(data.vehicle)
    end
    local coords = GetEntityCoords(data.vehicle)
    SetVehicleFixed(data.vehicle)
    SetTrailerLegsRaised(data.vehicle)
    Wait(2000)
    SetTrailerLegsLowered(data.vehicle)
end)

RegisterNetEvent('prdx_trailers:toggleVehicle', function(data)
    local vehicle
    if data and type(data) == "table" and data.entity then
        vehicle = data.entity
    else
        data = nil
        vehicle = GetVehiclePedIsIn(PlayerPedId())
    end
    print(vehicle)
    if vehicle and DoesEntityExist(vehicle) then
        if IsEntityAttached(vehicle) then
            print('DETACH')
            if data then
                DetachVehicle(data)
            else
                DetachVehicle()
            end            
        else
            print('ATTACH')
            AttachVehicle()
        end
    end
end)

RegisterNetEvent('carhauler:toggleVehicle', function(data)
    if not data.vehicle or not data.door then return end
    if not NetworkHasControlOfEntity(data.vehicle) then
        QBCore.Functions.TakeControl(data.vehicle)
    end
    if GetVehicleDoorAngleRatio(data.vehicle, data.door) > 0.1 then -- open already
        print('SHUT DOOR')
        SetVehicleDoorShut(data.vehicle, data.door, false)
        Wait(2500)
        SetVehicleDoorLatched(data.vehicle, data.door, true, false)
    else
        print('OPEN DOOR')
        SetVehicleDoorOpen(data.vehicle, data.door, false, false)
        Wait(5000)
        local angle = GetVehicleDoorAngleRatio(data.vehicle, data.door)
        SetVehicleDoorControl(data.vehicle, data.door, 5, angle)
    end
end)

RegisterNetEvent('carhauler:toggleExtra', function(data)
    if not data.vehicle or not data.extra then 
        print('ERROR')
        return 
    end
    if not NetworkHasControlOfEntity(data.vehicle) then
        QBCore.Functions.TakeControl(data.vehicle)
    end
    SetVehicleAutoRepairDisabled(data.vehicle, false)
    local isOn = IsVehicleExtraTurnedOn(data.vehicle, data.extra)
    if isOn then
        print('Turning off extra:', data.extra)
        SetVehicleExtra(data.vehicle, tonumber(data.extra), 1)
    else
        print('Turning on extra:', data.extra)
        SetVehicleExtra(data.vehicle, tonumber(data.extra), 0)
    end
    SetVehicleAutoRepairDisabled(data.vehicle, true)

end)



AddEventHandler("carhauler:openMenu", function(data)
    lib.registerContext({
        id = 'carhaulerMenu',
        title = 'Car Hauler - Vehicle Interactions',
        onExit = function() end,
        options = {
            {
                title = 'Lower Center Hyrdaulics',
                description = 'Toggle the central ramp',
                event = 'carhauler:toggleVehicle',
                args = {door = 4, vehicle = data.entity},
            },{
                title = 'Lower Rear Ramp',
                description = 'Toggle the rear ramp',
                event = 'carhauler:toggleVehicle',
                args = {door = 5, vehicle = data.entity},
            },{
                title = 'Carhauler reset',
                description = '',
                event = 'carhauler:reset',
                args = {vehicle = data.entity},
            },
            
        }
    })
    lib.showContext('carhaulerMenu')
end)

AddEventHandler("prdx_trailers:client:LowboyMenu", function(data)
	
    lib.registerContext({
        id = 'LowboyMenu',
        title = 'Lowboy Trailer - Vehicle Interactions',
        onExit = function() end,
        options = {
            {
                title = 'Toggle Oversize Load',
                description = '',
                event = 'carhauler:toggleExtra',
                args = {extra = 1, vehicle = data.entity},
            },{
                title = 'Toggle Goose Neck',
                description = '',
                event = 'carhauler:toggleExtra',
                args = {extra = 2, vehicle = data.entity},
            },{
                title = 'Reset Hauler',
                description = '',
                event = 'carhauler:reset',
                args = {vehicle = data.entity},
            },
            
        }
    })
    lib.showContext('LowboyMenu')
end)

exports['qb-target']:AddTargetModel('tr2', {
    options = {
        {
			type = "client",
            event = "carhauler:openMenu",
            icon = "fas fa-anchor",
            label = "Open Car Hauler Menu",
        },
		{
			type = "client",
			event = "target:client:openImpoundMenu",
			icon = "fas fa-car",
			label = "Impound Menu",
		},
    },
    distance = 2.5,
})

exports['qb-target']:AddTargetModel('tvtrailer', {
    options = {
        {
			type = "client",
            event = "prdx_trailers:client:LowboyMenu",
            icon = "fas fa-anchor",
            label = "Open Lowboy Menu",
        },
		{
			type = "client",
			event = "target:client:openImpoundMenu",
			icon = "fas fa-car",
			label = "Impound Menu",
		},
    },
    distance = 2.5,
})