Farming = {}
Farming.ClosePlantsIndexes = {}
busy = false

Farming.AllPlants = {}
Farming.SpawnedPlants = {}

CreateThread(function()
    while true do
        Farming.ClosePlantsIndexes = ReChunk(GetEntityCoords(cache.ped), Farming.AllPlants)
        Wait(2500)
    end
end)

local plantingTargetOffset = vector3(0, 2, -3)
local plantingSpaceAbove = vector3(0, 0, 3.0)
local rayFlagsLocation = 17
local rayFlagsObstruction = 273
local InsideFarm = false

function flatEnough(surfaceNormal)
    local x = math.abs(surfaceNormal.x)
    local y = math.abs(surfaceNormal.y)
    local z = math.abs(surfaceNormal.z)
    return (x <= 0.3 and y <= 0.3 and z >= 1.0 - 0.3)
end

getPlantingLocation = function(plantData)
    local ped = cache.ped
    if cache.vehicle then return { plantable = false, reason = 'planting_in_vehicle', targetCoords = nil, surfaceNormal = nil, soil = nil } end
    local playerCoord = GetEntityCoords(ped)
    local target = GetOffsetFromEntityInWorldCoords(ped, plantingTargetOffset)
    local testRay = StartShapeTestRay(playerCoord, target, rayFlagsLocation, ped, 7)
    local _, hit, hitLocation, surfaceNormal, material, _ = GetShapeTestResultEx(testRay)
    p(1, 'Ground material is ' .. material)
    if hit ~= 1 then return { plantable = false, reason = 'planting_too_steep', targetCoords = hitLocation, surfaceNormal = surfaceNormal, soil = material } end
    if not Config.Soil[material] then return { plantable = false, reason = 'planting_not_suitable_soil', targetCoords = hitLocation, surfaceNormal = surfaceNormal, soil = material } end
    if not flatEnough(surfaceNormal) then return { plantable = false, reason = 'planting_too_steep', targetCoords = hitLocation, surfaceNormal = surfaceNormal, soil = material } end
    local plantDistance = #(playerCoord - hitLocation)
    if plantDistance > 2.0 then return { plantable = false, reason = 'planting_too_far', targetCoords = hitLocation, surfaceNormal = surfaceNormal, soil = material } end
    local aboveTarget = hitLocation + plantingSpaceAbove
    local aboveRay = StartShapeTestRay(hitLocation, aboveTarget, rayFlagsObstruction, ped, 7)
    local _, hitAbove, _ = GetShapeTestResult(aboveRay)
    if hitAbove == 1 then return { plantable = false, reason = 'planting_obstructed', targetCoords = hitLocation, surfaceNormal = surfaceNormal, soil = material } end
    if plantData.plantanywhere then return { plantable = true, reason = 'planting_ok', targetCoords = hitLocation, surfaceNormal = surfaceNormal, soil = material } end
    if not InsideFarm then return { plantable = false, reason = 'not_inside_farm', targetCoords = hitLocation, surfaceNormal = surfaceNormal, soil = material } end
    return { plantable = true, reason = 'planting_ok', targetCoords = hitLocation, surfaceNormal = surfaceNormal, soil = material }
end

