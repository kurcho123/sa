local QBCore = exports['qb-core']:GetCoreObject()
local SpawnedPeds = {}
local currentLab
local inMenu = false
local inDrugEntrance = false
local openingDoor = false
local UsedPinCode = false
local zones = {}
local LabStorage

function HasKeys(closestLab)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local LabData = Config.ActiveLabs[closestLab] or Config.PrivateLabs[closestLab]
    if not LabData then return false end
    local hasKeys = false
    if type(LabData.owner) == "table" then
        if LabData.owner.gang and LabData.owner.gang == PlayerData.gang.name then
            hasKeys = true
        end
        if LabData.owner.job and LabData.owner.job == PlayerData.job.name then
            hasKeys = true
        end
        if LabData.owner.citizenid and LabData.owner.citizenid == PlayerData.citizenid then
            hasKeys = true
        end
    else
        if LabData.owner == PlayerData.citizenid then
            hasKeys = true
        end
    end

    return hasKeys
end

function GetClosestLab()
    local coords = GetEntityCoords(cache.ped)
    local lab, closestDistance = nil, -1
    for k,v in pairs(Config.PrivateLabs) do
        local distance = #(coords - vec3(v.enterCoords.x, v.enterCoords.y, v.enterCoords.z))
        if closestDistance == -1 or distance < closestDistance  then
            lab = k
            closestDistance = distance
        end
    end
    for k, v in pairs(Config.ActiveLabs) do
        local distance = #(coords - vec3(v.enterCoords.x, v.enterCoords.y, v.enterCoords.z))
        if closestDistance == -1 or distance < closestDistance  then
            lab = k
            closestDistance = distance
        end
    end
    return lab, closestDistance
end

function CleanupPeds()
    for k,v in pairs(SpawnedPeds) do
        exports.ox_target.RemoveSpawnedPed(v)
    end
    for k,v in pairs(Config.ActiveLabs) do
        exports['polyzonehelper']:DeletePolyZone("DrugLabEntrance")
    end
end

