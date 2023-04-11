QBCore = exports['qb-core']:GetCoreObject()
CurrentCops = 0

function PoliceCall(BankName, coords)
    local data = exports['cd_dispatch']:GetPlayerInfo()
	TriggerServerEvent('cd_dispatch:AddNotification', {
		job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'},
		coords = coords,
		title = '10-68a - Silent alarm: '.. BankName,
		message = 'Silent alarm triggered at '..data.street .. ' - ' .. BankName, 
		flash = 1, 
		unique_id = tostring(math.random(0000000,9999999)),
		blip = {
			sprite = 303, 
			scale = 1.5, 
			colour = 1,
			flashes = true, 
			text = '10-68 - Silent alarm: '.. BankName,
			sound = 2,
		}
	})    
end

function IsWearingHandshoes() -- Globally Used
    local armIndex = GetPedDrawableVariation(cache.ped, 3)
    local model = GetEntityModel(cache.ped)
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

RegisterNetEvent('prdx_heists:client:UpdateHeistState', function(heistID, state)
    Config.Heists[heistID]['active'] = state  
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

-- MAIN SETUP THREAD --
CreateThread(function()
    for id,data in ipairs(Config.Heists) do
        for doorID, doordata in ipairs(data["doors"]) do
            if doordata["isVaultDoor"] then
                createDoorZone(doordata["coords"], id, doorID)
            end
            if doordata['hack'] then
                SetupDoorHackZone(id, doorID, doordata['hack'])
            end
            Wait(0)
        end
    end
end)