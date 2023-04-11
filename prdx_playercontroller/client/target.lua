-- Globals
GlobalPlayerOptions = {
    {
        num = 1,
        event = "police:openInteractions",
        icon = "fas fa-shield-alt",
        label = "Police Actions",
        groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
    },
    {
        num = 1,
        event = "prdx_fireems:openInteractions",
        icon = "fas fa-hospital",
        label = "EMS Actions",
        groups = {'ambulance', 'clinic'}
    },
    {
        num = 1,
        event = "tow:openInteractions",
        icon = "fas fa-tools",
        label = "Tow Actions",
        groups = "tow",
    },
    {
        event = "target:client:giveCash",
        label = "Give Cash",
    },
    {
        num = 2,
        event = "police:client:EscortPlayer",
        label = "Escort person",
    },
    {
        num = 3,
        event = "police:client:PutPlayerInVehicle",
        label = "Put person in vehicle",
    },
    {
        num = 4,
        event = "target:client:takePlayerOutVehicle",
        label = "Take person out of vehicle",
    },
    {
        event = "prdx_bossmenu:client:giveJob",
        label = "Hire Employee",
        groups = {["yellowjack"] = 1, ["smokeonthewater"] = 1, ["glazedandglorious"] = 2, ["vanillaunicorn"] = 6, ["tequilala"] = 4, ["finnistaxi"] = 1, ["tenfourtwo"] = 3, ["cardealer"] = 2, ["nismostuning"] = 4, ["bikinitow"] = 2, ["slurpngo"] = 3, ["realestate"] = 4, ["beaveraviation"] = 1, ["paintball"] = 2, ["gopostal"] = 3, ["maisonette"] = 3, ["knifeshop"] = 2, ["glizzycomics"] = 3, ["bikedealer"] = 3, ["clinic"] = 7, ["koi"] = 3, ["roseandcrown"] = 3},
        job = true
    },
    {
        event = "prdx_bossmenu:client:giveJob",
        label = "Recruit Member",
        groups = {["collective"] = 2, ["srr"] = 3, ["ballas"] = 3, ["nismos"] = 3, ["madrazo"] = 1, ["chaotek"] = 3, ["reapers"] = 3},
        gang = true
    },
}

GlobalPedOptions = {
    {
        num = 1,
        type = "client",
        event = "police:client:pedDeathReason",
        icon = "fas fa-skull",
        label = "Check Death Cause",
        canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
            if IsPedDeadOrDying(entity) then return true end -- This will return false if the entity interacted with is a player and otherwise returns true
            return false
        end,
        groups = {"marshalls", "pd_cid", "hc"},
    },
}

exports.ox_target:addGlobalPlayer(GlobalPlayerOptions)
exports.ox_target:addGlobalPed(GlobalPedOptions)

-- Models

-- Phoneboxes
local phoneboxes = {`p_phonebox_02_s`, `p_phonebox_01b_s`, `prop_phonebox_01a`, `prop_phonebox_01b`, `prop_phonebox_01c`, `prop_phonebox_02`, `prop_phonebox_03`, `prop_phonebox_04`, `ch_chint02_phonebox001`, `sf_prop_sf_phonebox_01b_s`, `sf_prop_sf_phonebox_01b_straight`}
local phoneboxes_options = {
    {
        serverEvent = "target:server:rentBike",
        icon = "fas fa-bicycle",
        label = "Rent a bike",
        description = "$25 gets you a bike for temporary use",
        distance = 3.0
    }
}
exports.ox_target:addModel(phoneboxes, phoneboxes_options)

-- Yoga
local yoga = {`prop_yoga_mat_01`, `prop_yoga_mat_02`, `prop_yoga_mat_03`, `p_yoga_mat_02_s`, `p_yoga_mat_03_s`, `v_61_bd2_mesh_yogamat`}
local yoga_options = {
    {
        event = "playercontroller:doYoga",
        icon = "fas fa-child",
        label = "Yoga",
        description = "Take a minute to relax",
        distance = 1.0
    }
}
exports.ox_target:addModel(yoga, yoga_options)

