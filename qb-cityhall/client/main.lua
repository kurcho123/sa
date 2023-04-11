local QBCore = exports['qb-core']:GetCoreObject()
local inCityhallPage = false
local qbCityhall = {}

qbCityhall.Open = function()
    SendNUIMessage({
        action = "open"
    })
    SetNuiFocus(true, true)
    inCityhallPage = true
end

qbCityhall.Close = function()
    SendNUIMessage({
        action = "close"
    })
    SetNuiFocus(false, false)
    inCityhallPage = false
end

DrawText3Ds = function(coords, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(coords.x, coords.y, coords.z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

RegisterNUICallback('close', function()
    SetNuiFocus(false, false)
    inCityhallPage = false
end)

local inRange = false

Citizen.CreateThread(function()
    CityhallBlip = AddBlipForCoord(Config.Cityhall.coords)

    SetBlipSprite (CityhallBlip, 487)
    SetBlipDisplay(CityhallBlip, 4)
    SetBlipScale  (CityhallBlip, 0.5)
    SetBlipAsShortRange(CityhallBlip, true)
    SetBlipColour(CityhallBlip, 0)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("City Services")
    EndTextCommandSetBlipName(CityhallBlip)

    SetupMetalDetectors()
end)

local creatingCompany = false
local currentName = nil
-- Citizen.CreateThread(function()
--     while true do

--         local ped = PlayerPedId()
--         local pos = GetEntityCoords(ped)
--         inRange = false

--         local dist = #(pos - Config.Cityhall.coords)
--         local dist2 = #(pos - Config.DrivingSchool.coords)

--         if dist < 20 then
--             inRange = true
--             DrawMarker(2, Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.2, 155, 152, 234, 155, false, false, false, true, false, false, false)
--             if #(pos - vector3(Config.Cityhall.coords.x, Config.Cityhall.coords.y, Config.Cityhall.coords.z)) < 1.5 then
--                 DrawText3Ds(Config.Cityhall.coords, '~g~E~w~ - City Services Menu')
--                 if IsControlJustPressed(0, 38) then
--                     qbCityhall.Open()
--                 end
--             end
--         end

--         if not inRange then
--             Citizen.Wait(1000)
--         end

--         Citizen.Wait(2)
--     end
-- end)

RegisterNetEvent('qb-cityhall:client:toggleDuty')
AddEventHandler('qb-cityhall:client:toggleDuty', function(data)
    TriggerServerEvent('QBCore:jobs:ToggleDuty', data)
end)

RegisterNetEvent('qb-cityhall:client:getIds')
AddEventHandler('qb-cityhall:client:getIds', function()
    TriggerServerEvent('qb-cityhall:server:getIDs')
end)

RegisterNetEvent('qb-cityhall:client:sendDriverEmail')
AddEventHandler('qb-cityhall:client:sendDriverEmail', function(charinfo)
    SetTimeout(math.random(2500, 4000), function()
        local gender = "Mr"
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = "Mrs"
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = "Township",
            subject = "Driving lessons request",
            message = "Hello " .. gender .. " " .. charinfo.lastname .. ",<br /><br />We have just received a message that someone wants to take driving lessons<br />If you are willing to teach, please contact us:<br />Naam: <strong>".. charinfo.firstname .. " " .. charinfo.lastname .. "</strong><br />Phone Number: <strong>"..charinfo.phone.."</strong><br/><br/>Kind regards,<br />Township Los Santos",
            button = {}
        })
    end)
end)

local idTypes = {
    ["id_card"] = {
        label = "ID Card",
        item = "id_card"
    },
    ["driver_license"] = {
        label = "Drivers License",
        item = "driver_license"
    },
    ["weaponlicense"] = {
        label = "Firearms License",
        item = "weaponlicense"
    }
}

RegisterNUICallback('requestId', function(data)
    if inRange then
        local idType = data.idType

        TriggerServerEvent('qb-cityhall:server:requestId', idTypes[idType])
        QBCore.Functions.Notify('You have recived your '..idTypes[idType].label..' for $50', 'success', 3500)
    else
        QBCore.Functions.Notify('This will not work', 'error')
    end
end)

RegisterNUICallback('requestLicenses', function(data, cb)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local licensesMeta = PlayerData.metadata["licences"]
    local availableLicenses = {}

    for type,_ in pairs(licensesMeta) do
        if licensesMeta[type] then
            local licenseType = nil
            local label = nil

            if type == "driver" then
                licenseType = "driver_license"
                label = "Drivers Licence"
            elseif type == "weapon" then
                licenseType = "weaponlicense"
                label = "Firearms License"
            end

            availableLicenses[#availableLicenses+1] = {
                idType = licenseType,
                label = label
            }
        end
    end
    cb(availableLicenses)
end)

RegisterNUICallback('applyJob', function(data)
    if inRange then
        TriggerServerEvent('qb-cityhall:server:ApplyJob', data.job)
    else
        QBCore.Functions.Notify('Unfortunately will not work ...', 'error')
    end
end)


