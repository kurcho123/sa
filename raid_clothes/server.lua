local QBCore = exports['qb-core']:GetCoreObject()

local function checkExistenceClothes(cid, cb)
    MySQL.Async.fetchAll("SELECT citizenid FROM character_current WHERE citizenid = @cid LIMIT 1 ", {["cid"] = cid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

local function checkExistenceFace(cid, cb)
    MySQL.Async.fetchAll("SELECT citizenid FROM character_face WHERE citizenid = @cid LIMIT 1", {["cid"] = cid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

RegisterServerEvent("raid_clothes:insert_character_current")
AddEventHandler("raid_clothes:insert_character_current",function(data)
    if not data then return end
    local src = source
    local user = QBCore.Functions.GetPlayer(src)
    local characterId = user.PlayerData.citizenid
    if data.model ~= `mp_f_freemode_01` or data.model ~= `mp_m_freemode_01` then
        MySQL.Async.fetchAll("SELECT * FROM chosen_peds WHERE taken = 0", {}, function(results)
            if results then
                for k,v in pairs(results) do
                    if tonumber(v.model_hash) == tonumber(data.model) then
                        MySQL.Async.execute("UPDATE chosen_peds SET taken = 1 WHERE id = @id", {["@id"] = v.id})
                    end
                end
            end
        end)
    end
    checkExistenceClothes(characterId, function(exists)
        local values = {
            ["@cid"] = characterId,
            ["@model"] = json.encode(data.model),
            ["@drawables"] = json.encode(data.drawables),
            ["@props"] = json.encode(data.props),
            ["@drawtextures"] = json.encode(data.drawtextures),
            ["@proptextures"] = json.encode(data.proptextures),
        }
        if not exists then
            MySQL.Async.insert("INSERT INTO character_current (citizenid, model, drawables, props, drawtextures, proptextures) VALUES (@cid, @model, @drawables, @props, @drawtextures, @proptextures)", values, function()
            end)
            return
        end
        MySQL.Async.execute("UPDATE character_current SET model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures WHERE citizenid = @cid", values)
    end)
end)


RegisterServerEvent("raid_clothes:insert_character_face")
AddEventHandler("raid_clothes:insert_character_face",function(data)
    if not data then return end
    local src = source

    local user = QBCore.Functions.GetPlayer(src)
    local characterId = user.PlayerData.citizenid

    if not characterId then return end

    checkExistenceFace(characterId, function(exists)
        local values = {
            ["@cid"] = characterId,
            ["@hairColor"] = json.encode(data.hairColor),
            ["@headBlend"] = json.encode(data.headBlend),
            ["@headOverlay"] = json.encode(data.headOverlay),
            ["@headStructure"] = json.encode(data.headStructure),
            ["@eyeColor"] = data.eyeColor
        }
        if not exists then
            MySQL.Async.insert("INSERT INTO character_face (citizenid, hairColor, headBlend, headOverlay, headStructure, eyeColor) VALUES (@cid, @hairColor, @headBlend, @headOverlay, @headStructure, @eyeColor)", values, function()
            end)
            return
        end
        MySQL.Async.execute("UPDATE character_face SET hairColor = @hairColor,headBlend = @headBlend, headOverlay = @headOverlay, headStructure = @headStructure, eyeColor = @eyeColor WHERE citizenid = @cid", values)

    end)
end)

RegisterServerEvent("raid_clothes:get_character_face")
AddEventHandler("raid_clothes:get_character_face",function(citizenid)
    local src = source
    local characterId = citizenid
    if not characterId then
        local user = QBCore.Functions.GetPlayer(src)
        characterId = user.PlayerData.citizenid
    end
    if characterId == nil then return end
    MySQL.Async.fetchAll("SELECT cc.model, cf.hairColor, cf.headBlend, cf.headOverlay, cf.headStructure, cf.eyeColor FROM character_face cf INNER JOIN character_current cc on cc.citizenid = cf.citizenid WHERE cf.citizenid = @cid", {['cid'] = characterId}, function(result)
        if (result ~= nil and result[1] ~= nil) then
            local temp_data = {
                hairColor = json.decode(result[1].hairColor),
                headBlend = json.decode(result[1].headBlend),
                headOverlay = json.decode(result[1].headOverlay),
                headStructure = json.decode(result[1].headStructure),
                eyeColor = result[1].eyeColor
            }
            local model = tonumber(result[1].model)
            if model == 1885233650 or model == -1667301416 then
                TriggerClientEvent("raid_clothes:setpedfeatures", src, temp_data)
            end
        end
	end)
end)

RegisterServerEvent("raid_clothes:get_character_current")
AddEventHandler("raid_clothes:get_character_current",function(pSrc)
    local src = ((not pSrc or type(pSrc) ~= "number") and source or pSrc)
    local user = QBCore.Functions.GetPlayer(src)
    if not user then return end
    local characterId = user.PlayerData.citizenid

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT * FROM character_current WHERE citizenid = @cid", {['cid'] = characterId}, function(result)
        if result[1] then
            local temp_data = {
                model = result[1].model,
                drawables = json.decode(result[1].drawables),
                props = json.decode(result[1].props),
                drawtextures = json.decode(result[1].drawtextures),
                proptextures = json.decode(result[1].proptextures),
            }
            TriggerClientEvent("raid_clothes:setclothes", src, temp_data,0)
        end
	end)
end)

RegisterServerEvent("raid_clothes:retrieve_tats")
AddEventHandler("raid_clothes:retrieve_tats", function(citizenid)

end)

RegisterServerEvent("raid_clothes:set_tats")
AddEventHandler("raid_clothes:set_tats", function(tattoosList)
	
end)


RegisterServerEvent("raid_clothes:get_outfit")
AddEventHandler("raid_clothes:get_outfit",function()
    local src = source

    local user = QBCore.Functions.GetPlayer(src)
    local characterId = user.PlayerData.citizenid

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT * FROM character_outfits WHERE citizenid = @cid", {
        ['cid'] = characterId
    }, function(result)
        if result and result[1] then
            if result[1].model == nil then
                TriggerClientEvent("notification", src, "Can not use.",2)
                return
            end

            local data = {
                model = result[1].model,
                drawables = json.decode(result[1].drawables),
                props = json.decode(result[1].props),
                drawtextures = json.decode(result[1].drawtextures),
                proptextures = json.decode(result[1].proptextures),
                hairColor = json.decode(result[1].hairColor)
            }

            TriggerClientEvent("raid_clothes:setclothes", src, data,0)

            local values = {
                ["cid"] = characterId,
                ["model"] = data.model,
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
            }

            local set = "model = @model, drawables = @drawables, props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
            MySQL.Async.execute("UPDATE character_current SET "..set.." WHERE citizenid = @cid",values)
        else
            TriggerClientEvent("notification", src, "No outfit on slot " .. slot,2)
            return
        end
	end)
end)

RegisterServerEvent("raid_clothes:set_outfit")
AddEventHandler("raid_clothes:set_outfit",function(name, data)
    local src = source

    local user = QBCore.Functions.GetPlayer(src)
    local characterId = user.PlayerData.citizenid

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT name FROM character_outfits WHERE citizenid = @cid and name = @name", {
        ['cid'] = characterId,
        ['name'] = name,
    }, function(result)
        if result and result[1] then
            local values = {
                ["cid"] = characterId,
                ["name"] = name,
                ["model"] = json.encode(data.model),
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
                ["hairColor"] = json.encode(data.hairColor),
            }

            local set = "model = @model,name = @name,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures,hairColor = @hairColor"
            MySQL.Async.execute("UPDATE character_outfits SET "..set.." WHERE citizenid = @cid AND name = @name",values)
        else
            local cols = "citizenid, model, name, drawables, props, drawtextures, proptextures, hairColor"
            local vals = "@cid, @model, @name, @drawables, @props, @drawtextures, @proptextures, @hairColor"

            local values = {
                ["cid"] = characterId,
                ["name"] = name,
                ["model"] = data.model,
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
                ["hairColor"] = json.encode(data.hairColor)
            }

            MySQL.Async.insert("INSERT INTO character_outfits ("..cols..") VALUES ("..vals..")", values, function()
                TriggerClientEvent("notification", src, name .. " stored",1)
            end)
        end
	end)
