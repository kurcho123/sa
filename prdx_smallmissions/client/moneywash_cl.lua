local QBCore = exports['qb-core']:GetCoreObject()
local inArea = false

function Text3D(x, y, z, text)
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

function SetupMoneywash()
    QBCore.Functions.TriggerCallback('prdx_moneywash:server:requestSync', function(ConfigData)
        Config.Moneywash.Machines = ConfigData
        for k,v in ipairs(Config.Moneywash.Machines) do
            exports['qb-target']:AddBoxZone('Moneywash-'..k, vec3(v.coords.x, v.coords.y, v.coords.z), 1.5, 1.5, {
                name = 'Moneywash-'..k, 
                heading = v.coords.w,
                debugPoly = Config.Debug,
                minZ = v.coords.z-1.0,
                maxZ = v.coords.z+1.0,
                }, {
                options = {
                    { 
                        type = "client",
                        event = "prdx_moneywash:client:openMenu",
                        icon = "fas fa-money-bill-transfer",
                        label = 'Interact',
                        args = k,
                    }
                },
                distance = 2.5,
            })
        end
        exports['polyzonehelper']:AddBoxZone("MoneyWashZone", vector3(1138.16, -990.79, 46.11), 9.8, 8.6, {
            name = "MoneyWashZone",
            heading = 8.0,
            debugPoly = false,
        })      
    end)
end

function StartTimerThread()
    inArea = true
    CreateThread(function ()
        while inArea do
            Wait(0)
            for k,v in ipairs(Config.Moneywash.Machines) do
                if v.isBusy and not v.isDone and v.timestamp then
                    local time = (v.timestamp - GetNetworkTimeAccurate()) / 1000
                    local minutes = '00'
                    if time > 60 then
                        local minutes = math.floor(time/60)
                    end
                    if time > 0 then
                        local seconds = math.floor(time - (minutes * 60))
                        if seconds < 10 then
                            Text3D(v.coords.x, v.coords.y, v.coords.z, 'Timer: '..minutes..':0'..seconds)
                        else
                            Text3D(v.coords.x, v.coords.y, v.coords.z, 'Timer: '..minutes..':'..seconds)
                        end
                    else
                        Text3D(v.coords.x, v.coords.y, v.coords.z, 'COMPLETE')
                    end
                end
            end
        end
    end)   
end

AddEventHandler('polyzonehelper:enter', function(name)
    if name == "MoneyWashZone" then
        if not inArea then
            StartTimerThread()
        end
    end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if name == "MoneyWashZone" then
        inArea = false
    end
end)


AddEventHandler('prdx_moneywash:client:openMenu', function(data)
    if not Config.Moneywash.Machines[data.args] then return end
    local menu = {}
    if not Config.Moneywash.Machines[data.args].isDone then
        if not Config.Moneywash.Machines[data.args].isBusy then
            menu[#menu+1] = {
                title = "Open Machine", 
                event = "target:client:openStash",
                args = {'moneywashingmachine'..data.args, 'moneywashingmachine'..data.args}
            }
            menu[#menu+1] = {
                title = "Start Cleaning", 
                serverEvent = "prdx_moneywash:server:startWashing",
                args = data.args
            }
        else
            if Config.Moneywash.Machines[data.args].timestamp and Config.Moneywash.Machines[data.args].timestamp - GetNetworkTimeAccurate() <= 0 then
                TriggerServerEvent('prdx_moneywash:server:checkComplete', data.args)
                menu[#menu+1] = {
                    title = "Collect Funds", 
                    serverEvent = "inventory:server:sellStash",
                    args = {'moneywashingmachine'..data.args, false}
                }
            else
                menu[#menu+1] = {
                    title = "Open Machine", 
                    description = 'Machine on | Door locked',
                    disabled = true
                }
                menu[#menu+1] = {
                    title = "Stop Machine", 
                    serverEvent = "prdx_moneywash:server:cancelWashing",
                    args = data.args
                }
            end
        end 
    else 
        menu[#menu+1] = {
            title = "Collect Funds", 
            serverEvent = "inventory:server:sellStash",
            args = {'moneywashingmachine'..data.args, true}
        }
    end
    lib.registerContext({
        id = 'moneywash_menu',
        title = 'Wiwang Washing Machine',
        options = menu,
    })
    lib.showContext('moneywash_menu')
end)

RegisterNetEvent('prdx_moneywash:client:syncMachines', function(ConfigData)
    Config.Moneywash.Machines = ConfigData
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    SetupMoneywash()
end)

-- This is to make sure the peds spawn on restart too instead of only when you load/log-in.
AddEventHandler('onResourceStart', function(resource)
    Wait(500)
	if resource == GetCurrentResourceName() and LocalPlayer.state.isLoggedIn then
		SetupMoneywash()
	end
end)