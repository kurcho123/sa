local QBCore = exports['qb-core']:GetCoreObject()
local notify = exports['qb-notify']
local xSound = exports.xsound

--Initial Load
CreateThread(function()
	Wait(1000)
    TriggerEvent('prdx_clinic:client:loadtargets')
    SetupElevatorPolys()
end)

RegisterNetEvent('prdx_clinic:client:loadtargets', function()
    -- Wheelchair
    exports.ox_target:addModel("iak_wheelchair", 
    {
        {
            event = 'prdx_clinic:client:RemoveWheelchair', 
            icon = 'fas fa-circle',
            label = 'Pickup Wheelchair'
        },
    })

    --Beds
    for k, bedmodel in pairs(Config.BedModels) do
        exports.ox_target:addModel(joaat(bedmodel.modelname), 
        {
            {
                event = 'prdx_clinic:client:getonbed', 
                icon = 'fas fa-bed',
                label = 'Get On Bed',
                position = bedmodel.layposition,
                bedname = bedmodel.modelname,
                distance = 1.0
            },
        })
     end

    --Chairs (Polyzone Version)
    for k, seatmodel in pairs(Config.Seats) do
        exports.ox_target:addBoxZone({
            coords = seatmodel.seatposition,
            size = vec3(seatmodel.ysize, seatmodel.xsize, seatmodel.maxz - seatmodel.minz),
            rotation = seatmodel.heading,
            debug = false,
            options = {
                {
                    name = 'prdx_sit:client:sit',
                    event = 'prdx_sit:client:sit',
                    icon = 'fas fa-chair',
                    label = 'Sit',
                    heading = seatmodel.heading,
                    seatingPos = seatmodel.sitposition,
                    sitanim = seatmodel.anim,
                    ispoly = true,
                    distance = 1.0
                }
            }
        })
    end    
    --Elevators
    for k, elevator in pairs(Config.Elevators) do
        exports.ox_target:addBoxZone({
            coords = elevator.boxPosition,
            size = vec3(elevator.ysize, elevator.xsize, elevator.maxz - elevator.minz),
            rotation = elevator.heading,
            debug = false,
            options = {
                {
                    name = 'prdx_clinic:client:elevator',
                    event = 'prdx_clinic:client:elevator',
                    icon = elevator.icon,
                    label = elevator.label,
                    exitCoords = elevator.exitPoint,
                    name = elevator.name,
                    tooltiptext = elevator.tooltiptext,
                    distance = 5.0
                }
            }
        })        
    end
    --Soundboards
    for k, soundbox in pairs(Config.SurgerySoundboxes) do
        exports.ox_target:addBoxZone({
            coords = soundbox.boxPosition,
            size = vec3(soundbox.ysize, soundbox.xsize, soundbox.maxz - soundbox.minz),
            rotation = soundbox.heading,
            debug = false,
            options = {
                {
                    name = 'prdx_clinic:client:triggersounds:Ventilator',
                    event = 'prdx_clinic:client:triggersounds',
                    icon = soundbox.icon,
                    label = 'Ventilator', 
                    groups = Config.Options.jobTitle,
                    soundName = soundbox.label,
                    url = Config.Options.soundboardURL .. Config.Options.ventSound,
                    volume = Config.Options.surgeryVolume,
                    range = Config.Options.surgeryDistance,
                    position = soundbox.boxPosition, 
                    distance = 5.0,
                    --Progress Bar Stuff
                    barname = "vent_on",
                    tooltip = "Activating Ventilator",
                    startuptime = 1000,
                    animD = "",
                    anim = "",
                    loopAudio = true,
                    duration = 1000
                },
                {
                    name = 'prdx_clinic:client:triggersounds:Suction',
                    event = 'prdx_clinic:client:triggersounds',
                    icon = soundbox.icontwo,
                    label = 'Suction', 
                    groups = Config.Options.jobTitle,
                    soundName = soundbox.label,
                    url = Config.Options.soundboardURL .. Config.Options.suctionSound,
                    volume = Config.Options.surgeryVolume,
                    range = Config.Options.surgeryDistance,
                    position = soundbox.boxPosition, 
                    distance = 5.0,
                    --Progress Bar Stuff
                    barname = "suction_on",
                    tooltip = "Running Suction-O-Tron",
                    startuptime = 1000,
                    animD = "",
                    anim = "",
                    loopAudio = true,
                    duration = 1000
                },
                {
                    name = 'prdx_clinic:client:triggersounds:Cauterize',
                    event = 'prdx_clinic:client:triggersounds',
                    icon = soundbox.iconthree,
                    label = 'Cauterize', 
                    groups = Config.Options.jobTitle,
                    soundName = soundbox.label,
                    url = Config.Options.soundboardURL .. Config.Options.cautSound,
                    volume = Config.Options.surgeryVolume,
                    range = Config.Options.surgeryDistance,
                    position = soundbox.boxPosition, 
                    distance = 5.0,
                    --Progress Bar Stuff
                    barname = "caut_on",
                    tooltip = "Starting Cauterizer",
                    startuptime = 1000,
                    animD = "",
                    anim = "",
                    loopAudio = true,
                    duration = 1000
                },
                {
                    name = 'prdx_clinic:client:triggersounds:SwitchOff',
                    event = 'prdx_clinic:client:triggersounds',
                    icon = soundbox.iconthree,
                    label = 'Switch Off', 
                    groups = Config.Options.jobTitle,
                    soundName = soundbox.label,
                    url = Config.Options.soundboardURL .. Config.Options.blankSoundfile,
                    volume = Config.Options.surgeryVolume,
                    range = Config.Options.surgeryDistance,
                    position = soundbox.boxPosition, 
                    distance = 5.0,
                    --Progress Bar Stuff
                    barname = "vent_off",
                    tooltip = "Deactivating Ventilator",
                    startuptime = 500,
                    animD = "",
                    anim = "",
                    loopAudio = false,
                    duration = 5
                }
            }
        })
    end
    --MRI & X-Ray
    exports.ox_target:addBoxZone({
        coords = vector3(340.98, -576.64, 43.58),
        size = vec3(0.6, 0.25, 43.88 - 43.28),
        rotation = 67.39,
        debug = false,
        options = {
            {
                name = 'prdx_clinic:client:triggersounds:StartMRI',
                event = 'prdx_clinic:client:triggersounds',
                icon = 'fas fa-laptop-medical',
                label = 'Start MRI',
                url = Config.Options.soundboardURL .. Config.Options.mriSound,
                soundName = "mri",
                volume = Config.Options.mriVolume,
                range = Config.Options.mriDistance,
                position = vector3(337.93, -572.95, 43.28),
                barname = "activate_mri",
                tooltip = "Starting MRI",
                animD = "mp_prison_break",
                anim = "hack_loop",
                startuptime = 1500,
                loopAudio = false,
                duration = 100
            },
            {
                name = 'prdx_clinic:client:triggersounds:StopMRI',
                event = 'prdx_clinic:client:triggersounds',
                icon = 'fas fa-power-off',
                label = 'Stop MRI',
                url = Config.Options.soundboardURL .. Config.Options.mriSound,
                soundName = "mri",
                volume = 0.0,
                volume = Config.Options.mriVolume,
                range = Config.Options.mriDistance,
                position = vector3(337.93, -572.95, 43.28),
                barname = "deactivate_mri",
                tooltip = "Stopping MRI",
                animD = "mp_prison_break",
                anim = "hack_loop",
                startuptime = 1500,
                loopAudio = false,
                duration = 10
            }
        }
    })  

    exports.ox_target:addBoxZone({
        coords = vector3(345.03, -577.74, 43.58),
        size = vec3(0.65, 0.3, 43.88 - 43.28),
        rotation = 258.81,
        debug = false,
        options = {
            {
                name = 'prdx_clinic:client:triggersounds:StartX-ray',
                event = 'prdx_clinic:client:triggersounds',
                icon = 'fas fa-radiation-alt',
                label = 'Start X-ray',
                url = Config.Options.soundboardURL .. Config.Options.xraySound,
                soundName = "xray",
                volume = Config.Options.xrayVolume,
                range = Config.Options.xrayDistance,
                position = vector3(349.3, -579.79, 43.22), 
                barname = "activate_xray",
                tooltip = "Starting X-Ray",
                animD = "mp_prison_break",
                anim = "hack_loop",
                startuptime = 1500,
                loopAudio = false,
                duration = 10
            },
            {
                name = 'prdx_clinic:client:triggersounds:StopX-ray',
                event = 'prdx_clinic:client:triggersounds',
                icon = 'fas fa-power-off',
                label = 'Stop X-ray',
                url = Config.Options.soundboardURL .. Config.Options.xraySound,
                soundName = "xray",
                volume = 0.0,
                volume = Config.Options.xrayVolume,
                range = Config.Options.xrayDistance,
                position = vector3(349.3, -579.79, 43.22),
                barname = "deactivate_xray",
                tooltip = "Stopping X-Ray",
                animD = "mp_prison_break",
                anim = "hack_loop",
                startuptime = 1500,
                loopAudio = false,
                duration = 10
            }
        }
    })
end)

