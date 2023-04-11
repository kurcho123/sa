local hasHuntingRifle = false
local isFreeAiming = false
local aimingAtAnimal = false

local animals = {`a_c_boar`, `a_c_cat_01`, `a_c_chickenhawk`, `a_c_chimp`, `a_c_chop`, `a_c_cormorant`, `a_c_cow`, `a_c_coyote`, `a_c_crow`, `a_c_deer`, `a_c_dolphin`, `a_c_fish`, `a_c_hen`, `a_c_humpback`, `a_c_husky`, `a_c_killerwhale`, `a_c_mtlion`, `a_c_pig`, `a_c_pigeon`, `a_c_poodle`, `a_c_pug`, `a_c_rabbit_01`, `a_c_rat`, `a_c_retriever`, `a_c_rhesus`, `a_c_rottweiler`, `a_c_seagull`, `a_c_sharkhammer`, `a_c_sharktiger`, `a_c_shepherd`, `a_c_stingray`, `a_c_westy`}

local blockShotActive = false
local function blockShooting()
    if blockShotActive then return end
    blockShotActive = true
    CreateThread(function()
        while hasHuntingRifle do
            local ply = PlayerId()
            local ped = PlayerPedId()
            local ent = nil
            local aiming, ent = GetEntityPlayerIsFreeAimingAt(ply)
            local freeAiming = IsPlayerFreeAiming(ply)
            for k,v in pairs(animals) do
                if v == GetEntityModel(ent) then
                    aimingAtAnimal = true
                    break
                else
                    aimingAtAnimal = false
                end
            end
            local et = GetEntityType(ent)
            if not freeAiming
                or IsPedAPlayer(ent)
                or et == 2
                or (et == 1 and IsPedInAnyVehicle(ent))
                or aimingAtAnimal == false
            then
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 47, true)
                DisableControlAction(0, 58, true)
                DisablePlayerFiring(ped, true)
            end
            Wait(0)
        end
        blockShotActive = false
    end)
end

CreateThread(function()
    local huntingRifleHash = `weapon_sniperrifle`

    while true do
        if cache.weapon == huntingRifleHash then
            hasHuntingRifle = true
            blockShooting()
        else
            hasHuntingRifle = false
        end
        Wait(1000)
    end
end)