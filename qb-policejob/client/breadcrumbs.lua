local BreadCrumbs = {}
local Blips = {}
local bleedLevel = 0
local isCold = false
local dropCrumb = true
local prevCoords
Config.BreadCrumDelay = 7 * (1000)-- seconds
Config.BreadCrumDelayBleed = 3 * (1000)-- seconds
Config.MaxBreadCrumbs = 30
Config.TrackableMaterials = {
    [909950165] = 'SandWet',
    [2387446527] = 'SandTrack',
    [509508168] = 'SandDryDeep',
    [1288448767] = 'SandWetDeep',
    [2357397706] = 'SnowLoose',
    [3416406407] = 'SnowCompact',
    [1619704960] = 'SnowDeep',
    [1550304810] = 'SnowTarmac',
    [951832588] = 'GravelSmall',
    [2128369009] = 'GravelLarge',
    [3938260814] = 'GravelDeep',
    [1925605558] = 'GravelTrainTrack',
    [2409420175] = 'DirtTrack',
    [2352068586] = 'MudHard',
    [312396330] = 'MudPothole',
    [1635937914] = 'MudSoft',
    [4021477129] = 'MudUnderwater',
    [1109728704] = 'MudDeep',
    [223086562] = 'Marsh',
    [1584636462] = 'MarshDeep',
    [3594309083] = 'Soil',
    [1144315879] = 'ClayHard',
    [560985072] = 'ClaySoft',
    [3833216577] = 'GrassLong',
    [1333033863] = 'Grass',
    [3008270349] = 'GrassShort',
    [2461440131] = 'Hay',
    [581794674] = 'Bushes',
    [3381615457] = 'Twigs',
    [2253637325] = 'Leaves',
    [3985845843] = 'Woodchips',
    [808719444] = 'Foam',
    [5236042] = 'Blood',
    [3660485991] = 'Oil',
    [2660782956] = 'Petrol',
    [1441114862] = 'BushesNoinst',
    [-1885547121] = 'CountIDK',
    [-1942898710] = 'CountIDK',
    [-124769592] = 'CountIDK',
    [-1286696947] = 'CountIDK',

}
Config.PlayerK9Models = {
    [`pd_k9`] = 'German Shepherd',
}

local InvestigateBreadCrumb = {}
local InvestigatePlayerID = nil

function CalcHeading(currentCoords)
    Wait(2000) -- 2 second
    local coords = GetEntityCoords(PlayerPedId())
    local xCalc = currentCoords.x - coords.x
    local yCalc = currentCoords.y - coords.y
    return GetHeadingFromVector_2d(xCalc, yCalc)
end

function CreateHint(currentCoords, recHeading, nextCoords)
    CreateThread(function() -- Thread it so we can do many
        local coords
        local rotCoords
        if nextCoords then
            local retval, groundZ, normalCoords = GetGroundZAndNormalFor_3dCoord(nextCoords.x, nextCoords.y, nextCoords.z, true)
            rotCoords = normalCoords
            coords = vec3(nextCoords.x, nextCoords.y, groundZ)
        else
            local model = GetEntityModel(PlayerPedId())
            if InvestigatePlayerID and not Config.PlayerK9Models[model] then
                local retval, groundZ, normalCoords = GetGroundZAndNormalFor_3dCoord(currentCoords.x, currentCoords.y, currentCoords.z, true)
                rotCoords = normalCoords
                coords = vec3(currentCoords.x, currentCoords.y, groundZ + 0.015)
                QBCore.Functions.Notify('The trails appears to go cold...', 'error', 15000)
            else 
               nextCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(InvestigatePlayerID)))
               coords = vec3(currentCoords.x, currentCoords.y, currentCoords.z + 0.015)
               recHeading = CalcHeading(nextCoords)
               QBCore.Functions.Notify('Suspect nearby...', 'success', 3000)
            end
        end

        local tempObj = CreateObject(`ch_prop_ch_fib_01a`, coords.x, coords.y, coords.z, false, true)
        FreezeEntityPosition(tempObj, true)
        PlaceObjectOnGroundProperly(tempObj)
        Wait(1)
        exports['qb-target']:AddTargetEntity(tempObj, {
            options = {
                {
                    type = "client",
                    event = "police:client:Investigate",
                    icon = "fas fa-question",
                    label = "Investigate",
                    job = {["marshalls"] = {0}, ["lspd"] = {0, 1, 2, 3, 4}, ["bcso"] = {0, 1, 2, 3, 4}, ["sast"] = {0, 1, 2, 3, 4}, ["pd_cid"] = {0, 1, 2, 3, 4}, ["hc"] = {0, 1, 2, 3, 4}},
                },
            },
            distance = 2.5
        })

        SetTimeout(60000, function()
            drawMarker = false
            exports['qb-target']:RemoveZone("BreadCrumb:"..coords.x)
            local entity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.5, `ch_prop_ch_fib_01a`)
            if entity and entity ~= 0 then
                DeleteEntity(entity)
            end
        end)

        drawMarker = true
        while drawMarker do
            Wait(0)
            DrawMarker(26, currentCoords.x, currentCoords.y, currentCoords.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, recHeading, 1.0, 1.0, 1.0, 37, 37, 237, 100, false, false, 2, false, false, false, false)
        end
    end)
