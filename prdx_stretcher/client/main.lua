local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local counting = 0
local lit = {{lit = "stretcher", distance_stop = 2.4, name = lit_1, title = "wip"}}
local ambo = {{hash = "Ambulance2", detection = 1.4, depth = -1.0, height = 0.0}}
local Keys = {  ["W"] = 32, ["A"] = 34, ["S"] = 8, ["D"] = 9}
local isEnabled = true -- Enable spawning stretchers


------------------------- QB-Target Model Registering ------------------------------

---Register the models in qb-target
CreateThread(function()
    Wait(500)
    TriggerEvent('prdx_stretcher:client:addEMSoptions')
end)

RegisterNetEvent('prdx_stretcher:client:addEMSoptions', function()
    if isEnabled ==  true then 
        ---Add Model & Options for stretcher
        exports.ox_target:addModel("Stretcher",
        {
            {
                event = 'prdx_stretcher:client:stretcherMenu', 
                icon = 'fas fa-circle',
                label = 'Stretcher Options',
                groups = {'ambulance', 'clinic'},
            }
        })

        ---Add Model & Options for Ambulances
        exports.ox_target:addModel("Ambulance2", 
        {
            {
                event = 'prdx_stretcher:client:ambulanceMenu',
                icon = "fas fa-circle",
                label = "Ambulance Options",
                groups = {"ambulance", "clinic"}
            }
        })
    end
end)

------------------------------------- Menus ---------------------------------------

---Menus (Stretcher)
RegisterNetEvent('prdx_stretcher:client:stretcherMenu', function()
    local menu = {
        {
            title = "Push/Release",
            description = "Push or Stop Pushing Stretcher",
            event = "prdx_stretcher:client:PushStretcher", 
        },
        {
            title = "Load/Unload Patient",
            description = "Load or unload patient on stretcher",
            event = "prdx_stretcher:client:LoadPatient",
        },
        {
            title = "Return Stretcher",
            description = "Return stretcher",
            event = "prdx_stretcher:client:RemoveStretcher",
        },
    }
    lib.registerContext({
		id = 'stretcher_menu',
		title = 'Stretcher Menu',
		options = menu,
	})
	lib.showContext('stretcher_menu')
end)

RegisterNetEvent('prdx_stretcher:client:loadAmbulance', function()
    local menu = {
        {
            title = "Load Left",
            description = "Load stretcher to the middle slot",
            event = "prdx_stretcher:client:LoadStretcherL"
        },
        {
            title = "Load Middle",
            description = "Load stretcher to the left slot",
            event = "prdx_stretcher:client:LoadStretcherM",
        },
        {
            title = "Load Right",
            description = "Load stretcher to the right slot",
            event = "prdx_stretcher:client:LoadStretcherR",
        }
    }
    lib.registerContext({
		id = 'ambulance_loading_menu',
		title = 'Ambulance Loading Options',
        menu = 'ambulance_menu',
		options = menu,
	})
	lib.showContext('ambulance_loading_menu')
end)

---Menus (Ambulance)
RegisterNetEvent('prdx_stretcher:client:ambulanceMenu', function()    
    local menu = {
        {
            title = "Open/Close Doors",
            description = "Opens/Closes Rear Doors",
            event = "prdx_stretcher:client:openDoors"
        },
        {
            title = "Unload Patient",
            description = "Unload patient from ambulance",
            event = "prdx_stretcher:client:takePlayerOutVehicle"
        },
        {
            title = "Load Stretcher",
            description = "Stretcher Loading Options", 
            event = "prdx_stretcher:client:loadAmbulance"
        },
        {
            title = "Unload Stretcher",
            description = "Unload stretcher from ambulance",
            event = "prdx_stretcher:client:UnloadStretcher"
        },
        {
            title = "Spawn Stretcher",
            description = "Spawn Stretcher",
            event = "prdx_stretcher:client:SpawnStretcher"
        },
    }
    lib.registerContext({
		id = 'ambulance_menu',
		title = 'Ambulance Menu',
		options = menu,
	})
	lib.showContext('ambulance_menu')
end)

