QBCore = exports['qb-core']:GetCoreObject()
local MotionSensors = {}
local _internal_camera
local ActivelyViewing = false

local function RotationToDirection(rotation)
	local adjustedRotation = {
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction = {
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance, prop)
    -- Checks to see if the Gameplay Cam is Rendering or another is rendering (no clip functionality)
    local currentRenderingCam = false
    if not IsGameplayCamRendering() then
        currentRenderingCam = GetRenderingCam()
    end

    local cameraRotation = not currentRenderingCam and GetGameplayCamRot() or GetCamRot(currentRenderingCam, 2)
    local cameraCoord = not currentRenderingCam and GetGameplayCamCoord() or GetCamCoord(currentRenderingCam)
	local direction = RotationToDirection(cameraRotation)
	local destination =	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local _, b, c, _, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, prop, 4))
	return b, c, e
end


function IsSpyCamActive()
    return IsCamActive(_internal_camera) == 1
end

function EnableCam(coords, rot)
    exports.ox_target:disableTargeting(true)
    LocalPlayer.state.invBusy = true
    _internal_camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    local int = GetInteriorAtCoords(coords.x, coords.y, coords.z)
    if int > 0 then
        LoadInterior(int)
    end
    local direction = RotationToDirection(rot)
    SetFocusArea(coords)
    LockMinimapPosition(coords.x, coords.y)
    SetCamFov(_internal_camera, 90.0)
    SetCamCoord(_internal_camera, coords.x, coords.y, coords.z)
    SetCamRot(_internal_camera, rot.x, rot.y, (rot.z) % 360 - 180, 0)
    SetCamNearClip(_internal_camera, 0.0)
    LockMinimapAngle(math.floor(rot.z))
    SetPlayerControl(PlayerId(), false)
    RenderScriptCams(true, false, 0)
    SetTimecycleModifier("scanline_cam_cheap")
    SetTimecycleModifierStrength(1.0)
end

function DisableCam()
    exports.ox_target:disableTargeting(false)
    LocalPlayer.state.invBusy = false
    DestroyCam(_internal_camera)
    ClearFocus()
    UnlockMinimapPosition()
    UnlockMinimapAngle()
    SetPlayerControl(PlayerId(), true)
    RenderScriptCams(false, false, 0)    
    ClearTimecycleModifier("scanline_cam_cheap")
end

AddEventHandler('JakeFun:spycam:viewCamera', function(CameraID)
    QBCore.Functions.TriggerCallback("JakeFun:spy:getCamera", function(CameraData)
        if CameraData and not IsSpyCamActive() then
            DoScreenFadeOut(500)
            Wait(500)
            EnableCam(CameraData.coords, CameraData.rotation)
            DoScreenFadeIn(1000)
        else
            print(CameraData, IsSpyCamActive())
        end
    end, CameraID)
end)
    
AddEventHandler('JakeFun:spycam:pickupCamera', function(data)
    local skillcheck = lib.skillCheck({'easy', 'medium', 'hard', 'easy'})
    local netid = NetworkGetNetworkIdFromEntity(data.entity)
    TriggerServerEvent('JakeFun:spy:pickupCamera', netid, skillcheck)
    TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
end)

AddEventHandler('JakeFun:spycam:pickupSensor', function(data)
    local skillcheck = lib.skillCheck({'easy', 'medium', 'hard', 'easy'})
    local netid = NetworkGetNetworkIdFromEntity(data.entity)
    TriggerServerEvent('JakeFun:spy:pickupSensor', netid, skillcheck)
    TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
end)

RegisterNetEvent('JakeFun:spycam:myCameras', function()
    QBCore.Functions.TriggerCallback("JakeFun:spy:getMyCamearas", function(CameraData)
        local menu = {
            {
                title = "Available Cameras", 
                disabled = true
            }
        }
        if CameraData then
            for _,camData in ipairs(CameraData) do
                menu[#menu+1] = {
                    title = camData.label,
                    event = "JakeFun:spycam:viewCamera",
                    args = camData.id
                } 
            end            
        end
        lib.registerContext({
            id = 'cam_menu',
            title = 'SpyCam Systems',
            options = menu,
        })
        lib.showContext('bomb_menu')
        
    end)
end)

RegisterNetEvent('JakeFun:spycam:openCameras', function(CameraData)
    TriggerEvent('animations:client:EmoteCommandStart', {"sms3"})
    local menu = {
        {
            title = "Available Cameras", 
            disabled = true
        }
    }
    if CameraData then
        for _,camData in ipairs(CameraData) do
            menu[#menu+1] = {
                title = camData.label,
                event = "JakeFun:spycam:viewCamera",
                args = camData.id
            } 
        end            
    end
    lib.registerContext({
        id = 'cam_menu',
        title = 'SpyCam Systems',
        options = menu,
    })
    lib.showContext('cam_menu')
end)