function SpawnPeds()
    QBCore.Functions.TriggerCallback('prdx_drugs:server:labs:getLabLocations', function(RecData, PrivateData)
        Config.ActiveLabs = RecData -- Keep updated
        Config.PrivateLabs = PrivateData
        for k,v in pairs(RecData) do
            local LabTypeData = Config.DrugLabs[v.labType]
            local random = math.random(1,#LabTypeData.pedModels)
            local random2 = math.random(1,#LabTypeData.pedScanarios)
            SpawnedPeds[#SpawnedPeds+1] = exports.ox_target:SpawnPed({
                model = LabTypeData.pedModels[random], 
                coords = v.pedCoords,
                minusOne = true, 
                freeze = true, 
                invincible = true, 
                blockevents = true,
                scenario = LabTypeData.pedScanarios[random],
            })
            -- Entrance --
            exports['polyzonehelper']:AddBoxZone("DrugLabEntrance", vector3(v.enterCoords.x, v.enterCoords.y, v.enterCoords.z), 3.0, 3.0, {
                name = "DrugLabEntrance",
                heading = v.enterCoords.w,
                debugPoly = Config.Debug,
            })  
        end
        -- Private Labs --
        for k,v in pairs(Config.PrivateLabs) do
            -- Entrance --
            exports['polyzonehelper']:AddBoxZone("PrivateDrugLabEntrance", vector3(v.enterCoords.x, v.enterCoords.y, v.enterCoords.z), 3.0, 3.0, {
                name = "PrivateDrugLabEntrance",
                heading = v.enterCoords.w,
                minZ = v.enterCoords.z-1.0,
                maxZ = v.enterCoords.z+1.0,
                debugPoly = Config.Debug,
            })  
        end 
        -- Exits --
        for k,v in pairs(Config.DrugLabs) do
            -- Exit --
            if v.insideCoords then
                exports['polyzonehelper']:AddBoxZone("DrugLabExit", vector3(v.insideCoords.x, v.insideCoords.y, v.insideCoords.z), 2.0, 2.0, {
                    name = "DrugLabExit",
                    heading = v.insideCoords.w,
                    minZ = v.insideCoords.z-1.0,
                    maxZ = v.insideCoords.z+1.0,
                    debugPoly = Config.Debug,
                }) 
            end
        end
    end)
end

function ClearTargets()
    for k,v in pairs(zones) do
        exports.ox_target:removeZone(v)
    end
end

function SetupTargets(LabType)
    local LabData = Config.DrugLabs[LabType]
    -- Crafting Stations --
    if LabData then
        -- Cracfting --
        if LabData.craftBenches then
            for k2,v2 in pairs(LabData.craftBenches) do
                zones[#zones+1] = exports.ox_target:addBoxZone({
                    coords = vec3(v2.coords.x, v2.coords.y, v2.coords.z),
                    size = vec3(1.5, 3.0, (v2.coords.z+1.0) - (v2.coords.z-1.0)),
                    rotation = v2.coords.w,
                    debug = Config.Debug,
                    options = {
                        {
                            name = 'DrugCraftZone-'..k2,
                            event = 'inventory:client:OpenCraftSet',
                            icon = 'fas fa-capsules',
                            label = v2.label,
                            args = v2.recipes,
                            craftingSet = v2.craftSet
                        }
                    }
                })
            end
        end
        -- Storage --
        if LabData.labStorage then
            zones[#zones+1] = exports.ox_target:addBoxZone({
                coords = vec3(LabData.labStorage.x, LabData.labStorage.y, LabData.labStorage.z),
                size = vec3(1.5, 3.0, (LabData.labStorage.z+1.0) - (LabData.labStorage.z-1.0)),
                rotation = LabData.labStorage.w,
                debug = Config.Debug,
                options = {
                    {
                        name = 'LabStorage',
                        event = 'prdx_drugs:client:labs:openLabStorage',
                        icon = 'fas fa-box-open',
                        label = 'Open Storage'
                    }
                }
            })
        end
        if LabData.swapZones then
            for k2,v2 in ipairs(LabData.swapZones) do
                zones[#zones+1] = exports.ox_target:addBoxZone({
                    coords = vec3(v2.coords.x, v2.coords.y, v2.coords.z),
                    size = vec3(1.5, 3.0, (v2.coords.z+1.0) - (v2.coords.z-1.0)),
                    rotation = v2.coords.w,
                    debug = Config.Debug,
                    options = {
                        {
                            name = 'DrugSwapZone-'..k2,
                            event = 'prdx_drugs:client:labs:swapMenu',
                            icon = 'fas fa-capsules',
                            label = v2.label,
                            args = k2
                        }
                    }
                })
            end
        end
    end
end

