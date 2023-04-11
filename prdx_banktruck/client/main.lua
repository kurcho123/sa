local QBCore = exports['qb-core']:GetCoreObject()
local LockBoxTracker = false
local NotificationEnabled = false

function AlertPolice()
	local data = exports['cd_dispatch']:GetPlayerInfo()
	TriggerServerEvent('cd_dispatch:AddNotification', {
		job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'},
		coords = data.coords,
		title = '10-68b - Bank Truck Under Fire',
		message = 'Gruppe6 dispatch reporting a truck has come under fire at '..data.street, 
		flash = 1, 
		unique_id = tostring(math.random(0000000,9999999)),
		blip = {
			sprite = 67, 
			scale = 1.5, 
			colour = 47,
			flashes = true, 
			text = '10-68 - Bank Truck',
			sound = 2,
		}
	})
end

RegisterNetEvent('prdx_banktruck:client:SetupPed', function(netid, frontSeat, isDriver)
    local ped = NetworkGetEntityFromNetworkId(netid)
    print('Setup banktruck ped:', ped, netid, frontSeat, isDriver)
    if isDriver then
        TaskVehicleDriveWander(ped, GetVehiclePedIsIn(ped), 80.0, 443)
    end
    if frontSeat then
        SetPedCombatAttributes(ped, 3, true)
        SetPedCombatAttributes(ped, 2, true)
    else
        SetPedCombatAttributes(ped, 2, false)
        SetPedCombatAttributes(ped, 3, false)
    end
	SetPedFleeAttributes(ped, 0, 0)
	SetPedCombatAttributes(ped, 46, true)
	SetPedCombatAttributes(ped, 0, true)
	SetPedArmour(ped, 400)
    SetPedMaxHealth(ped, 800)
    SetEntityHealth(ped, 800)
	SetPedCombatAbility(ped, 2)
	SetPedCombatMovement(ped, 1)
	SetPedCombatRange(ped, 2)
    SetRagdollBlockingFlags(ped, 1)
	SetPedKeepTask(ped, true)
	SetPedAsCop(ped, true)
	SetPedDropsWeaponsWhenDead(ped, false)
	SetPedSuffersCriticalHits(ped, false)
end)

RegisterNetEvent('prdx_banktruck:client:ReceiveLocation', function(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 161)
    SetBlipColour(blip, 24)
    SetBlipScale(blip, 0.75)
    AddTextEntry('MYBLIP', "Fleeca Lockbox Trakcer")
    BeginTextCommandSetBlipName('MYBLIP')
    AddTextComponentSubstringPlayerName("Fleeca Lockbox Trakcer")
    EndTextCommandSetBlipName(blip)
    SetTimeout(5500, function()
        RemoveBlip(blip)
    end)
end)

RegisterNetEvent('prdx_banktruck:client:lockboxTracker', function(isActive, RobberyID, Timer)
    if isActive and LockBoxTracker or not RobberyID then return end -- prevent double loops
    LockBoxComplete = false
    LockBoxTracker = isActive
    if isActive then
        CreateThread(function()
            while LockBoxTracker do
                Wait(5000)
                Timer = Timer - 1
                TriggerServerEvent('prdx_banktruck:server:SendLocation', GetEntityCoords(cache.ped), RobberyID, Timer)
                if Timer <= 0 then
                    LockBoxTracker = false
                end
            end
        end) 
    end
end)