end)


RegisterServerEvent("raid_clothes:remove_outfit")
AddEventHandler("raid_clothes:remove_outfit",function(name)

    local src = source
    local user = QBCore.Functions.GetPlayer(src)
    local cid = user.PlayerData.citizenid
    local name = name

    if not cid then return end

    MySQL.Async.execute("DELETE FROM character_outfits WHERE citizenid = @cid AND name = @name", { ['cid'] = cid,  ["name"] = name } )
    TriggerClientEvent("QBCore:Notify", src, "Removed " .. name .. ".", "success", 5000)
end)

RegisterServerEvent("raid_clothes:list_outfits")
AddEventHandler("raid_clothes:list_outfits",function()
    local src = source
    local user = QBCore.Functions.GetPlayer(src)
    local cid = user.PlayerData.citizenid
    local slot = slot
    local name = name

    if not cid then return end

    MySQL.Async.fetchAll("SELECT slot, name FROM character_outfits WHERE citizenid = @cid", {['cid'] = cid}, function(skincheck)
    	TriggerClientEvent("hotel:list",src, skincheck)
	end)
end)

QBCore.Functions.CreateCallback('raid_clothes:getOutfits', function(source, cb)
    local src = source
    local user = QBCore.Functions.GetPlayer(src)
    local cid = user.PlayerData.citizenid
    MySQL.Async.fetchAll("SELECT * FROM character_outfits WHERE citizenid = @cid", {['cid'] = cid}, function(result)
    	cb(result)
	end)
end)

