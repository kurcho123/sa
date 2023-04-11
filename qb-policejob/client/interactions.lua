-- Variables
local isEscorting = false
local cuffedRecently = false

-- Functions

exports('IsHandcuffed', function()
    return isHandcuffed
end)

function GetPlayerFromPed(ped)
    for _,player in ipairs(GetActivePlayers()) do
        if GetPlayerPed(player) == ped then
            return player
        end
    end
    return -1
end

RegisterNetEvent('police:openInteractions')
AddEventHandler('police:openInteractions', function(data)
    local player = GetPlayerFromPed(data.entity)
    local serverID = GetPlayerServerId(player)
    local MenuInteractionOptionsPD = {}
    lib.registerContext({
		id = 'MenuInteractionOptionsPD',
		title = 'Police Interactions',
		onExit = function() end,
		options = {
            {
                title = "Toggle Cuff",
                event = "police:client:CuffPlayerSoft",
                args = data
            },{
                title = "Toggle Shackle Cuff",
                event = "police:client:CuffPlayer",
                args = data
            },{
                title = "Check Person Health",
                serverEvent = "prdx_healthsystem:server:GetPlayerInjuries",
                args = serverID
            },{
                title = "Observe Person",
                event = "police:client:CheckStatus",
                args = data
            },{
                title = "Search Person",
                event = "police:client:SearchPlayer",
                args = data
            },{
                title = "Process Fine",
                serverEvent = "target:server:fine",
                args = data
            },{
                title = "Request Jail Transport",
                serverEvent = "target:server:jail",
                args = data
            }
        }
	})

	lib.showContext('MenuInteractionOptionsPD') 
end)

local function IsTargetDead(playerId)
    local retval = false
    QBCore.Functions.TriggerCallback('police:server:isPlayerDead', function(result)
        retval = result
    end, playerId)
    Wait(100)
    return retval
end

local function HandCuffAnimation()
    local ped = PlayerPedId()
    if isHandcuffed == true then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
    end

    QBCore.Functions.RequestAnimDict("mp_arrest_paired")
	Wait(100)
    TaskPlayAnim(ped, "mp_arrest_paired", "cop_p2_back_right", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
	Wait(3500)
    TaskPlayAnim(ped, "mp_arrest_paired", "exit", 3.0, 3.0, -1, 48, 0, 0, 0, 0)
end

local function GetCuffedAnimation(playerId)
    local ped = PlayerPedId()
    local cuffer = GetPlayerPed(GetPlayerFromServerId(playerId))
    local heading = GetEntityHeading(cuffer)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "Cuff", 0.2)
    QBCore.Functions.RequestAnimDict("mp_arrest_paired")
    SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(cuffer, 0.0, 0.45, -0.85))
	Wait(100)
	SetEntityHeading(ped, heading)
	TaskPlayAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3.0, 3.0, -1, 32, 0, 0, 0, 0 ,true, true, true)
	Wait(1000)
end

-- Events

RegisterNetEvent('police:client:SetOutVehicle', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        TaskLeaveVehicle(ped, vehicle, 16)        
    end
end)

