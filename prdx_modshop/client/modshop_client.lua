QBCore = exports['qb-core']:GetCoreObject()
--local function GarbageTruck() collectgarbage() SetTimeout(2000, GarbageTruck) end SetTimeout(2000, GarbageTruck)
local isDriving = false
local increasePercent = 200 -- Percent that the multi-items will go up by upgrade
local interiorIds = {}
local MasterZones = {}
local BlipData = {}
local ShownText = false

local function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function Button(ControlButton)
    PushScaleformMovieMethodParameterButtonName(ControlButton)
end

local function setupScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, 38, true))
    ButtonMessage("Open Los Santos Customs")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function loadCar(model)
	if not HasModelLoaded(model) then 
		RequestModel(model) 
	end
	while not HasModelLoaded(model) do 
		Wait(0) 
	end
end

local function setupScaleform2(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, 191, true))
    ButtonMessage("Confirm Choice")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(2, 194, true))
    ButtonMessage("Back")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

local function BuyModWithCash(amount, myCar)
	amount = math.floor(amount)
	local complete = nil
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plate = QBCore.Functions.GetPlate(vehicle)
	QBCore.Functions.TriggerCallback("prdx_modshop:purchase", function(success)
		if success == true then
			TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.1)
			myCar = QBCore.Functions.GetVehicleProperties(vehicle)
			complete = true
		else
			complete = false
		end
	end, amount, plate)
	while complete == nil do
		Wait(0)
	end
	return complete
end

local function CreateShopEvent(zone, shopID)
    zone:onPlayerInOut(function(isPointInside)
		if not isDriving then return end
        if isPointInside then
			CurrentShop = shopID
            exports['qb-core']:DrawText('[E] - Vehicle Customs')
        else
            CurrentShop = false
            exports['qb-core']:HideText()
        end
    end)
end

AddEventHandler('polyzonehelper:enter', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "InModShop" then
			local plyCoords = GetEntityCoords(PlayerPedId())
			for k,v in ipairs(Config.Locations) do
				if v.shopType ~= 'LSCustomsInt' then
					if #(plyCoords - v.coords) <= 25.0 then
						CurrentShop = k
					end
				end
			end
		end
	end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "InModShop" then
			CurrentShop = false
			if ShownText then
				exports['qb-core']:HideText()
				ShownText = false
			end
		end
	end
end)

