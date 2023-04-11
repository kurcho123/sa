QBCore.Functions = {}
QBCore.RequestId = 0


-- Voice Storage --
local hiddenSpeaker = -1
local lineInProgress = false

CreateThread(function()
    DecorRegister('PLAYER_VEHICLE', 2)
end)

-- Player

function QBCore.Functions.GetPlayerData(cb)
    if not cb then return QBCore.PlayerData end
    cb(QBCore.PlayerData)
end

function QBCore.Functions.GetCoords(entity)
    local coords = GetEntityCoords(entity)
    return vector4(coords.x, coords.y, coords.z, GetEntityHeading(entity))
end

function QBCore.Functions.HasItem(items, amount)
    local amount = amount or 1
    if type(items) == "table" then
        local inventory = exports.ox_inventory:Search('count', items)
        if inventory then
            for name, count in pairs(inventory) do
                if count <= 0 then return false end
            end
            return true
        end
    elseif type(items) == "string" then
        return exports.ox_inventory:Search('count', items) >= amount
    end
end

-- Utility

function QBCore.Functions.DrawText(x, y, width, height, scale, r, g, b, a, text)
    -- Use local function instead
    SetTextFont(4)
    SetTextProportional(false)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow()
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x - width / 2, y - height / 2 + 0.005)
end

function QBCore.Functions.DrawText3D(x, y, z, text)
    -- Use local function instead
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(true)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function QBCore.Functions.TakeControl(entity)
    local timeout = 0
    if not DoesEntityExist(entity) then return end
    NetworkRequestControlOfEntity(entity)
    while not NetworkHasControlOfEntity(entity) do
        Wait(10)
        NetworkRequestControlOfEntity(entity)
        timeout = timeout + 1
        if timeout > 150 then
            return false
        end
    end
    if timeout < 150 then
        return true
    else
        return false
    end
end

-- Streaming
function QBCore.Functions.RequestModel(model)
    if HasModelLoaded(model) or not IsModelInCdimage(model) then return end
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end


function QBCore.Functions.RequestStreamedTextureDict(textureDict)
	if HasStreamedTextureDictLoaded(textureDict) then return end
	RequestStreamedTextureDict(textureDict)
	while not HasStreamedTextureDictLoaded(textureDict) do
		Wait(0)
	end
end

function QBCore.Functions.RequestNamedPtfxAsset(assetName)
	if HasNamedPtfxAssetLoaded(assetName) then return end
	RequestNamedPtfxAsset(assetName)
	while not HasNamedPtfxAssetLoaded(assetName) do
		Wait(0)
	end
end

function QBCore.Functions.RequestAnimSet(animSet)
	if HasAnimSetLoaded(animSet) then return end
	RequestAnimSet(animSet)
	while not HasAnimSetLoaded(animSet) do
		Wait(0)
	end
end

QBCore.Functions.RequestAnimDict = lib.requestAnimDict

function QBCore.Functions.PlayAnim(animDict, animName, upperbodyOnly, duration)
    local flags = upperbodyOnly and 16 or 0
    local runTime = duration or -1
    QBCore.Functions.RequestAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 1.0, runTime, flags, 0.0, false, false, true)
    RemoveAnimDict(animDict)
end

QBCore.Functions.LoadModel = lib.requestModel

QBCore.Functions.LoadAnimSet = lib.requestAnimSet

function QBCore.Functions.RequestWeaponAsset(weaponHash)
	if HasWeaponAssetLoaded(weaponHash) then return end
	RequestWeaponAsset(weaponHash)
	while not HasWeaponAssetLoaded(weaponHash) do
		Wait(0)
	end
end

function QBCore.Functions.CreateBlip(coords, sprite, display, scale, colour, shortRange, title)
    if not coords or not sprite or not display or not scale or not colour or shortRange == nil or not title then 
        print("Blip failed to create, most likely missed a setting, debug log: ")
        print("Coords: " .. coords .. " Sprite: " .. sprite .. " Display: " .. display .. " scale: " .. scale .. " shortRange: " .. shortRange .. " Title: " .. title .. " if you're attempting to use a blip without a title, use an empty string.")
        return
    end
    
    coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, display)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, shortRange)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(title)
    EndTextCommandSetBlipName(blip)
end

RegisterNUICallback('getNotifyConfig', function(_, cb)
    cb(QBCore.Config.Notify)
end)