------------------------------------- Actions ---------------------------------------

RegisterNetEvent('prdx_stretcher:client:RemoveStretcher', function() 
    local pedCoords = GetEntityCoords(cache.ped)
    local closestObject = GetClosestVehicle(pedCoords, 5.0, joaat("stretcher"), 70)
    TriggerServerEvent('prdx_stretcher:server:LogStretcher', false, QBCore.Functions.GetPlate(closestObject))    
    DeleteStretcher(closestObject, 5)    
    Wait(100)
    ClearPedTasksImmediately(cache.ped)
end)

---Actions (Pushing)
local currentlyPushing = nil
RegisterNetEvent('prdx_stretcher:client:PushStretcher', function()  
    local pedCoords = GetEntityCoords(cache.ped)
    local closestObject = GetClosestVehicle(pedCoords, 5.0, joaat("stretcher"), 70)
    if not DoesEntityExist(closestObject) then return end
    if IsEntityAttachedToEntity(closestObject, cache.ped) then  
        currentlyPushing = false
        SetVehicleExtra(closestObject, 1, 0)
        SetVehicleExtra(closestObject, 2, 1)
        DetachEntity(closestObject, true, true)
        DetachEntity(cache.ped, true, true)
        Wait(500)
        ClearPedTasks(cache.ped)
        return
    end
    currentlyPushing = true         
    local propCoords = GetEntityCoords(closestObject)        
    NetworkRequestControlOfEntity(closestObject)
    local First = vector3(0.0, 0.0, 0.0)
    local Second = vector3(5.0, 5.0, 5.0)
    local dimension = GetModelDimensions(GetEntityModel(closestObject, First, Second))   
    AttachEntityToEntity(cache.ped, closestObject, GetPedBoneIndex(6286),  0.0, dimension.y - 0.8, dimension.z + 1.0, 0.0, 0.0, 0.0, 0.0, true, false, true, false, true)
    SetVehicleExtra(closestObject, 1, 0)
    SetVehicleExtra(closestObject, 2, 1)
    if GetIsVehicleEngineRunning(closestObject) then print ("Engine is running, shut it off") SetVehicleEngineOn(closestObject, false, true, true) end
    while currentlyPushing do
        Wait(100)
        if not DoesEntityExist(closestObject) then 
            ClearPedTasksImmediately(cache.ped)
            currentlyPushing = false
        end
        if not NetworkHasControlOfEntity(closestObject) then NetworkRequestControlOfEntity(closestObject) end
        if not IsEntityAttachedToEntity(closestObject, cache.ped) and currentlyPushing then
            pedCoords = GetEntityCoords(cache.ped)
            closestObject = GetClosestVehicle(pedCoords, 5.0, joaat("stretcher"), 70)
            propCoords = GetEntityCoords(closestObject)        
            NetworkRequestControlOfEntity(closestObject)
            First = vector3(0.0, 0.0, 0.0)
            Second = vector3(5.0, 5.0, 5.0)
            dimension = GetModelDimensions(GetEntityModel(closestObject, First, Second))   
            AttachEntityToEntity(cache.ped, closestObject, GetPedBoneIndex(6286),  0.0, dimension.y - 0.8, dimension.z + 1.0, 0.0, 0.0, 0.0, 0.0, true, false, true, false, true) 
        end
        if IsDisabledControlPressed(0, Keys["A"]) then
            TaskVehicleTempAction(cache.ped, closestObject, 7, 100)        
        elseif IsDisabledControlPressed(0, Keys["D"]) then
            TaskVehicleTempAction(cache.ped, closestObject, 8, 100)
        end
        if IsDisabledControlPressed(0, Keys["W"]) then
            if not IsEntityPlayingAnim(cache.ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 3) then
                AttachEntityToEntity(cache.ped, closestObject, GetPedBoneIndex(6286),  0.175, dimension.y - 1.128, dimension.z + 0.975, 0.0, 0.0, 0.0, 0.0, true, false, true, false, true)
                RequestAnimDict('missfinale_c2ig_11')
                TaskPlayAnim(cache.ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 8.0, 8.0, -1, 35, 0, false, false, false)
            end
            SetVehicleForwardSpeed(closestObject, 2.75)
            SetVehicleSteeringAngle(closestObject, 0)
        elseif IsDisabledControlPressed(0, Keys["S"]) then
            if not IsEntityPlayingAnim(cache.ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 3) then
                AttachEntityToEntity(cache.ped, closestObject, GetPedBoneIndex(6286),  0.175, dimension.y - 1.128, dimension.z + 0.975, 0.0, 0.0, 0.0, 0.0, true, false, true, false, true)
                RequestAnimDict('anim@heists@box_carry@')
                TaskPlayAnim(cache.ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 8.0, 8.0, -1, 35, 0, false, false, false)
                --Do a height check here for the backwards scuff--
            end
            SetVehicleForwardSpeed(closestObject, -1.00)
            SetVehicleSteeringAngle(closestObject, 0)
        else
            if not IsEntityPlayingAnim(cache.ped, 'anim@amb@nightclub@lazlow@ig1_vip@', 'clubvip_base_laz', 3) then
                AttachEntityToEntity(cache.ped, closestObject, GetPedBoneIndex(6286),  0.0, dimension.y - 0.8, dimension.z + 0.975, 0.0, 0.0, 0.0, 0.0, true, false, true, false, true)
                RequestAnimDict('anim@amb@nightclub@lazlow@ig1_vip@')
                TaskPlayAnim(cache.ped, 'anim@amb@nightclub@lazlow@ig1_vip@', 'clubvip_base_laz', 8.0, 8.0, -1, 35, 0, false, false, false)
            end
            SetVehicleForwardSpeed(closestObject, 0.0)
        end
        if HasEntityCollidedWithAnything(closestObject) then
            Wait(500)
            SetVehicleOnGroundProperly(closestObject)
        end                    
        if IsPedDeadOrDying(cache.ped) then
            ClearPedTasksImmediately(cache.ped)
            SetVehicleExtra(closestObject, 1, 0)
            SetVehicleExtra(closestObject, 2, 1)
            DetachEntity(closestObject, true, true)
            currentlyPushing = false
        end
    end 
end)