-- Donuts
local donuts = {`prop_donut_01`, `prop_donut_02`, `prop_amb_donut`, `prop_donut_02b`, `prop_food_cb_donuts`}
local donuts_options = {
    {
        event = "target:eatDonut",
        icon = "fas fa-utensils",
        label = "Eat Donut",
        description = "Eat the juicy donut"
    }
}
exports.ox_target:addModel(donuts, donuts_options)

-- PD Computers
local pd_computers = {`prop_monitor_01a`, `p_cs_laptop_02_w`, `v_res_lest_monitor`, `hei_prop_hei_monitor_police_01`, `prop_monitor_01b`}
local pd_computers_options = {			
    {
        num = 1,
        type = "server",
        serverEvent = "mdt:server:openMDT",
        noAnim = true,
        icon = "fas fa-tablet-alt",
        label = "Open MDT",
        groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
    },
    {
        num = 2,
        type = "client",
        event = "prdx_bossmenu:client:openMenu",
        icon = "fas fa-users",
        label = "Boss Actions",
        groups = {["marshalls"] = 0, ["lspd"] = 4, ["bcso"] = 4, ["sast"] = 4, ["pd_cid"] = 0, ["hc"] = 0},
    }
}
exports.ox_target:addModel(pd_computers, pd_computers_options)

-- Pool Cues
local pool_cues = {`prop_pool_rack_01`, `prop_pool_rack_02`, `k4mb1_prop_pool_rack_02`}
local pool_cues_options = {			
    {
        event = "rc_pool:poolqueuetoggle",
        icon = "fa-pool-8-ball",
        label = "Toggle Pool Cue",
        distance = 3.0
    }
}
exports.ox_target:addModel(pool_cues, pool_cues_options)

-- Pool Tables
local pool_tables = {joaat('prop_pooltable_3b'), joaat('prop_pooltable_02'), joaat('k4mb1_prop_pooltable_02'), joaat('prop_pooltable_02_custom'), joaat('pooltable_collective')}
local pool_tables_options = {			
    {
        num = 1,
        event = 'rcore_pool:requestTurn',
        icon = "fas fa-dot-circle",
        label = "Play Turn",
        distance = 3.0
    },
    {
        num = 2,
        event = 'rcore_pool:setupTable',
        args = 'BALL_SETUP_STRAIGHT_POOL',
        icon = "fas fa-dot-circle",
        label = "Setup Normal Pool",
        distance = 3.0
    },
    {
        num = 3,
        event = 'rcore_pool:setupTable',
        args = 'BALL_SETUP_8_BALL',
        icon = "fas fa-dot-circle",
        label = "Setup 8-Ball Pool",
        distance = 3.0
    }
}
exports.ox_target:addModel(pool_tables, pool_tables_options)

-- Cattle
local cattle = {`a_c_cow`, `a_c_hen`, `a_c_pig`}
local cattle_options = {			
    {
        event = "prdx_ranching:OpenRanchMenu",
        icon = "fas fa-tractor",
        label = "Tend Animal",
    }
}
exports.ox_target:addModel(cattle, cattle_options)

-- Nitrous Refill
local nitrous_refill = {`v_med_gastank`}
local nitrous_refill_options = {			
    {
        event = "prdx_tuningjob:openNitroRefill",
        icon = "fas fa-fire-burner",
        label = "Open NOS Refill Station",
        groups = {"nismostuning", "bikinitow", "bikedealer"},
        distance = 3.0
    }
}
exports.ox_target:addModel(nitrous_refill, nitrous_refill_options)

-- Events

QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler("target:eatDonut", function(data)
	TriggerEvent('animations:client:EmoteCommandStart', {"give3"})
	Wait(2000)
	SetEntityAsMissionEntity(data.entity)
	DeleteEntity(data.entity)
	TriggerEvent('animations:client:EmoteCommandStart', {"donut"})
	TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + math.random(20, 40))
    TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
end)

AddEventHandler("target:client:giveCash", function(data)
    local player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    local result = lib.inputDialog('Give Cash', {
        { type = "number", label = "Amount", default = 0 }
    })
    if not result then return end
    local amount = result[1]
    if amount and player then
        TriggerServerEvent("target:server:giveCash", player, amount)
    end
end)

