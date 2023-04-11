
local QBCore = exports['qb-core']:GetCoreObject()
local fishing = false
local pause = false
local pausetimer = 0
local correct = 0
local genderNum = 0
local peds = {} 
local rodHandle
local rentalVehicle = nil

--============================================================== For testing

if Config.TestFish then 
	RegisterCommand("startfish", function(source)
		TriggerEvent("fishing:fishstart")
	end)

	RegisterCommand('spawnfish', function()
	 	TriggerServerEvent('fishing:server:catch') 
	end)
end

--============================================================== Threads
CreateThread(function()
	while true do
		Wait(1200)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1)
		if fishing then
				if IsControlJustReleased(0, 23) then
					input = 1
			   	end

			if IsControlJustReleased(0, Config.StopFishing) then
				endFishing()
				QBCore.Functions.Notify('You Stopped Fishing', 'error')
			end

			if fishing then
				playerPed = PlayerPedId()
				local pos = GetEntityCoords(playerPed)
				if GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z -3.0)  then
				else
					endFishing()
					QBCore.Functions.Notify('Water isnt deep enough to fish', 'error')
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					endFishing()
					QBCore.Functions.Notify('Fishing ended', 'error')
				end
			end
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerEvent('fishing:SkillBar')
				else
					QBCore.Functions.Notify('The Fish Escaped!', 'error')
					loseBait()
				end
			end
		end
	end
end)

CreateThread(function()
	while true do
		local wait = 5000
		if fishing then
			wait = math.random(Config.FishingWaitTime.minTime , Config.FishingWaitTime.maxTime)
			pause = true
			correct = 1
			QBCore.Functions.Notify("Something is on the line...")         
			input = 1
			pausetimer = 0
		end
		Wait(wait)
	end
end)

CreateThread(function()
	while true do
		Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)

			if dist < 50.0 and not peds[k] then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end

			if dist >= 50.0 and peds[k] then
				for i = 255, 0, -51 do
					Wait(50)
					SetEntityAlpha(peds[k].ped, i, false)
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end)

--============================================================== Events

RegisterNetEvent('fishing:client:progressBar', function()
	exports['progressBars']:drawBar(1000, 'Opening Tackel Box')
end)

RegisterNetEvent('fishing:client:attemptTreasureChest', function()
	local ped = PlayerPedId()
	attemptTreasureChest()
	if QBCore.Functions.HasItem('fishingkey') then
		QBCore.Functions.Progressbar("accepted_key", "Unlocking Chest..", (math.random(2000, 5000)), false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "mini@repair",
			anim = "fixing_a_player",
			flags = 16,
		}, {}, {}, function() -- Done
			ClearPedTasks(ped)
			openedTreasureChest()
		end, function() -- Cancel
			ClearPedTasks(ped)
			QBCore.Functions.Notify("Canceled!", "error")
		end)
	else
		QBCore.Functions.Notify("You dont have a key to this lock!", "error")
	end
end)

