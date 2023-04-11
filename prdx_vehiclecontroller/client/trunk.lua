local inTrunk = false
local isKidnapped = false
local isKidnapping = false
local cam = nil
local disabledTrunk = {
    [`penetrator`] = "penetrator",
    [`vacca`] = "vacca",
    [`monroe`] = "monroe",
    [`turismor`] = "turismor",
    [`osiris`] = "osiris",
    [`comet`] = "comet",
    [`ardent`] = "ardent",
    [`jester`] = "jester",
    [`nero`] = "nero",
    [`nero2`] = "nero2",
    [`vagner`] = "vagner",
    [`infernus`] = "infernus",
    [`zentorno`] = "zentorno",
    [`comet2`] = "comet2",
    [`comet3`] = "comet3",
    [`comet4`] = "comet4",
    [`bullet`] = "bullet",
    [`adder`] = "adder",
}

-- Functions

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)

    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

local function TrunkCam(bool)
    local vehicle = GetEntityAttachedTo(PlayerPedId())
    local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.5, 0)
    local vehHeading = GetEntityHeading(vehicle)
    if bool then
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        if not DoesCamExist(cam) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamActive(cam, true)
            SetCamCoord(cam, drawPos.x, drawPos.y, drawPos.z + 2)
            SetCamRot(cam, -2.5, 0.0, vehHeading, 0.0)
            RenderScriptCams(true, false, 0, true, true)
        end
    else
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        cam = nil
    end
end

RegisterNetEvent('qb-trunk:client:GetIn',function()
    local ped = PlayerPedId()
    local closestVehicle = getNearestVeh()
    if closestVehicle ~= 0 then
        local vehClass = GetVehicleClass(closestVehicle)
        local plate = QBCore.Functions.GetPlate(closestVehicle)
        local model = GetEntityModel(closestVehicle)
        if not disabledTrunk[model] then
            local hasSomeone = Entity(closestVehicle).state.inTrunk
            if not hasSomeone then
                if GetVehicleDoorAngleRatio(closestVehicle, 5) > 0.9 then
                    RequestAnimDict("fin_ext_p1-7")
                    while not HasAnimDictLoaded("fin_ext_p1-7") do
                        Wait(0)
                    end
                    TaskPlayAnim(ped, "fin_ext_p1-7", "cs_devin_dual-7", 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
                    local dimensionMin, dimensionMax = GetModelDimensions(GetEntityModel(closestVehicle))
                    AttachEntityToEntity(ped, closestVehicle, 0, 0.0, (dimensionMin.y) + 0.75, 0.1, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
                    QBCore.Functions.SetStateBag(closestVehicle, 'inTrunk', true)
                    inTrunk = true
                    Wait(250)
                    SetVehicleDoorShut(closestVehicle, 5, false)
                    if isKidnapping then
                        TrunkCam(false) 
                    else
                        QBCore.Functions.Notify('You\'re in the trunk!', 'success', 4000)
                        TrunkCam(true)
                    end
                else
                    QBCore.Functions.Notify('The trunk is closed!', 'error', 2500)
                end
            else
                QBCore.Functions.Notify('Someone is already in the trunk!', 'error', 2500)
            end
        else
            QBCore.Functions.Notify('You can\'t get in this trunk!', 'error', 2500)
        end
    else
        QBCore.Functions.Notify('No vehicle found!', 'error', 2500)
    end
end)

-- Threads

CreateThread(function()
    while true do
        local sleep = 1000
        local vehicle = GetEntityAttachedTo(PlayerPedId())
        local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -5.5, 0)
        local vehHeading = GetEntityHeading(vehicle)
        if cam then
            sleep = 0
            SetCamRot(cam, -2.5, 0.0, vehHeading, 0.0)
            SetCamCoord(cam, drawPos.x, drawPos.y, drawPos.z + 2)
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if inTrunk then
            if not isKidnapped then
                local ped = PlayerPedId()
                local vehicle = GetEntityAttachedTo(ped)
                local drawPos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                local plate = QBCore.Functions.GetPlate(vehicle)
                if DoesEntityExist(vehicle) then
                    sleep = 0
                    DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.75, '[~g~E~w~] Get out of the trunk')
                    if IsControlJustPressed(0, 38) then
                        if GetVehicleDoorAngleRatio(vehicle, 5) > 0.9 then
                            local dimensionMin, dimensionMax = GetModelDimensions(GetEntityModel(vehicle))
					        local offsetCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, (dimensionMin.y) - 0.5, 0.25)
                            DetachEntity(ped, true, true)
                            SetEntityCoords(ped, offsetCoords.x, offsetCoords.y, offsetCoords.z)
                            ClearPedTasks(ped)
                            SetEntityVisible(ped, true)
                            SetEntityCollision(ped, true, true)
                            TrunkCam(false)
                            inTrunk = false
                            QBCore.Functions.SetStateBag(vehicle, 'inTrunk', false)
                        else
                            QBCore.Functions.Notify('The trunk is closed!', 'error', 2500)
                        end
                        sleep = 100
                    end
                    if GetVehicleDoorAngleRatio(vehicle, 5) > 0.9 then
                        sleep = 0
                        DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.5, '[~g~G~w~] Close the trunk')
                        SetEntityVisible(ped, true)
                        if IsControlJustPressed(0, 47) then
                            if not IsVehicleSeatFree(vehicle, -1) then
                                TriggerServerEvent('radialmenu:trunk:server:Door', false, plate, 5)
                            else
                                SetVehicleDoorShut(vehicle, 5, false)
                            end
                            sleep = 100
                        end
                    else
                        sleep = 0
                        DrawText3Ds(drawPos.x, drawPos.y, drawPos.z + 0.5, '[~g~G~w~] Open the trunk')
                        SetEntityVisible(ped, false)
                        if IsControlJustPressed(0, 47) then
                            if not IsVehicleSeatFree(vehicle, -1) then
                                TriggerServerEvent('radialmenu:trunk:server:Door', true, plate, 5)
                            else
                                SetVehicleDoorOpen(vehicle, 5, false, false)
                            end
                            sleep = 100
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)