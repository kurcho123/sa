---wip types

---@class OxStash
---@field name string
---@field label string
---@field owner? boolean | string | number
---@field slots number
---@field weight number
---@field groups? string | string[] | { [string]: number }
---@field blip? { id: number, colour: number, scale: number }
---@field coords? vector3
---@field target? { loc: vector3, length: number, width: number, heading: number, minZ: number, maxZ: number, distance: number, debug?: boolean, drawSprite?: boolean }

return {
	{
		name = 'admintrash',
		label = 'Admin Trash',
		owner = true,
		slots = 120,
		weight = 30000000,
	},
	{
		name = 'policetrash',
		label = 'Police Trash',
		owner = true,
		slots = 120,
		weight = 30000000,
	},
	{
		name = 'recyclesell',
		label = 'Recycle Bin',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'Cokepressing',
		label = 'Coke Presser',
		owner = true,
		slots = 10,
		weight = 30000000,
	},
	{
		name = 'Cokebreakdown',
		label = 'Coca Plant Processing',
		owner = true,
		slots = 10,
		weight = 30000000,
	},
	{
		name = 'Weedbreakdown',
		label = 'Weed Plant Processing',
		owner = true,
		slots = 10,
		weight = 30000000,
	},
	{
		name = 'farmsell',
		label = 'Crop Deposit',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'assasinsell',
		label = 'Sell Box',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'ranchsell',
		label = 'Sell Box',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'cryptosell',
		label = 'Decryption Rig',
		owner = true,
		slots = 3,
		weight = 30000000,
	},
	{
		name = 'cryptoprivatesell',
		label = 'Private Crypto Decryption Rig',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'warehousetransfer',
		label = 'Warehouse Intake',
		owner = true,
		slots = 25,
		weight = 300000000,
	},
	{
		name = 'itemmold',
		label = 'Mold Machine Input',
		owner = true,
		slots = 10,
		weight = 30000000,
	},
	{
		name = 'till_deposit',
		label = 'Receipt Drop-Box',
		owner = true,
		slots = 10,
		weight = 30000000,
	},
	{
		name = 'minesell',
		label = 'Ore Dealer',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'jewelsell',
		label = 'Jewel Dealer',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'jailsell',
		label = 'Prisoner',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'fishsell',
		label = 'Fish Sell Box',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'exoticfishsell',
		label = 'Exotic Fish Sell Box',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'meatsell',
		label = 'Meat Sell Box',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'prison',
		label = 'Prison Stash',
		owner = true,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'moneywashingmachine1',
		label = 'Money Washing Machine 1',
		owner = false,
		slots = 5,
		weight = 30000000,
	},
	{
		name = 'moneywashingmachine2',
		label = 'Money Washing Machine 2',
		owner = false,
		slots = 5,
		weight = 30000000,
	}
}