RegisterNetEvent('police:client:PutInVehicle', function(SentSeat)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local seat = SentSeat
    local ped = PlayerPedId()
    local seatsfree = {}
    if isHandcuffed or isEscorted or (PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"]) then
        
        if seat and IsVehicleSeatFree(vehicle, seat) then
            SetInCar(vehicle, tonumber(seat))
        else
            local vehicle = QBCore.Functions.GetClosestVehicle()
            if DoesEntityExist(vehicle) then
                for i=-1,GetVehicleMaxNumberOfPassengers(vehicle) do
                    if IsVehicleSeatFree(vehicle, i) then
                        seatsfree[i] = true
                    end
                end
                if seatsfree[2] then -- Priority List
                    SetInCar(vehicle, 2)
                elseif seatsfree[1] then
                    SetInCar(vehicle, 1)
                elseif seatsfree[0] then
                    SetInCar(vehicle, 0)
                elseif seatsfree[3] then
                    SetInCar(vehicle, 3)
                elseif seatsfree[4] then
                    SetInCar(vehicle, 4)
                elseif seatsfree[5] then
                    SetInCar(vehicle, 5)
                elseif seatsfree[6] then
                    SetInCar(vehicle, 6)
                end
            end
        end
    end
end)

function SetInCar(vehicle, seat)
    isEscorted = false
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    DetachEntity(ped, true, false)

    Wait(100)
    SetPedIntoVehicle(ped, vehicle, seat)
end


RegisterNetEvent('police:client:SearchPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        exports.ox_inventory:openInventory('player', playerId)
        TriggerServerEvent("police:server:SearchPlayer", playerId)
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNetEvent('police:client:SeizeCash', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeCash", playerId)
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNetEvent('police:client:SeizeDriverLicense', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        TriggerServerEvent("police:server:SeizeDriverLicense", playerId)
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)


RegisterNetEvent('police:client:RobPlayer', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local ped = PlayerPedId()
    if player ~= -1 and distance < 2.5 then
        if not (PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"]) then
            local playerPed = GetPlayerPed(player)
            local playerId = GetPlayerServerId(player)
            QBCore.Functions.TriggerCallback('prdx_playercontroller:GetPlayerPlaytime', function(playtime)
                if playtime <= 6000 then -- 100 hours of playtime n00b buffer
                    QBCore.Functions.Notify("Person has new immigration papers...", "error")
                end
                if Entity(playerPed).state.isDead or IsEntityPlayingAnim(playerPed, "missminuteman_1ig_2", "handsup_base", 3) or IsEntityPlayingAnim(playerPed, "mp_arresting", "idle", 3) or IsTargetDead(playerId) then
                    QBCore.Functions.Progressbar("robbing_player", "Robbing person..", math.random(5000, 7000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "random@shop_robbery",
                        anim = "robbery_action_b",
                        flags = 16,
                    }, {}, {}, function() -- Done
                        local plyCoords = GetEntityCoords(playerPed)
                        local pos = GetEntityCoords(ped)
                        if #(pos - plyCoords) < 2.5 then -- if they ran away
                            StopAnimTask(ped, "random@shop_robbery", "robbery_action_b", 1.0)
                            exports.ox_inventory:openInventory('player', playerId)
                            TriggerServerEvent('police:server:RobPlayer', playerId)
                        else
                            QBCore.Functions.Notify("No one nearby!", "error")
                        end
                    end, function() -- Cancel
                        StopAnimTask(ped, "random@shop_robbery", "robbery_action_b", 1.0)
                        QBCore.Functions.Notify("Canceled..", "error")
                    end)
                end
            end, playerId)
        else
            QBCore.Functions.Notify("Person is dead or not in handcuffs!", "error")
        end
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNetEvent('police:client:DNATest', function()
    local src = source
    local player, distance = QBCore.Functions.GetClosestPlayer()
    local ped = PlayerPedId()
    if player ~= -1 and distance < 2.5 then
        TriggerServerEvent('police:server:DNAResults', GetPlayerServerId(player))
    end
end)

RegisterNetEvent('police:client:JailCommand', function(playerId)
    local player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(playerId))
    if player == 0 then
        player = playerId
    end
    local result = lib.inputDialog("Jail",{
        { type = "number", label = "Enter length of jail time in months...", placeholder = "0" },
    })
    if not result then return end

    local time = tonumber(result[1])
    if time and player then
        TriggerServerEvent("police:server:JailPlayer", player, time)
    end

end)

RegisterNetEvent('police:client:BillCommand', function(playerId)
    local player = GetPlayerServerId(NetworkGetPlayerIndexFromPed(playerId))
    local result = lib.inputDialog('Fine',{
        { type = "number", label = "Enter fine amount", placeholder = "0" },
    })
    if not result then return end
    local fine = tonumber(result[1])

    if fine and player then
        TriggerServerEvent("police:server:BillPlayer", player, fine)
    end

end)

RegisterNetEvent('police:client:PutPlayerInVehicle', function(data)
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:PutPlayerInVehicle", playerId, data.seat)
        end
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNetEvent('police:client:SetPlayerOutVehicle', function(data)
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if data then
        local vehicle = QBCore.Functions.GetClosestVehicle()
        player = GetPedInVehicleSeat(vehicle, data.seat)
        local playerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(player))        
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:SetPlayerOutVehicle", playerId)
        end
    else
        if player ~= -1 and distance < 2.5 then
            local playerId = GetPlayerServerId(player)
            if not isHandcuffed and not isEscorted then
                TriggerServerEvent("police:server:SetPlayerOutVehicle", playerId)
            end
        else
            QBCore.Functions.Notify("No one nearby!", "error")
        end
    end
end)

RegisterNetEvent('police:client:EscortPlayer', function()
    
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local playerId = GetPlayerServerId(player)
        if not isHandcuffed and not isEscorted then
            TriggerServerEvent("police:server:EscortPlayer", playerId)
        end
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNetEvent('police:client:KidnapPlayer', function()
    local localPlayer = QBCore.Functions.GetPlayerData()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        if (PlayerData.metadata["isdead"] or isHandcuffed or PlayerData.metadata["inlaststand"]) or localPlayer.Job.name == 'ambulance' then
            local playerId = GetPlayerServerId(player)
            if not IsPedInAnyVehicle(GetPlayerPed(player)) then
                TriggerServerEvent("police:server:KidnapPlayer", playerId)
            end
        else
            QBCore.Functions.Notify("Player is not handcuffed or dead!", "error")
        end
    else
        QBCore.Functions.Notify("No one nearby!", "error")
    end
end)

RegisterNetEvent('police:client:CuffPlayerSoft', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 2.5 then
            if QBCore.Functions.HasItem("handcuffs") then
                local playerId = GetPlayerServerId(player)
                if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(GetPlayerPed(PlayerPedId())) then
                    TriggerServerEvent("police:server:CuffPlayer", playerId, true)
                    HandCuffAnimation()
                else
                    QBCore.Functions.Notify("You cant cuff someone in a vehicle", "error")
                end
            else
                QBCore.Functions.Notify("You don\'t have handcuffs on you", "error")
            end
        else
            QBCore.Functions.Notify("No one nearby!", "error")
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:CuffPlayerSoftCmd', function()
    if cuffedRecently == false then
        cuffedRecently = true
        if not IsPedRagdoll(PlayerPedId()) then
            local player, distance = QBCore.Functions.GetClosestPlayer()
            if player ~= -1 and distance < 2.5 then
                if QBCore.Functions.HasItem("handcuffs") then
                    local playerId = GetPlayerServerId(player)
                    if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(GetPlayerPed(PlayerPedId())) then
                        TriggerServerEvent("police:server:CuffPlayer", playerId, true)
                        HandCuffAnimation()
                    else
                        QBCore.Functions.Notify("You cant cuff someone in a vehicle", "error")
                    end
                else
                    QBCore.Functions.Notify("You don\'t have handcuffs on you", "error")
                end
            else
                QBCore.Functions.Notify("No one nearby!", "error")
            end
        else
            Wait(2000)
        end
        Wait(2500)
        cuffedRecently = false
    else
        QBCore.Functions.Notify("You've used your cuffs too recently!", "error")
    end

end)

RegisterNetEvent('police:client:CuffPlayer', function()
    if not IsPedRagdoll(PlayerPedId()) then
        local player, distance = QBCore.Functions.GetClosestPlayer()
        if player ~= -1 and distance < 2.5 then
            if QBCore.Functions.HasItem("handcuffs") then
                local playerId = GetPlayerServerId(player)
                if not IsPedInAnyVehicle(GetPlayerPed(player)) and not IsPedInAnyVehicle(GetPlayerPed(PlayerPedId())) then
                    TriggerServerEvent("police:server:CuffPlayer", playerId, false)
                    HandCuffAnimation()
                else
                    QBCore.Functions.Notify("You cant cuff someone in a vehicle", "error")
                end
            else
                QBCore.Functions.Notify("You don\'t have handcuffs on you", "error")
            end
        else
            QBCore.Functions.Notify("No one nearby!", "error")
        end
    else
        Wait(2000)
    end
end)

RegisterNetEvent('police:client:GetEscorted', function(playerId)
    local ped = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.metadata["isdead"] or isHandcuffed or PlayerData.metadata["inlaststand"] then
            if not isEscorted then
                isEscorted = true
                draggerId = playerId
                local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
                SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(dragger, 0.0, 0.45, 0.0))
                AttachEntityToEntity(ped, dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            else
                isEscorted = false
                DetachEntity(ped, true, false)
            end
        end
    end)
end)

RegisterNetEvent('police:client:DeEscort', function()
    isEscorted = false
    DetachEntity(PlayerPedId(), true, false)
end)

RegisterNetEvent('police:client:GetKidnappedTarget', function(playerId)
    local ped = PlayerPedId()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if not isEscorted then
            isEscorted = true
            draggerId = playerId
            local dragger = GetPlayerPed(GetPlayerFromServerId(playerId))
            RequestAnimDict("nm")

            while not HasAnimDictLoaded("nm") do
                Wait(10)
            end
            -- AttachEntityToEntity(PlayerPedId(), dragger, 11816, 0.45, 0.45, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            AttachEntityToEntity(ped, dragger, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
            TaskPlayAnim(ped, "nm", "firemans_carry", 8.0, -8.0, 100000, 33, 0, false, false, false)
        else
            isEscorted = false
            DetachEntity(ped, true, false)
            ClearPedTasksImmediately(ped)
        end
    end)
end)

RegisterNetEvent('police:client:GetKidnappedDragger', function(playerId)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if not isEscorting then
            draggerId = playerId
            local dragger = PlayerPedId()
            RequestAnimDict("missfinale_c2mcs_1")

            while not HasAnimDictLoaded("missfinale_c2mcs_1") do
                Wait(10)
            end
            TaskPlayAnim(dragger, "missfinale_c2mcs_1", "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
            isEscorting = true
        else
            local dragger = PlayerPedId()
            ClearPedSecondaryTask(dragger)
            ClearPedTasksImmediately(dragger)
            isEscorting = false
        end
        TriggerEvent('qb-kidnapping:client:SetKidnapping', isEscorting)
    end)
end)

-- No Skillcheck
-- RegisterNetEvent('police:client:GetCuffed', function(playerId, isSoftcuff)
--     local ped = PlayerPedId()
--     if not isHandcuffed then
--         isHandcuffed = true
--         TriggerServerEvent("police:server:SetHandcuffStatus", true)
--         ClearPedTasksImmediately(ped)
--         if GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED` then
--             SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
--         end
--         if not isSoftcuff then
--             cuffType = 16
--             GetCuffedAnimation(playerId)
--             QBCore.Functions.Notify("You are cuffed!")
--         else
--             cuffType = 49
--             GetCuffedAnimation(playerId)
--             QBCore.Functions.Notify("You are cuffed, but you can walk")
--         end
--         TriggerServerEvent("qb-log:server:CreateLog", "publicsafety", "Player Cuffed", "blue", "`" .. GetPlayerName(NetworkGetPlayerIndexFromPed(GetPlayerPed(GetPlayerFromServerId(playerId)))) .. "` has cuffed `" .. GetPlayerName(PlayerId()) .. "`", false, playerId)
--     else
--         isHandcuffed = false
--         isEscorted = false
--         DetachEntity(ped, true, false)
--         TriggerServerEvent("police:server:SetHandcuffStatus", false)
--         ClearPedTasksImmediately(ped)
--         TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
--         QBCore.Functions.Notify("You are uncuffed!")
--         TriggerServerEvent("qb-log:server:CreateLog", "publicsafety", "Player Uncuffed", "blue", "`" .. GetPlayerName(NetworkGetPlayerIndexFromPed(GetPlayerPed(GetPlayerFromServerId(playerId)))) .. "` has uncuffed `" .. GetPlayerName(PlayerId()) .. "`", false, playerId)
--     end
-- end) 

-- Skillcheck
local resistCount = 0
RegisterNetEvent('police:client:GetCuffed', function(playerId, isSoftcuff)
    local ped = PlayerPedId()
    if not isHandcuffed then --Not Cuffed, Try Cuff
        exports.npwd:setPhoneVisible(false)
        if not isSoftcuff then
            cuffType = 16
            GetCuffedAnimation(playerId)
            QBCore.Functions.Notify("You are being cuffed!")
        else
            cuffType = 49
            GetCuffedAnimation(playerId)
            QBCore.Functions.Notify("You are being cuffed, but you can walk")
        end
        local scDiff = 3 - resistCount
        -- local result = exports["skillcheck"]:StartCheck(scDiff, 3 + resistCount)
        local result
        if scDiff == 3 then
            result = lib.skillCheck({'easy', 'easy', 'easy'})
        elseif scDiff == 2 then
            result = lib.skillCheck({'medium', 'medium', 'medium', 'medium'})
        elseif scDiff == 1 then
            result = lib.skillCheck({'hard', 'hard', 'hard', 'hard', 'hard'})
        else
            result = lib.skillCheck({{ areaSize = 0, speedMultiplier = 5 }})
        end
        if result == false then -- Player failed the skillcheck and should be cuffed
            resistCount = 0
            isHandcuffed = true
            TriggerServerEvent("police:server:SetHandcuffStatus", true)
            TriggerEvent("police:client:SetHandcuffStatus", true)
            ClearPedTasksImmediately(ped)
            if GetSelectedPedWeapon(ped) ~= `WEAPON_UNARMED` then
                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
            end
            TriggerServerEvent("qb-log:server:CreateLog", "publicsafety", "Player Cuffed", "blue", "`" .. GetPlayerName(NetworkGetPlayerIndexFromPed(GetPlayerPed(GetPlayerFromServerId(playerId)))) .. "` has cuffed `" .. GetPlayerName(PlayerId()) .. "`", false, playerId)
            TriggerServerEvent("police:server:ResistCuffNotify", playerId, 'Player Cuffed')
        else -- Player passed the skillcheck
            TriggerServerEvent("qb-log:server:CreateLog", "publicsafety", "Player Resisted Cuffs", "blue", "`" .. GetPlayerName(NetworkGetPlayerIndexFromPed(GetPlayerPed(GetPlayerFromServerId(playerId)))) .. "` tried to cuff `" .. GetPlayerName(PlayerId()) .. "` but they resisted ", false, playerId)
            --Notify player they broke free
            QBCore.Functions.Notify("You resisted the cuffs!")
            resistCount = resistCount + 1
            --Notify cuffer they failed to cuff            
            TriggerServerEvent("police:server:ResistCuffNotify", playerId, 'Cuffs were resisted!')
            --Not Done
        end
    else --Already Cuffed
        isHandcuffed = false
        isEscorted = false
        DetachEntity(ped, true, false)
        TriggerEvent("police:client:SetHandcuffStatus", false)
        TriggerServerEvent("police:server:SetHandcuffStatus", false)
        ClearPedTasksImmediately(ped)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Uncuff", 0.2)
        QBCore.Functions.Notify("You are uncuffed!")
        TriggerServerEvent("qb-log:server:CreateLog", "publicsafety", "Player Uncuffed", "blue", "`" .. GetPlayerName(NetworkGetPlayerIndexFromPed(GetPlayerPed(GetPlayerFromServerId(playerId)))) .. "` has uncuffed `" .. GetPlayerName(PlayerId()) .. "`", false, playerId)
        Wait(1000)
        exports.npwd:setPhoneDisabled(false)
    end
end)

-- Threads

CreateThread(function()
    while true do
        Wait(1)
        if isEscorted then
            DisableAllControlActions(0)
            EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)
            EnableControlAction(0, 245, true)
            EnableControlAction(0, 38, true)
            EnableControlAction(0, 322, true)
	    EnableControlAction(0, 249, true)
            EnableControlAction(0, 46, true)
        end

        if isHandcuffed then
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			--DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			-- DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
	    	EnableControlAction(0, 249, true) -- Added for talking while cuffed
            EnableControlAction(0, 46, true)  -- Added for talking while cuffed

            if (not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(PlayerPedId(), "mp_arrest_paired", "crook_p2_back_right", 3)) and not QBCore.Functions.GetPlayerData().metadata["isdead"] and not QBCore.Functions.GetPlayerData().metadata["inlaststand"] then
                QBCore.Functions.RequestAnimDict("mp_arresting")
                TaskPlayAnim(PlayerPedId(), "mp_arresting", "idle", 8.0, -8, -1, cuffType, 0, 0, 0, 0)
            end
        end
        if not isHandcuffed and not isEscorted then
            Wait(2000)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if isHandcuffed then
            exports.npwd:setPhoneDisabled(true)
        end
    end
end)