local function CreateShopZone(shopID)
	local ShopData = Config.Locations[shopID]
	if ShopData then
		-- Bunker --
		exports['polyzonehelper']:AddCircleZone("InModShop", ShopData.coords, 7.0, {
			name="InModShop",
			heading = 0.0,
			minZ = ShopData.coords.z - 10.0,
			maxZ = ShopData.coords.z + 10.0,
			debugPoly = false
		})  
		MasterZones[#MasterZones+1] = zone
	end
end

CreateThread(function()
	AddTextEntry("CLSCPara", "Commercial Los Santos Customs")
	AddTextEntry("AirLSCPara", "Aircraft Los Santos Customs")
	AddTextEntry("BoatLSCPara", "Boat Los Santos Customs")
	exports['polyzonehelper']:DeletePolyZone("InModShop")
	Wait(250)
	for k,v in ipairs(Config.Locations) do
		if v.shopType == 'LSCustomsInt' then
			interiorIds[#interiorIds+1] = GetInteriorAtCoords(v.coords)
		else
			CreateShopZone(k)
		end
	end
end)

CreateThread(function() -- This is here for a good reason, leave it.
	local function IsCustomsOpen()
		return (JayMenu.IsMenuOpened('xncustoms') or string.find(tostring(JayMenu.CurrentMenu() or ""), "xnc2_"))
	end
	local function GetVehicleCustomTiresEnabled(vehicle)
		return GetVehicleModVariation(vehicle, 23)
	end
	local function SetVehicleCustomTires(veh, customTires)
		SetVehicleModKit(veh, 0)
		SetVehicleMod(veh, 23, GetVehicleMod(veh, 23), customTires)
	end
	local function ModVehicle(veh, mod, value)
		SetVehicleModKit(veh, 0)
		SetVehicleMod(veh, mod, value, GetVehicleCustomTiresEnabled(veh))
	end
	local hornCar = nil

	local function defaultDisplayHandler(modType, veh)
		for i=-1,#modType.mods do
			local mod = modType.mods[i]
			mod.id = modType.mod.id
			if modType.mod.name == "CMOD_MOD_BRA" or modType.mod.name == "CMOD_MOD_SUS" or modType.mod.name == "CMOD_MOD_TRN" then
				if i == -1 then
					mod.price = modType.mod.price
					percent = 1 - (increasePercent / 100)
				else
					percent = percent + (increasePercent / 100)
					mod.price = math.ceil(modType.mod.price * percent)
				end
			elseif tostring(modType.mod.name) == "CMOD_MOD_ENG" then
				if i == -1 then
					mod.price = modType.mod.price
					percent = 1 - ((increasePercent * 2) / 100)
				else
					percent = percent + ((increasePercent * 2) / 100)
					mod.price = math.ceil(modType.mod.price * percent)
				end
			else
				mod.price = modType.mod.price
			end
			
			if mod then
				
				if modType.mod.name == "CMM_MOD_S14" or modType.mod.name == "CMM_MOD_S15" or modType.mod.name == "CMM_MOD_S15b" then
					SetVehicleDoorOpen(veh, 4, false, false)
				elseif modType.mod.name == "CMM_MOD_S12" then
					SetVehicleDoorOpen(veh, 5, false, false)
				elseif modType.mod.name == "CMM_MOD_S6" then
					SetVehicleDoorOpen(veh, 0, false, false)
					SetVehicleDoorOpen(veh, 1, false, false)
					SetVehicleDoorOpen(veh, 2, false, false)
					SetVehicleDoorOpen(veh, 3, false, false)
				elseif modType.mod.name == "CMM_MOD_S2" or modType.mod.name == "CMM_MOD_S2b" or modType.mod.name == "CMM_MOD_S3" or modType.mod.name == "CMM_MOD_S5" or modType.mod.name == "CMM_MOD_S7" or modType.mod.name == "CMM_MOD_S8" or modType.mod.name == "CMM_MOD_S9" or modType.mod.name == "CMM_MOD_S19" or modType.mod.name == "CMM_MOD_S19b" or modType.mod.name == "CMM_MOD_S19c" or modType.mod.name == "CMM_MOD_S19d" then
					if CamMode ~= 4 then
						SetFollowVehicleCamViewMode(4)
					end
				end
				
				if xnCustoms.previousModValue == i then
					local clicked, hovered = JayMenu.SpriteButton(mod.name, "commonmenu", "shop_garage_icon_a", "shop_garage_icon_b")
					if clicked and i ~= -1 then
						xnCustoms.previousModValue = -1
						TriggerServerEvent("qb-log:server:CreateLog", "vehicleupgrades", "Vehicle Mod Removed", "red", "`" .. GetPlayerName(PlayerId()) .. "` removed a vehicle mod (`" .. modType.name .. ", " .. mod.name .. "`) on vehicle plate: `" .. GetVehicleNumberPlateText(veh) .. "`", false, GetPlayerServerId(PlayerId()))
					elseif hovered then
						if GetVehicleMod(veh, mod.id) ~= i then
							ModVehicle(veh, mod.id, i)
							if modType.mod.id == 14 then
								if not DoesEntityExist(hornCar) then
									local curModel = GetEntityModel(veh)
									local curPos = GetEntityCoords(veh)
									local curHead = GetEntityHeading(veh)
									loadCar(curModel)	
									hornCar = CreateVehicle(curModel, curPos, curHead, false, true)
									FreezeEntityPosition(hornCar, true)
									SetEntityVisible(hornCar, false, 0)
									SetEntityCollision(hornCar, false, false)
									ModVehicle(hornCar, mod.id, i)
									StartVehicleHorn(hornCar, 2000, "HELDDOWN", false)
									SetModelAsNoLongerNeeded(curModel)
								end
							end
							ModVehicle(hornCar, mod.id, i)
							StartVehicleHorn(hornCar, 2000, "HELDDOWN", false)
						end
					end
				else
					local clicked, hovered = JayMenu.Button(mod.name, "~HUD_COLOUR_GREENDARK~$" .. math.ceil(Config.priceMultiplier * (mod.price or 500)))
					if clicked then
						if BuyModWithCash(math.ceil(Config.priceMultiplier * mod.price), xnCustoms.playerVehicle) then
							xnCustoms.previousModValue = i
							ModVehicle(veh, mod.id, i)
						else
							QBCore.Functions.Notify("You do not have enough cash for this mod.")
						end
					elseif hovered then
						if GetVehicleMod(veh, mod.id) ~= i then
							ModVehicle(veh, mod.id, i)
							if modType.mod.id == 14 then
								if not DoesEntityExist(hornCar) then
									local curModel = GetEntityModel(veh)
									local curPos = GetEntityCoords(veh)
									local curHead = GetEntityHeading(veh)
									loadCar(curModel)	
									hornCar = CreateVehicle(curModel, curPos, curHead, false, true)
									FreezeEntityPosition(hornCar, true)
									SetEntityVisible(hornCar, false, 0)
									SetEntityCollision(hornCar, false, false)
									ModVehicle(hornCar, mod.id, i)
									StartVehicleHorn(hornCar, 2000, "HELDDOWN", false)
									SetModelAsNoLongerNeeded(curModel)
								end
								ModVehicle(hornCar, mod.id, i)
								StartVehicleHorn(hornCar, 2000, "HELDDOWN", false)
							end
						end
					end
				end
			end
		end
	end 

	RequestAdditionalText("mod_mnu", 8)
	Wait(100)
	while not HasAdditionalTextLoaded(8) do Wait(0) end

	xnCustoms = xnCustoms or {
		mods = {
			{
				name = "CMOD_MOD_SPO", 
				id = 0, 
				type = "auto",
				price = Config.itemCosts[4],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_BUMF", 
				id = 1, 
				type = "auto",
				price = Config.itemCosts[5],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_BUMR", 
				id = 2, 
				type = "auto",
				price = Config.itemCosts[6],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_SKI", 
				id = 3, 
				type = "auto",
				price = Config.itemCosts[7],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_MUF", 
				id = 4, 
				type = "auto",
				price = Config.itemCosts[8],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_CHA", 
				id = 5, 
				type = "auto",
				price = Config.itemCosts[9],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_GRL", 
				id = 6, 
				type = "auto",
				price = Config.itemCosts[10],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_HOD",
				noCustomName = true, 
				id = 7, 
				type = "auto",
				price = Config.itemCosts[11],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_FEN", 
				id = 8, 
				type = "auto",
				price = Config.itemCosts[12],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "DUMM", 
				id = 9, 
				type = "auto",
				price = 1000,

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_ROF", 
				id = 10, 
				type = "auto",
				price = Config.itemCosts[13],

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_ENG",
				id = 11,
				type = "defined",
				price = Config.itemCosts[14],
				
				definedMods = {
					[-1] = "Factory Stock Tune",
					[0] = "Factory Upgraded Tune",
					"Sport Tune",
					"Street Tune",
					"Race Tune",
					--GetLabelText("CMOD_ENG_5"),
				},

				displayHandler = defaultDisplayHandler,
			},
			-- {
			-- 	name = "CMOD_TUR_1", 
			-- 	id = 18, 
			-- 	type = "toggle",
			-- 	price = Config.itemCosts[15],
			-- },
			{
				name = "CMOD_MOD_BRA",
				id = 12,
				type = "defined",
				price = Config.itemCosts[3],

				definedMods = {
					[-1] = "Stock Calipers",
					[0] = "Factory Upgraded Calipers",
					"Sport Calipers",
					"Race Calipers",
					--GetLabelText("CMOD_BRA_4"),
				},

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_SUS",
				id = 15,
				type = "defined",
				price = Config.itemCosts[16],

				definedMods = {
					[-1] = GetLabelText("CMOD_SUS_0"),
					[0] = GetLabelText("CMOD_SUS_1"),
					GetLabelText("CMOD_SUS_2"),
					GetLabelText("CMOD_SUS_3"),
					GetLabelText("CMOD_SUS_4"),
				},

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMOD_MOD_TRN",
				id = 13,
				type = "defined",
				price = Config.itemCosts[17],

				definedMods = {
					[-1] = "Stock Clutch",
					[0] = "Factory Upgraded Clutch",
					"Street Clutch",
					"Race Clutch",
					--GetLabelText("CMOD_GBX_4"),
				},

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S0",
				id = 25,
				type = "auto",
				price = Config.itemCosts[18],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S1",
				id = 26,
				type = "auto",
				price = Config.itemCosts[19],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S2",
				id = 27,
				type = "auto",
				price = Config.itemCosts[20],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S3",
				id = 28,
				type = "auto",
				price = Config.itemCosts[21],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S4",
				id = 29,
				type = "auto",
				price = Config.itemCosts[22],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S5",
				id = 30,
				type = "auto",
				price = Config.itemCosts[23],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S6",
				id = 31,
				type = "auto",
				price = Config.itemCosts[24],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S7",
				id = 32,
				type = "auto",
				price = Config.itemCosts[25],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S8",
				id = 33,
				type = "auto",
				price = Config.itemCosts[26],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S9",
				id = 34,
				type = "auto",
				price = Config.itemCosts[27],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S10",
				id = 35,
				type = "auto",
				price = Config.itemCosts[28],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S11",
				id = 36,
				type = "auto",
				price = Config.itemCosts[29],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S12",
				id = 37,
				type = "auto",
				price = Config.itemCosts[30],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S13",
				id = 38,
				type = "auto",
				price = Config.itemCosts[31],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S14",
				id = 39,
				type = "auto",
				price = Config.itemCosts[32],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S15",
				id = 40,
				type = "auto",
				price = Config.itemCosts[33],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S16",
				id = 41,
				type = "auto",
				price = Config.itemCosts[34],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S17",
				id = 42,
				type = "auto",
				price = Config.itemCosts[35],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S18",
				id = 43,
				type = "auto",
				price = Config.itemCosts[36],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S19",
				id = 44,
				type = "auto",
				price = Config.itemCosts[37],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S20",
				id = 45,
				type = "auto",
				price = Config.itemCosts[38],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S21",
				id = 46,
				type = "auto",
				price = Config.itemCosts[39],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S22",
				id = 47,
				type = "auto",
				price = Config.itemCosts[40],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S23",
				id = 48,
				type = "auto",
				price = Config.itemCosts[41],
		
				displayHandler = defaultDisplayHandler,
			},
			{
				name = "CMM_MOD_S24",
				id = 49,
				type = "auto",
				price = 1000,
		
				displayHandler = defaultDisplayHandler,
			},
			-- {
			-- 	name = "CMM_MOD_S25",
			-- 	id = 50,
			-- 	type = "auto",
			-- 	price = 1000,
		
			-- 	displayHandler = defaultDisplayHandler,
			-- },
			-- {
			-- 	name = "CMM_MOD_S26",
			-- 	id = 51,
			-- 	type = "auto",
			-- 	price = Config.itemCosts[42],
		
			-- 	displayHandler = defaultDisplayHandler,
			-- },
			-- {
			-- 	name = "CMM_MOD_S27",
			-- 	id = 52,
			-- 	type = "auto",
			-- 	price = Config.itemCosts[43],
		
			-- 	displayHandler = defaultDisplayHandler,
			-- },
			{
				name = "CMOD_MOD_HRN",
				id = 14,
				type = "defined",
				price = Config.itemCosts[49],

				definedMods = {
					[-1] = "Stock " .. GetLabelText("CMOD_MOD_HRN"),
					[0] = "Truck Horn",
					[1] = "Cop Horn",
					[2] = "Clown Horn",
					[3] = "Musical Horn 1",
					[4] = "Musical Horn 2",
					[5] = "Musical Horn 3",
					[6] = "Musical Horn 4",
					[7] = "Musical Horn 5",
					[8] = "Sad Trombone",
					[9] = "Classical Horn 1",
					[10] = "Classical Horn 2",
					[11] = "Classical Horn 3",
					[12] = "Classical Horn 4",
					[13] = "Classical Horn 5",
					[14] = "Classical Horn 6",
					[15] = "Classical Horn 7",
					[16] = "Scale - Do",
					[17] = "Scale - Re",
					[18] = "Scale - Mi",
					[19] = "Scale - Fa",
					[20] = "Scale - Sol",
					[21] = "Scale - La",
					[22] = "Scale - Ti",
					[23] = "Scale - Do (high)",
					[24] = "Jazz Horn 1",
					[25] = "Jazz Horn 2",
					[26] = "Jazz Horn 3",
					[27] = "Jazz Horn Loop",
					[28] = "Star Spangled Banner 1",
					[29] = "Star Spangled Banner 2",
					[30] = "Star Spangled Banner 3",
					[31] = "Star Spangled Banner 4",
					[32] = "Classical Horn Loop 1",
					[33] = "Classical Horn 8",
					[34] = "Classical Horn Loop 2",
					[35] = "Classical Horn Loop 1",
					[36] = "Classical Horn 8",
					[37] = "Classical Horn Loop 2",
					[38] = "Halloween Loop 1",
					[39] = "Halloween Loop 1",
					[40] = "Halloween Loop 2",
					[41] = "Halloween Loop 2",
					[42] = "San Andreas Loop",
					[43] = "San Andreas Short",
					[44] = "Liberty City Loop",
					[45] = "Liberty City Short",
					[46] = "Festive Loop 1",
					[47] = "Festive Loop 2",
					[48] = "Festive Loop 3",
					[49] = "Sleigh Bells",
					[50] = "Festive Loop 4",
					[51] = "Sleigh Bells",
					[52] = "Air Horn 1",
					[53] = "Air Horn 1 Short",
					[54] = "Air Horn 2",
					[55] = "Air Horn 2 Short",
					[56] = "Air Horn 3",
					[57] = "Air Horn 3 Short",
				},

				displayHandler = defaultDisplayHandler,
			},
			{
				name = "Respray",
				type = "colour_selector"
			},
			{
				name = "Wheels",
				type = "wheel_selector"
			},
			{
				name = "Extras",
				type = "extras_selector"
			},
			{
				name = "Lights",
				type = "lights_menu"
			},
			{
				name = "Plates",
				type = "plates_menu"
			},
			{
				name = "Neons",
				type = "neons_menu",
				price = Config.itemCosts[45]
			},
			{
				name = "Window Tint",
				type = "window_menu",
			},
			customModTypes = {
				["colour_selector"] = true,
				["wheel_selector"] = true,
				["extras_selector"] = true,
				["lights_menu"] = true,
				["plates_menu"] = true,
				["window_menu"] = true,
				["toggle"] = true,
			},
		},
		colours = {
			["classic"] = json.decode('[[0,"BLACK"],[147,"BLACK_GRAPHITE"],[1,"GRAPHITE"],[11,"ANTHR_BLACK"],[2,"BLACK_STEEL"],[3,"DARK_SILVER"],[4,"SILVER"],[5,"BLUE_SILVER"],[6,"ROLLED_STEEL"],[7,"SHADOW_SILVER"],[8,"STONE_SILVER"],[9,"MIDNIGHT_SILVER"],[10,"CAST_IRON_SIL"],[27,"RED"],[28,"TORINO_RED"],[29,"FORMULA_RED"],[150,"LAVA_RED"],[30,"BLAZE_RED"],[31,"GRACE_RED"],[32,"GARNET_RED"],[33,"SUNSET_RED"],[34,"CABERNET_RED"],[143,"WINE_RED"],[35,"CANDY_RED"],[135,"HOT PINK"],[137,"PINK"],[136,"SALMON_PINK"],[36,"SUNRISE_ORANGE"],[38,"ORANGE"],[138,"BRIGHT_ORANGE"],[37,"GOLD"],[90,"BRONZE"],[88,"YELLOW"],[89,"RACE_YELLOW"],[91,"FLUR_YELLOW"],[49,"DARK_GREEN"],[50,"RACING_GREEN"],[51,"SEA_GREEN"],[52,"OLIVE_GREEN"],[53,"BRIGHT_GREEN"],[54,"PETROL_GREEN"],[92,"LIME_GREEN"],[141,"MIDNIGHT_BLUE"],[61,"GALAXY_BLUE"],[62,"DARK_BLUE"],[63,"SAXON_BLUE"],[64,"BLUE"],[65,"MARINER_BLUE"],[66,"HARBOR_BLUE"],[67,"DIAMOND_BLUE"],[68,"SURF_BLUE"],[69,"NAUTICAL_BLUE"],[73,"RACING_BLUE"],[70,"ULTRA_BLUE"],[74,"LIGHT_BLUE"],[96,"CHOCOLATE_BROWN"],[101,"BISON_BROWN"],[95,"CREEK_BROWN"],[94,"UMBER_BROWN"],[97,"MAPLE_BROWN"],[103,"BEECHWOOD_BROWN"],[104,"SIENNA_BROWN"],[98,"SADDLE_BROWN"],[100,"MOSS_BROWN"],[102,"WOODBEECH_BROWN"],[99,"STRAW_BROWN"],[105,"SANDY_BROWN"],[106,"BLEECHED_BROWN"],[71,"PURPLE"],[72,"SPIN_PURPLE"],[146,"MIGHT_PURPLE"],[145,"BRIGHT_PURPLE"],[107,"CREAM"],[111,"WHITE"],[112,"FROST_WHITE"]]'),
			["metallic"] = json.decode('[[0,"BLACK"],[147,"BLACK_GRAPHITE"],[1,"GRAPHITE"],[11,"ANTHR_BLACK"],[2,"BLACK_STEEL"],[3,"DARK_SILVER"],[4,"SILVER"],[5,"BLUE_SILVER"],[6,"ROLLED_STEEL"],[7,"SHADOW_SILVER"],[8,"STONE_SILVER"],[9,"MIDNIGHT_SILVER"],[10,"CAST_IRON_SIL"],[27,"RED"],[28,"TORINO_RED"],[29,"FORMULA_RED"],[150,"LAVA_RED"],[30,"BLAZE_RED"],[31,"GRACE_RED"],[32,"GARNET_RED"],[33,"SUNSET_RED"],[34,"CABERNET_RED"],[143,"WINE_RED"],[35,"CANDY_RED"],[135,"HOT PINK"],[137,"PINK"],[136,"SALMON_PINK"],[36,"SUNRISE_ORANGE"],[38,"ORANGE"],[138,"BRIGHT_ORANGE"],[99,"GOLD"],[90,"BRONZE"],[88,"YELLOW"],[89,"RACE_YELLOW"],[91,"FLUR_YELLOW"],[49,"DARK_GREEN"],[50,"RACING_GREEN"],[51,"SEA_GREEN"],[52,"OLIVE_GREEN"],[53,"BRIGHT_GREEN"],[54,"PETROL_GREEN"],[92,"LIME_GREEN"],[141,"MIDNIGHT_BLUE"],[61,"GALAXY_BLUE"],[62,"DARK_BLUE"],[63,"SAXON_BLUE"],[64,"BLUE"],[65,"MARINER_BLUE"],[66,"HARBOR_BLUE"],[67,"DIAMOND_BLUE"],[68,"SURF_BLUE"],[69,"NAUTICAL_BLUE"],[73,"RACING_BLUE"],[70,"ULTRA_BLUE"],[74,"LIGHT_BLUE"],[96,"CHOCOLATE_BROWN"],[101,"BISON_BROWN"],[95,"CREEK_BROWN"],[94,"UMBER_BROWN"],[97,"MAPLE_BROWN"],[103,"BEECHWOOD_BROWN"],[104,"SIENNA_BROWN"],[98,"SADDLE_BROWN"],[100,"MOSS_BROWN"],[102,"WOODBEECH_BROWN"],[99,"STRAW_BROWN"],[105,"SANDY_BROWN"],[106,"BLEECHED_BROWN"],[71,"PURPLE"],[72,"SPIN_PURPLE"],[142,"MIGHT_PURPLE"],[145,"BRIGHT_PURPLE"],[107,"CREAM"],[111,"WHITE"],[146,"VERY_DARK_BLUE"],[112,"FROST_WHITE"]]'),
			["pearl"] = json.decode('[[0,"BLACK"],[1,"GRAPHITE"],[11,"ANTHR_BLACK"],[2,"BLACK_STEEL"],[3,"DARK_SILVER"],[4,"SILVER"],[5,"BLUE_SILVER"],[6,"ROLLED_STEEL"],[7,"SHADOW_SILVER"],[8,"STONE_SILVER"],[9,"MIDNIGHT_SILVER"],[10,"CAST_IRON_SIL"],[27,"RED"],[28,"TORINO_RED"],[29,"FORMULA_RED"],[150,"LAVA_RED"],[30,"BLAZE_RED"],[31,"GRACE_RED"],[32,"GARNET_RED"],[33,"SUNSET_RED"],[34,"CABERNET_RED"],[143,"WINE_RED"],[35,"CANDY_RED"],[135,"HOT PINK"],[137,"PINK"],[136,"SALMON_PINK"],[36,"SUNRISE_ORANGE"],[38,"ORANGE"],[138,"BRIGHT_ORANGE"],[37,"GOLD"],[90,"BRONZE"],[88,"YELLOW"],[89,"RACE_YELLOW"],[91,"FLUR_YELLOW"],[49,"DARK_GREEN"],[50,"RACING_GREEN"],[51,"SEA_GREEN"],[52,"OLIVE_GREEN"],[53,"BRIGHT_GREEN"],[54,"PETROL_GREEN"],[92,"LIME_GREEN"],[141,"MIDNIGHT_BLUE"],[61,"GALAXY_BLUE"],[62,"DARK_BLUE"],[63,"SAXON_BLUE"],[64,"BLUE"],[65,"MARINER_BLUE"],[66,"HARBOR_BLUE"],[67,"DIAMOND_BLUE"],[68,"SURF_BLUE"],[69,"NAUTICAL_BLUE"],[73,"RACING_BLUE"],[70,"ULTRA_BLUE"],[74,"LIGHT_BLUE"],[96,"CHOCOLATE_BROWN"],[101,"BISON_BROWN"],[95,"CREEK_BROWN"],[94,"UMBER_BROWN"],[97,"MAPLE_BROWN"],[103,"BEECHWOOD_BROWN"],[104,"SIENNA_BROWN"],[98,"SADDLE_BROWN"],[100,"MOSS_BROWN"],[102,"WOODBEECH_BROWN"],[99,"STRAW_BROWN"],[105,"SANDY_BROWN"],[106,"BLEECHED_BROWN"],[71,"PURPLE"],[72,"SPIN_PURPLE"],[142,"MIGHT_PURPLE"],[145,"BRIGHT_PURPLE"],[107,"CREAM"],[111,"WHITE"],[112,"FROST_WHITE"]]'),
			["matte"] = json.decode('[[12,"BLACK"],[13,"GREY"],[14,"LIGHT_GREY"],[131,"WHITE"],[83,"BLUE"],[82,"DARK_BLUE"],[84,"MIDNIGHT_BLUE"],[149,"MIGHT_PURPLE"],[148,"Purple"],[39,"RED"],[40,"DARK_RED"],[41,"ORANGE"],[42,"YELLOW"],[55,"LIME_GREEN"],[128,"GREEN"],[151,"MATTE_FOR"],[155,"MATTE_FOIL"],[152,"MATTE_OD"],[153,"MATTE_DIRT"],[154,"MATTE_DESERT"]]'),
			["metals"] = json.decode('[[117,"BR_STEEL"],[118,"BR BLACK_STEEL"],[119,"BR_ALUMINIUM"],[158,"GOLD_P"],[159,"GOLD_S"]]'),
			["util"] = json.decode('[[15,"BLACK"],[16,"FMMC_COL1_1"],[17,"DARK_SILVER"],[18,"SILVER"],[19,"BLACK_STEEL"],[20,"SHADOW_SILVER"],[43,"DARK_RED"],[44,"RED"],[45,"GARNET_RED"],[56,"DARK_GREEN"],[57,"GREEN"],[75,"DARK_BLUE"],[76,"MIDNIGHT_BLUE"],[77,"SAXON_BLUE"],[78,"NAUTICAL_BLUE"],[79,"BLUE"],[80,"FMMC_COL1_13"],[81,"BRIGHT_PURPLE"],[93,"STRAW_BROWN"],[108,"UMBER_BROWN"],[109,"MOSS_BROWN"],[110,"SANDY_BROWN"],[122,"veh_color_off_white"],[125,"BRIGHT_GREEN"],[127,"HARBOR_BLUE"],[134,"FROST_WHITE"],[139,"LIME_GREEN"],[140,"ULTRA_BLUE"],[144,"GREY"],[157,"LIGHT_BLUE"],[160,"YELLOW"]]'),
			["worn"] = json.decode('[[21,"BLACK"],[22,"GRAPHITE"],[23,"LIGHT_GREY"],[24,"SILVER"],[25,"BLUE_SILVER"],[26,"SHADOW_SILVER"],[46,"RED"],[47,"SALMON_PINK"],[48,"DARK_RED"],[58,"DARK_GREEN"],[59,"GREEN"],[60,"SEA_GREEN"],[85,"DARK_BLUE"],[86,"BLUE"],[87,"LIGHT_BLUE"],[113,"SANDY_BROWN"],[114,"BISON_BROWN"],[115,"CREEK_BROWN"],[116,"BLEECHED_BROWN"],[121,"veh_color_off_white"],[123,"ORANGE"],[124,"SUNRISE_ORANGE"],[126,"veh_color_taxi_yellow"],[129,"RACING_GREEN"],[130,"ORANGE"],[131,"WHITE"],[132,"FROST_WHITE"],[133,"OLIVE_GREEN"]]'),
			["chrome"] = json.decode('[[120,"CHROME"]]'),
			["smoke"] = {
				{{255, 255, 255}, "CMOD_TYR_3"},
				{{0, 0, 0}, "CMOD_TYR_4"},
				{{0, 174, 239}, "CMOD_TYR_5"},
				{{252, 238, 0}, "CMOD_TYR_6"},
				{{203, 54, 148}, "CMOD_TYR_11"},
				{{226, 6, 6}, "CMOD_TYR_8"},
				{{255, 133, 85}, "CMOD_TYR_7"},
				{{57, 102, 57}, "CMOD_TYR_10"},
				{{203, 54, 148}, "CMOD_TYR_12"},
				{{112, 25, 25}, "CMOD_TYR_13"},
			},
			["neon"] = {
				{{222, 222, 255}, "CMOD_NEONCOL_0"},
				{{2, 21, 255}, "CMOD_NEONCOL_1"},
				{{3, 83, 255}, "CMOD_NEONCOL_2"},
				{{0, 255, 140}, "CMOD_NEONCOL_3"},
				{{94, 255, 1}, "CMOD_NEONCOL_4"},
				{{255, 255, 0}, "CMOD_NEONCOL_5"},
				{{255, 150, 0}, "CMOD_NEONCOL_6"},
				{{255, 62, 0}, "CMOD_NEONCOL_7"},
				{{255, 1, 1}, "CMOD_NEONCOL_8"},
				{{255, 50, 100}, "CMOD_NEONCOL_9"},
				{{255, 5, 190}, "CMOD_NEONCOL_10"},
				{{35, 1, 255}, "CMOD_NEONCOL_11"},
				{{15, 3, 255}, "CMOD_NEONCOL_12"},
			},
		},
		licensePlates = {
			{3,GetLabelText("CMOD_PLA_0")},
			{0,GetLabelText("CMOD_PLA_1")},
			{4,GetLabelText("CMOD_PLA_2")},
			{2,GetLabelText("CMOD_PLA_3")},
			{1,GetLabelText("CMOD_PLA_4")},
			{5,"North Yankton"},
		},
		xenoncolors = {
			{-1, "Default"},
			{0, "White"},
			{1,"Blue"},
			{2,"Electric Blue"},
			{3,"Mint Green"},
			{4,"Lime Green"},
			{5,"Yellow"},
			{6,"Golden Shower"},
			{7,"Orange"},
			{8,"Red"},
			{9,"Pony Pink"},
			{10,"Hot Pink"},
			{11,"Purple"},
			{12,"Blacklight"},
		},
		windowTint = {
			{4,"Stock"},
			{3,"Lightsmoke"},
			{2,"Darksmoke"},
			{1,"Pure Black"},
			{5,"Green"},
			{0,"None"},
		},

		previousModValue = false,
		playerVehicle = false,
		colourSelector = false,
		extrasSelector = false,
		liverySelector = false,
		wheelSelector = false,
		vehModList = {},
	}

	-- General Menu Functions
	local function GetVehicle()
		local found = false
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		if veh ~= 0 then
			if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
				found = true
			end
		end
		return found, veh, (veh ~= 0 and GetEntityModel(veh) or false)
		-- return true when a vehicle is found and they are the driver, vehicle's ent id or false, vehicle's model or false
	end

	function OpenCustoms()
		local isInVehicle, veh, vehModel = GetVehicle()
		if isInVehicle then
			xnCustoms.playerVehicle = veh
			--SetVehicleAutoRepairDisabled(xnCustoms.playerVehicle, true)
			
			-- Generate Specific Mod List
			SetVehicleModKit(veh, 0)
			xnCustoms.vehModList = {}
			for _,mod in ipairs(xnCustoms.mods) do
				local thisIter = #xnCustoms.vehModList + 1
				local modName = mod.name
				if mod.id then
					if (GetEntityModel(veh) == joaat("DELUXO") and mod.id == 10) or (GetEntityModel(veh) == joaat("COMET4") and mod.id == 10) then
						-- This removes the weapon option for the Deluxo
					else
						local specificModName = GetModSlotName(veh,mod.id)
						local numVehMods = GetNumVehicleMods(veh,mod.id)

						if mod.name and (string.upper(mod.name) == mod.name) then
							modName = GetLabelText(mod.name)
						end

						if specificModName and GetModSlotName(veh,mod.id) ~= "" and not mod.noCustomName then
							if (string.upper(specificModName) == specificModName) then
								if GetLabelText(specificModName) ~= "NULL" then
									modName = GetLabelText(specificModName)
								else
									modName = specificModName
								end
							else
								modName = specificModName
							end
						end

						if numVehMods and numVehMods > 0 then
							xnCustoms.vehModList[thisIter] = {
								name = modName,
								mod = mod -- Keep the original pre-defined mod info for this id
							}
							local modType = xnCustoms.vehModList[thisIter]
							
							if mod.type == "auto" then
								modType.mods = {[-1]={name = "Stock "..modName},}

								local numVehMods = GetNumVehicleMods(veh,mod.id)
								-- Gets the localised name for each mod (if it exists @xX_cust0m_v3h1cl3_mak3rs_Xx)
								for i=0,numVehMods-1 do
									local realName = string.format("Custom %s %s", modName, i)
									local textLabel = GetModTextLabel(veh, mod.id, i)

									if textLabel then
										realName = GetLabelText(textLabel) ~= "NULL" and GetLabelText(textLabel) or realName
									end

									modType.mods[i] = {
										name = realName,
									}
								end
							elseif mod.type == "defined" then
								modType.mods = {}
								for i=-1,#mod.definedMods do
									modType.mods[i] = {name = mod.definedMods[i]}
								end
							end						
						end
					end
				end

				if xnCustoms.mods.customModTypes[mod.type] then
					xnCustoms.vehModList[thisIter] = {
						name = modName,
						mod = mod
					}
				end
			end
			
			if GetVehicleLiveryCount(veh) > 0 then
				xnCustoms.liverySelector = {liveries = {[-1] = "No Livery"}}
				local liveryCount = GetVehicleLiveryCount(veh)

				for i=0,liveryCount do
					local realName = string.format("Custom Livery %s", i)
					local textLabel = GetLiveryName(veh, i)
					if textLabel then
						realName = GetLabelText(textLabel)
					end
					xnCustoms.liverySelector.liveries[i] = realName
				end
			end

			for i=1,20 do
				if DoesExtraExist(veh, i) then
					xnCustoms.extrasSelector = xnCustoms.extrasSelector or {}
					xnCustoms.extrasSelector[#xnCustoms.extrasSelector+1] = i
				end
			end

			table.sort(xnCustoms.vehModList, function(a,b) return a.name < b.name end)
			JayMenu.OpenMenu("xncustoms")
		else
			Notify.Error("You are not currently in a vehicle.")
		end
	end
	local function CloseCustoms()
		xnCustoms.previousModValue = false
		xnCustoms.playerVehicle = false
		xnCustoms.colourSelector = false
		xnCustoms.liverySelector = false
		xnCustoms.wheelSelector = false
		xnCustoms.extrasSelector = false
		xnCustoms.vehModList = {}
		CamMode = GetFollowVehicleCamViewMode()
		EnableAllControlActions(0)
		if DoesEntityExist(hornCar) then
			SetEntityAsMissionEntity(hornCar, true, true)
			DeleteEntity(hornCar)
		end
		local isInVehicle, veh, vehModel = GetVehicle()
		TriggerServerEvent('prdx_modshop:updateVeh', QBCore.Functions.GetVehicleProperties(veh))
		--SetVehicleAutoRepairDisabled(veh, false)
		return true
	end
	RegisterNetEvent("xnCustoms:openMenu", function()
		OpenCustoms()
	end)

	-- Colour Selector Functions
	local function IsVehicleColour(slot, value)
		if slot == "primary" then
			local pr = GetVehicleColours(xnCustoms.playerVehicle)
			if pr == value then return true end
		elseif slot == "secondary" then
			local _, sc = GetVehicleColours(xnCustoms.playerVehicle)
			if sc == value then return true end
		elseif slot == "pearl" then
			local pl = GetVehicleExtraColours(xnCustoms.playerVehicle)
			if pl == value then return true end
		elseif slot == "wheel" then
			local _, wh = GetVehicleExtraColours(xnCustoms.playerVehicle)
			if wh == value then return true end
		elseif slot == "smoke" then
			local smr, smb, smg = GetVehicleTyreSmokeColor(xnCustoms.playerVehicle)
			if smr == value[1] and smb == value[2] and smg == value[3] then return true end
		elseif slot == "interior" then
			local col = GetVehicleInteriorColour(xnCustoms.playerVehicle)
			if col == value then return true end
		end
		return false
	end
	local function SetVehicleColour(slot, value, customTires)
		if slot == "primary" then
			SetVehicleColours(xnCustoms.playerVehicle, value, xnCustoms.previousModValue.secondary)
		elseif slot == "secondary" then
			SetVehicleColours(xnCustoms.playerVehicle, xnCustoms.previousModValue.primary, value)
		elseif slot == "pearl" then
			SetVehicleExtraColours(xnCustoms.playerVehicle, value, xnCustoms.previousModValue.wheel)
		elseif slot == "wheel" then
			SetVehicleExtraColours(xnCustoms.playerVehicle, xnCustoms.previousModValue.pearl, value)
		elseif slot == "smoke" then
			SetVehicleCustomTires(xnCustoms.playerVehicle, true)
			SetVehicleTyreSmokeColor(xnCustoms.playerVehicle, value[1], value[2], value[3])
		end
	end
	local function SaveVehicleColourInfo()
		local pr, sc = GetVehicleColours(xnCustoms.playerVehicle)
		local pl, wh = GetVehicleExtraColours(xnCustoms.playerVehicle)
		local smr, smb, smg = GetVehicleTyreSmokeColor(xnCustoms.playerVehicle)
		xnCustoms.previousModValue = {
			isColour = true,

			primary = pr,
			secondary = sc,
			pearl = pl,
			wheel = wh,
			smoke = {smr, smb, smg},
		}
	end
	local function ResetVehicleColour()
		if xnCustoms.previousModValue and xnCustoms.previousModValue.isColour then
			SetVehicleColours(xnCustoms.playerVehicle, xnCustoms.previousModValue.primary, xnCustoms.previousModValue.secondary)
			SetVehicleExtraColours(xnCustoms.playerVehicle, xnCustoms.previousModValue.pearl, xnCustoms.previousModValue.wheel)
			SetVehicleTyreSmokeColor(xnCustoms.playerVehicle, xnCustoms.previousModValue.smoke[1], xnCustoms.previousModValue.smoke[2], xnCustoms.previousModValue.smoke[3])
		end
	end
	local function SaveVehicleRGB(Type, R, G, B)
		if Type == "primary" then
			SetVehicleCustomPrimaryColour(xnCustoms.playerVehicle, R, G, B)
		else
			SetVehicleCustomSecondaryColour(xnCustoms.playerVehicle, R, G, B)
		end
	end
	local function VehicleRGB(colour)
		local red, green, blue = GetVehicleColor(xnCustoms.playerVehicle)
		if colour == "r" then
			return red
		elseif colour == "g" then
			return green
		else
			return blue
		end
	end

	-- Wheel Selector Functions
	local function CreateVehicleWheelModList()
		local wheels = {[-1]={name = "Stock Wheels"},}
		local modid = xnCustoms.wheelSelector.slot
		local veh = xnCustoms.playerVehicle

		for i=0,GetNumVehicleMods(veh, modid)-1 do
			local realName = string.format("Custom %s %s", GetLabelText(modName), i)
			local textLabel = GetModTextLabel(veh, modid, i)
			if textLabel then
				realName = GetLabelText(textLabel)
			end

			wheels[i] = {
				name = realName,
			}
		end

		return wheels
	end
	local function ResetVehicleWheels()
		if xnCustoms.previousModValue and xnCustoms.previousModValue.isWheel then
			ModVehicle(xnCustoms.playerVehicle, 23, xnCustoms.previousModValue.frontWheel)
			if xnCustoms.previousModValue.hasBackWheels then
				ModVehicle(xnCustoms.playerVehicle, 24, xnCustoms.previousModValue.backWheel)
			end
			SetVehicleWheelType(xnCustoms.playerVehicle, xnCustoms.previousModValue.wheelType)
		end
	end

	-- Neons Menu Functions
	local function DoNeonColoursMatch(nc1, nc2)
		return (nc1[1] == nc2[1] and nc1[2] == nc2[2] and nc1[3] == nc2[3])
	end


	local RGBValues = {}
	for i = 0, 255 do
		table.insert(RGBValues, i)
	end

	-- Notifs
	function LSCustomsNotif(msg)
		AddTextEntry("prdx_modshopPlate", msg)
		SetNotificationTextEntry("prdx_modshopPlate")
		DrawNotification(false, true)
	end

	-- Menu Thread
	CreateThread(function()
		JayMenu.CreateMenu("xncustoms", "Mod Shop", function()
			return CloseCustoms()
		end)
		JayMenu.SetSubTitle("xncustoms", "main menu")
		JayMenu.UseSpriteAsBackground("xncustoms", "shopui_title_carmod", "shopui_title_carmod", 255, 255, 255, 255)

		-- Auto generated mod menus
		for _,mod in ipairs(xnCustoms.mods) do
			if mod.type == "auto" or mod.type == "defined" then
				JayMenu.CreateSubMenu("xnc2_"..mod.id, "xncustoms", tostring(mod.id or ""), function()
					if xnCustoms.previousModValue then
						ModVehicle(xnCustoms.playerVehicle, mod.id, xnCustoms.previousModValue)
					end
					return true
				end)
			end
		end

		-- Respray Menu
		JayMenu.CreateSubMenu("xnc2_colour_slot", "xncustoms", "Respray", function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_colour_type", "xnc2_colour_slot", "Respray", function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_colour_interior", "xnc2_colour_type", "Interior Color", function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_colour_dashboard", "xnc2_colour_type", "Dashboard Color", function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_colour_custom", "xnc2_colour_type", "Custom Color", function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_colour_custom_2", "xnc2_colour_type", "Custom Color 2", function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_colour_select", "xnc2_colour_type", "Respray", function()
			ResetVehicleColour()
			return true
		end)
		
		-- Wheels menu
		JayMenu.CreateSubMenu("xnc2_wheel_slot", "xncustoms", GetLabelText("CMOD_MOD_WHEM"), function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_wheel_type", "xnc2_wheel_slot", GetLabelText("CMOD_MOD_WHE"), function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_wheel_select", "xnc2_wheel_type", GetLabelText("CMOD_MOD_WHEM"), function()
			ResetVehicleWheels()
			if xnCustoms.wheelSelector.isBike then
				SetTimeout(5, function()
					xnCustoms.wheelSelector = false
					JayMenu.SwitchMenu("xnc2_wheel_slot")
				end)
			end
			return true
		end)

		-- Liveries Menu
		JayMenu.CreateSubMenu("xnc2_liveries", "xncustoms", GetLabelText("CMOD_COL0_4"), function()
			if xnCustoms.previousModValue then
				SetVehicleLivery(xnCustoms.playerVehicle, xnCustoms.previousModValue)
			end
			return true
		end)

		-- Extras Menu
		JayMenu.CreateSubMenu("xnc2_extras", "xncustoms", "Extras", function()
				return true
		end)

		-- Lights Menu
		JayMenu.CreateSubMenu("xnc2_lights", "xncustoms", GetLabelText("CMOD_MOD_LGT"), function()
			return true
		end)

		-- Horns Menu
		JayMenu.CreateSubMenu("xnc2_horns", "xncustoms", "Horns", function()
			return true
		end)

		-- Lights Menu
		JayMenu.CreateSubMenu("xnc2_neons", "xnc2_lights", GetLabelText("CMOD_MOD_LGT_N"), function()
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_neons_colour", "xnc2_neons", GetLabelText("CMOD_NEON_1"), function()
			if xnCustoms.previousModValue then
				local neonCol = xnCustoms.colours.neon[xnCustoms.previousModValue][1]
				SetVehicleNeonLightsColour(xnCustoms.playerVehicle, neonCol[1], neonCol[2], neonCol[3])
			end
			return true
		end)
		JayMenu.CreateSubMenu("xnc2_neons_layout", "xnc2_neons", GetLabelText("CMOD_NEON_0"), function()
			return true
		end)

		-- Plates Menu
		JayMenu.CreateSubMenu('xnc2_plates', 'xncustoms', GetLabelText("CMM_MOD_G2"), function()
			if xnCustoms.previousModValue then
				SetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle, xnCustoms.previousModValue)
			end
		end)

		JayMenu.CreateSubMenu('xnc2_windowtints', 'xncustoms', "Window Tint", function()
			if xnCustoms.previousModValue then
				SetVehicleWindowTint(xnCustoms.playerVehicle, xnCustoms.previousModValue)
			end
		end)

		JayMenu.CreateSubMenu('xnc2_xenoncolors', 'xncustoms', "Xenon Colors", function()
			if xnCustoms.previousModValue then
				SetVehicleXenonLightsColor(xnCustoms.playerVehicle, xnCustoms.previousModValue)
			end
		end)
	end)

	CreateThread(function()
		while true do Wait(0)
			if JayMenu.IsMenuOpened("xncustoms") then
				SetFollowVehicleCamViewMode(CamMode)
				local CamMode = GetFollowVehicleCamViewMode()
				for i = 1,6 do
					local newi = i - 1
					local isopen = GetVehicleDoorAngleRatio(xnCustoms.playerVehicle, newi)
					if isopen == 0.0 or isopen == false then
					else
						SetVehicleDoorShut(xnCustoms.playerVehicle, newi)
					end
				end
				-- local repairCost = nil
				-- if GetVehicleClass(xnCustoms.playerVehicle) == 8 then
				-- 	repairCost = math.ceil((((GetEntityMaxHealth(xnCustoms.playerVehicle) - GetEntityHealth(xnCustoms.playerVehicle)) * 2) + math.ceil(GetVehicleDirtLevel(xnCustoms.playerVehicle) + 4)) / 3)
				-- else
				-- 	repairCost = math.ceil((((GetEntityMaxHealth(xnCustoms.playerVehicle) - GetEntityHealth(xnCustoms.playerVehicle)) * 2) + math.ceil(GetVehicleDirtLevel(xnCustoms.playerVehicle) + 4)) / 1.5) 
				-- end
				-- local button = ""
				-- if repairCost == 5 then
				-- 	button = "Clean Vehicle"
				-- else
				-- 	button = "Repair and Clean Vehicle"
				-- end
				-- if JayMenu.Button(button, "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * repairCost) then
				-- 	if BuyModWithCash(repairCost, xnCustoms.playerVehicle) then
				-- 		SetVehicleFixed(xnCustoms.playerVehicle)
				-- 		SetVehicleDirtLevel(xnCustoms.playerVehicle, 0.0)
				-- 		WashDecalsFromVehicle(xnCustoms.playerVehicle, 100.0)
				-- 		RemoveDecalsFromVehicle(xnCustoms.playerVehicle, false)
				-- 	else
				-- 		QBCore.Functions.Notify("You do not have enough cash for this mod.")
				-- 	end
				-- end
				for _,modType in ipairs(xnCustoms.vehModList) do
					if modType.mod.type == "auto" or modType.mod.type == "defined" then
						if JayMenu.MenuButton(modType.name,"xnc2_"..modType.mod.id) then
							xnCustoms.previousModValue = GetVehicleMod(xnCustoms.playerVehicle, modType.mod.id)
							JayMenu.SetSubTitle("xnc2_"..modType.mod.id, modType.name)
						end				
					elseif modType.mod.type == "toggle" then
						JayMenu.CheckBox(modType.name .. " - ~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * modType.mod.price, IsToggleModOn(xnCustoms.playerVehicle, modType.mod.id), function(checked) 
							if BuyModWithCash(Config.priceMultiplier * modType.mod.price, xnCustoms.playerVehicle) then
								ToggleVehicleMod(xnCustoms.playerVehicle, modType.mod.id, checked) 
							else
								QBCore.Functions.Notify("You do not have enough cash for this mod.")
							end
						end)
					elseif modType.mod.type == "neons_menu" then
						if JayMenu.MenuButton("Neons", "xnc2_neons") then end
					elseif modType.mod.type == "colour_selector" then
						if JayMenu.MenuButton("Respray", "xnc2_colour_slot") then
							SaveVehicleColourInfo()
						end
					elseif modType.mod.type == "wheel_selector" then
						if JayMenu.MenuButton(GetLabelText("CMOD_MOD_WHEM"), "xnc2_wheel_slot") then
							xnCustoms.previousModValue = {
								isWheel = true,
								frontWheel = GetVehicleMod(xnCustoms.playerVehicle, 23),
								backWheel = GetVehicleMod(xnCustoms.playerVehicle, 24),
								wheelType = GetVehicleWheelType(xnCustoms.playerVehicle),
							}
						end
					elseif modType.mod.type == "extras_selector" then
						if xnCustoms.extrasSelector and JayMenu.MenuButton("Extras", "xnc2_extras") then end
					elseif modType.mod.type == "lights_menu" then
						if JayMenu.MenuButton(GetLabelText("CMOD_MOD_LGT"), "xnc2_lights") then end
					elseif modType.mod.type == "plates_menu" then
						if JayMenu.MenuButton(GetLabelText("CMM_MOD_G2"), "xnc2_plates") then
							xnCustoms.previousModValue = GetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle)
						end
					elseif modType.mod.type == "window_menu" then
						if JayMenu.MenuButton("Window Tint", "xnc2_windowtints") then
							xnCustoms.previousModValue = GetVehicleWindowTint(xnCustoms.playerVehicle)
						end
					elseif modType.mod.type == "xenon_menu" then
						if JayMenu.MenuButton("Xenon Colors", "xnc2_xenoncolors") then
							xnCustoms.previousModValue = GetVehicleXenonLightsColor(xnCustoms.playerVehicle)
						end
					end
				end
				JayMenu.Display()
			elseif JayMenu.IsMenuOpened("xnc2_colour_slot") then
				if JayMenu.MenuButton("Primary Colour", "xnc2_colour_type") then
					xnCustoms.colourSelector = {
						slot = "primary",
					}
				end
				if JayMenu.MenuButton("Secondary Colour", "xnc2_colour_type") then
					xnCustoms.colourSelector = {
						slot = "secondary",
					}
				end
				if JayMenu.MenuButton("Interior Colour", "xnc2_colour_interior") then
					xnCustoms.colourSelector = {
						slot = "interior",
					}
				end
				if JayMenu.MenuButton("Pearlescent Colour", "xnc2_colour_select") then
					xnCustoms.colourSelector = {
						slot = "pearl",
						type = "pearl",
					}
				end
				if JayMenu.MenuButton("Wheel Colour", "xnc2_colour_select") then
					xnCustoms.colourSelector = {
						slot = "wheel",
						type = "classic",
					}
				end
				if JayMenu.MenuButton("Dashboard Colour", "xnc2_colour_dashboard") then
					xnCustoms.colourSelector = {
						slot = "dashboard",
					}
				end
				-- if JayMenu.MenuButton("Wheel Smoke Colour", "xnc2_colour_select") then
					-- xnCustoms.colourSelector = {
						-- slot = "smoke",
						-- type = "smoke",
					-- }
				-- end
				if xnCustoms.liverySelector and JayMenu.MenuButton("Livery", "xnc2_liveries") then
					xnCustoms.previousModValue = GetVehicleLivery(xnCustoms.playerVehicle)
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_liveries") then
				if xnCustoms.liverySelector and xnCustoms.liverySelector.liveries then
					for i= 0, #xnCustoms.liverySelector.liveries do
						if xnCustoms.previousModValue == i then
							local clicked, hovered = JayMenu.SpriteButton(xnCustoms.liverySelector.liveries[i], "commonmenu", "shop_garage_icon_a", "shop_garage_icon_b")
							if clicked and i ~= 0 then
								xnCustoms.previousModValue = 0
								SetVehicleLivery(xnCustoms.playerVehicle, i)
							elseif hovered then
								if GetVehicleLivery(xnCustoms.playerVehicle) ~= i then
									SetVehicleLivery(xnCustoms.playerVehicle, i)
								end
							end
						else
							local clicked, hovered = JayMenu.Button(xnCustoms.liverySelector.liveries[i], "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[1])
							if clicked then
								xnCustoms.previousModValue = i
								if BuyModWithCash(Config.itemCosts[1], xnCustoms.playerVehicle) then
									SetVehicleLivery(xnCustoms.playerVehicle, i)
								else
									QBCore.Functions.Notify("You do not have enough cash for this mod.")
								end
							elseif hovered then
								if GetVehicleLivery(xnCustoms.playerVehicle) ~= i then
									SetVehicleLivery(xnCustoms.playerVehicle, i)
								end
							end
						end
					end
				else
					JayMenu.SwitchMenu("xnc2_colour_slot")
					Notify.Error("Colour selector error!\nCheck console.")
					print("xnCustoms Error: The livery selector was accessed when the vehicle doesn't have any liveries defined")
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_colour_type") then
				if xnCustoms.colourSelector and xnCustoms.colourSelector.slot then
					if xnCustoms.colourSelector.slot == "wheel" or xnCustoms.colourSelector.slot == "smoke" or xnCustoms.colourSelector.slot == "pearl" or xnCustoms.colourSelector.slot == "interior" or xnCustoms.colourSelector.slot == "dashboard"then
						JayMenu.SwitchMenu("xnc2_colour_slot")
					else
						-- if JayMenu.MenuButton("Custom Colour", "xnc2_colour_select") then
						-- 	if xnCustoms.colourSelector.slot == "primary" then
						-- 		JayMenu.SwitchMenu("xnc2_colour_custom")
						-- 	else
						-- 		JayMenu.SwitchMenu("xnc2_colour_custom_2")
						-- 	end
						-- else
						if JayMenu.MenuButton("Chrome", "xnc2_colour_select") then
							xnCustoms.colourSelector.type = "chrome"
						elseif JayMenu.MenuButton("Classic", "xnc2_colour_select") then
							xnCustoms.colourSelector.type = "classic"
						elseif JayMenu.MenuButton("Matte", "xnc2_colour_select") then
							xnCustoms.colourSelector.type = "matte"
						elseif JayMenu.MenuButton("Metallic", "xnc2_colour_select") then
							xnCustoms.colourSelector.type = "metallic"
						elseif JayMenu.MenuButton("Metals", "xnc2_colour_select") then
							xnCustoms.colourSelector.type = "metals"
						elseif JayMenu.MenuButton("Util", "xnc2_colour_select") then
							xnCustoms.colourSelector.type = "util"
						elseif JayMenu.MenuButton("Worn", "xnc2_colour_select") then
							xnCustoms.colourSelector.type = "worn"
						end
					end
				else
					JayMenu.SwitchMenu("xnc2_colour_slot")
					Notify.Error("Colour selector error!\nCheck console.")
					print("xnCustoms Error: The colour type selector was accessed without first defining a slot")
				end
				JayMenu.Display()
			
			elseif JayMenu.IsMenuOpened("xnc2_colour_interior") then
				for _,colour in ipairs(xnCustoms.colours["classic"]) do
					local colourIndex = colour[1]
					local colourName = colour[2]

					if xnCustoms.previousModValue[xnCustoms.colourSelector.slot] == colourIndex then
						local clicked, hovered = JayMenu.SpriteButton(GetLabelText(colourName), "commonmenu", "shop_tick_icon")
						if clicked then
							if xnCustoms.colourSelector.slot == "pearl" then
								SetVehicleInteriorColour(xnCustoms.playerVehicle, xnCustoms.previousModValue["primary"])
							end
							SaveVehicleColourInfo()
						elseif hovered then
							if not IsVehicleColour(xnCustoms.colourSelector.slot, colourIndex) then
								SetVehicleInteriorColour(xnCustoms.playerVehicle, colourIndex)
							end
						end
					else
						local clicked, hovered = JayMenu.Button(GetLabelText(colourName), "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[44])
						if clicked then
							if BuyModWithCash(Config.itemCosts[44], xnCustoms.playerVehicle) then
								SetVehicleInteriorColour(xnCustoms.playerVehicle, colourIndex)
								SaveVehicleColourInfo()
							else
								QBCore.Functions.Notify("You do not have enough cash for this mod.")
							end
						elseif hovered then
							if not IsVehicleColour(xnCustoms.colourSelector.slot, colourIndex) then
								SetVehicleInteriorColour(xnCustoms.playerVehicle, colourIndex)
							end
						end
					end
				end
				JayMenu.Display()
			elseif JayMenu.IsMenuOpened("xnc2_colour_dashboard") then
				for _,colour in ipairs(xnCustoms.colours["classic"]) do
					local colourIndex = colour[1]
					local colourName = colour[2]

					if xnCustoms.previousModValue[xnCustoms.colourSelector.slot] == colourIndex then
						local clicked, hovered = JayMenu.SpriteButton(GetLabelText(colourName), "commonmenu", "shop_tick_icon")
						if clicked then
							if xnCustoms.colourSelector.slot == "pearl" then
								SetVehicleDashboardColor(xnCustoms.playerVehicle, xnCustoms.previousModValue["primary"])
							end
							SaveVehicleColourInfo()
						elseif hovered then
							if not IsVehicleColour(xnCustoms.colourSelector.slot, colourIndex) then
								SetVehicleDashboardColor(xnCustoms.playerVehicle, colourIndex)
							end
						end
					else
						local clicked, hovered = JayMenu.Button(GetLabelText(colourName), "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[44])
						if clicked then
							if BuyModWithCash(Config.itemCosts[44], xnCustoms.playerVehicle) then
								SetVehicleDashboardColor(xnCustoms.playerVehicle, colourIndex)
								SaveVehicleColourInfo()
							else
								QBCore.Functions.Notify("You do not have enough cash for this mod.")
							end
						elseif hovered then
							if not IsVehicleColour(xnCustoms.colourSelector.slot, colourIndex) then
								SetVehicleDashboardColor(xnCustoms.playerVehicle, colourIndex)
							end
						end
					end
				end
				JayMenu.Display()
			elseif JayMenu.IsMenuOpened("xnc2_colour_custom") then
				if JayMenu.ComboBox('Red', RGBValues, Red_index or 1, VehicleRGB("red") or 1, function(currentIndex, selectedIndex)
					Red_index = currentIndex
					Red_selected = selectedIndex
					SetVehicleCustomPrimaryColour(xnCustoms.playerVehicle, currentIndex, Green_selected, Blue_selected)
				end) then
					SetVehicleCustomPrimaryColour(xnCustoms.playerVehicle, Red_selected, Green_selected, Blue_selected)
				end
				if JayMenu.ComboBox('Green', RGBValues, Green_index or 1, VehicleRGB("green") or 1, function(currentIndex, selectedIndex)
					Green_index = currentIndex
					Green_selected = selectedIndex
					SetVehicleCustomPrimaryColour(xnCustoms.playerVehicle, Red_selected, currentIndex, Blue_selected)
				end) then
					SetVehicleCustomPrimaryColour(xnCustoms.playerVehicle, Red_selected, Green_selected, Blue_selected)
				end
				if JayMenu.ComboBox('Blue', RGBValues, Blue_index or 1, VehicleRGB("blue") or 1, function(currentIndex, selectedIndex)
					Blue_index = currentIndex
					Blue_selected = selectedIndex
					SetVehicleCustomPrimaryColour(xnCustoms.playerVehicle, Red_selected, Green_selected, currentIndex)
				end) then
					SetVehicleCustomPrimaryColour(xnCustoms.playerVehicle, Red_selected, Green_selected, Blue_selected)
				end
				if JayMenu.Button("Confirm Choice", "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[44]) then
					SetVehicleCustomPrimaryColour(xnCustoms.playerVehicle, Red_selected, Green_selected, currentIndex)
				end
				JayMenu.Display()
			elseif JayMenu.IsMenuOpened("xnc2_colour_custom_2") then
				if JayMenu.ComboBox('Red', RGBValues, Red_index or 1, Red_selected or 1, function(currentIndex, selectedIndex)
					Red_index = currentIndex
					Red_selected = selectedIndex
					SetVehicleCustomSecondaryColour(xnCustoms.playerVehicle, currentIndex, Green_selected, Blue_selected)
				end) then
				end
				if JayMenu.ComboBox('Green', RGBValues, Green_index or 1, Green_selected or 1, function(currentIndex, selectedIndex)
					Green_index = currentIndex
					Green_selected = selectedIndex
					SetVehicleCustomSecondaryColour(xnCustoms.playerVehicle, Red_selected, currentIndex, Blue_selected)
				end) then
				end
				if JayMenu.ComboBox('Blue', RGBValues, Blue_index or 1, Blue_selected or 1, function(currentIndex, selectedIndex)
					Blue_index = currentIndex
					Blue_selected = selectedIndex
					SetVehicleCustomSecondaryColour(xnCustoms.playerVehicle, Red_selected, Green_selected, currentIndex)
				end) then
				end
				if JayMenu.Button("Confirm Choice", "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[44]) then
					SetVehicleCustomSecondaryColour(xnCustoms.playerVehicle, Red_selected, Green_selected, Blue_selected)
				end
				JayMenu.Display()
			elseif JayMenu.IsMenuOpened("xnc2_colour_select") then
				if xnCustoms.colourSelector and xnCustoms.colourSelector.slot and xnCustoms.colourSelector.type then
					for _,colour in ipairs(xnCustoms.colours[xnCustoms.colourSelector.type]) do
						local colourIndex = colour[1]
						local colourName = colour[2]

						if xnCustoms.previousModValue[xnCustoms.colourSelector.slot] == colourIndex then
							local clicked, hovered = JayMenu.SpriteButton(GetLabelText(colourName), "commonmenu", "shop_tick_icon")
							if clicked then
								if xnCustoms.colourSelector.slot == "pearl" then
									SetVehicleColour("pearl", xnCustoms.previousModValue["primary"])
								end
								SaveVehicleColourInfo()
							elseif hovered then
								if not IsVehicleColour(xnCustoms.colourSelector.slot, colourIndex) then
									SetVehicleColour(xnCustoms.colourSelector.slot, colourIndex)
								end
							end
						else
							local clicked, hovered = JayMenu.Button(GetLabelText(colourName), "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[44])
							if clicked then
								if BuyModWithCash(Config.itemCosts[44], xnCustoms.playerVehicle) then
									SetVehicleColour(xnCustoms.colourSelector.slot, colourIndex)
									SaveVehicleColourInfo()
								else
									QBCore.Functions.Notify("You do not have enough cash for this mod.")
								end
							elseif hovered then
								if not IsVehicleColour(xnCustoms.colourSelector.slot, colourIndex) then
									SetVehicleColour(xnCustoms.colourSelector.slot, colourIndex)
								end
							end
						end
					end
				else
					JayMenu.SwitchMenu("xnc2_colour_slot")
					Notify.Error("Colour selector error!\nCheck console.")
					print("xnCustoms Error: The colour selector was accessed without first defining a type")
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_wheel_slot") then
				if xnCustoms.wheelSelector then
					JayMenu.SwitchMenu("xncustoms")
					xnCustoms.wheelSelector = false
				else
					if IsThisModelABike(GetEntityModel(xnCustoms.playerVehicle)) and GetNumVehicleMods(xnCustoms.playerVehicle, 24) > 0 then
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE0_0"), "xnc2_wheel_type") then
							xnCustoms.wheelSelector = {
								slot = 23,
								isBike = true,
							}
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE0_1"), "xnc2_wheel_type") then
							xnCustoms.wheelSelector = {
								slot = 24,
								isBike = true,
							}
						end
						if JayMenu.CheckBox(GetLabelText("CMOD_TYR_1"), GetVehicleCustomTiresEnabled(xnCustoms.playerVehicle), function(checked) SetVehicleCustomTires(xnCustoms.playerVehicle, checked) end) then end
						-- if JayMenu.CheckBox(GetLabelText("CMOD_TYR_2"), GetVehicleTyresCanBurst(xnCustoms.playerVehicle), function(checked) SetVehicleTyresCanBurst(xnCustoms.playerVehicle, checked) end) then end
					else
						xnCustoms.wheelSelector = {
							slot = 23,
						}
						JayMenu.SwitchMenu("xnc2_wheel_type")
					end
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_wheel_type") then
				if xnCustoms.wheelSelector.slot then
					if xnCustoms.wheelSelector.isBike then
						SetVehicleWheelType(xnCustoms.playerVehicle, 6)
						xnCustoms.wheelSelector.type = 6
						xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						JayMenu.SwitchMenu("xnc2_wheel_select")
					else
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_5"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 0)
							xnCustoms.wheelSelector.type = 0
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_3"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 1)
							xnCustoms.wheelSelector.type = 1
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_2"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 2)
							xnCustoms.wheelSelector.type = 2
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_6"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 3)
							xnCustoms.wheelSelector.type = 3
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_4"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 4)
							xnCustoms.wheelSelector.type = 4
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_7"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 5)
							xnCustoms.wheelSelector.type = 5
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_1"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 7)
							xnCustoms.wheelSelector.type = 7
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_8"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 8)
							xnCustoms.wheelSelector.type = 8
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_9"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 9)
							xnCustoms.wheelSelector.type = 9
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_10"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 10)
							xnCustoms.wheelSelector.type = 10
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_11"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 11)
							xnCustoms.wheelSelector.type = 11
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.MenuButton(GetLabelText("CMOD_WHE1_12"), "xnc2_wheel_select") then
							SetVehicleWheelType(xnCustoms.playerVehicle, 12)
							xnCustoms.wheelSelector.type = 12
							xnCustoms.wheelSelector.thisVehicleWheelTypes = CreateVehicleWheelModList()
						end
						if JayMenu.CheckBox(GetLabelText("CMOD_TYR_1"), GetVehicleCustomTiresEnabled(xnCustoms.playerVehicle), function(checked) SetVehicleCustomTires(xnCustoms.playerVehicle, checked) end) then end
						-- if JayMenu.CheckBox(GetLabelText("CMOD_TYR_2"), GetVehicleTyresCanBurst(xnCustoms.playerVehicle), function(checked) SetVehicleTyresCanBurst(xnCustoms.playerVehicle, checked) end) then end
					end
				else
					JayMenu.SwitchMenu("xncustoms")
					Notify.Error("Wheel selector error!\nCheck console.")
					print("xnCustoms Error: The wheel type selector was accessed without first defining the wheel slot.")
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_wheel_select") then
				if xnCustoms.wheelSelector.slot and xnCustoms.wheelSelector.type then
					for i=-1,#xnCustoms.wheelSelector.thisVehicleWheelTypes do
						local veh = xnCustoms.playerVehicle
						local mod = xnCustoms.wheelSelector.thisVehicleWheelTypes[i]
						local modid = xnCustoms.wheelSelector.slot

						if ((xnCustoms.wheelSelector.slot == 24 and xnCustoms.previousModValue.backWheel or xnCustoms.previousModValue.frontWheel) == i) and xnCustoms.wheelSelector.type == xnCustoms.previousModValue.wheelType then
							local clicked, hovered = JayMenu.SpriteButton(mod.name, "commonmenu", "shop_garage_icon_a", "shop_garage_icon_b")
							if clicked and i ~= -1 then
								if xnCustoms.wheelSelector.slot == 24 then
									xnCustoms.previousModValue.backWheel = -1
									xnCustoms.previousModValue.hasBackWheels = true
								else
									xnCustoms.previousModValue.frontWheel = -1
								end
								xnCustoms.previousModValue.wheelType = xnCustoms.wheelSelector.type
							elseif hovered then
								if GetVehicleMod(veh, modid) ~= i then
									ModVehicle(veh, modid, i)
								end
							end
						else
							local clicked, hovered = JayMenu.Button(mod.name, "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[2])
							if clicked then
								if xnCustoms.wheelSelector.slot == 24 then
									xnCustoms.previousModValue.backWheel = i
									xnCustoms.previousModValue.hasBackWheels = true
								else
									xnCustoms.previousModValue.frontWheel = i
								end
								if BuyModWithCash(Config.itemCosts[2], xnCustoms.playerVehicle) then
									xnCustoms.previousModValue.wheelType = xnCustoms.wheelSelector.type
									ModVehicle(veh, modid, i)
								else
									QBCore.Functions.Notify("You do not have enough cash for this mod.")
								end
							elseif hovered then
								if GetVehicleMod(veh, modid) ~= i then
									ModVehicle(veh, modid, i)
								end
							end
						end
					end
				else
					JayMenu.SwitchMenu("xncustoms")
					Notify.Error("Wheel selector error!\nCheck console.")
					print("xnCustoms Error: The wheel selector was accessed without first defining the wheel slot and/or the wheel type.")
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_extras") then
				if xnCustoms.extrasSelector then
					for i,extraId in ipairs(xnCustoms.extrasSelector) do
						if JayMenu.CheckBox("Extra "..i, IsVehicleExtraTurnedOn(xnCustoms.playerVehicle, extraId), function(checked) SetVehicleExtra(xnCustoms.playerVehicle, extraId, not checked) end) then end
					end
				else
					JayMenu.SwitchMenu("xncustoms")
					Notify.Error("Extras menu error!\nCheck console.")
					print("xnCustoms Error: The extras menu was accessed when the vehicle does not have any extras.")
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_lights") then
				if JayMenu.CheckBox(GetLabelText("CMOD_LGT_1"), IsToggleModOn(xnCustoms.playerVehicle, 22), function(checked) ToggleVehicleMod(xnCustoms.playerVehicle, 22, checked) end) then end
				if JayMenu.MenuButton(GetLabelText("CMOD_MOD_LGT_N"), "xnc2_neons") then end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_neons") then
				if JayMenu.MenuButton(GetLabelText("CMOD_NEON_0"), "xnc2_neons_layout") then
				elseif JayMenu.MenuButton(GetLabelText("CMOD_NEON_1"), "xnc2_neons_colour") then 
					local r, g, b = GetVehicleNeonLightsColour(xnCustoms.playerVehicle)
					for k,v in ipairs(Config.AllNeonColours) do
						if v[1][1] == r and v[1][2] == g and v[1][3] == b then
							xnCustoms.previousModValue = k
						end
					end
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_neons_layout") then
				if JayMenu.CheckBox(GetLabelText("CMOD_NEONLAY_1") .. " - ~HUD_COLOUR_GREENDARK~$" .. Config.itemCosts[45] * 3, IsVehicleNeonLightEnabled(xnCustoms.playerVehicle, 2), function(checked) 
					if BuyModWithCash(Config.itemCosts[45], xnCustoms.playerVehicle) then
						SetVehicleNeonLightEnabled(xnCustoms.playerVehicle, 2, checked)
					else
						QBCore.Functions.Notify("You do not have enough cash for this mod.")
					end 
				end) then end
				if JayMenu.CheckBox(GetLabelText("CMOD_NEONLAY_2") .. " - ~HUD_COLOUR_GREENDARK~$" .. Config.itemCosts[45] * 3, IsVehicleNeonLightEnabled(xnCustoms.playerVehicle, 3), function(checked) 
					if BuyModWithCash(Config.itemCosts[45], xnCustoms.playerVehicle) then
						SetVehicleNeonLightEnabled(xnCustoms.playerVehicle, 3, checked)
					else
						QBCore.Functions.Notify("You do not have enough cash for this mod.")
					end
				end) then end
				if JayMenu.CheckBox("Left" .. " - ~HUD_COLOUR_GREENDARK~$" .. Config.itemCosts[45] * 3, IsVehicleNeonLightEnabled(xnCustoms.playerVehicle, 0), function(checked) 
					if BuyModWithCash(Config.itemCosts[45], xnCustoms.playerVehicle) then
						SetVehicleNeonLightEnabled(xnCustoms.playerVehicle, 0, checked)
					else
						QBCore.Functions.Notify("You do not have enough cash for this mod.")
					end 
				end) then end
				if JayMenu.CheckBox("Right" .. " - ~HUD_COLOUR_GREENDARK~$" .. Config.itemCosts[45] * 3, IsVehicleNeonLightEnabled(xnCustoms.playerVehicle, 1), function(checked) 
					if BuyModWithCash(Config.itemCosts[45], xnCustoms.playerVehicle) then
						SetVehicleNeonLightEnabled(xnCustoms.playerVehicle, 1, checked)
					else
						QBCore.Functions.Notify("You do not have enough cash for this mod.")
					end
				end) then end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_neons_colour") then
				for i,colour in ipairs(xnCustoms.colours.neon) do
					if xnCustoms.previousModValue == i then
						local _, hovered = JayMenu.SpriteButton(GetLabelText(colour[2]), "commonmenu", "shop_tick_icon")
						if hovered then
							if not DoNeonColoursMatch({GetVehicleNeonLightsColour(xnCustoms.playerVehicle)},colour[1]) then
								SetVehicleNeonLightsColour(xnCustoms.playerVehicle, colour[1][1], colour[1][2], colour[1][3])
							end
						end
					else
						local clicked, hovered = JayMenu.Button(GetLabelText(colour[2]), "~HUD_COLOUR_GREENDARK~$" .. Config.itemCosts[45])
						if clicked then
							if BuyModWithCash(Config.itemCosts[45], xnCustoms.playerVehicle) then
								xnCustoms.previousModValue = i
								SetVehicleNeonLightsColour(xnCustoms.playerVehicle, colour[1][1], colour[1][2], colour[1][3])
							else
								QBCore.Functions.Notify("You do not have enough cash for this mod.")
							end
						elseif hovered then
							if not DoNeonColoursMatch({GetVehicleNeonLightsColour(xnCustoms.playerVehicle)},colour[1]) then
								SetVehicleNeonLightsColour(xnCustoms.playerVehicle, colour[1][1], colour[1][2], colour[1][3])
							end
						end
					end
				end
				JayMenu.Display()
			

			elseif JayMenu.IsMenuOpened("xnc2_plates") then
				for _,plate in ipairs(xnCustoms.licensePlates) do
					if xnCustoms.previousModValue == plate[1] then
						local clicked, hovered = JayMenu.SpriteButton(plate[2], "commonmenu", "shop_garage_icon_a", "shop_garage_icon_b")
						if hovered then
							if GetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle) ~= plate[1] then
								SetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle, plate[1])
							end
						end
					else
						local clicked, hovered = JayMenu.Button(plate[2], "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[46])
						if clicked then
							if BuyModWithCash(Config.itemCosts[46], xnCustoms.playerVehicle) then
								SetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle, plate[1])
								xnCustoms.previousModValue = plate[1]
							else
								QBCore.Functions.Notify("You do not have enough cash for this mod.")
							end
						elseif hovered then
							if GetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle) ~= plate[1] then
								SetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle, plate[1])
							end
						end
					end
				end

				local clicked, hovered = JayMenu.Button(GetLabelText("VEUI_TEXT_STRING_EDIT"), "~HUD_COLOUR_GREENDARK~$" .. 3 * Config.itemCosts[47])
				if clicked then
					local result = ""
					local currentPlateText = QBCore.Functions.GetPlate(xnCustoms.playerVehicle)
					DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", currentPlateText:gsub("%s+", ""), "", "", "", 8)
					while (UpdateOnscreenKeyboard() == 0) do
						DisableAllControlActions(0)
						Wait(0)
					end
					if (UpdateOnscreenKeyboard() == 1 and GetOnscreenKeyboardResult() ~= "") then
						local result = GetOnscreenKeyboardResult()
						local spcaecheck = string.sub(result, 1, 2)
						if not result:match("[^%w%s]") and result ~= "" and spcaecheck ~= ' ' then
							QBCore.Functions.TriggerCallback('prdx_modshop:CheckPlate', function(data)
								if tostring(data) ~= tostring('Rejection') then
									if next(data) == nil then
										if BuyModWithCash(3 * Config.itemCosts[47], xnCustoms.playerVehicle) then
											SetVehicleNumberPlateText(xnCustoms.playerVehicle, string.sub(result,1,8))
											Wait(250)
											local mods = QBCore.Functions.GetVehicleProperties(xnCustoms.playerVehicle)
											local plate = QBCore.Functions.GetPlate(xnCustoms.playerVehicle)
											Wait(1000) -- Let game update plate
											TriggerServerEvent('prdx_modshop:UpdatePlate', currentPlateText, plate, mods)
											TriggerEvent("vehiclekeys:client:SetOwner", plate)
										else
											QBCore.Functions.Notify("You do not have enough cash for this mod.")
										end
									else
										QBCore.Functions.Notify("The plate " .. string.upper(result) .. " is already registered with the DMV. Please choose another.")
										SetVehicleNumberPlateText(xnCustoms.playerVehicle, string.sub(currentPlateText,1,8))
									end
								end
							end, result, currentPlateText)
						else
							QBCore.Functions.Notify("The license plate can only contain alphanumeric values (A-Z, 0-9 and Spaces). No spaces a the start of the plate. Please choose another plate.")
							SetVehicleNumberPlateText(xnCustoms.playerVehicle, string.sub(currentPlateText,1,8))
						end
					elseif UpdateOnscreenKeyboard() == 2 then
						SetVehicleNumberPlateText(xnCustoms.playerVehicle, string.sub(currentPlateText,1,8))
					else
						QBCore.Functions.Notify("Invalid plate text!")
					end
				elseif hovered then
					if GetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle) ~= xnCustoms.previousModValue then
						SetVehicleNumberPlateTextIndex(xnCustoms.playerVehicle, xnCustoms.previousModValue)
					end
				end
				JayMenu.Display()
			

		elseif JayMenu.IsMenuOpened("xnc2_windowtints") then
			for _,tint in ipairs(xnCustoms.windowTint) do
				if xnCustoms.previousModValue == tint[1] then
					local clicked, hovered = JayMenu.SpriteButton(tint[2], "commonmenu", "shop_garage_icon_a", "shop_garage_icon_b")
					if hovered then
						if GetVehicleWindowTint(xnCustoms.playerVehicle) ~= tint[1] then
							SetVehicleWindowTint(xnCustoms.playerVehicle, tint[1])
						end
					end
				else
					local clicked, hovered = JayMenu.Button(tint[2], "~HUD_COLOUR_GREENDARK~$" .. Config.priceMultiplier * Config.itemCosts[48])
					if clicked then
						if BuyModWithCash(Config.itemCosts[46], xnCustoms.playerVehicle) then
							SetVehicleWindowTint(xnCustoms.playerVehicle, tint[1])
							xnCustoms.previousModValue = tint[1]
						else
							QBCore.Functions.Notify("You do not have enough cash for this mod.")
						end
					elseif hovered then
						if GetVehicleWindowTint(xnCustoms.playerVehicle) ~= tint[1] then
							SetVehicleWindowTint(xnCustoms.playerVehicle, tint[1])
						end
					end
				end
			end
			JayMenu.Display()

		elseif JayMenu.IsMenuOpened("xnc2_xenoncolors") then
			for _,color in ipairs(xnCustoms.xenoncolors) do
				if xnCustoms.previousModValue == color[1] then
					local clicked, hovered = JayMenu.SpriteButton(color[2], "commonmenu", "shop_garage_icon_a", "shop_garage_icon_b")
					if hovered then
						if GetVehicleXenonLightsColor(xnCustoms.playerVehicle) ~= color[1] then
							SetVehicleXenonLightsColor(xnCustoms.playerVehicle, color[1])
						end
					end
				else
					local clicked, hovered = JayMenu.Button(color[2], "~HUD_COLOUR_GREENDARK~" .. Config.itemCosts[9] .. ' Car Parts')
					if clicked then
						if BuyModWithCash(Config.itemCosts[9], xnCustoms.playerVehicle) then
							SetVehicleXenonLightsColor(xnCustoms.playerVehicle, color[1])
							xnCustoms.previousModValue = color[1]
						else
							ExM.ShowNotification("~r~You do not have enough parts for this mod.")
						end
					elseif hovered then
						if GetVehicleXenonLightsColor(xnCustoms.playerVehicle) ~= color[1] then
							SetVehicleXenonLightsColor(xnCustoms.playerVehicle, color[1])
						end
					end
				end
			end
			JayMenu.Display()
			
			elseif IsCustomsOpen() then
				for _,modType in ipairs(xnCustoms.vehModList) do
					if not xnCustoms.mods.customModTypes[modType.mod.type] and JayMenu.IsMenuOpened("xnc2_"..modType.mod.id) then
						modType.mod.displayHandler(modType, xnCustoms.playerVehicle)
					end
				end
				JayMenu.Display()
			end

			-- elseif IsControlJustReleased(0, 167) then
				-- OpenCustoms()
				-- 
			-- end
			
			if IsCustomsOpen() then
				DisableControlAction(0, 75, true)
				DisableControlAction(0, 71, true)
				DisableControlAction(0, 72, true)
				DisableControlAction(0, 86, true)
				form = setupScaleform2("instructional_buttons")
				DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
			end
		end
	end)

	RegisterNetEvent('QBCore:enteredVehicle', function (currentVehicle, currentSeat) -- Allow pax to see blips
		local CurrentClass = GetVehicleClass(currentVehicle)
		for k, v in ipairs(Config.Locations) do -- Activate blips for only vehicle class
			if v.blip then
				if v.shopType == 'LSCustomsInt' or v.shopType == 'LSCustoms' then
					if CurrentClass ~= 20 and CurrentClass ~= 17 and CurrentClass ~= 10 and CurrentClass ~= 11 and CurrentClass ~= 19 and CurrentClass ~= 15 and CurrentClass ~= 16 and CurrentClass ~= 14 then
						local blip = AddBlipForCoord(v.coords)
						SetBlipSprite(blip, 72)
						SetBlipScale(blip, 0.5)
						SetBlipAsShortRange(blip, true)
						BlipData[#BlipData+1] = blip
					end
				elseif v.shopType == 'Commercial' then
					if CurrentClass == 20 or CurrentClass == 17 or CurrentClass == 10 or CurrentClass == 11 or CurrentClass == 19 then
						local blip = AddBlipForCoord(v.coords)
						SetBlipSprite(blip, 72)
						SetBlipColour(blip, 25)
						SetBlipScale(blip, 0.5)
						SetBlipAsShortRange(blip,true)
						BeginTextCommandSetBlipName("CLSCPara")
						EndTextCommandSetBlipName(blip)
						BlipData[#BlipData+1] = blip
					end
				elseif v.shopType == 'Aircraft' then
					if CurrentClass == 15 or CurrentClass == 16 then
						local blip = AddBlipForCoord(v.coords)
						SetBlipSprite(blip, 72)
						SetBlipColour(blip, 64)
						SetBlipScale(blip, 0.5)
						SetBlipAsShortRange(blip,true)
						BeginTextCommandSetBlipName("AirLSCPara")
						EndTextCommandSetBlipName(blip)
						BlipData[#BlipData+1] = blip
					end
				elseif v.shopType == 'Boat' then
					if CurrentClass == 14 then
						local blip = AddBlipForCoord(v.coords)
						SetBlipSprite(blip, 72)
						SetBlipColour(blip, 26)
						SetBlipScale(blip, 0.5)
						SetBlipAsShortRange(blip,true)
						BeginTextCommandSetBlipName("BoatLSCPara")
						EndTextCommandSetBlipName(blip)
						BlipData[#BlipData+1] = blip
					end
				end
			end
		end
	end)
	
	RegisterNetEvent('QBCore:leftVehicle', function() -- Remove blips
		if BlipData then
			for k,v in pairs(BlipData) do
				RemoveBlip(v)
			end
		end
		BlipData = {}
		if ShownText then
			exports['qb-core']:HideText()
			ShownText = false
		end
	end)

	RegisterNetEvent('QBCore:drivingVehicle', function(driving, currentVehicle)
		if driving and isDriving then return end -- prevent duplicate loops
		isDriving = driving
		while isDriving do
			local passed = false
			local currentInterior = GetInteriorFromEntity(PlayerPedId())
			local idle = 500
			if CurrentShop then
				idle = 0
				passed = true
				if not ShownText then
					ShownText = true
					exports['qb-core']:DrawText('[E] - Vehicle Customs')
				end
				if IsControlJustPressed(0, 38) then
					OpenCustoms()
                    exports['qb-core']:KeyPressed()
					ShownText = false
					idle = 2500
				end
			elseif currentInterior > 0 then
				if interiorIds then
					for _,interiorId in ipairs(interiorIds) do
						if currentInterior == interiorId then
							idle = 0
							passed = true
							if not ShownText then
								ShownText = true
								exports['qb-core']:DrawText('[E] - Vehicle Customs')
							end
							if IsControlJustPressed(0, 38) then
								OpenCustoms()
								exports['qb-core']:KeyPressed()
								ShownText = false
								idle = 2500
							end
						end
					end
				end
				if not passed then
					if ShownText then
						exports['qb-core']:HideText()
						ShownText = false
					end
				end
			elseif not passed then
				if ShownText then
					exports['qb-core']:HideText()
					ShownText = false
				end
			end
			Wait(idle)	
		end
	end)
	
	AddEventHandler('onResourceStop', function(resource)
		if resource == currentResourceName then
			if MasterZones then
				for k, v in pairs(MasterZones) do
					exports['polyzonehelper']:DeletePolyZone("InModShop")
				end
			end
		end
	end)
end)
