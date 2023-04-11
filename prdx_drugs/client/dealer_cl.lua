local QBCore = exports['qb-core']:GetCoreObject()
local DealerData
local spawnedPed
local spawnedObjects = {}

function CleanupDealer()
    if spawnedPed then
        exports.ox_target.RemoveSpawnedPed(spawnedPed)
    end
    for k,v in pairs(spawnedObjects) do
        DeleteObject(v)
    end
end

function SetupDealer()
    spawnedPed = exports.ox_target:SpawnPed({
        model = Config.DrugDealer.PedModel, 
        coords = DealerData.pedCoords,
        minusOne = true, 
        freeze = true, 
        invincible = true, 
        blockevents = true,
        spawnNow = true,
        scenario = 'WORLD_HUMAN_CLIPBOARD',
        target = {
            options = {
                {
					type = "client",
					event = 'target:client:openShop',
                    icon = 'fas fa-hand-holding-dollar',
					label = "Speak to dealer",
					sellitems = "MovingDealer",
				},
                {
					type = "server",
					event = 'prdx_drugs:server:dealer:raidDealer',
                    icon = 'fas fa-handcuffs',
					label = "Raid Dealer",
                    job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
				},
            },
            distance = 1.5,
        }
    })
    local boatObj = CreateObject(Config.DrugDealer.BoatModel, DealerData.boatCoords.x, DealerData.boatCoords.y, DealerData.boatCoords.z, false, true)
    SetEntityHeading(boatObj, DealerData.boatCoords.w)
    PlaceObjectOnGroundProperly(boatObj)
    SetEntityLodDist(boatObj, 1000)
    spawnedObjects[#spawnedObjects+1] = boatObj
    Wait(1)
    local crateObj = CreateObject(Config.DrugDealer.CreateModel, DealerData.crateCoords.x, DealerData.crateCoords.y, DealerData.crateCoords.z, false, true)
    SetEntityHeading(crateObj, DealerData.crateCoords.w)
    PlaceObjectOnGroundProperly(crateObj)
    SetEntityLodDist(boatObj, 1000)
    spawnedObjects[#spawnedObjects+1] = crateObj
end

RegisterNetEvent('prdx_drugs:client:dealer:dealerRaided', function(currentDealer)
    DealerData = currentDealer
    CleanupDealer()
    exports['polyzonehelper']:DeletePolyZone("DealerZone")
    Wait(1)
    exports['polyzonehelper']:AddBoxZone("DealerZone", vector3(DealerData.pedCoords.x, DealerData.pedCoords.y, DealerData.pedCoords.z), 250.0, 250.0, {
        name = "DealerZone",
        heading = DealerData.pedCoords.w,
        debugPoly = Config.Debug,
    })
end)

AddEventHandler('polyzonehelper:enter', function(name)
    if name == "DealerZone" then
        SetupDealer()
    end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if name == "DealerZone" then
        CleanupDealer()  
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('prdx_drugs:server:dealer:getDealerLocation', function(currentDealer)
        DealerData = currentDealer
        exports['polyzonehelper']:AddBoxZone("DealerZone", vector3(DealerData.pedCoords.x, DealerData.pedCoords.y, DealerData.pedCoords.z), 250.0, 250.0, {
            name = "DealerZone",
            heading = DealerData.pedCoords.w,
            debugPoly = Config.Debug,
        })
    end)
end)

-- This is to make sure the peds spawn on restart too instead of only when you load/log-in.
AddEventHandler('onResourceStart', function(resource)
    Wait(500)
	if resource == GetCurrentResourceName() and LocalPlayer.state.isLoggedIn then
        QBCore.Functions.TriggerCallback('prdx_drugs:server:dealer:getDealerLocation', function(currentDealer)
            DealerData = currentDealer
            exports['polyzonehelper']:AddBoxZone("DealerZone", vector3(DealerData.pedCoords.x, DealerData.pedCoords.y, DealerData.pedCoords.z), 250.0, 250.0, {
                name = "DealerZone",
                heading = DealerData.pedCoords.w,
                debugPoly = Config.Debug,
            })
        end)
    end
end)

-- This is to make sure the peds remove on restart too.
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		CleanupDealer()
        exports['polyzonehelper']:DeletePolyZone("DealerZone")
	end
end)