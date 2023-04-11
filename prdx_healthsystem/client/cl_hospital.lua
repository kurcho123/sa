HospitalTimer = 0
InHospitalBed = false
holdHospitalTimer = 5
CurrentBed,CurrentHospital = nil,nil

local function GetClosestHospital(coords)
    if exports["qb-prison"]:IsPlayerInsidePrisonZone() then
        return Config.PrisonHospital
    else
        local closestHospital, closestDistance = nil, -1
        for id,data in pairs(Config.Hospitals) do
            local distance = #(coords - data.coords) 
            if closestDistance == -1 or closestDistance > distance then
                closestHospital = id
                closestDistance = distance
            end
        end
        return Config.Hospitals[closestHospital] 
    end
end

function RespawnPlayerAtHospital(hospitalized, DeathEMS)
    local ped = cache.ped
    local coords = GetEntityCoords(ped)
    local hospital = GetClosestHospital(coords)
    -- GLOBAL SETTERS --
    LocalPlayer.state:set("isDead", false, true)
    TriggerServerEvent('prdx_healthsystem:server:syncInjuries', false, PlayerArmor)
    TriggerEvent('prdx_healthsystem:client:syncInjuries', false)
    ---------------------
    if not hospital then hospital = Config.Hospitals['pillbox'] end
    
    DoScreenFadeOut(1200)
    Wait(1300)
    SetEntityVisible(ped, false)
    RevivePlayer(100)
    ResetAllHealthValues()
    ClearPedTasksImmediately(ped)
    SetEntityCoords(ped, hospital.coords)
    SetEntityHeading(ped, hospital.heading)
    SetGameplayCamRelativeHeading(0.0)
    HospitalTimer = 0
    InHospitalBed = false
    DoScreenFadeIn(1200)
    Wait(500)
    FreezeEntityPosition(ped, false)
    SetEntityVisible(ped, true)
    if not hospitalized then
        local alert = lib.alertDialog({
            header = 'You have airlifted to the hospital',
            content = 'Upon airlifting, you must forget everything that caused you to do so. You should have NO knowledge of the events leading up to your demise.\n\nIf you\'re taken to the hospital, or otherwise treated, you may remember what caused your demise.',
            centered = true,
            cancel = false
        })
        TriggerServerEvent('prdx_healthsystem:server:respawnPenalty', DeathEMS)
    elseif CurrentBed then
        TriggerServerEvent('prdx_healthsystem:server:setBedAvailable', CurrentHospital, CurrentBed)
    end
    CurrentHospital = nil
    CurrentBed = nil
end

function PutPlayerInHospitalBed(bedCoords, model, timer, hospital, bedID)
    local ped = cache.ped
    lib.requestAnimDict(Config.HospitalAnimation.dict)
    FreezeEntityPosition(ped, true)
    DoScreenFadeOut(1200)
    Wait(1300)
    RevivePlayer(100)
    ToggleInvincibility(true)-- disable script
    SetEntityCoordsNoOffset(ped, bedCoords.x, bedCoords.y, bedCoords.z + 1.3)
    SetEntityHeading(ped, bedCoords.w)
    SetGameplayCamRelativeHeading(0.0)
    HospitalTimer = tonumber(timer)
    InHospitalBed = true
    CurrentHospital = hospital
    CurrentBed = tonumber(bedID)
    Wait(500)
    ClearPedTasksImmediately(ped)
    TaskPlayAnim(ped, Config.HospitalAnimation.dict, Config.HospitalAnimation.anim, 8.0, 1.0, -1, 1, 0, false, false, false)
    DoScreenFadeIn(1200)
end

RegisterNetEvent('prdx_healthsystem:client:GoToHospital', function(coords, model, timer, hospital, bedID)
    PutPlayerInHospitalBed(coords, model, timer, hospital, bedID)
end)

-- Hospital Loop --
-- Does all the hospital bits --
CreateThread(function()
    while true do
        if InHospitalBed then
            local ped = cache.ped
            if not IsEntityPlayingAnim(ped, Config.HospitalAnimation.dict, Config.HospitalAnimation.anim) then
                TaskPlayAnim(ped, Config.HospitalAnimation.dict, Config.HospitalAnimation.anim, 8.0, 1.0, -1, 1, 0, false, false, false)
            end
            if HospitalTimer > 0 then
                HospitalTimer -= 1
                drawTxt("YOU ARE CURRENTLY HEALING ~n~~r~" .. math.ceil(HospitalTimer) .. "~w~ SECONDS REMAINING")
                if IsPedDeadOrDying(ped) then
                    local pos = GetEntityCoords(ped, true)
                    NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(ped), true, false)
                end
            else
                drawTxt("~g~YOU ARE FULLY HEALED ~n~~w~ HOLD ~r~[E] ("..holdHospitalTimer..")~w~ TO CHECK OUT")
                if IsControlPressed(0, 38) and holdHospitalTimer <= 1 then
                    RespawnPlayerAtHospital(true)
                elseif IsControlPressed(0, 38) then
                    holdHospitalTimer -= 1
                else
                    holdHospitalTimer = 5
                end
            end     
        end
        Wait(1000)   
    end
end)