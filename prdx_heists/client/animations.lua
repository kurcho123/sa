function DoHack(hackID, doorID, coords)
    local loc = coords
    local animDict = 'anim@heists@ornate_bank@hack'
    lib.requestAnimDict(animDict)
    lib.requestModel('hei_prop_hst_laptop')
    lib.requestModel('hei_p_m_bag_var22_arm_s')

    local ped = cache.ped
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))

    SetEntityHeading(ped, loc.w)
    local animPos = GetAnimInitialOffsetPosition(animDict, 'hack_enter', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos2 = GetAnimInitialOffsetPosition(animDict, 'hack_loop', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, 'hack_exit', loc.x, loc.y, loc.z, loc.x, loc.y, loc.z, 0, 2)

    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(joaat('hei_p_m_bag_var22_arm_s'), targetPosition, 1, 1, 0)
    local laptop = CreateObject(joaat('hei_prop_hst_laptop'), targetPosition, 1, 1, 0)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, 'hack_enter', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, 'hack_enter_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, 'hack_enter_laptop', 4.0, -8.0, 1)

    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, true, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, 'hack_loop', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, 'hack_loop_bag', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, 'hack_loop_laptop', 4.0, -8.0, 1)
    Wait(200)
    NetworkStartSynchronisedScene(netScene)
    Wait(6300)
    NetworkStartSynchronisedScene(netScene2)
    Wait(2000)
    local continue = StartHack(hackID, doorID)
        -- Loops until done --

    NetworkStartSynchronisedScene(netScene3)
    NetworkStopSynchronisedScene(netScene3)
    QBCore.Functions.DeleteEntity(bag)
    QBCore.Functions.DeleteEntity(laptop)
    FreezeEntityPosition(ped, false)
end

function LootTrolley(heistID, trolleyID)
    LocalPlayer.state:set('inv_busy', true, true) -- Busy
    local ped = cache.ped
    local pos, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local sceneObject = NetworkGetEntityFromNetworkId(Config.Heists[heistID]["trolleys"][trolleyID]['entity'])
    local trollyModel = GetEntityModel(sceneObject)
    local animDict = 'anim@heists@ornate_bank@grab_cash'

    if trollyModel == 881130828 then
        grabModel = 'ch_prop_vault_dimaondbox_01a'
    elseif trollyModel == 2007413986 then
        grabModel = 'ch_prop_gold_bar_01a'
    else
        grabModel = 'hei_prop_heist_cash_pile'
    end

    lib.requestAnimDict(animDict)
    lib.requestModel('hei_p_m_bag_var22_arm_s')
    if IsEntityPlayingAnim(sceneObject, animDict, "cart_cash_dissapear", 3) then
        return
    end
    SetEntityCollision(sceneObject, true, true) -- Always set collision as anims sometimes mess it up

    bag = CreateObject(joaat('hei_p_m_bag_var22_arm_s'), pos, true, false, false)

    QBCore.Functions.TakeControl(sceneObject)

    scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene1, animDict, 'intro', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, animDict, 'bag_intro', 4.0, -8.0, 1)

    scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, true, 1065353216, 0, 1.3) -- loops trolly anim so we dont need to spawn a new prop
    NetworkAddPedToSynchronisedScene(ped, scene2, animDict, 'grab', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene2, animDict, 'bag_grab', 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(sceneObject, scene2, animDict, 'cart_cash_dissapear', 4.0, -8.0, 1)

    scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(sceneObject), GetEntityRotation(sceneObject), 2, true, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, scene3, animDict, 'exit', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene3, animDict, 'bag_exit', 4.0, -8.0, 1)

    NetworkStartSynchronisedScene(scene1)
    Wait(1750)
    GrabTrolley(grabModel)
    NetworkStartSynchronisedScene(scene2)
    Wait(37000)
    NetworkStartSynchronisedScene(scene3)
    Wait(2000)
    LocalPlayer.state:set('inv_busy', false, true) -- Not Busy  
    local coords = GetEntityCoords(sceneObject)
    newTrolly = CreateObject(769923921, coords.x, coords.y, coords.z - 10.0, true, false, false)
    SetEntityRotation(newTrolly, 0, 0, GetEntityHeading(sceneObject), 1, 0)
    QBCore.Functions.DeleteEntity(sceneObject)
    QBCore.Functions.DeleteEntity(bag)
    TriggerServerEvent('prdx_heists:server:setTrolleyState', heistID, trolleyID, 'isOpened', true)
    Wait(100)
    SetEntityCoords(newTrolly, coords)  
    SetEntityAsNoLongerNeeded(newTrolly)
end

function GrabTrolley(grabModel)
    local ped = cache.ped
    local pos = GetEntityCoords(ped)
    local grabModel = joaat(grabModel)

    lib.requestModel(grabModel)
    local grabObject = CreateObject(grabModel, pos, true)

    FreezeEntityPosition(grabObject, true)
    SetEntityInvincible(grabObject, true)
    SetEntityNoCollisionEntity(grabObject, ped)
    SetEntityVisible(grabObject, false, false)
    AttachEntityToEntity(grabObject, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
    local Looting = GetGameTimer()

    CreateThread(function()
        while GetGameTimer() - Looting < 37000 do
            Wait(1)
            DisableControlAction(0, 73, true)
            if HasAnimEventFired(ped, joaat('CASH_APPEAR')) then
                if not IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, true, false)
                end
            end
            if HasAnimEventFired(ped, joaat('RELEASE_CASH_DESTROY')) then
                if IsEntityVisible(grabObject) then
                    SetEntityVisible(grabObject, false, false)
                end
            end
        end
        DeleteObject(grabObject)
    end)
end