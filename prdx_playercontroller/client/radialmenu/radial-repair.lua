local InRepairStation = false
local InCarSell = false
local InBoatSell = nil

CreateThread(function()
    -- Repair Points:
    lib.removeRadialItem('repair')
    lib.removeRadialItem('carsell')
    lib.removeRadialItem('boatsell')

    for i = 1, 20 do
        exports['polyzonehelper']:DeletePolyZone("InRepairStation")
    end
    Wait(250)
    -- MRPD
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(435.73, -975.84, 25.7), 10.2, 6.4, {
        name="InRepairStation",
        heading = 270,
        debugPoly = false
    })

    -- Davis PD
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(380.92, -1625.76, 29.29), 15.0, 10.8, {
        name="InRepairStation",
        heading = 320,
        debugPoly = false
    })

    -- Sandy Motorpool
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(1881.0, 3691.41, 33.54), 8.2, 6.8, {
        name="InRepairStation",
        heading = 120,
        debugPoly = false
    })

    -- Pillbox
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(338.57, -575.52, 28.8), 19.8, 5.6, {
        name="InRepairStation",
        heading = 340,
        debugPoly = false
    })

    -- ELS Fire
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(1200.87, -1494.8, 34.69), 10.0, 10.0, {
        name="InRepairStation",
        heading = 181.96,
        debugPoly = false
    })

    -- Bennys
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(-209.46, -1322.08, 30.89), 23.0, 15.6, {
        name="InRepairStation",
        heading = 0,
        debugPoly = false
    })

    -- Kildares
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(-967.54, -2055.4, 9.51), 23.2, 15.4, {
        name="InRepairStation",
        heading = 45,
        debugPoly = false
    })

    -- Sandy LS Customs
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(1178.69, 2640.13, 37.75), 15.2, 10.0, {
        name="InRepairStation",
        heading = 90,
        debugPoly = false
    })

    -- Paleto LS Customs
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(108.42, 6624.79, 31.79), 13.8, 10.4, {
        name="InRepairStation",
        heading = 315,
        debugPoly = false
    })

    -- Middle City LS Customs
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(-336.27, -134.71, 39.01), 17.8, 31.4, {
        name="InRepairStation",
        heading = 340,
        debugPoly = false
    })

    -- South City LS Customs
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(-1154.01, -2009.72, 13.18), 19.0, 31.0, {
        name="InRepairStation",
        heading = 45,
        debugPoly = false
    })

    -- East City LS Customs
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(731.59, -1088.57, 21.76), 19.0, 31.0, {
        name="InRepairStation",
        heading = 270,
        debugPoly = false
    })

    -- Sandy Commercial Customs
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(332.3, 3408.86, 36.69), 39.8, 34.8, {
        name="InRepairStation",
        heading = 360,
        debugPoly = false
    })

    -- City Commercial Customs
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(919.89, -1232.78, 25.54), 39.8, 34.8, {
        name="InRepairStation",
        heading = 96,
        debugPoly = false
    })

    -- Paleto Commercial Customs
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(-364.86, 6063.73, 31.5), 39.8, 34.8, {
        name="InRepairStation",
        heading = 320,
        debugPoly = false
    })

    -- Bikini Tow
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(831.6, -813.18, 25.92), 14.0, 20.0, {
        name="InRepairStation",
        heading = 90.00,
        debugPoly = false
    })

    -- Race Repair
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(912.56, -2359.89, 21.21), 13.4, 13.15, {
        name="InRepairStation",
        heading = 355.0,
        minZ=20.21,
        maxZ=24.21,
        debugPoly = false
    })    
    
    -- Zancudo
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(-2611.57, 3294.53, 32.81), 59.0, 11.2, {
        name="InRepairStation",
        heading = 240.0,
        debugPoly = false
    })  
    
    -- Bunker --
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(834.46, -3237.21, -98.61), 26.4, 24.6, {
        name="InRepairStation",
        heading = 0.0,
        minZ=-100.21,
        maxZ=-91.41,
        debugPoly = false
    })  

     -- Sandy Heli repair --
     exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(1699.86, 3270.94, 41.15), 18.2, 16.4, {
        name="InRepairStation",
        heading = 25,
        minZ=-39.7,
        maxZ=-45.7,
        debugPoly = false
    })  

    -- GrapeSeed Heli repair --
    exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(2139.99, 4815.89, 41.2), 18.2, 16.4, {
        name="InRepairStation",
        heading = 25,
        debugPoly = false
    })  

     -- LSIA Heli repair --
     exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(-1483.4, -3225.16, 13.94), 35.8, 28.0, {
        name="InRepairStation",
        heading = 330,
        debugPoly = false
    }) 
       -- Reapers Bike Shop --
       exports['polyzonehelper']:AddBoxZone("InRepairStation", vector3(37.45, 6492.71, 31.44), 30.44, 32.64, {
        name="InRepairStation",
        heading = 46,
        debugPoly = false
    }) 
