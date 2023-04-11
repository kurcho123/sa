local QBCore = exports['qb-core']:GetCoreObject()
local firstAlarm = false
local smashing = false
local RobberyActive = false
-- Functions

local function loadParticle()
	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
		RequestNamedPtfxAsset("scr_jewelheist")
    end
    while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
		Wait(0)
    end
    SetPtfxAssetNextCall("scr_jewelheist")
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(3)
    end
end

local function validWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    for k, _ in pairs(Config.WhitelistedWeapons) do
        if pedWeapon == k then
            return true
        end
    end
    return false
end

local function IsWearingHandshoes()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == `mp_m_freemode_01` then
        if Config.MaleNoHandshoes[armIndex] ~= nil and Config.MaleNoHandshoes[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoHandshoes[armIndex] ~= nil and Config.FemaleNoHandshoes[armIndex] then
            retval = false
        end
    end
    return retval
end

function PoliceCall()
    local data = exports['cd_dispatch']:GetPlayerInfo()
	TriggerServerEvent('cd_dispatch:AddNotification', {
		job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'},
		coords = Config.jewelryLocation.coords,
		title = '10-68a - Active Armed Robbery',
		message = 'Reports of armed person(s) inside the Vangelico Jewelry Store', 
		flash = 1, 
		unique_id = tostring(math.random(0000000,9999999)),
		blip = {
			sprite = 303, 
			scale = 1.5, 
			colour = 1,
			flashes = true, 
			text = '10-68 - Silent alarm: - Vangelico Jewelry Store',
			sound = 2,
		}
	})    
end

local function smashCase(k)
    if RobberyActive then
        local animDict = "missheist_jewel"
        local animName = "smash_case"
        local ped = PlayerPedId()
        local plyCoords = GetOffsetFromEntityInWorldCoords(ped, 0, 0.6, 0)
        local pedWeapon = GetSelectedPedWeapon(ped)
        if math.random(1, 100) <= 80 and not IsWearingHandshoes() then
            TriggerServerEvent("evidence:server:CreateFingerDrop", plyCoords)
        end
        smashing = true
        loadAnimDict(animDict)
        CreateThread(function()
            while smashing do
                TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
                Wait(500)
                loadParticle()
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "robberyglass", 0.25)
                StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", plyCoords.x, plyCoords.y, plyCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
                Wait(1000)
            end
        end)
        QBCore.Functions.Progressbar("smash_case", Lang:t('info.progressbar'), Config.WhitelistedWeapons[pedWeapon]["timeOut"], false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            smashing = false
            TaskPlayAnim(ped, animDict, animName, 3.0, 3.0, -1, 2, 0, 0, 0, 0 )
            Wait(500)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "robberyglassbreak", 0.25)
            TriggerServerEvent('prdx_jewelry:server:caseReward', k)
            Wait(3000)
            TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
        end, function() -- Cancel
            TriggerServerEvent('prdx_jewelry:server:setCaseState', "isBusy", false, k)
            smashing = false
            TaskPlayAnim(ped, animDict, "exit", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
        end)
        TriggerServerEvent('prdx_jewelry:server:setCaseState', "isBusy", true, k) 
    end   
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.TriggerCallback('prdx_jewelry:server:getCaseState', function(result)
		Config.Locations = result
	end)
end)

RegisterNetEvent('prdx_jewelry:client:RobberyActive', function(state)
    RobberyActive = state
end)

RegisterNetEvent('prdx_jewelry:client:setAllCaseState', function(locationData)
    Config.Locations = locationData
end)

RegisterNetEvent('prdx_jewelry:client:setCaseState', function(stateType, state, k)
    Config.Locations[k][stateType] = state
    if stateType == 'isOpened' and state == true then
        CreateModelSwap(Config.Locations[k]["coords"].x, Config.Locations[k]["coords"].y, Config.Locations[k]["coords"].z, 0.1, Config.Locations[k]['PropStart'], Config.Locations[k]['PropEnd'], false)
    end

    if stateType == 'isOpened' and state == false then
        RemoveModelSwap(Config.Locations[k]["coords"].x, Config.Locations[k]["coords"].y, Config.Locations[k]["coords"].z, 0.1, Config.Locations[k]['PropStart'], Config.Locations[k]['PropEnd'], false)
    end
end)

AddEventHandler('prdx_jewelry:client:smashCase', function(data)
    if validWeapon() then
        if not RobberyActive then
            QBCore.Functions.TriggerCallback('RobberyTimer:CanStartRobbery', function(canStart)
                if canStart then
                    RobberyActive = true
                    PoliceCall()
                    TriggerServerEvent('prdx_jewelry:server:RobberyActive', true)
                    TriggerServerEvent('RobberyTimer:RobberyStarted', 'JewelryStore')
                    smashCase(data.args)
                else
                    QBCore.Functions.Notify('Can not do this right now', 'error')
                end
            end, 'JewelryStore')
        else
            smashCase(data.args)
        end
    else
        QBCore.Functions.Notify(Lang:t('error.wrong_weapon'), 'error')
    end
end)


-- Threads
CreateThread(function()
    for k, v in pairs(Config.Locations) do
        exports.ox_target:addBoxZone({
            coords = vec3(v.coords.x, v.coords.y, v.coords.z), 
            size = vec3(1, 1, 2),
            rotation = 40,
            debug = false,
            options = {
                {
                    icon = "fas fa-explosion",
                    label = 'Smash Jewelry Case',
                    event = 'prdx_jewelry:client:smashCase',
                    args = k,
                    canInteract = function()
                        if v.isOpened or v.isBusy then
                            return false
                        end
                        return true
                    end,
                    distance = 1.5
                }
            }
        })
    end
end)