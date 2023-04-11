-- Variables
local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData() -- Just for resource restart (same as event handler)
local insideZones = {}
local showRoomVehicles = {}

for name in pairs(Config.Shops) do -- foreach shop
    insideZones[name] = false  -- default to not being in a shop
end

local testDriveVeh, inTestDrive = 0, false
local ClosestVehicle = 1
local zones = {}

local function getShopInsideOf()
    for name in pairs(Config.Shops) do -- foreach shop
        if insideZones[name] then
            return name
        end
    end
    return nil
end

local function FixShowroomCars()
    for k,v in pairs(showRoomVehicles) do
        SetVehicleOnGroundProperly(v)
    end
end

-- Handlers

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    local citizenid = PlayerData.citizenid
    local gameTime = GetGameTimer()
    TriggerServerEvent('qb-vehicleshop:server:addPlayer', citizenid, gameTime)
    TriggerServerEvent('qb-vehicleshop:server:checkFinance')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    local citizenid = PlayerData.citizenid
    TriggerServerEvent('qb-vehicleshop:server:removePlayer', citizenid)
    PlayerData = {}
end)

-- Static Headers

local vehHeaderMenu = {
    {
        header = 'Vehicle Options',
        icon = "fa-solid fa-car",
        txt = 'Interact with the current vehicle',
        params = {
            event = 'qb-vehicleshop:client:showVehOptions'
        }
    }
}

local financeMenu = {
    {
        
        header = 'Financed Vehicles',
        txt = 'Browse your owned vehicles',
        icon = "fa-solid fa-user-ninja",
        params = {
            event = 'qb-vehicleshop:client:getVehicles'
        }
    }
}

local returnTestDrive = {
    {
        header = 'Finish Test Drive',
        icon = "fa-solid fa-flag-checkered",
        params = {
            event = 'qb-vehicleshop:client:TestDriveReturn'
        }
    }
}

-- Functions

function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
        QBCore.Functions.TakeControl(object)
		DetachEntity(object, 0, false)
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end

local function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

local function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end
    return formatted
end

local function getVehName()
    return QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["name"]
end

local function getVehPrice()
    return comma_value(QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["price"])
end

local function getVehPriceManaged()
    local BasePrice = QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle]["price"]
    local ManagedPrice = BasePrice - (BasePrice * 0.10)
    return comma_value(ManagedPrice)
end

local function getVehBrand()
    return QBCore.Shared.Vehicles[Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle].brand
end

local function setClosestShowroomVehicle()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    local closestShop = getShopInsideOf()
    for id in pairs(Config.Shops[closestShop]["ShowroomVehicles"]) do
        local dist2 = #(pos - vector3(Config.Shops[closestShop]["ShowroomVehicles"][id].coords.x, Config.Shops[closestShop]["ShowroomVehicles"][id].coords.y, Config.Shops[closestShop]["ShowroomVehicles"][id].coords.z))
        if current then
            if dist2 < dist then
                current = id
                dist = dist2
            end
        else
            dist = dist2
            current = id
        end
    end
    if current ~= ClosestVehicle then
        ClosestVehicle = current
    end
end

local function createTestDriveReturn()
    testDriveZone = BoxZone:Create(
        Config.Shops[getShopInsideOf()]["ReturnLocation"],
        3.0,
        5.0,
    {
        name = "box_zone_testdrive_return_"..getShopInsideOf(),
    })

    testDriveZone:onPlayerInOut(function(isPointInside)
        if isPointInside and IsPedInAnyVehicle(PlayerPedId()) then
			SetVehicleForwardSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 0)
            lib.registerContext({
                id = 'returnTestDrive',
                title = 'Finish Test Drive',
                onExit = function() end,
                options = {
                    {
                        title = "Return vehicle",
                        event = "qb-vehicleshop:client:TestDriveReturn",
                    }
                }
            })
            lib.showContext('returnTestDrive')
        end
    end)
end

