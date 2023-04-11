local ShowCoords = false
local VehicleDev = false
local VehicleTypes = {'Compacts', 'Sedans', 'SUVs', 'Coupes', 'Muscle', 'Sports Classics', 'Sports', 'Super', 'Motorcycles', 'Off-road', 'Industrial', 'Utility', 'Vans', 'Cycles', 'Boats', 'Helicopters', 'Planes', 'Service', 'Emergency', 'Military', 'Commercial', 'Trains', 'Open Wheel'}
local Options = {
    function() local Coords = GetEntityCoords(cache.ped) lib.setClipboard(string.format('vector2(%s, %s)', Round(Coords.x, 2), Round(Coords.y, 2))) lib.showMenu('qb_adminmenu_dev_menu', MenuIndexes['qb_adminmenu_dev_menu']) end,
    function() local Coords = GetEntityCoords(cache.ped) lib.setClipboard(string.format('vector3(%s, %s, %s)', Round(Coords.x, 2), Round(Coords.y, 2), Round(Coords.z, 2))) lib.showMenu('qb_adminmenu_dev_menu', MenuIndexes['qb_adminmenu_dev_menu']) end,
    function() local Coords = GetEntityCoords(cache.ped) local Heading = GetEntityHeading(cache.ped) lib.setClipboard(string.format('vector4(%s, %s, %s, %s)', Round(Coords.x, 2), Round(Coords.y, 2), Round(Coords.z, 2), Round(Heading, 2))) lib.showMenu('qb_adminmenu_dev_menu', MenuIndexes['qb_adminmenu_dev_menu']) end,
    function() local Heading = GetEntityHeading(cache.ped) lib.setClipboard(string.format('%s', Round(Heading, 2))) lib.showMenu('qb_adminmenu_dev_menu', MenuIndexes['qb_adminmenu_dev_menu']) end,
    function()
        ShowCoords = not ShowCoords
        while ShowCoords do
            local Coords, Heading = GetEntityCoords(cache.ped), GetEntityHeading(cache.ped)
            Draw2DText(string.format('~o~vector4~w~(%s, %s, %s, %s)', Round(Coords.x, 2), Round(Coords.y, 2), Round(Coords.z, 2), Round(Heading, 2)), 6, {255, 255, 255}, 0.5, 0.4, 0.025)
            Wait(0)
        end
    end,
    function()
        VehicleDev = not VehicleDev
        while VehicleDev do
            if cache.vehicle then
                local Clutch, Gear, Rpm, Temperature = GetVehicleClutch(cache.vehicle), GetVehicleCurrentGear(cache.vehicle), GetVehicleCurrentRpm(cache.vehicle), GetVehicleEngineTemperature(cache.vehicle)
                local Oil, Angle, Body, Engine, Class = GetVehicleOilLevel(cache.vehicle), GetVehicleSteeringAngle(cache.vehicle), GetVehicleBodyHealth(cache.vehicle), GetVehicleEngineHealth(cache.vehicle), VehicleTypes[GetVehicleClass(cache.vehicle)]
                local Dirt, MaxSpeed, NetId, Hash = GetVehicleDirtLevel(cache.vehicle), GetVehicleEstimatedMaxSpeed(cache.vehicle), VehToNet(cache.vehicle), GetEntityModel(cache.vehicle)
                local Name = GetLabelText(GetDisplayNameFromVehicleModel(Hash))
                Draw2DText(string.format('~o~Clutch: ~w~ %s | ~o~Gear: ~w~ %s | ~o~Rpm: ~w~ %s | ~o~Temperature: ~w~ %s', Round(Clutch, 4), Gear, Round(Rpm, 4), Temperature), 6, {255, 255, 255}, 0.45, 0.05, 0.100)
                Draw2DText(string.format('~o~Oil: ~w~ %s | ~o~Steering Angle: ~w~ %s | ~o~Body: ~w~ %s | ~o~Engine: ~w~ %s | ~o~Class: ~w~ %s', Round(Oil, 1), Round(Angle, 1), Round(Body, 2), Round(Engine, 2), Class), 6, {255, 255, 255}, 0.45, 0.05, 0.125)
                Draw2DText(string.format('~o~Dirt: ~w~ %s | ~o~Est Max Speed: ~w~ %s | ~o~Net ID: ~w~ %s | ~o~Hash: ~w~ %s', Round(Dirt, 4), Round(MaxSpeed, 4) * 3.6, NetId, Hash), 6, {255, 255, 255}, 0.45, 0.05, 0.150)
                Draw2DText(string.format('~o~Vehicle Name: ~w~ %s', Name), 6, {255, 255, 255}, 0.45, 0.05, 0.175)
                Wait(0)
            else
                Wait(800)
            end
        end
    end,
}

