QBCore = exports['qb-core']:GetCoreObject()

local jobStreet, trailer, truckingTrailerMarker, truckingSelectionMarker, doTimeout, jobBlip = nil
local TrailerNet = nil
local coords, jobLocation, trailerSpawnPoint = vec3(0, 0, 0), vec3(0, 0, 0), vec3(0, 0, 0)
local jobSelectionLoc = Config.Trucking.jobSelectionLoc
local playerPed = PlayerPedId()
local inSelectionMarker, inCancelMarker, isTrailerAttached, deliveryCompleted = false
local cancelJobLoc = Config.Trucking.cancelJobLoc
local jobLocations = {}
local generatedJobs = {}

-- main thread
CreateThread(function()
    while true do
        Citizen.Wait(0)
        if jobSelected then -- run when the player has a current delivery active
            if NetworkDoesEntityExistWithNetworkId(TrailerNet) then -- check if trailer exists
                trailerLocation, trailerHeading, trailerWheelLoc = GetEntityCoords(trailer), GetEntityHeading(trailer), GetWorldPositionOfEntityBone(trailer, GetEntityBoneIndexByName(trailer, "wheel_lr")) -- trailer properties
                isTrailerAttached = IsVehicleAttachedToTrailer(GetVehiclePedIsIn(PlayerPedId(), false))
                local retval, z = GetGroundZFor_3dCoord(trailerLocation.x, trailerLocation.y, trailerLocation.z, true)
                if not isTrailerAttached and deliveryCompleted ~= true then
                    truckingTrailerMarker = DrawMarker(7, vec3(trailerLocation.xy, z +0.05), 0, 0, 0, 0, 0, trailerHeading, 5.0, 15.0, 0.25, 0, 255, 255, 100, false, false)
                end
                jobLocation, jobHeading = jobSelected.location, jobSelected.location.w
                if deliveryCompleted ~= true then
                    if #(jobLocation.xyz - vector3(trailerLocation.xy, trailerWheelLoc.z)) < 1 and math.abs(jobHeading - trailerHeading) < 3 then
                        truckingDeliveryMarker = DrawMarker(7, jobSelected.location.xy, jobSelected.location.z - 0.95, 0, 0, 0, 0, 0, jobSelected.location.w, 5.0, 15.0, 0.25, 57, 255, 20, 50, false, false)
                        inJobDeliveryMarker = true
                    else
                        truckingDeliveryMarker = DrawMarker(7, jobSelected.location.xy, jobSelected.location.z - 0.95, 0, 0, 0, 0, 0, jobSelected.location.w, 5.0, 15.0, 0.25, 255, 255, 255, 50, false, false)
                        inJobDeliveryMarker = false
                    end
                end
            else
                if trailer then 
                    TrailerNet = VehToNet(trailer)
                    return
                end
            end
        end
        if inJobDeliveryMarker and deliveryCompleted ~= true then
            if jobSelected then
                if isTrailerAttached then
                    showHelpText("Press ~INPUT_CONTEXT~ to deliver the ~y~" .. jobSelected.cargo .. " ~w~and earn ~g~$" .. jobSelected.payout)
                    if IsControlJustPressed(0, 38) then -- E
                        if trailer ~= nil then
                            DetachVehicleFromTrailer(GetVehiclePedIsIn(PlayerPedId(), false))
                            SetVehicleAutomaticallyAttaches(trailer, false, nil)
                            doTimeout = true
                        end
                        RemoveBlip(jobBlip)
                        QBCore.Functions.Notify("Return to the depot to return your truck, complete the delivery and receive your payment.", "inform", 5000)
                        deliveryCompleted = true
                    end
                else
                    showHelpText("The trailer is required to make the delivery")
                end
            end
        end
    end
end)

CreateThread(function()
    local timeout = 0
    while true do
        Wait(1000)
        if doTimeout then
            if NetworkDoesEntityExistWithNetworkId(TrailerNet) then
                if not IsEntityAttachedToAnyVehicle(trailer) then
                    if timeout < 30 then
                        if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(trailer)) > 100 then
                            timeout = 30
                        else
                            timeout = timeout + 1
                        end
                    else
                        if jobSelected ~= nil and deliveryCompleted ~= true then
                            StopWorking(false)
                        else
                            DetachVehicleFromTrailer(GetVehiclePedIsIn(PlayerPedId(), false))
                            TriggerServerEvent("QBCore:Game:Delete", TrailerNet)
                            trailer = nil
                            TrailerNet = nil
                        end
                        timeout = 0
                        doTimeout = false
                    end
                else
                    timeout = 0
                    doTimeout = false
                end
            else
                if jobSelected and deliveryCompleted ~= true then
                    StopWorking(false)
                    timeout = 0
                    doTimeout = false
                end
            end
        end
    end
end)

CreateThread(function()
    blip = AddBlipForCoord(Config.Trucking.depotLocation)
    SetBlipSprite(blip, 477)
    SetBlipDisplay(blip, 2)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.5)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("PUBLIC JOB: Trucking Depot")
    EndTextCommandSetBlipName(blip)
end)

