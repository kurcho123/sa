local QBCore = exports['qb-core']:GetCoreObject()
local ox_inventory = exports.ox_inventory
local SavedMineData = {} -- Clientside saved data
-- FUNCTIONS --
function CreateBlips()
	for k, v in pairs(Config.Mining.Locations) do
		if Config.Mining.Locations[k].blipTrue then
			local blip = AddBlipForCoord(v.location)
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, 527)
			SetBlipColour(blip, 81)
			SetBlipScale(blip, 0.5)
			SetBlipDisplay(blip, 6)

			BeginTextCommandSetBlipName('STRING')
			if Config.Mining.Locations[k].name then
				AddTextComponentString("PUBLIC JOB: " .. Config.Mining.Locations[k].name)
			else
				AddTextComponentString("PUBLIC JOB: Mining")
			end
			EndTextCommandSetBlipName(blip)
			Config.Mining.Locations[k].Blip = blip
		end
	end
end

function DeleteBlips()
	for k, v in pairs(Config.Mining.Locations) do
		if Config.Mining.Locations[k].Blip then
			RemoveBlip(Config.Mining.Locations[k].Blip)
		end
	end
end

function SpawnOres()
	if not SavedMineData.Ores then return end
	for k,v in ipairs(SavedMineData.Ores) do
		if not SavedMineData.Ores[k].Mined and SavedMineData.Ores[k].Coords then -- Needs correaltion table between item and model. Also! We can just use universal target models since they are custom models!
			if SavedMineData.Ores[k].Ore == "copperore" then
				local prop = CreateObject(joaat("k4mb1_copperore"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true)   
				SavedMineData.Ores[k].Entity = prop
			elseif SavedMineData.Ores[k].Ore == "aluminumore" then
				local prop = CreateObject(joaat("k4mb1_bauxiteore"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true)   
				SavedMineData.Ores[k].Entity = prop
			elseif SavedMineData.Ores[k].Ore == "goldore" then
				local prop = CreateObject(joaat("k4mb1_goldore"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true) 
				SavedMineData.Ores[k].Entity = prop  
			elseif SavedMineData.Ores[k].Ore == "ironore" then
				local prop = CreateObject(joaat("k4mb1_ironore"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true)      
				SavedMineData.Ores[k].Entity = prop  
			elseif SavedMineData.Ores[k].Ore == "carbon" then
				local prop = CreateObject(joaat("k4mb1_coal"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true) 
				SavedMineData.Ores[k].Entity = prop 
			elseif SavedMineData.Ores[k].Ore == 'uncut_emerald' then
				local prop = CreateObject(joaat("k4mb1_crystalgreen"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true) 
				SavedMineData.Ores[k].Entity = prop 
			elseif SavedMineData.Ores[k].Ore == 'uncut_ruby' then
				local prop = CreateObject(joaat("k4mb1_crystalred"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true) 
				SavedMineData.Ores[k].Entity = prop 
			elseif SavedMineData.Ores[k].Ore == 'uncut_sapphire' then
				local prop = CreateObject(joaat("k4mb1_crystalblue"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true) 
				SavedMineData.Ores[k].Entity = prop 
			elseif SavedMineData.Ores[k].Ore == 'uncut_diamond' then
				local prop = CreateObject(joaat("k4mb1_diamond"),SavedMineData.Ores[k].Coords.x, SavedMineData.Ores[k].Coords.y, SavedMineData.Ores[k].Coords.z,false,false,false)
				SetEntityHeading(prop,GetEntityHeading(prop)-90)
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true) 
				SavedMineData.Ores[k].Entity = prop 
			end 
		elseif not SavedMineData.Ores[k].Coords then
			SavedMineData.Ores[k] = nil
		end
		Wait(1) -- Tick Scheduler    
	end
end

function SetupTargets()
		--Ores
		exports['qb-target']:AddTargetModel("k4mb1_copperore",  {options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Copper",  ore = "Copper",  reward = "copperore",  },}, distance = 1.7})
		exports['qb-target']:AddTargetModel("k4mb1_bauxiteore", {options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Bauxite", ore = "Bauxite", reward = "aluminumore",},}, distance = 1.7})
		exports['qb-target']:AddTargetModel("k4mb1_goldore",    {options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Gold",    ore = "Gold",    reward = "goldore",    },}, distance = 1.7})
		exports['qb-target']:AddTargetModel("k4mb1_ironore",    {options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Iron",    ore = "Iron",    reward = "ironore",    },}, distance = 1.7})
		exports['qb-target']:AddTargetModel("k4mb1_coal",    	{options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Carbon",  ore = "Carbon",  reward = "carbon",     },}, distance = 1.7})
		--Gems
		exports['qb-target']:AddTargetModel("k4mb1_crystalgreen",{options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Emerald", ore = "Emerald", reward = "uncut_emerald",  },}, distance = 1.7})
		exports['qb-target']:AddTargetModel("k4mb1_crystalred",  {options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Ruby",    ore = "Ruby",    reward = "uncut_ruby",     },}, distance = 1.7})
		exports['qb-target']:AddTargetModel("k4mb1_crystalblue", {options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Sapphire",ore = "Sapphire",reward = "uncut_sapphire", },}, distance = 1.7})
		exports['qb-target']:AddTargetModel("k4mb1_diamond",	 {options = {{type = "client", event = 'prdx_mining:MineOre', icon = "fas fa-certificate", label = "Mine Diamond", ore = "Diamond", reward = "uncut_diamond",  },}, distance = 1.7})
		
		--Smelter
		local smelter = Config.Mining.SmelterInformation
		exports['qb-target']:AddBoxZone(".Smelter.", smelter.location, smelter.sizeX, smelter.sizeY, {
			name = ".Smelter.", heading = smelter.direction, debugPoly = false, minZ = smelter.location.z - 1.0,
			maxZ = smelter.location.z + 1.5	}, 
		{options = {{event = "prdx_mining:SmeltMenuOres", icon = 'fas fa-box', label = "Smelter Options",},},distance = 2.5})
		
		--Gem Cutting
		exports['qb-target']:AddBoxZone(".CuttingTable.", vector3(2918.94, 2647.08, 42.65), 1.0, 1.85, {
			name = ".CuttingTable.", heading = 26.72, debugPoly = false, minZ = 42.25, maxZ = 42.95	}, 
		{options = {{event = "prdx_mining:CuttingMenu", icon = 'fas fa-box', label = "Gem Cutting",},},distance = 2.5})

		--Jewel Crafting
		exports['qb-target']:AddBoxZone(".JewelAnvil.", vector3(2918.8, 2655.31, 42.6), 0.40, 1.05, {
			name = ".JewelAnvil.", heading = 160.66, debugPoly = false, minZ = 42.25, maxZ = 42.95	}, 
		{options = {{event = "prdx_mining:JewelryMenu", icon = 'fas fa-box', label = "Jewelly Crafting",},},distance = 2.5})
		
		--Debug Poly
		if Config.Mining.ShowDebug == true then 
		PolyDebug()
		end
end 

function GetClosestRock()
	local closestRock = fasle
	if SavedMineData and SavedMineData.Ores then
		local coords = GetEntityCoords(PlayerPedId())
		local closestDistance = -1
		for k,v in pairs(SavedMineData.Ores) do
			if SavedMineData.Ores[k].Coords then
				local distance = #(SavedMineData.Ores[k].Coords - coords)
				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestRock = k
				end
			end
		end
		return closestRock
	end
end

function PolyDebug()
	local locations = {}
	locations = Config.Mining.OreSpawnLocations
	for k, v in pairs(locations) do
		exports['qb-target']:AddBoxZone(".Rock." .. k, locations[k], 1.0, 1.0, {name = ".Rock." .. k, heading = 0.00, debugPoly = true, minZ = locations[k].z - 1.0,maxZ = locations[k].z + 1.0}, {options = {{event = "", icon = 'fas fa-box', label = "DEBUG POLY",},},distance = 5.0})
	end
end
-----------------------------------------------------------

-- Mining Menu
AddEventHandler('prdx_mining:MineMenu', function()
	QBCore.Functions.TriggerCallback('prdx_mining:server:getMineData', function(data)
		local CitizenID = QBCore.Functions.GetPlayerData().citizenid
		local MineData = data
		local menuOptions = {}
		menuOptions[#menuOptions + 1] = {
			title = 'Generate Mine',
				description = 'Open up a mine',
				serverEvent = 'prdx_mining:server:generateMine',
		}
		for k, v in ipairs(MineData) do
			if not v.Locked or v.Owner == CitizenID then
				local status = ''
				local ico = ''
				if v.Regen then
					local random = math.random(1,4)
					if random == 1 then status = 'Mine Closed: Blasting Work'
					elseif random == 2 then status = 'Mine Closed: Flooding'
					elseif random == 3 then status = 'Mine Closed: Cave In'
					else status = 'Mine Closed: Dangerous Coal Dust Levels'
					end
				else
					local OreCount = 0
					for k,v in ipairs(v.Ores) do
						if not v.Mined then
							OreCount = OreCount + 1
						end
					end -- Checks for amount of ores not mined
					-- I think the less performance hitting thing would be the above check but if not the case you can flip them --
					local PercentageComplete = (OreCount / #v.Ores) * 100
					if v.Locked then
						status = 'Mine Locked: '..math.ceil(PercentageComplete)..'%'
						ico = 'lock'
					else
						status = 'Mine Unlocked: '..math.ceil(PercentageComplete)..'%'
						ico = 'lock-open'
					end
				end
				menuOptions[#menuOptions + 1] = {
					title = 'Mine #'..k, 
					description = status,
					icon = ico,
					event = "prdx_mining:openMineOptions",
					args = v
				}
			end
		end
		lib.registerContext({
			id = 'MineMenu',
			title = 'Davis Quartz Mining Corperation',
			onExit = function() end,
			options = menuOptions
		})
		lib.showContext('MineMenu')
	end)
end)

-- Enter Mines -- 
AddEventHandler('prdx_mining:openMineLeave', function()
	if SavedMineData then
		local CitizenID = QBCore.Functions.GetPlayerData().citizenid
		local menu = {}
		local mine = SavedMineData
		if mine.Locked then
			if mine.Owner == CitizenID then
				menu[#menu+1] = {
					title = "Open Mine to Public", 
					serverEvent = "prdx_mining:server:unlockMine",
					args = mine.ID
				}
			end
			menu[#menu+1] = {
				title = "Leave Mine", 
				serverEvent = "prdx_mining:server:LeaveMine"
			}
		else
			if mine.Owner == CitizenID then
				menu[#menu+1] = {
					title = "Lock Mine", 
					serverEvent = "prdx_mining:server:lockMine",
					args = mine.ID        
				}
			end
			menu[#menu+1] = {
				title = "Leave Mine", 
				serverEvent = "prdx_mining:server:LeaveMine"
			}
		end
		lib.registerContext({
            id = 'mine_exit_menu',
            title = 'Mine Options',
            options = menu,
        })
        lib.showContext('mine_exit_menu')   
	else
		TriggerServerEvent('prdx_mining:server:LeaveMine')
	end
end)

-- Enter Mines -- 
AddEventHandler('prdx_mining:openMineOptions', function(mine)
	local CitizenID = QBCore.Functions.GetPlayerData().citizenid
    local menu = {}
	if mine.Locked then
		if mine.Owner == CitizenID then
			menu[#menu+1] = {
				title = "Open Mine to Public", 
				serverEvent = "prdx_mining:server:unlockMine",
				args = mine.ID
			}
			menu[#menu+1] = {
				title = "Enter Mine", 
				serverEvent = "prdx_mining:server:EnterMine",   
				args = mine.ID
			}
		end
	else
		if mine.Owner == CitizenID then
			menu[#menu+1] = {
				title = "Lock Mine", 
				serverEvent = "prdx_mining:server:lockMine",
				args = mine.ID
			}
		end
		menu[#menu+1] = {
			title = "Enter Mine", 
			serverEvent = "prdx_mining:server:EnterMine",   
			args = mine.ID
		}
	end
	lib.registerContext({
		id = 'mine_entrance_menu',
		title = 'Mine Options',
		options = menu,
	})
	lib.showContext('mine_entrance_menu') 
end)

--Smelting Menu
AddEventHandler('prdx_mining:SmeltMenuOres', function()
    local menu = {}
    for k, v in pairs(Config.Mining.SmeltingRecipes) do -- Autogen menus
        local headermsg = ''
        local TableCount = 0
        for k2,v2 in pairs(v.cost) do
            if TableCount == 0 then
                headermsg = 'Make: '..v.drop..'x '..exports.ox_inventory:Items()[Config.Mining.SmeltingRecipes[k].reward]["label"]
				txtmsg = 'Requires: ' .. v2 .. "x " ..exports.ox_inventory:Items()[k2]["label"]
            else
                headermsg = headermsg--..' and '..v.drop..' '..exports.ox_inventory:Items()[k2]["label"]
				txtmsg = txtmsg..' and '..v2 .. "x " ..exports.ox_inventory:Items()[k2]["label"]
            end
            TableCount = TableCount + 1
        end
        menu[#menu + 1] = {
            title  = headermsg, 
            description = txtmsg,-- " to make " ..v.drop..' '.. exports.ox_inventory:Items()[Config.Mining.SmeltingRecipes[k].reward]["label"],
			serverEvent = "prdx_mining:smelting:Begin",
			args = k
        }
    end
    lib.registerContext({
		id = 'SmeltMenuOres',
		title = 'Standard Smelting Services',
		onExit = function() end,
		options = menu
	})
	lib.showContext('SmeltMenuOres')
end)

--Smelting Menu ADVANCED
AddEventHandler('prdx_mining:SmeltMenuOresAdv', function()
	local menu = {}
	menu[#menu+1] = {
		title  = "Return", 
		event = "prdx_mining:SmeltMenu",
	}
    for k, v in pairs(Config.Mining.SmeltingRecipes) do -- Autogen menus
        local headermsg = ''
        local TableCount = 0
        for k2,v2 in pairs(v.cost) do
            if TableCount == 0 then
                headermsg = 'Make: '..v.drop..'x '..exports.ox_inventory:Items()[Config.Mining.SmeltingRecipes[k].reward]["label"]
				txtmsg = 'Requires: ' .. v2 .. "x " ..exports.ox_inventory:Items()[k2]["label"]
            else
                headermsg = headermsg--..' and '..v.drop..' '..exports.ox_inventory:Items()[k2]["label"]
				txtmsg = txtmsg..' and '..v2 .. "x " ..exports.ox_inventory:Items()[k2]["label"]
            end
            TableCount = TableCount + 1
        end
        menu[#menu + 1] = {
            title = headermsg, 
            description = txtmsg,-- " to make " ..v.drop..' '.. exports.ox_inventory:Items()[Config.Mining.SmeltingRecipes[k].reward]["label"],
			serverEvent = "prdx_mining:smelting:BeginAdv",
			args = k
        }
    end
    lib.registerContext({
		id = 'SmeltMenuOresAdv',
		title = 'Pressure Smelting Services',
		onExit = function() end,
		options = menu
	})
	lib.showContext('SmeltMenuOresAdv')
end)

AddEventHandler('prdx_mining:SmeltMenu', function()
	lib.showContext('SmeltMenuOres')
end)

-- Cutting Menu
AddEventHandler('prdx_mining:CuttingMenu', function()
	local menu = {}

    for k, v in pairs(Config.Mining.CuttingRecipes) do -- Autogen menus
        local headermsg = ''
        local TableCount = 0
        for k2,v2 in pairs(v.cost) do
            if TableCount == 0 then
                headermsg = 'Make: '..v2..'x '..exports.ox_inventory:Items()[Config.Mining.CuttingRecipes[k].reward]["label"]
				txtmsg = 'Requires: ' .. v2 .. "x " ..exports.ox_inventory:Items()[k2]["label"]
            else
                headermsg = headermsg..' and '..v2..' '..exports.ox_inventory:Items()[k2]["label"]
				txtmsg = txtmsg..' and '..v2 .. "x " ..exports.ox_inventory:Items()[k2]["label"]
            end
            TableCount = TableCount + 1
        end
        menu[#menu + 1] = {
            title = headermsg, 
            description = txtmsg,--.. " to make " ..v.drop..' '.. exports.ox_inventory:Items()[Config.Mining.CuttingRecipes[k].reward]["label"],
			serverEvent = "prdx_mining:cutting:Begin",
			args = k
            
        }
    end
	lib.registerContext({
		id = 'CuttingMenu',
		title = 'Precision Cutting Services',
		onExit = function() end,
		options = menu
	})
	lib.showContext('CuttingMenu')	
end)

-- Jewelry Menu
AddEventHandler('prdx_mining:JewelryMenu', function()
    local menu = {}
    for k, v in pairs(Config.Mining.JewelryRecipes) do -- Autogen menus
        local headermsg = ''
        local TableCount = 0
        for k2,v2 in pairs(v.cost) do
            if TableCount == 0 then
                headermsg = 'Make: '..v2..' '..exports.ox_inventory:Items()[Config.Mining.JewelryRecipes[k].reward]["label"]
				txtmsg = 'Requires: ' .. v2 .. "x " ..exports.ox_inventory:Items()[k2]["label"]
            else
                headermsg = headermsg--..' and '..v2..' '..exports.ox_inventory:Items()[k2]["label"]
				txtmsg = txtmsg..' and '..v2 .. "x " ..exports.ox_inventory:Items()[k2]["label"]
            end
            TableCount = TableCount + 1
        end
        menu[#menu + 1] = {
            title = headermsg, 
            description = txtmsg,--.. " to make " ..v.drop..' '.. exports.ox_inventory:Items()[Config.Mining.JewelryRecipes[k].reward]["label"],
			serverEvent = "prdx_mining:jewelry:Begin",
			args = k
        }
    end
    lib.registerContext({
		id = 'JewelryMenu',
		title = 'Jewellery Crafting Services',
		onExit = function() end,
		options = menu
	})
	lib.showContext('JewelryMenu')	
end)

-- Smelt Command / Animations
RegisterNetEvent('prdx_mining:smelting:DoSmeltAdv', function(item)
    local pos = GetEntityCoords(PlayerPedId())
	local RandomTime = math.random(20000, 25000)
	local result = exports["slidergame"]:slider()
	local no1,no2,no3 = tonumber(result[1]), tonumber(result[2]) * 5, tonumber(result[3]) * 5
	local PressureGenerated = (((35000 * no1) * no2 + (no3 * 2)) / 10000) / 2
	local Offset = (math.abs(Config.Mining.SmeltingPressures[item] - PressureGenerated) / 100) + 1
	QBCore.Functions.Notify('Smelting Pressure Generated: '..(PressureGenerated)..'psi', 'inform', 15000)

	if Offset <= 25.0 then 
		result = true
	else
		result = false
	end
	--QBCore.Functions.Notify('Smeltery Pressure Offset: '..(math.abs(Config.Mining.SmeltingPressures[item] - PressureGenerated) * 10)..'psi', 'info', 30000) -- Maybe add an item called a "ore detector" which will help new people learn the pressures to set for ores, item used, degrades, prints the table for this ore
	
	-- Execute --
	TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
	QBCore.Functions.Progressbar("open_locker_drill", "Smelting..", RandomTime, false, true, {
        disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
            if result then
				QBCore.Functions.Notify('Proper pressure achieved', 'success')
			end
			TriggerServerEvent('prdx_mining:smelting:Reward', item, true, result) -- When animations finished this is called and does the correct reward command via the ID it received from the menu
            TriggerEvent('prdx_mining:SmeltMenu')
			TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            
    end, function() -- Cancel
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

-- Smelt Command / Animations
RegisterNetEvent('prdx_mining:smelting:DoSmelt', function(item)
    local pos = GetEntityCoords(PlayerPedId())
	TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
	local result
	local random = math.random(3,5)
	local skillcheck = { areaSize = 70, speedMultiplier = 0.75 }
	if random == 3 then
		result = lib.skillCheck({skillcheck, skillcheck, skillcheck})
	elseif random == 4 then
		result = lib.skillCheck({skillcheck, skillcheck, skillcheck, skillcheck})
	elseif random == 5 then
		result = lib.skillCheck({skillcheck, skillcheck, skillcheck, skillcheck, skillcheck})
	end

	local RandomTime = math.random(30000,40000)
	if result then
		RandomTime = math.random(5000,10000)
	end

	-- Execute --
	QBCore.Functions.Progressbar("open_locker_drill", "Smelting..", RandomTime, false, true, {
        disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
            TriggerServerEvent('prdx_mining:smelting:Reward', item) -- When animations finished this is called and does the correct reward command via the ID it received from the menu
            lib.showContext('SmeltMenuOres')
			TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            
    end, function() -- Cancel
		StartEntityFire(cache.ped)
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		Wait(150)
		QBCore.Functions.Notify('You burned yourself rushing!', 'error')
		StopEntityFire(cache.ped)
    end)
end)

-- Cutting Command / Animations
RegisterNetEvent('prdx_mining:cutting:DoCutting', function(item)
    local pos = GetEntityCoords(PlayerPedId())
	TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
	QBCore.Functions.Progressbar("open_locker_drill", "Cutting jewels..", math.random(3500,4500), false, true, {
		disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
			local result = lib.skillCheck({'easy', 'medium', 'medium'})
			if result then
				QBCore.Functions.Notify('Precision cut achieved!', 'success')
			end
			TriggerServerEvent('prdx_mining:cutting:Reward', item, result) -- When animations finished this is called and does the correct reward command via the ID it received from the menu
			TriggerEvent('prdx_mining:CuttingMenu')
			TriggerEvent('animations:client:EmoteCommandStart', {"c"})
	end, function() -- Cancel
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
	end)
end)

-- Cutting Command / Animations
RegisterNetEvent('prdx_mining:cutting:DoJewelry', function(item)
	TriggerEvent('animations:client:EmoteCommandStart', {"picklock"})
	QBCore.Functions.Progressbar("open_locker_drill", "Crafting..", math.random(3500,4500), false, true, {
        disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
			local result = lib.skillCheck({'easy', 'medium', 'medium', 'medium', 'easy'})
			if result then
				QBCore.Functions.Notify('Precision cut achieved!', 'success')
			end
            TriggerServerEvent('prdx_mining:cutting:JewelReward', item, result) -- When animations finished this is called and does the correct reward command via the ID it received from the menu
            TriggerEvent('prdx_mining:JewelryMenu')
			TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
		TriggerServerEvent('prdx_mining:server:JewelryFail', item) -- Punish player by removing item to prevent min/maxers
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('prdx_mining:client:EnteredMine', function(data)
	SavedMineData = data
	DoScreenFadeOut(800)
	Wait(850)
	TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999}) -- Set time to night (activate lights), and weather to clear
	TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
	SetEntityCoords(PlayerPedId(), Config.Mining.TeleportInsideLocation)
	SetEntityHeading(PlayerPedId(), Config.Mining.TeleportInsideLocation.w)
	SpawnOres()
	Wait(250)
	DoScreenFadeIn(1000)

	--Spawn in rocks to block the holes in the MLO (Remove on exit?)
	-- Wait(100)
	-- SpawnBlockerRocks()
end)

RegisterNetEvent('prdx_mining:client:LeftMine', function()
	DoScreenFadeOut(800)
	Wait(850)
	if SavedMineData and SavedMineData.Ores then
		local deleteores = SavedMineData.Ores
		for k,v in pairs(deleteores) do
			if v.Entity and v.Entity ~= 0 then
				DeleteEntity(v.Entity)
			end
		end
		SavedMineData = {}
	end
	TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
	TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
	SetEntityCoords(PlayerPedId(), Config.Mining.TeleportOutsideLocation)
	SetEntityHeading(PlayerPedId(), Config.Mining.TeleportOutsideLocation.w)
	Wait(250)
	DoScreenFadeIn(1000)
end)

RegisterNetEvent('prdx_mining:mineLocked', function()
    if not SavedMineData then return end
    SavedMineData.Locked = true
end)

RegisterNetEvent('prdx_mining:mineUnlocked', function() -- 
    if not SavedMineData then return end
    SavedMineData.Locked = false
end)

RegisterNetEvent('prdx_mining:MineOre', function (data)
	if QBCore.Functions.HasItem('drill') then
		local ClosestRock = GetClosestRock()
		local MineOre = SavedMineData.Ores[ClosestRock]
		if MineOre then
			QBCore.Functions.TriggerCallback("prdx_mining:server:checkOre", function(allowed) 
				if not allowed then
					TriggerServerEvent('prdx_mining:server:doMineOre', SavedMineData.ID, ClosestRock)
					local pos = GetEntityCoords(PlayerPedId())
					--Targets the old rocks, redundant/needs replaced with a table of the new ore props
					local ent = GetClosestObjectOfType(pos, 2.5, `cs_x_rubweec`, false, false)
					if ent then
						TaskTurnPedToFaceEntity(PlayerPedId(), ent, 1.0)
						Wait(500)
					end

					local ore = SavedMineData.Ores[ClosestRock].Ore
					TriggerEvent('animations:client:EmoteCommandStart', {"drill2"})
					local result
					local random = math.random(3,5)
					local skillcheck = { areaSize = 70, speedMultiplier = 0.75 }
					if random == 3 then
						result = lib.skillCheck({skillcheck, skillcheck})
					elseif random == 4 then
						result = lib.skillCheck({skillcheck, skillcheck, skillcheck})
					elseif random == 5 then
						result = lib.skillCheck({skillcheck, skillcheck, skillcheck, skillcheck})
					end
					if result then
						QBCore.Functions.Progressbar("open_locker_drill", "Cracking " .. data.ore .." rock...", math.random(25000, 30000), false, true, {
							disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
							TriggerEvent('animations:client:EmoteCommandStart', {"c"})
							TriggerEvent('animations:client:EmoteCommandStart', {"hammer"})
							Wait(math.random(2500,3500))
							TriggerServerEvent('prdx_mining:MineRewardType', SavedMineData.ID, ClosestRock)
							TriggerEvent('animations:client:EmoteCommandStart', {"c"})
							TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})

						end, function() -- Cancel
							TriggerServerEvent('prdx_mining:server:resetMineOre', SavedMineData.ID, ClosestRock)
							TriggerEvent('animations:client:EmoteCommandStart', {"c"})

						end)
					else
						TriggerEvent('animations:client:EmoteCommandStart', {"c"})
						QBCore.Functions.Notify('Failed to drill', 'error')
					end
					local time = Config.Mining.MiningTime[ore]
				end
			end, SavedMineData.ID, ClosestRock)
		end    
	else
		TriggerEvent('QBCore:Notify', "You dont have a drill", 'error')
	end 
end)

RegisterNetEvent('prdx_mining:client:OreMined', function(oreid)
	if SavedMineData and SavedMineData.Ores then
		if SavedMineData.Ores[oreid] and SavedMineData.Ores[oreid].Entity then
			DeleteEntity(SavedMineData.Ores[oreid].Entity)
			SavedMineData.Ores[oreid].Mined = true
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
		if SavedMineData and SavedMineData.Ores then
			local deleteores = SavedMineData.Ores
			for k,v in pairs(deleteores) do
				if v.Entity and v.Entity ~= 0 then
					DeleteEntity(v.Entity)
				end
			end
			SavedMineData = {}		
			TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
			TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
			TriggerServerEvent('qb-apartments:returnBucket')
			QBCore.Functions.Notify('The mines have had a water leak. Please exit and generate a new mine!', 'error', 20000)
			--SetEntityCoords(PlayerPedId(), Config.Mining.TeleportOutsideLocation)
			--SetEntityHeading(PlayerPedId(), Config.Mining.TeleportOutsideLocation.w)
			DeleteBlips()
		end
    end
end)

CreateThread(function()
	Wait(2500)
	CreateBlips()
	SetupTargets()	
end)

AddEventHandler('prdx_mining:client:OreBuyerMenu', function(data)
	local SellMenu = ''
	local SellPricesMenu = {}
	for k,v in pairs(Config.Mining.SellPricesOres) do
		SellPricesMenu[#SellPricesMenu+1] = {name = k, price = v}
	end
	table.sort(SellPricesMenu, function(a,b) return exports.ox_inventory:Items()[a.name]["label"] < exports.ox_inventory:Items()[b.name]["label"] end)
	for k,v in pairs(SellPricesMenu) do
		SellMenu = SellMenu..exports.ox_inventory:Items()[v.name]["label"]..':		$'..v.price..'  \n'
	end

    local menu = {
        {
            title = "Current Sell Prices:", 
            description = SellMenu,
			disabled = true
        },
		{
            title = "Open Ore Sell Box", 
            event = "prdx_mining:client:openStash",
            args = data
        },
        {
            title = "Sell Ores", 
            event = "prdx_mining:client:sellStashMenu"
        },
		{
            title = "Buy Ores", 
            event = "qb-shops:client:OpenDynamicShop",
			args = {shop = 'minesell'}
        }        
    }
	lib.registerContext({
		id = 'ore_buyer_menu',
		title = 'Grand Banks Metalworks',
		options = menu,
	})
	lib.showContext('ore_buyer_menu') 
end)

AddEventHandler('prdx_mining:client:sellStashMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
			args = {'minesell', true}
        }  
    }
	lib.registerContext({
		id = 'ore_sell_menu',
		title = 'Sell Ores',
		options = menu,
	})
	lib.showContext('ore_sell_menu') 
end)

RegisterNetEvent('prdx_mining:client:OpenOreDictionary', function()
	
    local menu = {}
    for k, v in pairs(Config.Mining.SmeltingPressures) do -- Autogen menus
        menu[#menu + 1] = {
            title = exports.ox_inventory:Items()[k]["label"], 
            descrption = 'Optimal Pressure: '..(v*10)..' PSI',--.. " to make " ..v.drop..' '.. exports.ox_inventory:Items()[Config.Mining.JewelryRecipes[k].reward]["label"],
        }
    end
    lib.registerContext({
		id = 'OreDictionary',
		title = 'Grand Banks Metalworks',
		onExit = function() end,
		options = menu
	})
	lib.showContext('OreDictionary')
end)

AddEventHandler('prdx_mining:client:JewelBuyerMenu', function(data)
	local SellMenu = ''
	local SellPricesMenu = {}

	for k,v in pairs(Config.Mining.SellPricesGems) do
		SellPricesMenu[#SellPricesMenu+1] = {
			name = k, 
			price = v
		}
	end
	table.sort(SellPricesMenu, function(a,b) return exports.ox_inventory:Items()[a.name]["label"] < exports.ox_inventory:Items()[b.name]["label"] end)
	for k,v in pairs(SellPricesMenu) do
		SellMenu = SellMenu..'$'..v.price .."  \t"..exports.ox_inventory:Items()[v.name]["label"]..'\r\n'
	end
    local menu = {
        {
            title = "Current Prices:", 
            description = SellMenu,
			disabled = true
        },
		{
            title = "Open Jewel Sell Box", 
			event = "prdx_mining:client:openStash",
			args = data,
        },
        {
            title = "Sell Jewels",
			event = "prdx_mining:client:sellJewelStashMenu",
        },    
    }
    lib.registerContext({
		id = 'JewelBuyerMenu',
		title = 'Vangelico Fine Jewellery',
		onExit = function() end,
		options = menu
	})
	lib.showContext('JewelBuyerMenu')
end)

AddEventHandler('prdx_mining:client:sellJewelStashMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'jewelsell', true}
        }    
    }
	lib.registerContext({
		id = 'jewel_sell_menu',
		title = 'Sell Jewels',
		options = menu,
	})
	lib.showContext('jewel_sell_menu') 
end)

RegisterNetEvent('prdx_mining:client:openStash', function(data)
	exports.ox_inventory:openInventory('stash', {id = data.args[1], owner = QBCore.Functions.GetPlayerData().citizenid})
end)

-- Mining Store Opening
RegisterNetEvent('prdx_mining:openShop', function()
	exports.ox_inventory:openInventory('shop', { type = 'MineShop' })
end)