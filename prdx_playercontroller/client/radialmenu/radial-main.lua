local QBCore = exports['qb-core']:GetCoreObject()

-- Misc Functions
local function isPoliceOrEMS()
    local PlayerData = QBCore.Functions.GetPlayerData()
    return (PlayerData.job.name == "ambulance" or PlayerData.job.name == "marshalls" or PlayerData.job.name == "lspd" or PlayerData.job.name == "bcso" or PlayerData.job.name == "sast" or PlayerData.job.name == "hc" or PlayerData.job.name == "pd_cid")
end

local function isPolice()
    local PlayerData = QBCore.Functions.GetPlayerData()
    return (PlayerData.job.name == "marshalls" or PlayerData.job.name == "lspd" or PlayerData.job.name == "bcso" or PlayerData.job.name == "sast" or PlayerData.job.name == "hc" or PlayerData.job.name == "pd_cid")
end

-- Global Options
local addedGlobal = false
CreateThread(function()
    while true do
        Wait(1000)
        if not addedGlobal then
            lib.addRadialItem({
                {
                  id = 'citizen',
                  label = 'Self Actions',
                  icon = 'user',
                  menu = 'citizen_menu'
                },
                {
                  id = 'house',
                  label = 'House Interaction',
                  icon = 'house',
                  menu = 'house_menu'
                }
            })
            addedGlobal = true
        end
    end
end)

-- citizen_menu (Self Actions)
RegisterNetEvent('prdx_playercontroller:permsloaded', function (getPerms)
    local items = {
        {
            label = 'Give Contact Info',
            icon = 'address-book',
            onSelect = function()
                TriggerEvent('radialmenu:client:GiveContact')
            end
          },
          {
            label = 'Hair',
            icon = 'user',
            onSelect = function()
                TriggerEvent('radialmenu:client:ToggleClothing', "hair")
            end
          },
          {
            label = 'Corner Selling',
            icon = 'cannabis',
            onSelect = function()
                TriggerEvent('prdx_drugs:client:cornerselling')
            end
          }
    }
    if getPerms then
        if getPerms.serverOne.vip1 or getPerms.serverOne.vip2 or getPerms.serverOne.vip3 or getPerms.serverOne.vip3 or getPerms.staff.staff or getPerms.staff.admin or getPerms.staff.headadmin or getPerms.staff.director then
            items[#items+1] = {
                label = 'Rob Person',
                icon = 'mask',
                onSelect = function()
                    TriggerEvent('police:client:RobPlayer')
                end
            }
        end
    end
    lib.registerRadial({
        id = 'citizen_menu',
        items = items
    })
end)

-- house_menu (House Interaction)
lib.registerRadial({
    id = 'house_menu',
    items = {
      {
        label = 'Give House Keys',
        icon = 'key',
        onSelect = function()
            TriggerEvent('qb-houses:client:giveHouseKey')
        end
      },
      {
        label = 'Remove House Keys',
        icon = 'key',
        onSelect = function()
            TriggerEvent('qb-houses:client:removeHouseKey')
        end
      },
      {
        label = 'Toggle Doorlock',
        icon = 'door-closed',
        onSelect = function()
            TriggerEvent('qb-houses:client:toggleDoorlock')
        end
      },
      {
        label = 'Decorate House',
        icon = 'boxes-stacked',
        onSelect = function()
            TriggerEvent('qb-houses:client:decorate')
        end
      },
      {
        label = 'Locations',
        icon = 'house',
        menu = 'house_locations_menu'
      }
    }
})
-- house_locations_menu (Interaction Locations)
lib.registerRadial({
    id = 'house_locations_menu',
    items = {
      {
        label = 'Set Stash',
        icon = 'box-open',
        onSelect = function()
            TriggerEvent('qb-houses:client:setLocation', {id = "setstash"})
        end
      },
      {
        label = 'Set Wardrobe',
        icon = 'tshirt',
        onSelect = function()
            TriggerEvent('qb-houses:client:setLocation', {id = "setoutfit"})
        end
      },
      {
        label = 'Set Logout',
        icon = 'door-open',
        onSelect = function()
            TriggerEvent('qb-houses:client:setLocation', {id = "setlogout"})
        end
      },
      {
        label = 'Set Garage',
        icon = 'warehouse',
        onSelect = function()
            TriggerEvent('qb-houses:client:addGarage')
        end
      }
    }
})