end

CreateThread(function()
    local sleep = 1000
    while true do
        ::return_loop::
        Wait(sleep) -- ONLY TO PREVENT A CRASH 
        if not isLoggedIn then 
            isLoggedIn = LocalPlayer.state.isLoggedIn
            prevCoords = currentCoords
            goto return_loop  
        end
        -- Initial Data --
        sleep = 1000 -- Reset to fast sync
        local ped = PlayerPedId()
        local currentCoords = GetEntityCoords(ped)
        local height = GetEntityHeightAboveGround(ped)
        
        if isCold then 
            isCold = false
            if IsPedInAnyVehicle(ped, true) then 
                sleep = 1000
                isCold = true
                prevCoords = currentCoords
                goto return_loop 
            end
            if IsPedSwimming(ped) or IsPedSwimmingUnderWater(ped) then
                sleep = 1000
                isCold = true
                prevCoords = currentCoords
                goto return_loop 
            end
        end

        if #BreadCrumbs >= Config.MaxBreadCrumbs then
            table.remove(BreadCrumbs, 1) -- Remove oldest in table
        end


        -- Checks --
        if height >= 2 then
            sleep = 5000 -- wait 5 seconds and try again 
            goto return_loop -- Not on ground no possible crumb
        end

        if IsPedInAnyVehicle(ped, true) then
            if not isCold then
                isCold = true
                BreadCrumbs[#BreadCrumbs+1] = {
                    crumbType = 'VEHICLE',
                    coords = currentCoords,
                }
            end
            prevCoords = currentCoords
            goto return_loop -- Drop a crumb when we enter the vehicle and then stop dropping 
        end

        if IsPedSwimming(ped) or IsPedSwimmingUnderWater(ped) then
            if not isCold then
                isCold = true
                BreadCrumbs[#BreadCrumbs+1] = {
                    crumbType = 'WATER',
                    coords = currentCoords,
                }
            end
            prevCoords = currentCoords
            goto return_loop -- Drop a crumb when we enter the water and then stop dropping 
        end

        -- Calculate Run Direction (more advanced and makes sure its them actually walking or something)--
    
        if not dropCrumb then
            sleep = 1000
            prevCoords = currentCoords
            goto return_loop -- Save some perf
        end

        if prevCoords and #(prevCoords - currentCoords) <= 20.0 then
            sleep = Config.BreadCrumDelay
            goto return_loop -- Save some perf
        end

        if bleedLevel > 0 then
            if dropCrumb then -- I do it this way so we can detect water edges and shizzz
                dropCrumb = false
                sleep = Config.BreadCrumDelayBleed
                BreadCrumbs[#BreadCrumbs+1] = {
                    crumbType = 'BLOOD',
                    coords = currentCoords,
                    heading = GetEntityHeading(ped),
                }
                SetTimeout(Config.BreadCrumDelayBleed, function() -- drop another crumb in x time (BLOOD TIMER) 
                    dropCrumb = true
                end)
            end
        else
            if dropCrumb then
                local target = GetOffsetFromEntityInWorldCoords(ped, vector3(0, 0, -3))
                local testRay = StartShapeTestRay(currentCoords, target, 17, ped, 7)
                local _, hit, hitLocation, surfaceNormal, material, _ = GetShapeTestResultIncludingMaterial(testRay)
                dropCrumb = false
                sleep = Config.BreadCrumDelay
                BreadCrumbs[#BreadCrumbs+1] = {
                    crumbType = 'NORMAL',
                    coords = currentCoords,
                    heading = GetEntityHeading(ped),
                    trackable = Config.TrackableMaterials[material] or false -- Trackable by not K9
                }
                SetTimeout(Config.BreadCrumDelay, function() -- drop another crumb in x time 
                    dropCrumb = true
                end)   
            end
        end
        prevCoords = currentCoords
        Wait(0) -- Prevent crashes
    end
end)