function EnterLab(LabID)
    TriggerEvent('animations:client:EmoteCommandStart', {"keyfob"})
    currentLab = LabID
    if Config.ActiveLabs[LabID] then
        local ped = cache.ped
        local LabData = Config.DrugLabs[Config.ActiveLabs[LabID].labType]
        if Config.Interiors[Config.ActiveLabs[LabID].labType] then
            Config.Interiors[Config.ActiveLabs[LabID].labType]()
        end
        --LabData.interior()
        SetupTargets(Config.ActiveLabs[LabID].labType)
        DoScreenFadeOut(1500)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
        Wait(1500)
        TriggerServerEvent('qb-apartments:setBucket', Config.ActiveLabs[LabID].instanceid)
        TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999})
        TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
        FreezeEntityPosition(ped, true)
        RequestCollisionAtCoord(LabData.insideCoords.x, LabData.insideCoords.y, LabData.insideCoords.z)
        SetEntityCoords(ped, LabData.insideCoords.x, LabData.insideCoords.y, LabData.insideCoords.z)
        SetEntityHeading(ped, LabData.insideCoords.w)
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(1000)
    elseif Config.PrivateLabs[LabID] then
        local ped = cache.ped
        local LabData = Config.DrugLabs[Config.PrivateLabs[LabID].labType]
        if Config.Interiors[Config.PrivateLabs[LabID].labType] then
            Config.Interiors[Config.PrivateLabs[LabID].labType]()
        end
        SetupTargets(Config.PrivateLabs[LabID].labType)
        DoScreenFadeOut(1500)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
        Wait(1500)
        TriggerServerEvent('qb-apartments:setBucket', Config.PrivateLabs[LabID].instanceid)
        TriggerEvent('ParadoxTime:client:setOverrideData', {hours = 21, minutes = 0, seconds = 0, TimeScaler = 999999999})
        TriggerEvent('ParadoxWeather:client:setOverrideData', 'EXTRASUNNY')
        FreezeEntityPosition(ped, true)
        RequestCollisionAtCoord(LabData.insideCoords.x, LabData.insideCoords.y, LabData.insideCoords.z)
        SetEntityCoords(ped, LabData.insideCoords.x, LabData.insideCoords.y, LabData.insideCoords.z)
        SetEntityHeading(ped, LabData.insideCoords.w)
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(1000)
    end
end

function ExitLab()
    local ped = cache.ped
    TriggerEvent('animations:client:EmoteCommandStart', {"keyfob"})
    if currentLab then
        local LabData = Config.ActiveLabs[currentLab] or Config.PrivateLabs[currentLab]
        if not LabData then
            currentLab = nil
            ExitLab()
        end
        DoScreenFadeOut(1500)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
        Wait(1500)
        TriggerEvent('ParadoxTime:client:setOverrideData' , nil)
        TriggerEvent('ParadoxWeather:client:setOverrideData' , nil)
        TriggerServerEvent('qb-apartments:returnBucket')
        FreezeEntityPosition(ped, true)
        RequestCollisionAtCoord(LabData.enterCoords.x, LabData.enterCoords.y, LabData.enterCoords.z)
        SetEntityCoords(ped, LabData.enterCoords.x, LabData.enterCoords.y, LabData.enterCoords.z)
        SetEntityHeading(ped, LabData.enterCoords.w)
        FreezeEntityPosition(ped, false)
        DoScreenFadeIn(1000)
        currentLab = nil
    else
        DoScreenFadeOut(1500)
        Wait(1500)
        FreezeEntityPosition(ped, true)
        TriggerServerEvent('qb-apartments:returnBucket')
        SetEntityCoords(ped, -1204.47, -891.73, 19.98)
        SetEntityHeading(ped, 48.0)
        Wait(500)
        FreezeEntityPosition(ped, false)
        TriggerEvent('animations:client:EmoteCommandStart', {"passout"})
        DoScreenFadeIn(500)
        QBCore.Functions.Notify('You passed out and woke up somewhere strange...', 'inform')
    end
    ClearTargets()
end