local function startTestDriveTimer(testDriveTime)
    local gameTimer = GetGameTimer()
    CreateThread(function()
        while inTestDrive do
            if GetGameTimer() < gameTimer + tonumber(1000 * testDriveTime) then
                local secondsLeft = GetGameTimer() - gameTimer
                drawTxt('Test Drive Time Remaining: '..math.ceil(testDriveTime - secondsLeft / 1000), 4, 0.5, 0.93, 0.50, 255, 255, 255, 180)
            end
            Wait(0)
        end
    end)
end

local function createVehZones(shopName, entity)
    exports['qb-target']:AddTargetEntity(entity, {
        options = {
            {
                type = "client",
                event = "qb-vehicleshop:client:showVehOptions",
                icon = "fas fa-car",
                label = "Vehicle Interaction",
                canInteract = function()
                    local closestShop = getShopInsideOf()
                    return closestShop and (Config.Shops[closestShop]['Job'] == 'none' or PlayerData.job.name == Config.Shops[closestShop]['Job'])
                end
            },
        },
        distance = 2.5
    })
end

-- Zones

function createFreeUseShop(shopShape, name)
    local zone = PolyZone:Create(shopShape, {  -- create the zone
        name= name,
        minZ = shopShape.minZ,
        maxZ = shopShape.maxZ,
    })

    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            FixShowroomCars()
            insideZones[name] = true
            CreateThread(function()
                while insideZones[name] do
                    setClosestShowroomVehicle()
                    vehicleMenu = {
                        {
                            disabled = true,
                            icon = "circle-info",
                            title = getVehBrand():upper()..' '..getVehName():upper()..' - $'..getVehPrice(),
                        },
                        {
                            title = 'Test Drive',
                            description = 'Test drive currently selected vehicle',
                            icon = "car-on",
                            event = 'qb-vehicleshop:client:TestDrive',
                        },
                        {
                            title = "Buy Vehicle",
                            description = 'Purchase currently selected vehicle',
                            icon = "hand-holding-dollar",
                            event = 'qb-vehicleshop:client:showConfirmButton',
                            args = {
                                buyVehicle = Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle
                            }
                        },
                        -- {
                        --     header = 'Finance Vehicle',
                        --     txt = 'Finance currently selected vehicle',
                        --     icon = "fa-solid fa-coins",
                        --     params = {
                        --         event = 'qb-vehicleshop:client:openFinance',
                        --         args = {
                        --             price = getVehPrice(),
                        --             buyVehicle = Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle
                        --         }
                        --     }
                        -- },
                        {
                            icon = "arrow-rotate-left",
                            title = 'Swap Vehicle',
                            description = 'Change currently selected vehicle',
                            event = 'qb-vehicleshop:client:vehCategories',
                        },
                    }
                    Wait(1000)
                end
            end)
        else
            insideZones[name] = false -- leave the shops zone
            ClosestVehicle = 1
        end
    end)
end

function createManagedShop(shopShape, name)
    local zone = PolyZone:Create(shopShape, {  -- create the zone
        name= name,
        minZ = shopShape.minZ,
        maxZ = shopShape.maxZ
    })

    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            FixShowroomCars()
            insideZones[name] = true
            CreateThread(function()
                while insideZones[name] do
                    setClosestShowroomVehicle()
                    local closestShop = getShopInsideOf()
                    vehicleMenu = {
                        {
                            disabled = true,
                            icon = "circle-info",
                            title = getVehBrand():upper()..' '..getVehName():upper()..' - $'..getVehPriceManaged(),
                        },
                        {
                            title = 'Test Drive',
                            description = 'Allow player for test drive',
                            icon = "user-plus",
                            event = 'qb-vehicleshop:client:openIdMenu',
                            args = {
                                vehicle = Config.Shops[closestShop]["ShowroomVehicles"][ClosestVehicle].chosenVehicle,
                                type = 'testDrive'
                            }
                        },
                        {
                            title = "Sell Vehicle",
                            description = 'Sell vehicle to Player',
                            icon = "cash-register",
                            event = 'qb-vehicleshop:client:openIdMenu',
                            args = {
                                vehicle = Config.Shops[closestShop]["ShowroomVehicles"][ClosestVehicle].chosenVehicle,
                                type = 'sellVehicle'
                            }
                        },
                        -- {
                        --     header = 'Finance Vehicle',
                        --     txt = 'Finance vehicle to Player',
                        --     icon = "fa-solid fa-coins",
                        --     params = {
                        --         event = 'qb-vehicleshop:client:openCustomFinance',
                        --         args = {
                        --             price = getVehPrice(),
                        --             vehicle = Config.Shops[closestShop]["ShowroomVehicles"][ClosestVehicle].chosenVehicle
                        --         }
                        --     }
                        -- },
                        {
                            title = 'Swap Vehicle',
                            icon = "arrow-rotate-left",
                            description = 'Change currently selected vehicle',
                            event = 'qb-vehicleshop:client:vehCategories',
                        },
                    }
                    Wait(1000)
                end
            end)
        else
            insideZones[name] = false -- leave the shops zone
            ClosestVehicle = 1
        end
    end)