AddEventHandler("target:client:impoundVeh", function(netid) -- Normal
    local netid = netid
    if netid then 
        QBCore.Functions.TriggerCallback('tow:GetTow', function(result)
            local vehicle = NetToVeh(netid)
            local plate = QBCore.Functions.GetPlate(vehicle)
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle)
            TriggerEvent('animations:client:EmoteCommandStart', {"phonecall"})
            QBCore.Functions.Progressbar("impound_normal", "Requesting impound", math.random(7500,15000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                if tonumber(result) > 0 then -- Tow Online
                    local data = exports['cd_dispatch']:GetPlayerInfo()
                    TriggerServerEvent('cd_dispatch:AddNotification', {
                        job_table = {'tow'}, --{'police', 'sheriff} 
                        coords = data.coords,
                        title = 'Impound Request',
                        message = 'A '..data.vehicle_colour .. ' ' .. data.vehicle_label..' with the plate: '..data.vehicle_plate, 
                        flash = 0, 
                        unique_id = tostring(math.random(0000000,9999999)),
                        blip = {
                            sprite = 68, 
                            scale = 1.5, 
                            colour = 17,
                            flashes = false, 
                            text = 'Impound Request',
                            sound = 1,
                        }
                    })
                    QBCore.Functions.Notify("SADOT called!", "success")
                else
                    TriggerServerEvent('qb-tow:server:impoundDelay', netid)
                    QBCore.Functions.Notify("County tow enroute!", "success")
                end
                exports.scully_emotemenu:CancelAnimation()
                isBusy = false
            end, function() -- Cancel
                exports.scully_emotemenu:CancelAnimation()
                isBusy = false
            end)
        end)
    else
        QBCore.Functions.Notify("No vehicle", "error")
    end
end)   

AddEventHandler("target:client:depotVeh", function(vehicle) -- Police
    if vehicle then
        local userjob = QBCore.Functions.GetPlayerData().job.name
        if userjob == "marshalls" or userjob == "lspd" or userjob == "bcso" or userjob == "sast" or userjob == "hc" or userjob == "pd_cid" then
            TriggerEvent('animations:client:EmoteCommandStart', {"phonecall"})
            TaskTurnPedToFaceEntity(PlayerPedId(), vehicle)
            QBCore.Functions.Progressbar("impound_depot", "Requesting police seizure", math.random(15000,20000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                QBCore.Functions.Notify("Depot requested!", "success")
                local plate = QBCore.Functions.GetPlate(vehicle)
                TriggerServerEvent('qb-log:server:CreateLog', "publicsafety", "Vehicle Seized!", "red", "**" .. GetPlayerName(PlayerId()) .. "** (CitizenID: *" .. QBCore.Functions.GetPlayerData().citizenid .. "* | ID: *" .. GetPlayerServerId(PlayerId()) .. "*) has PD seized a vehicle with plate: `"..plate..'`' , false, GetPlayerServerId(PlayerId()))
                TriggerEvent('police:client:DepotVehicle', false, nil, vehicle)
                isBusy = false
            end, function() -- Cancel
                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                isBusy = false
            end)
        else
            QBCore.Functions.Notify("You can\'t do this!", "error")
        end
    else
        QBCore.Functions.Notify("No vehicle", "error")
    end
end)   

AddEventHandler("target:client:scuffVeh", function(netid) -- Scuff
    if netid then
        local vehicle = NetToVeh(netid)
        local plate = QBCore.Functions.GetPlate(vehicle)
        TaskTurnPedToFaceEntity(PlayerPedId(), vehicle)
        TriggerEvent('animations:client:EmoteCommandStart', {"phonecall"})
        QBCore.Functions.Progressbar("impound_normal", "Requesting scuff impound", 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            QBCore.Functions.Notify("Scuff impounded", "success")
            TriggerServerEvent('qb-log:server:CreateLog', "default", "Vehicle Impounded", "red", "**" .. GetPlayerName(PlayerId()) .. "** (CitizenID: *" .. QBCore.Functions.GetPlayerData().citizenid .. "* | ID: *" .. GetPlayerServerId(PlayerId()) .. "*) has scuff impounded vehicle with plate: `"..plate..'`' , false, GetPlayerServerId(PlayerId()))
            TriggerServerEvent('QBCore:Game:Delete', netid)
            isBusy = false
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            isBusy = false
        end)
    else
        QBCore.Functions.Notify("No vehicle", "error")
    end
end)   


RegisterNetEvent('target:client:putPlayerInVehicle', function(data)
    local player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    if IsVehicleSeatFree(vehicle, 3) then
        SetPedIntoVehicle(player, vehicle, 3)
    elseif IsVehicleSeatFree(vehicle, 4) then
        SetPedIntoVehicle(player, vehicle, 4)
    else
        QBCore.Functions.Notify("No availble seats to place this person.", "error")
    end
end)

AddEventHandler('target:client:openImpoundMenu', function(data)
    local vehicle = data.entity
    local netid = VehToNet(data.entity)
    local menu = {
        {
            title = 'Normal Impound',
            description = "Normal impound request",
            event = "target:client:impoundVeh",
            args = netid
        },
        {
            title = 'Scuff Impound',
            description = "Vehicle is/causing scuff (WARNING LOGGED!)",
            event = "target:client:scuffVeh",
            args = netid
        },
        {
            title = 'Police Seizure',
            description = "Seize vehicle to depot",
            event = "target:client:depotVeh",
            args = vehicle
        },
    }
    lib.registerContext({
        id = 'impound_menu',
        title = "Impound Vehicle",
        options = menu,
    })
    lib.showContext('impound_menu')
end)

RegisterNetEvent('target:client:takePlayerOutVehicle', function(data)
    local player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity))
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    TaskLeaveVehicle(player, vehicle, 256)
end)