function ExitMenu()
    QBCore.Functions.TriggerCallback('prdx_drugs:server:labs:getLabLocations', function(RecData, PrivateData)
        Config.ActiveLabs = RecData -- Keep updated
        Config.PrivateLabs = PrivateData
        if currentLab then
            local LabData = Config.ActiveLabs[currentLab]              
            if Config.PrivateLabs[currentLab] then
                ExitLab()
            elseif LabData and LabData.owner then
                local hasKeys = HasKeys(currentLab)
                if LabData.rekeyActive then
                    local FormattedType = LabData.labType:gsub("^%l", string.upper)
                    local menu = {
                        {
                            title = "Exit Lab",
                            event = "prdx_drugs:client:labs:ExitLab"
                        },
                        {
                            title = "Cancel Rekey",
                            serverEvent = "prdx_drugs:server:labs:cancelRekey",
                            args = currentLab
                        },
                    }
                    lib.registerContext({
                        id = 'drug_lab_menu',
                        title = FormattedType..' Lab',
                        options = menu,
                    })
                    lib.showContext('drug_lab_menu')
                elseif hasKeys or UsedPinCode then
                    local FormattedType = LabData.labType:gsub("^%l", string.upper)
                    if hasKeys and LabData.isLockpicked then
                        local menu = {
                            {
                                title = "Fix Doorlock",
                                serverEvent = "prdx_drugs:server:labs:FixDoorlock",
                                args = currentLab
                            },
                        }
                        lib.registerContext({
                            id = 'drug_lab_menu',
                            title = FormattedType..' Lab',
                            options = menu,
                        })
                        lib.showContext('drug_lab_menu')
                    else
                        ExitLab()
                    end
                else
                    local FormattedType = LabData.labType:gsub("^%l", string.upper)
                    local menu = {
                        {
                            title = "Exit Lab",
                            event = "prdx_drugs:client:labs:ExitLab",
                        },
                        {
                            title = "Rekey Lab",
                            serverEvent = "prdx_drugs:server:labs:startRekey",
                            args = currentLab
                        },
                    }
                    lib.registerContext({
                        id = 'drug_lab_menu',
                        title = FormattedType..' Lab',
                        options = menu,
                    })
                    lib.showContext('drug_lab_menu')                                     
                end
            else
                currentLab = nil
                ExitLab()
            end
        else
            ExitLab()
        end    
    end)
end

function EntranceLoop()
    while inDrugEntrance do
        Wait(0)
        if IsControlJustReleased(0, 38) then
            QBCore.Functions.TriggerCallback('prdx_drugs:server:labs:getLabLocations', function(RecData, PrivateData)
                Config.ActiveLabs = RecData -- Keep updated
                Config.PrivateLabs = PrivateData
                local lab, distance = GetClosestLab()
                if distance > 10.0 then return end
                if Config.ActiveLabs[lab] then
                    exports['qb-core']:HideText()
                    closestLab = lab
                    TriggerEvent('prdx_drugs:client:labs:openLabEnterMenu')
                elseif Config.PrivateLabs[lab] then
                    exports['qb-core']:HideText()
                    closestLab = lab
                    TriggerEvent('prdx_drugs:client:labs:openPrivateLabEnterMenu')
                end
                Wait(2500)
            end)
        end
    end
end

function ExitLoop()
    while inDrugExit do
        Wait(0)
        if IsControlJustPressed(0, 38) then
            exports['qb-core']:HideText()
            inDrugExit = false
            UsedPinCode = false
            ExitMenu()
            Wait(2500)
        end
    end
end