end

for name, shop in pairs(Config.Shops) do
    if shop['Type'] == 'free-use' then
        createFreeUseShop(shop['Zone']['Shape'], name)
    elseif shop['Type'] == 'managed' then
        createManagedShop(shop['Zone']['Shape'], name)
    end
end

-- Events

RegisterNetEvent('qb-vehicleshop:client:homeMenu', function()
    lib.registerContext({
        id = 'vehicleshopHomeMenu',
        title = 'Vehicle menu',
        onExit = function() end,
        options = vehicleMenu
    })
    lib.showContext('vehicleshopHomeMenu')
end)

RegisterNetEvent('qb-vehicleshop:client:showVehOptions', function()
    lib.registerContext({
        id = 'vehicleshopHomeMenu',
        title = 'Vehicle menu',
        onExit = function() end,
        options = vehicleMenu
    })
    lib.showContext('vehicleshopHomeMenu')
end)

RegisterNetEvent('qb-vehicleshop:client:TestDrive', function()
    if not inTestDrive and ClosestVehicle ~= 0 then
        if getShopInsideOf() == 'boats' or getShopInsideOf() == 'air' then QBCore.Functions.Notify('You cannot test drive this vehicle!', 'error') return end
        inTestDrive = true
        local prevCoords = GetEntityCoords(PlayerPedId())
        SetEntityCoords(Config.TestDriveArena)
        QBCore.Functions.SpawnVehicle(Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle, function(veh)
            local closestShop = getShopInsideOf()
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            exports['ps-fuel']:SetFuel(veh, 100)
            SetVehicleNumberPlateText(veh, 'TESTDRIVE')
            SetVehicleDirtLevel(veh, 0)
            SetEntityAsMissionEntity(veh, true, true)
            SetEntityHeading(veh, Config.TestDriveArena.w)
            TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
            TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
            testDriveVeh = veh
            QBCore.Functions.Notify('You have '..Config.Shops[closestShop]["TestDriveTimeLimit"]..' minutes remaining')
            SetTimeout(Config.Shops[closestShop]["TestDriveTimeLimit"] * 60000, function()
                if testDriveVeh ~= 0 then
                    testDriveVeh = 0
                    inTestDrive = false
                    QBCore.Functions.DeleteVehicle(veh)
                    SetEntityCoords(PlayerPedId(), prevCoords)
                    QBCore.Functions.Notify('Vehicle test drive complete')
                end
            end)
        end, Config.TestDriveArena, true)
        createTestDriveReturn()
        startTestDriveTimer(Config.Shops[getShopInsideOf()]["TestDriveTimeLimit"] * 60)
    else
        QBCore.Functions.Notify('Already in test drive', 'error')
    end
end)

