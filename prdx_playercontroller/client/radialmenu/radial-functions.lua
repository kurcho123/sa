local QBCore = exports['qb-core']:GetCoreObject()

-- Give contact info
RegisterNetEvent('radialmenu:client:GiveContact', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local PlayerId = GetPlayerServerId(player)
        TriggerEvent('animations:client:EmoteCommandStart', {"keyfob"})
        TriggerServerEvent('radialmenu:server:GiveContact', PlayerId)
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNetEvent('radialmenu:client:AddContact', function(data)
    exports.npwd:fillNewContact(
        { 
            name = data.name, 
            number = tostring(data.number)
        }
    )
    exports["npwd"]:createNotification({
        notisId = "npwd:ReceiveContact",
        appId = "CONTACTS",
        content = "New Contact Details Received",
        secondaryTitle = "Open to save...",
        keepOpen = false,
        duration = 5000,
        path = "/contacts",
    })
end)

-- Change vehicle seat
RegisterNetEvent('radialmenu:client:ChangeSeat', function(seat, label)
    local Veh = cache.vehicle
    local IsSeatFree = IsVehicleSeatFree(Veh, seat)
    local speed = GetEntitySpeed(Veh)
    local kmh = speed * 3.6
    if not IsSeatFree then
        QBCore.Functions.Notify("This seat is occupied", 'error')
        return
    end
    if kmh > 100.0 then
        QBCore.Functions.Notify("This vehicle is going too fast!", 'error')
        return
    end
    SetPedIntoVehicle(cache.ped, Veh, seat)
    QBCore.Functions.Notify("You switched to the " .. label, "success")
end)

-- Open vehicle door
RegisterNetEvent('radialmenu:client:openDoor', function(door)
    local ped = cache.ped
    local closestVehicle = cache.vehicle or getNearestVeh()
    if closestVehicle == 0 then
        QBCore.Functions.Notify("No vehicle found nearby", 'error')
        return
    end
    if not cache.vehicle then
        local plate = QBCore.Functions.GetPlate(closestVehicle)
        if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
            if not IsVehicleSeatFree(closestVehicle, -1) then
                TriggerServerEvent('radialmenu:trunk:server:Door', false, plate, door)
            else
                SetVehicleDoorShut(closestVehicle, door, false)
            end
        else
            if not IsVehicleSeatFree(closestVehicle, -1) then
                TriggerServerEvent('radialmenu:trunk:server:Door', true, plate, door)
            else
                SetVehicleDoorOpen(closestVehicle, door, false, false)
            end
        end
    else
        if GetVehicleDoorAngleRatio(closestVehicle, door) > 0.0 then
            SetVehicleDoorShut(closestVehicle, door, false)
        else
            SetVehicleDoorOpen(closestVehicle, door, false, false)
        end
    end
end)

RegisterNetEvent('radialmenu:trunk:client:Door', function(plate, door, open)
    local veh = cache.vehicle
    if veh ~= 0 then
        local pl = QBCore.Functions.GetPlate(veh)
        if pl == plate then
            if open then
                SetVehicleDoorOpen(veh, door, false, false)
            else
                SetVehicleDoorShut(veh, door, false)
            end
        end
    end
end)

-- Set vehicle extra
RegisterNetEvent('radialmenu:client:setExtra', function(extra)
    local ped = cache.ped
    local veh = cache.vehicle
    if not veh then return end
    if GetPedInVehicleSeat(veh, -1) ~= ped then
        QBCore.Functions.Notify('You\'re not the driver of the vehicle!', 'error', 2500)
        return
    end
    if not DoesExtraExist(veh, extra) then
        QBCore.Functions.Notify('Extra ' .. extra .. ' is not present on this vehicle!', 'error', 2500)
        return
    end
    if IsVehicleExtraTurnedOn(veh, extra) then
        SetVehicleExtra(veh, extra, 1)
        QBCore.Functions.Notify('Extra ' .. extra .. ' has been deactivated!', 'error', 2500)
    else
        SetVehicleExtra(veh, extra, 0)
        QBCore.Functions.Notify('Extra ' .. extra .. ' has been activated!', 'success', 2500)
    end
end)