lib.registerMenu({
    id = 'qb_adminmenu_dev_menu',
    title = Lang:t('title.dev_menu'),
    position = 'top-right',
    onClose = function(keyPressed)
        CloseMenu(false, keyPressed, 'qb_adminmenu_main_menu')
    end,
    onSelected = function(selected)
        MenuIndexes['qb_adminmenu_dev_menu'] = selected
    end,
    options = {
        {label = Lang:t('dev_options.label1'), description = Lang:t('dev_options.desc1'), icon = 'fas fa-compass'},
        {label = Lang:t('dev_options.label2'), description = Lang:t('dev_options.desc2'), icon = 'fas fa-compass'},
        {label = Lang:t('dev_options.label3'), description = Lang:t('dev_options.desc3'), icon = 'fas fa-compass'},
        {label = Lang:t('dev_options.label4'), description = Lang:t('dev_options.desc4'), icon = 'fas fa-compass'},
        {label = Lang:t('dev_options.label5'), description = Lang:t('dev_options.desc5'), icon = 'fas fa-compass-drafting', close = false},
        {label = Lang:t('dev_options.label6'), description = Lang:t('dev_options.desc6'), icon = 'fas fa-car-side', close = false},
        {label = Lang:t('admin_options.label1'), description = Lang:t('admin_options.desc1'), icon = 'fab fa-fly', close = false},
    }
}, function(selected)
    Options[selected]()
end)

RegisterNetEvent("ParadoxAdmin:OpenTrash", function()
    exports.ox_inventory:openInventory('stash', 'admintrash')
    Wait(250)
    while LocalPlayer.state.invOpen do
        Wait(250)
    end
    TriggerServerEvent('ParadoxAdmin:CleanTrash')
end)

RegisterNetEvent('ParadoxAdmin:IPLToggle', function(loadipl, ipl)
    print(loadipl, ipl)
    if loadipl and ipl then 
        RequestIpl(ipl)
    elseif ipl then
        RemoveIpl(ipl)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('ParadoxAdmin:getIPLLoader', function(adminIPLs)
        for k,v in pairs(adminIPLs) do
            if v then
                RequestIpl(k)
            else
                RemoveIpl(k)
            end
        end
    end)
end)

RegisterNetEvent('ParadoxAdmin:client:openEmailMaker', function()
    local input = lib.inputDialog('Admin Email', {
        {type = 'select', label = 'Recipient', options = {
            {value = 'player', label = 'Player'},
            {value = 'job', label = 'Job'},
            {value = 'gang', label = 'Gang'},
            {value = 'item', label = 'Item'},
            {value = 'all', label = 'Everyone'},
        },required = true, default = 'player'},
        {type = 'input', label = 'Sender', description = 'Who the email is coming from', required = true},
        {type = 'input', label = 'Subject', description = 'Email Subject', required = true},
        {type = 'textarea', label = 'Body', description = 'Email Body', required = true},
    })
    if not input then return end
    local secondOptions = {}
    if input[1] == 'gang' then
        for k,v in pairs(QBCore.Shared.Gangs) do
            secondOptions[#secondOptions+1] = {value = k, label = v.label}
        end
    elseif input[1] == 'job' then
        for k,v in pairs(QBCore.Shared.Jobs) do
            secondOptions[#secondOptions+1] = {value = k, label = v.label}
        end
    end
    if next(secondOptions) then
        local inputFinal = lib.inputDialog('Admin Email (Select Recipients)', {
            {type = 'multi-select', label = 'Recipient', options = secondOptions, required = true},
        })
        if not inputFinal then return end
        TriggerServerEvent('ParadoxAdmin:server:sendAdminMail', input[1], inputFinal[1], input[2], input[3], input[4])
    else
        if input[1] == 'all' then
            TriggerServerEvent('ParadoxAdmin:server:sendAdminMail', input[1], nil, input[2], input[3], input[4])
        elseif input[1] == 'player' then
            local inputFinal = lib.inputDialog('Admin Email (Select Recipients)', {
                {type = 'number', label = 'Player ID', default = GetPlayerServerId(PlayerPedId()), required = true},
            })
            if not inputFinal then return end
            TriggerServerEvent('ParadoxAdmin:server:sendAdminMail', input[1], inputFinal[1], input[2], input[3], input[4])
        elseif input[1] == 'item' then
            local inputFinal = lib.inputDialog('Admin Email (Select Recipients)', {
                {type = 'input', label = 'Item name (not label)', required = true},
            })
            if not inputFinal then return end
            TriggerServerEvent('ParadoxAdmin:server:sendAdminMail', input[1], inputFinal[1], input[2], input[3], input[4])
        end
    end
end)