RegisterNetEvent('qb-vehicleshop:client:customTestDrive', function(data)
    if not inTestDrive then
        inTestDrive = true
        shopInsideOf = getShopInsideOf()
        local vehicle = data
        local prevCoords = GetEntityCoords(PlayerPedId())
        QBCore.Functions.SpawnVehicle(vehicle, function(veh)
            local shopInsideOf = getShopInsideOf()
            exports['ps-fuel']:SetFuel(veh, 100)
            SetVehicleNumberPlateText(veh, 'TESTDRIVE')
            SetVehicleDirtLevel(veh, 0)
            SetEntityAsMissionEntity(veh, true, true)
            SetEntityHeading(veh, Config.Shops[shopInsideOf]["TestDriveSpawn"].w)
            TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(veh))
            TriggerServerEvent('qb-vehicletuning:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(veh))
            testDriveVeh = veh
            -- QBCore.Functions.Notify('You have '..Config.Shops[shopInsideOf]["TestDriveTimeLimit"]..' minutes remaining')
            -- SetTimeout(Config.Shops[shopInsideOf]["TestDriveTimeLimit"] * 60000, function()
            --     if testDriveVeh ~= 0 then
            --         testDriveVeh = 0
            --         inTestDrive = false
            --         QBCore.Functions.DeleteVehicle(veh)
            --         SetEntityCoords(PlayerPedId(), prevCoords)
            --         QBCore.Functions.Notify('Vehicle test drive complete')
            --     end
            -- end)
        end, Config.Shops[shopInsideOf]["TestDriveSpawn"], true)
        createTestDriveReturn()
        -- startTestDriveTimer(Config.Shops[shopInsideOf]["TestDriveTimeLimit"] * 60)
    else
        QBCore.Functions.Notify('Already in test drive', 'error')
    end
end)

RegisterNetEvent('qb-vehicleshop:client:TestDriveReturn', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped)
    if veh == testDriveVeh then
        testDriveVeh = 0
        inTestDrive = false
        QBCore.Functions.DeleteVehicle(veh)
        testDriveZone:destroy()
        QBCore.Functions.Notify('Vehicle test drive complete')
    else
        QBCore.Functions.Notify('This is not your test drive vehicle', 'error')
    end
end)

RegisterNetEvent('qb-vehicleshop:client:showConfirmButton', function(data)

    local alert = lib.alertDialog({
        header = 'Confirm Purchase',
        content = getVehBrand():upper()..' '..getVehName():upper()..' - $'..getVehPrice(),
        centered = true,
        cancel = true
    })
    
    if alert == "confirm" then
       TriggerServerEvent('qb-vehicleshop:server:buyShowroomVehicle',{
            buyVehicle = Config.Shops[getShopInsideOf()]["ShowroomVehicles"][ClosestVehicle].chosenVehicle
       }) 
    end
end)

RegisterNetEvent('qb-vehicleshop:client:vehCategories', function()
    local categoryMenu = {}
    categoryMenu[#categoryMenu + 1] = {
        title = 'Go Back',
        event = 'qb-vehicleshop:client:homeMenu',
    }

    local shop = getShopInsideOf()
    if Config.Shops[shop]['Type'] == 'managed' then
        for k,v in pairs(Config.Shops[shop]['Categories']) do
            categoryMenu[#categoryMenu + 1] = {
                title = v,
                event = 'qb-vehicleshop:client:openVehCatsManaged',
                args = {
                    catName = k
                }
                
            }
        end
    else
        for k,v in pairs(Config.Shops[shop]['Categories']) do
            categoryMenu[#categoryMenu + 1] = {
                title = v,
                event = 'qb-vehicleshop:client:openVehCats',
                args = {
                    catName = k
                }
                
            }
        end
    end
    lib.registerContext({
        id = 'categoryMenu',
        title = 'Categories',
        options = categoryMenu
    })
    lib.showContext('categoryMenu')
end)