function QBCore.Functions.Notify(text, texttype, length)
    texttype = texttype or 'inform'
    if texttype == 'primary' or texttype == 'info' then 
        texttype = 'inform' 
    elseif texttype == 'warning' or texttype == 'warn' then
        texttype = 'error'
    end
    length = length or 5000
    if type(text) == "table" then
        local ttext = text.text or 'Placeholder'
        local caption = text.caption or 'Placeholder'
        lib.notify({
            title = ttext,
            description = caption,
            duration = length,
            type = texttype,
            position = 'top-right',
        })
    else
        lib.notify({
            description = text,
            duration = length,
            type = texttype,
            position = 'top-right',
        })
    end
end

function QBCore.Debug(resource, obj, depth)
    TriggerServerEvent('QBCore:DebugSomething', resource, obj, depth)
end

-- Callback Functions --

-- Client Callback
function QBCore.Functions.CreateClientCallback(name, cb)
    QBCore.ClientCallbacks[name] = cb
end

function QBCore.Functions.TriggerClientCallback(name, cb, ...)
    if not QBCore.ClientCallbacks[name] then return end
    QBCore.ClientCallbacks[name](cb, ...)
end

-- Server Callback
function QBCore.Functions.TriggerCallback(name, cb, ...)
    QBCore.ServerCallbacks[name] = cb
    TriggerServerEvent('QBCore:Server:TriggerCallback', name, ...)
end

function QBCore.Functions.Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish, onCancel)
    if GetResourceState('ox_lib') ~= 'started' then error('ox_lib needs to be started in order for QBCore.Functions.Progressbar to work') end
    -- exports.progressbar:Progress({
    --     name = name:lower(),
    --     duration = duration*1000,
    --     label = label,
    --     useWhileDead = useWhileDead,
    --     canCancel = canCancel,
    --     controlDisables = disableControls,
    --     animation = animation,
    --     prop = prop,
    --     propTwo = propTwo,
    -- }, function(cancelled)
    --     if not cancelled then
    --         if onFinish then
    --             onFinish()
    --         end
    --     else
    --         if onCancel then
    --             onCancel()
    --         end
    --     end
    -- end)

    if lib.progressBar({
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        disable = {
            move = disableControls.disableMovement,
            car = disableControls.disableCarMovement,
            combat = disableControls.disableCombat,
            mouse = disableControls.disableMouse
        },
        anim = {
            dict = animation.animDict,
            clip = animation.anim,
            flag = animation.flags
        },
        prop = {
            model = prop.model,
            bone = prop.bone,
            pos = prop.coords and vector3(prop.coords.x, prop.coords.y, prop.coords.z),
            rot = prop.rotation and vector3(prop.rotation.x, prop.rotation.y, prop.rotation.z)
        },
    }) then 
        if onFinish then 
            onFinish() 
        end
    else 
        if onCancel then 
            onCancel() 
        end
    end
end

-- Getters

local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end

        enum.destructor = nil
        enum.handle = nil
    end
}

function QBCore.Functions.EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(
        function()
            local iter, id = initFunc()
            if not id or id == 0 then
                disposeFunc(iter)
                return
            end

            local enum = {
                handle = iter,
                destructor = disposeFunc
            }
            setmetatable(enum, entityEnumerator)
            local next = true

            repeat
                coroutine.yield(id)
                next, id = moveFunc(iter)
            until not next

            enum.destructor, enum.handle = nil, nil
            disposeFunc(iter)
        end
    )
end

