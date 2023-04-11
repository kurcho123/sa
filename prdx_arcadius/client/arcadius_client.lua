local currentBusiness = 'VACANT!'
QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('prdx_jobs:arcadius:openBusinessDirectory', function(data)
    local CitizenID = QBCore.Functions.GetPlayerData().citizenid
    local menu = {}
    for k, v in pairs(Config.Arcadius.Offices) do
        menu[#menu+1] = {
            title = Config.Arcadius.Offices[k].label, 
            event = "prdx_jobs:arcadius:openBusinessOptions",
            args = k           
        }
    end
    if GetInteriorFromEntity(cache.ped) ~= 0 and GetInteriorFromEntity(cache.ped) ~= 134657 then
        menu[#menu+1] = {
            title = 'Exit Building Front', 
            event = "prdx_jobs:arcadius:leaveBuilding"
        }
        menu[#menu+1] = {
            title = 'Exit Building Parking', 
            event = "prdx_jobs:arcadius:leaveBuildingParking"
        }
    end
    lib.registerContext({
        id = 'business_directory_menu',
        title = 'Business Directory',
        options = menu,
    })
    lib.showContext('business_directory_menu')
end)

AddEventHandler('prdx_jobs:arcadius:openBusinessOptions', function(business)
    local CitizenID = QBCore.Functions.GetPlayerData().citizenid
    local isOwner = false

    for k,v in pairs(Config.Arcadius.Offices) do
        for k2,ownerid in ipairs(Config.Arcadius.Offices[k].keys) do
            if tostring(CitizenID) == tostring(ownerid) then
                isOwner = true
            end
        end
    end
    local menu = {}
    QBCore.Functions.TriggerCallback("prdx_arcadius:server:getLockStatus", function(locked)
        if locked then
            if isOwner then
                menu[#menu+1] = {
                    title = "Unlock Office", 
                    serverEvent = "prdx_arcadius:server:unlockOffice",
                    args = business
                }
            end
            menu[#menu+1] = {
                title = "Office Locked", 
                event = "prdx_jobs:arcadius:openBusinessDirectory"
            }
        else
            if isOwner then
                menu[#menu+1] = {
                    title = "Lock Office", 
                    serverEvent = "prdx_arcadius:server:lockOffice",
                    args = business
                }
            end
            menu[#menu+1] = {
                title = "Visit Office", 
                event = "prdx_jobs:arcadius:visitOffice",   
                args = business
            }
        end
        lib.registerContext({
            id = 'office_menu',
            title = Config.Arcadius.Offices[business].label,
            options = menu,
        })
        lib.showContext('office_menu')
    end, business)
end)

function SetupInterior(ipl) -- Now using Bob74_IPL to setup changes
    -- Getting the object to interact with
	FinanceOffice1 = exports['bob74_ipl']:GetFinanceOffice1Object()
    FinanceOffice1.Style.Clear()
    for k, v in pairs(FinanceOffice1.Style.Theme) do
        if v.ipl == ipl then
            FinanceOffice1.Style.Set(v, true)

            -- Enable chairs in the office
            FinanceOffice1.Chairs.Set(FinanceOffice1.Chairs.on, true)
        
            -- Disabling booze bottles
            FinanceOffice1.Booze.Clear(true)
        
            -- Refresh Interior
            RefreshInterior(FinanceOffice1.currentInteriorId)
            return   
        end
    end
end

AddEventHandler('prdx_jobs:arcadius:visitOffice', function(business)
    if Config.Arcadius.Offices[business] then
        currentBusiness = Config.Arcadius.Offices[business].label
        local Office = Config.Arcadius.Offices[business]
        local Interior = GetInteriorAtCoords(-141.1987, -620.913, 168.8205)
        RequestCollisionAtCoord(-141.1987, -620.913, 167.8205)
        DoScreenFadeOut(800)
        Wait(800)
        TriggerServerEvent('qb-apartments:setBucket', Config.Arcadius.Offices[business].instanceid)
        UnloadOfficeIPL()
        SetPlayerInvincible(cache.playerId, true)
        FreezeEntityPosition(cache.ped, true)
        SetEntityCoords(cache.ped, vector3(-141.22, -621.06, 167.82))
        SetEntityHeading(cache.ped, 284.0)
        SetupInterior(Office.ipl)
        Wait(750)
        SetPlayerInvincible(cache.playerId, false)
        FreezeEntityPosition(cache.ped, false)
        Wait(250)
        DoScreenFadeIn(1000)
    end
end)