-- find available trailer spawn, spawn trailer if possible and set route
function StartJob()
    if jobSelected ~= nil then
        local spawnPointsA = Config.Trucking.truckSpawns
	    local foundA, foundSpawnPointA = false, nil
        for i=1, #spawnPointsA, 1 do
            if QBCore.Functions.IsSpawnPointClear(spawnPointsA[i], 5) then
                foundA, foundSpawnPointA = true, spawnPointsA[i]
                break
            end
        end 
        local spawnPointsB = Config.Trucking.trailerSpawns
	    local foundB, foundSpawnPointB = false, nil
        for i=1, #spawnPointsB, 1 do
            if QBCore.Functions.IsSpawnPointClear(spawnPointsB[i], 5) then
                foundB, foundSpawnPointB = true, spawnPointsB[i]
                break
            end
        end
        if foundA and foundB then
            QBCore.Functions.SpawnVehicle('hauler', function(veh)
                truck = veh
                TaskWarpPedIntoVehicle(PlayerPedId(), truck, -1)
                exports['ps-fuel']:SetFuel(truck, 100.0)
                TriggerEvent("vehiclekeys:client:SetOwner")
            end, foundSpawnPointA, true)
            QBCore.Functions.SpawnVehicle(jobSelected.trailer, function(returntrailer)
                trailer = returntrailer
                TrailerNet = NetworkGetNetworkIdFromEntity(trailer)
            end, foundSpawnPointB, true)
            trailerSpawnPoint = foundSpawnPointB
            jobBlip = AddBlipForCoord(jobSelected.location)
            SetBlipRoute(jobBlip, true)
            QBCore.Functions.TriggerCallback("prdx_skills:getCurrentLevel", function(level)
                local currentLevel = level.currentLevel
                QBCore.Functions.Notify("Deliver " .. jobSelected.cargo .. " to " .. jobSelected.street .. " to earn $" .. (jobSelected.payout), "inform")
                Wait(2000)
                doTimeout = true   
            end, "trucking")
            for k,v in pairs(generatedJobs) do
                if k == jobSelected.id then
                    generatedJobs[k] = nil
                end
            end
        else
            QBCore.Functions.Notify("The depot is currently full, please move existing trucks/trailers or try again later", 'error')
            jobSelected = nil
        end
    end
end

-- clean up variables and return to default state
function StopWorking(success)
    inJobDeliveryMarker = false
    if success then
        QBCore.Functions.Notify("You successfully completed the delivery!", 'success')
        if truck ~= nil then
            DeleteEntity(truck)
            truck = nil
        end
    else
        QBCore.Functions.Notify("You failed to complete the delivery! Return to the depot if you wish to select a new delivery.", 'error')
        if trailer ~= nil then
            doTimeout = false
            DetachVehicleFromTrailer(GetVehiclePedIsIn(PlayerPedId(), false))
            DeleteEntity(trailer)
            trailer = nil
            TrailerNet = nil
        end
        if truck ~= nil then
            DeleteEntity(truck)
            truck = nil
        end
    end
    jobSelected = nil
    deliveryCompleted = false
    RemoveBlip(jobBlip)
end

RegisterNUICallback('selectJob', function(data, cb)
    local jobId = tonumber(data.job_id)
    local jobDistance = tonumber(data.job_distance)
    for k,v in pairs(generatedJobs) do
        if k == jobId then
            jobSelected = v
            jobSelected.id = jobId
        end
    end
    StartJob()
    cb('ok')
end)

RegisterNetEvent("prdx_trucking:openMenu", function()
    if jobSelected then
        QBCore.Functions.Notify("You already have a route selected, cancel or complete the route first!", "error")
    else
        JobSelectMenu()
    end
end)

RegisterNetEvent("prdx_trucking:cancelRoute", function()
    if jobSelected then
        RemoveBlip(jobBlip)
        StopWorking(false)
    else
        QBCore.Functions.Notify("You do not have an active route to cancel!", "error")
    end
end)

RegisterNetEvent("prdx_trucking:completeRoute", function()
    if jobSelected and deliveryCompleted then
        if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(truck)) < 15.0 then
            TriggerServerEvent("prdx_trucking:completeDelivery", jobSelected, GetVehicleBodyHealth(truck))
            StopWorking(true)
            deliveryCompleted = false
            jobSelected = nil
        else
            QBCore.Functions.Notify("Your truck must be at the depot to complete the delivery", "error")
        end
    else
        QBCore.Functions.Notify("You have not completed a delivery yet!", "error")
    end
end)

function showHelpText(s)
	SetTextComponentFormat("STRING")
	AddTextComponentString(s)
	EndTextCommandDisplayHelp(0,0,0,-1)
end

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false,false)
	SendNUIMessage({ hidemenu = true })
end)

CreateThread(function()
    while true do
        Wait(600000)
        GenerateJobs()
    end
end)

function GenerateJobs()
    math.randomseed(GetGameTimer())
    generatedJobs = {}
    local randNum = nil
    for i = 0, 3, 1 do -- Pick 4 random jobs to display
        repeat
            randNum = math.random(#Config.Trucking.jobs)
        until (generatedJobs[randNum] == nil)
        generatedJobs[randNum] = Config.Trucking.jobs[randNum]
        local jobStreet = GetStreetNameFromHashKey(GetStreetNameAtCoord(Config.Trucking.jobs[randNum].location.x, Config.Trucking.jobs[randNum].location.y, Config.Trucking.jobs[randNum].location.z))
        generatedJobs[randNum].street = jobStreet
        local jobDistance = CalculateTravelDistanceBetweenPoints(GetEntityCoords(PlayerPedId()), Config.Trucking.jobs[randNum].location.xyz)
        if jobDistance >= 100000 then
            generatedJobs[randNum].distance = math.floor(#(GetEntityCoords(PlayerPedId()) - Config.Trucking.jobs[randNum].location.xyz) * 0.00062137)
        else
            generatedJobs[randNum].distance = math.floor(jobDistance / 1609) .. "-" .. math.floor(jobDistance / 1609) + 1
        end
        generatedJobs[randNum].id = randNum
    end
end

function JobSelectMenu()
    if not next(generatedJobs) then
        GenerateJobs()
    end
    SetNuiFocus(true,true)
    SendNUIMessage({ 
        showmenu = true,
        data = generatedJobs
    })
end