-- remove dead options on revive and add back regular options
RegisterNetEvent('prdx_healthsystem:server:syncInjuries', function(isDead)
    if not isDead then
        addedGlobal = false
        lib.removeRadialItem('emergency_buttons')
    else
        lib.removeRadialItem('citizen')
        lib.removeRadialItem('house')
        lib.removeRadialItem('emotes')
        lib.removeRadialItem('police_interactions')
        lib.removeRadialItem('ambulance_interactions')
        lib.removeRadialItem('tow_interactions')
        lib.removeRadialItem('gopostal_interactions')
    
        if isPoliceOrEMS() then
            lib.addRadialItem({
                {
                  id = 'emergency_buttons',
                  label = 'Emergency buttons',
                  icon = 'bell',
                  menu = 'emergency_buttons_menu'
                }
            })
        end
    end
end)

-- Job Options
local function setupJobOptions(PlayerJob)
    -- remove residual menus
    lib.removeRadialItem('police_interactions')
    lib.removeRadialItem('ambulance_interactions')
    lib.removeRadialItem('tow_interactions')
    lib.removeRadialItem('gopostal_interactions')

    -- Police/EMS
    if isPoliceOrEMS() then
        -- Emergency Buttons
        lib.registerRadial({
            id = 'emergency_buttons_menu',
            items = {
            {
                label = 'Emergency button',
                icon = 'bell',
                onSelect = function()
                    TriggerEvent('cd_dispatch:PanicButtonEvent')
                end
            },
            {
                label = 'Non-Emergency button',
                icon = 'bell',
                onSelect = function()
                    TriggerEvent('cd_dispatch:NonEmergencyButtonEvent')
                end
            }
            }
        })
        -- Radio
        lib.registerRadial({
            id = 'radio_menu',
            items = {
            {
                label = 'LEO Main',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 1)
                end,
                keepOpen = true
            },
            {
                label = 'LEO TAC 1',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 2)
                end,
                keepOpen = true
            },
            {
                label = 'LEO TAC 2',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 3)
                end,
                keepOpen = true
            },
            {
                label = 'LEO TAC 3',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 4)
                end,
                keepOpen = true
            },
            {
                label = 'Fire/EMS Main',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 5)
                end,
                keepOpen = true
            },
            {
                label = 'Fire/EMS TAC 1',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 6)
                end,
                keepOpen = true
            },
            {
                label = 'Fire/EMS TAC 2',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 7)
                end,
                keepOpen = true
            },
            {
                label = 'Fire/EMS TAC 3',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 8)
                end,
                keepOpen = true
            },
            {
                label = 'SADOT Main',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 9)
                end,
                keepOpen = true
            },
            {
                label = 'SADOT Alt',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 10)
                end,
                keepOpen = true
            },
            }
        })
    end

    -- Police
    if isPolice() then
        lib.addRadialItem({
            {
                id = 'police_interactions',
                label = 'Police Interactions',
                icon = 'shield-halved',
                menu = 'police_interactions_menu'
            }
        })
        -- Police Interactions Menu
        lib.registerRadial({
            id = 'police_interactions_menu',
            items = {
            {
                label = 'Emergency buttons',
                icon = 'bell',
                menu = 'emergency_buttons_menu'
            },
            {
                label = 'Objects',
                icon = 'road',
                menu = 'police_objects_menu'
            },
            {
                label = 'Radio Channels',
                icon = 'tower-broadcast',
                menu = 'radio_menu'
            }
            }
        })
        -- Police Objects Menu
        lib.registerRadial({
            id = 'police_objects_menu',
            items = {
            {
                label = 'Cone',
                icon = 'exclamation-triangle',
                onSelect = function()
                    TriggerEvent('police:client:spawnCone')
                end
            },
            {
                label = 'Barrier',
                icon = 'torii-gate',
                onSelect = function()
                    TriggerEvent('police:client:spawnBarier')
                end
            },
            {
                label = 'Speed Limit Sign',
                icon = 'sign',
                onSelect = function()
                    TriggerEvent('police:client:spawnSchotten')
                end
            },
            {
                label = 'Tent',
                icon = 'campground',
                onSelect = function()
                    TriggerEvent('police:client:spawnTent')
                end
            },
            {
                label = 'Light',
                icon = 'lightbulb',
                onSelect = function()
                    TriggerEvent('police:client:spawnLight')
                end
            },
            {
                label = 'Remove object',
                icon = 'trash',
                onSelect = function()
                    TriggerEvent('police:client:deleteObject')
                end
            },
            }
        })
    end

    -- Ambulance
    if PlayerJob == "ambulance" then
        lib.addRadialItem({
            {
                id = 'ambulance_interactions',
                label = 'EMS Interactions',
                icon = 'briefcase-medical',
                menu = 'ambulance_interactions_menu'
            }
        })
        -- EMS Interactions Menu
        lib.registerRadial({
            id = 'ambulance_interactions_menu',
            items = {
            {
                label = 'Emergency buttons',
                icon = 'bell',
                menu = 'emergency_buttons_menu'
            },
            {
                label = 'Radio Channels',
                icon = 'tower-broadcast',
                menu = 'radio_menu'
            }
            }
        })
    end

    -- Tow
    if PlayerJob == "tow" then
        lib.addRadialItem({
            {
              id = 'tow_interactions',
              label = 'SADOT Interactions',
              icon = 'snowplow',
              menu = 'tow_interactions_menu'
            }
        })
        -- SADOT Interactions Menu
        lib.registerRadial({
            id = 'tow_interactions_menu',
            items = {
            {
                label = 'Snowplowing',
                icon = 'snowflake',
                onSelect = function()
                    TriggerEvent('prdx_smallmissions:client:openSnowplowMenu')
                end
            },
            {
                label = 'Radio Channels',
                icon = 'tower-broadcast',
                menu = 'tow_radio_menu'
            }
            }
        })
        -- SADOT Radio Menu
        lib.registerRadial({
            id = 'tow_radio_menu',
            items = {
            {
                label = 'SADOT Main',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 9)
                end,
                keepOpen = true
            },
            {
                label = 'SADOT Alt',
                icon = 'right-to-bracket',
                onSelect = function()
                    TriggerEvent('target:client:setRadio', 10)
                end,
                keepOpen = true
            },
            }
        })
    end

    -- Go Postal
    if PlayerJob == "gopostal" then
        lib.addRadialItem({
            {
              id = 'gopostal_interactions',
              label = 'Go Postal Interactions',
              icon = 'box',
              menu = 'gopostal_interactions_menu'
            }
        })
        -- Go Postal Interactions Menu
        lib.registerRadial({
            id = 'gopostal_interactions_menu',
            items = {
            {
                label = 'Open Deliveries',
                icon = 'tablet-screen-button',
                onSelect = function()
                    TriggerEvent('prdx_gopostal:client:getDeliveriesMenu')
                end
            },
            {
                label = 'Toggle Duty',
                icon = 'briefcase',
                onSelect = function()
                    TriggerServerEvent('qb-radialmenu:server:SetDuty')
                end
            }
            }
        })
    end