function QBCore.Functions.EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
    local nearbyEntities = {}

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end

    for k, entity in pairs(entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if distance <= maxDistance then
            nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
        end
    end

    return nearbyEntities
end

function QBCore.Functions.EnumerateVehicles()
    return QBCore.Functions.EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function QBCore.Functions.GetVehiclesInArea(coords, maxDistance)
    return QBCore.Functions.EnumerateEntitiesWithinDistance(QBCore.Functions.GetVehicles(), false, coords, maxDistance)
end

function QBCore.Functions.IsSpawnPointClear(coords, maxDistance)
    return #QBCore.Functions.GetVehiclesInArea(coords, maxDistance) == 0
end

function QBCore.Functions.GetVehicles()
    return GetGamePool('CVehicle')
end

function QBCore.Functions.GetObjects()
    return GetGamePool('CObject')
end

function QBCore.Functions.GetPlayers()
    return GetActivePlayers()
end

function QBCore.Functions.GetPeds(ignoreList)
    local pedPool = GetGamePool('CPed')
    local peds = {}
	local ignoreList = ignoreList or {}
    for i = 1, #pedPool, 1 do
        local found = false
        for j = 1, #ignoreList, 1 do
            if ignoreList[j] == pedPool[i] then
                found = true
            end
        end
        if not found then
            peds[#peds + 1] = pedPool[i]
        end
    end
    return peds
end

function QBCore.Functions.GetClosestPed(coords, ignoreList)
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local ignoreList = ignoreList or {}
    local peds = QBCore.Functions.GetPeds(ignoreList)
    local closestDistance = -1
    local closestPed = -1
    for i = 1, #peds, 1 do
        local pedCoords = GetEntityCoords(peds[i])
        local distance = #(pedCoords - coords)

        if closestDistance == -1 or closestDistance > distance then
            closestPed = peds[i]
            closestDistance = distance
        end
    end
    return closestPed, closestDistance
end

function QBCore.Functions.IsWearingGloves()
    local ped = PlayerPedId()
    local armIndex = GetPedDrawableVariation(ped, 3)
    local model = GetEntityModel(ped)
    if model == `mp_m_freemode_01` then
        if QBCore.Shared.MaleNoGloves[armIndex] then
            return false
        end
    else
        if QBCore.Shared.FemaleNoGloves[armIndex] then
            return false
        end
    end
    return true
end

function QBCore.Functions.GetClosestPlayer(coords)
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local playerId, playerPed, playerCoords = lib.getClosestPlayer(coords, 50, false)
    local closestDistance = #(playerCoords - coords)

    return playerId, closestDistance
end

function QBCore.Functions.GetPlayersFromCoords(coords, distance)
    local players = GetActivePlayers()
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    distance = distance or 5
    local closePlayers = {}
    for _, player in pairs(players) do
        local target = GetPlayerPed(player)
        local targetCoords = GetEntityCoords(target)
        local targetdistance = #(targetCoords - coords)
        if targetdistance <= distance then
            closePlayers[#closePlayers + 1] = player
        end
    end
    return closePlayers
end

function QBCore.Functions.GetClosestVehicle(coords)
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(cache.ped)
    end
    local vehicle, vehicleCoords = lib.getClosestVehicle(coords, 50, true)
    local closestDistance = #(vehicleCoords - coords)
    return vehicle, closestDistance
end

function QBCore.Functions.GetClosestObject(coords)
    local ped = PlayerPedId()
    local objects = GetGamePool('CObject')
    local closestDistance = -1
    local closestObject = -1
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    for i = 1, #objects, 1 do
        local objectCoords = GetEntityCoords(objects[i])
        local distance = #(objectCoords - coords)
        if closestDistance == -1 or closestDistance > distance then
            closestObject = objects[i]
            closestDistance = distance
        end
    end
    return closestObject, closestDistance
end

function QBCore.Functions.GetClosestBone(entity, list)
    ---@type vector3, table?, vector3?, number?
    local playerCoords, bone, coords, distance = GetEntityCoords(PlayerPedId())
    for _, element in pairs(list) do
        local boneCoords = GetWorldPositionOfEntityBone(entity, element.id or element)
        local boneDistance = #(playerCoords - boneCoords)
        if not coords then
            bone, coords, distance = element, boneCoords, boneDistance
        elseif distance > boneDistance then
            bone, coords, distance = element, boneCoords, boneDistance
        end
    end
    if not bone then
        bone = {id = GetEntityBoneIndexByName(entity, "bodyshell"), type = "remains", name = "bodyshell"}
        coords = GetWorldPositionOfEntityBone(entity, bone.id)
        distance = #(coords - playerCoords)
    end
    return bone, coords, distance
end

function QBCore.Functions.GetBoneDistance(entity, boneType, boneIndex)
    local bone
    if boneType == 1 then
        bone = GetPedBoneIndex(entity, boneIndex)
    else
        bone = GetEntityBoneIndexByName(entity, boneIndex)
    end
    local boneCoords = GetWorldPositionOfEntityBone(entity, bone)
    local playerCoords = GetEntityCoords(PlayerPedId())
    return #(boneCoords - playerCoords)
end

function QBCore.Functions.AttachProp(ped, model, boneId, x, y, z, xR, yR, zR, vertex)
    local modelHash = type(model) == 'string' and joaat(model) or model
    local bone = GetPedBoneIndex(ped, boneId)
    QBCore.Functions.LoadModel(modelHash)
    local prop = CreateObject(modelHash, 1.0, 1.0, 1.0, true, true, false)
    AttachEntityToEntity(prop, ped, bone, x, y, z, xR, yR, zR, true, true, false, true, not vertex and 2 or 0, true)
    SetModelAsNoLongerNeeded(modelHash)
    return prop
end

function QBCore.Functions.SpawnObject(recmodel, cb, coords, isnetworked)
    local model = type(recmodel) == "number" and recmodel or joaat(recmodel)
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local isnetworked = isnetworked or true
    if not IsModelInCdimage(model) then
        return
    end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, isnetworked, true, false)
    local netid = NetworkGetNetworkIdFromEntity(obj)
    SetModelAsNoLongerNeeded(model)
    if cb then
        cb(obj)
    end
end

function QBCore.Functions.SpawnPed(recmodel, cb, coords, isnetworked)
    local model = type(recmodel) == "number" and recmodel or joaat(recmodel)
    local ped = PlayerPedId()
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local isnetworked = isnetworked or true
    if not IsModelInCdimage(model) then
        return
    end
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    local ped = CreatePed(4, model, coords.x, coords.y, coords.z, coords.w, isnetworked)
    local netid = NetworkGetNetworkIdFromEntity(ped)
    SetModelAsNoLongerNeeded(model)
    if cb then
        cb(ped)
    end
end

-- Vehicle

function QBCore.Functions.SpawnVehicle(model, cb, coords, isnetworked, teleportInto)
    local ped = PlayerPedId()
    local model = type(model) == 'string' and joaat(model) or model
    if not IsModelInCdimage(model) then return end
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(ped)
    end
    local isnetworked = isnetworked == nil or isnetworked
    QBCore.Functions.LoadModel(model)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, coords.w, isnetworked, false)
    local netid = NetworkGetNetworkIdFromEntity(veh)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, 'OFF')
    SetVehicleFuelLevel(veh, 100.0)
    SetModelAsNoLongerNeeded(model)
    DecorSetBool(veh, 'PLAYER_VEHICLE', true)
    if teleportInto then TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1) end
    if cb then cb(veh) end
