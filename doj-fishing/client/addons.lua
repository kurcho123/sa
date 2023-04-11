
local QBCore = exports['qb-core']:GetCoreObject()

function BoatMenuLaPuerta()
    lib.registerContext({
        id = 'BoatMenuLaPuerta',
        title = 'La Puerta Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Boat: "..Config.RentalBoat,
                description = "Price: $"..Config.BoatPrice,
                event = "doj:client:rentaBoat",
                args = 1,
            }
        }
    })
    lib.showContext('BoatMenuLaPuerta')
end 

function BoatMenuPaletoCove()
    lib.registerContext({
        id = 'BoatMenuPaletoCove',
        title = 'Paleto Cove Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Boat: "..Config.RentalBoat,
                description = "Price: $"..Config.BoatPrice,
                event = "doj:client:rentaBoat",
                args = 2,
            }
        }
    })
    lib.showContext('BoatMenuPaletoCove')
end 

function BoatMenuElGordo()
    lib.registerContext({
        id = 'BoatMenuElGordo',
        title = 'El Gordo Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Boat: "..Config.RentalBoat,
                description = "Price: $"..Config.BoatPrice,
                event = "doj:client:rentaBoat",
                args = 3,
            }
        }
    })
    lib.showContext('BoatMenuElGordo')
end 


function BoatMenuActDam()
    lib.registerContext({
        id = 'BoatMenuActDam',
        title = 'Act Dam Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Boat: "..Config.RentalBoat,
                description = "Price: $"..Config.BoatPrice,
                event = "doj:client:rentaBoat",
                args = 4,
            }
        }
    })
    lib.showContext('BoatMenuActDam')
end 

function BoatMenuAlamoSea()
    lib.registerContext({
        id = 'BoatMenuAlamoSea',
        title = 'Alamo Sea Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Boat: "..Config.RentalBoat,
                description = "Price: $"..Config.BoatPrice,
                event = "doj:client:rentaBoat",
                args = 5,
            }
        }
    })
    lib.showContext('BoatMenuAlamoSea')
end 
--============================================================== ReturnMenus

function ReturnBoatLaPuerta()
    lib.registerContext({
        id = 'ReturnBoatLaPuerta',
        title = 'Fishing Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Return Boat",
                description = "return and get $"..math.floor(Config.BoatPrice/2),
                event = "doj:client:ReturnBoat",
                args = 1,
            }
        }
    })
    lib.showContext('ReturnBoatLaPuerta')
end 

function ReturnBoatPaletoCove()
    lib.registerContext({
        id = 'ReturnBoatPaletoCove',
        title = 'Fishing Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Return Boat",
                description = "return and get $"..math.floor(Config.BoatPrice/2),
                event = "doj:client:ReturnBoat",
                args = 2,
            }
        }
    })
    lib.showContext('ReturnBoatPaletoCove')
end 

function ReturnBoatElGordo()
    lib.registerContext({
        id = 'ReturnBoatElGordo',
        title = 'Fishing Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Return Boat",
                description = "return and get $"..math.floor(Config.BoatPrice/2),
                event = "doj:client:ReturnBoat",
                args = 3,
            }
        }
    })
    lib.showContext('ReturnBoatElGordo')
end 

function ReturnBoatActDam()
    lib.registerContext({
        id = 'ReturnBoatActDam',
        title = 'Fishing Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Return Boat",
                description = "return and get $"..math.floor(Config.BoatPrice/2),
                event = "doj:client:ReturnBoat",
                args = 4,
            }
        }
    })
    lib.showContext('ReturnBoatActDam')
end 

function ReturnBoatAlamoSea()
    lib.registerContext({
        id = 'ReturnBoatAlamoSea',
        title = 'Fishing Boat Rental',
        onExit = function() end,
        options = {
            {
                title = "Return Boat",
                description = "return and get $"..math.floor(Config.BoatPrice/2),
                event = "doj:client:ReturnBoat",
                args = 5,
            }
        }
    })
    lib.showContext('ReturnBoatAlamoSea')
