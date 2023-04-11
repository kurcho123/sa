QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}
local PrevJob = {}
local CurrentJob = 'unemployed'
local inVehicle = false
local inForklift = false
local inDropZone = false
local PalletData = {}
local PalletAttached = false
-- Job Stuff --
local currentDepot

function GetClosestDeposit()
    local coords = GetEntityCoords(PlayerPedId())
    local dist, closest = 1000.0, false
    for k,v in pairs(Config.GoPostal.DepositLocations) do
        local tempDist = #(coords - vec3(v.x, v.y, v.z))
        if tempDist < dist then
            dist = tempDist
            closest = k
        end
    end
    for k,v in pairs(Config.GoPostal.BusinessDeposits) do
        local tempDist = #(coords - vec3(v.x, v.y, v.z))
        if tempDist < dist then
            dist = tempDist
            closest = k
        end
    end
    return closest
end

function GetClosestPickup()
    local coords = GetEntityCoords(PlayerPedId())
    local dist, closest = 1000.0, false
    for k,v in pairs(Config.GoPostal.Pickups) do
        local tempDist = #(coords - v.coords)
        if tempDist < dist then
            dist = tempDist
            closest = k
        end
    end
    return closest
end

function round(value, numDecimalPlaces)
    if value == nil then
        value = 0
    end
    if numDecimalPlaces == nil then
        numDecimalPlaces = 0
    end
    if numDecimalPlaces then
        local power = 10 ^ numDecimalPlaces
        return math.floor((value * power) + 0.5) / (power)
    else
        return math.floor(value + 0.5)
    end
end


function SetupWarehouseDropoff()
    local currentWarehouse
    local area = 1
    for k,data in pairs(Config.GoPostal.DropOff) do
        exports['qb-target']:AddBoxZone(k .. ".WarehouseDropoff", data.location, data.length, data.width, {
            name = k .. ".WarehouseDropoff",
            heading = data.heading,
            debugPoly = false,
            minZ = data.minZ,
            maxZ = data.maxZ
            }, {
            options = {
                {
                    id = 1,
                    type = "client",
                    event = 'target:client:openStash',
                    args = {'warehousetransfer', 'warehousetransfer'},
                    icon = "fas fa-box-open",
                    label = "Open Warehouse Intake",
                },
                {
                    id = 2,
                    type = "client",
                    event = 'prdx_gopostal:client:sellStashMenu',
                    icon = "far fa-money-bill-alt",
                    label = "Transfer Items",
                },
            },
            distance = 3.0
        })
    end
end

function SetupJob()
    exports['qb-target']:RemoveZone()
    if PlayerJob.name == 'gopostal' then -- Double check I guess
        SetupWarehouseDropoff()
    end
end