RegisterNetEvent('fishing:SkillBar', function(message)
if Config.Skillbar == "skillcheck" then
		-- local result = exports["skillcheck"]:StartCheck(5, 3)
		local skillcheck = { areaSize = 50, speedMultiplier = 1 }
		local result = lib.skillCheck({skillcheck, skillcheck, skillcheck})
        if result then 
            QBCore.Functions.Progressbar("", "Trying to reel in...", 10000, false, true, {
                disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function()
					catchAnimation()                                         
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end)
        else 
             QBCore.Functions.Progressbar("", "Trying to reel in...", 1000, false, true, {
                 disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function()
					loseBait()		
			 		QBCore.Functions.Notify('The Fish Escaped!', 'error')
					
             end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            end)
        end
	end
end) 

RegisterNetEvent('fishing:client:spawnFish', function(args)
	local time = 10000
	local args = tonumber(args)
	if args == 1 then 
		RequestTheModel("A_C_KillerWhale")
		local pos = GetEntityCoords(PlayerPedId())
		local positionOffset = GetEntityForwardVector(PlayerPedId())
		local spawnPoint = pos - (positionOffset * 3)
		local ped = CreatePed(29, `A_C_KillerWhale`, spawnPoint.x, spawnPoint.y, spawnPoint.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_KillerWhale`)
		Wait(time)
		DeletePed(ped)	
	elseif args == 2 then 
		RequestTheModel("A_C_dolphin")
		local pos = GetEntityCoords(PlayerPedId())
		local positionOffset = GetEntityForwardVector(PlayerPedId())
		local spawnPoint = pos - (positionOffset * 3)
		local ped = CreatePed(29, `A_C_dolphin`, spawnPoint.x, spawnPoint.y, spawnPoint.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_dolphin`)
		Wait(time)
		DeletePed(ped)
	elseif args == 3 then
		RequestTheModel("A_C_sharkhammer")
		local pos = GetEntityCoords(PlayerPedId())

		local positionOffset = GetEntityForwardVector(PlayerPedId())
		local spawnPoint = pos - (positionOffset * 3)
		local ped = CreatePed(29, `A_C_sharkhammer`, spawnPoint.x, spawnPoint.y, spawnPoint.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_sharkhammer`)
		Wait(time)
		DeletePed(ped)
	elseif args == 4 then
		RequestTheModel("A_C_SharkTiger")
		local pos = GetEntityCoords(PlayerPedId())
		local positionOffset = GetEntityForwardVector(PlayerPedId())
		local spawnPoint = pos - (positionOffset * 3)
		local ped = CreatePed(29, `A_C_SharkTiger`, spawnPoint.x, spawnPoint.y, spawnPoint.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_SharkTiger`)
		Wait(time)
		DeletePed(ped)
	elseif args == 5 then
		RequestTheModel("A_C_stingray")
		local pos = GetEntityCoords(PlayerPedId())
		local positionOffset = GetEntityForwardVector(PlayerPedId())
		local spawnPoint = pos - (positionOffset * 2)
		local ped = CreatePed(29, `A_C_stingray`, spawnPoint.x, spawnPoint.y, spawnPoint.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`A_C_stingray`)
		Wait(time)
		DeletePed(ped)
	else
		RequestTheModel("a_c_fish")
		local pos = GetEntityCoords(PlayerPedId())
		local positionOffset = GetEntityForwardVector(PlayerPedId())
		local spawnPoint = pos - (positionOffset * 1)
		local ped = CreatePed(29, `a_c_fish`, spawnPoint.x, spawnPoint.y, spawnPoint.z, 90.0, true, false)
		SetEntityHealth(ped, 0)
		DecorSetInt(ped, "propHack", 74)
		SetModelAsNoLongerNeeded(`a_c_fish`)
		Wait(time)
		DeletePed(ped)
	end
end)

RegisterNetEvent('fishing:client:useFishingBox', function(boxNumber)
	QBCore.Functions.Notify('Opening chest...')
	Wait(500)
	QBCore.Functions.TriggerCallback('fishing:server:generateStash', function(id)
		if id then
			exports.ox_inventory:openInventory('stash', id)
		end
	end, boxNumber)
end) 

RegisterNetEvent('fishing:fishstart', function()
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed) 
	if IsPedSwimming(playerPed) then return QBCore.Functions.Notify("You can't swim and fishing at the same time.", "error") end 
	if IsPedInAnyVehicle(playerPed) then return QBCore.Functions.Notify("You need to exit your vehicle to start fishing.", "error") end 
	if GetWaterHeight(pos.x, pos.y, pos.z-2, pos.z - 3.0)  then
		local time = 1000
		QBCore.Functions.Notify('Using Fishing Rod', 'inform', time)
		Wait(time)
		fishAnimation()
	else
		QBCore.Functions.Notify('The water is not deep enough to fish here', 'error')
	end
end, false)

RegisterNetEvent('doj:client:ReturnBoat', function(args)
	local ped = PlayerPedId()
	local args = tonumber(args)

    local veh = GetVehiclePedIsIn(PlayerPedId(), true)

	if GetEntityModel(veh) == joaat('dinghy') then
		if args == 1 then 
			local boat = GetVehiclePedIsIn(ped,true) 
			QBCore.Functions.DeleteVehicle(boat)
			SetEntityCoords(ped, Config.PlayerReturnLocation.LaPuerta.x, Config.PlayerReturnLocation.LaPuerta.y, Config.PlayerReturnLocation.LaPuerta.z, 0, 0, 0, false) 
			SetEntityHeading(ped, Config.PlayerReturnLocation.LaPuerta.w)
			TriggerServerEvent('fishing:server:returnDeposit')
		elseif args == 2 then
			local boat = GetVehiclePedIsIn(ped,true) 
			QBCore.Functions.DeleteVehicle(boat)
			SetEntityCoords(ped, Config.PlayerReturnLocation.PaletoCove.x, Config.PlayerReturnLocation.PaletoCove.y, Config.PlayerReturnLocation.PaletoCove.z, 0, 0, 0, false) 
			SetEntityHeading(ped, Config.PlayerReturnLocation.PaletoCove.w)
			TriggerServerEvent('fishing:server:returnDeposit')
		elseif args == 3 then
			local boat = GetVehiclePedIsIn(ped,true) 
			QBCore.Functions.DeleteVehicle(boat)
			SetEntityCoords(ped, Config.PlayerReturnLocation.ElGordo.x, Config.PlayerReturnLocation.ElGordo.y, Config.PlayerReturnLocation.ElGordo.z, 0, 0, 0, false) 
			SetEntityHeading(ped, Config.PlayerReturnLocation.ElGordo.w)
			TriggerServerEvent('fishing:server:returnDeposit')
		elseif args == 4 then
			local boat = GetVehiclePedIsIn(ped,true) 
			QBCore.Functions.DeleteVehicle(boat)
			SetEntityCoords(ped, Config.PlayerReturnLocation.ActDam.x, Config.PlayerReturnLocation.ActDam.y, Config.PlayerReturnLocation.ActDam.z, 0, 0, 0, false) 
			SetEntityHeading(ped, Config.PlayerReturnLocation.ActDam.w)
			TriggerServerEvent('fishing:server:returnDeposit')
		else
			local boat = GetVehiclePedIsIn(ped,true) 
			QBCore.Functions.DeleteVehicle(boat)
			SetEntityCoords(ped, Config.PlayerReturnLocation.AlamoSea.x, Config.PlayerReturnLocation.AlamoSea.y, Config.PlayerReturnLocation.AlamoSea.z, 0, 0, 0, false) 
			SetEntityHeading(ped, Config.PlayerReturnLocation.AlamoSea.w)
			TriggerServerEvent('fishing:server:returnDeposit')
		end
	end
end)

RegisterNetEvent('doj:client:rentaBoat', function(args)
	local args = tonumber(args)
	local chance = math.random(1, 20)

	QBCore.Functions.TriggerCallback('fishing:server:checkMoney', function(isSuccess)
		if isSuccess then 
			if args == 1 then 
				QBCore.Functions.SpawnVehicle(Config.RentalBoat, function(boat)
					SetVehicleNumberPlateText(boat, "RB" .. tostring(math.random(111111,999999)))
					exports['ps-fuel']:SetFuel(boat, 100.0)
					SetEntityHeading(boat, Config.BoatSpawnLocation.LaPuerta.w)
					TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
					TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(boat))
					SetVehicleEngineOn(boat, true, true)
					rentalVehicle = boat
					NetworkRegisterEntityAsNetworked(rentalVehicle)
				end, Config.BoatSpawnLocation.LaPuerta, true) 
			elseif args == 2 then 
				QBCore.Functions.SpawnVehicle(Config.RentalBoat, function(boat)
					SetVehicleNumberPlateText(boat, "RB" .. tostring(math.random(111111,999999)))
					exports['ps-fuel']:SetFuel(boat, 100.0)
					SetEntityHeading(boat, Config.BoatSpawnLocation.PaletoCove.w)
					TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
					TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(boat))
					SetVehicleEngineOn(boat, true, true)
					rentalVehicle = boat
					NetworkRegisterEntityAsNetworked(rentalVehicle)
				end, Config.BoatSpawnLocation.PaletoCove, true) 
			elseif args == 3 then 
				QBCore.Functions.SpawnVehicle(Config.RentalBoat, function(boat)
					SetVehicleNumberPlateText(boat, "RB" .. tostring(math.random(111111,999999)))
					exports['ps-fuel']:SetFuel(boat, 100.0)
					SetEntityHeading(boat, Config.BoatSpawnLocation.ElGordo.w)
					TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
					TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(boat))
					SetVehicleEngineOn(boat, true, true)
					rentalVehicle = boat
					NetworkRegisterEntityAsNetworked(rentalVehicle)
				end, Config.BoatSpawnLocation.ElGordo, true) 
			elseif args == 4 then
				QBCore.Functions.SpawnVehicle(Config.RentalBoat, function(boat)
					SetVehicleNumberPlateText(boat, "RB" .. tostring(math.random(111111,999999)))
					exports['ps-fuel']:SetFuel(boat, 100.0)
					SetEntityHeading(boat, Config.BoatSpawnLocation.ActDam.w)
					TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
					TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(boat))
					SetVehicleEngineOn(boat, true, true)
					rentalVehicle = boat
					NetworkRegisterEntityAsNetworked(rentalVehicle)
				end, Config.BoatSpawnLocation.ActDam, true) 
			else
				QBCore.Functions.SpawnVehicle(Config.RentalBoat, function(boat)
					SetVehicleNumberPlateText(boat, "RB" .. tostring(math.random(111111,999999)))
					exports['ps-fuel']:SetFuel(boat, 100.0)
					SetEntityHeading(boat, Config.BoatSpawnLocation.AlamoSea.w)
					TaskWarpPedIntoVehicle(PlayerPedId(), boat, -1)
					TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(boat))
					SetVehicleEngineOn(boat, true, true)
					rentalVehicle = boat
					NetworkRegisterEntityAsNetworked(rentalVehicle)
				end, Config.BoatSpawnLocation.AlamoSea, true) 
			end  
		end
	end)
