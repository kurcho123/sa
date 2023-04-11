local AudioLoaded = false
local InteriorIDs = {}
QBCore = exports['qb-core']:GetCoreObject()

Config.SerenityInteriors = {
    vector3(453.87, -983.41, 25.75), -- MRPD
    vector3(372.83, -1597.92, 32.13), -- Davis PD
    vector3(204.17, -1650.75, 30.61), -- Davis Fire
    vector3(1201.57, -1471.01, 35.27), -- Fire HQ
    vector3(-579.65, -1055.59, 22.34), -- G&G
    vector3(1854.33, 3684.59, 35.05), -- Sandy PD
    vector3(1834.99, 3676.17, 35.05), -- Sandy Med
    vector3(1778.55, 2552.33, 45.39), -- Prison Cafeteria
    vector3(1839.88, 2586.59, 46.35), -- Prison Reception
    vector3(1764.91, 2569.87, 46.35), -- Prison Infirm
	vector3(-104.64, 989.7, 235.75), -- Collective house
	vector3(-930.27, -2047.07, 9.51), -- New dealer
}

for k,v in ipairs(Config.SerenityInteriors) do
	local interior = tonumber(GetInteriorAtCoords(v))
	InteriorIDs[interior] = true
end

CreateThread(function()
	Wait(5000) -- DELAY STARTUP
	while true do
		local interior = GetInteriorFromEntity(cache.ped)
		local sleep = 1000
		if interior and interior ~= 0 then
			if InteriorIDs[interior] then
				if not AudioLoaded then
					AudioLoaded = true
					StartAudioScene("DLC_HEIST_PACIFIC_BANK_HACK_PASSWORD_SCENE")
				else
					sleep = 50
				end
			end
		elseif AudioLoaded then
			AudioLoaded = false
			StopAudioScenes()
		end
		Wait(sleep)
	end
end)