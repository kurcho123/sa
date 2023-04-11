QBCore = exports['qb-core']:GetCoreObject()
local ShowPeds = fasle
local Peds = {}
local isLeadingCattle = false
local LeadingCattle = {}
local isBusy = false
local Zone1 = PolyZone:Create({
    vector2(2283.7390136719, 4931.490234375),
    vector2(2293.8583984375, 4941.7426757813),
    vector2(2299.5795898438, 4935.9609375),
    vector2(2299.2841796875, 4933.3076171875),
    vector2(2290.6357421875, 4924.5791015625)
  }, {
    name="SellZone1",
    --minZ = 41.429527282715,
    --maxZ = 43.099346160889
})

local Zone2 = PolyZone:Create({
  vector2(2299.6030273438, 4933.4682617188),
  vector2(2301.9582519531, 4933.630859375),
  vector2(2306.2531738281, 4929.162109375),
  vector2(2296.1264648438, 4919.0043945313),
  vector2(2290.6689453125, 4924.5415039063)
}, {
  name="SellZone2",
  --minZ = 41.433494567871,
  --maxZ = 41.433494567871
})

AddEventHandler('prdx_ranching:OpenRanchMenu', function(data)
    QBCore.Functions.TriggerCallback("prdx_ranching:server:getCattleByNetId", function(cattle)
        if cattle then
            ClearPedTasks(data.entity)
            SetEntityInvincible(data.entity)
            SetTimeout(30000, function ()
                if not isLeadingCattle then
                    while isBusy do
                        Wait(0)
                    end -- Prevent stupid animal walking away when interacting
                    --TaskWanderInArea(data.entity, GetEntityCoords(data.entity), 15.0, 5.0, -1)
                    SetPedKeepTask(data.entity, true)
                end
            end)
            local menu = {
                {
                    title = "Animal Status:", 
                    description = "Growth: "..math.floor(cattle.growth * 100) .."% \n Health: "..math.floor(cattle.health * 100) .."% \n Hydation Level: "..math.floor(cattle.water * 100) .."% \n Nutrition Level: "..math.floor(cattle.food * 100) .."%", 
                    disabled = true
                },
            }
            menu[#menu + 1] = {
                title = "Hydrate Animal", 
                event = "prdx_ranching:client:HydrateAnimal",
                args = cattle
            }
            menu[#menu + 1] = {
                title = "Feed Animal", 
                event = "prdx_ranching:client:FeedAnimal",
                args = cattle
            }
            if cattle.milk then
                menu[#menu + 1] =  {
                    title = "Milk Animal", 
                    event = "prdx_ranching:client:MilkAnimal",
                    args = cattle
                }
            end

            if cattle.egg then
                menu[#menu + 1] =  {
                    title = "Check for eggs", 
                    event = "prdx_ranching:client:EggAnimal",
                    args = cattle
                }
            end

            if cattle.mushrooms then
                menu[#menu + 1] =  {
                    title = "Check for Mushrooms", 
                    event = "prdx_ranching:client:mushroomsAnimal",
                    args = cattle
                }
            end

            if isLeadingCattle then
                menu[#menu + 1] =  {
                    title = "Stop Leading", 
                    event = "prdx_ranching:client:StopLeadAnimal",
                    args = data.entity
                }
            else
                menu[#menu + 1] =  {
                    title = "Lead Animal", 
                    event = "prdx_ranching:client:LeadAnimal",
                    args = data.entity
                }
            end
            menu[#menu + 1] = {
                title = "Reset Animal", 
                event = "prdx_ranching:client:ResetAnimal",
                args = data.entity
            }
            lib.registerContext({
                id = 'ranch_menu',
                title = cattle.animal ..': '..cattle.id,
                options = menu,
            })
            lib.showContext('ranch_menu') 
        end
    end, NetworkGetNetworkIdFromEntity(data.entity))
end)


