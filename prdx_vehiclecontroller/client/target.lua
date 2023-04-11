exports.ox_target:addBoxZone({ -- Drag Times
    coords = vector3(-2046.25, 3019.16, 33.05),
    size = vector3(2.8, 1.4, 2.4),
    rotation = 328.0,
    debug = false,
    options = {
        {
            name = 'DragTimes',
            event = 'prdx_vehiclecontroller:client:generateDragTime',
            icon = 'fas fa-flag-checkered',
            label = 'Collect race results',
        }
    },
}) 

GlobalVehicleOptions = {
	{
        type = "client",
        event = "target:client:openImpoundMenu",
        icon = "fas fa-car",
        label = "Impound Menu",
    },
    {
        num = 1,
        type = "client",
        event = "tow:vehicleInteractions",
        icon = "fas fa-wrench",
        label = "Tow Vehicle Menu",
        groups = "tow",
    },
    {
        type = "client",
        event = "target:client:removeFromSeat",
        icon = "fas fa-chair",
        label = "Seat Menu",
    },
    {
        type = "client",
        event = "qb-trunk:client:GetIn",
        icon = "fas fa-car",
        label = "Get in Trunk",
    },
    {
        type = "client",
        event = "qb-tow:client:lockpickVehicle",
        icon = "fas fa-unlock",
        label = "Unlock Car",
        groups = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc", "ambulance"},
    },
}

exports.ox_target:addGlobalVehicle(GlobalVehicleOptions)