AddEventHandler('prdx_jobs:arcadius:leaveBuilding', function()
    RequestCollisionAtCoord(-117.28, -604.45, 36.28)
    DoScreenFadeOut(800)
    Wait(800)
    TriggerServerEvent("qb-apartments:returnBucket")
    UnloadOfficeIPL()
    SetPlayerInvincible(cache.playerId, true)
    FreezeEntityPosition(cache.ped, true)
    SetEntityCoords(cache.ped, vector3(-117.28, -604.45, 36.28))
    SetEntityHeading(cache.ped, 255.24)
    Wait(750)
    SetPlayerInvincible(cache.playerId, false)
    FreezeEntityPosition(cache.ped, false)
    Wait(250)
    DoScreenFadeIn(1000)
end)

AddEventHandler('prdx_jobs:arcadius:leaveBuildingParking', function()
    RequestCollisionAtCoord(vector3(-145.16, -579.42, 32.42))
    DoScreenFadeOut(800)
    Wait(800)
    TriggerServerEvent("qb-apartments:returnBucket")
    UnloadOfficeIPL()
    SetPlayerInvincible(cache.playerId, true)
    FreezeEntityPosition(cache.ped, true)
    SetEntityCoords(cache.ped, vector3(-145.16, -579.42, 32.42))
    SetEntityHeading(cache.ped, 166.31)
    Wait(750)
    SetPlayerInvincible(cache.playerId, false)
    FreezeEntityPosition(cache.ped, false)
    Wait(250)
    DoScreenFadeIn(1000)
end)

function UnloadOfficeIPL()
    local ipls = {
        "ex_dt1_02_office_01a",
        "ex_dt1_02_office_01b",
        "ex_dt1_02_office_01c",
        "ex_dt1_02_office_02a",
        "ex_dt1_02_office_02b",
        "ex_dt1_02_office_02c",
        "ex_dt1_02_office_03a",
        "ex_dt1_02_office_03b",
        "ex_dt1_02_office_03c",
    }
    for k,v in pairs(ipls) do
        RemoveIpl(v)
    end
end

CreateThread(function()
    local scaleform = lib.requestScaleformMovie("ORGANISATION_NAME")
    local sleep = 0
    while true do
        Wait(sleep)
        if #(vector3(-139.21, -631.71, 168.82) - GetEntityCoords(cache.ped)) < 45.0 and currentBusiness ~= nil then
            if scaleform then
                PushScaleformMovieFunction(scaleform, "SET_ORGANISATION_NAME")
                PushScaleformMovieFunctionParameterString(currentBusiness)
                PushScaleformMovieFunctionParameterInt(-1)
                PushScaleformMovieFunctionParameterInt(0)
                PushScaleformMovieFunctionParameterInt(0)
                EndScaleformMovieMethod()
            end
            
            local iVar0 = -2082168399
            if (not IsNamedRendertargetRegistered("prop_ex_office_text")) then
                RegisterNamedRendertarget("prop_ex_office_text", 0)
                LinkNamedRendertarget(iVar0)
                if (not IsNamedRendertargetLinked(iVar0)) then
                    ReleaseNamedRendertarget("prop_ex_office_text")
                end
            end
            local iLocal_186 = GetNamedRendertargetRenderId("prop_ex_office_text")
            SetTextRenderId(iLocal_186)            
            DrawScaleformMovie(scaleform, 0.196*1.75, 0.345*1.5, 0.46*2.5, 0.66*2.5, 255, 255, 255, 255, 1)
            sleep = 0
        else
            SetTextRenderId(GetDefaultScriptRendertargetRenderId())
            sleep = 5000
        end
    end
end)