RegisterNetEvent('target:client:removeFromSeat', function(data)
    local plate = QBCore.Functions.GetPlate(data.entity)
    QBCore.Functions.TriggerCallback('vehiclekeys:CheckHasKey', function(result)
        if result then
            local SeatsTaken = {}

            local seatstaken = {}
            local vehicle = data.entity
            for i=-1,GetVehicleMaxNumberOfPassengers(vehicle)-1 do
                if IsVehicleSeatFree(vehicle, i) then
                    SeatsTaken[#SeatsTaken+1] = {
                        title = "Seat " .. i+2 .. " : Free",
                        event = "target:client:putPlayerInVehicle",
                        args = {seat = i, vehicle = data.entity}
                    }
                else
                    SeatsTaken[#SeatsTaken+1] = {
                        title = "Seat " .. i+2 .. " : Occupied",
                        event = "police:client:SetPlayerOutVehicle",
                        args = {seat = i, vehicle = data.entity}
                    }
                end
            end
            lib.registerContext({
                id = 'seat_menu',
                title = 'Seats Taken',
                options = SeatsTaken,
            })
            lib.showContext('seat_menu')
        else
            QBCore.Functions.Notify("You do not have the keys to this vehicle!")
        end
    end, plate)
end)

RegisterNetEvent('target:client:setRadio', function(channel)
    if QBCore.Functions.HasItem('radio') then
        local id = tonumber(channel) or 0
        exports["qb-radio"]:ConnectToRadio(id)
    else
        QBCore.Functions.Notify('You do not have a radio!')
    end
end)


RegisterNetEvent('target:client:rentBike', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"impatient"})
    QBCore.Functions.Progressbar("requestbike", "Requesting bike", math.random(3500,5000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local heading = GetEntityHeading(PlayerPedId())
        QBCore.Functions.SpawnVehicle('cruiser', function(bike)
            SetVehicleNumberPlateText(bike, "RENTBIKE-" .. tostring(math.random(10,99)))
            exports['ps-fuel']:SetFuel(bike, 100.0)
            NetworkRegisterEntityAsNetworked(bike)
            SetEntityHeading(bike, heading)
            SetTimeout(60000, function()
                SetEntityAsNoLongerNeeded(bike) -- Keeps area clean
            end)
        end, GetEntityCoords(PlayerPedId()), true) 
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        isBusy = false
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        isBusy = false
    end)
end)

RegisterNetEvent('target:client:openStash', function(data)
    local stash = (data.args and data.args[1]) or data[1]
    exports.ox_inventory:openInventory('stash', stash)
end)

RegisterNetEvent('target:client:openShop', function(data)
    shop = data.sellitems
    exports.ox_inventory:openInventory('shop', {type = shop})
end)