---Actions (Loading Patients)
RegisterNetEvent('prdx_stretcher:client:LoadPatient', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        QBCore.Functions.Progressbar("loading_stretcher", "Loading Patient", 500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        }, {}, {}, {}, function() -- Done
            TriggerServerEvent("prdx_stretcher:server:LoadPatient", GetPlayerServerId(player))
            QBCore.Functions.Notify("Loading patient onto stretcher!", "info")
        end, function()
            QBCore.Functions.Notify("Failed!", "error")
        end)
    end
    if player == -1 then
        QBCore.Functions.Notify("No Patients Nearby", "error")
    end
end)

RegisterNetEvent('prdx_stretcher:client:GetOnStretcher', function()
    local pedCoords = GetEntityCoords(cache.ped)
    local closestObject = GetClosestVehicle(pedCoords, 5.0, joaat("stretcher"), 70)
    if closestObject > 0 then
        QBCore.Functions.Notify("Someone is loading you onto a stretcher", "info") 
        if not IsEntityAttachedToEntity(closestObject,cache.ped) then
            local pedCoords = GetEntityCoords(cache.ped)
            local closestObject = GetClosestVehicle(pedCoords, 5.0, joaat("stretcher"), 70)
            if DoesEntityExist(closestObject) then
                lib.requestAnimDict("savecouch@")
                exports['prdx_healthsystem']:DisableHealthSystem(true)
                AttachEntityToEntity(cache.ped, closestObject, cache.ped, 0.05, 0.15, 1.15, 0.5, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
                Wait(250)
                ClearPedTasksImmediately(cache.ped)
                TaskPlayAnim(cache.ped, "savecouch@", "t_sleep_loop_couch", 8.0, 8.0, -1, 1, 0, false, false, false)
            end
        else
            ClearPedTasksImmediately(cache.ped)
            Wait(100)
            DetachEntity(cache.ped, true, false)   
            exports['prdx_healthsystem']:DisableHealthSystem(false)
        end
    end
end)

---Actions (Loading Stretcher into Ambo (called by L/M/R)) -- This needs tweaked to prevent desync issues
RegisterNetEvent('prdx_stretcher:client:LoadStretcher', function(positionA)
    local nearbyStretcher = GetClosestVehicle(GetEntityCoords(cache.ped), 2.0, joaat("stretcher"), 70)
    if IsEntityAttachedToEntity(nearbyStretcher, cache.ped) then  
        TriggerEvent('prdx_stretcher:client:PushStretcher')
    end
    local nearestAmbo = GetClosestVehicle(GetEntityCoords(cache.ped), 7.0, joaat("Ambulance2"), 18)
    if DoesEntityExist(nearbyStretcher) and DoesEntityExist(nearestAmbo) then
        QBCore.Functions.Progressbar("load_ambo", "Loading Stretcher", 1500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        }, 
        {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 0,
            task = nil,
        }, {}, {}, function() 
            for _,g in pairs(ambo) do
                if nearestAmbo ~= 0 and nearbyStretcher ~= 0 then
                    AttachEntityToEntity(nearbyStretcher, nearestAmbo, GetEntityBoneIndexByName(nearestAmbo, "hood"), positionA, -2.5, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                    Wait(1000)
                    SetVehicleExtra(nearbyStretcher, 1, 1)
                    SetVehicleExtra(nearbyStretcher, 2, 0)
                    ClearPedTasksImmediately(cache.ped)
                end
            end
        end, function()
            QBCore.Functions.Notify("Failed!", "error")
        end)    
    else
        QBCore.Functions.Notify("You are not near a stretcher", "error")
    end
end)

RegisterNetEvent('prdx_stretcher:client:LoadStretcherL', function()
    TriggerServerEvent('prdx_stretcher:server:LoadStretcher', -0.35)
end)

RegisterNetEvent('prdx_stretcher:client:LoadStretcherR', function()
    TriggerServerEvent('prdx_stretcher:server:LoadStretcher', 0.35)
end)

RegisterNetEvent('prdx_stretcher:client:LoadStretcherM', function()
    TriggerServerEvent('prdx_stretcher:server:LoadStretcher', 0.0)
end)

---Actions (Unloading Stretcher from Ambo - Move to server)
RegisterNetEvent('prdx_stretcher:client:UnloadStretcher', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    --To add> Look at ambo
    QBCore.Functions.Progressbar("unload_stretcher", "Unloading Stretcher", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {
        animDict = "mini@repair",
        anim = "fixing_a_ped",
        flags = 0,
        task = nil,
    }, {}, {}, function() 
       -- Get the stretcher
        local stretcher = GetClosestVehicle(GetEntityCoords(cache.ped), 10.0, joaat("stretcher"), 70) 
        local breakcheck = 0  
            while stretcher == nil do
                Wait(500)
            local stretcher = GetClosestVehicle(GetEntityCoords(cache.ped), 10.0, joaat("stretcher"), 70)
            
            breakcheck = breakcheck + 1
                if breakcheck == 5 then 
                    break
                end
            end
        local ambulance = GetClosestVehicle(GetEntityCoords(cache.ped), 10.0, joaat("Ambulance2"), 70)
        -- Get the ambulance
        local pedloc = GetEntityCoords(ambulance)
        local unloadLocation = GetEntityForwardVector(ambulance)
        local testcoords = pedloc - (unloadLocation * 6)
        local testheading = GetEntityHeading(ambulance)
        TriggerServerEvent('prdx_stretcher:server:UnloadStretcher', stretcher, ambulance, testcoords, testheading)
    end, function()
        QBCore.Functions.Notify("Failed!", "error")
    end)
end)

RegisterNetEvent('prdx_stretcher:client:UnloadStretcherC', function(stretcher, ambulance, unloadlocation, heading)   
    local attempts = 0
    local checkone = QBCore.Functions.TakeControl(ambulance)
    if not checkone then 
        QBCore.Functions.Notify('Failed to access ambulance, are you the owner?', 'error')
        ClearPedTasks(cache.ped)
    end
    DetachEntity(ambulance, true, true)
    DetachEntity(stretcher, true, false)   
    SetEntityCoords(stretcher, unloadlocation.x, unloadlocation.y, unloadlocation.z)
    SetEntityHeading(stretcher, (heading + 180))  
    Wait(100)
    TriggerEvent('prdx_stretcher:client:PushStretcher')
end)

local doorsOpen = false
---Actions (Ambo Door Controls)
RegisterNetEvent('prdx_stretcher:client:openDoors', function()
    local lastAmbo = GetVehiclePedIsIn(cache.ped, true)
    local request = QBCore.Functions.TakeControl(lastAmbo)
    if not request then QBCore.Functions.Notify('Something went wrong with the doors, are you the owner?', 'error') return end
    if doorsOpen then 
        SetVehicleDoorShut(lastAmbo, 2, false)
        SetVehicleDoorShut(lastAmbo, 3, false)
        doorsOpen = false
    else
        SetVehicleDoorOpen(lastAmbo, 2, false, false)
        SetVehicleDoorOpen(lastAmbo, 3, false, false)
        doorsOpen = true
    end
end)

RegisterNetEvent('prdx_stretcher:client:stretchercheck', function()
    local closestObject = GetClosestVehicle(pedCoords, 2.0, joaat("stretcher"), 70)
    if closestObject then
        TriggerEvent('prdx_stretcher:client:LoadPatient')
    end
end)

------------------------------------- MISC FUNCTIONS ---------------------------------------

---Misc Functions (Stretcher Deletion)
function DeleteStretcher(veh)
    SetEntityAsMissionEntity( veh, true, true )
    DeleteVehicle(veh)
end

RegisterNetEvent('prdx_stretcher:client:checkPatientIntoHospital', function(data)
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= PlayerId() and player ~= -1 and distance < 2.5 then
        local result = lib.inputDialog("Hosptial Check In",{
            { type = "number", label = "Enter length of hospital time in seconds...", placeholder = '60' },
        })
        local time = nil
        if result then
            time = result[1]
            if time == 0 then
                time = nil
            end
            TriggerEvent('prdx_stretcher:client:RemoveStretcher')
            TriggerServerEvent("prdx_stretcher:server:LoadPatient", GetPlayerServerId(player))
            Wait(100)
            TriggerServerEvent('prdx_healthsystem:server:sendPlayerToHospital', time, GetPlayerServerId(player)) 
        end 
    else
        QBCore.Functions.Notify('Error: No one close enough', 'error')       
    end
end)

RegisterNetEvent('prdx_stretcher:client:takePlayerOutVehicle', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 7.0 then
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:SetPlayerOutVehicle", GetPlayerServerId(player))
        end
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNetEvent('prdx_stretcher:client:SpawnStretcher', function()
    local ambulance = GetClosestVehicle(GetEntityCoords(cache.ped), 10.0, joaat("Ambulance2"), 70)
    local pedloc = GetEntityCoords(ambulance)
    local unloadLocation = GetEntityForwardVector(ambulance)
    local coords = pedloc - (unloadLocation * 6)
    local heading = GetEntityHeading(ambulance)
    local veh = "stretcher"
    lib.requestModel(veh)
    local closestObject = CreateVehicle(joaat(veh), coords, heading -180, 1, 0)
    local platenum = math.random(11111, 99999)
    SetVehicleNumberPlateText(closestObject, "STR" .. platenum)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(closestObject))
    exports['ps-fuel']:SetFuel(closestObject, 0.0)
    Wait(100)
    SetVehicleExtra(closestObject, 1, 0)
    SetVehicleExtra(closestObject, 2, 1)
    SetEntityAsMissionEntity(closestObject, true, true)
    Wait(200)
    TriggerEvent('prdx_stretcher:client:PushStretcher')
    TriggerServerEvent('prdx_stretcher:server:LogStretcher', true, QBCore.Functions.GetPlate(closestObject))
end)