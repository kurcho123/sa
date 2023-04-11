QBCore = exports['qb-core']:GetCoreObject() -- Used Globally
inJail = false
jailTime = 0
--currentJob = "electrician"
CellsBlip = nil
TimeBlip = nil
ShopBlip = nil
PlayerJob = {}

-- Functions

function DrawText3D(x, y, z, text) -- Used Globally
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function CreateCellsBlip()
	if CellsBlip ~= nil then
		RemoveBlip(CellsBlip)
	end
	CellsBlip = AddBlipForCoord(Config.Locations["yard"].coords.x, Config.Locations["yard"].coords.y, Config.Locations["yard"].coords.z)

	SetBlipSprite (CellsBlip, 238)
	SetBlipDisplay(CellsBlip, 4)
	SetBlipScale  (CellsBlip, 0.5)
	SetBlipAsShortRange(CellsBlip, true)
	SetBlipColour(CellsBlip, 4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Cell Block")
	EndTextCommandSetBlipName(CellsBlip)

	if TimeBlip ~= nil then
		RemoveBlip(TimeBlip)
	end
	TimeBlip = AddBlipForCoord(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z)

	SetBlipSprite (TimeBlip, 466)
	SetBlipDisplay(TimeBlip, 4)
	SetBlipScale  (TimeBlip, 0.5)
	SetBlipAsShortRange(TimeBlip, true)
	SetBlipColour(TimeBlip, 4)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Visitation")
	EndTextCommandSetBlipName(TimeBlip)

	if ShopBlip ~= nil then
		RemoveBlip(ShopBlip)
	end
	ShopBlip = AddBlipForCoord(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z)

	SetBlipSprite (ShopBlip, 52)
	SetBlipDisplay(ShopBlip, 4)
	SetBlipScale  (ShopBlip, 0.5)
	SetBlipAsShortRange(ShopBlip, true)
	SetBlipColour(ShopBlip, 0)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("Canteen")
	EndTextCommandSetBlipName(ShopBlip)
end

-- Events

CreateThread(function()
	while not LocalPlayer.state.isLoggedIn do
		Wait(500)
	end
	if LocalPlayer.state.isLoggedIn then 
		QBCore.Functions.GetPlayerData(function(PlayerData)
			if PlayerData.metadata["injail"] > 0 then
				inJail = true
				jailTime = PlayerData.metadata["injail"]
				SetupExitPoly()
				SetupStashPoly()
				ChangeToJailOutfit()
			else
				-- For niche case when they relog when they are already outta jail time
				SetupExitPoly()
			end
		end)
	end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] > 0 then
			TriggerEvent("prison:client:Enter", PlayerData.metadata["injail"])
		end
	end)

	QBCore.Functions.TriggerCallback('prison:server:IsAlarmActive', function(active)
		if active then
			TriggerEvent('prison:client:JailAlarm', true)
		end
	end)

	PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
	inJail = false
	currentJob = nil
	RemoveBlip(currentBlip)
end)