end

--============================================================== Sell/Gear Menus

RegisterNetEvent('doj:client:SellLegalFish')
AddEventHandler('doj:client:SellLegalFish', function()
    lib.registerContext({
        id = 'SellLegalFish',
        title = "Pearl's Seafood Restaurant",
        onExit = function() end,
        options = {
            {
                title = 'Sell Mackerels',
                description = "Current Price: $"..Config.mackerelPrice.." each",
                serverEvent = "fishing:server:SellLegalFish",
                args = 1
            },
            {
                title = "Sell Codfish",
                description = "Current Price: $"..Config.codfishPrice.." each",
                serverEvent = "fishing:server:SellLegalFish",
                args = 2
            },
            {
                title = "Sell Bass",
                description = "Current Price: $"..Config.bassPrice.." each",
                serverEvent = "fishing:server:SellLegalFish",
                args = 3
            },
            {
                title = "Sell Flounder",
                description = "Current Price: $"..Config.flounderPrice.." each",
                serverEvent = "fishing:server:SellLegalFish",
                args = 4
            },
            {
                title = "Sell Stingray",
                description = "Current Price: $"..Config.stingrayPrice.." each",
                serverEvent = "fishing:server:SellLegalFish",
                args = 5
            },
        }
    })
    lib.showContext('SellLegalFish')
end)

RegisterNetEvent('doj:client:buyFishingGear')
AddEventHandler('doj:client:buyFishingGear', function()
    lib.registerContext({
        id = 'buyFishingGear',
        title = "Purchase Fishing Gear",
        onExit = function() end,
        options = {
            {
                title = "Buy Fishing Bait",
                description = "$"..Config.fishingBaitPrice,
                serverEvent = "fishing:server:BuyFishingGear",
                args = 1
            },{
                title = "Buy Fishing Rod",
                description = "$"..Config.fishingRodPrice,
                serverEvent = "fishing:server:BuyFishingGear",
                args = 2
            },{
                title = "Buy Boat Anchor",
                description = "$"..Config.BoatAnchorPrice,
                serverEvent = "fishing:server:BuyFishingGear",
                args = 3
            },{
                title = "Buy Fishing Box",
                description = "$"..Config.FishingBoxPrice,
                serverEvent = "fishing:server:BuyFishingGear",
                args = 4
            },
        }
    })
    lib.showContext('buyFishingGear')
end)

RegisterNetEvent('doj:client:SellillegalFish')
AddEventHandler('doj:client:SellillegalFish', function() 
    if exports.ox_inventory:Search('count', 'pearlscard') > 0 then
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        lib.notify({
            title = "Pearl's Seafood Restaurant",
            description = 'Wellcome, '..charinfo.firstname..' '..charinfo.lastname,
            type = 'success'
        })
        lib.registerContext({
            id = 'SellillegalFish',
            title = "Pearl's Seafood Restaurant",
            onExit = function() end,
            options = {
                {
                    title = "Sell dolphin",
                    description = "Current Price: $ each",
                    serverEvent = "fishing:client:SellillegalFish",
                    args = 1
                },{
                    title = "Sell Tiger Shark",
                    description = "Current Price: $ each",
                    serverEvent = "fishing:client:SellillegalFish",
                    args = 2
                },{
                    title = "Sell Hammerhead Shark",
                    description = "Current Price: $ each",
                    serverEvent = "fishing:client:SellillegalFish",
                    args = 3
                },{
                    title = "Sell Orca",
                    description = "Current Price: $  each",
                    serverEvent = "fishing:client:SellillegalFish",
                    args = 4
                },
            }
        })
        lib.showContext('SellillegalFish')
    else
        lib.notify({
            title = "Pearl's Seafood Restaurant",
            description = 'You cannot sell to us at the moment, sorry for the inconvenience',
            type = 'inform'
        })
    end
end)