AddEventHandler('prdx_ranching:client:OpenCattleDealer', function(data)
    QBCore.Functions.TriggerCallback("prdx_ranching:server:loadCattle", function(cattle)
        local Cow = 0
        local Pig = 0
        local Chicken = 0
        if cattle then
            for k,v in pairs(cattle) do
                if v.animal == 'Cow' then Cow = Cow + 1 end
                if v.animal == 'Pig' then Pig = Pig + 1 end
                if v.animal == 'Chicken' then Chicken = Chicken + 1 end
            end
        end

        local menu = {
            {
                title = "Current Animals:", 
                description = "\nCows: "..Cow .."\nPigs: "..Pig.."\nChickens: "..Chicken, 
                disabled = true
            },
            {
                title = 'Purchase Cattle:',
                disabled = true
            },
            {
                title = "Purchase Cow", 
                description = '$'..Config.Ranching.Costs.Cow,
                event = "prdx_ranching:client:BuyCattleMenu",
                args = {cost = Config.Ranching.Costs.Cow, animal = 'Cow'}
            },
            {
                title = "Purchase Pig", 
                description = '$'..Config.Ranching.Costs.Pig,
                event = "prdx_ranching:client:BuyCattleMenu",
                args = {cost = Config.Ranching.Costs.Pig, animal = 'Pig'}
            },
            {
                title = "Purchase Chicken", 
                description = '$'..Config.Ranching.Costs.Chicken,
                event = "prdx_ranching:client:BuyCattleMenu",
                args = {cost = Config.Ranching.Costs.Chicken, animal = 'Chicken'}
            }
        }
        lib.registerContext({
            id = 'cattle_dealer_menu',
            title = 'Grapeseed Farms Cattle',
            options = menu,
        })
        lib.showContext('cattle_dealer_menu')
    end)
end)

AddEventHandler('prdx_ranching:client:BuyCattleMenu', function(data)
    local menu = {
        {
            title = 'Confirm Purchase:',
            disabled = true
        },
        {
            title = "Purchase "..data.animal, 
            description = '$'..data.cost,
            event = "prdx_ranching:client:BuyCattle",
            args = data
        },
        {
            title = "Cancel Purchase", 
            event = "prdx_ranching:client:OpenCattleDealer",
        },
    }
    lib.registerContext({
        id = 'buy_cattle_menu',
        title = 'Grapeseed Farms Cattle',
        options = menu,
    })
    lib.showContext('buy_cattle_menu')
end)

AddEventHandler('prdx_ranching:client:OpenCattleSell', function(data)
    local menu = {
        {
            title = 'Sell Cattle',
            description = 'Select a pen to sell from',
            disabled = true
        },
        {
            title = "Selling Pen North", 
            description = 'Sell all animals on the left side',
            event = "prdx_ranching:client:GenerateSale",
            args = 1
        },
        {
            title = "Selling Pen South", 
            description = 'Sell all animals on the right side',
            event = "prdx_ranching:client:GenerateSale",
            args = 2
        },
    }
    lib.registerContext({
        id = 'sell_cattle_menu',
        title = 'Grapeseed Farms Cattle',
        options = menu,
    })
    lib.showContext('sell_cattle_menu')
end)

AddEventHandler('prdx_ranching:client:sellStashMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'ranchsell', true}          
        }     
    }
    lib.registerContext({
        id = 'sell_meat_menu',
        title = 'Sell Meat',
        options = menu,
    })
    lib.showContext('sell_meat_menu')
end)

