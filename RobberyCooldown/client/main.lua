QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('RobberyCooldown:client:openMenuPublic', function(data) -- Public
    QBCore.Functions.TriggerCallback('RobberyTimer:GetRobberyTimers', function(timers)
        local menu = {}
        for RobberyID, RobberyData in pairs(timers) do
            if Config.Menu[RobberyID] and Config.Menu[RobberyID].public then
                if not RobberyData.available and RobberyData.currentUser == GetPlayerServerId(PlayerId()) then -- I reserved it
                    local menu2 = {
                        {
                            title = Config.Menu[RobberyID].label,
                            description = 'Reserved by me (Press to unreserve)',
                            serverEvent = "RobberyTimer:RobberyUnreserve",
                            args = RobberyID
                        },
                    }
                    lib.registerContext({
                        id = 'public_robbery_queue_menu2',
                        title = 'Robbery Queue',
                        options = menu2,
                    })
                    lib.showContext('public_robbery_queue_menu2')
                    return
                else
                    menu[#menu + 1] = {
                        title = Config.Menu[RobberyID].label,
                        description = Config.Menu[RobberyID].desc,
                        disabled = not RobberyData.available or false,
                        serverEvent = "RobberyTimer:RobberyReserved",
                        args = RobberyID
                    }
                end
            end
        end
        lib.registerContext({
            id = 'public_robbery_queue_menu',
            title = 'Robbery Queue',
            options = menu,
        })
        lib.showContext('public_robbery_queue_menu')
    end, true)
end)

AddEventHandler('RobberyCooldown:client:openMenuPrivate', function(data) -- Private
    QBCore.Functions.TriggerCallback('RobberyTimer:GetRobberyTimers', function(timers)
        local menu = {}
        for RobberyID,Reserved in pairs(timers) do
            if Config.Menu[RobberyID] and not Config.Menu[RobberyID].public then
                if Reserved and Reserved == GetPlayerServerId(PlayerId()) then -- I reserved it
                    local menu2 = {
                        {
                            title = Config.Menu[RobberyID].label,
                            description = 'Reserved by me (Press to unreserve)',
                            serverEvent = "RobberyTimer:RobberyUnreserve",
                            args = RobberyID
                        },
                    }
                    lib.registerContext({
                        id = 'private_robbery_queue_menu2',
                        title = 'Robbery Queue',
                        options = menu2,
                    })
                    lib.showContext('robbery_queue_menu2')
                    return
                else
                    local header = false
                    if Reserved then
                        header = true
                    end  
                    menu[#menu + 1] = {
                        title = Config.Menu[RobberyID].label,
                        description = Config.Menu[RobberyID].desc,
                        disabled = header,
                        serverEvent = "RobberyTimer:RobberyReserved",
                        args = RobberyID
                    }
                end
            end
        end
        lib.registerContext({
            id = 'private_robbery_queue_menu',
            title = 'Robbery Queue',
            options = menu,
        })
        lib.showContext('private_robbery_queue_menu')
    end, true)
end)