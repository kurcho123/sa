QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('weapons:client:GunCleaningKit', function()
    local ped = cache.ped
    local pass = lib.skillCheck({'easy', 'easy', 'easy', 'easy', 'easy'})
    if pass then
        LocalPlayer.state:set("inv_busy", true, true)
        QBCore.Functions.Progressbar("cleaning_gun", "Cleaning weapon...", 3500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        },{ 
            animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
            anim = "weed_inspecting_high_base_inspector",
            flags = 49,
        }, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
            LocalPlayer.state:set("inv_busy", false, true)
            TriggerServerEvent("weapons:server:SetWeaponQuality", 100)
        end, function()
            StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
            LocalPlayer.state:set("inv_busy", false, true)
            QBCore.Functions.Notify("Canceled", "error")
        end)
    else
        QBCore.Functions.Notify('Failed to clean gun', 'error')
        TriggerServerEvent('hud:server:GainStress', math.random(2, 4)) 
    end
end)

local repairZones = {
    [1] = {
        location = "MRPD",
        coords = vector3(487.83, -997.03, 30.69),
        size = vec3(1, 2, 2.5),
        rotation = 0
    },
    [2] = {
        location = "Davis",
        coords = vector3(361.95, -1603.78, 25.45),
        size = vec3(1, 2, 2.5),
        rotation = 50
    },
    [3] = {
        location = "Sandy",
        coords = vector3(1863.21, 3688.68, 33.7),
        size = vec3(1.2, 0.6, 1),
        rotation = 210
    },
    [4] = {
        location = "ELS Fire",
        coords = vector3(1209.12, -1475.93, 34.86),
        size = vec3(1.0, 0.6, 1),
        rotation = 0
    },
}

for k,v in pairs(repairZones) do
    exports.ox_target:addBoxZone({
        coords = v.coords,
        size = v.size,
        rotation = v.rotation,
        debug = false,
        options = {
            {
                name = "weapon_repair_" .. v.location,
                event = 'weapons:client:openRepairStation',
                icon = 'fas fa-wrench',
                label = 'Open Repair Station'
            }
        }
    })
end

RegisterNetEvent('weapons:client:openRepairStation', function()
    exports.ox_inventory:openInventory('stash', 'weapon_repair')
end)