RegisterNetEvent('qb-vehicleshop:client:openVehCats', function(data)
    local vehicleMenu = {}
    vehicleMenu[#vehicleMenu + 1] = {
        title = 'Go Back',
        event = 'qb-vehicleshop:client:vehCategories',
    }

    for k,v in pairs(QBCore.Shared.Vehicles) do
        if QBCore.Shared.Vehicles[k]["category"] == data.catName then
            vehicleMenu[#vehicleMenu + 1] = {
                title = v.name,
                description = 'Price: $'..v.price,
                serverEvent = 'qb-vehicleshop:server:swapVehicle',
                args = {
                    toVehicle = v.model,
                    ClosestVehicle = ClosestVehicle,
                    ClosestShop = getShopInsideOf(),
                    category = data.catName
                }
                
            }
        end
    end
    lib.registerContext({
        id = 'vehicleMenu',
        title = 'Vehicle Menu',
        options = vehicleMenu
    })
    lib.showContext('vehicleMenu')
end)

RegisterNetEvent('qb-vehicleshop:client:openVehCatsManaged', function(data)
    local vehicleMenu = {}

    for k,v in pairs(QBCore.Shared.Vehicles) do
        if QBCore.Shared.Vehicles[k]["category"] == data.catName then
            local ManagedPrice = v.price - (v.price * 0.10)

            vehicleMenu[#vehicleMenu + 1] = {
                title = v.name,
                description = 'Price: $'..ManagedPrice,
                serverEvent = 'qb-vehicleshop:server:swapVehicle',
                args = {
                    toVehicle = v.model,
                    ClosestVehicle = ClosestVehicle,
                    ClosestShop = getShopInsideOf(),
                    category = data.catName
                }
            }
        end
    end

    lib.registerContext({
        id = 'vehicleMenu',
        title = 'Vehicle menu',
        onExit = function() end,
        options = vehicleMenu
    })
    lib.showContext('vehicleMenu')
end)

RegisterNetEvent('qb-vehicleshop:client:openFinance', function(data)
    local dialog = lib.inputDialog(getVehBrand():upper()..' '..data.buyVehicle:upper()..' - $'..data.price,{
        { type = "number", label = 'Down Payment Amount - Min '..Config.MinimumDown..'%', placeholder = "0" },
        { type = "number", label = "Total Payments - Max "..Config.MaximumPayments, placeholder = "0" },
    })
    if not dialog then return end
    TriggerServerEvent('qb-vehicleshop:server:financeVehicle', dialog[2], dialog[1], data.buyVehicle)

end)

RegisterNetEvent('qb-vehicleshop:client:openCustomFinance', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"tablet2"})
    local dialog = lib.inputDialog(getVehBrand():upper()..' '..data.vehicle:upper()..' - $'..data.price,{
        { type = "number", label = "Down Payment Amount - Min 10%", placeholder = "0" },
        { type = "number", label = "Total Payments - Max "..Config.MaximumPayments, placeholder = "0" },
        { type = "number", label = "Server ID (#)", placeholder = "0" },
    })
    if not dialog then return end
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    TriggerServerEvent('qb-vehicleshop:server:sellfinanceVehicle', dialog[1], dialog[2], data.vehicle, dialog[3])
    
end)

RegisterNetEvent('qb-vehicleshop:client:swapVehicle', function(data)
    local shopName = data.ClosestShop
    if Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].chosenVehicle ~= data.toVehicle then
        local closestVehicle, closestDistance = QBCore.Functions.GetClosestVehicle(vector3(Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.x, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.y, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.z))
        if closestVehicle == 0 then return end
        if closestDistance < 5 then 
            DeleteVehicle(closestVehicle)
            showRoomVehicles[closestVehicle] = nil
        end
        while DoesEntityExist(closestVehicle) do
            Wait(50)
        end
        Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].chosenVehicle = data.toVehicle
        local model = joaat(data.toVehicle)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(50)
        end
        local veh = CreateVehicle(model, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.x, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.y, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.z - 1.0, false, false)
        while not DoesEntityExist(veh) do
            Wait(50)
        end
        table.insert(showRoomVehicles, veh)
        SetModelAsNoLongerNeeded(model)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh,true)
        SetVehicleEngineOn(veh, false, true, true)
        SetEntityHeading(veh, Config.Shops[shopName]["ShowroomVehicles"][data.ClosestVehicle].coords.w)
        SetVehicleDoorsLocked(veh, 3)
        FreezeEntityPosition(veh, true)
        SetVehicleNumberPlateText(veh, 'BUY ME')
        SetVehicleDirtLevel(veh, 0)
        QBCore.Functions.SetStateBag(veh, 'isDisabled', true)
        if Config.UsingTarget then createVehZones(shopName, veh) end
    end
