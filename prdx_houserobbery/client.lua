local QBCore = exports['qb-core']:GetCoreObject()
local inside, CurrentHouse, layerJob = false,nil,nil
local CurrentCops = 0
local CurrentMission = nil
local houseObj = {}
local POIOffsets = {}
local openingDoor = false
local JobBlip = nil
-- Functions --

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

function PoliceCall()
	local data = exports['cd_dispatch']:GetPlayerInfo()
	TriggerServerEvent('cd_dispatch:AddNotification', {
		job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'}, --{'police', 'sheriff} 
		coords = data.coords,
		title = '10-43 - Residental Alarm',
		message = 'A '..data.sex..' was reported breaking into a house at '..data.street, 
		flash = 0, 
		unique_id = tostring(math.random(0000000,9999999)),
		blip = {
			sprite = 40, 
			scale = 1.2, 
			colour = 47,
			flashes = true, 
			text = '10-43 - Residental Alarm',
			sound = 1,
		}
	})
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function openHouseAnim()
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

local function enterRobberyHouse(house)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    Wait(250)
    DoScreenFadeOut(250)
    local coords = { x = Config.Houses[house]["coords"]["x"], y = Config.Houses[house]["coords"]["y"], z= Config.Houses[house]["coords"]["z"] - Config.MinZOffset}
    local data
    if Config.Houses[house]["tier"] == 1 then
        data = exports['qb-interior']:CreateHouseRobbery(coords)
    end
    Wait(500)
	TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999}) -- Set time to night (activate lights), and weather to clear
    TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
    Wait(100)
    houseObj = data[1]
    POIOffsets = data[2]
    inside = true
    CurrentHouse = house
    DoScreenFadeIn(250)
end

local function leaveRobberyHouse(house)
    local ped = PlayerPedId()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    Wait(250)
    DoScreenFadeOut(250)
    Wait(500)
    exports['qb-interior']:DespawnInterior(houseObj, function()
        TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
        TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
        Wait(250)
        DoScreenFadeIn(250)
        SetEntityCoords(ped, Config.Houses[house]["coords"]["x"], Config.Houses[house]["coords"]["y"], Config.Houses[house]["coords"]["z"] + 0.5)
        SetEntityHeading(ped, Config.Houses[house]["coords"]["h"])
        inside = false
        CurrentHouse = nil
    end)
end

