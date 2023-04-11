QBCore = exports['qb-core']:GetCoreObject()

local HouseZones, HouseObj, POIOffsets, OwnedHouseBlips, UnownedHouseBlips, data = {}, {}, {}, {}, {}, {}
local isOwned, CurrentHouse, ContractOpen, cam, viewCam, FrontCam, FetchingHouseKeys, Entering, RangDoorbell = false, nil, false, nil, false, false, false, false, nil
local CurrentDoorBell, RamsDone = 0, 0
IsInside, HasHouseKey, ClosestHouse = false, false, nil
local dryVolume = 0
-- Functions

    local function OpenHouseAnim()
        lib.requestAnimDict('anim@heists@keycard@', 100)
        TaskPlayAnim(cache.ped, 'anim@heists@keycard@', 'exit', 5.0, 1.0, -1, 16, 0, false, false, false)
        Wait(400)
        StopAnimTask(cache.ped, 'anim@heists@keycard@', 'exit', 1.0)
    end

    local function RamAnim(bool)
        local dict = 'missheistfbi3b_ig7'
        local anim = 'ift_fibagent_loop'
        lib.requestAnimDict(dict, 100)
        if bool then
            TaskPlayAnim(cache.ped, dict, anim, 8.0, 8.0, -1, 1, -1, false, false, false)
        else
            TaskPlayAnim(cache.ped, dict, 'exit', 8.0, 8.0, -1, 1, -1, false, false, false)
        end
    end

    local function ShowEntranceHeaderMenu(house)
        local headerMenu = {}

        if Config.Debug then
           print(house)
        end

        QBCore.Functions.TriggerCallback('qb-houses:server:HasKeysIsOwned', function(haskeys, owned)
            HasHouseKey = haskeys
            isOwned = owned
            
            if not isOwned then
                headerMenu[#headerMenu+1] = {
                    title = Lang:t("menu.view_house"),
                    event = "qb-houses:client:viewHouse",
                    args = {}
                }
            else
                if isOwned and HasHouseKey then
                    headerMenu[#headerMenu+1] = {
                        title = Lang:t("menu.enter_house"),
                        event = "qb-houses:client:enterHouse",
                        args = {}
                    }

                    headerMenu[#headerMenu+1] = {
                        title = Lang:t("menu.give_house_key"),
                        event = "qb-houses:client:giveHouseKey",
                        args = {}
                    }
                elseif isOwned and not HasHouseKey then
                    headerMenu[#headerMenu+1] = {
                        title = Lang:t("menu.ring_door"),
                        event = "qb-houses:client:requestRing",
                        args = {}
                    }
                    headerMenu[#headerMenu+1] = {
                        title = Lang:t("menu.enter_unlocked_house"),
                        event = "qb-houses:client:enterHouse",
                        args = {}
                    }
                    local PlayerJob = QBCore.Functions.GetPlayerData().job
                    if PlayerJob.name == "marshalls" or PlayerJob.name == "lspd" or PlayerJob.name == "bcso" or PlayerJob.name == "sast" or PlayerJob.name == "hc" or PlayerJob.name == "pd_cid" then
                        headerMenu[#headerMenu+1] = {
                            title = Lang:t("menu.lock_door_police"),
                            event = "qb-houses:client:resetHouse",
                            args = {}
                        }
                    end
                else
                    headerMenu = {}
                end
            end

            if headerMenu and next(headerMenu) then
                lib.registerContext({
                    id = 'house_context_menu',
                    title = Lang:t('menu.house_options'),
                    options = headerMenu
                })

                lib.showContext('house_context_menu')
            end
        end, house)
    end

    local function ShowExitHeaderMenu()
        local headerMenu = {}

        headerMenu[#headerMenu+1] = {
            title = Lang:t("menu.exit_property"),
            event = "qb-houses:client:exitOwnedHouse",
            args = {}
        }

        if isOwned then
            headerMenu[#headerMenu+1] = {
                title = Lang:t("menu.front_camera"),
                event = "qb-houses:client:frontDoorCam",
                args = {}
            }
            headerMenu[#headerMenu+1] = {
                title = Lang:t("menu.open_door"),
                event = "qb-houses:client:answerDoorbell",
                args = {}
            }
        end
    
        if headerMenu and next(headerMenu) then
            lib.registerContext({
                id = 'house_exit_context_menu',
                title = Lang:t('menu.house_options'),
                options = headerMenu
            })
            lib.showContext('house_exit_context_menu')
        end
    end

    local function onEnter(self)
        lib.showTextUI(Lang:t('menu.' .. self.typ))
        currentEntrance = self.houseId
    end

    local function onExit(self)
        lib.hideTextUI()
        currentEntrance = nil
    end

    local function isInside(self)
        if IsControlJustPressed(0, 38) then
            if self.typ == 'enter' then
                ShowEntranceHeaderMenu(self.houseId)
            elseif self.typ == 'leave' then
                ShowExitHeaderMenu()
            elseif self.typ == 'open_stash' then
                TriggerEvent('qb-houses:client:openStash', self.houseId)
            elseif self.typ == 'change_outfit' then
                TriggerEvent('qb-houses:client:changeOutfit')
            elseif self.typ == 'logout' then
                TriggerEvent('qb-houses:client:changeCharacter')
            end
            lib.hideTextUI()
        end
    end

    local function CreateEnterances()
        if Config.Houses and next(Config.Houses) then
            for id, house in pairs(Config.Houses) do
                if house and house.coords and house.coords.enter then
                    HouseZones[id] = {}
                    HouseZones[id].enterance = lib.zones.sphere({
                        coords = vector3(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z),
                        radius = 1.5,
                        debug = false,
                        inside = isInside,
                        onEnter = onEnter,
                        onExit = onExit,
                        typ = 'enter',
                        houseId = id
                    })
                end
            end
        end
    end

    local function RemoveEnterances()
        onExit()
        for id, _ in pairs(HouseZones) do
            HouseZones[id].enterance:remove()
        end
    end

    local function CreateInsidePoints(id, data)
        HouseZones[id].exit = lib.zones.sphere({
            coords = vector3(Config.Houses[id].coords.enter.x + data.exit.x, Config.Houses[id].coords.enter.y + data.exit.y, Config.Houses[id].coords.enter.z - Config.MinZOffset + data.exit.z + 1.0),
            radius = 3.0,
            debug = false,
            inside = isInside,
            onEnter = onEnter,
            onExit = onExit,
            typ = 'leave',
            houseId = id
        })
        
        QBCore.Functions.TriggerCallback('qb-houses:server:getHouseLocations', function(result)
            if result.stash then
                local stash = json.decode(result.stash)
                HouseZones[id].stash = lib.zones.sphere({
                    coords = vector3(stash.x, stash.y, stash.z),
                    radius = 1.0,
                    debug = false,
                    inside = isInside,
                    onEnter = onEnter,
                    onExit = onExit,
                    typ = 'open_stash',
                    houseId = id
                })
            end

            if result.outfit then
                local outfit = json.decode(result.outfit)
                HouseZones[id].clothes = lib.zones.sphere({
                    coords = vector3(outfit.x, outfit.y, outfit.z),
                    radius = 1.0,
                    debug = false,
                    inside = isInside,
                    onEnter = onEnter,
                    onExit = onExit,
                    typ = 'change_outfit',
                    houseId = id
                })
            end

            if result.logout then
                local logout = json.decode(result.logout)
                HouseZones[id].logout = lib.zones.sphere({
                    coords = vector3(logout.x, logout.y, logout.z),
                    radius = 1.0,
                    debug = false,
                    inside = isInside,
                    onEnter = onEnter,
                    onExit = onExit,
                    typ = 'logout',
                    houseId = id
                })
            end
        end, id)
    end

    local function RemoveInsidePoints(id)
        if HouseZones[id].exit then HouseZones[id].exit:remove() end
        if HouseZones[id].stash then HouseZones[id].stash:remove() end
        if HouseZones[id].clothes then HouseZones[id].clothes:remove() end
        if HouseZones[id].logout then HouseZones[id].logout:remove() end
    end

    -- Enter/Exit
    local function EnterOwnedHouse(house)
        if not Config.Houses[house] then return end
        CurrentHouse = house
        ClosestHouse = house
        HasHouseKey = true
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        OpenHouseAnim()
        IsInside = true
        if Config.Debug then
            QBCore.Functions.Tableprint(Config.Houses[house])
            print('DEBUG ID:', Config.Houses[house].instanceid, tonumber(Config.Houses[house].instanceid), house)
        end
        TriggerServerEvent('qb-houses:server:setBucket', house)
        Wait(500)
        local coords = { x = Config.Houses[house].coords.enter.x, y = Config.Houses[house].coords.enter.y, z= Config.Houses[house].coords.enter.z - Config.MinZOffset}
        LoadDecorations(house)
        data = GetDataForHouseTier(house, coords)
        dryVolume = CreateDryVolume(coords.x - 25.0, coords.y - 25.0, coords.z - 25.0, coords.x + 25.0, coords.y + 25.0, coords.z + 25.0)
        Wait(100)
        HouseObj = data[1]
        POIOffsets = data[2]
        Entering = true
        Wait(500)
        TriggerServerEvent('qb-houses:server:SetInsideMeta', house, true)
        TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999})
        TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
        TriggerEvent('qb-weed:client:getHousePlants', house)
        Entering = false
        CreateInsidePoints(house, POIOffsets)
        if Config.Debug then
            print('ENTER COMPLETE...')
        end
        StartAudioScene("DLC_MPHEIST_TRANSITION_TO_APT_FADE_OUT_AMB_SCENE")
    end

    local function EnterNonOwnedHouse(house)
        if not Config.Houses[house] then return end
        CurrentHouse = house
        ClosestHouse = house
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        OpenHouseAnim()
        IsInside = true
        TriggerServerEvent('qb-houses:server:setBucket', house)
        Wait(500)
        local coords = { x = Config.Houses[house].coords.enter.x, y = Config.Houses[house].coords.enter.y, z= Config.Houses[house].coords.enter.z - Config.MinZOffset}
        LoadDecorations(house)
        data = GetDataForHouseTier(house, coords)
        dryVolume = CreateDryVolume(coords.x - 25.0, coords.y - 25.0, coords.z - 25.0, coords.x + 25.0, coords.y + 25.0, coords.z + 25.0)
        HouseObj = data[1]
        POIOffsets = data[2]
        Entering = true
        Wait(500)
        TriggerServerEvent('qb-houses:server:SetInsideMeta', house, true)
        TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999})
        TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
        TriggerEvent('qb-weed:client:getHousePlants', house)
        Entering = false
        InOwnedHouse = true
        CreateInsidePoints(house, POIOffsets)
    end

    local function LeaveHouse(house)
        if not FrontCam then
            IsInside = false
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
            OpenHouseAnim()
            Wait(250)
            DoScreenFadeOut(250)
            Wait(500)
            exports['qb-interior']:DespawnInterior(HouseObj, function()
                RemoveDryVolume(dryVolume)
                UnloadDecorations()
                TriggerServerEvent("qb-houses:server:returnBucket")
                TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
                TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
                StopAudioScenes()
                DoScreenFadeIn(250)
                SetEntityCoords(PlayerPedId(), Config.Houses[house].coords.enter.x, Config.Houses[house].coords.enter.y, Config.Houses[house].coords.enter.z)
                SetEntityHeading(PlayerPedId(), Config.Houses[house].coords.enter.h)
                TriggerEvent('qb-weed:client:leaveHouse')
                TriggerServerEvent('qb-houses:server:SetInsideMeta', house, false)
                CurrentHouse = nil
                RemoveInsidePoints(house)
            end)
        end
    end

    -- Cameras
    local function SetViewCam(coords, h, yaw)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z, yaw, 0.00, h, 80.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)
        viewCam = true
    end

    local function DisableViewCam()
        if viewCam then
            RenderScriptCams(false, true, 500, true, true)
            SetCamActive(cam, false)
            DestroyCam(cam, true)
            viewCam = false
        end
    end

    local function FrontDoorCam(coords)
        DoScreenFadeOut(150)
        Wait(500)
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 0.5, 0.0, 0.00, coords.h - 180, 80.00, false, 0)
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 500, true, true)
        TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
        TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
        FrontCam = true
        FreezeEntityPosition(PlayerPedId(), true)
        Wait(500)
        DoScreenFadeIn(150)
        SendNUIMessage({
            type = "frontcam",
            toggle = true,
            label = Config.Houses[ClosestHouse].adress
        })
        TriggerServerEvent("qb-houses:server:returnBucket")
        CreateThread(function()
            while FrontCam do
                local instructions = CreateInstuctionScaleform("instructional_buttons")
                DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
                SetTimecycleModifier("scanline_cam_cheap")
                SetTimecycleModifierStrength(1.0)
                if IsControlJustPressed(1, 194) then -- Backspace
                    DoScreenFadeOut(150)
                    SendNUIMessage({
                        type = "frontcam",
                        toggle = false,
                    })
                    Wait(500)
                    RenderScriptCams(false, true, 500, true, true)
                    FreezeEntityPosition(PlayerPedId(), false)
                    SetCamActive(cam, false)
                    DestroyCam(cam, true)
                    ClearTimecycleModifier("scanline_cam_cheap")
                    cam = nil
                    FrontCam = false
                    Wait(500)
                    DoScreenFadeIn(150)
                end
    
                local getCameraRot = GetCamRot(cam, 2)
    
                -- ROTATE UP
                if IsControlPressed(0, 32) then -- W
                    if getCameraRot.x <= 0.0 then
                        SetCamRot(cam, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
                    end
                end
    
                -- ROTATE DOWN
                if IsControlPressed(0, 33) then -- S
                    if getCameraRot.x >= -50.0 then
                        SetCamRot(cam, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
                    end
                end
    
                -- ROTATE LEFT
                if IsControlPressed(0, 34) then -- A
                    SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
                end
    
                -- ROTATE RIGHT
                if IsControlPressed(0, 35) then -- D
                    SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
                end
    
                Wait(1)
            end
            TriggerServerEvent('qb-houses:server:setBucket', ClosestHouse)
            TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999})
            TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
        end)
    end

    -- Scaleforms
    local function InstructionButton(ControlButton)
        ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
    end
    
    local function InstructionButtonMessage(text)
        BeginTextCommandScaleformString("STRING")
        AddTextComponentScaleform(text)
        EndTextCommandScaleformString()
    end
    
    function CreateInstuctionScaleform(scaleform)
        local scaleform = RequestScaleformMovie(scaleform)
        while not HasScaleformMovieLoaded(scaleform) do
            Wait(0)
        end
        PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
        PushScaleformMovieFunctionParameterInt(200)
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
        PushScaleformMovieFunctionParameterInt(1)
        InstructionButton(GetControlInstructionalButton(1, 194, true))
        InstructionButtonMessage(Lang:t("info.exit_camera"))
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(80)
        PopScaleformMovieFunctionVoid()
        return scaleform
    end

    -- Decorations
    function LoadDecorations(house)
        local HouseConfig = Config.Houses[house]
        if HouseConfig.decorations == nil or next(HouseConfig.decorations) == nil then
            QBCore.Functions.TriggerCallback('qb-houses:server:getHouseDecorations', function(result)
                HouseConfig.decorations = result
                if HouseConfig.decorations ~= nil then
                    ObjectList = {}
                    for k, v in pairs(HouseConfig.decorations) do
                        if HouseConfig.decorations[k] ~= nil then
                            if HouseConfig.decorations[k].object ~= nil then
                                if DoesEntityExist(HouseConfig.decorations[k].object) then
                                    DeleteObject(HouseConfig.decorations[k].object)
                                end
                            end
                            local modelHash = joaat(HouseConfig.decorations[k].hashname)
                            RequestModel(modelHash)
                            while not HasModelLoaded(modelHash) do
                                Wait(10)
                            end
                            local decorateObject = CreateObject(modelHash, HouseConfig.decorations[k].x, HouseConfig.decorations[k].y, HouseConfig.decorations[k].z, false, false, false)
                            FreezeEntityPosition(decorateObject, true)
                            SetEntityCoordsNoOffset(decorateObject, HouseConfig.decorations[k].x, HouseConfig.decorations[k].y, HouseConfig.decorations[k].z)
                            SetEntityRotation(decorateObject, HouseConfig.decorations[k].rotx, HouseConfig.decorations[k].roty, HouseConfig.decorations[k].rotz)
                            ObjectList[HouseConfig.decorations[k].objectId] = {hashname = HouseConfig.decorations[k].hashname, x = HouseConfig.decorations[k].x, y = HouseConfig.decorations[k].y, z = HouseConfig.decorations[k].z, rotx = HouseConfig.decorations[k].rotx, roty = HouseConfig.decorations[k].roty, rotz = HouseConfig.decorations[k].rotz, object = decorateObject, objectId = HouseConfig.decorations[k].objectId}
                        end
                    end
                end
            end, house)
        elseif HouseConfig.decorations ~= nil then
            ObjectList = {}
            for k, v in pairs(HouseConfig.decorations) do
                if HouseConfig.decorations[k] ~= nil then
                    if HouseConfig.decorations[k].object ~= nil then
                        if DoesEntityExist(HouseConfig.decorations[k].object) then
                            DeleteObject(HouseConfig.decorations[k].object)
                        end
                    end
                    local modelHash = joaat(HouseConfig.decorations[k].hashname)
                    RequestModel(modelHash)
                    local decorateObject = CreateObjectNoOffset(modelHash, HouseConfig.decorations[k].x, HouseConfig.decorations[k].y, HouseConfig.decorations[k].z, false, false, false)
                    FreezeEntityPosition(decorateObject, true)
                    SetEntityCoordsNoOffset(decorateObject, HouseConfig.decorations[k].x, HouseConfig.decorations[k].y, HouseConfig.decorations[k].z)
                    HouseConfig.decorations[k].object = decorateObject
                    SetEntityRotation(decorateObject, HouseConfig.decorations[k].rotx, HouseConfig.decorations[k].roty, HouseConfig.decorations[k].rotz)
                    ObjectList[HouseConfig.decorations[k].objectId] = {hashname = HouseConfig.decorations[k].hashname, x = HouseConfig.decorations[k].x, y = HouseConfig.decorations[k].y, z = HouseConfig.decorations[k].z, rotx = HouseConfig.decorations[k].rotx, roty = HouseConfig.decorations[k].roty, rotz = HouseConfig.decorations[k].rotz, object = decorateObject, objectId = HouseConfig.decorations[k].objectId}
                end
            end
        end
    end

    function UnloadDecorations()
        if ObjectList ~= nil then
            for k, v in pairs(ObjectList) do
                if DoesEntityExist(v.object) then
                    DeleteObject(v.object)
                end
            end
        end
    end

    -- Keys
    local function RemoveHouseKey(citizenData)
        TriggerServerEvent('qb-houses:server:removeHouseKey', ClosestHouse, citizenData)
    end

    local function GetKeyHolders()
        if FetchingHouseKeys then return end
        FetchingHouseKeys = true
    
        local p = promise.new()
        QBCore.Functions.TriggerCallback('qb-houses:server:getHouseKeyHolders', function(holders)
            p:resolve(holders)
        end,ClosestHouse)
    
        return Citizen.Await(p)
    end

    function HouseKeysMenu()
        local holders = GetKeyHolders()
        FetchingHouseKeys = false
        if holders == nil or next(holders) == nil then
            QBCore.Functions.Notify(Lang:t("error.no_key_holders"), "error", 3500)
        else
            keyholderMenu = {}
            for k, v in pairs(holders) do
                keyholderMenu[#keyholderMenu+1] = {
                    title = holders[k].firstname .. " " .. holders[k].lastname,
                    event = "qb-houses:client:openClientOptions",
                    args = {
                        citizenData = holders[k]
                    }
                }
            end
            if keyholderMenu and next(keyholderMenu) then
                lib.registerContext({
                    id = 'keyholder_menu',
                    title = 'Keyholders',
                    options = keyholderMenu
                })
    
                lib.showContext('keyholder_menu')
            end
        end
    end

    local function KeyholderOptionsMenu(citizenData)
        keyholderOptions = {
            {
                title = Lang:t("menu.remove_key"),
                event = "qb-houses:client:revokeKey",
                args = {
                    citizenData = citizenData
                }
            },
            {
                title = Lang:t("menu.back"),
                event = "qb-houses:client:removeHouseKey",
                args = {}
            },
        }
    
        lib.registerContext({
            id = 'keyholder_options_menu',
            title = 'Keyholder Options',
            options = keyholderOptions
        })
    
        lib.showContext('keyholder_options_menu')
    end

    -- Util
    local function OpenContract(bool)
        SetNuiFocus(bool, bool)
        SendNUIMessage({
            type = "toggle",
            status = bool,
        })
        ContractOpen = bool
    end

    local function SetClosestHouse()
        local pos = GetEntityCoords(PlayerPedId(), true)
        local current = nil
        local dist = nil
        if not IsInside then
            for id, house in pairs(Config.Houses) do
                local distcheck = #(pos - vector3(Config.Houses[id].coords.enter.x, Config.Houses[id].coords.enter.y, Config.Houses[id].coords.enter.z))
                if current ~= nil then
                    if distcheck < dist then
                        current = id
                        dist = distcheck
                    end
                else
                    dist = distcheck
                    current = id
                end
            end
            ClosestHouse = current
            if ClosestHouse ~= nil and tonumber(dist) < 30 then
                QBCore.Functions.TriggerCallback('qb-houses:server:HasKeysIsOwned', function(key, owned)
                    HasHouseKey = key
                    isOwned = owned
                end, ClosestHouse)
            end
        end
        TriggerEvent('qb-garages:client:setHouseGarage', ClosestHouse, HasHouseKey)
    end

    local function GetClosestPlayer()
        local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
        local closestDistance = -1
        local closestPlayer = -1
        local coords = GetEntityCoords(PlayerPedId())
        for i=1, #closestPlayers, 1 do
            if closestPlayers[i] ~= PlayerId() then
                local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
                local distance = #(pos - coords)
    
                if closestDistance == -1 or closestDistance > distance then
                    closestPlayer = closestPlayers[i]
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance
    end

    local function CheckDistance(target, distance)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
    
        return #(pos - target) <= distance
    end

    local function IsNearHouses()
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
    
        if ClosestHouse ~= nil then
            local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
            if dist <= 1.5 then
                if HasHouseKey then
                    return true
                end
            end
        end
    end

    function GetDataForHouseTier(house, coords)
        local HouseConfig = Config.Houses[house]
        if HouseConfig.tier == 1 then
            return exports['qb-interior']:CreateApartmentShell(coords)
        elseif HouseConfig.tier == 2 then
            return exports['qb-interior']:CreateTier1House(coords)
        elseif HouseConfig.tier == 3 then
            return exports['qb-interior']:CreateTrevorsShell(coords)
        elseif HouseConfig.tier == 4 then
            return exports['qb-interior']:CreateCaravanShell(coords)
        elseif HouseConfig.tier == 5 then
            return exports['qb-interior']:CreateLesterShell(coords)
        elseif HouseConfig.tier == 6 then
            return exports['qb-interior']:CreateRanchShell(coords)
        elseif HouseConfig.tier == 7 then
            return exports['qb-interior']:CreateContainer(coords)
        elseif HouseConfig.tier == 8 then
            return exports['qb-interior']:CreateFurniMid(coords)
        elseif HouseConfig.tier == 9 then
            return exports['qb-interior']:CreateFurniMotelModern(coords)
        elseif HouseConfig.tier == 10 then
            return exports['qb-interior']:CreateFranklinAunt(coords)
        elseif HouseConfig.tier == 11 then
            return exports['qb-interior']:CreateGarageMed(coords)
        elseif HouseConfig.tier == 12 then
            return exports['qb-interior']:CreateMichael(coords)
        elseif HouseConfig.tier == 13 then
            return exports['qb-interior']:CreateOffice1(coords)
        elseif HouseConfig.tier == 14 then
            return exports['qb-interior']:CreateStore1(coords)
        elseif HouseConfig.tier == 15 then
            return exports['qb-interior']:CreateWarehouse1(coords)
        elseif HouseConfig.tier == 16 then
            return exports['qb-interior']:CreateFurniMotelStandard(coords) -- End of free shells
        elseif HouseConfig.tier == 17 then
            return exports['qb-interior']:CreateMedium2(coords)
        elseif HouseConfig.tier == 18 then
            return exports['qb-interior']:CreateMedium3(coords)
        elseif HouseConfig.tier == 19 then
            return exports['qb-interior']:CreateBanham(coords)
        elseif HouseConfig.tier == 20 then
            return exports['qb-interior']:CreateWestons(coords)
        elseif HouseConfig.tier == 21 then
            return exports['qb-interior']:CreateWestons2(coords)
        elseif HouseConfig.tier == 22 then
            return exports['qb-interior']:CreateClassicHouse(coords)
        elseif HouseConfig.tier == 23 then
            return exports['qb-interior']:CreateClassicHouse2(coords)
        elseif HouseConfig.tier == 24 then
            return exports['qb-interior']:CreateClassicHouse3(coords)
        elseif HouseConfig.tier == 25 then
            return exports['qb-interior']:CreateHighend1(coords)
        elseif HouseConfig.tier == 26 then
            return exports['qb-interior']:CreateHighend2(coords)
        elseif HouseConfig.tier == 27 then
            return exports['qb-interior']:CreateHighend3(coords)
        elseif HouseConfig.tier == 28 then
            return exports['qb-interior']:CreateHighend(coords)
        elseif HouseConfig.tier == 29 then
            return exports['qb-interior']:CreateHighendV2(coords)
        elseif HouseConfig.tier == 30 then
            return exports['qb-interior']:CreateStashHouse(coords)
        elseif HouseConfig.tier == 31 then
            return exports['qb-interior']:CreateStashHouse2(coords)
        elseif HouseConfig.tier == 32 then
            return exports['qb-interior']:CreateGarageLow(coords)
        elseif HouseConfig.tier == 33 then
            return exports['qb-interior']:CreateGarageHigh(coords)
        elseif HouseConfig.tier == 34 then
            return exports['qb-interior']:CreateOffice2(coords)
        elseif HouseConfig.tier == 35 then
            return exports['qb-interior']:CreateOfficeBig(coords)
        elseif HouseConfig.tier == 36 then
            return exports['qb-interior']:CreateBarber(coords)
        elseif HouseConfig.tier == 37 then
            return exports['qb-interior']:CreateGunstore(coords)
        elseif HouseConfig.tier == 38 then
            return exports['qb-interior']:CreateStore2(coords)
        elseif HouseConfig.tier == 39 then
            return exports['qb-interior']:CreateStore3(coords)
        elseif HouseConfig.tier == 40 then
            return exports['qb-interior']:CreateWarehouse2(coords)
        elseif HouseConfig.tier == 41 then
            return exports['qb-interior']:CreateWarehouse3(coords)
        elseif HouseConfig.tier == 42 then
            return exports['qb-interior']:CreateK4Coke(coords)
        elseif HouseConfig.tier == 43 then
            return exports['qb-interior']:CreateK4Meth(coords)
        elseif HouseConfig.tier == 44 then
            return exports['qb-interior']:CreateK4Weed(coords)
        elseif HouseConfig.tier == 45 then
            return exports['qb-interior']:CreateContainer2(coords)
        elseif HouseConfig.tier == 46 then
            return exports['qb-interior']:CreateFurniStash1(coords)
        elseif HouseConfig.tier == 47 then
            return exports['qb-interior']:CreateFurniStash3(coords)
        elseif HouseConfig.tier == 48 then
            return exports['qb-interior']:CreateFurniLow(coords)
        elseif HouseConfig.tier == 49 then
            return exports['qb-interior']:CreateFurniMotel(coords)
        elseif HouseConfig.tier == 50 then
            return exports['qb-interior']:CreateFurniMotelClassic(coords)
        elseif HouseConfig.tier == 51 then
            return exports['qb-interior']:CreateFurniMotelHigh(coords)
        elseif HouseConfig.tier == 52 then
            return exports['qb-interior']:CreateFurniMotelModern2(coords)
        elseif HouseConfig.tier == 53 then
            return exports['qb-interior']:CreateFurniMotelModern3(coords)
        elseif HouseConfig.tier == 54 then
            return exports['qb-interior']:CreateCoke(coords)
        elseif HouseConfig.tier == 55 then
            return exports['qb-interior']:CreateCoke2(coords)
        elseif HouseConfig.tier == 56 then
            return exports['qb-interior']:CreateMeth(coords)
        elseif HouseConfig.tier == 57 then
            return exports['qb-interior']:CreateWeed(coords)
        elseif HouseConfig.tier == 58 then
            return exports['qb-interior']:CreateWeed2(coords)
        elseif HouseConfig.tier == 59 then
            return exports['qb-interior']:CreateMansion(coords)
        elseif HouseConfig.tier == 60 then
            return exports['qb-interior']:CreateMansion2(coords)
        elseif HouseConfig.tier == 61 then
            return exports['qb-interior']:CreateMansion3(coords)
        elseif HouseConfig.tier == 62 then
            return exports['qb-interior']:CreateHotel1(coords)
        elseif HouseConfig.tier == 63 then
            return exports['qb-interior']:CreateHotel2(coords)
        elseif HouseConfig.tier == 64 then
            return exports['qb-interior']:CreateHotel3(coords)
        elseif HouseConfig.tier == 65 then
            return exports['qb-interior']:CreateMotel1(coords)
        elseif HouseConfig.tier == 66 then
            return exports['qb-interior']:CreateMotel2(coords)
        elseif HouseConfig.tier == 67 then
            return exports['qb-interior']:CreateMotel3(coords)
        elseif HouseConfig.tier == 68 then
            return exports['qb-interior']:CreateV2Default1(coords)
        elseif HouseConfig.tier == 69 then
            return exports['qb-interior']:CreateV2Default2(coords)
        elseif HouseConfig.tier == 70 then
            return exports['qb-interior']:CreateV2Default3(coords)
        elseif HouseConfig.tier == 71 then
            return exports['qb-interior']:CreateV2Default4(coords)
        elseif HouseConfig.tier == 72 then
            return exports['qb-interior']:CreateV2Default5(coords)
        elseif HouseConfig.tier == 73 then
            return exports['qb-interior']:CreateV2Default6(coords)
        elseif HouseConfig.tier == 74 then
            return exports['qb-interior']:CreateV2Deluxe1(coords)
        elseif HouseConfig.tier == 75 then
            return exports['qb-interior']:CreateV2Deluxe2(coords)
        elseif HouseConfig.tier == 76 then
            return exports['qb-interior']:CreateV2Deluxe3(coords)
        elseif HouseConfig.tier == 77 then
            return exports['qb-interior']:CreateV2HighEnd1(coords)
        elseif HouseConfig.tier == 78 then
            return exports['qb-interior']:CreateV2HighEnd2(coords)
        elseif HouseConfig.tier == 79 then
            return exports['qb-interior']:CreateV2HighEnd3(coords)
        elseif HouseConfig.tier == 80 then
            return exports['qb-interior']:CreateV2Medium1(coords)
        elseif HouseConfig.tier == 81 then
            return exports['qb-interior']:CreateV2Medium2(coords)
        elseif HouseConfig.tier == 82 then
            return exports['qb-interior']:CreateV2Medium3(coords)
        elseif HouseConfig.tier == 83 then
            return exports['qb-interior']:CreateV2Modern1(coords)
        elseif HouseConfig.tier == 84 then
            return exports['qb-interior']:CreateV2Modern2(coords)
        elseif HouseConfig.tier == 85 then
            return exports['qb-interior']:CreateV2Modern3(coords)
        else
            QBCore.Functions.Notify(Lang:t("error.invalid_tier"), 'error')
        end
    end

