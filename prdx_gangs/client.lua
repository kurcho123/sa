QBCore = exports['qb-core']:GetCoreObject()
local PlayerGang = {}

CreateThread(function() -- Live reboot
    if not GangConfig.Enabled then return end
    if not LocalPlayer.state['isLoggedIn'] or Started then return end
    PlayerGang = QBCore.Functions.GetPlayerData().gang
    Wait(1000)
    SetupStorage()
    SetupClothing()
    SetupBossMenus()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    if not GangConfig.Enabled then return end
    PlayerGang = QBCore.Functions.GetPlayerData().gang
    Wait(1000)
    SetupStorage()
    SetupClothing()
    SetupBossMenus()
end)

function SetupStorage()
    for k,v in pairs(GangConfig.Storage) do
        for i=1, #v do
            exports.ox_target:addBoxZone({
                coords  = v[i].location,
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ), 
                rotation = v[i].heading,
                debug = GangConfig.Debug,
                options = {
                    {
                        event = "prdx_gangs:storage",
                        icon = 'fas fa-box',
                        label = "Open Storage",
                        stash = v[i].stashName,
                        groups = k,
                        distance = 3.5,
                    },
                },
            })
        end
    end
end

function SetupClothing()
    for k,v in pairs(GangConfig.Clothing) do
        for i=1, #v do
            exports.ox_target:addBoxZone({
                coords  = v[i].location,
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ), 
                rotation = v[i].heading,
                debug = GangConfig.Debug,
                options = {
                    {
                        event = 'prdx_gangs:clothing',
                        icon = 'fas fa-tshirt',
                        label = "Open Clothing",
                        distance = 3.5,
                    },
                },
            })
        end
    end
end

function SetupBossMenus()
    for k,v in pairs(GangConfig.BossMenu) do
        for i=1, #v do
            exports.ox_target:addBoxZone({
                coords  = v[i].location,
                size = vec3(v[i].width, v[i].length, v[i].maxZ - v[i].minZ), 
                rotation = v[i].heading,
                debug = GangConfig.Debug,
                options = {
                    {
                        event = 'prdx_bossmenu:client:openMenu',
                        icon = 'fas fa-users',
                        label = "Boss Actions",
                        distance = 3.5,
                        groups = k
                    },
                },
            })
        end
    end
end

-- Open clothing
AddEventHandler("prdx_gangs:clothing", function(data)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
    TriggerEvent('raid_clothes:outfitsMenu')
end)

-- Open storage
AddEventHandler("prdx_gangs:storage", function(data)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "LockerOpen", 0.4)
    exports.ox_inventory:openInventory('stash', {id = data.stash, owner = PlayerGang.name})
end)