end)

RegisterNetEvent('doj:client:BoatMenu', function(data)
	local ped = PlayerPedId()
	local inVehicle = nil 

	local veh = GetVehiclePedIsIn(ped, true)

	if GetEntityModel(veh) == joaat('dinghy') then
		 print("Was in a dinghy")
		 inVehicle = true
		
	else 
		print("Was not in a dinghy")
		inVehicle = false
	end
    

	if data.location == 1 then 
        if Config.Fish24hours then
            if inVehicle == true then
                ReturnBoatLaPuerta()
            else
				BoatMenuLaPuerta()
            end
        else
            if GetClockHours() >= 6 and GetClockHours() <= 21 then
                if inVehicle == true then
                    ReturnBoatLaPuerta()
                else
                    BoatMenuLaPuerta()
                end
            else
                QBCore.Functions.Notify('Too Late to Fish!, Opened from 6:00am / 21:00pm', 'error')
            end
        end
	elseif data.location == 2 then
        if Config.Fish24hours then
            if inVehicle == true  then
                ReturnBoatPaletoCove()
            else
                BoatMenuPaletoCove()
            end
        else
            if GetClockHours() >= 6 and GetClockHours() <= 21 then
                if inVehicle == true  then
                    ReturnBoatPaletoCove()
                else
                    BoatMenuPaletoCove()
                end
            else
                QBCore.Functions.Notify('Too Late to Fish!, Opened from 6:00am / 21:00pm', 'error')
            end
        end
    elseif data.location == 3 then
        if Config.Fish24hours then
            if inVehicle == true  then
                ReturnBoatElGordo()
            else
                BoatMenuElGordo()
            end
        else
            if GetClockHours() >= 6 and GetClockHours() <= 21 then
                if inVehicle == true  then
                    ReturnBoatElGordo()
                else
                    BoatMenuElGordo()
                end
            else
                QBCore.Functions.Notify('Too Late to Fish!, Opened from 6:00am / 21:00pm', 'error')
            end
        end
    elseif data.location == 4 then
		if Config.Fish24hours then
			if inVehicle == true  then
				ReturnBoatActDam()
			else
				BoatMenuActDam()
			end
		else
			if GetClockHours() >= 6 and GetClockHours() <= 21 then
				if inVehicle == true  then
					ReturnBoatActDam()
				else
					BoatMenuActDam()
				end
			else
				QBCore.Functions.Notify('Too Late to Fish!, Opened from 6:00am / 21:00pm', 'error')
			end
		end
	else
        if Config.Fish24hours then
            if inVehicle == true  then
                ReturnBoatAlamoSea()
            else
                BoatMenuAlamoSea()
            end
        else
            if GetClockHours() >= 6 and GetClockHours() <= 21 then
                if inVehicle == true  then
                    ReturnBoatAlamoSea()
                else
                    BoatMenuAlamoSea()
                end
            else
                QBCore.Functions.Notify('Too Late to Fish!, Opened from 6:00am / 21:00pm', 'error')
            end
        end
	end
end)

