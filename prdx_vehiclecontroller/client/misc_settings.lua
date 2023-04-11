AddEventHandler('prdx_vehiclecontroller:client:AnchorBoat', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then -- if driver
        if IsThisModelABoat(GetEntityModel(vehicle)) then -- boat
            SetBoatFrozenWhenAnchored(vehicle, true)
            SetForcedBoatLocationWhenAnchored(vehicle, true)
            if IsBoatAnchoredAndFrozen(vehicle) then
                SetBoatAnchor(vehicle, false)
                if AnchorRope then
                    DeleteRope(AnchorRope)
                    RopeUnloadTextures()
                end
                QBCore.Functions.Notify('Boat anchor pulled')
            elseif not IsBoatAnchoredAndFrozen(vehicle) then
                SetBoatAnchor(vehicle, true)
                local VehicleCoords = GetEntityCoords(vehicle)
                local found, z = GetGroundZFor_3dCoord(VehicleCoords.x, VehicleCoords.y, VehicleCoords.z, false)
                local Depth = VehicleCoords.z - z
                local dimmensions = GetModelDimensions(GetEntityModel(vehicle))
                local VehicleOffset = GetOffsetFromEntityInWorldCoords(vehicle, -dimmensions.x/1.7, -dimmensions.y*0.7, -dimmensions.z/2.1)
                local FloorOffset = GetOffsetFromEntityInWorldCoords(vehicle, 10.0, 10.0, z)
                AnchorRope = AddRope(FloorOffset.x, FloorOffset.y, FloorOffset.z, 0.0, 5.0, 0.0, 500.0, 1, Depth+25, 0.0, 0, 0, false, true, 50000.0, false, 1)
                AttachRopeToEntity(AnchorRope, vehicle, VehicleOffset.x, VehicleOffset.y, VehicleOffset.z, 1)
                QBCore.Functions.Notify('Boat anchor thrown')
            end
        end
    end
end)