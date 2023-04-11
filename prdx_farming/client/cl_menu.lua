QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('prdx_farming:OpenCropMenu', function(data)
    local plant = GetClosestPlant()
    if plant.id ~= nil then
        local dist = #(GetEntityCoords(cache.ped) - vector3(plant.coords.x, plant.coords.y, plant.coords.z))
        if dist < 2.0 then -- Double check
            local menu = {
                {
                    title = "Crop Status:", 
                    description = "\n\rCrop Growth: "..math.floor(plant.growth * 100) .."%\n\rCrop Health: "..math.floor(plant.health * 100) .."%\n\rSoil Quality: "..math.floor(plant.soilQuality * 60) .."%\n\rHydration Level: "..math.floor(plant.water * 100) .."%\n\rNutrition Level: "..math.floor(plant.fertilizer * 100) .."%", 
                    disabled = true
                },
                {
                    title = "Water Crop", 
                    serverEvent = "prdx_farming:waterPlantSV",
                    args = plant
                },
                {
                    title = "Fertilize Crop", 
                    serverEvent = "prdx_farming:fertilizePlantSV",
                    args = plant
                },
                {
                    title = "Pull/Pick Crop", 
                    description = "Partial amounts for less growth", 
                    event = "prdx_farming:harvestPlant",
                    args = plant
                },
            }
            lib.registerContext({
                id = 'crop_menu',
                title = plant.clientData.name,
                options = menu,
            })
            lib.showContext('crop_menu')
        end
    end
end)

AddEventHandler('prdx_farming:client:sellStashMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'farmsell', true}
        }
    }
    lib.registerContext({
        id = 'sell_crops_menu',
        title = 'Sell Crops',
        options = menu,
    })
    lib.showContext('sell_crops_menu')
end)

RegisterNetEvent('prdx_farming:waterPlant', function(plant)
    local plyPed = cache.ped
    local actionTime = math.random(7500,15000)
    TaskTurnPedToFaceCoord(plyPed, vector3(plant.coords.x, plant.coords.y, plant.coords.z), 7500)
    local hash = joaat("prop_wateringcan")
    lib.requestModel(hash)
    waterCanProp = CreateObject(hash, GetEntityCoords(plyPed), true, true, true)
    AttachEntityToEntity(waterCanProp, plyPed, GetPedBoneIndex(plyPed, 57005), 0.27, 0.0, -0.23, -75.0, 41.0, 36.0, true, true, false, false, 1, true)    
    local ptfx = doPTFX("core", "water_splash_generic", waterCanProp, 'water', actionTime)
    QBCore.Functions.Progressbar("water_crop", "Watering crop", actionTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
		animDict = "anim@vx_watercan@garden",
		anim = "vx_watercan",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(plyPed, 'anim@vx_watercan@garden', 'vx_watercan', 0)
        RemovePropFromPed()
        TriggerServerEvent('prdx_farming:UpdatePlant', plant, 'water')
        StopParticleFxLooped(ptfx)
    end, function() -- Cancel
        StopAnimTask(plyPed, 'anim@vx_watercan@garden', 'vx_watercan', 0)
        StopParticleFxLooped(ptfx)
    end)
end)

RegisterNetEvent('prdx_farming:fertilizePlant', function(plant)
    local plyPed = cache.ped
    local actionTime = math.random(7500,15000)
    TaskTurnPedToFaceCoord(plyPed, vector3(plant.coords.x, plant.coords.y, plant.coords.z), 7500)
    local hash = joaat("bkr_prop_weed_bucket_open_01a")
    lib.requestModel(hash)
    fertilizerProp = CreateObject(hash, GetEntityCoords(plyPed), true, true, true)
    AttachEntityToEntity(fertilizerProp, plyPed, GetPedBoneIndex(plyPed, 18905), 0.19, -0.19, 0.42, -144.0, -324.0, -84.0, true, true, false, false, 1, true)
    doPTFX("scr_reburials", "scr_burial_dirt", fertilizerProp, 'fertilizer', actionTime)
    QBCore.Functions.Progressbar("fertilize_crop", "Fertilizing crop", actionTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
		animDict = "weapons@misc@jerrycan@",
		anim = "fire",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(plyPed, '"weapons@misc@jerrycan@', 'fire', 0)
        RemovePropFromPed()
        TriggerServerEvent('prdx_farming:UpdatePlant', plant, 'fertilizer')
        StopParticleFxLooped(ptfx)
    end, function() -- Cancel
        StopAnimTask(plyPed, '"weapons@misc@jerrycan@', 'fire', 0)
    end)
end)

RegisterNetEvent('prdx_farming:harvestPlant', function(plant)
    local plyPed = cache.ped
    local actionTime = math.random(7500,15000)
    TaskTurnPedToFaceCoord(plyPed, vector3(plant.coords.x, plant.coords.y, plant.coords.z), 7500)
    TriggerEvent('animations:client:EmoteCommandStart', {"rake2"})
    QBCore.Functions.Progressbar("harvest_crop", "Harvesting crop", actionTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        exports.scully_emotemenu:CancelAnimation()
        RemovePropFromPed()
        TriggerServerEvent('prdx_farming:UpdatePlant', plant, 'harvest')
        TriggerEvent('prdx_farming:removePlantObject', plant.id)
    end, function() -- Cancel
        exports.scully_emotemenu:CancelAnimation()
    end)
end)

function doPTFX(dict, particleName, entity, type, actionTime)
    Wait(250)
    lib.requestNamedPtfxAsset(dict)
    local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
    local x, y, z = table.unpack(GetEntityCoords(entity, false))
    local offsetCoords = nil
    local ptfxActive = true
    SetTimeout(actionTime, function()
        ptfxActive = false
    end)
    CreateThread(function ()
        while ptfxActive do
            if type == 'fertilizer' then
                offsetCoords = GetOffsetFromEntityInWorldCoords(entity, maximum.x - 0.25, maximum.y - 0.4, minimum.z + 0.5)
            elseif type == 'water' then
                offsetCoords = GetOffsetFromEntityInWorldCoords(entity, maximum.x + 0.05, maximum.y - 0.1, minimum.z + 0.3)
            end
            UseParticleFxAssetNextCall(dict)
            StartParticleFxNonLoopedAtCoord(particleName, offsetCoords.x + 0.0, offsetCoords.y + 0.0, offsetCoords.z + 0.05, 0.0, 0.0, 0.0, 0.2, false, false, false)
            Wait(1)
        end
    end)
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    RemovePropFromPed()
end)

function RemovePropFromPed()
    if waterCanProp ~= nil then
        DeleteObject(waterCanProp)
        waterCanProp = nil
    end
    if fertilizerProp ~= nil then
        DeleteObject(fertilizerProp)
        fertilizerProp = nil
    end
    if hoeProp ~= nil then
        DeleteObject(hoeProp)
        hoeProp = nil
    end
end
