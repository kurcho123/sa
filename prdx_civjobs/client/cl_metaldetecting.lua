local QBCore = exports['qb-core']:GetCoreObject()
local isInsideZone = false

local digZone = nil
local insideDigZone = false
local detectorModel = nil
local detecting = false

local function isInHotbar(item)
    local items = exports.ox_inventory:Search('slots', item)
    local inHotbar = false
    for _, v in pairs(items) do inHotbar = v.slot <= 6 end
    return inHotbar
end

local function attachDetector(shouldAttach)
    local model = 'w_am_digiscanner'
    local ped = PlayerPedId()
    if shouldAttach and not IsEntityAttached(detectorModel) then
        QBCore.Functions.LoadModel(model)
        local pos = GetEntityCoords(PlayerPedId())
        detectorModel = CreateObjectNoOffset(model, pos, 1, 1, 0)
        AttachEntityToEntity(detectorModel, ped, GetPedBoneIndex(ped, Config.metalDetecting.boneoffsets[model].bone), Config.metalDetecting.boneoffsets[model].offset, Config.metalDetecting.boneoffsets[model].rotation, 1, 0, 0, 0, 2, 1)
    else
        StopAnimTask(cache.ped, 'mini@golfai','wood_idle_a', 1.0)
        QBCore.Functions.DeleteEntity(detectorModel)
        detectorModel = nil
    end
end

local function startZoneThread()
    CreateThread(function ()
        while insideDigZone do
            Wait(10)
            if IsControlJustReleased(0, 38) then
                digZone:remove() -- Remove Old zone
                attachDetector(false) -- Remove metaldetector
                insideDigZone = false
                StopAnimTask(cache.ped, 'mini@golfai','wood_idle_a', 1.0)
                TriggerEvent('animations:client:EmoteCommandStart', {"dig"})
                if lib.progressBar({
                    duration = 2000,
                    label = 'Digging',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        car = true,
                    }
                }) then -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('metaldetecting:server:reward')
                    detecting = false
                else -- Cancel
                end
            end
        end
    end)
end

RegisterNetEvent('metaldetecting:client:startdetect')
AddEventHandler('metaldetecting:client:startdetect', function(data)
    if detecting == true then return end
    if isInsideZone == false then
        lib.notify({title = 'Not inside detection zone',
        description = 'This is not a suitable place to do metaldetecting.',
        type = 'inform'})
    elseif IsPedInAnyVehicle(cache.ped) then
        lib.notify({title = 'Metaldetecting',
        description = 'You cant detect while in a vehicle',
        type = 'inform'})
    elseif not isInHotbar('metaldetector') then
        -- Check so staff dont randomly gets detector attached
        lib.notify({title = 'Metaldetecting',
        description = 'Detector not in hotbar.',
        type = 'inform'})
    else
        insideDigZone = false
        if digZone ~= nil then digZone:remove() end -- Remove Old zone
        attachDetector(true)
        detecting = true
        lib.requestAnimDict('mini@golfai', 1000)
        TaskPlayAnim(cache.ped,'mini@golfai','wood_idle_a', 8.0, 8.0, -1, 51, 0, false, false, false)
        local startCords = GetEntityCoords(cache.ped)
        local distanceLeft = math.random(50,200)
        CreateThread(function ()
            while distanceLeft > 0 do
                distanceLeft = distanceLeft - #(GetEntityCoords(cache.ped)-startCords)
                Wait(500)
            end
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, 'metaldetector', 0.2)
            lib.notify({title = 'Metaldetecting',
            description = 'Looks like there might be something in this area.',
            type = 'inform'})
            digZone = lib.zones.box({
                coords = GetEntityCoords(cache.ped),
                size = vector3(3.0,3.0,3.0),
                rotation = 45,
                debug = false,
                inside = function()
                    lib.showTextUI('[E] - Start digging')
                    insideDigZone = true
                end,
                onEnter = function()
                    insideDigZone = true
                    startZoneThread()
                 end,
                onExit = function()
                    insideDigZone = false
                end,
            })
            startZoneThread()
        end)
    end
end)

local function buildDetectionZones()
    for _,v in pairs(Config.metalDetecting.zones) do
        lib.zones.poly({
            thickness = v.thickness,
            debug = Config.metalDetecting.debug,
            points = v.points,
            inside  = function (self)
                isInsideZone = true
            end,
            onEnter = function (self)
                isInsideZone = true
            end,
            onExit  = function (self)
                isInsideZone = false
                attachDetector(false)
                if digZone then digZone:remove() end
            end
        })
    end
end


CreateThread(function ()
    Wait(15000)
    buildDetectionZones()
end)