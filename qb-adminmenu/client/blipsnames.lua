QBCore = exports['qb-core']:GetCoreObject()
local PlayerBlips = {}
local PlayerList = {}

local function CreatePlayerBlip(playerId, playerLabel, playerLocation)
    local ped = GetPlayerPed(playerId)
    local sprite = 1
    if NetworkIsPlayerActive(playerId) then
        blip = AddBlipForEntity(ped)
    else
        blip = AddBlipForCoord(playerLocation.x, playerLocation.y, playerLocation.z)
    end
    SetBlipSprite(blip, sprite)
    SetBlipCategory(blip, 7)
    ShowHeadingIndicatorOnBlip(blip, true)
    SetBlipRotation(blip, math.ceil(playerLocation.w))
    SetBlipScale(blip, 0.5)
    SetBlipColour(blip, 0)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(playerLabel)
    EndTextCommandSetBlipName(blip)
    PlayerBlips[#PlayerBlips+1] = blip
end

RegisterNetEvent('qb-admin:client:ClearAllBlips', function()
    if PlayerBlips then
        for k, v in pairs(PlayerBlips) do
            RemoveBlip(v)
        end
    end
end)

RegisterNetEvent('qb-admin:client:UpdateBlips', function(data)
    PlayerList = data
    if PlayerBlips then
        for k, v in pairs(PlayerBlips) do
            RemoveBlip(v)
        end
    end
    Wait(5)
    PlayerBlips = {}
    if PlayerList then
        for k, data in pairs(PlayerList) do
            local id = GetPlayerFromServerId(data.id)
            if id ~= PlayerId() then
                CreatePlayerBlip(id, data.name, data.coords)
            end
        end
    end
end)