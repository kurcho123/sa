local CurrentCops = 0
local ATMS = {
    `prop_atm_01`,
    `prop_atm_02`,
    `prop_atm_03`,
    `prop_fleeca_atm`,
}

exports['qb-target']:AddTargetModel(ATMS,  {
    options = {
        {
            type = "client",
            event = "prdx_smallmissions:tryATMHack",
            icon = "fas fa-money-check",
            item = 'atm_usb',
            label = "Insert USB Device",
        },
    },
    distance = 1.5
})

local function PoliceCall()
    local data = exports['cd_dispatch']:GetPlayerInfo()
    TriggerServerEvent('cd_dispatch:AddNotification', {
        job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'}, --{'police', 'sheriff} 
        coords = data.coords,
        title = '10-17 - Suspicious Person',
        message = 'A suspicious '..data.sex..' was reported inserting a device into an ATM on '..data.street, 
        flash = 0, 
        unique_id = tostring(math.random(0000000,9999999)),
        blip = {
            sprite = 66, 
            scale = 1.2, 
            colour = 5,
            flashes = false, 
            text = '10-17 - Suspicious Person (ATM)',
            sound = 1,
        }
    }) 
end
 
RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

local clientCooldown = false
RegisterNetEvent('prdx_smallmissions:tryATMHack', function()
    if not clientCooldown then
        QBCore.Functions.TriggerCallback('RobberyTimer:CanStartRobbery', function(canStart)
            clientCooldown = true
            if canStart then
                TriggerEvent('prdx_smallmissions:startATMHack', src)
            else
                QBCore.Functions.Notify('ATM security in lockdown', 'error')
            end
            SetTimeout(15000, function ()
                clientCooldown = false
            end)
        end, 'ATMHack') 
    else
        QBCore.Functions.Notify('You are doing that too fast!', 'error')
    end
end)

RegisterNetEvent('prdx_smallmissions:startATMHack')
AddEventHandler('prdx_smallmissions:startATMHack', function()
    PoliceCall()
    TriggerEvent('animations:client:EmoteCommandStart', {"atm"})
    QBCore.Functions.Progressbar("atm_hack", "Inserting USB Device...", math.random(15000,20000), false, true, {disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        Wait(250)
        TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
        TriggerServerEvent('RobberyTimer:RobberyStarted', 'ATMHack')
        local pass = exports['hackgreen']:Begin(3, 3500)
        if pass then
            TriggerServerEvent('prdx_smallmissions:server:atmHackReward')
            QBCore.Functions.Notify('The ATM spews out dollars...', 'success')
        else
            QBCore.Functions.Notify('ATM security in lockdown', 'error')
        end
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)      

end)