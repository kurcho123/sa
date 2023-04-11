local appid = '832109810698551316' -- Make an application @ https://discordapp.com/developers/applications/ ID can be found there.
local PlayerData                = {}
local name = GetPlayerName(PlayerId())
local id = GetPlayerServerId(PlayerId())
local Players = 0

function SetRP()
    local name = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    SetDiscordAppId(appid)
    SetDiscordRichPresenceAsset(asset)
end


-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686

CreateThread(function()
    while true do
        --This is the Application ID (Replace this with you own)
        SetDiscordAppId(appid)
        --(11-11-2018) New Natives:

        --Here you will have to put the image name for the "large" icon.
        SetDiscordRichPresenceAsset('logo')

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Enjoying San Andreas')

        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('info')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('Join today to start your experience!')

        SetDiscordRichPresenceAction(0, "Website", "https://www.paradoxgaming.co/")
        SetDiscordRichPresenceAction(1, "Join", "fivem://connect/p59p6m")

        -- Players since 1S is borked
        local queue =  GetConvarInt('queueCountClient', 0)
        if queue ~= nil then
            if Players > 90 and queue > 2 then
                SetRichPresence('Players: ' .. Players .. "/" .. GetConvarInt('sv_maxclients', 100) .. ' [Queue: ' .. queue .. ']')
            else
                SetRichPresence('Players: ' .. Players .. "/" .. GetConvarInt('sv_maxclients', 100))
            end
        else
            SetRichPresence('Players: ' .. Players .. "/" .. GetConvarInt('sv_maxclients', 100))
        end
    	Wait(60000)
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('smallresources:server:SetPlayerPerms', GetPlayerServerId(PlayerId()))
end)

RegisterNetEvent('smallresources:client:SetCurrentPlayers', function(players)
    Players = players
end)