local inserting = false
--Object thread
CreateThread(function()
    while true do
        for _, index in pairs(Farming.ClosePlantsIndexes) do
            local plyPed = cache.ped
            local plyCoords = GetEntityCoords(plyPed)
            local plant = Farming.AllPlants[index]
            if plant ~= nil then
                local dist = #(plyCoords - vector3(plant.coords.x, plant.coords.y, plant.coords.z))
                if dist < Config.PlantRenderDist then
                    local exists = false
                    for spawnedPlantIndex, spawnedPlant in pairs(Farming.SpawnedPlants) do
                        if spawnedPlant.id == plant.id then
                            exists = true
                            if plant.growth ~= spawnedPlant.growth then
                                p(1, 'Re-spawning plant object ' .. spawnedPlant.id)
                                if DoesEntityExist(spawnedPlant.spawnedEntity) then
                                    DeleteObject(spawnedPlant.spawnedEntity)
                                end
                                exports.ox_target:removeLocalEntity(spawnedPlant.spawnedEntity, {'prdx_farming:OpenCropMenu'})
                                table.remove(Farming.SpawnedPlants, spawnedPlantIndex)
                                local data = {}
                                data.model = table.find(plant.clientData.type, Config.Plants).model
                                local hash = joaat(data.model)
                                data.id = plant.id
                                data.growth = plant.growth
                                lib.requestModel(hash)
                                SetModelAsNoLongerNeeded(hash)
                                local minz = math.abs(table.find(plant.clientData.type, Config.Plants).minZ)
                                local maxz = math.abs(table.find(plant.clientData.type, Config.Plants).maxZ)
                                local height = -(maxz + ((minz - maxz) * math.abs(plant.growth - 1.0)))
                                data.spawnedEntity = CreateObject(hash, vector3(plant.coords.x, plant.coords.y, plant.coords.z + height), false, false, false)
                                local options = {
                                    {
                                        name = 'prdx_farming:OpenCropMenu',
                                        event = 'prdx_farming:OpenCropMenu',
                                        icon = 'fas fa-tractor',
                                        label = 'Tend Crop',
                                        distance = 1.5
                                    }
                                }
                                exports.ox_target:addLocalEntity(data.spawnedEntity, options)
                                FreezeEntityPosition(data.spawnedEntity, true)
                                SetObjectColour(data.spawnedEntity,1,128,0,128)
                                SetEntityLodDist(data.spawnedEntity, 1000)
                                table.insert(Farming.SpawnedPlants, data)
                                hasSpawned = false
                            end
                        end
                    end
                    if not exists then
                        p(1, 'Creating new plant')
                        local data = {}
                        data.model = table.find(plant.clientData.type, Config.Plants).model
                        local hash = joaat(data.model)
                        data.id = plant.id
                        data.growth = plant.growth
                        lib.requestModel(hash)
                        local minz = math.abs(table.find(plant.clientData.type, Config.Plants).minZ)
                        local maxz = math.abs(table.find(plant.clientData.type, Config.Plants).maxZ)
                        local height = -(maxz + ((minz - maxz) * math.abs(plant.growth - 1.0)))
                        data.spawnedEntity = CreateObject(hash, vector3(plant.coords.x, plant.coords.y, plant.coords.z + height), false, false, false)
                        local options = {
                            {
                                name = 'prdx_farming:OpenCropMenu',
                                event = 'prdx_farming:OpenCropMenu',
                                icon = 'fas fa-tractor',
                                label = 'Tend Crop',
                                distance = 1.5
                            }
                        }
                        exports.ox_target:addLocalEntity(data.spawnedEntity, options)
                        SetEntityAsMissionEntity(data.spawnedEntity, true)
                        FreezeEntityPosition(data.spawnedEntity, true)
                        SetObjectColour(data.spawnedEntity,1,128,0,128)
                        SetEntityLodDist(data.spawnedEntity, 1000)
                        table.insert(Farming.SpawnedPlants, data)
                        hasSpawned = false
                    end
                end
            end
        end
        Wait(5000)
    end
end
)

RegisterNetEvent('prdx_farming:removePlantObject', function(objectId)
    RemovePlant(objectId)
end)

function RemovePlant(plantId)
    p(1, 'Trying to remove plant object ' .. plantId)
    for index, plant in pairs(Farming.SpawnedPlants) do
        if plant.id == plantId then
            p(1, 'Removing plant object ' .. plant.id)
            SetEntityAsMissionEntity(plant.spawnedEntity, true, true)
            DeleteObject(plant.spawnedEntity)
            exports.ox_target:removeLocalEntity(plant.spawnedEntity, {'prdx_farming:OpenCropMenu'})    
            table.remove(Farming.SpawnedPlants, index)
            RemovePlantFromTable(plant.id)
        end
    end
end

RegisterNetEvent('prdx_farming:newPlantData', function(validPlants, plantsToRemove)
    Farming.AllPlants = {}
    inserting = true
    for _, v in pairs(validPlants) do
        local _plant = {}
        _plant.clientData = table.find(v.type, Config.Plants)
        _plant.id = v.id
        _plant.coords = vector3(v.coords.x,v.coords.y,v.coords.z)
        _plant.water = v.water
        _plant.fertilizer = v.fertilizer
        _plant.health = v.health
        _plant.growth = v.growth
        _plant.soilQuality = v.soilQuality
        table.insert(Farming.AllPlants, _plant)
        if curentPlant ~= nil and v.id == curentPlant.id then
            curentPlant = _plant
        end
        _plant = {}
    end
    for _, v in pairs(plantsToRemove) do
        RemovePlant(v)
        v = nil
    end
    Farming.ClosePlants = ReChunk(GetEntityCoords(cache.ped), Farming.AllPlants)
    inserting = false
end)

