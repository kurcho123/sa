local minutesToWait = 5

-- register when ready
Citizen.CreateThread(function()
	Citizen.Wait(0)
	TriggerServerEvent('scrp-idlogs:register')
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000 * 60 * minutesToWait)
		TriggerServerEvent('scrp-idlogs:updateTime', minutesToWait)
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	TriggerServerEvent('scrp-idlogs:register')
end)