-- Lay On Beds // Works for all beds except x-ray, think it has a collider across the bed forcing the player to the side when collisions go back on
RegisterNetEvent('prdx_clinic:client:getonbed', function(data)
    local pedCoords = GetEntityCoords(cache.ped)
    local bedCoords = nil
    local objectId = nil
    if not objectId then objectId = GetClosestObjectOfType(pedCoords, 5.0, joaat(data.bedname), false) end
    if not DoesEntityExist(objectId) then return end
    local bedCoords = GetEntityCoords(objectId)
    local bedheading = (GetEntityHeading(objectId) - 180)
    local unloadLocation = GetEntityForwardVector(objectId)                
    local laypos = vector3(bedCoords.x, bedCoords.y, (bedCoords.z + 1))
    SetEntityHeading(cache.ped, bedheading)
    Wait(10)
    SetEntityCollision(cache.ped, false, true)
    SetEntityCoords(cache.ped, laypos, false)    
    FreezeEntityPosition(cache.ped, true)            
    Wait(500)
    TriggerEvent('animations:client:EmoteCommandStart', {"passout3", 0})
    Wait(1000)
    SetEntityCollision(cache.ped, true, true)
    FreezeEntityPosition(cache.ped, false)   
end)

--Trigger Sounds from client > server
RegisterNetEvent('prdx_clinic:client:triggersounds', function(data)
    QBCore.Functions.Progressbar(data.barname, data.tooltip, data.startuptime, false, true, 
    {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, 
    {}, {}, {}, function() 
    Wait(200)
    ClearPedTasks(cache.ped)
    TriggerServerEvent('prdx_clinic:server:triggersounds', data)
    end, function()
        QBCore.Functions.Notify("Failed!", "error")
    end)

end)

--Trigger Sounds Locally
RegisterNetEvent('prdx_clinic:client:playlocally', function(data)
    CreateThread(function()
        local pos = GetEntityCoords(cache.ped)
        xSound:PlayUrlPos(data.soundName,data.url,data.volume,data.position, data.loopAudio)
        xSound:Distance(data.soundName,data.range)        
        Wait(1000*data.duration)
        xSound:Destroy(data.soundName)
    end)
end)

--Manual Elevators
RegisterNetEvent('prdx_clinic:client:elevator', function(data)
    QBCore.Functions.Progressbar(data.name, data.tooltiptext, 500, false, true, 
    {
        disableMovement = true,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, 
    {}, {}, {}, function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetEntityCoords(PlayerPedId(), data.exitCoords.x, data.exitCoords.y, data.exitCoords.z - 0.50, false)
        SetEntityHeading(PlayerPedId(), data.exitCoords.w)

        Citizen.CreateThread(function()
            local pos = GetEntityCoords(PlayerPedId())
            xSound:PlayUrlPos("ele_ding",Config.Options.soundboardURL .. Config.Options.elevatorSound, Config.Options.elevatorVolume,pos)
            xSound:Distance("ele_ding",5.0)        
            Citizen.Wait(1000*10)
            xSound:Destroy("ele_ding")
        end)        

        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
    end, function()
        QBCore.Functions.Notify("Failed!", "error")
    end)  
end)

--Auto Elevators
RegisterNetEvent('prdx_clinic:client:elevatorpoly', function(data)
    QBCore.Functions.Progressbar(data.name, data.tooltiptext, 1000, false, true, 
    { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, }, 
    {}, {}, {}, function()
        DoScreenFadeOut(1000)
        Wait(1000)
        SetEntityCoords(cache.ped, data.exitCoords.x, data.exitCoords.y, data.exitCoords.z - 0.50, false)
        SetEntityHeading(cache.ped, 70.09)

        CreateThread(function()
            local pos = GetEntityCoords(cache.ped)
            xSound:PlayUrlPos("ele_ding",Config.Options.soundboardURL .. Config.Options.elevatorSound, Config.Options.elevatorVolume,pos)
            xSound:Distance("ele_ding",5.0)        
            Wait(1000*10)
            xSound:Destroy("ele_ding")
        end)        

        Wait(1000)
        DoScreenFadeIn(1000)
    end, function()
        QBCore.Functions.Notify("Failed!", "error")
    end)  
end)

RegisterNetEvent('prdx_clinic:client:SpawnWheelchair', function()
    QBCore.Functions.Progressbar("spawn_wheelchair", "Deploying Wheelchair", 5000, false, true, 
    { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, }, 
    {}, {}, {}, function()   
        local veh = "iak_wheelchair"
        if veh == nil then veh = "iak_wheelchair" end
        local vehiclehash = joaat(veh)
        lib.requestModel(veh)
        local chair = CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(cache.ped)+10, 1, 0)
        local platenum = math.random(111111, 999999)
        SetVehicleNumberPlateText(chair, platenum .. "CHAIR")
        local spawnPos = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 1.0, 0.0)
        SetEntityCoords(chair, spawnPos)
        SetEntityHeading(chair, 250.08)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(chair))
        exports['ps-fuel']:SetFuel(chair, 100.0)
        TriggerServerEvent('prdx_clinic:server:WheelchairSpawned')
    end, function()
        QBCore.Functions.Notify("Failed!", "error")
    end)
