local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData() -- Just for resource restart (same as event handler)
local radioMenu = false
local onRadio = false
local RadioChannel = 0
local RadioVolume = 50

-- Functions

function connecttoradio(channel)
    RadioChannel = tonumber(channel)
    if onRadio then
        exports["pma-voice"]:setRadioChannel(0)
    else
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
    end
    exports["pma-voice"]:setRadioChannel(channel)
    local data = {
        Status = 'on',
        Frequency = 0
    }
    if Config.PresetChannels[channel] then
        newChannel = Config.PresetChannels[newChannel]
    end
    if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        data.Frequency = channel.. ' MHz'
        if Config.PresetChannels[channel] then
            QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..Config.PresetChannels[channel], 'success')
        else
            QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
        end
    else
        data.Frequency = channel.. '.00 MHz'
        if Config.PresetChannels[channel] then
            QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..Config.PresetChannels[channel], 'success')
        else
            QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
        end
    end

    TriggerServerEvent('qb-radio:server:updateRadioMetadata', data)
end

function leaveradio()
    closeEvent()
	RadioChannel = 0
    onRadio = false
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    QBCore.Functions.Notify(Config.messages['you_leave'] , 'error')
    local data = {
        Status = 'off'
    }
    TriggerServerEvent('qb-radio:server:updateRadioMetadata', data)
end

function SplitStr(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function IsRadioOn()
    return onRadio
end

local function DoRadioCheck(PlayerItems)
    local _hasRadio = false

    for _, item in pairs(PlayerItems) do
        if item.name == "radio" then
            _hasRadio = true
            break;
        end
    end

    hasRadio = _hasRadio
end

-- Exports
exports("IsRadioOn", IsRadioOn)
exports("ConnectToRadio", connecttoradio)

-- Events

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    DoRadioCheck(PlayerData.items)
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DoRadioCheck({})
    PlayerData = {}
    leaveradio()
end)

-- Handles state when PlayerData is changed. We're just looking for inventory updates.
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    DoRadioCheck(PlayerData.items)
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        PlayerData = QBCore.Functions.GetPlayerData()
        DoRadioCheck(PlayerData.items)
    end
end)

RegisterNetEvent('qb-radio:use', function()
    toggleRadio(not radioMenu)
end)

RegisterNetEvent('qb-radio:onRadioDrop', function()
    if RadioChannel ~= 0 then
        leaveradio()
    end
end)

-- NUI

RegisterNUICallback('joinRadio', function(data, cb)
    local rchannel = tonumber(data.channel)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] then
                        connecttoradio(rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
    cb("ok")
end)


function LoadAnimDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

function toggleRadioAnimation(pState)
	LoadAnimDic("cellphone@")
	
	if pState then
		TriggerEvent("attachItemRadio","radio01")
		TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
		radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
	else
		StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
		ClearPedTasks(PlayerPedId())
		if radioProp ~= 0 then
			DeleteObject(radioProp)
			radioProp = 0
		end
	end
end

function closeEvent()
	TriggerEvent("InteractSound_CL:PlayOnOne","click",0.6)
end

function toggleRadio(toggle)
    radioMenu = toggle
    SetNuiFocus(radioMenu, radioMenu)
    if radioMenu then
		toggleRadioAnimation(true)
        SendNUIMessage({type = "open"})
    else
		toggleRadioAnimation(false)
        SendNUIMessage({type = "close"})
    end
end

RegisterNUICallback('leaveRadio', function(data, cb)
    if RadioChannel == 0 then
        QBCore.Functions.Notify(Config.messages['not_on_radio'], 'error')
    else
        leaveradio()
    end
end)

RegisterNUICallback("volumeUp", function()
	if RadioVolume <= 95 then
		RadioVolume = RadioVolume + 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["decrease_radio_volume"], "error")
	end
end)

RegisterNUICallback("volumeDown", function()
	if RadioVolume >= 10 then
		RadioVolume = RadioVolume - 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["increase_radio_volume"], "error")
	end
end)

RegisterNUICallback("increaseradiochannel", function(data, cb)
    if not onRadio then return end
    local newChannel = RadioChannel + 1
    local data = {
        Status = 'on',
        Frequency = newChannel
    }
    if Config.RestrictedChannels[newChannel] ~= nil then
        if not Config.RestrictedChannels[newChannel][PlayerData.job.name] then
            QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
            return
        end
    end
    TriggerServerEvent('qb-radio:server:updateRadioMetadata', data)
	exports["pma-voice"]:setRadioChannel(newChannel)
    if Config.PresetChannels[newChannel] then
        newChannel = Config.PresetChannels[newChannel]
    end
	QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
end)

