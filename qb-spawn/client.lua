local QBCore = exports['qb-core']:GetCoreObject()
local camZPlus1 = 1500
local camZPlus2 = 50
local pointCamCoords = 75
local pointCamCoords2 = 0
local cam1Time = 500
local cam2Time = 1000
local choosingSpawn = false
local cam, cam2 = nil, nil
local spawnLocs

-- Functions

local function SetDisplay(bool)
    choosingSpawn = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool
    })
end

-- Events

RegisterNetEvent('qb-spawn:client:openUI', function(value)
    SetPlayerInvincible(PlayerId(), true)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityVisible(PlayerPedId(), false)
    DoScreenFadeOut(250)
    Wait(1000)
    DoScreenFadeIn(250)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", PlayerData.position.x, PlayerData.position.y, PlayerData.position.z + camZPlus1, -85.00, 0.00, 0.00, 100.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    end)
    Wait(500)
    SetDisplay(value)
end)

-- Commented due to it keep erroring constantly
RegisterNetEvent('qb-houses:client:setHouseConfig', function(houseConfig)
    Config.Houses = houseConfig
end)

RegisterNetEvent('qb-spawn:client:setupSpawns', function(cData, new, apps)
    camZPlus1 = 1500
    camZPlus2 = 50
    pointCamCoords = 75
    pointCamCoords2 = 0
    cam1Time = 500
    cam2Time = 1000
    choosingSpawn = false
    cam, cam2 = nil, nil
    spawnLocs = {}
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["injail"] > 0 then
            spawnLocs = QB.JailSpawns
            if not new then
                SendNUIMessage({
                    action = "setupLocations",
                    locations = spawnLocs,
                })
            elseif new then
                SendNUIMessage({
                    action = "setupAppartements",
                    locations = apps,
                })
            end
        else
            spawnLocs = QB.Spawns

            if PlayerData.gang and QB.GangSpawns[PlayerData.gang.name] then
                local GangSpawn = QB.GangSpawns[PlayerData.gang.name]
                spawnLocs[GangSpawn.location] = GangSpawn
            end

            if not new then
                QBCore.Functions.TriggerCallback('qb-spawn:server:getOwnedHouses', function(houses)
                    local myHouses = {}
                    if houses ~= nil then
                        for k,v in pairs(houses) do
                            myHouses[#myHouses+1] = {
                                house = v.house,
                                label = Config.Houses[v.house].adress,
                            }
                        end
                    end
        
                    Wait(500)
                    SendNUIMessage({
                        action = "setupLocations",
                        locations = spawnLocs,
                        houses = myHouses,
                    })
                end, cData.citizenid)
            elseif new then
                SendNUIMessage({
                    action = "setupAppartements",
                    locations = apps,
                })
            end
            
        end
    end)

   
end)

-- NUI Callbacks

RegisterNUICallback("exit", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "ui",
        status = false
    })
    choosingSpawn = false
end)

local cam = nil
local cam2 = nil

local function SetCam(campos)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus1, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam2, campos.x, campos.y, campos.z + pointCamCoords)
    SetCamActiveWithInterp(cam2, cam, cam1Time, true, true)
    if DoesCamExist(cam) then
        DestroyCam(cam, true)
    end
    Wait(cam1Time)

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z + camZPlus2, 300.00,0.00,0.00, 110.00, false, 0)
    PointCamAtCoord(cam, campos.x, campos.y, campos.z + pointCamCoords2)
    SetCamActiveWithInterp(cam, cam2, cam2Time, true, true)
    SetEntityCoords(PlayerPedId(), campos.x, campos.y, campos.z)
end