function SpawnPallet(product, coords, orderid, index)
    if not coords then
        coords = GetEntityCoords(PlayerPedId())
    end
    if not coords.w then
        local heading = GetEntityHeading(PlayerPedId())
        coords = vec4(coords.x, coords.y, coords.z, heading)
    end
    local _, ground = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, 0)
    local ProductData = Config.GoPostal.Containers[product]
    if not ProductData then
        ProductData = 'generic'
    end
    local ProductData = Config.GoPostal.Containers[product]
    local randomObj = math.random(1, #ProductData)
    local ChosenProduct = ProductData[randomObj]
    QBCore.Functions.LoadModel(ChosenProduct.model)
    local palletEntity = CreateObject(Config.GoPostal.PalletModel, coords.x, coords.y, ground, true, true)
    local productEntity = CreateObject(ChosenProduct.model, coords.x, coords.y, ground, true, true)
    SetEntityHeading(palletEntity, coords.w + 90.0)
    SetEntityHeading(productEntity, coords.w + 90.0)
    SetEntityCanBeDamaged(palletEntity, false)
    SetEntityCanBeDamaged(productEntity, false)
    SetEntityAsMissionEntity(palletEntity, true, true)
    SetEntityAsMissionEntity(productEntity, true, true)
    SetDisableFragDamage(palletEntity, true)
    SetDisableFragDamage(productEntity, true)
    Wait(250)
    local PalletNet = ObjToNet(palletEntity)
    local TempPalletData = {
        containerData = ChosenProduct,
        id = PalletNet,
        orderid = orderid,
        productNetID = ObjToNet(productEntity),
        productModel = ChosenProduct.model
    }
    AttachProductToPallet(palletEntity, productEntity, ChosenProduct.offset, ChosenProduct.rotation)
    TriggerServerEvent('prdx_gopostal:server:palletSpawned', orderid, TempPalletData, index, PalletNet)
end

function AttachProductToPallet(palletEntity, productEntity, offset, rotation)
    SetEntityNoCollisionEntity(palletEntity, productEntity, false)
    AttachEntityToEntity(productEntity, palletEntity, 0, 0.0 + (offset.x or 0), 0.0 + (offset.y or 0), 0.00 + (offset.z or 0), (rotation.x or 0.0), (rotation.y or 0.0), (rotation.z or 0.0), false, false, false, false, 0, true)
end

function ActivatePallet(pallet, vehicle)
    if vehicle then
        local rotPallet = GetEntityRotation(pallet, 2)
        local rotForklift = GetEntityRotation(vehicle, 2)
        local rotation = vec3(rotPallet.x - rotForklift.x, rotPallet.y - rotForklift.y, rotPallet.z - rotForklift.z)
        local boneIDX = GetEntityBoneIndexByName(vehicle, 'forks')
        local offset = GetOffsetFromEntityGivenWorldCoords(vehicle, GetEntityCoords(pallet))
        AttachEntityToEntity(pallet, vehicle, boneIDX, offset.x, offset.y, offset.z, rotation.x, rotation.y, rotation.z, false, false, false, false, 2, true)
        ProcessEntityAttachments(pallet)
        ProcessEntityAttachments(vehicle)
        PalletAttached = pallet
        QBCore.Functions.Notify('Secured pallet to vehicle', 'success')
    end
end

function DepositPallet(PalletNetID)
    if not PalletData then return end
    QBCore.Functions.DeleteEntity(PalletData.productNetID)
    Wait(250)
    QBCore.Functions.DeleteEntity(PalletNetID)
    TriggerServerEvent('prdx_gopostal:server:DepositPallet', PalletData.orderid, PalletData.id, GetClosestDeposit())
end

function ForkliftThread(vehicle)
    local boneIDX = GetEntityBoneIndexByName(vehicle, 'forks')
    local ShowUI = false
    local WasAttached = false
    local currentPallet = false
    exports['qb-core']:HideText()
    PalletAttached = false
    PalletData = {}
    while inVehicle do
        local sleep = 1000
        local forkCoords = GetWorldPositionOfEntityBone(vehicle, boneIDX)
        local pallet = GetClosestObjectOfType(forkCoords.x, forkCoords.y, forkCoords.z, 1.1, Config.GoPostal.PalletModel, true, false, false)
        if pallet and pallet > 0 then
            local PalletNetID = ObjToNet(pallet)
            if pallet ~= currentPallet then
                print('New pallet detected:', pallet)
                PalletData = Entity(pallet).state.PalletData
            end
            currentPallet = pallet
            if PalletData then
                sleep = 250
                local ProductObj = NetToObj(PalletData.productNetID)
                local attachedVehicle = IsEntityAttachedToAnyVehicle(pallet)
                if attachedVehicle then
                    attachedVehicle = GetEntityAttachedTo(pallet)
                    if attachedVehicle == 0 then return end
                    if not ShowUI then
                        ShowUI = true
                        exports['qb-core']:DrawText('[E] - Unsecure Pallet')
                    end
                    sleep = 10

                    if IsControlJustPressed(0, 38) then
                        exports['qb-core']:HideText()
                        ShowUI = false
                        TriggerServerEvent('prdx_gopostal:server:detachPallet', PalletNetID, VehToNet(attachedVehicle))
                        sleep = 10
                    end                    
                elseif inDropZone then
                    if not ShowUI then
                        ShowUI = true
                        exports['qb-core']:DrawText('[E] - Deposit Pallet')
                    end
                    sleep = 10
                    if IsControlJustPressed(0, 38) then
                        exports['qb-core']:HideText()
                        ShowUI = false
                        DepositPallet(PalletNetID)
                        sleep = 2500
                    end
                else
                    local target = GetOffsetFromEntityInWorldCoords(pallet, vector3(0, 0, -0.3))
                    local testRay = StartShapeTestRay(GetEntityCoords(pallet), target, 2, vehicle, 7)
                    local retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(testRay)   
                    if entityHit > 0 then
                        if not ShowUI then
                            ShowUI = true
                            exports['qb-core']:DrawText('[E] - Secure Pallet')
                        end
                        sleep = 10
    
                        if IsControlJustPressed(0, 38) then
                            exports['qb-core']:HideText()
                            ShowUI = false
                            TriggerServerEvent('prdx_gopostal:server:attachPallet', PalletNetID, VehToNet(entityHit))
                            sleep = 250
                        end
                    elseif ShowUI then
                        exports['qb-core']:HideText()
                        ShowUI = false
                    end         
                end
                if GetEntityAttachedTo(ProductObj) == 0 then
                    TriggerServerEvent('prdx_gopostal:server:resetPallet', PalletNetID, PalletData.productNetID)
                    sleep = 500
                end        
            elseif ShowUI then
                exports['qb-core']:HideText()
                ShowUI = false
            end
        else
            if ShowUI then
                exports['qb-core']:HideText()
                ShowUI = false
            end
        end        
        Wait(sleep)
    end
    if ShowUI then
        exports['qb-core']:HideText()
        ShowUI = false
    end   
end

function SetupPalletDeposit()
    for business,coords in pairs(Config.GoPostal.DepositLocations) do
        exports['polyzonehelper']:AddBoxZone("PalletDeposit", vector3(coords.x, coords.y, coords.z), 5.0, 8.0, {
            name = "PalletDeposit",
            heading = coords.w,
            minZ = coords.z - 2.0,
            maxZ = coords.z + 1.0,
            debugPoly = false,
        }) 
    end
    for warehouse,coords in pairs(Config.GoPostal.BusinessDeposits) do
        exports['polyzonehelper']:AddBoxZone("PalletDeposit", vector3(coords.x, coords.y, coords.z), 8.0, 5.0, {
            name = "PalletDeposit",
            heading = coords.w,
            minZ = coords.z - 2.0,
            maxZ = coords.z + 1.0,
            debugPoly = false,
        }) 
    end
end

AddEventHandler('polyzonehelper:enter', function(name)
    if name == "PalletDeposit" then
        inDropZone = true
    end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if name == "PalletDeposit" then
        inDropZone = false
    end
end)

AddEventHandler('prdx_gopostal:client:sellStashMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Transfer", 
            serverEvent = "inventory:server:sellStash",
            args = {'warehousetransfer', true}
        }
    }
    lib.registerContext({
        id = 'transfer_intake_menu',
        title = 'Transfer Intake',
        options = menu,
    })
    lib.showContext('transfer_intake_menu')
