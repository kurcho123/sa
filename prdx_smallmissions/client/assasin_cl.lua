local SpawnedPeds = {}
local MissionStarted = false
local PoliceCalled = false
local TargetGender = nil
local MissionID = nil
local targetData = {}
local TargetPed = nil
local blip1 = nil
local blip2 = nil

local function PoliceCall()
    math.randomseed(GetGameTimer())
    local Random = math.random(1, 100)
    if Random <= 85 and not PoliceCalled then
        PoliceCalled = true
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {'lspd', 'bcso', 'sast', 'marshalls', 'hc', 'pd_cid'}, --{'police', 'sheriff} 
            coords = data.coords,
            title = '10-17 - Suspicious Person',
            message = 'A suspicious '..data.sex..' was reported at '..data.street, 
            flash = 0, 
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 66, 
                scale = 1.2, 
                colour = 5,
                flashes = false, 
                text = '10-17 - Suspicious Person',
                sound = 1,
            }
        }) 
    end
end

function SetupBlip(location)
    blip1 = AddBlipForRadius(location, 100.0)
    SetBlipColour(blip1, 1)
    SetBlipAlpha(blip1, 128)
    blip2 = AddBlipForCoord(location)
    SetBlipAsShortRange(blip2, true)
    SetBlipSprite(blip2, 303)
    SetBlipColour(blip2, 1)
    SetBlipScale(blip2, 0.5)
    SetBlipDisplay(blip2, 6)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Target area")
    EndTextCommandSetBlipName(blip2)
end

RegisterNetEvent('prdx_smallmissions:takeAssasinMission')
AddEventHandler('prdx_smallmissions:takeAssasinMission', function(data)
    print("START MISSION")
    math.randomseed(GetGameTimer())
    MissionID = math.random(1, #Config.AssasinTargets)
    targetData = Config.AssasinTargets[MissionID]
    PoliceCalled = false
    if targetData then
        local model
        local gender = math.random(0,1)
        if gender == 1 then
            TargetGender = 'Male'
        else
            TargetGender = 'Female'
        end
        QBCore.Functions.Notify('Target is a '..TargetGender..' | They should be on their phone in the area')
        SetupBlip(vector3(targetData.coords.x, targetData.coords.y, targetData.coords.z))
        exports['polyzonehelper']:AddBoxZone("AssasinSpawnZone", vector3(targetData.coords.x, targetData.coords.y, targetData.coords.z), 150.0, 150.0, {
            name = "AssasinSpawnZone",
            heading = 0.00,
            debugPoly = false,
        }) 
        exports['polyzonehelper']:AddBoxZone("AssasinCloseZone", vector3(targetData.coords.x, targetData.coords.y, targetData.coords.z), 50.0, 50.0, {
            name = "AssasinSpawnZone",
            heading = 0.00,
            debugPoly = false,
        }) 
    end
end)

RegisterNetEvent('prdx_smallmissions:client:AssasinHarvest', function(data)
    PoliceCall()
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
    QBCore.Functions.Progressbar("cut_finger", "Cutting out eye...", math.random(15000,20000), false, true, {disableMovement = true,	disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function() -- Done
        TriggerServerEvent('prdx_smallmissions:client:AssasinReward', MissionID, TargetGender)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        SetPedAsNoLongerNeeded(data.entity)
        RemoveBlip(blip1)
        RemoveBlip(blip2)
        blip1 = nil
        blip2 = nil
        TargetPed = nil
        PoliceCalled = false
        TargetGender = nil
        SpawnedPeds = {}
        exports['qb-target']:RemoveTargetEntity(data.entity)
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)        
end)

RegisterNetEvent('prdx_smallmissions:client:missionCleanup', function()
    exports['polyzonehelper']:DeletePolyZone("AssasinSpawnZone")
    exports['polyzonehelper']:DeletePolyZone("AssasinCloseZone")  
    MissionStarted = false
    MissionID = nil
    targetData = {}
    RemoveBlip(blip1)
    RemoveBlip(blip2)
    blip1 = nil
    blip2 = nil
    TargetPed = nil
    PoliceCalled = false
    TargetGender = nil
    for k,v in pairs(SpawnedPeds) do
        QBCore.Functions.DeleteEntity(v)
        v = nil
    end
end)

AddEventHandler('polyzonehelper:enter', function(name)
    if LocalPlayer.state["isLoggedIn"] then
        if name == "AssasinSpawnZone" and not MissionStarted then
            print('SPAWN PEDS')
            MissionStarted = true
            math.randomseed(GetGameTimer())
            if TargetGender == 'Male' then
                local random = math.random(1, #Config.MalePeds)
                model = Config.MalePeds[random]
            else
                local random = math.random(1, #Config.FemalePeds)
                model = Config.FemalePeds[random]
            end
            QBCore.Functions.SpawnPed(model, function(returnPed)
                TargetPed = returnPed
                exports['polyzonehelper']:DeletePolyZone("AssasinSpawnZone") 
                SetEntityHeading(returnPed, targetData.coords.w)
                Wait(1)
                TaskStartScenarioInPlace(returnPed, targetData.scenario)
                SetRagdollBlockingFlags(returnPed, 3)
                SetPedSuffersCriticalHits(returnPed, false)
                SetPedMaxHealth(returnPed, 300.0)
                SetPedArmour(returnPed, 200)
                SetPedRelationshipGroupHash(returnPed, `COP`)
                GiveWeaponToPed(returnPed, `weapon_combatpistol`, 200, true, false)
                SetPedDropsWeaponsWhenDead(returnPed, false)
                --
                SetPedCombatMovement(returnPed, 1)
                SetPedCombatAttributes(returnPed, 1, true)
                SetPedCombatAbility(returnPed, 2)
                table.insert(SpawnedPeds, returnPed)
                exports['qb-target']:AddTargetEntity(returnPed, {
                    options = {
                        {
                            type = "client",
                            event = "prdx_smallmissions:client:AssasinHarvest",
                            icon = "fas fa-skull",
                            label = "Cut out eye",
                            canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                                if IsPedDeadOrDying(entity) then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
                                return false
                            end,
                        },
                    },
                    distance = 1.5
                })
            end, vec3(targetData.coords.x, targetData.coords.y, targetData.coords.z), true)
        elseif name == "AssasinCloseZone" and MissionStarted then
            exports['polyzonehelper']:DeletePolyZone("AssasinCloseZone") 
            if not IsPedDeadOrDying(TargetPed) then
                PoliceCall()
                QBCore.Functions.TakeControl(TargetPed)
                ClearPedTasksImmediately(TargetPed)
                local flee = math.random(0,1)
                if flee == 1 then
                    TaskSmartFleePed(TargetPed, PlayerPedId(), 250.0, -1)
                else
                    TaskCombatPed(TargetPed, PlayerPedId(), 0, 16)
                end
            end
        end  
    end
end)