AddEventHandler('prdx_banktruck:ThermiteAction', function(data)
    local transport = data.entity
    local ped = cache.ped
	if transport and GetEntitySpeed(transport) < 2.0 then
        if not IsEntityInWater(ped) then
            lib.requestAnimDict("anim@heists@ornate_bank@thermal_charge")
            lib.requestModel("hei_p_m_bag_var22_arm_s")
            lib.requestNamedPtfxAsset("scr_ornate_heist")
            TaskTurnPedToFaceEntity(ped, transport, 1000)
            Wait(200)
            local loc = GetEntityCoords(ped)
            local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(ped)))
            local rotplus = 0
            local bagscene = NetworkCreateSynchronisedScene(loc.x, loc.y+0.05, loc.z, rotx, roty, rotz + rotplus, 2, false, false, 1065353216, 0, 1.3)
            local bag = CreateObject(joaat("hei_p_m_bag_var22_arm_s"), loc.x, loc.y, loc.z,  true,  true, false)
            SetEntityCollision(bag, false, true)
            NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
            local x, y, z = table.unpack(GetEntityCoords(ped))
            local bomba = CreateObject(joaat("hei_prop_heist_thermite"), x, y, z - 20.0,  true,  true, true)
            NetworkStartSynchronisedScene(bagscene)
            SetEntityVisible(bomba, false)
            SetEntityCollision(bomba, false, true)
            AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
            Wait(500)
            SetEntityVisible(bomba, true)
            Wait(4000)
            DeleteObject(bag)
            DetachEntity(bomba, 1, 1)
            AttachEntityToEntity(bomba, transport, GetEntityBoneIndexByName(transport, 'door_pside_r'), -0.5, -0.25, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            FreezeEntityPosition(bomba, true)
            NetworkStopSynchronisedScene(bagscene)
            local result = lib.skillCheck({'easy', 'medium', 'medium', 'medium'}) -- , 
            if result then
                TriggerServerEvent('prdx_heists:server:removeThermite')
                TriggerServerEvent("prdx_banktruck:server:TruckTaken")
                QBCore.Functions.Notify('Thermite set. The truck looks pressurized...', 'success', 15000)
                TriggerServerEvent("QBCore:Server:DoPTFX", "scr_ornate_heist", 'scr_heist_ornate_thermal_burn', true, GetEntityCoords(bomba), vec3(0.0, 0.0, 0.0), 0.5, nil, nil, Config.ThermiteTime - 5000)
                TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
                TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
                DeleteObject(bomba)
                Wait(Config.ThermiteTime - 5000) -- WAIT
                AlertPolice()
                local transportCoords = GetEntityCoords(transport)
                SetEntityInvincible(transport, true)
                AddExplosion(transportCoords.x, transportCoords.y, transportCoords.z, 48, 0.1, true, false, 1.0)
                ApplyForceToEntity(transport, 0.0, 5.25, 0.0, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
                SetEntityInvincible(transport, false)
                QBCore.Functions.SetStateBag(transport, 'isLootable', true)
                TriggerServerEvent('prdx_banktruck:server:TruckOpened')
                QBCore.Functions.Notify('Truck doors blown open!', "success")
            else
                math.randomseed(GetGameTimer())
                local chance = math.random(1, 100)
                if chance <= 45 then
                    TriggerServerEvent('prdx_banktruck:server:thermiteFailed')
                end
            end
            DeleteObject(bomba)
            ClearPedTasks(ped)
        else
            QBCore.Functions.Notify('Truck is in water', "error")
        end
	else
        QBCore.Functions.Notify('Truck is moving too fast', "error")
	end
end)

CreateThread(function()
    local options = {
        {
            name = 'prdx_banktruck:ThermiteAction',
            event = "prdx_banktruck:ThermiteAction",
            icon = 'fas fa-explosion',
            label = 'Thermite Truck Doors',
            item = 'thermite',
            canInteract = function(entity, distance, coords, name, bone) 
                if not Entity(entity).state.isBankTruck then return false end
                if Entity(entity).state.isLootable then return false end
                return true
            end,
		},
        {
            name = 'prdx_banktruck:stealTruck',
            serverEvent = "prdx_banktruck:server:stealTruck",
            icon = 'fas fa-boxes-stacked',
            label = 'Rob Truck Lockbox',
            canInteract = function(entity, distance, coords, name, bone) 
                if not Entity(entity).state.isBankTruck then return false end
                if not Entity(entity).state.isLootable then return false end
                return true
            end,
		}
    }
    local optionNames = { 'prdx_banktruck:ThermiteAction', 'prdx_banktruck:stealTruck' }
    exports.ox_target:removeGlobalVehicle(optionNames)
    exports.ox_target:addGlobalVehicle(options)
end)