RegisterNetEvent('JakeFun:spycam:createSpyDevice', function(deviceType)
    TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"})
    currentType = deviceType
    if deviceType == 'spycam' then
        model = joaat('prop_spycam')
        distance = 4.0
    elseif deviceType == 'motionsensor' then
        model = joaat('prop_cs_saucer_01')
        distance = 5.5
    end
    QBCore.Functions.Progressbar("place-Device", "Prepping Device", math.random(1500,3000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        }, {}, {}, {}, 
    function() -- Done
        local color = {r = 255, g = 255, b = 255, a = 200}
        local startCoords = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, -0.5, 1.0)
        local startHeading = GetEntityHeading(cache.ped) - 180.0
        local tempObj = CreateObject(model, startCoords.x, startCoords.y, startCoords.z, false, true) -- temp model for placement
        SetEntityAlpha(tempObj, 115)
        SetEntityCompletelyDisableCollision(tempObj, true, false)
        FreezeEntityPosition(tempObj, true)
        PlacingCam = true
        local finalCoords
        local finalRotation
        local camCoords
        local heading = startHeading
        exports.ox_target:disableTargeting(true)
        LocalPlayer.state.invBusy = true
        while PlacingCam do
            Wait(1)
            local incriment = 1
            local position = GetEntityCoords(cache.ped)
            local hit, coords, entity = RayCastGamePlayCamera(distance, tempObj)
            if coords == vec3(0.0, 0.0, 0.0) then
                SetEntityCoords(tempObj, startCoords.x, startCoords.y, startCoords.z - 20.0)
            else
                SetEntityCoords(tempObj, coords)
                PlaceObjectOnGroundProperly(tempObj)
                local entCoords = GetEntityCoords(tempObj)
                DrawLine(position.x, position.y, position.z, entCoords.x, entCoords.y, entCoords.z, color.r, color.g, color.b, color.a)
            end

            if IsDisabledControlPressed(0, 19) then
                incriment = 10
            end
            if IsDisabledControlJustPressed(0, 14) then
                heading = GetEntityHeading(tempObj) + incriment
            elseif IsDisabledControlJustPressed(0, 15) then
                heading = GetEntityHeading(tempObj) - incriment
            end
            SetEntityHeading(tempObj, heading)

            -- Place --
            if IsDisabledControlPressed(0, 38) then
                finalCoords = GetEntityCoords(tempObj)
                camCoords = GetOffsetFromEntityInWorldCoords(tempObj, 0.0, -0.05, 0.05)
                finalRotation = GetEntityRotation(tempObj)
                PlacingCam = false
            end
        end
        if finalCoords and finalRotation then
            if deviceType == 'spycam' then
                local input = lib.inputDialog('Setup Cam', {'Camera Label:'})
                TriggerServerEvent('JakeFun:spy:createCamera', finalCoords, finalRotation, camCoords, input?[1]) 
            elseif deviceType == 'motionsensor' then
                local input = lib.inputDialog('Setup Sensor', {'Sensor Label:'})
                TriggerServerEvent('JakeFun:spy:createSensor', finalCoords, finalRotation, input?[1])
            end
        else
            TriggerServerEvent('JakeFun:spy:cancelPlacement', deviceType)
        end
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        DeleteEntity(tempObj)
        PlacingCam = false
        exports.ox_target:disableTargeting(false)
        LocalPlayer.state.invBusy = false
    end, function() -- Cancel
        QBCore.Functions.Notify('Canceled', 'error')
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('prdx_playercontroller:actionCancelled', function()
    if IsSpyCamActive() then
       DisableCam() 
    end
    PlacingCam = false
end)

RegisterNetEvent('JakeFun:spy:sensorCreated', function(SensorData, citizenid, tableID)
    MotionSensors = SensorData
    local newSensor = MotionSensors[citizenid][tableID]
    exports['polyzonehelper']:AddBoxZone("MotionSensor", vector3(newSensor.coords.x, newSensor.coords.y, newSensor.coords.z), Config.MotionSensorRange, Config.MotionSensorRange, {
        name="MotionSensor",
        heading=newSensor.rotation.z,
        debugPoly = false,
        minZ= newSensor.coords.z - 0.5,
        maxZ= newSensor.coords.z + 2.0,
    })
end)

AddEventHandler('polyzonehelper:enter', function(name)
    if name == "MotionSensor" then
        TriggerServerEvent('JakeFun:spy:motionDetected', GetEntityCoords(cache.ped))
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback("JakeFun:spy:getAllSensors", function(data) 
        MotionSensors = data
        for owner, sensors in pairs(MotionSensors) do
            for id, sensorData in pairs(sensors) do
                exports['polyzonehelper']:AddBoxZone("MotionSensor", vector3(sensorData.coords.x, sensorData.coords.y, sensorData.coords.z), Config.MotionSensorRange, Config.MotionSensorRange, {
                    name="MotionSensor",
                    heading=sensorData.rotation.z,
                    debugPoly = false,
                    minZ= sensorData.coords.z - 0.5,
                    maxZ= sensorData.coords.z + 2.0,
                }) 
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    for owner, sensors in pairs(MotionSensors) do
        for id, sensorData in pairs(sensors) do
            exports['polyzonehelper']:DeletePolyZone("MotionSensor")
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for owner, sensors in pairs(MotionSensors) do
            for id, sensorData in pairs(sensors) do
                exports['polyzonehelper']:DeletePolyZone("MotionSensor")
            end
        end
    end
end)

CreateThread(function ()
    exports['qb-target']:AddTargetModel(joaat('prop_spycam'), {
        options = {
            {
                type = "client",
                event = "JakeFun:spycam:pickupCamera",
                icon = "fas fa-user-secret",
                label = "Pickup",
            },
        },
        distance = 2.0
    })

    exports['qb-target']:AddTargetModel(joaat('prop_cs_saucer_01'), {
        options = {
            {
                type = "client",
                event = "JakeFun:spycam:pickupSensor",
                icon = "fas fa-user-secret",
                label = "Pickup",
            },
        },
        distance = 2.0
    })
end)

