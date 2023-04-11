QBCore = exports['qb-core']:GetCoreObject()



RegisterNetEvent('prdx_smallmissions:client:OpenMenu', function()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    if PlayerJob.name == "marshalls" or PlayerJob.name == "lspd" or PlayerJob.name == "bcso" or PlayerJob.name == "sast" or PlayerJob.name == "hc" or PlayerJob.name == "pd_cid" then
        QBCore.Functions.Notify('\"Piss off!\"', 'error')
        return
    end


    local menu = {
        {
            title = "Assasin Missions", 
            description = 'Assasinate the target and bring confirmation back',
            event = "prdx_smallmissions:client:AssasinMissionMenu",
            args = {'assasinsell', 'assasinsell'}
        }
    }
    lib.registerContext({
        id = 'assasin_menu',
        title = 'Small Missions',
        options = menu,
    })
    lib.showContext('assasin_menu')
end)

AddEventHandler('prdx_smallmissions:client:AssasinMissionMenu', function(data)
    local menu = {
        {
            title = 'Assasinate the target and bring confirmation back',
            disabled = true
        },
		{
            title = "Take Mission", 
            serverEvent = "RobberyTimer:RobberyReserved",
            args = 'AssasinMission'
        },
		{
            title = "Open Sell Box", 
            event = "target:client:openStash",
            args = data
        },
        {
            title = "Confirm Sale", 
            event = "prdx_smallmissions:client:sellMenu",
        }
    }
    lib.registerContext({
        id = 'assasin_mission_menu',
        title = "Assasin Missions",
        menu = 'assasin_menu',
        options = menu,
    })
    lib.showContext('assasin_mission_menu')
end)

AddEventHandler('prdx_smallmissions:client:sellMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm Sale", 
            serverEvent = "inventory:server:sellStash",
            args = {'assasinsell', true}
        }     
    }
    lib.registerContext({
        id = 'assasin_sell_menu',
        title = "Assasin Sell",
        menu = 'assasin_mission_menu',
        options = menu,
    })
    lib.showContext('assasin_sell_menu')
end)