function LockpickDoorAnim(time)
    time = time / 1000
    lib.requestAnimDict("veh@break_in@0h@p_m_one@")
    TaskPlayAnim(cache.ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    CreateThread(function()
        while openingDoor do
            TaskPlayAnim(cache.ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Wait(2000)
            time = time - 2
            if time <= 0 then
                openingDoor = false
                StopAnimTask(cache.ped, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0)
            end
        end
    end)
end

RegisterNetEvent('prdx_drugs:client:labs:openLabStorage', function()
    if currentLab and type(currentLab) == 'string' then
        QBCore.Functions.TriggerCallback('prdx_drugs:server:generateStash', function(id)
            if id then
                exports.ox_inventory:openInventory('stash', id)
            end
        end, currentLab)
    else
        QBCore.Functions.Notify('No storage available', 'error')
    end
end)

RegisterNetEvent('prdx_drugs:client:labs:enterLab', function(data, LabID)
    inDrugEntrance = false
    UsedPinCode = false
    if LabID then
        EnterLab(LabID)  
    elseif closestLab then
        EnterLab(closestLab)
    end
end)

RegisterNetEvent('prdx_drugs:client:labs:ExitLab', function()
    ExitLab()
end)

AddEventHandler('prdx_drugs:client:labs:usePincode', function()
    exports['keypad']:OpenKeypad(function(combination)
        QBCore.Functions.TriggerCallback('prdx_drugs:server:labs:tryCombo', function(success)
            if success then
                UsedPinCode = true
                EnterLab(closestLab)
            end
        end, closestLab, combination)
    end)
end)

AddEventHandler('prdx_drugs:client:labs:sellLabConfirm', function()
    local menu = {
        {
            title = "Yes",
            serverEvent = "prdx_drugs:server:labs:sellLab",
            args = closestLab
        },
        {
            title = "No", 
            event = "prdx_drugs:client:labs:openLabEnterMenu" 
        }
    }
    lib.registerContext({
        id = 'sell_lab_menu',
        title = 'Are you sure?',
        options = menu,
    })
    lib.showContext('sell_lab_menu')     
end)

AddEventHandler('prdx_drugs:client:labs:openPrivateLabEnterMenu', function()
    local LabData = Config.PrivateLabs[closestLab]
    if LabData.owner then
        local hasKeys = HasKeys(closestLab)
        if hasKeys then
            local menu = {
                {
                    title = "Enter Lab",
                    event = "prdx_drugs:client:labs:enterLab"
                },
            }
            lib.registerContext({
                id = 'private_lab_enter_menu',
                title = LabData.id..' Lab (Private Lab)',
                options = menu,
            })
            lib.showContext('private_lab_enter_menu')
        else
            QBCore.Functions.Notify('Door appears to be locked', 'error')
        end
    end
end)

AddEventHandler('prdx_drugs:client:labs:openLabEnterMenu', function()
    if not closestLab then return end
    local LabData = Config.ActiveLabs[closestLab]
    local FormattedType = LabData.labType:gsub("^%l", string.upper)
    if LabData.owner then
        local hasKeys = HasKeys(closestLab)
        if LabData.isLockpicked then
            local menu = {
                {
                    title = "Enter Lab (Lockpicked)",
                    event = "prdx_drugs:client:labs:enterLab"
                },
            }
            
            lib.registerContext({
                id = 'lab_enter_menu',
                title = FormattedType..' Lab',
                options = menu,
            })
            lib.showContext('lab_enter_menu')
        elseif hasKeys then
            local menu = {
                {
                    title = "Enter Lab",
                    event = "prdx_drugs:client:labs:enterLab"
                },
                {
                    title = "Change Pincode", 
                    event = "prdx_drugs:client:labs:setupPincode"
                },
                {
                    title = "Remove Locks", 
                    description = "You will no longer own/run this lab", 
                    event = "prdx_drugs:client:labs:sellLabConfirm"
                },
            }
            lib.registerContext({
                id = 'lab_enter_menu',
                title = FormattedType..' Lab',
                options = menu,
            })
            lib.showContext('lab_enter_menu')
        else
            local menu = {
                {
                    title = "Pin Code",
                    description = 'Enter pincode to gain entry', 
                    event = "prdx_drugs:client:labs:usePincode"
                }
            }
            lib.registerContext({
                id = 'lab_enter_menu',
                title = 'Unknown Location (Electronically secured door)',
                options = menu,
            })
            lib.showContext('lab_enter_menu')
        end
    else
        local menu = {
            {
                title = "Claim Lab",
                description = 'Put locks on this lab', 
                serverEvent = "prdx_drugs:server:labs:claimLab",
                args = closestLab   
            }
        }
        lib.registerContext({
            id = 'lab_enter_menu',
            title = FormattedType..' Lab',
            options = menu,
        })
        lib.showContext('lab_enter_menu')
    end
end)

-- Pincode Menu --
AddEventHandler('prdx_drugs:client:labs:setupPincode', function()
    local dialog = lib.inputDialog("Setup Lab Pincode",{
        { type = "number", label = "Lab Pin Code", placeholder = "0000" }
    })
    if not dialog then return end

    TriggerServerEvent('prdx_drugs:server:labs:setupPincode', closestLab, dialog[1])
end)

AddEventHandler('prdx_drugs:client:labs:swapMenu', function(data)
    if not currentLab then return end
    local LabData = Config.ActiveLabs[currentLab] or Config.PrivateLabs[currentLab]
    if not LabData then return end
    local swapData = LabData.swapZones[data.args]
    if not swapData then return end
    QBCore.Functions.TriggerCallback('prdx_drugs:server:labs:requestSync', function(RecData, isPrivate)
        if isPrivate then
            Config.PrivateLabs = RecData
        else
            Config.ActiveLabs = RecData
        end
        LabData = RecData[currentLab]
        swapData = LabData.swapZones[data.args]
        if swapData.timestamp then
            local menu = {}
            local readableTimer
            local timeRemaining = TimeFormat(swapData.timestamp)
            if not timeRemaining then
                readableTimer = 'Complete'
                menu = {
                    {
                        title = "Current Status:", 
                        description = 'Time remaining: '..readableTimer,
                        disabled = true,
                    },
                    {
                        title = "Open Machine", 
                        event = "target:client:openStash",
                        args = {swapData.stash, swapData.stash}
                    },
                    {
                        title = "Start Processing", 
                        serverEvent = "prdx_drugs:server:startStageTwo",
                        args = {currentLab, data.args, swapData.stash}                   
                    },
                }
                lib.registerContext({
                    id = 'lab_swap_menu',
                    title = 'Extra Processing',
                    options = menu,
                })
                lib.showContext('lab_swap_menu')
            else
                readableTimer = timeRemaining
                menu = {
                    {
                        title = "Current Status:", 
                        description = 'Time remaining: '..readableTimer,
                        disabled = true,
                    },
                    {
                        title = "Cancel Processing", 
                        serverEvent = "prdx_drugs:server:cancelStageTwo",
                        args = {currentLab, data.args, swapData.stash}                   
                    },
                }
                lib.registerContext({
                    id = 'lab_swap_menu2',
                    title = 'Extra Processing',
                    options = menu,
                })
                lib.showContext('lab_swap_menu2')
            end
        else
            menu = {
                {
                    title = "Open Machine", 
                    event = "target:client:openStash",
                    args = {swapData.stash, swapData.stash}
                },
                {
                    title = "Start Processing", 
                    serverEvent = "prdx_drugs:server:startStageTwo",
                    args = {currentLab, data.args, swapData.stash}                   
                },
            }
            lib.registerContext({
                id = 'lab_swap_menu3',
                title = 'Extra Processing',
                options = menu,
            })
            lib.showContext('lab_swap_menu3')
        end
    end, currentLab, data.args)
end)

AddEventHandler('prdx_drugs:client:labs:cancelConfirmMenu', function(data)
    local menu = {
        {
            title = "Are you sure you want to cancel?", 
            disabled = true
        },
        {
            title = "Confirm", 
            serverEvent = "prdx_drugs:server:cancelStageTwo",
            args = data.args       
        }
    }
    lib.registerContext({
        id = 'lab_swap_confirm_menu',
        title = 'Extra Processing',
        options = menu,
    })
    lib.showContext('lab_swap_confirm_menu')
end)

AddEventHandler('prdx_drugs:client:labs:swapConfirmMenu', function(data)
    local menu = {
        {
            title = "WARNING:", 
            description = "This action is not reversable!", 
            disabled = true
        },
        {
            title = "Confirm", 
            args = data.args       
        }
    }
    lib.registerContext({
        id = 'lab_swap_confirm_menu',
        title = 'Extra Processing',
        options = menu,
    })
    lib.showContext('lab_swap_confirm_menu')
end)

AddEventHandler('prdx_drugs:client:startSwapping', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"parkingmeter"})
    QBCore.Functions.Progressbar("process_drugs", "Processing drugs...", math.random(10000,25000), false, true, {
            disableMovement = true, disableCarMovement = true,disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
            TriggerServerEvent("inventory:server:sellStash", data)
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

function LockpickLab()
    if isBusy then return end
    isBusy = true
    QBCore.Functions.TriggerCallback('prdx_drugs:server:labs:getLabLocations', function(RecData, PrivateData)
        Config.ActiveLabs = RecData -- Keep updated
        Config.PrivateLabs = PrivateData
        local coords = GetEntityCoords(cache.ped)
        local lab, distance = GetClosestLab()
        if not lab or distance >= 10.0 then isBusy = false return end
        local LabData = Config.ActiveLabs[lab]
        if not LabData.owner then QBCore.Functions.Notify('There are no locks on the door', 'error') isBusy = false return end
        local pass = lib.skillCheck({'medium', 'medium', 'medium', 'medium'})
        if not pass then QBCore.Functions.Notify('Failed', "error") isBusy = false return end
        TriggerServerEvent('prdx_drugs:server:labs:breakinAttempt', lab)
        local lockpickTime = 25000
        LockpickDoorAnim(lockpickTime)
        QBCore.Functions.Progressbar("lockpicking_door", 'Lockpicking door...', lockpickTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "veh@break_in@0h@p_m_one@",
            anim = "low_force_entry_ds",
            flags = 16,
        }, {}, {}, function() -- Done
            openingDoor = false
            ClearPedTasks(cache.ped)
            TriggerServerEvent('prdx_drugs:server:labs:LockpickLab', lab)
        end, function() -- Cancel
            openingDoor = false
            ClearPedTasks(cache.ped)
            QBCore.Functions.Notify('Cancelled', "error")
        end)
        CreateThread(function()
            while openingDoor do
                TriggerServerEvent('hud:server:GainStress', math.random(1, 2))
                Wait(10000)
            end
        end)
        isBusy = false 
    end) 
end

RegisterNetEvent('qb-police:client:usedStormRam', function()
    LockpickLab()
end)

RegisterNetEvent('lockpicks:UseLockpick', function()
    LockpickLab()
end)

RegisterNetEvent('prdx_drugs:client:syncLabs', function(LabData, isPrivate)
    if isPrivate then
        Config.PrivateLabs = LabData
    else
        Config.ActiveLabs = LabData
    end
end)

AddEventHandler('polyzonehelper:enter', function(name)
    if not LocalPlayer.state["isLoggedIn"] then return end
    if (name == "DrugLabEntrance" or name == "PrivateDrugLabEntrance") and not inDrugEntrance then
        Wait(250)
        inDrugEntrance = true
        exports['qb-core']:DrawText('[E] Enter', 'left')
        closestLab = false
        EntranceLoop()
    elseif name == "DrugLabExit" and not inDrugExit then
        inDrugExit = true
        exports['qb-core']:DrawText('[E] Exit', 'left')
        closestLab = false
        ExitLoop()
    end
end)

AddEventHandler('polyzonehelper:exit', function(name)
    if not LocalPlayer.state["isLoggedIn"] then return end
    if name == "DrugLabEntrance" or name == "PrivateDrugLabEntrance" then
        inDrugEntrance = false
        closestLab = false
        exports['qb-core']:HideText()
    elseif name == "DrugLabExit" then
        inDrugExit = false
        closestLab = false
        exports['qb-core']:HideText()
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    SpawnPeds()
end)

-- This is to make sure the peds spawn on restart too instead of only when you load/log-in.
AddEventHandler('onResourceStart', function(resource)
    Wait(500)
	if resource ~= GetCurrentResourceName() or not LocalPlayer.state.isLoggedIn then return end
	SpawnPeds()
--[[Wait(500) -- Auto enter DEV
    local lab, distance = GetClosestLab()
    EnterLab(lab) ]]
end)

-- This is to make sure the peds remove on restart too.
AddEventHandler('onResourceStop', function(resource)
	if resource ~= GetCurrentResourceName() then return end
	CleanupPeds()
end)