local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('ox_doorlock:client:breachDoor', function(exptype)
    print('Start breach:', exptype, closest, ClosestDoor)
	if ClosestDoor and ClosestDoor.id then
        if ClosestDoor.lockpick or exptype == 'breaching' then -- PD Bypass 
            print('START')
            local ped = PlayerPedId()
            local StartPostion = GetEntityCoords(ped)
            if ClosestDoor and ClosestDoor.distance < ClosestDoor.maxDistance/2 then
                local StoredDoor = ClosestDoor
                local loc = GetEntityCoords(ped)
                local ptfx = ''
                local method = ''
                local rotplus = 0
                local objcoords = StoredDoor.coords
                RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
                RequestModel("hei_p_m_bag_var22_arm_s")
                RequestNamedPtfxAsset("scr_ornate_heist")
                while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") and not HasNamedPtfxAssetLoaded("scr_ornate_heist") do
                    Wait(50)
                end
                TaskTurnPedToFaceCoord(ped, objcoords, 1000)
                Wait(200)
                local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
                local bagscene = NetworkCreateSynchronisedScene(loc.x, loc.y+0.05, loc.z, rotx, roty, rotz + rotplus, 2, false, false, 1065353216, 0, 1.3)
                local bag = CreateObject(joaat("hei_p_m_bag_var22_arm_s"), loc.x, loc.y, loc.z,  true,  true, false)
                SetEntityCollision(bag, false, true)
                NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
                NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
                local x, y, z = table.unpack(GetEntityCoords(ped))
                NetworkStartSynchronisedScene(bagscene)
                local bomba
                if exptype == 'breaching' then
                    bomba = CreateObject(joaat("prop_ld_bomb"), x, y, z - 20.0,  true,  true, true)
                    SetEntityVisible(bomba, false)
                    SetEntityCollision(bomba, false, true)
                    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 90.0, 180.0, 180.0, 0, true, true, false, 0, true)

                else
                    bomba = CreateObject(joaat("hei_prop_heist_thermite"), x, y, z - 20.0,  true,  true, true)
                    SetEntityVisible(bomba, false)
                    SetEntityCollision(bomba, false, true)
                    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)

                end
                local BombCoords = GetEntityCoords(bomba)
                Wait(500)
                SetEntityVisible(bomba, true)
                Wait(4000)
                DeleteObject(bag)
                DetachEntity(bomba, 1, 1)
                FreezeEntityPosition(bomba, true)
                NetworkStopSynchronisedScene(bagscene)
                SetEntityCoords(ped, StartPostion.x, StartPostion.y, StartPostion.z)
                -- local result = exports["skillcheck"]:StartCheck(3, 3)
                local result = lib.skillCheck({'easy', 'easy', 'medium'})
                if result then
                    if exptype == 'breaching' then
                        TriggerServerEvent('ox_doorlock:server:removeBreachingCharge')
                        Wait(5000)
                        AddExplosion(BombCoords.x, BombCoords.y, BombCoords.z, 2, 0.1, true, false, 1)
                    else
                        TriggerServerEvent('ox_doorlock:server:removeOther', exptype)
                        TriggerServerEvent("QBCore:Server:DoPTFX", "scr_ornate_heist", 'scr_heist_ornate_thermal_burn', true, GetEntityCoords(bomba), vec3(0.0, 0.0, 0.0), 0.5, nil, nil, 25000)
                        TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
                        TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 3000, 49, 1, 0, 0, 0)
                        Wait(25000)
                    end
                    TriggerServerEvent('ox_doorlock:setState', StoredDoor.id, StoredDoor.state == 1 and 0 or 1, true)
                end
                ClearPedTasks(ped)
                QBCore.Functions.DeleteEntity(bomba)
                -- DONE --
            end
		end
	end
end)