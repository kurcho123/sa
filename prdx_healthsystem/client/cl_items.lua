QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('prdx_healthsystem:client:UseBandage', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_bandage", "Using bandage..", 8000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
		anim = "weed_inspecting_high_base_inspector",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        TriggerServerEvent("prdx_healthsystem:server:removeBandage")
        SetPlayerHealth(cache.ped, 100)
        RemovePlayerBleed(1)
        QBCore.Functions.Notify("-Bleed")
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('prdx_healthsystem:client:UseIFAK', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_ifak", "Using IFAK..", 24000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
		anim = "weed_inspecting_high_base_inspector",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        SetPlayerHealth(cache.ped, 100)
        RemovePlayerBleed(2)
        QBCore.Functions.Notify("-Bleed")
        if math.random(1, 100) < 50 then
            QBCore.Functions.Notify("-Injury")
            HealAllInjuries()
        end
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('prdx_healthsystem:client:UseITK', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_itk", "Using ITK..", 15000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "anim@amb@business@weed@weed_inspecting_high_dry@",
		anim = "weed_inspecting_high_base_inspector",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        SetPlayerHealth(cache.ped, 100)
        RemovePlayerBleed(2)
        QBCore.Functions.Notify("-Bleed")
        if math.random(1, 100) < 50 then
            QBCore.Functions.Notify("-Injury")
            HealAllInjuries()
        end
    end, function() -- Cancel
        StopAnimTask(ped, "anim@amb@business@weed@weed_inspecting_high_dry@", "weed_inspecting_high_base_inspector", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('prdx_healthsystem:client:UseSertraline', function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("use_painkillers", "Taking Sertraline", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "mp_suicide", "pill", 1.0)
        TriggerServerEvent("prdx_healthsystem:server:removeSertraline")
        TriggerServerEvent('hud:server:RelieveStress', 100)
    end, function() -- Cancel
        StopAnimTask(ped, "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)