end

function QBCore.Functions.DeleteEntity(data)
    if type(data) == "table" then
        local NetIds = {}
        for k, v in pairs(data) do
            if NetworkDoesNetworkIdExist(v) then
                NetIds[#NetIds+1] = v
            elseif DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end
        if NetIds then
            TriggerServerEvent('QBCore:Game:Delete', NetIds)
        end
    else
        if NetworkDoesNetworkIdExist(data) then
            TriggerServerEvent('QBCore:Game:Delete', data)
        elseif DoesEntityExist(data) then
            DeleteEntity(data)
        end
    end
end

function QBCore.Functions.DeleteVehicle(vehicle)
    QBCore.Functions.DeleteEntity(vehicle)
end

function QBCore.Functions.GetPlate(vehicle)
    if vehicle == 0 then return end
    return QBCore.Shared.Trim(GetVehicleNumberPlateText(vehicle))
end

function QBCore.Functions.GetVehicleLabel(vehicle)
    if vehicle == nil or vehicle == 0 then return end
    return GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
end

function QBCore.Functions.SpawnClear(coords, radius)
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(PlayerPedId())
    end
    local vehicles = GetGamePool('CVehicle')
    local closeVeh = {}
    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = #(vehicleCoords - coords)
        if distance <= radius then
            closeVeh[#closeVeh + 1] = vehicles[i]
        end
    end
    if #closeVeh > 0 then return false end
    return true
end

function QBCore.Functions.GetVehicleProperties(vehicle)
    return lib.getVehicleProperties(vehicle)
end

function QBCore.Functions.Tableprint(t, exclusions)
    print(json.encode(t , {indent=true}))
end

function QBCore.Functions.SetVehicleProperties(vehicle, props)
    lib.setVehicleProperties(vehicle, props)
end

function QBCore.Functions.LoadParticleDictionary(dictionary)
    if HasNamedPtfxAssetLoaded(dictionary) then return end
    RequestNamedPtfxAsset(dictionary)
    while not HasNamedPtfxAssetLoaded(dictionary) do
        Wait(0)
    end
end

function QBCore.Functions.StartParticleAtCoord(dict, ptName, looped, coords, rot, scale, alpha, color, duration)
    if coords then
        coords = type(coords) == 'table' and vec3(coords.x, coords.y, coords.z) or coords
    else
        coords = GetEntityCoords(PlayerPedId())
    end
    QBCore.Functions.LoadParticleDictionary(dict)
    UseParticleFxAssetNextCall(dict)
    SetPtfxAssetNextCall(dict)
    local particleHandle
    if looped then
        particleHandle = StartParticleFxLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale or 1.0, false, false, false, false)
        if color then
            SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, false)
        end
        SetParticleFxLoopedAlpha(particleHandle, alpha or 10.0)
        if duration then
            Wait(duration)
            StopParticleFxLooped(particleHandle, false)
        end
    else
        SetParticleFxNonLoopedAlpha(alpha or 10.0)
        if color then
            SetParticleFxNonLoopedColour(color.r, color.g, color.b)
        end
        StartParticleFxNonLoopedAtCoord(ptName, coords.x, coords.y, coords.z, rot.x, rot.y, rot.z, scale or 1.0, false, false, false)
    end
    return particleHandle
