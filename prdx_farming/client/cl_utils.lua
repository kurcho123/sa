function p(level, text)
    if Config.Debug then
        color = '^0'
        msgType = '^0[INFO] :'
        if level == 1 then
            color = '^2'
            msgType = '^2[DEBUG]: '
        end
        if level == 2 then
            color = '^3'
            msgType = '^3[WARN]: '
        end
        if level == 3 then
            color = '^1'
            msgType = '^1[ERROR]: '
        end
        print(msgType .. '^3(prdx_farming) ' .. color .. text)
    end
end

function DrawMarkerRad(markerType, x, y, z, posX, posY, posZ, dirX, dirY, dirZ, scaleX, scaleY, scaleZ, r, g, b, a, upDown, face, p19, rotate, texture, textureName, drawEnts)
    local dist = #(vector3(x, y, z) - GetEntityCoords(cache.ped))
    if dist < 20 then
        local dist = math.floor(a - (dist * 30))
        if dist < 0 then
            dist = 0
        end
        DrawMarker(markerType, x, y, z - 1.0, posX, posY, posZ, dirX, dirY, dirZ, scaleX, scaleY, scaleZ, r, g, b, dist, upDown, face, p19, rotate, texture, textureName, drawEnts)
    end
end

round = function(value, numDecimalPlaces)
    if value == nil then
        value = 0
        p(3, 'Round function has nil value parameter. Returning 0 instead.')
    end
    if numDecimalPlaces == nil then
        numDecimalPlaces = 0
        p(3, 'Round function has nil decimal places parameter. Returning 0 instead.')
    end
    if numDecimalPlaces then
        local power = 10 ^ numDecimalPlaces
        return math.floor((value * power) + 0.5) / (power)
    else
        return math.floor(value + 0.5)
    end
end

ReChunk = function(coords, plants)
    local in_range = {}
    local countClose = 0
    local countTotal = 0
    for k, v in ipairs(plants) do
        local dist = #(vector3(coords.x, coords.y, coords.z) - vector3(v.coords.x, v.coords.y, v.coords.z))
        if dist < Config.ChunkDist then
            table.insert(in_range, k)
            countClose = countClose + 1
        end
        countTotal = countTotal + 1
    end
    --p(1, 'There are currently ' .. countClose .. ' plants nearby of total ' .. countTotal .. ' planted plants.')
    return in_range
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function GetClosestPlant()
    local dist = 1000
    local ped = cache.ped
    local pos = GetEntityCoords(ped)
    local plant = {}
    if not inserting then
        if Farming.AllPlants ~= nil and next(Farming.AllPlants) ~= nil then
            if next(Farming.ClosePlantsIndexes) ~= nil and #Farming.ClosePlantsIndexes > 0 then
                for k, v in pairs(Farming.ClosePlantsIndexes) do
                    if Farming.AllPlants[v] ~= nil then
                        local distance = #(vector3(Farming.AllPlants[v].coords.x, Farming.AllPlants[v].coords.y, Farming.AllPlants[v].coords.z) - pos)
                        if distance < dist then
                            dist = distance
                            plant = Farming.AllPlants[v]
                        end
                    end
                end
            end
        end
    end
    return plant
end

function RemovePlantFromTable(plantId)
    for k, v in pairs(Farming.AllPlants) do
        if v.id == plantId then
            Farming.AllPlants[k] = nil
            Farming.ClosePlantsIndexes[k] = nil
        end
    end
end

function table.diff(a, b)
    for k, v in pairs(a) do
        for i, j in pairs(b) do
            if v.id == j.id then
                table.remove(b, i)
            end
        end
    end
    return b
end

function table.find(f, l)
    for _, v in ipairs(l) do
        if v.type == f then
            return v
        end
    end
    return nil
end

function table.findById(f, l)
    for i, v in ipairs(l) do
        if v.id == f then
            return l[i]
        end
    end
    return nil
end

RegisterNetEvent('prdx_farming:Notify', function(type, text)
    Notify(type, text)
end)