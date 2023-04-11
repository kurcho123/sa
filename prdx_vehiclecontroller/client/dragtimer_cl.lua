local timer = 0
local speed = 0
local TimerStarted = false

local function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('prdx_vehiclecontroller:client:generateDragTime', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, true)
    if vehicle and vehicle ~= 0 then
        TriggerServerEvent('prdx_vehiclecontroller:giveRaceResult', QBCore.Functions.GetPlate(vehicle))
    else
        QBCore.Functions.Notify('No vehicle detected', 'error')
    end
end)

local ZancudoDragTimer = PolyZone:Create({
	vector2(-2659.1530761719, 3225.4379882813),
	vector2(-2651.5131835938, 3238.7136230469),
	vector2(-2642.3422851563, 3247.423828125),
	vector2(-2187.1945800781, 2986.2736816406),
	vector2(-2208.1691894531, 2949.8356933594),
	vector2(-2657.4675292969, 3210.4877929688),
	vector2(-2654.82421875, 3215.5454101563),
	vector2(-2659.4128417969, 3218.0283203125)
  }, {
    debugPoly = false,
	name = "ZancudoDragTimer",
	minZ = 30.810333251953,
	maxZ = 42.832599639893
})

CreateThread(function()
    ZancudoDragTimer:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
        local plyPed = PlayerPedId()
        if IsPedInAnyVehicle(plyPed, false) then
            local vehicle = GetVehiclePedIsIn(plyPed)
            if vehicle and vehicle == 0 and GetPedInVehicleSeat(vehicle, -1) ~= plyPed then return end

            if isPointInside then
                timer = GetNetworkTimeAccurate()
            else 
                timer = (GetNetworkTimeAccurate() - timer) / 1000
                speed = GetEntitySpeed(GetVehiclePedIsIn(plyPed)) * 2.236936
                local hash = GetEntityModel(vehicle)
                local modelName = GetLabelText(GetDisplayNameFromVehicleModel(hash))
                local makeName = GetLabelText(GetMakeNameFromVehicleModel(hash))
                TriggerServerEvent('prdx_vehiclecontroller:server:sendDragTime', QBCore.Functions.GetPlate(vehicle), timer, round(speed, 2), makeName, modelName)
                timer = 0
                TimerStarted = false
            end
        end 
    end, 0)
end)   