end)

AddEventHandler('prdx_gopostal:client:OpenWarehouse', function(data)
    exports.ox_inventory:openInventory('shop', { type = 'GoPostalWarehouse' })
end)

AddEventHandler('prdx_gopostal:client:openPalletMenu', function(data)
    local OrderData, PickupLocation = data[1], data[2]
    local menu = {}
    for k,palletData in ipairs(OrderData.pallets) do
        if type(palletData) == 'table' and palletData.id and palletData.id > 0 and DoesEntityExist(NetToObj(palletData.id)) then
            local PalletEntity = NetToObj(palletData.id)
            local PalletCoords = GetEntityCoords(PalletEntity)
            local PlayerCoords = GetEntityCoords(PlayerPedId())
            menu[#menu+1] = {
                title = 'Pallet #'..k..' | ID: '..palletData.id, 
                description = 'Pallet Distance: '..(round(#(PalletCoords - PlayerCoords), 0))..' ft. | Press to respawn',
                serverEvent = "prdx_gopostal:server:spawnPallet",
                args = {true, OrderData.orderid, PickupLocation, k}
            }     
        else
            menu[#menu+1] = {
                title = 'Order Pallet #'..k, 
                description = 'Press to spawn pallet',
                serverEvent = "prdx_gopostal:server:spawnPallet",
                args = {false, OrderData.orderid, PickupLocation, k}
            }   
        end
    end
    lib.registerContext({
        id = 'pallet_menu',
        title = 'Request Pallet',
        options = menu,
    })
    lib.showContext('pallet_menu')
end)

AddEventHandler('prdx_gopostal:client:spawnPalletMenu', function(data)
    local menu = {}
    QBCore.Functions.TriggerCallback('prdx_gopostal:server:getDeliveries', function(Deliveries)
        for k,v in pairs(Deliveries) do
            if v.active and v.active == GetPlayerServerId(PlayerId()) then
                menu[#menu+1] = {
                    title = 'Order: '..v.orderid, 
                    description = Config.GoPostal.MaxPallets..' ',
                    event = "prdx_gopostal:client:openPalletMenu",
                    args = {v, data.pickuplocation}
                }
            end
        end
        lib.registerContext({
            id = 'deliveries_menu',
            title = 'My Deliveries',
            options = menu,
        })
        lib.showContext('deliveries_menu')
    end, false) 
end)


AddEventHandler('prdx_gopostal:client:startDeliveryMenu', function(delivery)
    local text = ""
    for k,v in pairs(delivery.items) do
        text = text .. '  \n'.. exports.ox_inventory:Items()[k]['label']..' - '..v..'x'
    end
    local menu = {
        {
            title = 'Start Delivery',
            description = text, 
            disabled = true
        },
        {
            title = "Confirm",
            serverEvent = "prdx_gopostal:server:startDelivery",
            args = delivery.orderid
        }     
    }
    lib.registerContext({
        id = 'start_delivery_menu',
        title = 'Confirm you want to start this delivery?',
        menu = 'get_deliveries_menu',
        options = menu,
    })
    lib.showContext('start_delivery_menu')
end)

AddEventHandler('prdx_gopostal:client:quitDeliveryMenu', function(delivery)
    local text = ""
    for k,v in pairs(delivery.items) do
        text = text .. '  \n'.. exports.ox_inventory:Items()[k]['label']..' - '..v..'x'
    end
    local menu = {
        {
            title = 'Stop Delivery',
            description = text, 
            disabled = true
        },
        {
            title = "Confirm",
            serverEvent = "prdx_gopostal:server:stopDelivery",
            args = delivery.orderid            
        }     
    }
    lib.registerContext({
        id = 'quit_delivery_menu',
        title = 'Confirm you want to stop your delivery?',
        menu = 'get_deliveries_menu',
        options = menu,
    })
    lib.showContext('quit_delivery_menu')
end)

AddEventHandler('prdx_gopostal:client:cancelDeliveryMenu', function(delivery)
    local text = ""
    for k,v in pairs(delivery.items) do
        text = text .. '  \n'.. exports.ox_inventory:Items()[k]['label']..' - '..v..'x'
    end
    local menu = {
        {
            title = 'Cancel Delivery',
            description = text,
            disabled = true
        },
        {
            title = "Confirm",
            serverEvent = "prdx_gopostal:server:cancelDelivery",
            args = delivery.orderid           
        }      
    }
    lib.registerContext({
        id = 'quit_delivery_menu',
        title = 'Confirm you want to cancel this delivery?',
        options = menu,
    })
    lib.showContext('quit_delivery_menu')
end)

AddEventHandler('prdx_gopostal:client:getDeliveriesMenu', function(data)
    local coords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.TriggerCallback('prdx_gopostal:server:getDeliveries', function(Deliveries)
        local menu = {}
        for k,v in pairs(Deliveries) do
            if not v.complete and v.location then
                local dist = #(coords - vec3(v.location.x, v.location.y, v.location.z))
                local headerTxt
                if v.business and v.business ~= 'gopostal' then
                    headerTxt = 'Business delivery to: '..QBCore.Shared.Jobs[v.business].label
                else
                    headerTxt = 'Warehouse Delivery'
                end
                if v.active and v.active ~= GetPlayerServerId(PlayerId()) then
                    menu[#menu+1] = {
                        title = headerTxt, 
                        description = round(((dist / 1609)), 2) ..' Miles | Already Active',
                        disabled = true
                    }
                elseif v.active and v.active == GetPlayerServerId(PlayerId()) then
                    menu[#menu+1] = {
                        title = 'Your current delivery | '..headerTxt, 
                        description = round(((dist / 1609)), 2) ..' Miles | Already Active',
                        event = "prdx_gopostal:client:quitDeliveryMenu",
                        args = v
                    }
                else
                    menu[#menu+1] = {
                        title = headerTxt, 
                        description = round(((dist / 1609)), 2) ..' Miles',
                        event = "prdx_gopostal:client:startDeliveryMenu",
                        args = v
                    }
                end
            end
        end
        lib.registerContext({
            id = 'get_deliveries_menu',
            title = 'GoPostal Deliveries',
            options = menu,
        })
        lib.showContext('get_deliveries_menu')      
    end) 
end)

RegisterNetEvent('prdx_gopostal:client:supplyOrdersMenu', function(isBusiness)
    QBCore.Functions.TriggerCallback('prdx_gopostal:server:getMyDeliveries', function(Deliveries)
        local menu = {}
        for k,v in pairs(Deliveries) do
            local headerTxt
            if v.business and v.business ~= 'gopostal' then
                headerTxt = 'Business Order: '..QBCore.Shared.Jobs[v.business].label
            else
                headerTxt = 'Warehouse Delivery'
            end
            if v.complete then
                menu[#menu+1] = {
                    title = headerTxt, 
                    description = 'Order: '..v.orderid..' | Order Completed',
                    disabled = true
                }
            elseif v.active then
                menu[#menu+1] = {
                    title = headerTxt, 
                    description = 'Order: '..v.orderid..' | Cannot Cancel Already Active',
                    disabled = true
                }
            else
                menu[#menu+1] = {
                    title = headerTxt, 
                    description = 'Order: '..v.orderid..' | Pending',
                    event = "prdx_gopostal:client:cancelDeliveryMenu",
                    args = v
                }
            end
        end
        lib.registerContext({
            id = 'supply_orders_menu',
            title = 'GoPostal Deliveries',
            options = menu,
        })
        lib.showContext('supply_orders_menu')     
    end, isBusiness) 
end)

RegisterNetEvent('QBCore:drivingVehicle', function(isDriving, currentVehicle)
    if inVehicle and isDriving then return end -- prevent duplicate loops
	inVehicle = isDriving
    if inVehicle then
        if GetEntityModel(currentVehicle) == joaat('forklift2') then -- in forklift start thread
            inForklift = true
            CreateThread(function()
                ForkliftThread(currentVehicle)
            end)
        else
            inForklift = false
        end
    end
end)

RegisterNetEvent('prdx_gopostal:client:spawnPallet', function(product, coords, orderid, index)
    SpawnPallet(product, coords, orderid, index)
end)

RegisterNetEvent('prdx_gopostal:client:attachPallet', function(pallet, vehicle)
    local palletEnt = NetToEnt(pallet)
    local vehicleEnt = NetToVeh(vehicle)
    print('Attach', palletEnt, vehicleEnt, vehicle)
    ActivatePallet(palletEnt, vehicleEnt)
end)

RegisterNetEvent('prdx_gopostal:client:detachPallet', function(pallet, vehicle)
    local palletEnt = NetToEnt(pallet)
    local vehicleEnt = NetToVeh(vehicle)
    print('Detach', palletEnt, entityHit)
    DetachEntity(palletEnt, false, false)
    ActivatePhysics(palletEnt)
    ProcessEntityAttachments(palletEnt)
    SetActivateObjectPhysicsAsSoonAsItIsUnfrozen(palletEnt, true)
    FreezeEntityPosition(palletEnt, false)
    QBCore.Functions.Notify('Unsecured pallet from vehicle', 'success')
end)

RegisterNetEvent('prdx_gopostal:client:resetPallet', function(pallet, product)
    local palletEnt = NetToEnt(pallet)
    local productEnt = NetToEnt(product)
    local tempPalletData = Entity(palletEnt).state.PalletData
    print('Reset', palletEnt, palletEnt)
    if DoesEntityExist(productEnt) then
        AttachProductToPallet(palletEnt, productEnt, tempPalletData.containerData.offset, tempPalletData.containerData.rotation)
    else
        local coords = GetEntityCoords(pallet)
        local productEntity = CreateObject(ChosenProduct.model, coords.x, coords.y, coords.z - 20.0, true, true)
        SetEntityHeading(productEntity, GetEntityHeading(pallet))
        SetEntityCanBeDamaged(productEntity, false)
        SetEntityAsMissionEntity(productEntity, true, true)
        SetDisableFragDamage(productEntity, true)
        Wait(250)
        AttachProductToPallet(palletEnt, productEnt, tempPalletData.containerData.offset, tempPalletData.containerData.rotation)
    end
end)

RegisterNetEvent('prdx_gopostal:client:spawnForklift', function(data)
    if Config.GoPostal.ForkliftSpawns[data.spawnlocation] then
        QBCore.Functions.SpawnVehicle('forklift2', function(forklift)
            SetVehicleNumberPlateText(forklift, "FORKLIFT-" .. tostring(math.random(10,99)))
            exports['ps-fuel']:SetFuel(forklift, 100.0)
            SetEntityHeading(forklift, Config.GoPostal.ForkliftSpawns[data.spawnlocation].w)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(forklift))
            NetworkRegisterEntityAsNetworked(forklift)
            SetVehicleLivery(forklift, 1)
            SetTimeout(60000, function()
                SetEntityAsNoLongerNeeded(forklift) -- Keeps area clean
            end)
        end, vec3(Config.GoPostal.ForkliftSpawns[data.spawnlocation].x, Config.GoPostal.ForkliftSpawns[data.spawnlocation].y, Config.GoPostal.ForkliftSpawns[data.spawnlocation].z), true) 
    end
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerJob = {}
    SetupJob()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    SetupJob()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    SetupJob()
end)

AddEventHandler('onResourceStart', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        if LocalPlayer.state['isLoggedIn'] then
            PlayerJob = QBCore.Functions.GetPlayerData().job
            SetupJob()
        end
    end
end)

AddEventHandler('onResourceStop', function (resourceName)
    if resourceName == GetCurrentResourceName() then
        for business,coords in pairs(Config.GoPostal.DepositLocations) do
            exports['polyzonehelper']:DeletePolyZone("PalletDeposit")
        end
        for warehouse,coords in pairs(Config.GoPostal.BusinessDeposits) do
            exports['polyzonehelper']:DeletePolyZone("PalletDeposit")
        end
    end
end)

CreateThread(function()
	Wait(2500)
	SetupPalletDeposit()	
end)
