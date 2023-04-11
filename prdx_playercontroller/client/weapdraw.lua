local prevFemaleVariation = nil
local prevMaleVariation = nil
local holsterset = nil
local femaleHash = joaat("mp_f_freemode_01")
local maleHash = joaat("mp_m_freemode_01")
local weapon = nil
local hasholster  = false
local usedholster = false
local goodweapon = false
local holstered = true
local StoredWeapon = nil
local maleholsters = {
    [154] = 156,
    [158] = 157,
    [159] = 155,
    [160] = 155,
    [173] = 0,
    [177] = 178,
}
local femaleholsters = {
    [125] = 127,
    [129] = 128,
    [130] = 126,
    [131] = 126,
	[139] = 140,
}

-- Fucntions -- 
function loadAnimDict(dict)
	RequestAnimDict(dict)
 	while not HasAnimDictLoaded(dict) do
 		Wait(0)
 	end
end

function LoadWeapon(weaponData, shootbool)
	local ped = PlayerPedId()
	TriggerEvent('weapons:client:SetCurrentWeapon', weaponData, shootbool)
	QBCore.Functions.TriggerCallback("weapon:server:GetWeaponAmmo", function(result)
		local ammo = tonumber(result)
		if weaponName == "weapon_fireextinguisher" then
			ammo = 4000
		end
		local weaponName = tostring(weaponData.name)
		GiveWeaponToPed(ped, joaat(weaponName), 0, false, false)
		SetPedAmmo(ped, joaat(weaponName), ammo)
		SetCurrentPedWeapon(ped, joaat(weaponName), true)
		if weaponData.info.attachments ~= nil then
			for _, attachment in pairs(weaponData.info.attachments) do
				GiveWeaponComponentToPed(ped, joaat(weaponName), joaat(attachment.component))
			end
		end
	end, weaponData)
end

-- Categories --
function GetCategory(cat)
    local category
    if cat == 970310034 then -- 970310034 rifles
        category = 'rifle'
    elseif cat == 416676503 or cat == 690389602 then -- 416676503 hand guns // 690389602 stun gun
        category = 'pistol'
    elseif cat == 860033945 then -- 860033945 shotguns
        category = 'shotgun'
    elseif cat == 3337201093 or cat == -957766203 then -- 3337201093 sub machine guns
        category = 'smg'
    elseif cat == 1159398588 or cat == -1569042529 then -- 1159398588 light machine gun
        category = 'lmg'
    elseif cat == 1548507267 or cat == 4257178988 or cat == 1595662460 then -- 1548507267 throwables // 4257178988 fire extinghuiser // jerry can
        category = 'throwable'
    elseif cat == 3566412244 or cat == 2685387236 then -- 3566412244 melee weapons // 2685387236 knuckle duster
        category = 'melee'
    elseif cat == 2725924767 then -- 2725924767 heavy weapons
        category = 'heavy'
    elseif cat == 3082541095 or cat == -1212426201 then -- 3082541095 snipers
        category = 'sniper'
    end
    return category
end

-- HOLSTERS AND WEAPON ANIM --
function SetHolster(id)
	local ped = PlayerPedId()
	if GetEntityModel(ped) == femaleHash then -- mp female
		prevFemaleVariation = id
		SetPedComponentVariation(ped, 7, holsterset, 0, 0)
	elseif GetEntityModel(ped) == maleHash then -- mp male
		prevMaleVariation = id
		SetPedComponentVariation(ped, 7, holsterset, 0, 0)
	end
end

function UnSetHolster(id)
	local ped = PlayerPedId()
	if GetEntityModel(ped) == femaleHash then -- mp female
		SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
	elseif GetEntityModel(ped) == maleHash then -- mp male
		SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
	end
end

RegisterNetEvent('weapons:ResetHolster', function()
	prevFemaleVariation = nil
	prevMaleVariation = nil
	holsterset = nil
	weapon = nil
	hasholster  = false
	usedholster = false
	goodweapon = false
	holstered = true
	StoredWeapon = nil
end)

