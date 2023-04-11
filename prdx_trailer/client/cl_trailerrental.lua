function GetClosestTrailerSpawn()
    local dist = 10000.0
    local coords = GetEntityCoords(PlayerPedId())
    local ClosestSpawn
    for k,v in pairs(Config.TrailerSpawns) do
        local TempDist = #(vec3(v.x, v.y, v.z) - coords) 
        if TempDist < dist then
            ClosestSpawn = v
            dist = TempDist
        end
    end    
    return ClosestSpawn
end

AddEventHandler('prdx_trailers:client:OpenTrailerMenu', function(data)
    local menu = {
        {
            title = 'Rent a trailer | Single use',
            disabled = true
        },
        {
            title = "Small Truck Trailers", 
            event = "prdx_trailers:client:RentTrailerMenu",
            args = 'truck'
        },    
        {
            title = "Semi Truck Trailers", 
            event = "prdx_trailers:client:RentTrailerMenu",
            args = 'semi'
        },   
        {
            title = "Tractor Trailers", 
            event = "prdx_trailers:client:RentTrailerMenu",
            args = 'tractor'
        },   
    }
    lib.registerContext({
        id = 'trailer_rentals_menu',
        title = "Trailer Rentals",
        options = menu,
    })
    lib.showContext('trailer_rentals_menu')
end)

AddEventHandler('prdx_trailers:client:RentTrailerMenu', function(trailerType)
    local menu = {
        {
            title = 'Rent a trailer | Single use',
            disabled = true
        }
    }
    for k,v in pairs(Config.TrailerRentals) do
        if v.trailerType == trailerType then
            menu[#menu+1] = {
                title = v.name,
                description = 'Price: $'..v.price, 
                serverEvent = "prdx_trailers:server:RentTrailer",
                args = k
            }
        end
    end
    lib.registerContext({
        id = 'rent_trailer_menu',
        title = "Trailer Rentals",
        options = menu,
    })
    lib.showContext('rent_trailer_menu')
end)

RegisterNetEvent('prdx_trailers:client:RentedTrailer', function(trailer)
    local SpawnPoint = GetClosestTrailerSpawn()
    if SpawnPoint then
        QBCore.Functions.SpawnVehicle(trailer, function(trailer)
            QBCore.Functions.Notify('Your trailer rental has been started!', 'success')
            SetVehicleNumberPlateText(trailer, "RT" .. tostring(math.random(111111,999999)))
            exports['ps-fuel']:SetFuel(trailer, 100.0)
            SetEntityHeading(trailer, SpawnPoint.w)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(trailer))
            NetworkRegisterEntityAsNetworked(trailer)
        end, SpawnPoint, true) 
    end
end)