RegisterNetEvent('prison:client:Enter', function(time)
	QBCore.Functions.Notify("You're in jail for "..time.." months..", "error")
	TriggerEvent("chatMessage", "SYSTEM", "warning", "Your property has been seized, you'll get everything back when your time is up..")
	DoScreenFadeOut(500)
	while not IsScreenFadedOut() do
		Wait(10)
	end
	FreezeEntityPosition(PlayerPedId(), true)
	local RandomStartPosition = Config.Locations.spawns[math.random(1, #Config.Locations.spawns)]
	SetEntityCoords(PlayerPedId(), RandomStartPosition.coords.x, RandomStartPosition.coords.y, RandomStartPosition.coords.z - 0.9, 0, 0, 0, false)
	SetEntityHeading(PlayerPedId(), RandomStartPosition.coords.w)
	Wait(1000)
	TriggerEvent('animations:client:EmoteCommandStart', {RandomStartPosition.animation})

	inJail = true
	jailTime = time
	--currentJob = "electrician"
	TriggerServerEvent("prison:server:SetJailStatus", jailTime)
	TriggerServerEvent("prison:server:SaveJailItems", jailTime)
	TriggerServerEvent("InteractSound_SV:PlayOnSource", "jail", 0.5)
	CreateCellsBlip()
	Wait(2000)
	ChangeToJailOutfit()
	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		Wait(10)
	end
	FreezeEntityPosition(PlayerPedId(), false)
	DoScreenFadeIn(1000)
	SetupExitPoly()
	SetupStashPoly()
	--QBCore.Functions.Notify("Do some work for sentence reduction, instant job: "..Config.Jobs[currentJob])
end)

RegisterNetEvent('prison:client:Leave', function()
	if jailTime > 0 then
		QBCore.Functions.Notify("You still have to... "..jailTime.." months..")
	else
		jailTime = 0
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		TriggerEvent("chatMessage", "SYSTEM", "warning", "you've received your property back..")
		inJail = false
		RemoveBlip(currentBlip)
		RemoveBlip(CellsBlip)
		CellsBlip = nil
		RemoveBlip(TimeBlip)
		TimeBlip = nil
		RemoveBlip(ShopBlip)
		ShopBlip = nil
		QBCore.Functions.Notify("You're free! Enjoy it! :)")
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Wait(10)
		end
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)

		Wait(500)
		ChangeFromJailOutfit()
		DoScreenFadeIn(1000)
	end
end)

RegisterNetEvent('prison:client:UnjailPerson', function()
	if jailTime > 0 then
		TriggerServerEvent("prison:server:SetJailStatus", 0)
		TriggerServerEvent("prison:server:GiveJailItems")
		TriggerEvent("chatMessage", "SYSTEM", "warning", "You got your property back..")
		inJail = false
		RemoveBlip(currentBlip)
		RemoveBlip(CellsBlip)
		CellsBlip = nil
		RemoveBlip(TimeBlip)
		TimeBlip = nil
		RemoveBlip(ShopBlip)
		ShopBlip = nil
		QBCore.Functions.Notify("You're free! Enjoy it! :)")
		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Wait(10)
		end
		SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
		SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)
		Wait(500)
		ChangeFromJailOutfit()
		DoScreenFadeIn(1000)
	end
end)

RegisterNetEvent('prison:client:CheckTime', function()
	if jailTime > 0 then
		QBCore.Functions.Notify("Time Left: " .. tostring(jailTime) .. " Months", "error")
	else
		QBCore.Functions.Notify("You have no jailtime, if you are in jail you can check out", "success")
	end
end)

RegisterNetEvent('prison:client:CheckOut', function()
	if jailTime <= 0 then
		QBCore.Functions.Notify("You've done your time, get out!", "success")
			TriggerServerEvent("prison:server:SetJailStatus", 0)
			TriggerServerEvent("prison:server:GiveJailItems")
			TriggerEvent("chatMessage", "SYSTEM", "warning", "You got your property back..")
			inJail = false
			RemoveBlip(currentBlip)
			RemoveBlip(CellsBlip)
			CellsBlip = nil
			RemoveBlip(TimeBlip)
			TimeBlip = nil
			RemoveBlip(ShopBlip)
			ShopBlip = nil
			QBCore.Functions.Notify("You're free! Enjoy it! :)")
			DoScreenFadeOut(500)
			while not IsScreenFadedOut() do
				Wait(10)
			end
			SetEntityCoords(PlayerPedId(), Config.Locations["outside"].coords.x, Config.Locations["outside"].coords.y, Config.Locations["outside"].coords.z, 0, 0, 0, false)
			SetEntityHeading(PlayerPedId(), Config.Locations["outside"].coords.w)
			Wait(500)
			ChangeFromJailOutfit()
			DoScreenFadeIn(1000)
	else 
		QBCore.Functions.Notify("You still have: " .. tostring(jailTime) .. " Months left in jail, you cannot check out", "error")
	end
end)