end)

RegisterNetEvent('qb-vehicleshop:client:buyShowroomVehicle', function(vehicle, plate)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        exports['ps-fuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, plate)
        SetVehicleDirtLevel(veh, 0)
        SetEntityHeading(veh, Config.Shops[getShopInsideOf()]["VehicleSpawn"].w)
        SetEntityAsMissionEntity(veh, true, true)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        TriggerServerEvent("qb-vehicletuning:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))
    end, Config.Shops[getShopInsideOf()]["VehicleSpawn"], true)
end)

RegisterNetEvent('qb-vehicleshop:client:getVehicles', function()
    QBCore.Functions.TriggerCallback('qb-vehicleshop:server:getVehicles', function(vehicles)
        local ownedVehicles = {}
        for k,v in pairs(vehicles) do
            if v.balance ~= 0 then
                local name = QBCore.Shared.Vehicles[v.vehicle]["name"]
                local plate = v.plate:upper()
                ownedVehicles[#ownedVehicles + 1] = {
                    title = name,
                    description = 'Plate: '..plate,
                    event = 'qb-vehicleshop:client:getVehicleFinance',
                    args = {
                        vehiclePlate = plate,
                        balance = v.balance,
                        paymentsLeft = v.paymentsleft,
                        paymentAmount = v.paymentamount
                    }
                }
            end
        end
        lib.registerContext({
            id = 'ownedVehicles',
            title = 'Owned vehicles',
            onExit = function() end,
            options = ownedVehicles
        })
        lib.showContext('ownedVehicles')
    end)
end)

RegisterNetEvent('qb-vehicleshop:client:getVehicleFinance', function(data)
    lib.registerContext({
        id = 'vehFinance',
        title = 'Vehicle Finance',
        onExit = function() end,
        options = {
            {
                title = '< Go Back',
                event = 'qb-vehicleshop:client:getVehicles',
            },{
                title = 'Total Balance Remaining',
                description = '$'..comma_value(data.balance),
            },{
                title = 'Total Payments Remaining',
                description = data.paymentsLeft,
            },{
                title = 'Recurring Payment Amount',
                description = '$'..comma_value(data.paymentAmount),
            },{
                title = 'Make a payment',
                description = 'Toggle the rear ramp',
                event = 'qb-vehicleshop:client:financePayment',
                args = {
                    vehData = data,
                    paymentsLeft = data.paymentsleft,
                    paymentAmount = data.paymentamount
                },
            },
        }
    })

    lib.showContext('vehFinance')
end)

RegisterNetEvent('qb-vehicleshop:client:financePayment', function(data)
    local dialog = lib.inputDialog('Vehicle Payment', {
        { type = "number", label = "Payment Amount ($)"},
    })
    if not dialog or dialog[1] == nil then return end
    TriggerServerEvent('qb-vehicleshop:server:financePayment', dialog[1], data.vehData)
end)

RegisterNetEvent('qb-vehicleshop:client:openIdMenu', function(data)
    QBCore.Functions.TriggerCallback('qb-vehicleshop:server:getNearbyPlayers', function(players)
        local options = {}
        for k,v in pairs(players) do
            table.insert(options, {value = v.id, label = v.name})
        end
        local FormattedText = nil
        if data.type == 'testDrive' then
            FormattedText = "Select Person for a test drive (Nearby Players)"
        else
            FormattedText = "Select Person to Sell Vehicle (Nearby Players)"
        end
        local dialog = lib.inputDialog(QBCore.Shared.Vehicles[data.vehicle]["name"], {
            { type = 'select', label = 'Player ID', options = options}
        })
        if not dialog or dialog[1] == nil then return end

        if data.type == 'testDrive' then
            TriggerServerEvent('qb-vehicleshop:server:customTestDrive', data.vehicle, dialog[1])
        elseif data.type == 'sellVehicle' then
            TriggerServerEvent('qb-vehicleshop:server:sellShowroomVehicle', data.vehicle, dialog[1], Config.Shops[getShopInsideOf()]['Job'])
        end
        
    end, 5.0)
end)

RegisterNetEvent('qb-vehicleshop:client:soldVehicle', function(amount)
    ReqAndDelete(GetVehiclePedIsIn(PlayerPedId()))
end)

-- Threads

CreateThread(function()
    -- Sell zones
    for k,v in pairs(Config.SellZones) do
        local sellblip = AddBlipForCoord(v.coords.xyz)
        SetBlipSprite(sellblip, v.blip.sprite)
        SetBlipDisplay(sellblip, 4)
        SetBlipScale(sellblip, 0.6)
        SetBlipAsShortRange(sellblip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(k)
        EndTextCommandSetBlipName(sellblip)

        exports['polyzonehelper']:AddBoxZone(v.zoneName, v.coords.xyz, 5.0, 5.0, {
            name = v.zoneName,
            heading = v.coords.w,
            debugPoly = Config.DebugSellZones,
            minZ = v.coords.z - 1.0,
            maxZ = v.coords.z + 2.0
        })
    end
end)

CreateThread(function()
    for k, v in pairs(Config.Shops) do
        if v.showBlip then
            local Dealer = AddBlipForCoord(Config.Shops[k]["Location"])
            SetBlipSprite (Dealer, Config.Shops[k]["blipSprite"])
            SetBlipDisplay(Dealer, 4)
            SetBlipScale  (Dealer, 0.6)
            SetBlipAsShortRange(Dealer, true)
            SetBlipColour(Dealer, Config.Shops[k]["blipColor"])
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Config.Shops[k]["ShopLabel"])
            EndTextCommandSetBlipName(Dealer)
        end
    end
end)

CreateThread(function()
    local financeZone = BoxZone:Create(Config.FinanceZone, 2.0, 2.0, {
        name = "vehicleshop_financeZone",
        offset = {0.0, 0.0, 0.0},
        scale = {1.0, 1.0, 1.0},
        debugPoly = false,
    })

    financeZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            lib.registerContext({
                id = 'financeMenu',
                title = 'Financed Vehicles',
                onExit = function() end,
                options = {
                    {
                        title = 'Browse your owned vehicles',
                        event = 'qb-vehicleshop:client:getVehicles'
                    }
                }
                
            })
            lib.showContext('financeMenu')
        else
            lib.hideContext(false)
        end
    end)
end)