local function LockpickDoorAnim()
    openingDoor = true
    CreateThread(function()
        while true do
            if openingDoor then
                if HasAnimDictLoaded('veh@break_in@0h@p_m_one@') then
                    TaskPlayAnim(PlayerPedId(), 'veh@break_in@0h@p_m_one@', 'low_force_entry_ds', 1.0, -1.0, 1000, 49, 1, false, false, false)
                    Wait(650)
                else
                    RequestAnimDict('veh@break_in@0h@p_m_one@')
                end
            else
                StopAnimTask(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
                break
            end
            Wait(1000)
        end
    end)
end

local function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

local function searchFurniture(cabin)
    local ped = PlayerPedId()
    LockpickDoorAnim()
    TriggerServerEvent('prdx_houserobbery:server:SetBusyState', cabin, CurrentHouse, true)
    IsLockpicking = true
    -- local Skillbar = exports["skillcheck"]:StartCheck(3, 5)
    local Skillbar = lib.skillCheck({'easy', 'easy', 'medium', 'easy', 'easy'})
    if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
        local pos = GetEntityCoords(PlayerPedId())
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    openingDoor = false
    ClearPedTasks(PlayerPedId())
    if Skillbar then
        TriggerServerEvent('prdx_houserobbery:server:searchFurniture', cabin, CurrentHouse)
        Config.Houses[CurrentHouse]["furniture"][cabin]["searched"] = true
    end
    TriggerServerEvent('prdx_houserobbery:server:SetBusyState', cabin, CurrentHouse, false)
    SetTimeout(500, function()
        IsLockpicking = false
    end)
end

local function lockpickFinish(success)
    openingDoor = false
    if success then
        if closestHouse then
            TriggerServerEvent('prdx_houserobbery:server:enterHouse', closestHouse)
        end
        QBCore.Functions.Notify('Success!', "success", 2500)
    else
        QBCore.Functions.Notify('Failed!', "error", 2500)
    end
    if math.random(1, 100) <= 15 and CurrentMission then
        PoliceCall()
        if not IsWearingHandshoes() then
            local pos = GetEntityCoords(PlayerPedId())
            TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
        end
    end
end

-- Events --

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
    QBCore.Functions.TriggerCallback('prdx_houserobbery:server:GetHouseConfig', function(HouseConfig)
        Config.Houses = HouseConfig
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo.name
end)

RegisterNetEvent('prdx_houserobbery:client:TimerUp', function()
    CurrentMission = nil
    if JobBlip then
        RemoveBlip(JobBlip)
        TriggerServerEvent('prdx_houserobbery:server:resetHouse', CurrentHouse)
        CurrentHouse = nil
    end
end)

RegisterNetEvent('prdx_houserobbery:client:GotJob', function(coords, houseID)
    CurrentHouse = houseID
    CurrentMission = coords
    JobBlip = AddBlipForCoord(coords)
    SetBlipAsShortRange(JobBlip, true)
    SetBlipSprite(JobBlip, 586)
    SetBlipColour(JobBlip, 81)
    SetBlipScale(JobBlip, 1.5)
    SetBlipDisplay(JobBlip, 6)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Emailed Location")
    EndTextCommandSetBlipName(JobBlip)
end)

RegisterNetEvent('prdx_houserobbery:client:enterHouse', function(house)
    enterRobberyHouse(house)
end)

RegisterNetEvent('prdx_houserobbery:client:setHouseState', function(house, state)
    Config.Houses[house]["opened"] = state
    if state == false then
        if CurrentHouse and inside then
            leaveRobberyHouse(CurrentHouse)
        end
        inside = false
        CurrentMission = nil
    end
end)

RegisterNetEvent('prdx_houserobbery:client:setCabinState', function(house, cabin, state)
    Config.Houses[house]["furniture"][cabin]["searched"] = state
end)

RegisterNetEvent('prdx_houserobbery:client:SetBusyState', function(cabin, house, bool)
    Config.Houses[house]["furniture"][cabin]["isBusy"] = bool
end)

RegisterNetEvent('lockpicks:UseLockpick', function(isAdvanced)
    local hours = GetClockHours()
    if CurrentCops < Config.MinimumHouseRobberyPolice and CurrentMission then
        QBCore.Functions.Notify('There sounds like there is someone inside; try again later!', 'error')
        return
    end
    if hours >= Config.MinimumTime or hours <= Config.MaximumTime and CurrentMission and closestHouse then
        LockpickDoorAnim()
        if isAdvanced then
            -- lockpickFinish(exports["skillcheck"]:StartCheck(3, 3))
            lockpickFinish(lib.skillCheck({'easy', 'easy', 'medium', 'easy', 'easy'}))
        else
            -- lockpickFinish(exports["skillcheck"]:StartCheck(2, 5))
            lockpickFinish(lib.skillCheck({'easy', 'medium', 'medium', 'medium', 'easy'}))
        end
    elseif CurrentMission then
        QBCore.Functions.Notify('It\'s too bright out to be doing this...', 'error')
    end
end)

-- Thread --
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        if inside then
            if #(pos - vector3(Config.Houses[CurrentHouse]["coords"]["x"] + POIOffsets.exit.x, Config.Houses[CurrentHouse]["coords"]["y"] + POIOffsets.exit.y, Config.Houses[CurrentHouse]["coords"]["z"] - Config.MinZOffset + POIOffsets.exit.z)) < 1.5 then
                DrawText3Ds(Config.Houses[CurrentHouse]["coords"]["x"] + POIOffsets.exit.x, Config.Houses[CurrentHouse]["coords"]["y"] + POIOffsets.exit.y, Config.Houses[CurrentHouse]["coords"]["z"] - Config.MinZOffset + POIOffsets.exit.z, '~g~E~w~ - To leave home')
                if IsControlJustPressed(0, 38) then
                    leaveRobberyHouse(CurrentHouse)
                end
            end

            for k, _ in pairs(Config.Houses[CurrentHouse]["furniture"]) do
                if #(pos - vector3(Config.Houses[CurrentHouse]["coords"]["x"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["x"], Config.Houses[CurrentHouse]["coords"]["y"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["y"], Config.Houses[CurrentHouse]["coords"]["z"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["z"] - Config.MinZOffset)) < 1 then
                    if not Config.Houses[CurrentHouse]["furniture"][k]["searched"] then
                        if not Config.Houses[CurrentHouse]["furniture"][k]["isBusy"] then
                            DrawText3Ds(Config.Houses[CurrentHouse]["coords"]["x"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["x"], Config.Houses[CurrentHouse]["coords"]["y"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["y"], Config.Houses[CurrentHouse]["coords"]["z"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["z"] - Config.MinZOffset, '~g~E~w~ - '..Config.Houses[CurrentHouse]["furniture"][k]["text"])
                            if not IsLockpicking then
                                if IsControlJustReleased(0, 38) then
                                    searchFurniture(k)
                                end
                            end
                        else
                            DrawText3Ds(Config.Houses[CurrentHouse]["coords"]["x"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["x"], Config.Houses[CurrentHouse]["coords"]["y"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["y"], Config.Houses[CurrentHouse]["coords"]["z"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["z"] - Config.MinZOffset, 'Searching..')
                        end
                    else
                        DrawText3Ds(Config.Houses[CurrentHouse]["coords"]["x"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["x"], Config.Houses[CurrentHouse]["coords"]["y"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["y"], Config.Houses[CurrentHouse]["coords"]["z"] + Config.Houses[CurrentHouse]["furniture"][k]["coords"]["z"] - Config.MinZOffset, 'Empty..')
                    end
                end
            end
        end

        if not inside then
            Wait(5000)
        end
        Wait(3)
    end
end)

CreateThread(function()
    Wait(5000)
    while true do
        inRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        closestHouse = nil
        if QBCore ~= nil then
            local hours = GetClockHours()
            if hours >= Config.MinimumTime or hours <= Config.MaximumTime then
                if not inside then
                    for k, _ in pairs(Config.Houses) do
                        local dist = #(PlayerPos - vector3(Config.Houses[k]["coords"]["x"], Config.Houses[k]["coords"]["y"], Config.Houses[k]["coords"]["z"]))
                        if dist <= 1.5 then
                            closestHouse = k
                            inRange = true
                            if Config.Houses[k]["opened"] then
                                DrawText3Ds(Config.Houses[k]["coords"]["x"], Config.Houses[k]["coords"]["y"], Config.Houses[k]["coords"]["z"], '~g~E~w~ - To Enter')
                                if IsControlJustPressed(0, 38) then
                                    enterRobberyHouse(k)
                                end
                            end
                        end
                    end
                end
            end
            if inside then Wait(1500) end
            if not inRange then Wait(1000) end
        end
        Wait(5)
    end
end)