RegisterNetEvent('fishing:client:anchor', function()
    local currVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    if currVeh ~= 0 then
        local vehModel = GetEntityModel(currVeh)
        if vehModel ~= nil and vehModel ~= 0 then
            if DoesEntityExist(currVeh) then
                if IsThisModelABoat(vehModel) or IsThisModelAJetski(vehModel) or IsThisModelAnAmphibiousCar(vehModel) or IsThisModelAnAmphibiousQuadbike(vehModel) then
                    if IsBoatAnchoredAndFrozen(currVeh) then
						QBCore.Functions.Notify('Retrieving Anchor', 'success')
                        Wait(2000)
						QBCore.Functions.Notify('Anchor Disabled', 'inform')
                        SetBoatAnchor(currVeh, false)
                        SetBoatFrozenWhenAnchored(currVeh, false)
                        SetForcedBoatLocationWhenAnchored(currVeh, false)
                    elseif not IsBoatAnchoredAndFrozen(currVeh) and CanAnchorBoatHere(currVeh) and GetEntitySpeed(currVeh) < 3 then
                        SetEntityAsMissionEntity(currVeh,false,true)
						QBCore.Functions.Notify('Dropping Anchor', 'inform')
                        Wait(2000)
						QBCore.Functions.Notify('Anchor Enabled', 'success')
                        SetBoatAnchor(currVeh, true)
                        SetBoatFrozenWhenAnchored(currVeh, true)
                        SetForcedBoatLocationWhenAnchored(currVeh, true)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('fishing:client:SellLegalFish', function(args) 
	TriggerServerEvent("fishing:server:SellLegalFish", args)
end)

RegisterNetEvent('fishing:client:SellillegalFish', function(args) 
	TriggerServerEvent("fishing:server:SellillegalFish", args)
end)


--- NEW SELLING STUFF

AddEventHandler('fishing:client:FishBuyerMenu', function(data)
	local SellMenu = ''
	for k,v in pairs(Config.FishPrices) do
		SellMenu = SellMenu..exports.ox_inventory:Items()[k]["label"]..':		$'..v..'\n\r'
	end
    local menu = {
        {
            title = "Current Prices:", 
            description = SellMenu,
            disabled = true,
        },
		{
            title = "Open Fish Sell Box", 
			event = "target:client:openStash",
            args = data,          
        },
        {
            title = "Sell Fish", 
            event = "fishing:client:sellFishMenu",
        }   
    }
	lib.registerContext({
		id = 'fish_buyer_menu',
		title = 'Fish Buyer',
		options = menu,
	})
	lib.showContext('fish_buyer_menu')
end)

AddEventHandler('fishing:client:ExoticFishBuyerMenu', function(data)
	if QBCore.Functions.HasItem('pearlscard') then
		QBCore.Functions.Notify("The fish buyer checks your membership card...", "success")
		local SellMenu = ''
		for k,v in pairs(Config.ExoticFishPrices) do
			SellMenu = SellMenu..exports.ox_inventory:Items()[k]["label"]..':		$'..v..'\n\r'
		end
		local menu = {
			{
				title = "Current Prices:", 
				description = SellMenu,
				disabled = true,
			},
			{
				title = "Open Exotic Fish Sell Box", 
				event = "target:client:openStash",
				args = data,          
			},
			{
				title = "Sell Fish", 
				event = "fishing:client:sellExoticFishMenu",
			}       
		}
		lib.registerContext({
			id = 'exotic_fish_buyer_menu',
			title = 'Exotic Fish Buyer',
			options = menu,
		})
		lib.showContext('exotic_fish_buyer_menu')
	else
		QBCore.Functions.Notify("They hold out their hand expectantly...", "error")       
	end
end) 

-- Sell Menu
AddEventHandler('fishing:client:sellFishMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'fishsell', true},            
        }        
    }
	lib.registerContext({
		id = 'sell_fish_menu',
		title = 'Sell Fish',
		options = menu,
	})
	lib.showContext('sell_fish_menu')
