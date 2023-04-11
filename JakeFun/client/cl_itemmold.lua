local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('JakeFun:client:moldMachineSettings', function()
    local dialog = lib.inputDialog("Item Molder",{
        { type = "input", label = "Molded Name"},
        { type = "input", label = "Molded Description"},
        { type = "input", label = "Image File Name"},
    })
    
    if not dialog then return end

    TriggerServerEvent('JakeFun:server:itemMoldSettings', dialog[1], dialog[2], dialog[3])

end)

RegisterNetEvent('JakeFun:client:openItemMolder', function(data)
    QBCore.Functions.TriggerCallback("JakeFun:server:getMolderSettings", function(settingsName, settingsDesc, settingsImage, isBusy)
        if isBusy then
            local menu = {
                {
                    title = 'Mold Items',
                    description = 'Name: '..settingsName..'\n\rDescription: '..settingsDesc..'\n\rImage: '..settingsImage,
                    disabled = true
                },
                {
                    title = "ERROR:", 
                    description = "Machine in use already!", 
                    disabled = true
                },      
            }
            lib.registerContext({
                id = 'mold_items_menu',
                title = 'Item Molder',
                options = menu,
            })
            lib.showContext('mold_items_menu')
        else
            if not settingsName then
                settingsName = '-Reset-'
            end 
            if not settingsDesc then
                settingsDesc = '-Reset-'
            end
            if not settingsImage then
                settingsImage = '-Reset-'
            end
            local menu = {
                {
                    title = 'Item Molder x5000',
                    description = 'Current Settings: \n\rName: '..settingsName..'\n\rDescription: '..settingsDesc..'\n\rImage: '..settingsImage,
                    disabled = true
                },
                {
                    title = "Set Machine Settings",
                    event = "JakeFun:client:moldMachineSettings"
                },
                {
                    title = "Open Mold Machine Input",
                    event = "target:client:openStash",
                    args = {"itemmold", true}         
                },
                {
                    title = "Process Items",
                    event = "JakeFun:client:confirmMold" ,
                    args = data, 
                },
            }
            lib.registerContext({
                id = 'mold_items_menu',
                title = 'Item Molder',
                options = menu,
            })
            lib.showContext('mold_items_menu')
        end
    end)
end)

AddEventHandler('JakeFun:client:confirmMold', function(data)
    QBCore.Functions.TriggerCallback("JakeFun:server:getMolderSettings", function(settingsName, settingsDesc, settingsImage, isBusy)
        if not settingsName then
            settingsName = '-Reset-'
        end 
        if not settingsDesc then
            settingsDesc = '-Reset-'
        end
        if not settingsImage then
            settingsImage = '-Reset-'
        end
        if isBusy then
            local menu = {
                {
                    title = 'Mold Items',
                    description = 'Name: '..settingsName..'\n\rDescription: '..settingsDesc..'\n\rImage: '..settingsImage,
                    disabled = true
                },
                {
                    title = "ERROR:", 
                    description = "Machine in use already!", 
                    disabled = true
                },      
            }
            lib.registerContext({
                id = 'mold_items_menu',
                title = 'Item Molder',
                options = menu,
            })
            lib.showContext('mold_items_menu')
        else
            local menu = {
                {
                    title = 'Mold Items',
                    description = 'Name: '..settingsName..'\n\rDescription: '..settingsDesc..'\n\rImage: '..settingsImage,
                    disabled = true
                },
                {
                    title = "WARNING:", 
                    description = "This action is not reversable!", 
                    disabled = true
                },
                {
                    title = "Confirm", 
                    event = "JakeFun:client:startMolding",
                    args = {'itemmold', true}      
                }    
            }
            lib.registerContext({
                id = 'mold_items_menu',
                title = 'Item Molder',
                options = menu,
            })
            lib.showContext('mold_items_menu')
        end
    end)
end)

AddEventHandler('JakeFun:client:startMolding', function(data)
    QBCore.Functions.Notify('Molding machine started...', 'success')
    TriggerServerEvent('JakeFun:server:setMolderBusy', true)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.5, 'puffmachine', 0.01)
    SetTimeout(44000, function()
        TriggerServerEvent("inventory:server:sellStash", data)
        TriggerServerEvent('JakeFun:server:setMolderBusy', false)
    end)
end)

RegisterNetEvent('JakeFun:client:engraveMachineSettings', function()
    local dialog = lib.inputDialog("Item Engraver",{
        { type = "input", label = "Engraved Name"},
        { type = "input", label = "Engraved Description"},
    })
    
    if not dialog then return end

    TriggerServerEvent('JakeFun:server:itemEngraveSettings', dialog[1], dialog[2], dialog[3])

end)