CreateThread(function()
    for k,v in pairs(Config.Shops) do
        for i,v2 in pairs(Config.Shops[k]['ShowroomVehicles']) do
            local model = joaat(Config.Shops[k]["ShowroomVehicles"][i].defaultVehicle)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            local veh = CreateVehicle(model, Config.Shops[k]["ShowroomVehicles"][i].coords.x, Config.Shops[k]["ShowroomVehicles"][i].coords.y, Config.Shops[k]["ShowroomVehicles"][i].coords.z - 1.0, false, false)
            table.insert(showRoomVehicles, veh)
            FreezeEntityPosition(veh,true)
            SetModelAsNoLongerNeeded(model)
            SetEntityAsMissionEntity(veh, true, true)
            SetVehicleEngineOn(veh, false, true, true)
            SetEntityInvincible(veh,true)
            SetVehicleDirtLevel(veh, 0.0)
            SetVehicleDoorsLocked(veh, 3)
            SetEntityHeading(veh, Config.Shops[k]["ShowroomVehicles"][i].coords.w)
            SetVehicleOnGroundProperly(veh)
            SetVehicleNumberPlateText(veh, 'BUY ME')
            SetVehicleDirtLevel(veh, 0)
            QBCore.Functions.SetStateBag(veh, 'isDisabled', true)
            createVehZones(k, veh)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for k,v in pairs(showRoomVehicles) do
        DeleteVehicle(v)
    end
    showRoomVehicles = {}
end)