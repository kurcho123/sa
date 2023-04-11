local currentGate = 0
local requiredItemsShowed = false
local requiredItems = {}
local inRange = false
local securityLockdown = false

local Gates = {
    [1] = {
        gatekey = 'maingateeast',
        coords = vector3(1845.99, 2604.7, 45.58),
        hit = false,
    },
    [2] = {
        gatekey = 'maingatewest',
        coords = vector3(1819.47, 2604.67, 45.56),
        hit = false,
    },
    [3] = {
        gatekey = 'exitfencewalkway',
        coords = vector3(1797.2, 2597.0, 45.59),
        hit = false,
    }
}

-- Functions

local function OnHackDone(success)
    if success then
        TriggerServerEvent("prison:server:SetGateHit", currentGate)
		TriggerServerEvent('qb-doorlock:server:updateState', Gates[currentGate].gatekey, false, true, true)
		TriggerEvent('mhacking:hide')
    else
        TriggerServerEvent("prison:server:SecurityLockdown")
		TriggerEvent('mhacking:hide')
	end
end

-- Events
RegisterNetEvent('electronickit:UseElectronickit', function()
    
    if currentGate ~= 0 and not securityLockdown and not Gates[currentGate].hit then
        if QBCore.Functions.HasItem("thermite") then
            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
            QBCore.Functions.Progressbar("hack_gate", "Electronic kit plug in..", math.random(5000, 10000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "anim@gangops@facility@servers@",
                anim = "hotwire",
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                TriggerEvent("mhacking:show")
                TriggerEvent("mhacking:start", math.random(3, 6), math.random(20, 25), OnHackDone)
            end, function() -- Cancel
                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                QBCore.Functions.Notify("Cancelled..", "error")
            end)
        else
            QBCore.Functions.Notify("You're missing an item..", "error")
        end
    end
end)

RegisterNetEvent('prison:client:SetLockDown', function(isLockdown)
    securityLockdown = isLockdown
    if securityLockdown and inJail then
        TriggerEvent("chatMessage", "HOSTAGE", "error", "Highest security level is active, stay with the cell blocks!")
    end
end)

RegisterNetEvent('prison:client:PrisonBreakAlert', function()
    -- TriggerEvent("chatMessage", "ALERT", "error", "Attentie alle eenheden! Poging tot uitbraak in de gevangenis!")
    TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
        timeOut = 10000,
        alertTitle = "Prison outbreak",
        details = {
            [1] = {
                icon = '<i class="fas fa-lock"></i>',
                detail = "Boilingbroke Penitentiary",
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = "Route 68",
            },
        },
        callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
    })

    local BreakBlip = AddBlipForCoord(Config.Locations["middle"].coords.x, Config.Locations["middle"].coords.y, Config.Locations["middle"].coords.z)
    TriggerServerEvent('prison:server:JailAlarm')
	SetBlipSprite(BreakBlip , 161)
	SetBlipScale(BreakBlip , 3.0)
	SetBlipColour(BreakBlip, 3)
	PulseBlip(BreakBlip)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    Wait(100)
    PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Wait(100)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    Wait(100)
    PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Wait((1000 * 60 * 5))
    RemoveBlip(BreakBlip)
end)

RegisterNetEvent('prison:client:SetGateHit', function(key, isHit)
    Gates[key].hit = isHit
end)

RegisterNetEvent('prison:client:JailAlarm', function(toggle)
    if toggle then
        local alarmIpl = GetInteriorAtCoordsWithType(1787.004,2593.1984,45.7978, "int_prison_main")

        RefreshInterior(alarmIpl)
        EnableInteriorProp(alarmIpl, "prison_alarm")

        CreateThread(function()
            while not PrepareAlarm("PRISON_ALARMS") do
                Wait(100)
            end
            StartAlarm("PRISON_ALARMS", true)
        end)
    else
        local alarmIpl = GetInteriorAtCoordsWithType(1787.004,2593.1984,45.7978, "int_prison_main")

        RefreshInterior(alarmIpl)
        DisableInteriorProp(alarmIpl, "prison_alarm")

        CreateThread(function()
            while not PrepareAlarm("PRISON_ALARMS") do
                Wait(100)
            end
            StopAllAlarms(true)
        end)
    end
end)