end)

AddEventHandler('fishing:client:sellExoticFishMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'exoticfishsell', true}      
        }   
    }
	lib.registerContext({
		id = 'sell_exotic_fish_menu',
		title = 'Sell Exotic Fish',
		options = menu,
	})
	lib.showContext('sell_exotic_fish_menu')
end)




---
--============================================================== Functions

loseBait = function()
	local chance = math.random(1, 15)
	if chance <= 5 then
		TriggerServerEvent("fishing:server:removeFishingBait")
		loseBaitAnimation()
	end
end

loseBaitAnimation = function()
	local ped = PlayerPedId()
	local animDict = "gestures@f@standing@casual"
	local animName = "gesture_damn"
	--DeleteEntity(rodHandle)
	QBCore.Functions.DeleteEntity(rodHandle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 0, 0, 0, 48, 0)
	RemoveAnimDict(animDict)
	--exports['textUi']:DrawTextUi('show', "Fish took your bait!")
	QBCore.Functions.Notify("Fish took your bait!")         
	Wait(2000)
	--exports['textUi']:DrawTextUi('hide')
	fishAnimation()
end

RequestTheModel = function(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(0)
	end
end

catchAnimation = function()
	local ped = PlayerPedId()
	local animDict = "mini@tennis"
	local animName = "forehand_ts_md_far"
	DeleteEntity(rodHandle)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 0, 0, 0, 48, 0)
	local time = 1750
	QBCore.Functions.Notify('Caught Something!', 'success', time)
	Wait(time)
	TriggerServerEvent('fishing:server:catch') 
	loseBait()
	if math.random(1, 100) < 50 then
		TriggerServerEvent('hud:server:RelieveStress', 50)
	end
	PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	RemoveAnimDict(animDict)
	endFishing()