function SetupMetalDetectors()
    exports['polyzonehelper']:AddBoxZone("CourtMetalDetectorUpstairs", vector3(-559.07, -200.18, 43.37), 4.0, 4.0, {
        name = "CourtMetalDetectorUpstairs",
        heading = 30.28,
        debugPoly = false,
        minZ = 41.80,
        maxZ = 43.95
    })

    exports['polyzonehelper']:AddBoxZone("CourtMetalDetectorDownstairs", vector3(-559.54, -200.47, 38.23), 4.0, 3.0, {
        name = "CourtMetalDetectorDownstairs",
        heading = 30.28,
        debugPoly = false,
        minZ = 37.22,
        maxZ = 39.42
    })

    exports['polyzonehelper']:AddBoxZone("CourtReturnItems", vector3(-547.09, -200.65, 38.23), 3.0, 6.0, {
        name = "CourtReturnItems",
        heading = 30.28,
        debugPoly = false,
        minZ = 37.32,
        maxZ = 38.82
    })
    SpawnGuards()
end

function SpawnGuards()
    exports.ox_target:SpawnPed({
        [1] = { 
          model = 'ig_prolsec_02', 
          coords = vector4(-560.88, -199.87, 38.23, 265.18), 
          minusOne = true, 
          freeze = true, 
          invincible = true, 
          blockevents = true, 
          scenario = 'WORLD_HUMAN_GUARD_STAND', 
        },
        [2] = {
          model = 'ig_prolsec_02', 
          coords = vector4(-560.05, -202.06, 43.37, 357.17), 
          minusOne = true, 
          freeze = true, 
          invincible = true, 
          blockevents = true, 
          scenario = 'WORLD_HUMAN_GUARD_STAND', 
        }
      })
end

local inZone = false
local weaponsRemoved = false
local removedWeapons = {}

AddEventHandler('polyzonehelper:enter', function(name)
    if inZone == false then
        if LocalPlayer.state["isLoggedIn"] then
            if name == "CourtMetalDetectorUpstairs" or name == "CourtMetalDetectorDownstairs" then  
               inZone = true   
               local job = QBCore.Functions.GetPlayerData().job
               if job.name == "lspd" or job.name == "bcso" or job.name == "state" or job.name == "pd_cid" or job.name == "hc" or job.name == "marshalls" then
                    QBCore.Functions.Notify("Your weapons were not removed.", "error") 
                    --TriggerServerEvent("InteractSound_SV:PlayOnSource", "metaldetected", 0.1)
                    --Trigger a guard comment/sfx
                    return
               else       
                    FreezeEntityPosition(GetPlayerPed(-1),  true)
                    --TriggerServerEvent("InteractSound_SV:PlayOnSource", "metaldetected", 0.1) 
                        --Trigger a guard comment      
                    TriggerServerEvent('qb-cityhall:server:removeweapons')    
               end         
            elseif name == "CourtReturnItems" and weaponsRemoved then
                inZone = true
                TriggerServerEvent('qb-cityhall:server:returnweapons', removedWeapons)  
            end
        end
    end
end)  

AddEventHandler('polyzonehelper:exit', function(name)
    if inZone == true then
        if LocalPlayer.state["isLoggedIn"] then
            if name == "CourtMetalDetectorUpstairs" or name == "CourtMetalDetectorDownstairs" then  
                inZone = false            
            elseif name == "CourtReturnItems" then
                inZone = false
            end
        end
    end
end)  

--Remove Items
RegisterNetEvent('qb-cityhall:client:removeweapons', function()
    local ped = PlayerPedId()
    SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
    QBCore.Functions.Notify("You hand your weapons over to security, you can pick them up when you leave.", "error")
    FreezeEntityPosition(GetPlayerPed(-1),  false)
    removedWeapons = data
    weaponsRemoved = true 
end)

--Return Items
RegisterNetEvent('qb-cityhall:client:returnweapons', function()
    weaponsRemoved = false
    QBCore.Functions.Notify("Your weapons have been returned", "success")
end)

-- TODO: Test range & implement target locations
-- local loudSpeakerEnabled = false
-- RegisterNetEvent("qb-cityhall:client:toggleLoudSpeaker", function()
--     if not loudSpeakerEnabled then
--         exports["pma-voice"]:overrideProximityRange(50, true)
--         loudSpeakerEnabled = true
--     else
--         exports["pma-voice"]:clearProximityOverride()
--         loudSpeakerEnabled = false
--     end
-- end)

-- TODO: Setup box zone around judges area

-- exports['polyzonehelper']:AddBoxZone("CourtJudgeArea", vector3(-518.4, -175.52, 38.55), 10.0, 5.0, {
--     name = "CourtJudgeArea",
--     heading = 30.28,
--     debugPoly = false,
--     minZ = 37.32,
--     maxZ = 40.0
-- })

-- AddEventHandler('polyzonehelper:exit', function(name)
--     if LocalPlayer.state["isLoggedIn"] then
--         if name == "CourtJudgeArea" then
--             if loudSpeakerEnabled then  
--                 exports["pma-voice"]:clearProximityOverride()
--                 loudSpeakerEnabled = false
--                 QBCore.Functions.Notify("Turning loud speaker off as you left the vicinity.", "info")
--             end
--         end
--     end
-- end) 