-- Variables --
local inTelescope = false
local gameplayCamera = {}
local QBCore = exports['qb-core']:GetCoreObject()
local camera = nil
local scaleform = nil
local instScaleform = nil
local fov = Config.Zoom.Max

local maxLeft = 0
local maxRight = 0

-- Functions --
local function DisplayNativeNotification(msg)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostTicker(false, false)
end

local function DisplayNotification(msg)
	if Config.UseNativeNotifiactions then
		DisplayNativeNotification(msg)
	else
		QBCore.Functions.Notify(msg, 'error')
	end
end

local function DisplayHelpText(msg)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

local function SetupInstructions()
    instScaleform = RequestScaleformMovie("instructional_buttons")
    while not HasScaleformMovieLoaded(instScaleform) do
        Wait(10)
    end
    
    DrawScaleformMovieFullscreen(instScaleform, 255, 255, 255, 0, 0)
    
    PushScaleformMovieFunction(instScaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(instScaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(instScaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    ScaleformMovieMethodAddParamPlayerNameString("~INPUT_TALK~")
    BeginTextCommandScaleformString("STRING")
	AddTextComponentSubstringPlayerName("Exit Telescope")
	EndTextCommandScaleformString(0, 0, 1, -1)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(instScaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(instScaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
end

local function LoadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(10)
	end
end

local function GetDifference(num1, num2)
	if num1 > num2 then
		return num1 - num2
	else
		return num2 - num1
	end
end

local function RotationToHeading(rotation)
    local heading = rotation
    if heading < 0 then 
        heading = heading*-1 
        heading = heading + GetDifference(heading, 180.0)*2
    end
    return heading
end

local function HeadingToRotation(heading)
    local rotation = heading
    if rotation > 180.0 then
        rotation = 180.0 - GetDifference(rotation, 180.0)
        rotation = rotation*-1 
    end
    return rotation
end

local function CreateTelescopeCamera(entity, data)
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    local coords = GetOffsetFromEntityInWorldCoords(entity, data.cameraOffset)
    local rotation = GetEntityRotation(entity, 5).z
    if data.headingOffset then
        rotation = rotation + data.headingOffset 
        if rotation > 360.0 then rotation = rotation - 360.0 end
    end

    SetCamCoord(camera, coords.x, coords.y, coords.z)
    SetCamRot(camera, 0.0, 0.0, rotation, 2)

    SetExtraTimecycleModifier("telescope")

    scaleform = RequestScaleformMovie(data.scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(10)
    end
    local xres,yres = GetActiveScreenResolution()
    BeginScaleformMovieMethod(scaleform, "SET_DISPLAY_CONFIG")
    ScaleformMovieMethodAddParamInt(xres)
    ScaleformMovieMethodAddParamInt(yres)
    ScaleformMovieMethodAddParamInt(5) --_safeTopPercent
    ScaleformMovieMethodAddParamInt(5) --_safeBottomPercent
    ScaleformMovieMethodAddParamInt(5) --_safeLeftPercent
    ScaleformMovieMethodAddParamInt(5) --_safeRightPercent
    ScaleformMovieMethodAddParamBool(GetIsWidescreen())
    ScaleformMovieMethodAddParamBool(GetIsHidef())
    ScaleformMovieMethodAddParamBool(false) --isAsian
    EndScaleformMovieMethod()

    RenderScriptCams(camera, 0, 0, false, false)
end

local function HideHudThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1) -- Wanted Stars
	HideHudComponentThisFrame(2) -- Weapon icon
	HideHudComponentThisFrame(3) -- Cash
	HideHudComponentThisFrame(4) -- MP CASH
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13) -- Cash Change
	HideHudComponentThisFrame(11) -- Floating Help Text
	HideHudComponentThisFrame(12) -- More floating help text
	HideHudComponentThisFrame(15) -- Subtitle Text
	HideHudComponentThisFrame(18) -- Game Stream
	HideHudComponentThisFrame(19) -- Weapon Wheel
end

-- EnumerateEntities made by IllidanS4
-- https://gist.github.com/IllidanS4/9865ed17f60576425369fc1da70259b2
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	local entityEnumerator = {
		__gc = function(enum)
			if enum.destructor and enum.handle then
				enum.destructor(enum.handle)
			end
			enum.destructor = nil
			enum.handle = nil
		end
	}
	
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
		
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
		
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

local function IsPedPlayingAnyTelescopeAnim(ped)
    for animType, animations in pairs(Config.Animations) do 
        for type, animation in pairs(animations) do 
            if type ~= "enterTime" and IsEntityPlayingAnim(ped, "mini@telescope", animation, 3) then
                return true
            end
        end
    end
    return false
end

local function IsTelescopeAvailable(coords)
	local playerPed = PlayerPedId()
    for ped in EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed) do
        if #(GetEntityCoords(ped)-coords) < 1.0 and ped ~= playerPed then
            if IsPedPlayingAnyTelescopeAnim(ped) then
			    return false
            end
        end
	end
    return true
end

local function HandleZoom()
	if GetDisabledControlNormal(0, 32) ~= 0.0 or GetDisabledControlNormal(0, 335) ~= 0.0 then -- Zoom in
        fov = math.max(fov - Config.Zoom.Speed, Config.Zoom.Min)
    end
    if GetDisabledControlNormal(0, 33) ~= 0.0 or GetDisabledControlNormal(0, 336) ~= 0.0 then -- Zoom out
        fov = math.min(fov + Config.Zoom.Speed, Config.Zoom.Max)
    end
    local current_fov = GetCamFov(camera)
    if math.abs(fov-current_fov) < 0.1 then
        fov = current_fov
    end
    SetCamFov(camera, current_fov + (fov - current_fov)*0.05)
end

local function HandleMovement(maxVertical)
    local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)

	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        local zoomValue = (1.0/(Config.Zoom.Max-Config.Zoom.Min))*(fov-Config.Zoom.Min)
        local rotation = GetCamRot(camera, 2)
        local heading = RotationToHeading(rotation.z)
        
        local movementSpeed = (IsUsingKeyboard(1) and Config.MovementSpeed.Keyboard) or Config.MovementSpeed.Controller
        local newX = math.max(math.min(maxVertical, rotation.x + rightAxisY*-1.0*(movementSpeed)*(zoomValue+0.1)), maxVertical*-1)
        local newZ = rotation.z

        if not (heading > maxLeft and rightAxisX < 0.0) and not (heading < maxRight and rightAxisX > 0.0) then
            newZ = rotation.z + rightAxisX*-1.0*(movementSpeed)*(zoomValue+0.1)
        end

		SetCamRot(camera, newX, 0.0, newZ, 2)
	end
end

local function GetClosestTelescope()
    local closest = 0
    local closestDist = Config.MaxDetectionDist
    local coords = GetEntityCoords(PlayerPedId())

    for model, data in pairs(Config.Models) do
        local entity = GetClosestObjectOfType(coords.x, coords.y, coords.z, Config.MaxDetectionDist, model, false, false, false)
        if entity ~= 0 then
            local entityCoords = GetEntityCoords(entity)
            local dist = #(coords-entityCoords)
            if dist < closestDist then
                closest = entity
                closestDist = dist
            end
        end
    end
   
    return closest
end

AddEventHandler('telescope:openTelescope', function(data)
    local entity = data.entity
    local playerPed = PlayerPedId()
    local data = Config.Models[GetEntityModel(entity)]
    local offsetCoords = GetOffsetFromEntityInWorldCoords(entity, data.offset)
    local animation = Config.Animations[data.animation]
    inTelescope = true

    if not IsTelescopeAvailable(offsetCoords) then
        DisplayNotification(Config.TelescopeInUse)
        return
    end

    local heading = GetEntityHeading(entity)
    if data.headingOffset then 
        heading = heading + data.headingOffset
        if heading > 360.0 then heading = heading - 360.0 end
    end

    TaskGoStraightToCoord(playerPed, offsetCoords, 1, 8000, heading, 0.05)

    while true do
        Wait(500)
        local taskStatus = GetScriptTaskStatus(playerPed, "SCRIPT_TASK_GO_STRAIGHT_TO_COORD") 
        if taskStatus == 0 or taskStatus == 7 then
            break
        end
    end

    ClearPedTasks(playerPed)
    local difference = GetDifference(heading, GetEntityHeading(playerPed))
    if difference > 10.0 then
        SetEntityHeading(playerPed, heading)
    end

    local dist = #(GetEntityCoords(playerPed)-offsetCoords)
    if dist > 0.3 and dist < 2.5 then
        SetEntityCoords(playerPed, vector3(offsetCoords.x, offsetCoords.y, offsetCoords.z-1.0))
    elseif dist > 2.5 then
        DisplayNotification(Config.ToFarAway)
        ClearPedTasks(playerPed)
        return
    end

    LoadAnimDict("mini@telescope")
    TaskPlayAnim(playerPed, "mini@telescope", animation.enter, 2.0, 2.0, -1, 2, 0, false, false, false)

    gameplayCamera.heading = GetGameplayCamRelativeHeading()
    gameplayCamera.pitch = GetGameplayCamRelativePitch()

    Wait(animation.enterTime)
    DoScreenFadeOut(500)
    Wait(600)

    TaskPlayAnim(playerPed, "mini@telescope", animation.idle, 2.0, 2.0, -1, 1, 0, false, false, false)
    CreateTelescopeCamera(entity, data)
    SetupInstructions()
    CreateThread(function()
        DoScreenFadeIn(500)
    end)

    local tick = 0
    local doAnim = true
    fov = Config.Zoom.Max

    maxLeft = heading+data.MaxHorizontal
    if maxLeft > 360.0 then maxLeft = maxLeft - 360.0 end

    maxRight = heading-data.MaxHorizontal
    if maxRight < 0.0 then maxRight = maxRight + 360.0 end
    TriggerEvent('hud:client:HideHud', true)
    while true do
        -- Handle the movement and button inputs every frame
        HandleZoom()
        HandleMovement(data.MaxVertical)

        if IsControlJustPressed(0, 46) then
            break
        end

        -- Only handle "less important" stuff every 100 frames
        if tick >= 100 then
            if #(GetEntityCoords(playerPed)-offsetCoords) > 2.0 or IsEntityDead(playerPed) then
                doAnim = false
                break
            end
            tick = 0
        end

        -- Draw the scaleform
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)

        -- Draw instructions
        DrawScaleformMovieFullscreen(instScaleform, 255, 255, 255, 255, 0)

        -- Hide hud
        HideHudThisFrame()

        tick = tick + 1
        Wait(0)
    end
    TriggerEvent('hud:client:HideHud', false)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        Wait(0)
    end
    Wait(150)

    RenderScriptCams(cam, 0, false, 0, false, false)
    DestroyCam(cam, 0)

    ClearExtraTimecycleModifier()
    SetScaleformMovieAsNoLongerNeeded(scaleform)
    SetScaleformMovieAsNoLongerNeeded(instScaleform)

    SetGameplayCamRelativeHeading(gameplayCamera.heading)
    SetGameplayCamRelativePitch(gameplayCamera.pitch, 1.0)

    DoScreenFadeIn(500)
    Wait(500)

    if doAnim then
        TaskPlayAnim(playerPed, "mini@telescope", animation.exit, 2.0, 1.0, -1, 0, 0, false, false, false)
        Wait(1500)
    else
        ClearPedTasks(playerPed)
    end
    inTelescope = false
    RemoveAnimDict("mini@telescope")
end)

CreateThread(function()
    local models = {}
    local index = 0
    for model, data in pairs(Config.Models) do
        index = index + 1
        models[index] = model
    end

    exports['qb-target']:AddTargetModel(models, {
        options = {
            {
                icon = Config.Targeting.Icon,
                label = Config.Targeting.Label,
                event = "telescope:openTelescope",
            }
        },
        distance = Config.MaxInteractionDist,
    })
    
end)

-- Help Text Thread --
if Config.UseDistanceThread then
    CreateThread(function()
        while true do
            local sleep = 500
            local coords = GetEntityCoords(PlayerPedId())
            local closest = 0
            local distance = 1000

            if not inTelescope then
                for index, data in pairs(Config.Telescopes) do
                    local dist = #(data.coords-coords)
                    if dist < distance then
                        closest = index
                        distance = dist
                    end
                end

                if closest ~= 0 then
                    if distance < Config.MaxInteractionDist then
                        sleep = 0
                        DisplayHelpText(Config.HelpText)
                        if IsControlJustPressed(0, 46) then
                            local telescope = GetClosestTelescope()
                            if telescope ~= 0 then
                                UseTelescope(telescope)
                            else
                                DisplayNotification(Config.NoFoundMessage)
                            end
                        end
                    else
                        sleep = distance*20
                    end
                end
            else
                sleep = 500
            end

            Wait(sleep)
        end
    end)
end