-- Threads

CreateThread(function()
    TriggerEvent('prison:client:JailAlarm', false)
	while true do
		Wait(7)
		if jailTime > 0 and inJail then
			Wait(1000 * 60)
			if jailTime > 0 and inJail then
				jailTime = jailTime - 1
				if jailTime <= 0 then
					jailTime = 0
				end
				TriggerServerEvent("prison:server:SetJailStatus", jailTime)
			end
		elseif jailTime <= 0 and inJail then
			QBCore.Functions.Notify("Your time is up! Check yourself out at the visitors center", "success", 10000)
			Wait(60000)
		else
			Wait(5000)
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1)
		if LocalPlayer.state.isLoggedIn then
			if inJail then
				local pos = GetEntityCoords(PlayerPedId())
				-- if #(pos - vector3(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z)) < 1.5 then
				-- 	DrawText3D(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z, "~g~E~w~ - Check time")
				-- 	if IsControlJustReleased(0, 38) then
				-- 		TriggerEvent("prison:client:Leave")
				-- 	end
				-- elseif #(pos - vector3(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z)) < 2.5 then
				-- 	DrawText3D(Config.Locations["freedom"].coords.x, Config.Locations["freedom"].coords.y, Config.Locations["freedom"].coords.z, "Check time")
				-- end

				if #(pos - vector3(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z)) < 1.5 then
					DrawText3D(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, "~g~E~w~ - Canteen")
					if IsControlJustReleased(0, 38) then
						exports.ox_inventory:openInventory('shop', { type = 'CanteenShop' })
					end
					DrawMarker(2, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 55, 22, 222, false, false, false, 1, false, false, false)
				elseif #(pos - vector3(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z)) < 2.5 then
					DrawText3D(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, "Canteen")
					DrawMarker(2, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 55, 22, 222, false, false, false, 1, false, false, false)
				elseif #(pos - vector3(Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z)) < 10 then
					DrawMarker(2, Config.Locations["shop"].coords.x, Config.Locations["shop"].coords.y, Config.Locations["shop"].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255, 55, 22, 222, false, false, false, 1, false, false, false)
				end
			end
		else
			Wait(5000)
		end
	end
end)

-- Functions

function SetupExitPoly()
	exports.ox_target:addBoxZone({
		coords = vector3(1828.79, 2579.77, 46.55), 
		size = vec3(0.5, 0.5, 47.00 - 46.10),
		rotation = 180.00, 
		debug = false,
		options = {
			{
				event = "prison:client:CheckTime",
				icon = 'fas fa-hand-sparkles',
				label = "Check Time",
			},
			{
				event = "prison:client:CheckOut",
				icon = 'fas fa-hand-sparkles',
				label = "Check Out",
			},
		},
	})
end

function SetupStashPoly()
	local locations = Config.PrisonJobTypes["bunks"].sites
    for k, v in pairs(locations) do
		if v.label == "Clean Bunk" then
        	exports['qb-target']:AddBoxZone("PrisonStash." .. k, locations[k].location, locations[k].length, locations[k].width, {
				name = "PrisonStash." .. k, heading = locations[k].heading, debugPoly = false, minZ = locations[k].minZ, maxZ = locations[k].maxZ }, 
				{
					options = {
						{
							type = "server",
							event = "prison:server:OpenStash", 
							icon = "fas fa-screwdriver", 
							label = "Pry Open Bunk",
						},
					},
					distance = 2.5
				}
			)
		end
	end
end

-- Commands
RegisterCommand("jailtime", function()
	TriggerEvent('prison:client:CheckTime')
end)

-- Outfit Stuff - Should probably change to metadata
function ChangeToJailOutfit()
	TriggerEvent('raid_clothes:client:loadOutfit', nil, 'jail', 1)
end

function ChangeFromJailOutfit()	
	TriggerServerEvent('raid_clothes:get_character_current')
end