RegisterNUICallback("decreaseradiochannel", function(data, cb)
    if not onRadio then return end
    local newChannel = RadioChannel - 1
    local data = {
        Status = 'on',
        Frequency = newChannel
    }
    TriggerServerEvent('qb-radio:server:updateRadioMetadata', data)
    if newChannel >= 1 then
        if Config.RestrictedChannels[newChannel] ~= nil then
            if not Config.RestrictedChannels[newChannel][PlayerData.job.name] then
                QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                return
            end
        end
		exports["pma-voice"]:setRadioChannel(newChannel)
        if Config.PresetChannels[newChannel] then
            newChannel = Config.PresetChannels[newChannel]
        end
		QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
    end
end)

RegisterNUICallback('poweredOff', function(data, cb)
	leaveradio()
end)

RegisterNUICallback('escape', function(data, cb)
    toggleRadio(false)
end)

--Main Thread
CreateThread(function()
    while true do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn and onRadio then
            if not hasRadio then
                if RadioChannel ~= 0 then
                    leaveradio()
                end
            end
        end
    end
end)

-- KEYSWITCHER --
CreateThread(function()
    while true do
        ::return_loop::
        Wait(0)
        if not LocalPlayer.state.isLoggedIn or not onRadio then
            Wait(5000)
            goto return_loop
        end
        if IsDisabledControlPressed(0, 21) and IsDisabledControlJustReleased(0, 172) then -- Shift + Up Arrow
            local newChannel = tonumber(RadioChannel) + 1
            print(newChannel)
            local data = {
                Status = 'on',
                Frequency = newChannel
            }
            if Config.RestrictedChannels[newChannel] ~= nil then
                if not Config.RestrictedChannels[newChannel][PlayerData.job.name] then
                    QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    goto return_loop
                end
            end
            RadioChannel = newChannel
            exports["pma-voice"]:setRadioChannel(newChannel)
            if Config.PresetChannels[newChannel] then
                newChannel = Config.PresetChannels[newChannel]
            end
            local random = math.random(1,3)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", 'radiostatic'..random, 0.75)
            QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
            TriggerServerEvent('qb-radio:server:updateRadioMetadata', data)
        elseif IsDisabledControlPressed(0, 21) and IsDisabledControlJustReleased(0, 173) then -- Shift + Down Arrow
            local newChannel = tonumber(RadioChannel) - 1
            if newChannel < 1 then
                newChannel = 1
            end
            local data = {
                Status = 'on',
                Frequency = newChannel
            }
            if newChannel >= 1 then
                if Config.RestrictedChannels[newChannel] ~= nil then
                    if not Config.RestrictedChannels[newChannel][PlayerData.job.name] then
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                        goto return_loop
                    end
                end
                RadioChannel = newChannel
                exports["pma-voice"]:setRadioChannel(newChannel)
                if Config.PresetChannels[newChannel] then
                    newChannel = Config.PresetChannels[newChannel]
                end
                local random = math.random(1,3)
                TriggerServerEvent("InteractSound_SV:PlayOnSource", 'radiostatic'..random, 0.75)
                QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
                TriggerServerEvent('qb-radio:server:updateRadioMetadata', data)
            end
        elseif IsDisabledControlPressed(0, 21) and IsDisabledControlJustReleased(0, 174) then -- Shift + Left Arrow
            if RadioVolume >= 10 then
                RadioVolume = RadioVolume - 5
                QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
                exports["pma-voice"]:setRadioVolume(RadioVolume)
            else
                QBCore.Functions.Notify(Config.messages["increase_radio_volume"], "error")
            end
        elseif IsDisabledControlPressed(0, 21) and IsDisabledControlJustReleased(0, 175) then -- Shift + Right Arrow
            if RadioVolume <= 95 then
                RadioVolume = RadioVolume + 5
                QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
                exports["pma-voice"]:setRadioVolume(RadioVolume)
            else
                QBCore.Functions.Notify(Config.messages["decrease_radio_volume"], "error")
            end
        end
    end
end)