end)

AddEventHandler('polyzonehelper:enter', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "InRepairStation" or "NismosTuning" and not InRepairStation then
            InRepairStation = true
            lib.addRadialItem({
                {
                    id = 'repair',
                    label = 'Repair Vehicle',
                    icon = 'wrench',
                    onSelect = function()
                        TriggerEvent('radialmenu:client:repairCar')
                    end
                }
            })
        end 
        if name == "pdmcarsell" and cache.vehicle and not InCarSell then
            InCarSell = true
            lib.addRadialItem({
                {
                    id = 'carsell',
                    label = 'Sell Vehicle',
                    icon = 'car',
                    menu = 'car_sell_menu'
                }
            })
            lib.registerRadial({
                id = 'car_sell_menu',
                items = {
                    {
                        label = 'Sell',
                        icon = 'car',
                        onSelect = function()
                            TriggerServerEvent('qb-vehicleshop:server:sellvehicle')
                        end
                    },
                    {
                        label = 'Get Price',
                        icon = 'car',
                        onSelect = function()
                            TriggerServerEvent('qb-vehicleshop:server:getprice')
                        end
                    }
                }
            })
        end  
        if name == "pdmboatsell" and IsPedInAnyBoat(cache.ped) and not InBoatSell then
            InBoatSell = true
            lib.addRadialItem({
                {
                    id = 'boatsell',
                    label = 'Sell Boat',
                    icon = 'car',
                    menu = 'boat_sell_menu'
                }
            })
            lib.registerRadial({
                id = 'boat_sell_menu',
                items = {
                    {
                        label = 'Sell',
                        icon = 'car',
                        onSelect = function()
                            TriggerServerEvent('qb-vehicleshop:server:sellvehicle')
                        end
                    },
                    {
                        label = 'Get Price',
                        icon = 'car',
                        onSelect = function()
                            TriggerServerEvent('qb-vehicleshop:server:getprice')
                        end
                    }
                }
            })
        end  
    end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "InRepairStation"  or "NismosTuning" then
            lib.removeRadialItem('repair')
            InRepairStation = false
        end
        if name == "pdmcarsell" then
            lib.removeRadialItem('carsell')
            InCarSell = false
        end  
        if name == "pdmboatsell" then
            lib.removeRadialItem('boatsell')
            InBoatSell = false
        end  
    end
end)

AddEventHandler('radialmenu:client:repairCar', function(data)
    local veh = cache.vehicle
    if veh and veh ~= 0 and InRepairStation then
        local vehicleFuel = exports["ps-fuel"]:GetFuel(veh)
        local vehicleHealth = GetVehicleEngineHealth(veh)
        local damage = math.ceil(1000 - vehicleHealth)
        local repairCost = (damage / 10) * 3
        QBCore.Functions.TriggerCallback("prdx_modshop:server:canRepair", function(success)
            if success then
                SetVehicleEngineOn(veh, false, true, true)
                PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "impactdrill", 0.75)
                QBCore.Functions.Progressbar("vehicle_repair", "Repairing car..", 7000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    SetVehicleFixed(veh)
                    SetVehicleDirtLevel(veh, 0.0)
                    WashDecalsFromVehicle(veh, 100.0)
                    RemoveDecalsFromVehicle(veh, false)
                    exports["ps-fuel"]:SetFuel(veh, vehicleFuel)
                    TriggerServerEvent('prdx_vehiclecontroller:server:repairVehicle', repairCost, QBCore.Functions.GetVehicleProperties(veh), damage, VehToNet(veh))
                    SetVehicleEngineOn(veh, true, true, false)
                end, function() -- Cancel
                    QBCore.Functions.Notify('Repair cancelled', 'error', 3000)
                end, "fas fa-procedures")
            end
        end, repairCost)
    else
        QBCore.Functions.Notify("No vehicle to repair.", "error")
    end
end)

lib.onCache('vehicle', function(value)
    if not value then
        if InRepairStation then
            lib.removeRadialItem('repair')
            InRepairStation = false
        end
    end
end)