RegisterNetEvent('prdx_farming:CLSyncFarmingData', function()
   local coords = GetEntityCoords(cache.ped)
    if not coords then return end
    TriggerServerEvent('prdx_farming:SVSyncFarmingData', coords)
end)

RegisterNetEvent('prdx_farming:TryToPlant', function(type, planter)
    if busy then QBCore.Functions.Notify('Action impossible', 'error', 10000); return end
    busy = true
    SetTimeout(2500, function()
        busy = false
    end)
    local found = false
    local plantData
    for k, v in pairs(Config.Plants) do
        if v.type == type then
            plantData = v
            found = true
        end
    end
    local closestPlant = GetClosestPlant()
    local targetPlantResult = getPlantingLocation(plantData)
    if not next(targetPlantResult) then
        p(3, 'Cannot find plant ' .. type .. ' in config file.')
        return
    end
    if targetPlantResult.reason == 'planting_not_suitable_soil' then Notify('error', Lang[Config.Language].Notification.notSuitableSoil) return end
    if targetPlantResult.reason == 'planting_too_steep' then Notify('error', Lang[Config.Language].Notification.tooSteepTerrain) return end
    if targetPlantResult.reason == 'planting_obstructed' then Notify('error', Lang[Config.Language].Notification.plantingObstructed) return end
    if targetPlantResult.reason == 'planting_too_far' then Notify('error', Lang[Config.Language].Notification.planting_too_far) return end
    if targetPlantResult.reason == 'planting_in_vehicle' then Notify('error', Lang[Config.Language].Notification.planting_too_far) return end
    if targetPlantResult.reason == 'not_inside_farm' then Notify('error', Lang[Config.Language].Notification.not_inside_farm) return end
    if not targetPlantResult.plantable then busy = false return end
    if closestPlant then
        if closestPlant.coords then
            if #(vector3(targetPlantResult.targetCoords.x,targetPlantResult.targetCoords.y,targetPlantResult.targetCoords.z) - vector3(closestPlant.coords.x,closestPlant.coords.y,closestPlant.coords.z)) < Config.MinimumDistanceBetweenPlants then
                Notify('error', Lang[Config.Language].Notification.tooCloseToOtherPlant)
                return
            end
        end
    end
    local data = {}
    data.coords = targetPlantResult.targetCoords
    TaskStartScenarioInPlace(cache.ped, 'world_human_gardener_plant', 0, false)
    Wait(1000)
    ClearPedTasks(cache.ped)
    data.type = type
    data.soil = targetPlantResult.soil
    data.planter = planter
    data.illegal = plantData.illegal
    TriggerServerEvent('prdx_farming:createNewPlant', data)
end)

RegisterNetEvent('prdx_farming:spawnNewPlant', function(newPlant)
    local plant = table.find(newPlant.type, Config.Plants)
    plant.growthStage = 1
    if not plant then p(3, 'This plant does not exist! Make sure that you have configured it correctly.') return end
    local closestPlant = GetClosestPlant()
    if closestPlant.coords then
        if #(vector3(newPlant.coords.x, newPlant.coords.y, newPlant.coords.z) - closestPlant.coords) < Config.MinimumDistanceBetweenPlants then
            Notify('error', Lang[Config.Language].Notification.tooCloseToOtherPlant)
            return
        end
    end
    lib.requestAnimDict('amb@prop_human_bum_bin@base')
    QBCore.Functions.Progressbar("plant_crop", "Planting crop", math.random(7500,15000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'amb@prop_human_bum_bin@base',
        anim = 'base',
        flags = 49,
    }, {}, {}, function() -- Done
        newPlant.name = plant.name
        table.insert(Farming.AllPlants, newPlant)
        StopAnimTask(cache.ped, 'amb@prop_human_bum_bin@base', 'base', 0)
        RemovePropFromPed()
        TriggerServerEvent('prdx_farming:UpdatePlant', plant, 'water')
        StopParticleFxLooped(ptfx)
    end, function() -- Cancel
        StopAnimTask(cache.ped, 'amb@prop_human_bum_bin@base', 'base', 0)
        StopParticleFxLooped(ptfx)
    end)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for index, plant in pairs(Farming.SpawnedPlants) do
        p(1, 'Removing plant object: ' .. plant.id)
        RemovePlant(plant.id)
        RemovePlantFromTable(plant.id)
    end
    RemovePropFromPed()
end)

