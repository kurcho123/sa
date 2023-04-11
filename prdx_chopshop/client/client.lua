local QBCore = exports['qb-core']:GetCoreObject()
local ContractCar
local Cooldown = false

local function getVehName(model)
    return QBCore.Shared.Vehicles[model]["name"]
end

local function getVehBrand(model)
    return QBCore.Shared.Vehicles[model]["brand"]
end 

RegisterNetEvent('prdx_chopshop:requestJob', function()
    if not Cooldown then
        Cooldown = true
        TriggerServerEvent('prdx_chopshop:server:JobRequested')
        QBCore.Functions.Notify('I\'ll send an email once something comes up!', 'inform', 7500)
        SetTimeout(Config.Timeout, function()
            Cooldown = false
        end)
    else
        QBCore.Functions.Notify('You can not pick and choose what you get. Go get the car I requested!', 'error', 7500)
    end
end)

RegisterNetEvent('prdx_chopshop:client:startMission', function(car)
    ContractCar = car
end)

RegisterNetEvent('prdx_chopshop:client:turnInCar', function()
    if ContractCar then
        local ped = cache.ped
        local vehicle = GetVehiclePedIsIn(ped, true)
        if joaat(ContractCar) == GetEntityModel(vehicle) then
            ContractCar = nil
            QBCore.Functions.DeleteVehicle(vehicle)
            TriggerServerEvent('prdx_chopshop:server:JobComplete', GetVehicleClass(vehicle))
            QBCore.Functions.Notify('Job complete', 'success', 7500)
        else
            QBCore.Functions.Notify('You seem to have the wrong car', 'error', 7500)
        end
    else
        QBCore.Functions.Notify('What are you lookin\' at?', 'error', 7500)
    end
end)