end

-- if player changes job
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    local PlayerJob = JobInfo.name
    setupJobOptions(PlayerJob)
end)

-- Vehicle Menus
-- Vehicle functions
local seats = {}
local function setupSeats(vehicle)
    local seatTable = {
        [1] = "Drivers Seat",
        [2] = "Passenger Seat",
        [3] = "Rear Left Seat",
        [4] = "Rear Right Seat",
    }

    local AmountOfSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))

    for i = 1, AmountOfSeats do
        seats[#seats+1] = {
            label = seatTable[i] or "Other Seat",
            icon = 'caret-up',
            onSelect = function()
                TriggerEvent('radialmenu:client:ChangeSeat', i - 2, seatTable[i] or "Other Seat")
            end
        }
    end

    -- Vehicle Seats Menu
    lib.registerRadial({
        id = 'vehicle_seats_menu',
        items = seats
    })
end
local function setupMenu(vehicle)
    local options = {
        {
            label = 'Vehicle Seats',
            icon = 'chair',
            menu = 'vehicle_seats_menu'
        },
        {
            label = 'Vehicle Controls',
            icon = 'car',
            onSelect = function()
                TriggerEvent('vehcontrol:openExternal')
            end
        },
        {
            label = 'Toggle Attach',
            icon = 'wrench',
            onSelect = function()
                TriggerEvent('prdx_trailers:toggleVehicle')
            end
        }
    }

    -- Boat options
    if IsThisModelABoat(GetEntityModel(vehicle)) or GetVehicleClass(vehicle) == 14 then
        if IsBoatAnchoredAndFrozen(vehicle) then
            options[#options+1] = {
                label = 'Pull Boat Anchor',
                icon = 'anchor',
                onSelect = function()
                    TriggerEvent('prdx_vehiclecontroller:client:AnchorBoat')
                end
            }
        elseif CanAnchorBoatHere(vehicle) then
            options[#options+1] = {
                label = 'Throw Boat Anchor',
                icon = 'anchor',
                onSelect = function()
                    TriggerEvent('prdx_vehiclecontroller:client:AnchorBoat')
                end
            }
        else
            QBCore.Functions.Notify('Boat anchor unavailable', 'error')  
        end
    end

    -- Extras options
    local extraJobTable = {["lspd"], ["bcso"], ["sast"], ["hc"], ["marshalls"], ["pd_cid"], ["ambulance"], ["tow"], ["gopostal"], ["clinic"]}
    if extraJobTable[QBCore.Functions.GetPlayerData().job.name] then
        local VehicleExtrasItems = {}
        local numExtras = 0
        local pages = 1
        for i=1,20 do
            if DoesExtraExist(vehicle, i) then
                numExtras = numExtras + 1
            end
        end
        if numExtras > 15 then
            pages = 4
        elseif numExtras > 10 then
            pages = 3
        elseif numExtras > 5 then
            pages = 2
        end
        if pages == 1 then
            for i=1,numExtras do
                VehicleExtrasItems[#VehicleExtrasItems+1] = {
                    label = 'Extra ' .. i,
                    onSelect = function()
                        TriggerEvent('radialmenu:client:setExtra', i)
                    end
                }
            end
        elseif pages > 1 then
            local MenuItems = {}
            if not MenuItems[1] then MenuItems[1] = {} end
            if not MenuItems[2] then MenuItems[2] = {} end
            if not MenuItems[3] then MenuItems[3] = {} end
            if not MenuItems[4] then MenuItems[4] = {} end
            for i=1,5 do
                if DoesExtraExist(vehicle, i) then
                    MenuItems[1][#MenuItems[1]+1] = {
                        label = 'Extra ' .. i,
                        onSelect = function()
                            TriggerEvent('radialmenu:client:setExtra', i)
                        end,
                        keepOpen = true
                    }
                end
            end
            for i=6,10 do
                if DoesExtraExist(vehicle, i) then
                    MenuItems[2][#MenuItems[2]+1] = {
                        label = 'Extra ' .. i,
                        onSelect = function()
                            TriggerEvent('radialmenu:client:setExtra', i)
                        end,
                        keepOpen = true
                    }
                end
            end
            for i=11,15 do
                if DoesExtraExist(vehicle, i) then
                    MenuItems[3][#MenuItems[3]+1] = {
                        label = 'Extra ' .. i,
                        onSelect = function()
                            TriggerEvent('radialmenu:client:setExtra', i)
                        end,
                        keepOpen = true
                    }
                end
            end
            for i=16,20 do
                if DoesExtraExist(vehicle, i) then
                    MenuItems[4][#MenuItems[4]+1] = {
                        label = 'Extra ' .. i,
                        onSelect = function()
                            TriggerEvent('radialmenu:client:setExtra', i)
                        end,
                        keepOpen = true
                    }
                end
            end

            for page=1,pages do
                VehicleExtrasItems[#VehicleExtrasItems+1] = {
                    label = 'Page ' .. page,
                    icon = page,
                    menu = 'vehicle_extras_menu_page' .. page
                }

                lib.registerRadial({
                    id = 'vehicle_extras_menu_page' .. page,
                    items = MenuItems[page]
                })
            end
        end

        options[#options+1] = {
            label = 'Vehicle Extras',
            icon = 'car',
            menu = 'vehicle_extras_menu'
        }

        -- Vehicle Extras Menu
        lib.registerRadial({
            id = 'vehicle_extras_menu',
            items = VehicleExtrasItems
        })
    end

    -- Vehicle Interactions Menu
    lib.registerRadial({
        id = 'vehicle_interactions_menu',
        items = options
    })