function HarvestPlant(plant)
    TaskTurnPedToFaceCoord(cache.ped, plant.coords, 5000)
    lib.requestAnimDict('amb@prop_human_bum_bin@base')
    TaskPlayAnim(PlayerPedId(), 'amb@prop_human_bum_bin@base', 'base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
    Wait(3000)
    ClearPedTasksImmediately(PlayerPedId())
    TaskStartScenarioInPlace(PlayerPedId(), 'world_human_gardener_plant', 0, false)
    Wait(1000)
    RemovePlant(objectId)
    ClearPedTasksImmediately(PlayerPedId())
end

Notify = function(type, text)
    QBCore.Functions.Notify(text, type, 10000)
end

AddEventHandler('polyzonehelper:enter', function(name)
    if not LocalPlayer.state["isLoggedIn"] then return end
    if name == "FarmingZone" then
        InsideFarm = true
    end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if not LocalPlayer.state["isLoggedIn"] then return end
    if name == "FarmingZone" then
        InsideFarm = false
    end
end)

CreateThread(function ()
    -- Farming Zones --

    -- Farm 1
    exports['polyzonehelper']:AddBoxZone("FarmingZone", vector3(1956.58, 4796.22, 44.08), 46.8, 37.8, {
        name="FarmingZone",
        heading = 315,
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 2
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(1917.4445800781, 4787.197265625),
        vector2(1924.4217529297, 4792.4111328125),
        vector2(1944.3577880859, 4772.1860351563),
        vector2(1948.7185058594, 4764.4926757813),
        vector2(1931.6005859375, 4749.0092773438),
        vector2(1910.0610351563, 4738.3852539063),
        vector2(1901.9315185547, 4740.2397460938),
        vector2(1880.3326416016, 4761.5170898438),
        vector2(1892.2426757813, 4770.677734375),
        vector2(1903.2650146484, 4775.5517578125)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 3
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(1875.1260986328, 4767.4033203125),
        vector2(1832.1806640625, 4809.8696289063),
        vector2(1869.5775146484, 4846.0263671875),
        vector2(1917.8603515625, 4798.1625976563),
        vector2(1918.8740234375, 4797.384765625),
        vector2(1897.7171630859, 4780.9438476563),
        vector2(1880.8612060547, 4770.40625)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 4
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(2078.5561523438, 5184.810546875),
        vector2(2090.4870605469, 5195.3266601563),
        vector2(2103.3332519531, 5203.3071289063),
        vector2(2116.5551757813, 5208.6958007813),
        vector2(2135.2639160156, 5212.16015625),
        vector2(2190.5051269531, 5152.009765625),
        vector2(2149.6123046875, 5114.1650390625),
        vector2(2148.7707519531, 5114.9501953125),
        vector2(2146.0258789063, 5112.3403320313)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 5
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(2146.8310546875, 5211.9970703125),
        vector2(2170.0932617188, 5210.1254882813),
        vector2(2180.3840332031, 5205.484375),
        vector2(2197.6650390625, 5194.7211914063),
        vector2(2215.9797363281, 5176.2241210938),
        vector2(2214.9990234375, 5173.2651367188),
        vector2(2211.1875, 5168.5561523438),
        vector2(2199.70703125, 5158.7163085938),
        vector2(2195.3278808594, 5158.0522460938),
        vector2(2191.4165039063, 5161.5170898438)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 6
    exports['polyzonehelper']:AddBoxZone("FarmingZone", vector3(2307.65, 5126.02, 53.47), 80.6, 51.6, {
        name="FarmingZone",
        heading = 46,
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 7
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(2495.8400878906, 4885.1005859375),
        vector2(2455.5053710938, 4843.3364257813),
        vector2(2473.9411621094, 4826.9448242188),
        vector2(2481.3264160156, 4828.1020507813),
        vector2(2491.5776367188, 4825.3657226563),
        vector2(2523.8354492188, 4859.35546875)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 8
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(2531.0473632813, 4852.873046875),
        vector2(2588.9387207031, 4800.30078125),
        vector2(2562.0681152344, 4774.1513671875),
        vector2(2555.1103515625, 4774.5595703125),
        vector2(2547.9064941406, 4774.6435546875),
        vector2(2544.2844238281, 4773.724609375),
        vector2(2496.9052734375, 4817.5571289063)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 9
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(2622.0151367188, 4739.2690429688),
        vector2(2626.1003417969, 4737.9638671875),
        vector2(2666.9475097656, 4696.7924804688),
        vector2(2682.8781738281, 4636.5185546875),
        vector2(2681.1730957031, 4634.6625976563),
        vector2(2678.6433105469, 4634.1157226563),
        vector2(2675.283203125, 4635.5439453125),
        vector2(2672.6748046875, 4637.0493164063),
        vector2(2654.2502441406, 4655.1455078125),
        vector2(2641.7253417969, 4671.6625976563),
        vector2(2635.7839355469, 4679.2583007813),
        vector2(2633.5068359375, 4684.1904296875),
        vector2(2628.7158203125, 4685.9326171875),
        vector2(2627.7102050781, 4686.2221679688),
        vector2(2625.9155273438, 4687.4047851563),
        vector2(2601.2939453125, 4711.2553710938),
        vector2(2598.7185058594, 4714.6943359375),
        vector2(2598.4702148438, 4718.568359375),
        vector2(2598.8542480469, 4722.9619140625),
        vector2(2600.9853515625, 4726.9565429688),
        vector2(2606.3464355469, 4732.6328125),
        vector2(2612.7912597656, 4737.4267578125),
        vector2(2616.97265625, 4738.9594726563)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 10
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(2576.1520996094, 4350.0263671875),
        vector2(2574.8671875, 4345.7607421875),
        vector2(2568.8349609375, 4340.5532226563),
        vector2(2554.8635253906, 4331.3217773438),
        vector2(2539.5944824219, 4324.0244140625),
        vector2(2525.8073730469, 4322.7573242188),
        vector2(2485.3894042969, 4330.513671875),
        vector2(2480.9682617188, 4333.9619140625),
        vector2(2480.2883300781, 4338.98046875),
        vector2(2482.625, 4343.4443359375),
        vector2(2498.1706542969, 4384.7065429688),
        vector2(2502.3947753906, 4393.5180664063),
        vector2(2507.7165527344, 4402.921875),
        vector2(2509.1489257813, 4405.4321289063),
        vector2(2516.1176757813, 4399.7275390625),
        vector2(2524.2854003906, 4409.8383789063),
        vector2(2555.7221679688, 4378.015625),
        vector2(2575.6437988281, 4358.2412109375),
        vector2(2577.4968261719, 4352.1884765625)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 11
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(2817.4711914063, 4586.291015625),
        vector2(2801.935546875, 4647.3984375),
        vector2(2803.25390625, 4649.703125),
        vector2(2805.8479003906, 4652.0595703125),
        vector2(2811.7346191406, 4658.5346679688),
        vector2(2881.7548828125, 4676.3720703125),
        vector2(2901.7307128906, 4598.13671875),
        vector2(2900.0339355469, 4595.2392578125),
        vector2(2898.5754394531, 4593.5908203125),
        vector2(2896.5388183594, 4591.6166992188),
        vector2(2891.5344238281, 4588.6459960938),
        vector2(2887.041015625, 4587.5649414063),
        vector2(2884.7236328125, 4586.23828125),
        vector2(2885.4221191406, 4581.2612304688),
        vector2(2884.1650390625, 4579.1787109375),
        vector2(2843.9211425781, 4569.0),
        vector2(2836.9196777344, 4590.7431640625)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
    
    -- Farm 12
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(2897.201171875, 4685.654296875),
        vector2(2943.6647949219, 4696.8935546875),
        vector2(2949.1220703125, 4672.9052734375),
        vector2(2938.3708496094, 4669.9794921875),
        vector2(2926.8500976563, 4668.017578125),
        vector2(2922.0649414063, 4662.2802734375),
        vector2(2918.6916503906, 4658.8676757813),
        vector2(2911.7770996094, 4657.021484375),
        vector2(2911.8125, 4654.0166015625),
        vector2(2909.935546875, 4651.2143554688),
        vector2(2904.2565917969, 4650.0776367188)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })

    -- Paleto --
    --Name: FarmingZone | 2023-02-20T18:45:32Z
    exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(206.05799865723, 6478.9174804688),
        vector2(209.23570251465, 6464.5229492188),
        vector2(233.52291870117, 6441.826171875),
        vector2(290.32870483398, 6446.6870117188),
        vector2(288.66644287109, 6484.9340820313)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
  
  --Name: FarmingZone | 2023-02-20T18:46:38Z
   exports['polyzonehelper']:AddPolyZone("FarmingZone", {
        vector2(610.28167724609, 6502.1430664063),
        vector2(754.64440917969, 6476.2534179688),
        vector2(745.38879394531, 6452.5512695313),
        vector2(611.58758544922, 6458.3901367188)
    }, {
        name="FarmingZone",
        debugPoly = false,
        minZ=21.0,
        maxZ=82.0
    })
end)