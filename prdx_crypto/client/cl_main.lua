QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('prdx_crypto:client:confirmPublicDecypt', function()
    local CryptoMenu = {
        {
            title = "Start Decryption", 
            icon = 'check',
            colorScheme = '#37b24d',
            event = 'prdx_crypto:client:startPublicDecypt'
        },
        {
            title = "Cancel", 
            icon = 'ban',
            colorScheme = '#fa5252'
    
        },
    }
    lib.registerContext({
        id = 'crypto_confirm',
        title = 'Confirm Decryption',
        options = CryptoMenu,
    })
    lib.showContext('crypto_confirm')
end)

RegisterNetEvent('prdx_crypto:client:startPublicDecypt', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"type4"})
    local result = exports["blockmatch"]:StartHack(7, 2, 5, 30) -- Correct blocks, allowed incorrect blocks, time to show (s), time to lose (s)
    if result then
        QBCore.Functions.Notify('Successfully decrypted!', 'success')
        local data = {args = {'cryptosell', true}}
        TriggerServerEvent("inventory:server:sellStash", data)
    else
        QBCore.Functions.Notify('Decryption failed!', 'error')
        TriggerServerEvent('prdx_crypto:server:failedDecypt')
    end
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

RegisterNetEvent('prdx_crypto:client:confirmPrivateDecypt', function()
    local CryptoMenu = {
        {
            title = "Start Decryption", 
            icon = 'check',
            colorScheme = '#37b24d',
            args = {'cryptoprivatesell', true},
            serverEvent = 'inventory:server:sellStash',
        },
        {
            title = "Cancel", 
            icon = 'ban',
            colorScheme = '#fa5252'
        },
    }
    lib.registerContext({
        id = 'crypto_confirm_priv',
        title = 'Confirm Decryption',
        options = CryptoMenu,
    })
    lib.showContext('crypto_confirm_priv')
end)