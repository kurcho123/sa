local MenuItemIdNVG = false
local NightVisionOn = false

RegisterNetEvent('JakeFun:client:UseGasMask', function(bool)
    local ped = PlayerPedId()
    local status = bool
    if LocalPlayer.state['GasMask'] and bool == nil then
        status = LocalPlayer.state['GasMask']
    end
    if status then
        QBCore.Functions.Progressbar("equip_gear_mask", "Equiping Gas Mask", 5000, false, true, {}, {}, {}, {}, function() -- Done
            LocalPlayer.state:set('GasMask', true, true)
            QBCore.Functions.Notify('You put gas mask on')
            TriggerServerEvent('JakeFun:server:RemoveGasMask')
            local animDict = 'mp_masks@on_foot'
            local animName = 'put_on_mask'
            SetEntityProofs(ped, false, false, true, false, false, false, false, false)
            RequestAnimDict(animDict)

            while not HasAnimDictLoaded(animDict) do
                Wait(10)
            end
            TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 51, 0, false, false, false)
            Wait(150)
            StopAnimTask(ped, animDict, animName, 1.0)
            if GetEntityModel(ped) == `mp_m_freemode_01` then
                SetPedComponentVariation(ped, 1, 46, 0, 0)
            else
                SetPedComponentVariation(ped, 1, 46, 0, 0)
            end
            lib.addRadialItem({
                {
                  id = 'gas_mask',
                  label = 'Remove Gas Mask',
                  icon = 'eye',
                  onSelect = function()
                    TriggerEvent('JakeFun:client:RemoveGasMask')
                  end
                }
            })
        end)       
    end
end)

RegisterNetEvent('JakeFun:client:RemoveGasMask', function()	--Add event to call externally
    QBCore.Functions.Progressbar("remove_gear", "Removing Gas Mask...", 5000, false, true, {}, {}, {}, {}, function() -- Done
        LocalPlayer.state:set('GasMask', false, true)
        lib.removeRadialItem('gas_mask')
        local animDict = 'missfbi4'
        local animName = 'takeoff_mask'
        local ped = PlayerPedId()
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(10)
        end
        TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 51, 0, false, false, false)
        Wait(800)
        QBCore.Functions.Notify('You took your gas mask off')
        TriggerServerEvent('JakeFun:server:RestoreGasMask')
        StopAnimTask(ped, animDict, animName, 1.0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetEntityProofs(ped, false, false, false, false, false, false, false, false)
    end)
end)

RegisterNetEvent('JakeFun:client:UseRevivePen', function()	--Add event to call externally
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        TriggerEvent('animations:client:EmoteCommandStart', {"kneel"})
        QBCore.Functions.Progressbar("inject_needle", "Prepping needle...", 5000, false, true, {}, {}, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            -- local success = exports["skillcheck"]:StartCheck(2, 2)
            local success = lib.skillCheck({'easy', 'easy', 'easy'})
            TriggerServerEvent('JakeFun:server:revivePenUsed', GetPlayerServerId(player), success)
        end)
    else
        QBCore.Functions.Notify('No player nearby', 'error')
    end
end)

RegisterNetEvent('JakeFun:client:UsePoisonPen', function()	--Add event to call externally
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 2.5 then
        local success = lib.skillCheck({'easy', 'easy', 'easy'})
        TriggerServerEvent('JakeFun:server:poisonUsed', GetPlayerServerId(player), success)
    else
        QBCore.Functions.Notify('No player nearby', 'error')
    end
end)

RegisterNetEvent('JakeFun:client:getPoisoned', function()
    TriggerEvent('prdx_healthsystem:client:RevivePlayer')
    TriggerEvent('animations:client:EmoteCommandStart', {"nervous"})
    Wait(math.random(2000,3000))
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    Wait(math.random(9000,20000))
    TriggerEvent('animations:client:EmoteCommandStart', {"fallover"})
    exports['prdx_buffs']:AddBuff('poison', 13, {
        stress = 100,
        water = -90,
        food = -90,
        health = -200,
    },{
        stoned = 1.0,
    }, 4.99)
end)


RegisterNetEvent("Nightvision")
AddEventHandler("Nightvision", function(enable)
    local SetStatus = enable
    if SetStatus == nil or type(SetStatus) == "table" then
        SetStatus = not NightVisionOn or false
    end
    local ped = PlayerPedId()
	if SetStatus then
        NightVisionOn = true
		SetNightvision(true)
		local animDict = 'mp_masks@on_foot'
		local animName = 'put_on_mask'

		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Wait(10)
		end
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "nv", 0.5)
		TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 51, 0, false, false, false)
        Wait(150)
        StopAnimTask(ped, animDict, animName, 1.0)
        if GetEntityModel(ped) == `mp_m_freemode_01` then
            SetPedPropIndex(ped, 0, 116, 0, 0)
        else
            SetPedPropIndex(ped, 0, 115, 0, 0)
        end

	else
        NightVisionOn = false
		SetNightvision(false)
		local animDict = 'missfbi4'
		local animName = 'takeoff_mask'
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(10)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 51, 0, false, false, false)
        Wait(800)
        StopAnimTask(ped, animDict, animName, 1.0)
        if GetEntityModel(ped) == `mp_m_freemode_01` then
            SetPedPropIndex(ped, 0, 117, 0, 0)
        else
            SetPedPropIndex(ped, 0, 116, 0, 0)
        end
	end
end)


RegisterNetEvent('JakeFun:client:UseNightvision', function(bool)
    local status = bool
    if LocalPlayer.state['NVG'] and bool == nil then
        status = LocalPlayer.state['NVG']
    end
    if status then
        QBCore.Functions.Progressbar("equip_gear", "Equiping NVGs", 5000, false, true, {}, {}, {}, {}, function() -- Done
            LocalPlayer.state:set('NVG', true, true)
            QBCore.Functions.Notify('You put nightvision goggles on')
            SetPedPropIndex(PlayerPedId(), 0, 117, 0, 0)
            TriggerServerEvent('JakeFun:server:RemoveNVGs')
            MenuItemIdNVG = exports['qb-radialmenu']:AddOption({
                id = 'NVG',
                title = 'NVG Options',
                icon = 'eye',
                items = {
                    {
                        id = 'removenvg',
                        title = 'Remove NVGs',
                        icon = 'eye-slash',
                        type = 'client',
                        event = 'JakeFun:client:RemoveNightVision',
                        shouldClose = true
                    },
                    {
                        id = 'togglestatus',
                        title = 'Toggle Nightvision',
                        icon = 'eye',
                        type = 'client',
                        event = 'Nightvision',
                        shouldClose = true
                    },
                },
            }, MenuItemIdNVG)
        end)
    else
        QBCore.Functions.Progressbar("remove_gear", "Removing NVGs...", 5000, false, true, {}, {}, {}, {}, function() -- Done
            LocalPlayer.state:set('NVG', false, true)
            TriggerEvent('Nightvision', false)
            Wait(900)
            QBCore.Functions.Notify('You took your night vision goggles off')
            TriggerServerEvent('JakeFun:server:RestoreNVGs')
            ClearPedProp(PlayerPedId(), 0)
            if MenuItemIdNVG ~= nil then
                exports['qb-radialmenu']:RemoveOption(MenuItemIdNVG)
                MenuItemIdNVG = nil
            end
        end)
    end
end)

RegisterNetEvent('JakeFun:client:RemoveNightVision', function()	--Add event to call externally
    TriggerEvent('JakeFun:client:UseNightvision', false)
end)