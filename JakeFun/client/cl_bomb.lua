local Colors = {'Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Purple', 'Cyan', 'Magenta'}
QBCore = exports['qb-core']:GetCoreObject()
local BombModel = `ch_prop_ch_explosive_01a`
local DirtyBombModel = `prop_sh_mr_rasp_01`
local Bombs = {}
local CarBombs = {}
local SpeedWarning = 0
local WaterWarning = 0
local DamageCoords
local DamageLoop = false
local GasMask = false
local inVehicle = false
PlayerData = {}
isLoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Player:SetPlayerData')
AddEventHandler('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

-- TEST

--- Get around a vector for spread  (Credits: Albo1125) ---
function GetAround(vec, MinDistance, MaxDistance)
    local Around = Around(vec, NextDouble(MinDistance, MaxDistance))
    return Around
end

--- Get a random float and make sure its in the proper params (Credits: Albo1125) ---
function NextDouble(MinDistance, MaxDistance)
    return GetRandomFloatInRange(0.0, 1.0) * (MaxDistance - MinDistance) + MinDistance
end

--- Get a random direction (Credits: Albo1125) ---
function RandomXY()
    local x = GetRandomFloatInRange(0.0, 1.0) - 0.5
    local y = GetRandomFloatInRange(0.0, 1.0) - 0.5
    local z = 0.0
    return vec3(x,y,z)
end

--- Complete the vector for spread (Credits: Albo1125) ---
function Around(vec, radius)
    local direction = RandomXY() 
    local RetVec = vec + (direction * radius)
    return RetVec
end

AddEventHandler('JakeFun:bomb:openWireMenu', function(data)
    local netid = NetworkGetNetworkIdFromEntity(data.entity)
    QBCore.Functions.TriggerCallback("JakeFun:bomb:getBombData", function(Bomb) 
        TriggerEvent('animations:client:EmoteCommandStart', {"kneel"})
        local menu = {
            {
                title = "WARNING:", 
                description = "This may kill you!", 
                disabled = true
            }
        }
        for i=1, Bomb.wires do
            menu[#menu+1] = {
                title = Colors[i].." Wire",
                event = "JakeFun:bomb:cutWire",
                args = {Colors[i] , netid}
            }   
        end
        lib.registerContext({
            id = 'bomb_menu',
            title = 'BOMB',
            options = menu,
        })
        lib.showContext('bomb_menu')
    end, netid)
end)

AddEventHandler('JakeFun:bomb:cutWire', function(sentargs)
    local color = sentargs[1]
    local bombid = sentargs[2]
    local menu = {
        {
            title = "YES", 
            event = "JakeFun:bomb:doWireCut",
            args = sentargs         
        },
        {
            title = "NO",
            event = "JakeFun:bomb:openWireMenu",
            args = {entity = bombid}
        }
    }
    lib.registerContext({
        id = 'bomb_wire_menu',
        title = 'CUT '..string.upper(color)..' WIRE?',
        options = menu,
    })
    lib.showContext('bomb_wire_menu')
end)

AddEventHandler('JakeFun:bomb:doWireCut', function(sentargs)
    local color = sentargs[1]
    local bombid = sentargs[2]
    TriggerEvent('animations:client:EmoteCommandStart', {"picklock"})
    QBCore.Functions.Progressbar("cut-wire", "Cutting Wire", math.random(4000,9000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        }, {}, {}, {}, 
    function() -- Done
        TriggerServerEvent('JakeFun:bomb:wireCut', color, bombid)
    end, function() -- Cancel
        QBCore.Functions.Notify('Cutting Canceled', 'error')
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('JakeFun:bomb:bombExplode', function(coords)
	AddExplosion(coords.x, coords.y, coords.z+0.1, 47, 500.0, false, false, 0)
	Wait(1)
	AddExplosion(coords.x, coords.y, coords.z+0.1, 49, 500.0, false, false, 0)
    Wait(1)
    AddExplosion(coords.x, coords.y, coords.z+0.1, 37, 500.0, true, false, 1)
end)

RegisterNetEvent('JakeFun:bomb:dirtybombExplode', function(coords)
    local timer = 5 * (60000)
    AddExplosion(coords.x, coords.y, coords.z, 48, 50.0, true, false, 1)
    Wait(1)
    for i=1, 5, 1 do
        local tempcoords = GetAround(coords, 0, 50.0)
        local ground, groundz = GetGroundZFor_3dCoord(tempcoords.x, tempcoords.y, tempcoords.z, 0)
        local expcoords = vec3(tempcoords.x, tempcoords.y, groundz + 0.3)
        if groundz > 1.0 then
            TriggerEvent("QBCore:Client:SyncPTFX", "cut_jewelheist", "scr_jewel_haze", true, expcoords, vec3(0.0, 0.0, 0.0), 3.0, nil, nil, timer + 5000)
            Wait(50)
        end
    end
    DamageCoords = coords
    DamageLoop = true
    SetTimeout(timer, function()
        DamageLoop = false
    end)
end)


RegisterNetEvent('JakeFun:bomb:syncBombData', function(BombData, CarBombData)
    Sync = true
    Bombs = BombData
    CarBombs = CarBombData
end)

RegisterNetEvent('JakeFun:bomb:doBombCreate', function(dirty)
    TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"})
    QBCore.Functions.Progressbar("place-bomb", "Activating Bomb", math.random(4000,9000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
        }, {}, {}, {}, 
    function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
        local dialog = lib.inputDialog("Configure Explosive",{
            { type = "number", label = "Time (Minutes)"},
            { type = 'select', label = 'Wires (Number of wires)', options = {
                { value = '1', label = '1' },
                { value = '2', label = '2' },
                { value = '3', label = '3' },
                { value = '4', label = '4' },
                { value = '5', label = '5' },
                { value = '6', label = '6' },
                { value = '7', label = '7' },
                { value = '8', label = '8' },
            }},
            { type = 'select', label = 'Difficulty', options = {
                { value = '1', label = 'Easy' },
                { value = '2', label = 'Medium' },
                { value = '3', label = 'Hard' },
            }},
        })
        
        if not dialog then return end

        local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
        local model
        if dirty then model = DirtyBombModel else model = BombModel end
        QBCore.Functions.SpawnObject(model, function(bomb)
            local netid = NetworkGetNetworkIdFromEntity(bomb)
            PlaceObjectOnGroundProperly(bomb)
            SetEntityHeading(GetEntityHeading(PlayerPedId()))
            FreezeEntityPosition(bomb, true)
            while not NetworkGetEntityIsNetworked(bomb) do
                Wait(10)
                NetworkRegisterEntityAsNetworked(bomb)
            end
            QBCore.Functions.SetStateBag(bomb, 'isBomb', true)
            TriggerServerEvent('JakeFun:bomb:bombCreated', dialog[1], dialog[2], dialog[3], netid, GetNetworkTimeAccurate(), dirty)
        end, spawnCoords, true) 
    end, function() -- Cancel
        QBCore.Functions.Notify('Placing Canceled', 'error')
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(Player)
    QBCore.Functions.TriggerCallback("JakeFun:bomb:getAllBombs", function(BombData) 
        Bombs = BombData
    end)
    QBCore.Functions.TriggerCallback("JakeFun:bomb:getAllCarBombs", function(CarBombData) 
        CarBombs = CarBombData
    end)
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
	while true do
        Wait(0)
        if DamageLoop and isLoggedIn then
            local pos = GetEntityCoords(PlayerPedId())
            local inRange = false  
            local distance = #(pos - DamageCoords)
            if distance < 25.0 then
                if not PlayerData.metadata["isdead"] and not LocalPlayer.state['GasMask'] then
                    ApplyDamageToPed(PlayerPedId(), 5, false)
                end
                Wait(500)
            end
        else 
            Wait(5000)
        end
    end
end)

CreateThread(function()
	while true do
		local pos = GetEntityCoords(PlayerPedId())
		local inRange = false
        if Sync then
            Wait(500)
            Sync = false
        end
        for k,v in pairs(Bombs) do
            local distance = #(pos - v.coords)
            if distance < 10 then
                inRange = true
                if distance < 3.0 then
                    local time = (v.endTime - GetNetworkTimeAccurate()) / 1000
                    if time > 60 then
                        local minutes = math.floor(time/60)
                        local seconds = math.floor(time - (minutes * 60))
                        if seconds < 10 then
                            DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.5, 'Timer: '..minutes..':0'..seconds)
                        else
                            DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.5, 'Timer: '..minutes..':'..seconds)
                        end
                    else
                        local seconds = math.floor(time)
                        DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 0.5, 'Timer: 00:'..seconds)
                    end
                end
            end
            if not inRange then
                Wait(1000)
            end 
        end
		Wait(0)
	end
end)

RegisterNetEvent('QBCore:drivingVehicle', function(isDriving, currentVehicle)
    if inVehicle then return end
    if not isDriving then return end
    Wait(10000)
    if cache.seat and cache.seat == -1 then
        for k,v in pairs(CarBombs) do
            if v.planter ~= GetPlayerServerId(PlayerId()) then
                if tostring(QBCore.Functions.GetPlate(cache.vehicle)) == v.plate then
                    TriggerServerEvent('JakeFun:server:ActivateCarBomb', v.plate)
                    CarBombs[k] = nil
                    Wait(2500)
                end
            end
        end 
    end
end)

RegisterNetEvent('QBCore:leftVehicle', function ()
	inVehicle = false
end)

RegisterNetEvent('JakeFun:client:explodeCar', function(netid)
	local veh = NetToVeh(netid)
    if veh > 0 then
        NetworkExplodeVehicle(veh, true, false, 0)
        ExplodeVehicle(veh, true, false)
    end
end)

RegisterNetEvent('JakeFun:client:doCarBombCreate', function()
    local veh = lib.getClosestVehicle(GetEntityCoords(cache.ped), 5, true)
    if veh and veh ~= 0 then
        QBCore.Functions.Progressbar("place-bomb", "Activating Bomb", math.random(4000,9000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
            }, {}, {}, {}, 
        function() -- Done
            local plate = QBCore.Functions.GetPlate(veh)
            TriggerServerEvent('JakeFun:bomb:CarBombCreated', plate)
            TriggerServerEvent("JakeFun:bomb:removeCarBomb")
            QBCore.Functions.Notify('Bomb planted: '..plate, 'success')
        end, function() -- Cancel
            QBCore.Functions.Notify('Placing Canceled', 'error')
        end)
    end
end)

RegisterNetEvent('JakeFun:client:ActivatedCarBomb', function()
    local ped = cache.ped
    local vehicle = cache.vehicle
    WaterWarning = 0
    SpeedWarning = 0
    Wait(5000)
    while (GetEntitySpeed(vehicle) * 2.236936) <= 50 do
        Wait(0)
    end
    BombActive = true
    SetTimeout(15 * 60000, function()
        if BombActive then
            BombActive = false        
            QBCore.Functions.Notify('Bomb de-activated', 'success', 30000) 
        end
    end)

    PlaySoundFromEntity(-1, "IDLE_BEEP", vehicle, "EPSILONISM_04_SOUNDSET", false)
    QBCore.Functions.Notify('The car is rigged with explosives | Go below 60 mph and you die | Try and get out and you die', 'error', 25000)
    QBCore.Functions.Notify('You hear over the car radio in a robotic voice:', 'error', 25000)
    CreateThread(function ()
        while BombActive do
            Wait(0)
            if not cache.vehicle then
                TriggerServerEvent('JakeFun:server:explodeCarBomb', VehToNet(vehicle))
                BombActive = false
            end
        end
    end)
    CreateThread(function ()
        while BombActive do
            Wait(0)
            if (GetEntitySpeed(vehicle) * 2.236936 <= 60) then
                SpeedWarning = SpeedWarning + 1
                PlaySoundFromEntity(-1, "IDLE_BEEP", vehicle, "EPSILONISM_04_SOUNDSET", false)
                QBCore.Functions.Notify('WARNING SPEED LOW!', 'error', 2000)
                Wait(2000)
                if (GetEntitySpeed(vehicle) * 2.236936 >= 60) then
                    SpeedWarning = SpeedWarning - 1
                end
            end

            if GetEntitySubmergedLevel(vehicle) >= 0.50 then
                WaterWarning = WaterWarning + 1
                PlaySoundFromEntity(-1, "IDLE_BEEP", vehicle, "EPSILONISM_04_SOUNDSET", false)
                QBCore.Functions.Notify('WARNING WATER DETECTED!', 'error', 2000)
                Wait(500)
                if GetEntitySubmergedLevel(vehicle) <= 0.50 then
                    WaterWarning = WaterWarning - 1
                end
            end

            if not IsVehicleDriveable(vehicle, false) then
                TriggerServerEvent('JakeFun:server:explodeCarBomb', VehToNet(vehicle))
                BombActive = false
            end

            if WaterWarning >= 5 or SpeedWarning >= 5 then
                TriggerServerEvent('JakeFun:server:explodeCarBomb', VehToNet(vehicle))
                BombActive = false
            end

        end
    end)
end)

-- This is here to get the player data when the resource is restarted instead of having to log out and back in each time
-- This won't set the player data too early as this only triggers when the server side is started and not the client side
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerData = QBCore.Functions.GetPlayerData()
        isLoggedIn = true
    end
end)

CreateThread(function ()
    for k,v in pairs(Config.Bombs) do
        exports['qb-target']:AddTargetModel(v, {
            options = {
                {
                    num = 2,
                    type = "client",
                    event = "JakeFun:bomb:openWireMenu",
                    icon = "fas fa-scissors",
                    label = "Defuse Bomb",
                    canInteract = function(entity, distance, data)
                        if not Entity(entity).state.isBomb then return false end
                        return true
                    end,
                },
            },
            distance = 2.0
        })
    end
end)
