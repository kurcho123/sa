local raw = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
local postals = json.decode(raw)

local nearest = nil
local pBlip = nil
local interface = true
local returnpostal = nil

function openInterface()
    if interface then
        interface = false
    else
        interface = true
    end
end

RegisterNetEvent('postals:GetPostal')
AddEventHandler('postals:GetPostal', function(data)
    local pedCoords = data
    local nd = -1
    local ni = -1
    for i, p in ipairs(postals) do
        local d = math.sqrt((pedCoords.x - p.x)^2 + (pedCoords.y - p.y)^2) -- pythagorean theorem
        if nd == -1 or d < nd then
            ni = i
            nd = d
        end
    end

    if ni ~= -1 then
        returnpostal = {dist = nd, i = ni}
        
    end
    local x = postals[returnpostal.i].x
    local y = postals[returnpostal.i].y
    local street, cross = GetStreetNameAtCoord(x, y, 0.0)
    local StreetName = GetStreetNameFromHashKey(street)
    local CrossName = GetStreetNameFromHashKey(cross)
    TriggerEvent('esx_dispatch:returnpostal', postals[returnpostal.i].code, StreetName)
    TriggerEvent('esx_addons_gcphone:moreinfo', postals[returnpostal.i].code, StreetName)
end)

RegisterNetEvent('postals:GetPostal2')
AddEventHandler('postals:GetPostal2', function(data)
    local pedCoords = data
    local nd = -1
    local ni = -1
    for i, p in ipairs(postals) do
        local d = math.sqrt((pedCoords.x - p.x)^2 + (pedCoords.y - p.y)^2) -- pythagorean theorem
        if nd == -1 or d < nd then
            ni = i
            nd = d
        end
    end

    if ni ~= -1 then
        returnpostal = {dist = nd, i = ni}
        
    end
    local x = postals[returnpostal.i].x
    local y = postals[returnpostal.i].y
    local street, cross = GetStreetNameAtCoord(x, y, 0.0)
    local StreetName = GetStreetNameFromHashKey(street)
    local CrossName = GetStreetNameFromHashKey(cross)
    TriggerEvent('esx_ambulancejob:moreinfo', postals[returnpostal.i].code, StreetName)
end)

RegisterNetEvent('postals:GetPostal3')
AddEventHandler('postals:GetPostal3', function(data)
    local pedCoords = data
    local nd = -1
    local ni = -1
    for i, p in ipairs(postals) do
        local d = math.sqrt((pedCoords.x - p.x)^2 + (pedCoords.y - p.y)^2) -- pythagorean theorem
        if nd == -1 or d < nd then
            ni = i
            nd = d
        end
    end

    if ni ~= -1 then
        returnpostal = {dist = nd, i = ni}
        
    end
    local x = postals[returnpostal.i].x
    local y = postals[returnpostal.i].y
    TriggerEvent('CH_hud:postals', postals[returnpostal.i].code)
end)

RegisterNetEvent('postals:GetPostalPanic')
AddEventHandler('postals:GetPostalPanic', function(data, namesent, jobsent)
    local pedCoords = data
    local name = namesent
    local job = jobsent
    --
    local nd = -1
    local ni = -1
    for i, p in ipairs(postals) do
        local d = math.sqrt((pedCoords.x - p.x)^2 + (pedCoords.y - p.y)^2) -- pythagorean theorem
        if nd == -1 or d < nd then
            ni = i
            nd = d
        end
    end

    if ni ~= -1 then
        returnpostal = {dist = nd, i = ni}
        
    end
    local x = postals[returnpostal.i].x
    local y = postals[returnpostal.i].y
    local street, cross = GetStreetNameAtCoord(x, y, 0.0)
    local StreetName = GetStreetNameFromHashKey(street)
    local CrossName = GetStreetNameFromHashKey(cross)
    --
    TriggerServerEvent('cadlink:panicInfo', postals[returnpostal.i].code, StreetName, name, job)
end)

RegisterNetEvent('postals:GetPostalFire')
AddEventHandler('postals:GetPostalFire', function(data, namesent, jobsent)
    local pedCoords = data
    local name = namesent
    local job = jobsent
    --
    local nd = -1
    local ni = -1
    for i, p in ipairs(postals) do
        local d = math.sqrt((pedCoords.x - p.x)^2 + (pedCoords.y - p.y)^2) -- pythagorean theorem
        if nd == -1 or d < nd then
            ni = i
            nd = d
        end
    end

    if ni ~= -1 then
        returnpostal = {dist = nd, i = ni}
        
    end
    local x = postals[returnpostal.i].x
    local y = postals[returnpostal.i].y
    local street, cross = GetStreetNameAtCoord(x, y, 0.0)
    local StreetName = GetStreetNameFromHashKey(street)
    local CrossName = GetStreetNameFromHashKey(cross)
    --
    TriggerServerEvent('cadlink:fireInfo', postals[returnpostal.i].code, StreetName, name, job)
end)