AddEventHandler('holster:DoHolster', function(weaponitem, shootbool, swapWepon)
    SetWeaponsNoAutoswap(true)
    local ped = PlayerPedId()
	local weaponObj = GetSelectedPedWeapon(ped)
    local male = nil
    if GetEntityModel(ped) == maleHash then -- mp male
        male = true
    elseif GetEntityModel(ped) == femaleHash then -- mp female
        male = false
    end

    if DoesEntityExist(ped) and not IsEntityDead(ped) and not IsPedInParachuteFreeFall(ped) and not IsPedFalling(ped) and (GetPedParachuteState(ped) == -1 or GetPedParachuteState(ped) == 0) then
            -- Checking if we have a valid holster
            local holstertype = GetPedDrawableVariation(ped, 7)
            if male == true then -- mp male
                if maleholsters[holstertype] then
                    hasholster = true
                    holsterset = maleholsters[holstertype]
                else
                    hasholster = false
                end
            elseif male == false then -- mp female
                if femaleholsters[holstertype] then
                    hasholster = true
                    holsterset = femaleholsters[holstertype]
                else
                    hasholster = false
                end
            end

            -- Checking if we are swapping to a weapon or not
            if weaponitem then
                local group = GetWeapontypeGroup(weaponitem.name)
                -- If the group is a pistol
                if group == 416676503 or group == 690389602 then
                    goodweapon = true
                else
                    goodweapon = false
                end
            else
                goodweapon = false
            end

            -- Load animations
            loadAnimDict("weapons@pistol@")
            loadAnimDict("rcmjosh4")

            if group ~= 1548507267 then -- not a throwable as they skip everything
				
                -- If we are switching to a weapon, have a valid hoster, and pulling out a pistol
                if not StoredWeapon and hasholster == true and goodweapon == true then
                    DisablePlayerFiring(ped)
                    RemoveAllPedWeapons(ped)
                    SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', true)
                    TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                    Wait(500)
					LoadWeapon(weaponitem, shootbool)
                    RemoveAnimDict("rcmjosh4")
                    Wait(100)
                    ClearPedTasks(ped)
                    ClearPedSecondaryTask(ped)
                    holstered = false
                    SetPedComponentVariation(ped, 0, 0, 0, 0)
                    SetHolster(holstertype)
                    usedholster = true
					StoredWeapon = weaponitem
                -- If we are putting away a holstered gun    
                elseif StoredWeapon and usedholster == true then
                    DisablePlayerFiring(ped)
                    TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                    Wait(400)
                    RemoveAnimDict("weapons@pistol@")
                    SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', true)
                    Wait(100)
                    ClearPedTasks(ped)
                    ClearPedSecondaryTask(ped)
                    holstered = true
                    SetPedComponentVariation(ped, 0, 0, 0, 0)
                    UnSetHolster(holstertype)
                    usedholster = false
                    SetPedComponentVariation(ped, 0, 0, 0, 0)
					StoredWeapon = nil
                    TriggerEvent('weapons:client:SetCurrentWeapon', nil, shootbool)
                else
                    -- Civ weapon pulls
                    loadAnimDict("reaction@intimidation@1h")
                    if not StoredWeapon then  
                        DisablePlayerFiring(ped)
                        local weapon = GetSelectedPedWeapon(ped)
                        RemoveAllPedWeapons(ped)
                        SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', true)
                        TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 48, 63, 0, 0, 0 )
                        Wait(1100)
						-- LoadWeapon(weaponitem, shootbool)
                        GiveWeaponToPed(ped, weaponitem.hash, 0, false, true)
                        SetCurrentPedWeapon(ped, weaponitem.hash, true)
                        RemoveAnimDict("reaction@intimidation@1h")
                        Wait(600)
                        ClearPedTasks(ped)
                        ClearPedSecondaryTask(ped)
                        holstered = false
                        SetPedComponentVariation(ped, 0, 0, 0, 0)
						StoredWeapon = weaponitem
                        TriggerEvent('weapons:client:SetCurrentWeapon', weaponitem, shootbool)
                    elseif StoredWeapon then
                        DisablePlayerFiring(ped)
                        TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 1.0, -1, 48, 10, 0, 0, 0 )
                        Wait(1200)
                        RemoveAnimDict("reaction@intimidation@1h")
                        SetCurrentPedWeapon(ped, 'WEAPON_UNARMED', true)
                        Wait(200)
                        ClearPedTasks(ped)
                        ClearPedSecondaryTask(ped)
                        holstered = true
                        SetPedComponentVariation(ped, 0, 0, 0, 0)
						StoredWeapon = nil
                        TriggerEvent('weapons:client:SetCurrentWeapon', nil, shootbool)
                    end
                end
            end
        --end
    end
end)


--[[ -- WEAPON CLIMBING -- I am unsure if still needed
CreateThread(function ()
    while true do 
        Wait(100)
        local ped = PlayerPedId()
        if IsPlayerClimbing(PlayerId()) and IsPedArmed(ped, 7) then
            if climbweapon == nil then
                climbweapon = GetSelectedPedWeapon(ped)
            end
        else
            if climbweapon ~= nil then
                SetCurrentPedWeapon(ped, climbweapon, true)
                climbweapon = nil
                Wait(500)
            end
        end
    end
end) ]]