-- Events

    RegisterNetEvent('qb-houses:client:setHouseConfig', function(houseConfig)
        Config.Houses = houseConfig
        RemoveEnterances()
        CreateEnterances()
    end)

    RegisterNetEvent('qb-houses:server:setHouseDecorations', function(house, decorations)
        Config.Houses[house].decorations = decorations
        if IsInside and ClosestHouse == house then
            LoadDecorations(house)
        end
    end)

    RegisterNetEvent('qb-houses:client:createHouses', function(price, tier)
        local pos = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
        local street = GetStreetNameFromHashKey(s1)
        local coords = {
            enter 	= { x = pos.x, y = pos.y, z = pos.z, h = heading},
            cam 	= { x = pos.x, y = pos.y, z = pos.z, h = heading, yaw = -10.00},
        }
        street = street:gsub("%-", " ")
        TriggerServerEvent('qb-houses:server:addNewHouse', street, coords, price, tier)
        if Config.UnownedBlips then TriggerServerEvent('qb-houses:server:createBlip') end
    end)

    RegisterNetEvent('qb-houses:client:addGarage', function()
        if ClosestHouse ~= nil then
            local pos = GetEntityCoords(PlayerPedId())
            local heading = GetEntityHeading(PlayerPedId())
            local coords = {
                x = pos.x,
                y = pos.y,
                z = pos.z,
                h = heading,
            }
            TriggerServerEvent('qb-houses:server:addGarage', ClosestHouse, coords)
        else
            QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
        end
    end)

    RegisterNetEvent('qb-houses:client:sellHouse', function()
        if ClosestHouse and HasHouseKey then
            TriggerServerEvent('qb-houses:server:viewHouse', ClosestHouse)
        end
    end)

    RegisterNetEvent('qb-houses:client:enterHouse', function()
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        if ClosestHouse ~= nil then
            local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
            if dist <= 1.5 then
                if HasHouseKey then
                    EnterOwnedHouse(ClosestHouse)
                else
                    if not Config.Houses[ClosestHouse].locked then
                        EnterNonOwnedHouse(ClosestHouse)
                    end
                end
            end
        else
            QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
        end
    end)

    RegisterNetEvent('qb-houses:client:enterOwnedHouse', function(house)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            if PlayerData.metadata["injail"] == 0 then
                EnterOwnedHouse(house)
            end
        end)
    end)

    RegisterNetEvent('qb-houses:client:exitOwnedHouse', function()
        local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
        if CheckDistance(door, 1.5) then
            LeaveHouse(CurrentHouse)
        end
    end)

    -- Keys

    RegisterNetEvent('qb-houses:client:lockHouse', function(bool, house)
        Config.Houses[house].locked = bool
    end)

    RegisterNetEvent('qb-houses:client:toggleDoorlock', function()
        local pos = GetEntityCoords(PlayerPedId())
        local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if dist <= 1.5 then
            if HasHouseKey then
                if Config.Houses[ClosestHouse].locked then
                    TriggerServerEvent('qb-houses:server:lockHouse', false, ClosestHouse)
                    QBCore.Functions.Notify(Lang:t("success.unlocked"), "success", 2500)
                else
                    TriggerServerEvent('qb-houses:server:lockHouse', true, ClosestHouse)
                    QBCore.Functions.Notify(Lang:t("error.locked"), "error", 2500)
                end
            else
                QBCore.Functions.Notify(Lang:t("error.no_keys"), "error", 3500)
            end
        else
            QBCore.Functions.Notify(Lang:t("error.no_door"), "error", 3500)
        end
    end)

    RegisterNetEvent('qb-houses:client:giveHouseKey', function()
        local player, distance = GetClosestPlayer()
        if player ~= -1 and distance < 2.5 and ClosestHouse ~= nil then
            local playerId = GetPlayerServerId(player)
            local pedpos = GetEntityCoords(PlayerPedId())
            local housedist = #(pedpos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
            if housedist < 10 then
                TriggerServerEvent('qb-houses:server:giveHouseKey', playerId, ClosestHouse)
            else
                QBCore.Functions.Notify(Lang:t("error.no_door"), "error")
            end
        elseif ClosestHouse == nil then
            QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
        else
            QBCore.Functions.Notify(Lang:t("error.no_one_near"), "error")
        end
    end)

    RegisterNetEvent('qb-houses:client:removeHouseKey', function()
        if ClosestHouse ~= nil then
            local pedpos = GetEntityCoords(PlayerPedId())
            local housedist = #(pedpos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
            if housedist <= 5 then
                QBCore.Functions.TriggerCallback('qb-houses:server:getHouseOwner', function(result)
                    if QBCore.Functions.GetPlayerData().citizenid == result then
                        HouseKeysMenu()
                    else
                        QBCore.Functions.Notify(Lang:t("error.not_owner"), "error")
                    end
                end, ClosestHouse)
            else
                QBCore.Functions.Notify(Lang:t("error.no_door"), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.no_door"), "error")
        end
    end)

    RegisterNetEvent('qb-houses:client:revokeKey', function(data)
        RemoveHouseKey(data.citizenData)
    end)

    RegisterNetEvent('qb-houses:client:keyholderOptions', function(data)
        KeyholderOptionsMenu(data.citizenData)
    end)

    -- Doorbell

    RegisterNetEvent('qb-houses:client:requestRing', function()
        if ClosestHouse ~= nil then
            TriggerServerEvent('qb-houses:server:RingDoor', ClosestHouse)
        end
    end)

    RegisterNetEvent('qb-houses:client:ringDoor', function(player, house)
        if ClosestHouse == house and IsInside then
            CurrentDoorBell = player
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "doorbell", 0.1)
            QBCore.Functions.Notify(Lang:t("info.door_ringing"))
        end
    end)

    RegisterNetEvent('qb-houses:client:frontDoorCam', function()
        local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
        if CheckDistance(door, 1.5) then
            FrontDoorCam(Config.Houses[CurrentHouse].coords.enter)
        end
    end)

    RegisterNetEvent('qb-houses:client:answerDoorbell', function()
        if not CurrentDoorBell or CurrentDoorBell == 0 then
            QBCore.Functions.Notify(Lang:t('error.nobody_at_door'))
            return
        end
        local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
        if CheckDistance(door, 1.5) and CurrentDoorBell ~= 0 then
            TriggerServerEvent("qb-houses:server:OpenDoor", CurrentDoorBell, ClosestHouse)
            CurrentDoorBell = 0
        end
    end)

    -- Spawn

    RegisterNetEvent('qb-houses:client:spawnInApartment', function(house)
        local pos = GetEntityCoords(PlayerPedId())
        if RangDoorbell ~= nil then
            if #(pos - vector3(Config.Houses[house].coords.enter.x, Config.Houses[house].coords.enter.y, Config.Houses[house].coords.enter.z)) > 5 then
                return
            end
        end
        ClosestHouse = house
        EnterNonOwnedHouse(house)
    end)

    RegisterNetEvent('qb-houses:client:lastLocationHouse', function(houseId)
        QBCore.Functions.GetPlayerData(function(PlayerData)
            if PlayerData.metadata["injail"] == 0 then
                EnterOwnedHouse(houseId)
            end
        end)
    end)

    -- Blips

    RegisterNetEvent('qb-houses:client:setupHouseBlips', function() -- Setup owned on load
        CreateThread(function()
            Wait(2000)
            if LocalPlayer.state['isLoggedIn'] then
                QBCore.Functions.TriggerCallback('qb-houses:server:getOwnedHouses', function(ownedHouses)
                    if ownedHouses then
                        for k, v in pairs(ownedHouses) do
                            local house = Config.Houses[ownedHouses[k]]
                            HouseBlip = AddBlipForCoord(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z)
                            SetBlipSprite (HouseBlip, 40)
                            SetBlipDisplay(HouseBlip, 4)
                            SetBlipScale  (HouseBlip, 0.65)
                            SetBlipAsShortRange(HouseBlip, true)
                            SetBlipColour(HouseBlip, 3)
                            AddTextEntry('OwnedHouse', house.adress)
                            BeginTextCommandSetBlipName('OwnedHouse')
                            EndTextCommandSetBlipName(HouseBlip)
                            OwnedHouseBlips[#OwnedHouseBlips+1] = HouseBlip
                        end
                    end
                end)
            end
        end)
    end)

    RegisterNetEvent('qb-houses:client:setupHouseBlips2', function() -- Setup unowned on load
        for k,v in pairs(Config.Houses) do
            if not v.owned then
                HouseBlip2 = AddBlipForCoord(v.coords.enter.x, v.coords.enter.y, v.coords.enter.z)
                SetBlipSprite (HouseBlip2, 40)
                SetBlipDisplay(HouseBlip2, 4)
                SetBlipScale  (HouseBlip2, 0.65)
                SetBlipAsShortRange(HouseBlip2, true)
                SetBlipColour(HouseBlip2, 3)
                AddTextEntry('UnownedHouse', Lang:t("info.house_for_sale"))
                BeginTextCommandSetBlipName('UnownedHouse')
                EndTextCommandSetBlipName(HouseBlip2)
                UnownedHouseBlips[#UnownedHouseBlips+1] = HouseBlip2
            end
        end
    end)

    RegisterNetEvent('qb-houses:client:createBlip', function(coords) -- Create unowned on command
        NewHouseBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite (NewHouseBlip, 40)
        SetBlipDisplay(NewHouseBlip, 4)
        SetBlipScale  (NewHouseBlip, 0.65)
        SetBlipAsShortRange(NewHouseBlip, true)
        SetBlipColour(NewHouseBlip, 3)
        AddTextEntry('NewHouseBlip', Lang:t("info.house_for_sale"))
        BeginTextCommandSetBlipName('NewHouseBlip')
        EndTextCommandSetBlipName(NewHouseBlip)
        UnownedHouseBlips[#UnownedHouseBlips+1] = NewHouseBlip
    end)

    RegisterNetEvent('qb-houses:client:refreshBlips', function() -- Refresh unowned on buy
        for k,v in pairs(UnownedHouseBlips) do RemoveBlip(v) end
        Wait(250)
        TriggerEvent('qb-houses:client:setupHouseBlips2')
        RemoveEnterances()
        CreateEnterances()
    end)

    -- View
    
    RegisterNetEvent('qb-houses:client:viewHouseReturn', function(houseprice, brokerfee, bankfee, taxes, firstname, lastname)
        SetViewCam(Config.Houses[ClosestHouse].coords.cam, Config.Houses[ClosestHouse].coords.cam.h, Config.Houses[ClosestHouse].coords.yaw)
        Wait(500)
        OpenContract(true)
        SendNUIMessage({
            type = "setupContract",
            firstname = firstname,
            lastname = lastname,
            street = Config.Houses[ClosestHouse].adress,
            houseprice = houseprice,
            brokerfee = brokerfee,
            bankfee = bankfee,
            taxes = taxes,
            totalprice = (houseprice + brokerfee + bankfee + taxes)
        })
    end)

    RegisterNetEvent('qb-houses:client:viewHouse', function()
        local houseCoords = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
        if CheckDistance(houseCoords, 1.5) then
            TriggerServerEvent('qb-houses:server:viewHouse', ClosestHouse)
        end
    end)

    -- POIs

    RegisterNetEvent('qb-houses:client:setLocation', function(data)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local coords = {x = pos.x, y = pos.y, z = pos.z}
        if IsInside then
            if HasHouseKey then
                if data.id == 'setstash' then
                    TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 1)
                elseif data.id == 'setoutfit' then
                    TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 2)
                elseif data.id == 'setlogout' then
                    TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 3)
                end
            else
                QBCore.Functions.Notify(Lang:t("error.not_owner"), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.not_in_house"), "error")
        end
    end)

    RegisterNetEvent('qb-houses:client:refreshLocations', function(house)
        if ClosestHouse == house then
            if IsInside then
                RemoveInsidePoints(house)
                CreateInsidePoints(house, POIOffsets)
            end
        end
    end)

    RegisterNetEvent('qb-houses:client:openStash', function(houseId)
        QBCore.Functions.TriggerCallback('qb-houses:server:getHouseOwner', function(result)
            exports.ox_inventory:openInventory('stash', {id = houseId})
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4)
        end, houseId)
    end)

    RegisterNetEvent('qb-houses:client:changeCharacter', function()
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(10)
        end
        exports['qb-interior']:DespawnInterior(HouseObj, function()
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.5)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            InOwnedHouse = false
            IsInside = false
            TriggerServerEvent('qb-houses:server:LogoutLocation')
        end)
    end)

    RegisterNetEvent('qb-houses:client:changeOutfit', function()
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
        TriggerEvent('raid_clothes:outfitsMenu')
    end)

    -- Police Raid

    RegisterNetEvent('qb-houses:client:homeInvasion', function()
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        if ClosestHouse ~= nil then
            QBCore.Functions.TriggerCallback('police:server:IsPoliceForcePresent', function(IsPresent)
                if IsPresent then
                    local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
                    if Config.Houses[ClosestHouse].IsRaming == nil then
                        Config.Houses[ClosestHouse].IsRaming = false
                    end
                    if dist < 1 then
                        if Config.Houses[ClosestHouse].locked then
                            if not Config.Houses[ClosestHouse].IsRaming then
                                TriggerServerEvent('qb-houses:server:SetRamState', true, ClosestHouse)
                                RamAnim(true)
                                -- local Skillbar = exports["skillcheck"]:StartCheck(5, 3)
                                local Skillbar = lib.skillCheck({'easy', 'easy', 'easy'})
                                if Skillbar then
                                    TriggerServerEvent('qb-houses:server:lockHouse', false, ClosestHouse)
                                    QBCore.Functions.Notify(Lang:t("success.home_invasion"), 'success')
                                    TriggerServerEvent('qb-houses:server:SetHouseRammed', true, ClosestHouse)
                                    TriggerServerEvent('qb-houses:server:SetRamState', false, ClosestHouse)
                                    RamAnim(false)
                                else
                                    TriggerServerEvent('qb-houses:server:SetRamState', false, ClosestHouse)
                                    QBCore.Functions.Notify(Lang:t("error.failed_invasion"), 'error')
                                    RamAnim(false)
                                end
                            else
                                QBCore.Functions.Notify(Lang:t("error.inprogress_invasion"), 'error')
                            end
                        else
                            QBCore.Functions.Notify(Lang:t("error.already_open"), 'error')
                        end
                    else
                        QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
                    end
                else
                    QBCore.Functions.Notify(Lang:t("error.no_police"), 'error')
                end
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
        end
    end)

    RegisterNetEvent('qb-houses:client:setRamState', function(bool, house)
        Config.Houses[house].IsRaming = bool
        RemoveEnterances()
        CreateEnterances()
    end)

    RegisterNetEvent('qb-houses:client:setHouseRammed', function(bool, house)
        Config.Houses[house].IsRammed = bool
        RemoveEnterances()
        CreateEnterances()
    end)

    RegisterNetEvent('qb-houses:client:resetHouse', function()
        if ClosestHouse ~= nil then
            if Config.Houses[ClosestHouse].IsRammed == nil then
                Config.Houses[ClosestHouse].IsRammed = false
                TriggerServerEvent('qb-houses:server:SetHouseRammed', false, ClosestHouse)
                TriggerServerEvent('qb-houses:server:SetRamState', false, ClosestHouse)
            end
            if Config.Houses[ClosestHouse].IsRammed then
                OpenHouseAnim()
                TriggerServerEvent('qb-houses:server:SetHouseRammed', false, ClosestHouse)
                TriggerServerEvent('qb-houses:server:SetRamState', false, ClosestHouse)
                TriggerServerEvent('qb-houses:server:lockHouse', true, ClosestHouse)
                RamsDone = 0
                QBCore.Functions.Notify(Lang:t("success.lock_invasion"), 'success')
            else
                QBCore.Functions.Notify(Lang:t("error.no_invasion"), 'error')
            end
        end
    end)

    -- Util

    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        TriggerServerEvent('qb-houses:server:setHouses')
        SetClosestHouse()
        TriggerEvent('qb-houses:client:setupHouseBlips')
        if Config.UnownedBlips then TriggerEvent('qb-houses:client:setupHouseBlips2') end
        Wait(100)
        TriggerEvent('qb-garages:client:setHouseGarage', ClosestHouse, HasHouseKey)
        TriggerServerEvent("qb-houses:server:setHouses")
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        if ClosestHouse then
            RemoveInsidePoints(ClosestHouse)
        end
        IsInside = false
        ClosestHouse = nil
        HasHouseKey = false
        isOwned = false
        for k, v in pairs(OwnedHouseBlips) do
            RemoveBlip(v)
        end
        if Config.UnownedBlips then
            for k,v in pairs(UnownedHouseBlips) do
                RemoveBlip(v)
            end
        end
    end)

    RegisterNetEvent('qb-houses:client:refreshHouse', function(data)
        Wait(100)
        SetClosestHouse()
    end)

    RegisterNetEvent('qb-houses:client:setClosestHouse', function()
        SetClosestHouse()
    end)

    RegisterNetEvent('qb-house:client:refreshHouseTargets', function ()
        RemoveEnterances()
        CreateEnterances()
    end)

