if not lib then return end

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerData(key, value)
	PlayerData[key] = value
	OnPlayerData(key, value)
end

function client.hasHolster()
	if not PlayerData.loaded then return end

	local maleholsters = {
		[154] = 156,
		[158] = 157,
		[159] = 155,
		[160] = 155,
		[173] = 0,
		[177] = 178,
	}
	local femaleholsters = {
		[125] = 127,
		[129] = 128,
		[130] = 126,
		[131] = 126,
		[139] = 140,
	}

	local ped = cache.ped
	local femaleHash = joaat("mp_f_freemode_01")
	local maleHash = joaat("mp_m_freemode_01")
	local hasholster  = false

	local male = nil
    if GetEntityModel(ped) == maleHash then -- mp male
        male = true
    elseif GetEntityModel(ped) == femaleHash then -- mp female
        male = false
    end

	-- Checking if we have a valid holster
	local holstertype = GetPedDrawableVariation(ped, 7)
	if male == true then -- mp male
		if maleholsters[holstertype] then
			hasholster = true
		else
			hasholster = false
		end
	elseif male == false then -- mp female
		if femaleholsters[holstertype] then
			hasholster = true
		else
			hasholster = false
		end
	end

	return hasholster
end

function client.hasGroup(group)
	if not PlayerData.loaded then return end

	if type(group) == 'table' then
		for name, rank in pairs(group) do
			local groupRank = PlayerData.groups[name]
			if groupRank and groupRank >= (rank or 0) then
				return name, groupRank
			end
		end
	else
		local groupRank = PlayerData.groups[group]
		if groupRank then
			return group, groupRank
		end
	end
end

local Shops = require 'modules.shops.client'
local Utils = require 'modules.utils.client'
local Weapon = require 'modules.weapon.client'

function client.onLogout()
	if not PlayerData.loaded then return end

	if client.parachute then
		Utils.DeleteEntity(client.parachute)
		client.parachute = false
	end

	for _, point in pairs(client.drops) do
		if point.entity then
			Utils.DeleteEntity(point.entity)
		end

		point:remove()
	end

	PlayerData.loaded = false
	client.drops = nil

	client.closeInventory()
	Shops.wipeShops()
	ClearInterval(client.interval)
	ClearInterval(client.tick)
	Weapon.Disarm()
end

local scriptPath = ('modules/bridge/%s/client.lua'):format(shared.framework)
local resourceFile = LoadResourceFile(cache.resource, scriptPath)

if not resourceFile then
	lib = nil
	return error(("Unable to find framework bridge for '%s'"):format(shared.framework))
end

local func, err = load(resourceFile, ('@@%s/%s'):format(cache.resource, scriptPath))

if not func or err then
	lib = nil
	return error(err)
end

func(client.onLogout, client.weapon)
