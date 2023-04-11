local QBCore = exports['qb-core']:GetCoreObject()
local SpawnedBait = nil
local InsideHuntingZone = false
exports['polyzonehelper']:AddPolyZone("HuntingZone", {
    vector2(-2162.7736816406, 4417.4995117188),
    vector2(-1198.5750732422, 3837.533203125),
    vector2(-381.80087280273, 3866.7946777344),
    vector2(-272.88235473633, 4034.8596191406),
    vector2(-228.74833679199, 4187.8388671875),
    vector2(-120.06370544434, 4289.90234375),
    vector2(31.396734237671, 4443.5263671875),
    vector2(672.56884765625, 4221.880859375),
    vector2(1157.3256835938, 4433.3315429688),
    vector2(1715.8963623047, 4578.7075195313),
    vector2(1652.4188232422, 4895.9594726563),
    vector2(1895.4116210938, 5151.5498046875),
    vector2(2166.6164550781, 5238.19140625),
    vector2(2594.4519042969, 5123.1025390625),
    vector2(2200.2795410156, 6027.3950195313),
    vector2(1412.275390625, 6443.1088867188),
    vector2(640.62487792969, 6507.71484375),
    vector2(154.72735595703, 6496.9350585938),
    vector2(-490.64694213867, 5815.4116210938),
    vector2(-641.74224853516, 5559.560546875),
    vector2(-1274.8883056641, 5234.8588867188),
    vector2(-1440.0736083984, 5037.5732421875),
    vector2(-1774.7963867188, 4728.9672851563),
    vector2(-1959.3195800781, 4538.984375)
}, {
    name="HuntingZone",
    debugPoly = false,
})

AddEventHandler('polyzonehelper:enter', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "HuntingZone" then
            InsideHuntingZone = true
        end  
    end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "HuntingZone" then
            InsideHuntingZone = false
        end
    end
end)


local baitexists, baitLocation, HuntedAnimalTable, busy = 0, nil, {}, false
DecorRegister('MyAnimal', 2) -- don't touch it

isValidZone =  function()
    local zoneInH = GetNameOfZone(GetEntityCoords(PlayerPedId()))
    for k, v in pairs(AOD.HuntingZones) do
        if zoneInH == v or AOD.HuntAnyWhere == true then
            return true
        end
    end

end

SetSpawn = function(baitLocation)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local spawnCoords = nil
    while spawnCoords == nil do
        local spawnX = math.random(-AOD.SpawnDistanceRadius, AOD.SpawnDistanceRadius)
        local spawnY = math.random(-AOD.SpawnDistanceRadius, AOD.SpawnDistanceRadius)
        local spawnZ = baitLocation.z
        local vec = vector3(baitLocation.x + spawnX, baitLocation.y + spawnY, spawnZ)
        if #(playerCoords - vec) > AOD.SpawnDistanceRadius then
            spawnCoords = vec
        end
    end
    local worked, groundZ, normal = GetGroundZAndNormalFor_3dCoord(spawnCoords.x, spawnCoords.y, 1023.9)
    spawnCoords = vector3(spawnCoords.x, spawnCoords.y, groundZ)
    return spawnCoords
end

baitDown = function(baitLocation)
    Citizen.CreateThread(function()
        while baitLocation ~= nil do
            local coords = GetEntityCoords(PlayerPedId())
            if #(baitLocation - coords) > AOD.DistanceFromBait then
                if math.random(0, 100) <= AOD.SpawnChance then
                    SpawnAnimal(baitLocation)
                    baitLocation = nil
                end
            end
            Citizen.Wait(15000)
        end
    end)
end

