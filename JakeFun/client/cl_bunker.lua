
function EnterBunker(coords)
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh > 0 then
        DoScreenFadeOut(500)
        Wait(750)
        FreezeEntityPosition(veh, true)
        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            QBCore.Functions.TriggerCallback("JakeFun:server:InstanceVehicle", function(pass) 
                local veh = GetVehiclePedIsIn(PlayerPedId())
                print('passed:', pass)
                FreezeEntityPosition(veh, false)
            end, 8008, NetworkGetNetworkIdFromEntity(veh), coords) 
        end
        Wait(2500)
        FreezeEntityPosition(PlayerPedId(), false)
        DoScreenFadeIn(2500)
    end
end

function ExitBunker(coords)
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh > 0 then
        DoScreenFadeOut(500)
        Wait(750)
        FreezeEntityPosition(veh, true)
        if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            QBCore.Functions.TriggerCallback("JakeFun:server:InstanceVehicle", function(pass) 
                local veh = GetVehiclePedIsIn(PlayerPedId())
                print('passed:', pass)
                FreezeEntityPosition(veh, false)
            end, 0, NetworkGetNetworkIdFromEntity(veh), coords) 
        end
        Wait(2500)
        FreezeEntityPosition(PlayerPedId(), false)
        DoScreenFadeIn(2500)
    end
end

function SetupBunkerExits()
    exports['polyzonehelper']:DeletePolyZone("BunkerExit")
    exports['polyzonehelper']:DeletePolyZone("BunkerEnter")
    Wait(1000)
    exports['polyzonehelper']:AddBoxZone("BunkerExit", vector3(937.38, -3246.09, -97.46), 29.0, 10.8, {
        name="BunkerExit",
        heading=90,
        debugPoly=false,
        minZ=-98.06,
        maxZ=-86.46
    }) 
    exports['polyzonehelper']:AddBoxZone("BunkerEnter", vector3(963.64, -1856.74, 31.2), 6.2, 8.4, {
        name="BunkerEnter",
        heading=355,
        debugPoly=false,
        minZ=25.06,
        maxZ=37.00
    })  
      
end

AddEventHandler('polyzonehelper:enter', function(name)
    if name == "BunkerExit" then
        local exitCoords = vector4(938.35, -1804.94, 30.94, 264.75)
        ExitBunker(exitCoords)
    elseif name == "BunkerEnter" then
        local enterCoords = vector4(913.02, -3245.55, -97.55, 89.78)
        EnterBunker(enterCoords)
    end
end)

CreateThread(function()
    SetupBunkerExits()    
end)