local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
        PlayerJob = QBCore.Functions.GetPlayerData().job
    end
end)

RegisterNetEvent('prdx_realty:client:openMenu', function()
    QBCore.Functions.Notify('Loading...', 'info', 6000)
    QBCore.Functions.TriggerCallback('qb-houses:server:getHouses', function(available, sold)
        local properties = {
            available = {},
            sold = {}
        }
        for k,v in pairs(available) do
            properties.available[#properties.available+1] = {
                id = k,
                address = v.label,
                price = v.price,
                tier = v.tier
            }
        end

        for k,v in pairs(sold) do
            if v.house then
                properties.sold[#properties.sold+1] = {
                    id = k,
                    address = available[v.house].label,
                    owner = v.owner .. string.format(" (%s)", v.citizenid),
                    keyholders = v.keyholders
                }
            end
        end

        table.sort(properties.available, function(a, b)
            return a.address < b.address
        end)

        table.sort(properties.sold, function(a, b)
            return a.address < b.address
        end)
                    
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                ['showmenu'] = true,
                ['properties'] = properties
            }
        )
    end)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback("deleteProperty", function(data)
    TriggerServerEvent('qb-houses:server:deleteHouse', data.propertyId)
end)

RegisterNUICallback("transferProperty", function(data, cb)
    local house = {name = data.propertyId}
    QBCore.Functions.TriggerCallback("qb-phone:server:TransferCid", function(result, owner, keyholders)
        if result then
            cb({owner = owner .. " (" .. data.newOwner .. ")", keyholders = keyholders})
        end
    end, data.newOwner:upper(), house)
end)

RegisterNUICallback("setPropertyTier", function(data)
    TriggerServerEvent('qb-houses:server:setHouseTier', data.propertyId, data.newTier)
end)

RegisterNUICallback("setPropertyPrice", function(data)
    TriggerServerEvent('qb-houses:server:setHousePrice', data.propertyId, data.newPrice)
end)