AddEventHandler('prdx_ranching:client:GenerateSale', function(Zone)
    local AllPeds = QBCore.Functions.GetPeds({})
    local SellPeds = {}
    for k,v in pairs(AllPeds) do
        local pedCoords = GetEntityCoords(v)
        if Zone == 1 then
            if Zone1:isPointInside(pedCoords) then
                SellPeds[#SellPeds+1] = NetworkGetNetworkIdFromEntity(v)
            end
        elseif Zone == 2 then
            if Zone2:isPointInside(pedCoords) then
                SellPeds[#SellPeds+1] = NetworkGetNetworkIdFromEntity(v)
            end
        end
    end
    if #SellPeds > 0 then
        QBCore.Functions.TriggerCallback("prdx_ranching:server:generatePrice", function(amounts)
            if amounts then
                local menu = {
                    {
                        title = 'Butcher Estimate:',
                        description = 'This action is not reversable',
                        disabled = true
                    },
                    {
                        title = "Butcher Animals", 
                        description = amounts,
                        serverEvent = "prdx_ranching:server:SellCattle",
                        args = SellPeds
                    },
                    {
                        title = "Cancel", 
                        event = "prdx_ranching:client:OpenCattleSell"
                    },
                }
                lib.registerContext({
                    id = 'sell_cattle_confirm_menu',
                    title = 'Grapeseed Farms Cattle',
                    options = menu,
                })
                lib.showContext('sell_cattle_confirm_menu')
            else
                QBCore.Functions.Notify('No animals owned in pen!', 'error')
                TriggerEvent('prdx_ranching:client:OpenCattleSell')
            end
        end, SellPeds)
    else
        QBCore.Functions.Notify('No animals in pen!', 'error')
    end
end)

AddEventHandler('prdx_ranching:client:BuyCattle', function(data)
    for SpawnAnimal, SpawnPoints in pairs(Config.Ranching.SpawnPoints) do
        if SpawnAnimal == data.animal then
            for k,coords in pairs(SpawnPoints) do
                if QBCore.Functions.IsSpawnPointClear(coords, 5) then
                    TriggerServerEvent('prdx_ranching:server:BuyCattle', data, coords)
                    break
                end
            end
        end
    end
end)

AddEventHandler('prdx_ranching:client:ResetAnimal', function(animal)
    if DoesEntityExist(animal) then
        QBCore.Functions.TakeControl(animal)
        local ent = Entity(animal)
        QBCore.Functions.SetStateBag(animal, 'isLead', false)
        local coords = GetEntityCoords(animal)
        ClearPedTasksImmediately(animal)
        SetEntityInvincible(animal, true)
        SetEntityMaxHealth(animal, 5000)
        SetEntityHealth(animal, 5000)
        SetPedCanRagdoll(animal, false)
        SetPedCanBeTargetted(animal, false)
        SetBlockingOfNonTemporaryEvents(animal, true)
        --TaskWanderInArea(animal, coords, 5.0, 5.0, -1)
        SetPedKeepTask(animal, true)
        isLeadingCattle = false            
        QBCore.Functions.Notify('Reset animal')
    end
end)

AddEventHandler('prdx_ranching:client:StopLeadAnimal', function(animal)
    if DoesEntityExist(animal) then
        local ent = Entity(animal)
        if ent.state.isLead and isLeadingCattle then
            QBCore.Functions.SetStateBag(animal, 'isLead', false)
            QBCore.Functions.TakeControl(animal)
            ClearPedTasksImmediately(animal)
            SetNetworkIdCanMigrate(ObjToNet(animal), true)
            SetEntityInvincible(animal, true)
            --TaskWanderInArea(animal, GetEntityCoords(animal), 5.0, 5.0, -1)
            SetPedKeepTask(animal, true) 
            isLeadingCattle = false
        else
            QBCore.Functions.Notify('You are not leading any animals?', 'error')

            -- not being lead
        end
    end
end)

AddEventHandler('prdx_ranching:client:LeadAnimal', function(animal)
    if DoesEntityExist(animal) then
        local ent = Entity(animal)
        if not ent.state.isLead and not isLeadingCattle then
            QBCore.Functions.SetStateBag(animal, 'isLead', true)
            QBCore.Functions.TakeControl(animal)
            local coords = GetEntityCoords(animal)
            if IsPedDeadOrDying(animal) then
                SetEntityHealth(animal, 1000)
                SetEntityCoords(animal, coords)
                ClearPedTasksImmediately(animal)
            end
            SetNetworkIdCanMigrate(ObjToNet(animal), false)
            SetEntityInvincible(animal, true)
            ClearPedTasksImmediately(animal)
            TaskFollowToOffsetOfEntity(animal, PlayerPedId(), 1.2, 0.0, 0.0, 2.0, -1, 0.5, true)
            SetPedKeepTask(animal, true)    
            isLeadingCattle = true
        else
            QBCore.Functions.Notify('This animal is already being led or you are already leading an animal', 'error')
            -- already being lead
        end
    end
end)

RegisterNetEvent('prdx_ranching:client:SetWander', function(netid)
    if NetworkDoesEntityExistWithNetworkId(netid) then
        local Cattle = NetworkGetEntityFromNetworkId(netid)
        if DoesEntityExist(Cattle) then
            local coords = GetEntityCoords(Cattle)
            ClearPedTasksImmediately(animal)
            --TaskWanderInArea(Cattle, coords, 15.0, 5.0, -1)
            SetPedKeepTask(Cattle, true)
            SetEntityInvincible(Cattle, true)
            SetEntityMaxHealth(Cattle, 5000)
            SetEntityHealth(Cattle, 5000)
            SetPedCanRagdoll(Cattle, false)
            SetPedCanBeTargetted(Cattle, false)
            SetBlockingOfNonTemporaryEvents(Cattle, true)
        end
    end
end)

RegisterNetEvent('prdx_ranching:client:SetWanderTable', function(netids)
    for k,v in pairs(netids) do
        if NetworkDoesEntityExistWithNetworkId(v) then
            local Cattle = NetworkGetEntityFromNetworkId(v)
            if DoesEntityExist(Cattle) then
                local coords = GetEntityCoords(Cattle)
                ClearPedTasksImmediately(animal)
                --TaskWanderInArea(Cattle, coords, 5.0, 5.0, -1)
                SetPedKeepTask(Cattle, true)
                SetEntityInvincible(Cattle, true)
                SetEntityMaxHealth(Cattle, 5000)
                SetEntityHealth(Cattle, 5000)
                SetPedCanRagdoll(Cattle, false)
                SetPedCanBeTargetted(Cattle, false)
                SetBlockingOfNonTemporaryEvents(Cattle, true)
            end
        end
    end
end)



RegisterNetEvent('prdx_ranching:client:ShowMyAnimals', function()
    Peds = {}
    QBCore.Functions.TriggerCallback("prdx_ranching:server:loadCattle", function(cattle)
        local myid = QBCore.Functions.GetPlayerData().citizenid
        for k,v in pairs(cattle) do
            if v.owner == myid then
                Peds[#Peds+1] = NetworkGetEntityFromNetworkId(v.netid)
            end
        end
        ShowPeds = true
        SetTimeout(15000, function()
            ShowPeds = false
        end)
    end)
end)

CreateThread(function()
    while true do
        if ShowPeds then
            for k,v in pairs(Peds) do
                local coords = GetEntityCoords(v)
                DrawMarker(0, coords.x, coords.y, coords.z+0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 200, false, true, 2)
            end
        end
        Wait(1)
    end
end)

RegisterCommand('Animals', function(source, args)
    TriggerEvent('prdx_ranching:client:ShowMyAnimals')
    QBCore.Functions.Notify('Showing all animals you own')
end)

RegisterNetEvent('prdx_ranching:client:HydrateAnimal', function(cattle)
    if QBCore.Functions.HasItem('watering_can') then
        if isBusy then
            TriggerEvent('QBCore:Notify', "Error: Busy", 'error')
            return
        end
        isBusy = true
        TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(NetworkGetEntityFromNetworkId(cattle.netid)), 7500)
        TriggerEvent('animations:client:EmoteCommandStart', {"watering"})
        QBCore.Functions.Progressbar("hydrate_animal", "Giving water to animal...", math.random(7500,15000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent('prdx_ranching:hydrateCattle', cattle.id)
            isBusy = false
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            isBusy = false
        end)
    else 
        TriggerEvent('QBCore:Notify', "You don't have any water", 'error')
    end 
end)

RegisterNetEvent('prdx_ranching:client:MilkAnimal', function(cattle)
    if isBusy then
        TriggerEvent('QBCore:Notify', "Error: Busy", 'error')
        return
    end
    isBusy = true
    TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(NetworkGetEntityFromNetworkId(cattle.netid)), 7500)
    TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
    QBCore.Functions.Progressbar("milk_animal", "Milking cow...", math.random(7500,15000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('prdx_ranching:milkCattle', cattle.id)
        isBusy = false
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        isBusy = false
    end)
end)

RegisterNetEvent('prdx_ranching:client:EggAnimal', function(cattle)
    if isBusy then
        TriggerEvent('QBCore:Notify', "Error: Busy", 'error')
        return
    end
    isBusy = true
    TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(NetworkGetEntityFromNetworkId(cattle.netid)), 7500)
    TriggerEvent('animations:client:EmoteCommandStart', {"bumbin"})
    QBCore.Functions.Progressbar("egg_animal", "Collecting eggs...", math.random(7500,15000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('prdx_ranching:eggCattle', cattle.id)
        isBusy = false
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        isBusy = false
    end)
end)

RegisterNetEvent('prdx_ranching:client:mushroomsAnimal', function(cattle)
    if isBusy then
        TriggerEvent('QBCore:Notify', "Error: Busy", 'error')
        return
    end
    isBusy = true
    TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(NetworkGetEntityFromNetworkId(cattle.netid)), 7500)
    TriggerEvent('animations:client:EmoteCommandStart', {"medic"})
    QBCore.Functions.Progressbar("mushrooms_animal", "Collecting Mushrooms...", math.random(7500,15000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('prdx_ranching:mushroomsCattle', cattle.id)
        isBusy = false
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        isBusy = false
    end)
end)

RegisterNetEvent('prdx_ranching:client:KillAnimal', function(netid)
    if NetworkDoesEntityExistWithNetworkId(netid) then
        local Cattle = NetworkGetEntityFromNetworkId(netid)
        if DoesEntityExist(Cattle) then
            SetEntityHealth(Cattle, 0)
        end
    end
end)

RegisterNetEvent('prdx_ranching:client:FeedAnimal', function(cattle)
    local AnimalData = {}
    for k,v in pairs(Config.Ranching.Animals) do
        if k == cattle.animal then
            AnimalData = v
        end
    end
    if QBCore.Functions.HasItem(AnimalData.foodItem) then
        if isBusy then
            TriggerEvent('QBCore:Notify', "Error: Busy", 'error')
            return
        end
        isBusy = true
        TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(NetworkGetEntityFromNetworkId(cattle.netid)), 7500)
        TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
        QBCore.Functions.Progressbar("feed_animal", "Feeding animal...", math.random(7500,15000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent('prdx_ranching:feedCattle', cattle.id, AnimalData.foodItem)
            isBusy = false
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            isBusy = false
        end)
    else 
        TriggerEvent('QBCore:Notify', "You don't have any: "..exports.ox_inventory:Items()[AnimalData.foodItem]["label"], 'error')
    end 
end) 