SpawnAnimal = function(location)
    local spawn = SetSpawn(location)
    local model = AOD.HuntAnimals[math.random(1,#AOD.HuntAnimals)]
    QBCore.Functions.SpawnPed(model, function(prey)
        DecorSetBool(prey, 'MyAnimal', true)
        TaskGoToCoordAnyMeans(prey, location, 1.0, 0, 0, 786603, 1.0)
        table.insert(HuntedAnimalTable, {id = prey, animal = model})
        if AOD.UseBlip then
            local blip = AddBlipForEntity(prey)
                SetBlipDisplay(blip, 2)
                SetBlipScale  (blip, 0.5)
                SetBlipColour (blip, 2)
                SetBlipAsShortRange(blip, false)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(AOD.BlipText)
                EndTextCommandSetBlipName(blip)
        end
        Citizen.CreateThread(function()
            local destination = false
            while not IsPedDeadOrDying(prey) and not destination do
                local preyCoords = GetEntityCoords(prey)
                local distance = #(location - preyCoords)
                local guy = PlayerPedId()
                if distance < 0.35 then
                    ClearPedTasks(prey)
                    Citizen.Wait(1500)
                    TaskStartScenarioInPlace(prey, 'WORLD_DEER_GRAZING', 0, true)
                    Citizen.SetTimeout(8000, function()
                        destination = true
                    end)
                end
                if #(preyCoords - GetEntityCoords(guy)) < AOD.DistanceTooCloseToAnimal then
                    ClearPedTasks(prey)
                    TaskSmartFleePed(prey, guy,600.0, -1, true, true)
                    destination = true
                end
                Citizen.Wait(1000)
            end
            if not IsPedDeadOrDying(prey) then
                TaskSmartFleePed(prey, guy,600.0, -1, true, true)
            end
        end)
    end, spawn, true)
end

RegisterNetEvent('AOD-huntingbait')
AddEventHandler('AOD-huntingbait', function(item)
    if not InsideHuntingZone then
        Notify(AOD.Strings.NotValidZone)
        return
    end
    if busy then
        Notify(AOD.Strings.ExploitDetected)
        Citizen.Wait(2000)
        Notify(AOD.Strings.DontSpawm)
        TriggerServerEvent('AOD-hunt:TakeItem', 'huntingbait')
        return
    end
    if baitexists ~= 0 and GetGameTimer() < (baitexists + 90000) then
        Notify(AOD.Strings.WaitToBait)
        return
    end
    busy = true
    local player = PlayerPedId()
    TaskStartScenarioInPlace(player, 'WORLD_HUMAN_GARDENER_PLANT', 0, true)
    DeleteBaitItem()
    QBCore.Functions.Progressbar("placing_bait", AOD.Strings.PlacingBait, 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        ClearPedTasks(player)
        baitexists = GetGameTimer()
        local baitLocation = GetEntityCoords(player)
        Notify(AOD.Strings.BaitPlaced)
        TriggerServerEvent('AOD-hunt:TakeItem', item)
        baitDown(baitLocation)
        SpawnBaitItem(baitLocation)
        busy = false
    end, function()
        ClearPedTasks(player)
        QBCore.Functions.Notify("Failed!", "error")
        busy = false
        baitexists = 0
    end)
end)

RegisterNetEvent('AOD-huntingknife')
AddEventHandler('AOD-huntingknife', function(item)
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        for index, value in ipairs(HuntedAnimalTable) do
            local person = PlayerPedId()
            local AnimalCoords = GetEntityCoords(value.id)
            local PlyCoords = GetEntityCoords(person)
            local AnimalHealth = GetEntityHealth(value.id)
            local PlyToAnimal = #(PlyCoords - AnimalCoords)
            local gun = AOD.HuntingWeapon
            local d = GetPedCauseOfDeath(value.id)
            if DoesEntityExist(value.id) and AnimalHealth <= 0 and PlyToAnimal < 2.0 and (gun == d or gun == nil) and not busy then
                busy = true
                LoadAnimDict('amb@medic@standing@kneel@base')
                LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
                TaskTurnPedToFaceEntity(person, value.id, -1)
                Citizen.Wait(1500)
                ClearPedTasksImmediately(person)
                TaskPlayAnim(person, 'amb@medic@standing@kneel@base' ,'base' ,8.0, -8.0, -1, 1, 0, false, false, false )
                TaskPlayAnim(person, 'anim@gangops@facility@servers@bodysearch@' ,'player_search' ,8.0, -8.0, -1, 48, 0, false, false, false )
                QBCore.Functions.Progressbar("butchering", AOD.Strings.Harvest, 30000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    ClearPedTasks(person)
                    Notify(AOD.Strings.Butchered)                   
                    TriggerServerEvent('AOD-butcheranimal', value.animal, PedToNet(value.id))
                    TriggerServerEvent('AOD-hunt:TakeItem', item)
                    busy = false
                    table.remove(HuntedAnimalTable, index)
                    DeleteBaitItem()
                    QBCore.Functions.DeleteEntity(value.id)
                end, function()
                    QBCore.Functions.Notify("Failed!", "error")
                end)
            elseif busy then
                Notify(AOD.Strings.ExploitDetected)
            elseif gun ~= d and AnimalHealth <= 0 and PlyToAnimal < 2.0 then
                Notify(AOD.Strings.Roadkill)
                QBCore.Functions.DeleteEntity(value.id)
                table.remove(HuntedAnimalTable, index)
                DeleteBaitItem()
            elseif PlyToAnimal > 3.0 then
                Notify(AOD.Strings.NoAnimal)
            elseif AnimalHealth > 0 then
                Notify(AOD.Strings.NotDead)
            elseif not DoesEntityExist(value.id) and PlyToAnimal < 2.0 then
                Notify(AOD.Strings.NotYours)
            else
                Notify(AOD.Strings.WTF)
            end
        end
    end)
end)

AddEventHandler('AOD-HuntingBuyerMenu', function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local licensesMeta = PlayerData.metadata["licences"]
    if not licensesMeta["hunting"] then
        QBCore.Functions.Notify("You don't have a valid hunting license!", "error")
        return
    end
	local SellMenu = ''
	for k,v in pairs(AOD.SellItems) do
		SellMenu = SellMenu..exports.ox_inventory:Items()[k]["description"]..':		$'..v..'  \n'
	end
    local menu = {
        {
            title = "Current Prices:", 
            description = SellMenu,
            disabled = true,
        },
		{
            title = "Open Meat Sell Box", 
			event = "target:client:openStash",
            args = data
        },
        {
            title = "Sell Meat", 
            event = "AOD-sellMeatMenu"
        }     
    }
    lib.registerContext({
		id = 'meat_buyer_menu',
		title = 'Meat Buyer',
		options = menu,
	})
	lib.showContext('meat_buyer_menu')
end)

AddEventHandler('AOD-sellMeatMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'meatsell', true}
        }      
    }
    lib.registerContext({
		id = 'meat_sell_menu',
		title = 'Sell Meat',
        menu = 'meat_buyer_menu',
		options = menu,
	})
	lib.showContext('meat_sell_menu')
end)

SpawnBaitItem = function(result)
    local model = "prop_drug_package_02"
    QBCore.Functions.SpawnObject(model, function(bait)
        Wait(250)
        FreezeEntityPosition(bait, true)
        PlaceObjectOnGroundProperly(bait)
        SpawnedBait = NetworkGetNetworkIdFromEntity(bait)
    end, vec3(result.x , result.y , result.z- 1.0), true)            
end

DeleteBaitItem = function()
    local player = PlayerPedId()
    if SpawnedBait then
        local bait = NetworkGetNetworkIdFromEntity(SpawnedBait)
        QBCore.Functions.DeleteEntity(bait)
    end
end


LoadAnimDict = function(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

Notify = function(text, timer)
    if timer == nil then
        timer = 5000
    end
    QBCore.Functions.Notify(text, "error")
end

