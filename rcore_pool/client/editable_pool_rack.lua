local isNearRack = false

local closestRack = nil

HasPoolCueInHand = false
IsCloseToPoolRack = false

AddEventHandler('rc_pool:poolqueuetoggle', function()
    if Config.AllowTakePoolCueFromStand == nil then
        Config.AllowTakePoolCueFromStand = true
    end
    if Config.AllowTakePoolCueFromStand then
        if HasPoolCueInHand then
            RemovePoolCueInHand()
        else
            CreatePoolCueInHand()
        end
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        Wait(0)

        local newClosestCoords = nil
        local newClosestRack = nil

        for _, hash in pairs(POOL_RACKS) do
            local rackObj = GetClosestObjectOfType(
                coords.x, 
                coords.y, 
                coords.z, 
                30.0, 
                hash, false, false, false
            )

            if rackObj and rackObj > 0 then
                local rackCoords = GetEntityCoords(rackObj)

                if not newClosestRack then
                    newClosestRack = rackObj
                    newClosestCoords = rackCoords
                else
                    if #(coords - rackCoords) < #(coords - newClosestCoords) then
                        newClosestRack = rackObj
                        newClosestCoords = rackCoords
                    end
                end
            end

            Wait(500)
        end

        if newClosestRack then
            isNearRack = true
            closestRack = newClosestRack
        else
            isNearRack = false
            closestRack = nil
        end
    else

    end
end)