-- ONLY UNCOMMENT TO RESET THE TABLES FOR THE PEDS!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- MAKE SURE YOU KNOW WHAT YOU ARE DOING
-- THE TABLES NAMES ARE WRONG ON PURPOSE TO MAKE SURE YOU KNOW WHAT YOU ARE DOING!!!!!!!!!


-- CreateThread(function()
--     print('BUILDING PED TABLES')
--     for k2,v2 in pairs(frm_skins) do
--         local hash = joaat(v2)
--         MySQL.Async.insert("INSERT INTO the_peds (model_hash, sex) VALUES (@hash, 'male')", {['hash'] = hash}, function()
--         end)
--     end
--     for k2,v2 in pairs(fr_skins) do
--         local hash = joaat(v2)
--         MySQL.Async.insert("INSERT INTO the_peds (model_hash, sex) VALUES (@hash, 'female')", {['hash'] = hash}, function()
--         end)
--     end
--     print('Completed Building Tables')
-- end)

QBCore.Functions.CreateCallback('raid_clothes:getPedSkins', function(source, cb)
    local src = source
    local maleskins = {
        `mp_m_freemode_01`,
    }
    local femskins = {
        `mp_f_freemode_01`
    }
    MySQL.Async.fetchAll("SELECT * FROM chosen_peds WHERE taken = 0", {}, function(results)
        if results then
            for k,v in pairs(results) do
                if v.sex == 'male' then
                    table.insert(maleskins, v.model_hash)
                else
                    table.insert(femskins, v.model_hash)
                end
            end
            local skins = {male = maleskins, female = femskins}
            cb(skins)
        else
            print('MAJOR ERROR')
            cb(nil)
        end
	end)
end)

QBCore.Functions.CreateCallback('raid_clothes:getVIP', function(source, cb)
    local src = source
    local getPerms = exports["prdx_playercontroller"]:getPlayerPerms(src) or false
    if getPerms then
        if getPerms.serverOne.vip1 or getPerms.serverOne.vip2 or getPerms.serverOne.vip3 or getPerms.serverOne.vip3 or getPerms.staff.staff or getPerms.staff.admin or getPerms.staff.headadmin or getPerms.staff.director then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent("clothing:checkMoney")
AddEventHandler("clothing:checkMoney", function(menu, askingPrice)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.GetMoney('cash') >= askingPrice then
        TriggerClientEvent("raid_clothes:hasEnough",src,menu)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have enough money', 'error')
    end
end)

RegisterServerEvent("clothing:takeMoney")
AddEventHandler("clothing:takeMoney", function(menu,askingPrice)
    local src = source
	local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.GetMoney('cash') >= askingPrice then
        xPlayer.Functions.RemoveMoney('cash', askingPrice)
        TriggerClientEvent('QBCore:Notify', source, 'You paid $' .. askingPrice)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have enough money', 'error')
    end
end)

RegisterServerEvent("clothing:GiveMask")
AddEventHandler("clothing:GiveMask", function(prop, texture)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local askingPrice = 50
    if Player.Functions.GetMoney('cash') >= askingPrice then
        Player.Functions.RemoveMoney('cash', askingPrice)
        local info = {
            prop = prop,
            texture = texture
        }
        Player.Functions.AddItem('player_mask', 1, false, info)
        TriggerClientEvent('QBCore:Notify', source, 'You paid $' .. askingPrice)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have enough money', 'error')
    end
end)

RegisterServerEvent("clothing:GiveHat")
AddEventHandler("clothing:GiveHat", function(prop, texture)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local askingPrice = 50
    if Player.Functions.GetMoney('cash') >= askingPrice then
        Player.Functions.RemoveMoney('cash', askingPrice)
        local info = {
            prop = prop,
            texture = texture
        }
        Player.Functions.AddItem('player_hat', 1, false, info)
        TriggerClientEvent('QBCore:Notify', source, 'You paid $' .. askingPrice)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You dont have enough money', 'error')
    end
end)

QBCore.Functions.CreateUseableItem("player_mask", function(source, item)
    local src = source
    if item.metadata then
        TriggerClientEvent("raid_clothes:client:applyMask", src, item.metadata)
    end
end)

QBCore.Functions.CreateUseableItem("player_hat", function(source, item)
    local src = source
    if item.metadata then
        TriggerClientEvent("raid_clothes:client:applyHat", src, item.metadata)
    end
end)