end)

RegisterNetEvent('prdx_clinic:client:RemoveWheelchair', function(data)
    QBCore.Functions.Progressbar("delete_wheelchair", "Picking Up Wheelchair", 5000, false, true, 
    { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, }, 
    {}, {}, {}, function()   
        SetEntityAsMissionEntity(data.entity, true, true);
        DeleteVehicle(data.entity)
        TriggerServerEvent('prdx_clinic:server:WheelchairDeleted')
    end, function()
        QBCore.Functions.Notify("Failed!", "error")
    end)
end)

--Auto Elevator Polys
function SetupElevatorPolys()
    exports['polyzonehelper']:AddBoxZone("RightElevator", vector3(342.11, -585.5, 28.80), 3.5, 4.0, {name = "LeftElevator", heading = 250.64, debugPoly = false, minZ = 27.80, maxZ = 29.00 })
    exports['polyzonehelper']:AddBoxZone("LeftElevator", vector3(343.49, -581.8, 28.80), 3.5, 4.0, {name = "RightElevator", heading = 250.64, debugPoly = false, minZ = 27.80, maxZ = 29.00 })
end

local inZone = false
AddEventHandler('polyzonehelper:enter', function(name)
    if inZone == false then
        if LocalPlayer.state["isLoggedIn"] then
            if name == "LeftElevator" then  
               inZone = true   
               elevator = { name = "name", tooltiptext = "Going Up", exitCoords = vector3(332.05, -595.7, 43.28) } 
               TriggerEvent('prdx_clinic:client:elevatorpoly', elevator)
            elseif name == "RightElevator" then
                elevator = { name = "name", tooltiptext = "Going Up", exitCoords = vector3(330.06, -601.26, 43.28) }
                inZone = true
                TriggerEvent('prdx_clinic:client:elevatorpoly', elevator)
            end
        end
    end
end)  

AddEventHandler('polyzonehelper:exit', function(name)
    if inZone == true then
        if LocalPlayer.state["isLoggedIn"] then
            if name == "LeftElevator" then  
               inZone = false      
            elseif name == "RightElevator" then
                inZone = false
            end
        end
    end
end)  