-- Exports

    exports('isNearHouses', isNearHouses)

-- NUI Callbacks

    RegisterNUICallback('HasEnoughMoney', function(data, cb)
        QBCore.Functions.TriggerCallback('qb-houses:server:HasEnoughMoney', function(hasEnough)
        end, data.objectData)
    end)

    RegisterNUICallback('buy', function()
        OpenContract(false)
        DisableViewCam()
        Config.Houses[ClosestHouse].owned = true
        if Config.UnownedBlips then TriggerEvent('qb-houses:client:refreshBlips') end
        TriggerServerEvent('qb-houses:server:buyHouse', ClosestHouse)
    end)
    
    RegisterNUICallback('exit', function()
        OpenContract(false)
        DisableViewCam()
    end)

-- Threads

CreateThread(function ()
    local wait = 500
    while not LocalPlayer.state.isLoggedIn do
        -- do nothing
        Wait(wait)
    end
    TriggerEvent('qb-houses:client:setupHouseBlips')
    if Config.UnownedBlips then
        TriggerEvent('qb-houses:client:setupHouseBlips2')
    end
    Wait(wait)
    TriggerEvent('qb-garages:client:setHouseGarage', ClosestHouse, HasHouseKey)
    if not Config.Houses[1] then
        TriggerServerEvent("qb-houses:server:setHouses")
    end

    while true do
        if not IsInside then
            SetClosestHouse()
        end
        Wait(500)
    end
end)