RegisterNUICallback('setCam', function(data)
    local location = tostring(data.posname)
    local type = tostring(data.type)

    DoScreenFadeOut(200)
    Wait(500)
    DoScreenFadeIn(200)

    if DoesCamExist(cam) then
        DestroyCam(cam, true)
    end

    if DoesCamExist(cam2) then
        DestroyCam(cam2, true)
    end

    if type == "current" then
        QBCore.Functions.GetPlayerData(function(PlayerData)
            SetCam(PlayerData.position)
        end)
    elseif type == "house" then
        SetCam(Config.Houses[location].coords.enter)
    elseif type == "normal" then
        SetCam(spawnLocs[location].coords)
    elseif type == "appartment" then
        SetCam(vec3(Apartments.Locations[location].enter.x, Apartments.Locations[location].enter.y, Apartments.Locations[location].enter.z+50.0))
    end
end)

RegisterNUICallback('chooseAppa', function(data)
    local appaYeet = data.appType
    SetDisplay(false)
    DoScreenFadeOut(500)
    Wait(5000)
    TriggerServerEvent("apartments:server:CreateApartment", appaYeet, Apartments.Locations[appaYeet].label)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
    FreezeEntityPosition(PlayerPedId(), false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(PlayerPedId(), true)
end)

local function PreSpawnPlayer()
    SetDisplay(false)
    DoScreenFadeOut(500)
    Wait(2000)
    local interior = GetInteriorAtCoords(GetEntityCoords(PlayerPedId()))
    if interior ~= 0 then
        RefreshInterior(interior)
    end
end

local function PostSpawnPlayer(ped)
    --SetPlayerInvincible(PlayerId(), false)
    FreezeEntityPosition(PlayerPedId(), false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(PlayerPedId(), true)
    local interior = GetInteriorAtCoords(GetEntityCoords(PlayerPedId()))
    if interior ~= 0 then
        RefreshInterior(interior)
    end
    Wait(1000)
    SetPlayerInvincible(PlayerId(), false)
    DoScreenFadeIn(250)
end

RegisterNUICallback('spawnplayer', function(data)
    local location = tostring(data.spawnloc)
    local type = tostring(data.typeLoc)
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local insideMeta = PlayerData.metadata["inside"]
    TriggerServerEvent("qb-log:server:CreateLog", "default", "Player Spawned", "blue", "`" .. GetPlayerName(PlayerId()) .. "` has chosen type spawn: `"..type.."` at location: `"..location.."`", false, GetPlayerServerId(PlayerId()))
    if type == "current" then
        PreSpawnPlayer()
        QBCore.Functions.GetPlayerData(function(PlayerData)
            SetEntityCoords(PlayerPedId(), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
            SetEntityHeading(PlayerPedId(), PlayerData.position.a)
            FreezeEntityPosition(PlayerPedId(), false)
        end)
        TriggerServerEvent("qb-apartments:returnBucket")
        if insideMeta.house ~= nil then
            local houseId = insideMeta.house
            TriggerEvent('qb-houses:client:LastLocationHouse', houseId)
        elseif insideMeta.apartment.apartmentType ~= nil or insideMeta.apartment.apartmentId ~= nil then
            local apartmentType = insideMeta.apartment.apartmentType
            local apartmentId = insideMeta.apartment.apartmentId
            TriggerEvent('qb-apartments:client:LastLocationHouse', apartmentType, apartmentId)
        else
            TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
            TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
        end
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        PostSpawnPlayer()
    elseif type == "house" then
        PreSpawnPlayer()
        TriggerEvent('qb-houses:client:enterOwnedHouse', location)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
        PostSpawnPlayer()
    elseif type == "normal" then
        local pos = spawnLocs[location].coords
        PreSpawnPlayer()
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
        Wait(500)
        SetEntityCoords(ped, pos.x, pos.y, pos.z)
        SetEntityHeading(ped, pos.w)
        PostSpawnPlayer()
        TriggerServerEvent("qb-apartments:returnBucket")
        TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
        TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
    end
end)

-- Threads

CreateThread(function()
    while true do
        Wait(0)
        if choosingSpawn then
            DisableAllControlActions(0)
        else
            Wait(1000)
        end
    end
end)