-- text display thread
-- Citizen.CreateThread(function()
--     while true do
--         if nearest and interface and IsPedInAnyVehicle(PlayerPedId(), true) then
--             local playerVeh = GetVehiclePedIsIn(PlayerPedId(), false)
--             if GetVehicleClass(playerVeh) == 14 or GetVehicleClass(playerVeh) == 15 or GetVehicleClass(playerVeh) == 16 then
--                 paraoff = -0.01
--             else
--                 paraoff = 0.0
--             end
--             local text = config.text.format:format(postals[nearest.i].code, nearest.dist)
--             SetTextScale(0.53, 0.53)
--             SetTextFont(4)
--             SetTextProportional(false)
--             SetTextEntry("STRING")
--             SetTextCentre(1)
--             SetTextColour(255, 255, 255, 255)
--             SetTextOutline()
--             AddTextComponentString(text)
--             DrawText(config.text.posX, paraoff + config.text.posY)
--         end
--         Wait(2)
--     end
-- end)

-- blip thread
-- Citizen.CreateThread(function()
--     while true do
--         if pBlip then
--             local p = GetEntityCoords(GetPlayerPed(-1))
--             local b = {x = pBlip.p.x, y = pBlip.p.y}
--             local dx, dy = math.abs(p.x - b.x), math.abs(p.y - b.y)
--             local d = math.sqrt(dx^2 + dy^2)
--             if d < config.blip.distToDelete then
--                 RemoveBlip(pBlip.hndl)
--                 pBlip = nil
--             end
--         end
--         Wait(100)
--     end
-- end)
RegisterCommand('postal', function(source, args, raw)
    if #args < 1 then
        if pBlip then
            RemoveBlip(pBlip.hndl)
            pBlip = nil
        end
        return
    end
    local n = string.upper(args[1])

    local fp = nil
    for _, p in ipairs(postals) do
        if string.upper(p.code) == n then
            fp = p
        end
    end

    if fp then
        if pBlip then
            RemoveBlip(pBlip.hndl)
        end
        pBlip = {hndl = AddBlipForCoord(fp.x, fp.y, 0.0), p = fp}
        SetBlipRoute(pBlip.hndl, true)
        SetBlipColour(pBlip.hndl, 3)
        SetBlipRouteColour(pBlip.hndl, config.blip.color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(config.blip.textFormat:format(pBlip.p.code))
        EndTextCommandSetBlipName(pBlip.hndl)

        TriggerEvent('chat:addMessage', {
            color = {255,0,0},
            args = {
                'Postals',
                'Drawing a route to '..fp.code
            }
        })
    else
        TriggerEvent('chat:addMessage', {
            color = {255,0,0},
            args = {
                'Postals',
                'That postal code doesn\'t exist'
            }
        })
    end
end)

-- --[[Development shit]]
-- local dev = false
-- if dev then
--     local devLocal = json.decode(raw)
--     local next = 0

--     RegisterCommand('setnext', function(src, args, raw)
--         local n = tonumber(args[1])
--         if n ~= nil then
--             next = n
--             --
--             return
--         end
--         --
--     end)
--     RegisterCommand('next', function(src, args, raw)
--         for i, d in ipairs(devLocal) do
--             if d.code == tostring(next) then
--                 --
--                 return
--             end
--         end
--         local coords = GetEntityCoords(GetPlayerPed(-1))
--         table.insert(devLocal, {code = tostring(next), x = coords.x, y = coords.y})
--         --
--         next = next + 1
--     end)
--     RegisterCommand('rl', function(src, args, raw)
--         if #devLocal > 0 then
--             local data = table.remove(devLocal, #devLocal)
--             --
--             --
--             next = next - 1
--         else
--             --
--         end
--     end)
--     RegisterCommand('remove', function(src, args, raw)
--         if #args < 1 then
--             --
--         else
--             for i, d in ipairs(devLocal) do
--                 if d.code == args[1] then
--                     table.remove(devLocal, i)
--                     --
--                     return
--                 end
--             end
--             --
--         end
--     end)
--     RegisterCommand('json', function(src, args, raw)
--         --
--     end)
-- end