end

function QBCore.Functions.StartParticleOnEntity(dict, ptName, looped, entity, bone, offset, rot, scale, alpha, color, evolution, duration)
    QBCore.Functions.LoadParticleDictionary(dict)
    UseParticleFxAssetNextCall(dict)
    local particleHandle, boneID
    if bone and GetEntityType(entity) == 1 then
        boneID = GetPedBoneIndex(entity, bone)
    elseif bone then
        boneID = GetEntityBoneIndexByName(entity, bone)
    end
    if looped then
        if bone then
            particleHandle = StartParticleFxLoopedOnEntityBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneID, scale, false, false, false)
        else
            particleHandle = StartParticleFxLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale, false, false, false)
        end
        if evolution then
            SetParticleFxLoopedEvolution(particleHandle, evolution.name, evolution.amount, false)
        end
        if color then
            SetParticleFxLoopedColour(particleHandle, color.r, color.g, color.b, false)
        end
        SetParticleFxLoopedAlpha(particleHandle, alpha)
        if duration then
            Wait(duration)
            StopParticleFxLooped(particleHandle, false)
        end
    else
        SetParticleFxNonLoopedAlpha(alpha or 10.0)
        if color then
            SetParticleFxNonLoopedColour(color.r, color.g, color.b)
        end
        if bone then
            StartParticleFxNonLoopedOnPedBone(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, boneID, scale, false, false, false)
        else
            StartParticleFxNonLoopedOnEntity(ptName, entity, offset.x, offset.y, offset.z, rot.x, rot.y, rot.z, scale, false, false, false)
        end
    end
    return particleHandle
end

function QBCore.Functions.GetStreetNametAtCoords(coords)
    local streetname1, streetname2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    return { main = GetStreetNameFromHashKey(streetname1), cross = GetStreetNameFromHashKey(streetname2) }
end

function QBCore.Functions.GetZoneAtCoords(coords)
    return GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
end

function QBCore.Functions.GetCardinalDirection(entity)
    entity = entity or PlayerPedId()
    if DoesEntityExist(entity) then
        local heading = GetEntityHeading(entity)
        if ((heading >= 0 and heading < 45) or (heading >= 315 and heading < 360)) then
            return 'North'
        elseif (heading >= 45 and heading < 135) then
            return 'West'
        elseif (heading >= 135 and heading < 225) then
            return 'South'
        elseif (heading >= 225 and heading < 315) then
            return 'East'
        end
    else
        return 'Entity does not exist'
    end
end

function QBCore.Functions.GetCurrentTime()
    local obj = {}
    obj.min = GetClockMinutes()
    obj.hour = GetClockHours()

    if obj.hour <= 12 then
        obj.ampm = 'AM'
    elseif obj.hour >= 13 then
        obj.ampm = 'PM'
        obj.formattedHour = obj.hour - 12
    end

    if obj.min <= 9 then
        obj.formattedMin = ('0%s'):format(obj.min)
    end

    return obj
end

function QBCore.Functions.GetGroundZCoord(coords)
    if not coords then return end

    local retval, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
    if retval then
        return vector3(coords.x, coords.y, groundZ)
    else
        print('Couldn\'t find Ground Z Coordinates given 3D Coordinates')
        print(coords)
        return coords
    end
end

function QBCore.Functions.SetStateBag(entity, statebag, value)
    if entity ~= 0 and DoesEntityExist(entity) then
        if NetworkHasControlOfEntity(entity) then
            Entity(entity).state:set(statebag, value, true) -- Local Player Setting
        else
            local netid = NetworkGetNetworkIdFromEntity(entity)
            TriggerServerEvent('QBCore:server:setStateBag', netid, statebag, value)
        end
    end
end

function QBCore.Functions.PersistEntity(entity)
    if entity ~= 0 and DoesEntityExist(entity) then
        TriggerServerEvent('QBCore:server:persistEntity', ObjToNet(entity))
    end
end