RegisterNetEvent('hud:client:updateBleed', function(level)
    bleedLevel = level
end)

RegisterNetEvent('police:client:RequestBreadCrumbs', function(requester)
    TriggerServerEvent('police:server:SendBreadCrumbs', BreadCrumbs, requester)
end)

RegisterCommand('testSearch', function(source, args)
    local ped = PlayerPedId()
    local model = GetEntityModel(ped)
    TriggerServerEvent('police:server:SearchAreaBreadCrumbs', Config.PlayerK9Models[model])
end, false)

RegisterNetEvent('police:client:doAreaSearch', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local model = GetEntityModel(ped)
    if not Config.PlayerK9Models[model] then
        TriggerEvent('animations:client:EmoteCommandStart', {"cop3"})
    end
    QBCore.Functions.Progressbar("crumb_investigate", "Searching area...", math.random(2500, 3000), false, true, {
        disableMovement = true, disableCarMovement = true, disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            if CrumbMenu then
                lib.showContext('CrumbMenu')
            else
                local closestCrumb = GetEntityCoords(PlayerPedId())
                local closestDist = 1000.0
                local currentCrumb
                for k,v in pairs(InvestigateBreadCrumb) do
                    local dist = #(closestCrumb - vec3(v.coords.x, v.coords.y, v.coords.z))
                    if dist < closestDist then
                        currentCrumb = k
                        closestDist = dist
                    end
                end
                if currentCrumb then
                    print('USE HEADING AREA')
                    local heading = CalcHeading(InvestigateBreadCrumb[currentCrumb].coords)
                    CreateHint(coords, heading, InvestigateBreadCrumb[currentCrumb].coords)
                end
            end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('police:client:SetInvestigateCrumbs', function(data)
    InvestigateBreadCrumb = data[1]
    InvestigatePlayerID = data[2]
    local closestCrumb = GetEntityCoords(PlayerPedId())
    local closestDist = 1000.0
    local currentCrumb
    for k,v in pairs(InvestigateBreadCrumb) do
        local dist = #(closestCrumb - vec3(v.coords.x, v.coords.y, v.coords.z))
        if dist < closestDist then
            currentCrumb = k
            closestDist = dist
        end
    end
    if currentCrumb then
        local heading = CalcHeading(InvestigateBreadCrumb[currentCrumb].coords)
        CreateHint(closestCrumb, heading, InvestigateBreadCrumb[currentCrumb].coords)
    end
end)

RegisterNetEvent('police:client:GotBreadCrumbs', function(RecBreadCrumbs, HasMany, SingleID)
    if not RecBreadCrumbs then return end
    CrumbMenu = nil
    
    if RecBreadCrumbs and HasMany then
        CrumbMenu = { }
        for k,v in pairs(RecBreadCrumbs) do
            CrumbMenu[#CrumbMenu+1] = {
                header = 'Track ID: '.. v.id + 8550, -- Random number to mask the fact its a server ID

                event = "police:client:SetInvestigateCrumbs",
                args = {v.BreadCrumbs, v.id}
            }
        end
        -- Register Ox-Menu for opening up later
        lib.registerContext({
            id = 'CrumbMenu',
            title = 'Tracking Menu',
            onExit = function() end,
            options = CrumbMenu
        })
    else -- Only 1 person
        InvestigatePlayerID = SingleID
        InvestigateBreadCrumb = RecBreadCrumbs
    end
end)

RegisterNetEvent('police:client:AreaCrumbSearch', function(requester, coords, isK9)
    if requester == GetPlayerServerId(PlayerId()) then return end
    local dist = 30.0
    if isK9 then
        dist = 50.0
    end
    for k,v in ipairs(BreadCrumbs) do
        if #(v.coords - coords) < dist then
            if not v.trackable and isK9 then 
                TriggerServerEvent('police:server:SendAreaBreadCrumbs', BreadCrumbs, requester)
            elseif v.trackable then
                TriggerServerEvent('police:server:SendAreaBreadCrumbs', BreadCrumbs, requester)
            end
            return
        end
    end
end)

RegisterNetEvent('police:client:Investigate', function()
    local currentCrumb = 0 
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local model = GetEntityModel(ped)
    if not Config.PlayerK9Models[model] then
        TriggerEvent('animations:client:EmoteCommandStart', {"cop3"})
    end
    QBCore.Functions.Progressbar("crumb_investigate", "Searching...", math.random(1500, 2000), false, true, {
        disableMovement = true, disableCarMovement = true, disableMouse = false,	disableCombat = true, }, {}, {}, {}, function() -- Done
        for currentCrumb,v in pairs(InvestigateBreadCrumb) do
            if #(vec3(v.coords.x, v.coords.y, v.coords.z) - coords) < 2.5 then
                if InvestigateBreadCrumb[currentCrumb] then
                    if not InvestigateBreadCrumb[currentCrumb].trackable then 
                        if Config.PlayerK9Models[model] then
                            QBCore.Functions.Notify('Sniff sniff sniff...', 'success', 15000)
                            if InvestigateBreadCrumb[currentCrumb+1] then
                                print('HAS NEXT 1')
                                local heading = CalcHeading(InvestigateBreadCrumb[currentCrumb+1].coords)                    
                                CreateHint(InvestigateBreadCrumb[currentCrumb].coords, heading, InvestigateBreadCrumb[currentCrumb+1].coords)
                            else
                                print('USE HEADING 1')
                                CreateHint(InvestigateBreadCrumb[currentCrumb].coords, InvestigateBreadCrumb[currentCrumb].heading)
                            end
                        end
                        return 
                    end -- ONLY K9
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})


                    -- INVESTIGATE --
                    local crumbType = InvestigateBreadCrumb[currentCrumb].crumbType
                    if crumbType == 'NORMAL' then
                        QBCore.Functions.Notify('You found a shoeprint/footprint...', 'success', 15000)
                    elseif crumbType == 'BLOOD' then
                        QBCore.Functions.Notify('You found a dropplet of warm blood...', 'success', 15000)
                    elseif crumbType == 'VEHICLE' then
                        QBCore.Functions.Notify('You notice tire marks...', 'error', 15000)
                    elseif crumbType == 'WATER' then
                        QBCore.Functions.Notify('You found a shoeprint/footprint leading into the water...', 'error', 15000)
                    end
                    
                    if InvestigateBreadCrumb[currentCrumb+1] then
                        print('HAS NEXT 2')
                        local heading = CalcHeading(InvestigateBreadCrumb[currentCrumb+1].coords)                    
                        CreateHint(InvestigateBreadCrumb[currentCrumb].coords, heading, InvestigateBreadCrumb[currentCrumb+1].coords)
                    else
                        print('USE HEADING 2')
                        CreateHint(InvestigateBreadCrumb[currentCrumb].coords, InvestigateBreadCrumb[currentCrumb].heading)
                    end
                end
                return
            end
        end
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)