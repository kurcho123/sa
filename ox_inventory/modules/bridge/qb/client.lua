local onLogout, Weapon = ...
QBCore = exports['qb-core']:GetCoreObject()
local Inventory = require 'modules.inventory.client'

RegisterNetEvent('QBCore:Client:OnPlayerUnload', onLogout)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
	if source == '' or not PlayerData.loaded then return end

	if data.metadata.isdead ~= PlayerData.dead then
		PlayerData.dead = data.metadata.isdead
		OnPlayerData('dead', PlayerData.dead)
	end

	local groups = PlayerData.groups

	if not groups[data.job.name] or not groups[data.gang.name] or groups[data.job.name] ~= data.job.grade.level or groups[data.gang.name] ~= data.gang.grade.level then
		PlayerData.groups = {
			[data.job.name] = data.job.grade.level,
			[data.gang.name] = data.gang.grade.level,
		}

		OnPlayerData('groups', PlayerData.groups)
	end

	QBCore.Functions.TriggerCallback('ox_inventory:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
end)

RegisterNetEvent('police:client:SetHandcuffStatus', function(status)
	PlayerData.cuffed = status
	LocalPlayer.state:set('invBusy', PlayerData.cuffed, false)
	if not PlayerData.cuffed then return end

	Weapon.Disarm()
end)

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerStatus(item, values)
	exports['prdx_buffs']:AddBuff(item, values.time or 30, values.effects or {}, values.visualEffects or {}, values.toxicity or 0.0) 
end

-- taken from qbox-core (https://github.com/Qbox-project/qb-core/blob/f4174f311aae8157181a48fa2e2bd30c8d13edb1/client/functions.lua#L25)
local function hasItem(items, amount)
    amount = amount or 1

    local count = Inventory.Search('count', items)

    if type(items) == 'table' and type(count) == 'table' then
        for _, v in pairs(count) do
            if v < amount then
                return false
            end
        end

        return true
    end

    return count >= amount
end

AddEventHandler(('__cfx_export_qb-inventory_HasItem'), function(setCB)
	setCB(hasItem)
end)