RegisterNetEvent('JakeFun:client:openItemEngraver', function(data)
    QBCore.Functions.TriggerCallback("JakeFun:server:getEngraverSettings", function(settingsName, settingsDesc, settingsImage, isBusy)
        if isBusy then
            local menu = {
                {
                    title = 'Engrave Items',
                    description = 'Name: '..settingsName..'\n\rDescription: '..settingsDesc,
                    disabled = true
                },
                {
                    title = "ERROR:", 
                    description = "Machine in use already!", 
                    disabled = true
                },      
            }
            lib.registerContext({
                id = 'engrave_items_menu',
                title = 'Item Engraver',
                options = menu,
            })
            lib.showContext('engrave_items_menu')
        else
            if not settingsName then
                settingsName = '-Reset-'
            end 
            if not settingsDesc then
                settingsDesc = '-Reset-'
            end
            local menu = {
                {
                    title = 'Item Engraver x5000',
                    description = 'Current Settings: \n\rName: '..settingsName..'\n\rDescription: '..settingsDesc,
                    disabled = true
                },
                {
                    title = "Set Machine Settings",
                    event = "JakeFun:client:engraveMachineSettings"
                },
                {
                    title = "Open Engraving Machine Input",
                    event = "target:client:openStash",
                    args = {"itemengrave", true}         
                },
                {
                    title = "Process Items",
                    event = "JakeFun:client:confirmEngrave" ,
                    args = data, 
                },
            }
            lib.registerContext({
                id = 'engrave_items_menu',
                title = 'Item Engraver',
                options = menu,
            })
            lib.showContext('engrave_items_menu')
        end
    end)
end)

AddEventHandler('JakeFun:client:confirmEngrave', function(data)
    QBCore.Functions.TriggerCallback("JakeFun:server:getEngraverSettings", function(settingsName, settingsDesc, isBusy)
        if not settingsName then
            settingsName = '-Reset-'
        end 
        if not settingsDesc then
            settingsDesc = '-Reset-'
        end
        if isBusy then
            local menu = {
                {
                    title = 'Engrave Items',
                    description = 'Name: '..settingsName..'\n\rDescription: '..settingsDesc,
                    disabled = true
                },
                {
                    title = "ERROR:", 
                    description = "Machine in use already!", 
                    disabled = true
                },      
            }
            lib.registerContext({
                id = 'engrave_items_menu',
                title = 'Item Engraver',
                options = menu,
            })
            lib.showContext('engrave_items_menu')
        else
            local menu = {
                {
                    title = 'Engrave Items',
                    description = 'Name: '..settingsName..'\n\rDescription: '..settingsDesc,
                    disabled = true
                },
                {
                    title = "WARNING:", 
                    description = "This action is not reversable!", 
                    disabled = true
                },
                {
                    title = "Confirm", 
                    event = "JakeFun:client:startEngraving",
                    args = {'itemengrave', true}      
                }    
            }
            lib.registerContext({
                id = 'engrave_items_menu',
                title = 'Item Engraver',
                options = menu,
            })
            lib.showContext('engrave_items_menu')
        end
    end)
end)

AddEventHandler('JakeFun:client:startEngraving', function(data)
    QBCore.Functions.Notify('Engraving machine started...', 'success')
    TriggerServerEvent('JakeFun:server:setEngraverBusy', true)
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.5, 'puffmachine', 0.01)
    SetTimeout(44000, function()
        TriggerServerEvent("inventory:server:sellStash", data)
        TriggerServerEvent('JakeFun:server:setEngraverBusy', false)
    end)
end)

exports.ox_target:addBoxZone({
	name = "ItemMolder",
	coords = vec3(-44.3, -90.05, 58.5),
	size = vec3(0.4, 0.4, 0.5),
	rotation = 341.0,
    options = {
        {
            name = 'ItemMolder',
            event = 'JakeFun:client:openItemMolder',
            icon = "fas fa-boxes-packing",
            label = "Start Item Molding",
        }
    },
})

exports.ox_target:addBoxZone({
	name = "ItemEngraver",
	coords = vector3(887.78, -3210.19, -98.44),
	size = vec3(0.6, 0.6, 1.0),
	rotation = 341.0,
    options = {
        {
            name = 'ItemEngraver',
            event = 'JakeFun:client:openItemEngraver',
            icon = "fas fa-screwdriver",
            label = "Start Item Engraving",
            groups = {["collective"] = 0, ["srr"] = 0, ["ballas"] = 0, ["nismos"] = 0, ["madrazo"] = 0, ["chaotek"] = 0, ["reapers"] = 0},
            distance = 3.5
        },
    },
})