-- Threads

CreateThread(function()
    Wait(500)
    requiredItems = {
        [1] = {name = "electronickit", image = exports.ox_inventory:Items()["electronickit"]["image"]},
        [2] = {name = "gatecrack", image = exports.ox_inventory:Items()["gatecrack"]["image"]},
    }
    while true do
        Wait(5)
        inRange = false
        currentGate = 0
        if LocalPlayer.state.isLoggedIn then
            if PlayerJob.name ~= "police" then
                local pos = GetEntityCoords(PlayerPedId())
                for k, v in pairs(Gates) do
                    local dist =  #(pos - Gates[k].coords)
                    if (dist < 1.5) then
                        currentGate = k
                        inRange = true
                        if securityLockdown then
                            DrawText3D(Gates[k].coords.x, Gates[k].coords.y, Gates[k].coords.z, "~r~SYSTEM LOCKDOWN")
                        elseif Gates[k].hit then
                            DrawText3D(Gates[k].coords.x, Gates[k].coords.y, Gates[k].coords.z, "SYSTEM BREACH")
                        elseif not requiredItemsShowed then
                            requiredItemsShowed = true
                            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
                        end
                    end
                end

                if not inRange then
                    if requiredItemsShowed then
                        requiredItemsShowed = false
                        TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                    end
                    Wait(1000)
                end
            else
                Wait(1000)
            end
        else
            Wait(5000)
        end
    end
end)

local PrisonZone = PolyZone:Create({
    vector2(1823.7407226563, 2475.3930664063),
    vector2(1760.9300537109, 2410.1040039063),
    vector2(1659.2530517578, 2395.0642089844),
    vector2(1541.380859375, 2469.7209472656),
    vector2(1535.8454589844, 2584.6960449219),
    vector2(1570.0028076172, 2679.9223632813),
    vector2(1650.0240478516, 2757.8278808594),
    vector2(1773.267578125, 2762.2282714844),
    vector2(1848.2181396484, 2699.5244140625),
    vector2(1823.4418945313, 2621.4340820313),
    vector2(1819.9617919922, 2597.9792480469),
    vector2(1838.2340087891, 2597.7348632813),
    vector2(1837.173828125, 2567.8989257813),
    vector2(1819.4858398438, 2568.8984375),
    vector2(1816.9759521484, 2532.1450195313)
  }, {
    name="Prison",
    --minZ = 45.528114318848,
    --maxZ = 45.805561065674
  })

CreateThread(function()
	while true do
		Wait(1000)
		local pos = GetEntityCoords(PlayerPedId(), true)
        if LocalPlayer.state.isLoggedIn then
            if not PrisonZone:isPointInside(pos) and QBCore.Functions.GetPlayerData().metadata["injail"] > 0 then
                inJail = false
                jailTime = 0
                RemoveBlip(currentBlip)
                RemoveBlip(CellsBlip)
                CellsBlip = nil
                RemoveBlip(TimeBlip)
                TimeBlip = nil
                RemoveBlip(ShopBlip)
                ShopBlip = nil
                TriggerServerEvent("prison:server:SecurityLockdown")
                TriggerEvent('prison:client:PrisonBreakAlert')
                TriggerServerEvent("prison:server:SetJailStatus", 0)
                TriggerServerEvent("QBCore:Server:SetMetaData", "jailitems", {})
                QBCore.Functions.Notify("You escaped... Get the hell out of here.!", "error")
            end
        end
	end
end)

function IsPlayerInsidePrisonZone()
    local pos = GetEntityCoords(PlayerPedId(), true)
    if PrisonZone:isPointInside(pos) then
        return true
    end
    return false
end

exports("IsPlayerInsidePrisonZone", IsPlayerInsidePrisonZone)