end

fishAnimation = function()
	if QBCore.Functions.HasItem('fishbait') then
		local ped = PlayerPedId()
		local animDict = "amb@world_human_stand_fishing@idle_a"
		local animName = "idle_c"
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(100)
		end
		TaskPlayAnim(ped, animDict, animName, 1.0, -1.0, 1.0, 11, 0, 0, 0, 0)
		fishingRodEntity()
		fishing = true
		Wait(3700)
		--exports['textUi']:DrawTextUi('hide') 
	else
		endFishing()
		QBCore.Functions.Notify("You dont have any fishing bait", "error")
	end
end

fishingRodEntity = function()
	local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
	local fishingRodHash = `prop_fishing_rod_01`
	local bone = GetPedBoneIndex(ped, 18905)
	if rodHandle == 0 or rodHandle == nil then 
    rodHandle = CreateObject(fishingRodHash, pedPos, true)
    AttachEntityToEntity(rodHandle, ped, bone, 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
	end
end

endFishing = function() 
	local ped = PlayerPedId()
    if rodHandle ~= 0 then
		QBCore.Functions.DeleteEntity(rodHandle)
		--DeleteObject(rodHandle)
		ClearPedTasks(ped)
		fishing = false
		rodHandle = 0
		--exports['textUi']:DrawTextUi('hide')
    end
end

attemptTreasureChest = function()
	local ped = PlayerPedId()
	local animDict = "veh@break_in@0h@p_m_one@"
	local animName = "low_force_entry_ds"
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do
		Wait(100)
	end
	TaskPlayAnim(ped, animDict, animName, 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
	RemoveAnimDict(animDict)
	QBCore.Functions.Notify('Attempting to open Treasure Chest', 'inform', 1500)
	Wait(1500)
	ClearPedTasks(PlayerPedId())
end

openedTreasureChest = function()
	if math.random(1,15) < 13 then
		TriggerServerEvent("fishing:server:removeFishingKey")
	end
	TriggerServerEvent("fishing:server:removeFishingLootBig")

	if math.random(1,100) <= 10 then
		TriggerServerEvent('fishing:server:addTackleBox')
	end

	Wait(500)
	QBCore.Functions.TriggerCallback('fishing:server:tryOpenTreasure', function(success)
		if success then
			exports.ox_inventory:openInventory('stash', 'TreasureChest')
		end
	end)
end

nearPed = function(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(joaat(model))
	while not HasModelLoaded(joaat(model)) do
		Wait(1)
	end

	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("No gender provided! Check your configuration!")
	end	

	ped = CreatePed(genderNum, joaat(v.model), coords, heading, false, true)
	SetEntityAlpha(ped, 0, false)

	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) 
	end
	for i = 0, 255, 51 do
		Wait(50)
		SetEntityAlpha(ped, i, false)
	end

	return ped
end