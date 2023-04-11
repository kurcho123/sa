
local isUiOpen = false

-- Functions

local function openGui(noteId, text)
    local veh = GetVehiclePedIsUsing(PlayerPedId())
    if GetPedInVehicleSeat(veh, -1) ~= PlayerPedId() then
        SetPlayerControl(PlayerId(), 0, 0)
        SendNUIMessage({
            action = 'openNotepad',
            id = noteId,
            text = text
        })
        isUiOpen = true
        SetNuiFocus(true, true);
    end
end

-- Events

RegisterNetEvent('qb-notepad:client:OpenNotepadGui', function(item, text)
    if not isUiOpen then
        openGui(item.metadata.noteId, text)
    end
end)

RegisterNetEvent('qb-notepad:client:CloseNotepad', function()
    SendNUIMessage({
        action = 'closeNotepad'
    })
    SetPlayerControl(PlayerId(), 1, 0)
    isUiOpen = false
    SetNuiFocus(false, false);
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    Wait(100)
end)

RegisterNetEvent('qb-notepad:client:note', function()
    local player = PlayerPedId()
    
    if (DoesEntityExist(player) and not IsEntityDead(player)) then
        TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
    end
end)

-- Callbacks

RegisterNUICallback('escape', function(data, cb)
    TriggerEvent('qb-notepad:client:CloseNotepad')
end)

RegisterNUICallback('updating', function(data, cb)
    local text = data.text
    local id = data.id
    TriggerServerEvent('qb-notepad:server:updateNote', id, text)
    TriggerEvent('qb-notepad:client:CloseNotepad')
end)