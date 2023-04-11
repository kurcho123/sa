local insideZones = {}

function createDoorZone(coords, heistID, doorID)
    local zone = BoxZone:Create(coords, 35.0, 35.0, {  -- create the zone
        debugPoly = Config.DebugMode,
        name = 'heist-'..heistID,
        heading = Config.Heists[heistID]["doors"][doorID]["heading"].closed,
        minZ = coords.z - 10.0,
        maxZ = coords.z + 10.0
    })

    zone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
            RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
            RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
            if Config.Heists[heistID] and Config.Heists[heistID]["doors"] and Config.Heists[heistID]["doors"][doorID] then -- Depth error checks
                local object = GetClosestObjectOfType(Config.Heists[heistID]["doors"][doorID]["coords"].x, Config.Heists[heistID]["doors"][doorID]["coords"].y, Config.Heists[heistID]["doors"][doorID]["coords"].z, 5.0, Config.Heists[heistID]["doors"][doorID]["object"], false, false, false)
                if not Config.Heists[heistID]["doors"][doorID]["isOpened"] and object ~= 0 then
                    SetEntityHeading(object, Config.Heists[heistID]["doors"][doorID]["heading"].closed)
                elseif object ~= 0 then
                    SetEntityHeading(object, Config.Heists[heistID]["doors"][doorID]["heading"].open)
                end
            end
            insideZones[heistID] = true
            -- CreateThread(function() -- Can be used to run a loop if you are inside the zone
            --     while insideZones[heistID] do
            --         Wait(1000)
            --     end
            -- end)
        else
            ReleaseScriptAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
            ReleaseScriptAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
            ReleaseScriptAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
            insideZones[heistID] = false -- leave the door zone
        end
    end)
end


local function OpenBankDoor(heistID, doorID)
    local DoorCoords = vec3(Config.Heists[heistID]["doors"][doorID]['coords'].x, Config.Heists[heistID]["doors"][doorID]['coords'].y, Config.Heists[heistID]["doors"][doorID]['coords'].z)
    local object = GetClosestObjectOfType(DoorCoords.x, DoorCoords.y, DoorCoords.z, 5.0, Config.Heists[heistID]["doors"][doorID]["object"], false, false, false)
    local timeOut = 10
    local entHeading = GetEntityHeading(object)
    if object ~= 0 then
        CreateThread(function()          
            QBCore.Functions.StartParticleOnEntity("des_vaultdoor", "ent_ray_pro_door_steam", false, object, nil, vec3(0.5, 0.25, 0), vec3(0, 90, 0), 1.0)
            while true do
                if math.abs(entHeading - Config.Heists[heistID]["doors"][doorID]["heading"].open) > 0.5 then
                    if Config.Heists[heistID]["doors"][doorID]["heading"].invserse then
                        SetEntityHeading(object, entHeading + 0.1)
                    else
                        SetEntityHeading(object, entHeading - 0.1)
                    end
                    entHeading = GetEntityHeading(object)
                else
                    break
                end
                Wait(5)
            end
        end)
    end
end

local function TimedDoorOpen(heistID, doorID)
    local VaultWaitMins = Config.Heists[heistID]["doors"][doorID]["wait"] * 60000
    QBCore.Functions.Notify("Door Opening in: "..Config.Heists[heistID]["doors"][doorID]["wait"].." Minutes", 'success', 15000)
    if Config.DebugMode then VaultWaitMins = 5000 end
    SetTimeout(VaultWaitMins, function()
        if Config.Heists[heistID]["doors"][doorID]["isVaultDoor"] then
            OpenBankDoor(heistID, doorID)
        end
        Config.Heists[heistID]["doors"][doorID]["isOpened"] = true
    end)
end 

RegisterNetEvent('prdx_heists:client:UpdateHeistDoor', function(heistID, doorID)
    if Config.Heists[heistID] and Config.Heists[heistID]["doors"] then
        if insideZones[heistID] then
            if Config.Heists[heistID]["doors"][doorID]["wait"] then
                TimedDoorOpen(heistID, doorID)
            else
                Config.Heists[heistID]["doors"][doorID]["isOpened"] = true
            end
        end
    end
end)

RegisterNetEvent('prdx_heists:client:ResetHeistDoors', function(heistID)
    if Config.Heists[heistID] and Config.Heists[heistID]["doors"] then
        for doorID,doordata in ipairs(Config.Heists[heistID]["doors"]) do
            Config.Heists[heistID]["doors"][doorID]["isOpened"] = false
            if insideZones[heistID] then
                Config.Heists[heistID]["doors"][doorID]["isOpened"] = false
                if Config.Heists[heistID]["doors"][doorID]["isVaultDoor"] then
                    local object = GetClosestObjectOfType(Config.Heists[heistID]["doors"][doorID]["coords"]["x"], Config.Heists[heistID]["doors"][doorID]["coords"]["y"], Config.Heists[heistID]["doors"][doorID]["coords"]["z"], 5.0, Config.Heists[heistID]["doors"][doorID]["object"], false, false, false)
                    if not Config.Heists[heistID]["doors"][doorID]["isOpened"] and object ~= 0 then
                        SetEntityHeading(object, Config.Heists[heistID]["doors"][doorID]["heading"].closed)
                    elseif Config.Heists[heistID]["doors"][doorID]["isOpened"] and object ~= 0 then
                        SetEntityHeading(object, Config.Heists[heistID]["doors"][doorID]["heading"].open)
                    end
                end
            end
        end    
    end
end)