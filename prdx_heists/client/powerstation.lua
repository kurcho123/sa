-- Functions
function thermiteAnimation(k)
    lib.requestAnimDict('anim@heists@ornate_bank@thermal_charge')
    lib.requestModel('hei_p_m_bag_var22_arm_s')
    lib.requestNamedPtfxAsset('scr_ornate_heist')
    local ped = cache.ped

    SetEntityHeading(ped, Config.PowerStations[k]['coords'].w)
    Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local scene1 = NetworkCreateSynchronisedScene(Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z, rotx, roty, rotz + 1.1, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(joaat('hei_p_m_bag_var22_arm_s'), Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z,  true,  true, false)

    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, scene1, 'anim@heists@ornate_bank@thermal_charge', 'thermal_charge', 1.2, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, 'anim@heists@ornate_bank@thermal_charge', 'bag_thermal_charge', 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(scene1)
    Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local thermiteObj = CreateObject(joaat('hei_prop_heist_thermite'), x, y, z + 0.3,  true,  true, true)

    SetEntityCollision(thermiteObj, false, true)
    AttachEntityToEntity(thermiteObj, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Wait(2000)
    DeleteObject(bag)
    DetachEntity(thermiteObj, 1, 1)
    FreezeEntityPosition(thermiteObj, true)

    TriggerServerEvent('prdx_heists:server:removeThermite')

    NetworkStopSynchronisedScene(scene1)
    ClearPedTasks(ped)
    Wait(2500)
    TriggerServerEvent("QBCore:Server:DoPTFX", "scr_ornate_heist", 'scr_heist_ornate_thermal_burn', true, GetEntityCoords(thermiteObj), vec3(0.0, 0.0, 0.0), 0.5, nil, nil, 10000)
    QBCore.Functions.Notify('Heating up turbine...') 
    Wait(10000)
    DeleteObject(thermiteObj)
    AddExplosion(Config.PowerStations[k]['coords'].x, Config.PowerStations[k]['coords'].y, Config.PowerStations[k]['coords'].z, 65, 1.0, true, false, 4.0)
    QBCore.Functions.Notify("The turbine has overheated...", "success")
    TriggerServerEvent("prdx_heists:server:SetStationStatus", k, true)
end

-- Events
RegisterNetEvent('thermite:UseThermite', function()
    if QBCore.Functions.HasItem('thermite') then
        local ped = cache.ped
        local pos = GetEntityCoords(ped)
        for k,v in pairs(Config.PowerStations) do
            local Dist = #(pos - vector3(v['coords'].x, v['coords'].y, v['coords'].z))
            if Dist <= 1.5 then
                if not v['hit'] then
                    -- local result = exports["skillcheck"]:StartCheck(3, 3)
                    local result = lib.skillCheck({'medium', 'medium', 'medium'})
                    if result then
                        thermiteAnimation(k)
                    else
                        QBCore.Functions.Notify('Arming failed!', 'error', '5000')
                        TriggerServerEvent('prdx_heists:server:removeThermite')
                    end
                else 
                    QBCore.Functions.Notify('Fuse blown already', 'error', '5000')
                end
            end
        end
    else
        QBCore.Functions.Notify('You appear to be missing something...', 'error')
    end
end)

RegisterNetEvent('prdx_heists:client:SetStationStatus', function(key, isHit)
    Config.PowerStations[key].hit = isHit
end)

RegisterNetEvent('prdx_heists:client:ResetPowerStations', function()
    for k, v in pairs(Config.PowerStations) do
        Config.PowerStations[k].hit = false
    end
end)

-- Threads
CreateThread(function() 
    for k,v in pairs(Config.PowerStations) do
        exports.ox_target:addBoxZone({
            coords = vec3(v.coords.x, v.coords.y, v.coords.z),
            size = vec3(1.5, 1.5, (v.coords.z+2) - (v.coords.z-1)),
            rotation = v.coords.w,
            debug = Config.DebugMode,
            items = 'thermite',
            options = {
                {
                    name = 'thermite:UseThermite',
                    event = 'thermite:UseThermite',
                    icon = 'fas fa-bomb',
                    label = 'Place Thermite',
                    distance = 1.5
                }
            }
        })
    end
end)