end
function getNearestVeh()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 20.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
    return vehicleHandle
end

-- Check if in or looking at vehicle
lib.onCache('vehicle', function(value)
    if not value then
        lib.removeRadialItem('vehicle')
        seats = {}
        return
    end
    lib.removeRadialItem('vehicle_doors')
    lib.addRadialItem({
        {
          id = 'vehicle',
          label = 'Vehicle Interactions',
          icon = 'car',
          menu = 'vehicle_interactions_menu'
        }
    })
    setupSeats(value)
    setupMenu(value)
end)
local added = false
CreateThread(function()
    while true do
        Wait(1000)
        local vehicle = getNearestVeh()
        if vehicle ~= 0 and GetVehicleDoorLockStatus(vehicle) < 2 and not added then
            lib.removeRadialItem('vehicle')
            lib.removeRadialItem('vehicle_doors')
            lib.addRadialItem({
                {
                  id = 'vehicle_doors',
                  label = 'Vehicle Doors',
                  icon = 'car-side',
                  menu = 'vehicle_doors_menu'
                }
            })
            -- Vehicle Doors Menu
            local doors = {
                {
                    label = 'Drivers door',
                    icon = 'car-side',
                    onSelect = function()
                        TriggerEvent('radialmenu:client:openDoor', 0)
                    end
                }, {
                    label = 'Hood',
                    icon = 'car',
                    onSelect = function()
                        TriggerEvent('radialmenu:client:openDoor', 4)
                    end
                }, {
                    label = 'Passengers door',
                    icon = 'car-side',
                    onSelect = function()
                        TriggerEvent('radialmenu:client:openDoor', 1)
                    end
                }, {
                    label = 'Right rear',
                    icon = 'car-side',
                    onSelect = function()
                        TriggerEvent('radialmenu:client:openDoor', 3)
                    end
                }, {
                    label = 'Trunk',
                    icon = 'car',
                    onSelect = function()
                        TriggerEvent('radialmenu:client:openDoor', 5)
                    end
                }, {
                    label = 'Left rear',
                    icon = 'car-side',
                    onSelect = function()
                        TriggerEvent('radialmenu:client:openDoor', 2)
                    end
                }
            }
            lib.registerRadial({
                id = 'vehicle_doors_menu',
                items = doors
            })
            added = true
        elseif (vehicle == 0 or GetVehicleDoorLockStatus(vehicle) >= 2) and added then
            lib.removeRadialItem('vehicle_doors')
            added = false
        end
    end
end)

-- setup job & vehicle if resource restarted
CreateThread(function()
    if LocalPlayer.state['isLoggedIn'] then
        setupJobOptions(QBCore.Functions.GetPlayerData().job.name)
        if cache.vehicle then
            lib.addRadialItem({
                {
                id = 'vehicle',
                label = 'Vehicle Interactions',
                icon = 'car',
                menu = 'vehicle_interactions_menu'
                }
            })
            setupSeats(cache.vehicle)
            setupMenu(cache.vehicle)
        end
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    setupJobOptions(QBCore.Functions.GetPlayerData().job.name)
end)