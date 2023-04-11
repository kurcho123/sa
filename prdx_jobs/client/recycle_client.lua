CreateThread(function()
    blip1 = AddBlipForCoord(vector3(-616.93, -1622.77, 33.01))
    SetBlipSprite(blip1, 467)
    SetBlipDisplay(blip1, 2)
    SetBlipAsShortRange(blip1, true)
    SetBlipScale(blip1, 0.7)
    SetBlipColour(blip1, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Recycling Center")
    EndTextCommandSetBlipName(blip1)

    blip2 = AddBlipForCoord(vector3(-184.8, 6271.89, 31.49))
    SetBlipSprite(blip2, 467)
    SetBlipDisplay(blip2, 2)
    SetBlipAsShortRange(blip2, true)
    SetBlipScale(blip2, 0.7)
    SetBlipColour(blip2, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Recycling Center")
    EndTextCommandSetBlipName(blip2)
end)

AddEventHandler('prdx_jobs:client:recycleItems', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'fishsell', true},            
        },
        {
            title = "Cancel", 
            event = "fishing:client:FishBuyerMenu"
        },        
    }
    lib.registerContext({
        id = 'recycle_menu',
        title = 'Reycle Items',
        options = menu,
    })
    lib.showContext('recycle_menu')
end)