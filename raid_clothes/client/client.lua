QBCore = exports['qb-core']:GetCoreObject()

local enabled = false
local player = false
local firstChar = false
local cam = false
local customCam = false
local oldPed = false
local startingMenu = false
local selectorPed = nil

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local tatCategory = GetTatCategs()
local tattooHashList = CreateHashList()

local shopType = nil
local StoreCost = 0
local isService = false;

local female_peds = {}
local male_peds = {}

local hairDecorDefault = {'mpbeach_overlays', "FM_hair_fuzz"} --if the haircut is not there, add some hair fuzz. It will not always match, but it's better than having the hair look "glued on".

local hairDecor = {
    ['m'] = {
        [0] = {"",""}, --who doesn't like a shiny head from time to time?
        [1] = {"multiplayer_overlays", "FM_M_Hair_001_a"},
        [2] = {"multiplayer_overlays", "NG_M_Hair_002"},
        [3] = {"multiplayer_overlays", "FM_M_Hair_003_a"},
        [4] = {"multiplayer_overlays", "NG_M_Hair_004"},
        [5] = {"multiplayer_overlays", "FM_M_Hair_long_a"},
        [6] = {"multiplayer_overlays", "FM_M_Hair_006_a"},
        [8] = {"multiplayer_overlays", "FM_M_Hair_008_a"},
        [9] = {"multiplayer_overlays", "NG_M_Hair_009"},
        [10] = {"multiplayer_overlays", "NG_M_Hair_013"},
        [11] = {"multiplayer_overlays", "NG_M_Hair_002"},
        [12] = {"multiplayer_overlays", "NG_M_Hair_011"},
        [13] = {"multiplayer_overlays", "NG_M_Hair_012"},
        [14] = {"multiplayer_overlays", "NG_M_Hair_014"},
        [15] = {"multiplayer_overlays", "NG_M_Hair_015"},
        [16] = {"multiplayer_overlays", "NGBea_M_Hair_000"},
        [17] = {"multiplayer_overlays", "NGBea_M_Hair_001"},
        [18] = {"mpbusiness_overlays", "FM_Bus_M_Hair_000_a"},
        [19] = {"mpbusiness_overlays", "FM_Bus_M_Hair_001_a"},
        [20] = {"mphipster_overlays", "FM_Hip_M_Hair_000_a"},
        [21] = {"mphipster_overlays", "FM_Hip_M_Hair_001_a"},
        [22] = {"multiplayer_overlays", "NGInd_M_Hair_000"},
            --23
        [24] = {"mplowrider_overlays", "LR_M_Hair_000"},
        [25] = {"mplowrider_overlays", "LR_M_Hair_001"},
        [26] = {"mplowrider_overlays", "LR_M_Hair_002"},
        [27] = {"mplowrider_overlays", "LR_M_Hair_003"},
        [28] = {"mplowrider2_overlays", "LR_M_Hair_004"},
        [29] = {"mplowrider2_overlays", "LR_M_Hair_005"},
        [30] = {"mplowrider2_overlays", "LR_M_Hair_006"},
        [31] = {"mpbiker_overlays", "MP_Biker_Hair_000_M"},
        [32] = {"mpbiker_overlays", "MP_Biker_Hair_001_M"},
        [33] = {"mpbiker_overlays", "MP_Biker_Hair_002_M"},
        [34] = {"mpbiker_overlays", "MP_Biker_Hair_003_M"},
        [35] = {"mpbiker_overlays", "MP_Biker_Hair_004_M"},
        [36] = {"mpbiker_overlays", "MP_Biker_Hair_005_M"},

        [72] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_M_000_M"},
        [73] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_M_001_M"},
        [74] = {"mpvinewood_overlays", "MP_Vinewood_Hair_M_000_M"},
        [75] = {"mptuner_overlays", "MP_Tuner_Hair_001_M"},
        [76] = {"mpsecurity_overlays", "MP_Security_Hair_001_M"},
    },
    ['f'] = {
        [0] = {"",""}, --who doesn't like a shiny head from time to time?
        [1] = {"multiplayer_overlays", "NG_F_Hair_001"},
        [2] = {"multiplayer_overlays", "NG_F_Hair_002"},
        [3] = {"multiplayer_overlays", "FM_F_Hair_003_a"},
        [4] = {"multiplayer_overlays", "NG_F_Hair_004"},
        [5] = {"multiplayer_overlays", "FM_F_Hair_005_a"},
        [6] = {"multiplayer_overlays", "FM_F_Hair_006_a"},
        [7] = {"multiplayer_overlays", "NG_F_Hair_007"},
        [8] = {"multiplayer_overlays", "NG_F_Hair_008"},
        [9] = {"multiplayer_overlays", "NG_F_Hair_009"},
        [10] = {"multiplayer_overlays", "NG_F_Hair_010"},
        [11] = {"multiplayer_overlays", "NG_F_Hair_011"},
        [12] = {"multiplayer_overlays", "NG_F_Hair_012"},
        [13] = {"multiplayer_overlays", "FM_F_Hair_013_a"},
        [14] = {"multiplayer_overlays", "FM_F_Hair_014_a"},
        [15] = {"multiplayer_overlays", "NG_M_Hair_015"},
        [16] = {"multiplayer_overlays", "NGBea_F_Hair_000"},
        [17] = {"mpbusiness_overlays", "FM_Bus_F_Hair_a"},
        [18] = {"multiplayer_overlays", "NG_F_Hair_007"},
        [19] = {"multiplayer_overlays", "NGBus_F_Hair_000"},
        [20] = {"multiplayer_overlays", "NGBus_F_Hair_001"},
        [21] = {"multiplayer_overlays", "NGBea_F_Hair_001"},
        [22] = {"mphipster_overlays", "FM_Hip_F_Hair_000_a"},
        [23] = {"multiplayer_overlays", "NGInd_F_Hair_000"},
        --24
        [25] = {"mplowrider_overlays", "LR_F_Hair_000"},
        [26] = {"mplowrider_overlays", "LR_F_Hair_001"},
        [27] = {"mplowrider_overlays", "LR_F_Hair_002"},
        [29] = {"mplowrider2_overlays", "LR_F_Hair_003"},
        [30] = {"mplowrider2_overlays", "LR_F_Hair_004"},
        [31] = {"mplowrider2_overlays", "LR_F_Hair_006"},
        [32] = {"mpbiker_overlays", "MP_Biker_Hair_000_F"},
        [33] = {"mpbiker_overlays", "MP_Biker_Hair_001_F"},
        [34] = {"mpbiker_overlays", "MP_Biker_Hair_002_F"},
        [35] = {"mpbiker_overlays", "MP_Biker_Hair_003_F"},
        [38] = {"mpbiker_overlays", "MP_Biker_Hair_004_F"},
        [36] = {"mpbiker_overlays", "MP_Biker_Hair_005_F"},
        [37] = {"mpbiker_overlays", "MP_Biker_Hair_005_F"},

        [76] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_F_000_F"},
        [77] = {"mpgunrunning_overlays", "MP_Gunrunning_Hair_F_001_F"},
        [78] = {"mpvinewood_overlays", "MP_Vinewood_Hair_F_000_F"},
        [79] = {"mptuner_overlays", "MP_Tuner_Hair_000_F"},
        [80] = {"mpsecurity_overlays", "MP_Security_Hair_000_F"},
    },
}

QBCore.Functions.TriggerCallback("raid_clothes:getPedSkins", function(skins)
    male_peds = skins.male
    female_peds = skins.female
end)

function RefreshUI()
    hairColors = {}
    for i = 0, GetNumHairColors()-1 do
        local outR, outG, outB= GetPedHairRgbColor(i)
        hairColors[i] = {outR, outG, outB}
    end

    makeupColors = {}
    for i = 0, GetNumMakeupColors()-1 do
        local outR, outG, outB= GetPedMakeupRgbColor(i)
        makeupColors[i] = {outR, outG, outB}
    end

    SendNUIMessage({
        type="colors",
        hairColors=hairColors,
        makeupColors=makeupColors,
        hairColor=GetPedHair()
    })
    SendNUIMessage({
        type = "menutotals",
        drawTotal = GetDrawablesTotal(),
        propDrawTotal = GetPropDrawablesTotal(),
        textureTotal = GetTextureTotals(),
        headoverlayTotal = GetHeadOverlayTotals(),
        skinTotal = GetSkinTotal()
    })
    SendNUIMessage({
        type = "barbermenu",
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructureData(),
        skinTotal = GetSkinTotal(),
        eyeColor = GetPedEyeColor(PlayerPedId())
    })
    SendNUIMessage({
        type = "clothesmenudata",
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        skin = GetSkin(),
        oldPed = oldPed,
    })
    SendNUIMessage({
        type = "tattoomenu",
        totals = tatCategory,
        values = GetTats()
    })
end

function GetSkin()
    for i = 1, #male_peds do
        if (tonumber(male_peds[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_male", value=i}
        end
    end
    for i = 1, #female_peds do
        if (tonumber(female_peds[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_female", value=i}
        end
    end
    return false
end

function GetDrawables()
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(player, i) == -1 then
            SetPedComponentVariation(player, i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(player, i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(player, i)}
    end
    return props
end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(player, i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(player, i)})
    end
    return textures
end

function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(player, i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(player, i)}
    end
    return props
end

function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw-1 do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name] = GetNumberOfPedTextureVariations(player, idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name] = GetNumberOfPedPropTextureVariations(player, idx, value)
    end
    return values
end

function SetClothing(drawables, props, drawTextures, propTextures, ped)
    selectorPed = ped
    if ped then
        if ped == "player" then
            player = PlayerPedId()
        else
            player = ped
        end
    end
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(player, i-1)
        SetPedPropIndex(
            player,
            i-1,
            propZ,
            propTextures[i][2], true)
    end
end

function GetSkinTotal()
	return {
        #male_peds,
        #female_peds
    }
end

local toggleClothing = {}
function ToggleProps(data)
    local name = data["name"]

    selectedValue = has_value(drawable_names, name)
    if (selectedValue > -1) then
        if (toggleClothing[name] ~= nil) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            toggleClothing[name] = {
                GetPedDrawableVariation(player, tonumber(selectedValue)),
                GetPedTextureVariation(player, tonumber(selectedValue))
            }

            local value = -1
            if name == "undershirts" or name == "torsos" then
                value = 15
                if name == "undershirts" and GetEntityModel(PlayerPedId()) == joaat('mp_f_freemode_01') then
                    value = -1
                end
            end
            if name == "legs" then
                value = 14
            end

            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                value, 0, 2)
        end
    else
        selectedValue = has_value(prop_names, name)
        if (selectedValue > -1) then
            if (toggleClothing[name] ~= nil) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            else
                toggleClothing[name] = {
                    GetPedPropIndex(player, tonumber(selectedValue)),
                    GetPedPropTextureIndex(player, tonumber(selectedValue))
                }
                ClearPedProp(player, tonumber(selectedValue))
            end
        end
    end
end

function SaveToggleProps()
    for k in pairs(toggleClothing) do
        local name  = k
        selectedValue = has_value(drawable_names, name)
        if (selectedValue > -1) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            selectedValue = has_value(prop_names, name)
            if (selectedValue > -1) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            end
        end
    end
end

function LoadPed(data)
    local armor = GetPedArmour(PlayerPedId())
    SetSkin(data.model, true)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Wait(500)
    SetPedHairColor(player, tonumber(data.hairColor[1]), tonumber(data.hairColor[2]))
    SetPedHeadBlend(data.headBlend)
    SetHeadStructure(data.headStructure)
    SetHeadOverlayData(data.headOverlay)
    SetPedArmour(player, armor)
    FinalizeHeadBlend(player)
    return
end

function GetCurrentPed()
    player = PlayerPedId()
    return {
        model = GetEntityModel(PlayerPedId()),
        hairColor = GetPedHair(),
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructure(),
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
    }
end

function PlayerModel(data)
    local skins = nil
    local skin = nil
    if (data['name'] == 'skin_male') then
        skin = male_peds[tonumber(data['value'])]
    else
        skin = female_peds[tonumber(data['value'])]
    end
    if skin then
        rotation(180.0)
        SetSkin(tonumber(skin), true)
        Wait(1)
        rotation(180.0)
    else
        QBCore.Functions.TriggerCallback("raid_clothes:getPedSkins", function(skins)
            male_peds = skins.male
            female_peds = skins.female
            if (data['name'] == 'skin_male') then
                skin = male_peds[tonumber(data['value'])]
            else
                skin = female_peds[tonumber(data['value'])]
            end
            if skin then
                rotation(180.0)
                SetSkin(tonumber(skin), true)
                Wait(1)
                rotation(180.0)
            end
        end)
    end
end

function SetSkin(model, setDefault)
    -- TODO: If not isCop and model not in copModellist, do below.
    -- Model is a hash, joaat(modelName)
    if IsModelValid(model) then
        exports['prdx_healthsystem']:DisableHealthSystem(true)
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        ClearPedDecorations(PlayerPedId())
        ClearPedFacialDecorations(PlayerPedId())
        ClearAllPedProps(PlayerPedId())
        SetPedHairColor(PlayerPedId(), 0, 0)
        SetPedEyeColor(PlayerPedId(), 0)
        SetModelAsNoLongerNeeded(model)
        SetPedDefaultComponentVariation(PlayerPedId())
        SetPedCanLosePropsOnDamage(PlayerPedId(), false)
        player = PlayerPedId()
        FreezePedCameraRotation(player, true)
        if setDefault and model ~= nil then
            if (model ~= `mp_f_freemode_01` and model ~= `mp_m_freemode_01`) then
                SetPedRandomComponentVariation(PlayerPedId(), true)
            else
                SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
                SetPedComponentVariation(player, 11, 0, 11, 0)
                SetPedComponentVariation(player, 8, 0, 1, 0)
                SetPedComponentVariation(player, 6, 1, 2, 0)
                SetPedHeadOverlayColor(player, 1, 1, 0, 0)
                SetPedHeadOverlayColor(player, 2, 1, 0, 0)
                SetPedHeadOverlayColor(player, 4, 2, 0, 0)
                SetPedHeadOverlayColor(player, 5, 2, 0, 0)
                SetPedHeadOverlayColor(player, 8, 2, 0, 0)
                SetPedHeadOverlayColor(player, 10, 1, 0, 0)
                SetPedHeadOverlay(player, 1, 0, 0.0)
                SetPedHairColor(player, 1, 1)
            end
        end
        local health = GetEntityHealth(PlayerPedId())  
        local maxHealth = GetEntityMaxHealth(PlayerPedId())  
        SetEntityMaxHealth(PlayerPedId(), maxHealth)
        SetEntityHealth(PlayerPedId(), health)
    end
    Wait(250)
    exports['prdx_healthsystem']:DisableHealthSystem(false)
end


RegisterNUICallback('updateclothes', function(data, cb)
    toggleClothing[data["name"]] = nil
    selectedValue = has_value(drawable_names, data["name"])
    if (selectedValue > -1) then
        SetPedComponentVariation(player, tonumber(selectedValue), tonumber(data["value"]), tonumber(data["texture"]), 2)
        if tonumber(selectedValue) == 2 then
            ClearPedDecorations(player)
            local Gender = IsPedMale(player)
            
            if Gender == 1 then
                Gender = 'm'
            else
                Gender = 'f'
            end
            
            
            if hairDecor[Gender][tonumber(data["value"])] ~= nil then
                AddPedDecorationFromHashes(player, hairDecor[Gender][tonumber(data["value"])][1], hairDecor[Gender][tonumber(data["value"])][2])
                print('Send update to tattoos')
                TriggerEvent('xnTattoos:setHairDecor', hairDecor[Gender][tonumber(data["value"])][1], hairDecor[Gender][tonumber(data["value"])][2])
            else
                print('Send update to tattoos 2')
                AddPedDecorationFromHashes(player, hairDecorDefault[1], hairDecorDefault[2])
                TriggerEvent('xnTattoos:setHairDecor', hairDecorDefault[1], hairDecorDefault[2])
            end
        end
        cb({
            GetNumberOfPedTextureVariations(player, tonumber(selectedValue), tonumber(data["value"]))
        })
    else
        selectedValue = has_value(prop_names, data["name"])
        if (tonumber(data["value"]) == -1) then
            ClearPedProp(player, tonumber(selectedValue))
        else
            SetPedPropIndex(
                player,
                tonumber(selectedValue),
                tonumber(data["value"]),
                tonumber(data["texture"]), true)
        end
        cb({
            GetNumberOfPedPropTextureVariations(
                player,
                tonumber(selectedValue),
                tonumber(data["value"])
            )
        })
    end
end)

RegisterNUICallback('customskin', function(data, cb)
    if canUseCustomSkins() then
        local valid_model = isInSkins(data)
        if valid_model then
            SetSkin(joaat(data), true)
        end
    end
end)

RegisterNUICallback('setped', function(data, cb)
    PlayerModel(data)
    RefreshUI()
    cb('ok')
end)

RegisterNUICallback('resetped', function(data, cb)
    LoadPed(oldPed)
    cb('ok')
end)


------------------------------------------------------------------------------------------
-- Barber

function GetPedHeadBlendData()
    local blob = string.rep("\0\0\0\0\0\0\0\0", 6 + 3 + 1) -- Generate sufficient struct memory.
    if not Citizen.InvokeNative(0x2746BD9D88C5C5D0, player, blob, true) then -- Attempt to write into memory blob.
        return nil
    end

    return {
        shapeFirst = string.unpack("<i4", blob, 1),
        shapeSecond = string.unpack("<i4", blob, 9),
        shapeThird = string.unpack("<i4", blob, 17),
        skinFirst = string.unpack("<i4", blob, 25),
        skinSecond = string.unpack("<i4", blob, 33),
        skinThird = string.unpack("<i4", blob, 41),
        shapeMix = string.unpack("<f", blob, 49),
        skinMix = string.unpack("<f", blob, 57),
        thirdMix = string.unpack("<f", blob, 65),
        hasParent = string.unpack("b", blob, 73) ~= 0,
    }
end

function SetPedHeadBlend(data)
    SetPedHeadBlendData(player,
        tonumber(data['shapeFirst']),
        tonumber(data['shapeSecond']),
        tonumber(data['shapeThird']),
        tonumber(data['skinFirst']),
        tonumber(data['skinSecond']),
        tonumber(data['skinThird']),
        tonumber(data['shapeMix']),
        tonumber(data['skinMix']),
        tonumber(data['thirdMix']),
    false)
    FinalizeHeadBlend(player)
end

function GetHeadOverlayData()
    local headData = {}
    for i = 1, #head_overlays do
        local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, i-1)
        if retval then
            headData[i] = {}
            headData[i].name = head_overlays[i]
            headData[i].overlayValue = overlayValue
            headData[i].colourType = colourType
            headData[i].firstColour = firstColour
            headData[i].secondColour = secondColour
            headData[i].overlayOpacity = overlayOpacity
        end
    end
    return headData
end

function SetHeadOverlayData(data)
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            SetPedHeadOverlay(player,  i-1, tonumber(data[i].overlayValue),  tonumber(data[i].overlayOpacity))
            -- SetPedHeadOverlayColor(player, i-1, data[i].colourType, data[i].firstColour, data[i].secondColour)
        end

        SetPedHeadOverlayColor(player, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(player, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(player, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(player, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(player, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(player, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(player, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(player, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(player, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(player, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(player, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(player, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

function GetHeadOverlayTotals()
    local totals = {}
    for i = 1, #head_overlays do
        totals[head_overlays[i]] = GetNumHeadOverlayValues(i-1)
    end
    return totals
end

function GetPedHair()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

function GetHeadStructureData()
    local structure = {}
    for i = 1, #face_features do
        structure[face_features[i]] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetHeadStructure(data)
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function SetHeadStructure(data)
    for i = 1, #face_features do
        SetPedFaceFeature(player, i-1, data[i])
    end
end


-- RegisterNUICallback('saveheadblend', function(data, cb)
--     SetPedHeadBlendData(player,
--     tonumber(data.shapeFirst),
--     tonumber(data.shapeSecond),
--     tonumber(data.shapeThird),
--     tonumber(data.skinFirst),
--     tonumber(data.skinSecond),
--     tonumber(data.skinThird),
--     tonumber(data.shapeMix) / 100,
--     tonumber(data.skinMix) / 100,
--     tonumber(data.thirdMix) / 100, false)
--     cb('ok')
-- end)

RegisterNUICallback('saveheadblend', function(data, cb)
    SetPedHeadBlendData(player,
    tonumber(data.shapeFirst),
    tonumber(data.shapeSecond),
    0,
    tonumber(data.skinFirst),
    tonumber(data.skinSecond),
    tonumber(data.skinThird),
    tonumber(data.shapeMix) / 100,
    tonumber(data.skinMix) / 100,
    0.0, true)
    cb('ok')
    FinalizeHeadBlend(player)
end)


RegisterNUICallback('savehaircolor', function(data, cb)
    SetPedHairColor(player, tonumber(data['firstColour']), tonumber(data['secondColour']))
end)

RegisterNUICallback('savefacefeatures', function(data, cb)
    if data.name == "Eye_Color" then
        SetPedEyeColor(PlayerPedId(), tonumber(data.scale))
    else
        local index = has_value(face_features, data["name"])
        if (index <= -1) then return end
        local scale = tonumber(data["scale"]) / 100
        SetPedFaceFeature(player, index, scale)
    end
    cb('ok')
end)

RegisterNUICallback('saveheadoverlay', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    SetPedHeadOverlay(player,  index, tonumber(data["value"]), tonumber(data["opacity"]) / 100)
    cb('ok')
end)

RegisterNUICallback('saveheadoverlaycolor', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    local success, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, index)
    local sColor = tonumber(data['secondColour'])
    if (sColor == nil) then
        sColor = tonumber(data['firstColour'])
    end
    SetPedHeadOverlayColor(player, index, colourType, tonumber(data['firstColour']), sColor)
    cb('ok')
end)


-- RegisterCommand("outfitadd", function(source, args, rawCommand)
--     if (IsNearShop(Config.clothingShops) < 9.0) then
--         if args[1] and args[2] then
--             TriggerEvent('raid_clothes:outfits', 1, tonumber(args[1]), args[2])
--         else
--             TriggerEvent('notification', 'You need to do something like /outfitadd 1 <br/ > <br/ > 1 being the slot id that you will have had previously saved')
 
--         end
--     else
--         TriggerEvent("notification", "Not Near A Clothing Store", 2)
--     end
-- end, false)

-- RegisterCommand("outfituse", function(source, args, rawCommand)
--     if (IsNearShop(Config.clothingShops) < 9.0) then
--         if args[1] then
--             TriggerEvent('raid_clothes:outfits', 3, tonumber(args[1]))

--          TriggerEvent("facewear:adjust",5,false)
--          TriggerEvent('InteractSound_CL:PlayOnOne','Clothes1', 0.6)

--         else
--             TriggerEvent('notification', 'You need to do something like /oufituse 1 <br/ > <br/ > 1 being the slot id that you will have had previously saved')
 
--         end
--     else
--         TriggerServerEvent("raid_clothes:list_outfits")
--         TriggerEvent("notification", "Not Near A Clothing Store", 2)
--     end
-- end, false) 

-- RegisterCommand("removeoutfit", function(source, args, rawCommand)
--     if (IsNearShop(Config.clothingShops) < 9.0) then
--         if args[1] then
--             TriggerEvent('raid_clothes:outfits', 2, tonumber(args[1]))
--         else
--             TriggerEvent('notification', 'You need to do something like /removeoutfit 1 <br/ > <br/ > 1 being the slot id that you will have had previously saved')
 
--         end
--     else
--         TriggerEvent("notification", "Not Near A Clothing Store", 2)
--     end
-- end, false) 


-- RegisterCommand('outfits', function(source, args, raw)
--     local nearcloth = IsNearShop(Config.clothingShops)
--     local coord = GetEntityCoords(source)
--     if nearcloth < 10 then
--         TriggerServerEvent("raid_clothes:list_outfits")
--     else
--         TriggerEvent("notification", "Not Near A Clothing Store", 2)
--     end

-- end, false)

----------------------------------------------------------------------------------
-- UTIL SHIT


function has_value (tab, val)
    for index = 1, #tab do
        if tab[index] == val then
            return index-1
        end
    end
    return -1
end

function EnableGUI(enable, menu)
    --QBCore.Functions.TriggerCallback("raid_clothes:getPedSkins", function(skins)
        --male_peds = skins.male
        --female_peds = skins.female
        enabled = enable
        SetNuiFocus(enable, enable)
        if enable == true then
            QBCore.Functions.TriggerCallback("raid_clothes:getVIP", function(isVIP)
                QBCore.Functions.TriggerCallback("raid_clothes:getOutfits", function(outfits)
                    SendNUIMessage({
                        type = "enableclothesmenu",
                        enable = enable,
                        menu = menu,
                        isService = isService,
                        creator = firstChar,
                        outfits = outfits,
                        showPeds = isVIP
                    })
                end)
            end)
        else
            SendNUIMessage({
                type = "enableclothesmenu",
                enable = enable,
                menu = menu,
                isService = isService,
                creator = firstChar
            })
        end

        if (not enable) then
            SaveToggleProps()
            oldPed = {}
        end
    --end)
end

function CustomCamera(position)
    if position ~= "apartment" and (customCam or position == "torso") then
        FreezePedCameraRotation(player, false)
        SetCamActive(cam, false)
        RenderScriptCams(false,  false,  0,  true,  true)
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end
        customCam = false
    else
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end
        
        local pos = GetEntityCoords(player, true)
        if position == "apartment" then
            SetEntityRotation(player, 0.0, 180.0, 0.0, 1, true)
        else
            SetEntityRotation(player, 0.0, 0.0, 0.0, 1, true)
        end
        FreezePedCameraRotation(player, true)

        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        
        if position == "apartment" then
            SetCamCoord(cam, GetOffsetFromEntityInWorldCoords(player, 0, -2.0, 0))
            SetCamRot(cam, 0.0, 0.0, 180.0)
        else
            SetCamCoord(cam, player)
            SetCamRot(cam, 0.0, 0.0, 0.0)
        end

        SetCamActive(cam, true)
        RenderScriptCams(true,  false,  0,  true,  true)

        if position ~= "apartment" then
            SwitchCam(position)
        end
        customCam = true
    end
end

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId())+dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
end

function TogRotation()
    local pedRot = GetEntityHeading(PlayerPedId())+90 % 360
    SetEntityHeading(PlayerPedId(), math.floor(pedRot / 90) * 90.0)
end

function SwitchCam(name)
    if name == "cam" then
        TogRotation()
        return
    end

    local pos = GetEntityCoords(player, true)
    local bonepos = false
    if (name == "head") then
        bonepos = GetPedBoneCoords(player, 31086)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 0.4, bonepos.z + 0.05)
    end 
    if (name == "torso") then
        bonepos = GetPedBoneCoords(player, 11816)
        bonepos = vector3(bonepos.x - 0.4, bonepos.y + 2.2, bonepos.z + 0.2)
    end
    if (name == "leg") then
        bonepos = GetPedBoneCoords(player, 46078)
        bonepos = vector3(bonepos.x - 0.1, bonepos.y + 1, bonepos.z)
    end

    if bonepos then
        SetCamCoord(cam, bonepos.x, bonepos.y, bonepos.z)
    end
    SetCamRot(cam, 0.0, 0.0, 180.0)
end

RegisterNetEvent("clothing:close")
AddEventHandler("clothing:close", function()
    EnableGUI(false, false)
end)

RegisterNetEvent("clothing:open")
AddEventHandler("clothing:open", function()
    OpenMenu("barbermenu")
    startingMenu = true
    firstChar = true
end)

RegisterNUICallback('escape', function(data, cb)
    TriggerServerEvent("Police:getMeta")
    Save(data['save'], data['name'])
    cb('ok')
end)

RegisterNUICallback('togglecursor', function(data, cb)
    CustomCamera("torso")
    SetNuiFocus(false, false)
    FreezePedCameraRotation(player, false)
    cb('ok')
end)

RegisterNUICallback('rotate', function(data, cb)
    if (data["key"] == "left") then
        rotation(20)
    else
        rotation(-20)
    end
    cb('ok')
end)

RegisterNUICallback('switchcam', function(data, cb)
    CustomCamera(data['name'])
    cb('ok')
end)

RegisterNUICallback('toggleclothes', function(data, cb)
    ToggleProps(data)
    cb('ok')
end)


------------------------------------------------------------------------
-- Tattooooooos


-- currentTats [[collectionHash, tatHash], [collectionHash, tatHash]]
-- loop tattooHashList [categ] find [tatHash, collectionHash]

function GetTats()
    local tempTats = {}
    if currentTats == nil then return {} end
    for i = 1, #currentTats do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTats[i][2] then
                    tempTats[key] = j
                end
            end
        end
    end
    return tempTats
end

function SetTats(data)
    -- currentTats = {}
    -- for k, v in pairs(data) do
    --     for categ in pairs(tattooHashList) do
    --         if k == categ then
    --             local something = tattooHashList[categ][tonumber(v)]
    --             if something ~= nil then
    --                 table.insert(currentTats, {something[2], something[1]})
    --             end
    --         end
    --     end
    -- end
    -- ClearPedDecorations(PlayerPedId())
    -- for i = 1, #currentTats do
    --     ApplyPedOverlay(PlayerPedId(), currentTats[i][1], currentTats[i][2])
    -- end
end

RegisterNUICallback('settats', function(data, cb)
    SetTats(data["tats"])
    cb('ok')
end)


--------------------------------------------------------------------
-- Main menu

function OpenMenu(name)
    player = PlayerPedId()
    oldPed = GetCurrentPed()
    local isAllowed = false
    if(oldPed.model == 1885233650 or oldPed.model == -1667301416) then isAllowed = true end
    if((oldPed.model ~= 1885233650 or oldPed.model ~= -1667301416) and (name == "clothesmenu" or name == "tattoomenu")) then isAllowed = true end
    isAllowed = true
    if isAllowed then
        FreezePedCameraRotation(player, true)
        RefreshUI()
        EnableGUI(true, name)
        -- TaskAchieveHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 180)
    else
        TriggerEvent("DoLongHudText", "You are not welcome here!");
    end
end

function Save(save, name)
    if save then
        TriggerServerEvent("clothing:takeMoney",shopType,StoreCost)
        shopType = nil
        StoreCost = 0
        local data = GetCurrentPed()
        data.eyeColor = GetPedEyeColor(PlayerPedId())
        TriggerServerEvent("raid_clothes:insert_character_current", data)
        if name ~= "" and name ~= nil then
            TriggerServerEvent("raid_clothes:set_outfit", name, data)
        end
        if data.model == `mp_f_freemode_01` or data.model == `mp_m_freemode_01` then
            TriggerServerEvent("raid_clothes:insert_character_face", data)
            TriggerEvent("raid_clothes:setpedfeatures", data)
            TriggerEvent("xnTattoos:SetTattoos")
        end
        EnableGUI(false, false)
    else
        LoadPed(oldPed)
        if not characterid then
            characterid = QBCore.Functions.GetPlayerData().citizenid
        end
        TriggerServerEvent("raid_clothes:get_character_face", characterid)
        TriggerEvent("xnTattoos:SetTattoos")
    end

    EnableGUI(false, false)

    if firstChar then
        Wait(1000)
        OpenMenu("clothesmenu")
        CustomCamera("apartment")
        SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 180)
        firstChar = false
    else
        FreezePedCameraRotation(player, false)
        SetCamActive(cam, false)
        RenderScriptCams(false,  false,  0,  true,  true)
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end
        customCam = false
        startingMenu = false
    end

    -- TriggerEvent("ressurection:relationships:norevive")
    -- TriggerEvent("gangs:setDefaultRelations")
    -- TriggerEvent("facewear:update")
    -- TriggerEvent('np-weapons:getAmmo')
    -- TriggerEvent("e-blips:updateAfterPedChange",exports["isPed"]:isPed("myjob"))
end

function IsNearShop(shops)
    local dstchecked = 1000
    local plyPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	for i = 1, #shops do
		shop = shops[i]
		local comparedst = Vdist(plyPos.x, plyPos.y, plyPos.z,shop[1], shop[2], shop[3])
		if comparedst < dstchecked then
			dstchecked = comparedst
		end
	end
	return dstchecked
end


function addBlips()
    showBarberShopBlips = true
    TriggerEvent('hairDresser:ToggleHair')
end

CreateThread(function()
    for k, v in pairs (Config.clothingShops) do
        local clothingShop = AddBlipForCoord(v)
        SetBlipSprite(clothingShop, 73)
        SetBlipColour(clothingShop, 2)
        SetBlipScale(clothingShop, 0.5)
        SetBlipAsShortRange(clothingShop, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Clothing Store")
        EndTextCommandSetBlipName(clothingShop)
    end

    for k, v in pairs (Config.barberShops) do
        local barberShop = AddBlipForCoord(v)
        SetBlipSprite(barberShop, 71)
        SetBlipColour(barberShop, 1)
        SetBlipScale(barberShop, 0.5)
        SetBlipAsShortRange(barberShop, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Barber Store")
        EndTextCommandSetBlipName(barberShop)
    end

    -- for k, v in pairs (Config.tattoosShops) do
    --     local tattoosShop = AddBlipForCoord(v)
    --     SetBlipSprite(tattoosShop, 75)
    --     SetBlipColour(tattoosShop, 5)
    --     SetBlipScale(tattoosShop, 0.5)
    --     SetBlipAsShortRange(tattoosShop, true)
    --     BeginTextCommandSetBlipName("STRING")
    --     AddTextComponentString("Tattoo Store")
    --     EndTextCommandSetBlipName(tattoosShop)
    -- end
end)

CreateThread(function()
    addBlips()
	while true do
		Wait(1)
        local nearcloth = IsNearShop(Config.clothingShops)
        --local neartat = IsNearShop(Config.tattoosShops)
        local nearbarber = IsNearShop(Config.barberShops)
        local jailcheck = GetInteriorFromEntity(GetPlayerPed(PlayerId()))

        local menu = nil

        if nearcloth < 5.0 and jailcheck == 12282 then
            menu = {"clothesmenu", "Press ~g~E~s~ to change in to prison outfits"}
        elseif nearcloth < 5.0 then
            StoreCost = 0;
            menu = {"clothesmenu", "Press ~g~E~s~ to change Clothes $"..StoreCost}
        -- elseif neartat < 5.0 then
        --     StoreCost = 400;
        --     menu = {"tattoomenu", "Press ~g~E~s~ to change Tattoos $"..StoreCost}
        elseif nearbarber < 5.0 then
            StoreCost = 0;
            menu = {"barbermenu", "Press ~g~E~s~ to visit the Barber $"..StoreCost}
        elseif startingMenu then
            menu = "clothesmenu"
        end


        if (menu ~= nil) then
            if (not enabled) then
                DisplayHelpText(menu[2])

                if IsControlJustPressed(1, 38) then
                    TriggerServerEvent("clothing:checkMoney",menu[1],StoreCost)
                end
            else
                if (IsControlJustReleased(1, 25)) then
                    SetNuiFocus(true, true)
                    FreezePedCameraRotation(player, true)
                end
                InvalidateIdleCam()
            end
        else
            local dist = math.min(nearcloth, nearbarber)
            if dist > 10 then
                Wait(math.ceil(dist * 10))
            end
		end
	end
end)

AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    TriggerServerEvent("raid_clothes:get_character_current")
end)

AddEventHandler("qb-clothes:client:CreateFirstCharacter", function()
    TriggerEvent("raid_clothes:setclothes", {}, 0)
    CreateThread(function()
        while true do
            Wait(0)
            SetTextComponentFormat("STRING")
            AddTextComponentString("Press ~INPUT_FRONTEND_CANCEL~ to progress")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if startingMenu == false then
                break
            end
        end
    end)
end)

RegisterNetEvent("raid_clothes:inService")
AddEventHandler("raid_clothes:inService", function(service)
    isService = service
end)


RegisterNetEvent("raid_clothes:hasEnough")
AddEventHandler("raid_clothes:hasEnough", function(menu)
    if menu == "tattoomenu" then
        TriggerServerEvent("raid_clothes:retrieve_tats")
        while currentTats == nil do
            Wait(1)
        end
    end
    shopType = menu
    OpenMenu(menu)
end)

RegisterNetEvent("raid_clothes:setclothes")
AddEventHandler("raid_clothes:setclothes", function(data, alreadyExist, ped, citizenid)
    player = PlayerPedId()
    local characterid = citizenid
    local function setDefault()
        CreateThread(function()
            firstChar = true
            local PlayerData = QBCore.Functions.GetPlayerData()
            local gender = PlayerData.charinfo.gender
            if gender ~= 0 then
                SetSkin(`mp_f_freemode_01`, true)
            else
                SetSkin(`mp_m_freemode_01`, true)
            end
            OpenMenu("barbermenu")
            CustomCamera("apartment")
            startingMenu = true
            SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 180)
            DoScreenFadeIn(250)
        end)
    end

	if not data.model and alreadyExist <= 0 then setDefault() return end
    if not data.model and alreadyExist >= 1 then return end
    model = data.model
    model = model ~= nil and tonumber(model) or false
	if not IsModelInCdimage(model) or not IsModelValid(model) then setDefault() return end
    SetSkin(model, false)
    Wait(10)
    if ped then
        SetClothing(json.decode(data.drawables), json.decode(data.props), json.decode(data.drawtextures), json.decode(data.proptextures), ped)
    else
        SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    end
    Wait(50)
    if not characterid then
        characterid = QBCore.Functions.GetPlayerData().citizenid
    end
    TriggerServerEvent("raid_clothes:get_character_face", characterid)
    TriggerEvent("xnTattoos:SetTattoos")
end)

RegisterNetEvent("raid_clothes:AdminSetModel")
AddEventHandler("raid_clothes:AdminSetModel", function(model)
    local hashedModel = joaat(model)
    if not IsModelInCdimage(hashedModel) or not IsModelValid(hashedModel) then return end
    SetSkin(hashedModel, true)
end)


RegisterNetEvent("raid_clothes:defaultReset")
AddEventHandler("raid_clothes:defaultReset", function()
    local LocalPlayer = QBCore.Functions.GetPlayerData()
    local gender = LocalPlayer.gender
    Wait(1000)
    if gender ~= 0 then
        SetSkin(`mp_f_freemode_01`, true)
    else
        SetSkin(`mp_m_freemode_01`, true)
    end
    --SetPedHeadBlendData(PlayerPedId(), 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
    --menu = "clothesmenu"
    OpenMenu("clothesmenu")
    startingMenu = true
end)

RegisterNetEvent('hotel:list')
AddEventHandler('hotel:list', function(skincheck)
    for i = 1, #skincheck do
        TriggerEvent("notification", skincheck[i].slot.."  |  "..skincheck[i].name, 1)
   
	end
end)


RegisterNetEvent("raid_clothes:settattoos")
AddEventHandler("raid_clothes:settattoos", function(playerTattoosList)
    --currentTats = playerTattoosList
    --SetTats(GetTats())
end)

RegisterNetEvent("raid_clothes:setpedfeatures")
AddEventHandler("raid_clothes:setpedfeatures", function(data)
    
    if selectorPed == 'player' then
        player = PlayerPedId()
    elseif selectorPed == nil then
        player = PlayerPedId()
    else
        player = selectorPed
    end
    
    
    if data == false then
        
        SetSkin(GetEntityModel(PlayerPedId()), true)
        return
    end
    
    local haircolor = data.hairColor
    if data.headBlend then
        local head = data.headBlend
        SetPedHeadBlendData(player,
            tonumber(head['shapeFirst']),
            tonumber(head['shapeSecond']),
            tonumber(head['shapeThird']),
            tonumber(head['skinFirst']),
            tonumber(head['skinSecond']),
            tonumber(head['skinThird']),
            tonumber(head['shapeMix']),
            tonumber(head['skinMix']),
            tonumber(head['thirdMix']),
            false)
            
        while not HasPedHeadBlendFinished(player) do
            Wait(0)
        end
        FinalizeHeadBlend(player)
    end
    SetHeadStructure(data.headStructure)
    
    SetPedHairColor(player, tonumber(haircolor[1]), tonumber(haircolor[2]))

    SetPedEyeColor(player, tonumber(data.eyeColor))
    
    SetHeadOverlayData(data.headOverlay)
    GetDrawables()
    TriggerEvent('clothing:setupCommandsData')
    local drawables = GetDrawables()
    for i = 1, #drawable_names do
        
        if drawable_names[i] == 'hair' then
            local drawable = drawables[i-1][2]
            ClearPedDecorations(player)
            local Gender = IsPedMale(player)
            if Gender == 1 then
                Gender = 'm'
            else
                Gender = 'f'
            end
            if hairDecor[Gender][drawable] ~= nil then
                TriggerEvent('xnTattoos:setHairDecor', hairDecor[Gender][drawable][1], hairDecor[Gender][drawable][2])
                AddPedDecorationFromHashes(player, hairDecor[Gender][drawable][1], hairDecor[Gender][drawable][2])
            else
                TriggerEvent('xnTattoos:setHairDecor', hairDecorDefault[1], hairDecorDefault[2])
                AddPedDecorationFromHashes(player, hairDecorDefault[1], hairDecorDefault[2])
            end
        end
    end
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


RegisterNetEvent('raid_clothes:outfits')
AddEventHandler('raid_clothes:outfits', function(pAction, pId, pName)
    if pAction == 1 then
        data = GetCurrentPed()
        data.eyeColor = GetPedEyeColor(PlayerPedId())
        Wait(1500)
        TriggerServerEvent("raid_clothes:insert_character_current", data)
        
        TriggerServerEvent("raid_clothes:set_outfit", pId, pName)
        if data.model == `mp_f_freemode_01` or data.model == `mp_m_freemode_01` then
            TriggerServerEvent("raid_clothes:insert_character_face", data)
            TriggerEvent("xnTattoos:SetTattoos")
        end
        --TriggerServerEvent("raid_clothes:set_outfit",pId, pName, GetCurrentPed())
    elseif pAction == 2 then
        TriggerServerEvent("raid_clothes:remove_outfit",pId)
    elseif pAction == 3 then 
        TriggerEvent('item:deleteClothesDna')
        TriggerEvent('InteractSound_CL:PlayOnOne','Clothes1', 0.6)
        TriggerServerEvent("raid_clothes:get_outfit", pId)
    else
        TriggerServerEvent("raid_clothes:list_outfits")
    end
end)

RegisterNetEvent("raid_clothes:setSavedOutfit")
AddEventHandler("raid_clothes:setSavedOutfit", function(data)
    local currArmor = GetPedArmour(PlayerPedId())
    TriggerEvent("raid_clothes:setclothes", data, 1, "player")
    Wait(1500)
    SetPedHairColor(player, tonumber(json.decode(data.hairColor)[1]), tonumber(json.decode(data.hairColor)[2]))
    data = GetCurrentPed()
    data.eyeColor = GetPedEyeColor(PlayerPedId())
    TriggerServerEvent("raid_clothes:insert_character_current", data)
    
    if data.model == `mp_f_freemode_01` or data.model == `mp_m_freemode_01` then
        TriggerServerEvent("raid_clothes:insert_character_face", data)
        TriggerEvent("xnTattoos:SetTattoos")
    end
    SetPedArmour(PlayerPedId(), currArmor)
end)

RegisterNetEvent("raid_clothes:deleteSavedOutfit")
AddEventHandler("raid_clothes:deleteSavedOutfit", function(outfit)
    TriggerServerEvent("raid_clothes:remove_outfit", outfit.name)
end)

RegisterNetEvent('raid_clothes:outfitsMenu')
AddEventHandler('raid_clothes:outfitsMenu', function()
    local menu = {}

    QBCore.Functions.TriggerCallback("raid_clothes:getOutfits", function(outfits)
        for k,v in pairs(outfits) do
            menu[#menu+1] = {
                title = v.name,
                event = "raid_clothes:outfitMenu",
                args = v
            }
        end
        lib.registerContext({
            id = 'outfits_menu',
            title = "Outfits",
            options = menu,
        })
        lib.showContext('outfits_menu')
    end)
end)

RegisterNetEvent('raid_clothes:outfitMenu')
AddEventHandler('raid_clothes:outfitMenu', function(outfit)
    local menu = {
        {
            title = "Change Into Outfit",
            event = "raid_clothes:setSavedOutfit",
            args = outfit
        },
        {
            title = "Delete Outfit",
            event = "raid_clothes:deleteSavedOutfit",
            args = outfit
        }
    }
    lib.registerContext({
        id = 'outfits_change_menu',
        title = outfit.name,
        menu = 'outfits_menu',
        options = menu,
    })
    lib.showContext('outfits_change_menu')
end)

RegisterNetEvent('raid_clothes:client:openJobClothing')
AddEventHandler('raid_clothes:client:openJobClothing', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if Config.Outfits[PlayerData.job.name] then
        gender = "male"
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then gender = "female" end
        local menu = {}

        menu[#menu+1] = {
            title = "Regular Clothes",
            serverEvent = "raid_clothes:get_character_current"
        }

        for k,v in pairs(Config.Outfits[PlayerData.job.name][gender]) do
            menu[#menu+1] = {
                title = v.outfitLabel,
                event = "raid_clothes:client:loadOutfit",
                args = v
            }
        end
        lib.registerContext({
            id = 'job_clothing_menu',
            title = "Preset Outfits",
            options = menu,
        })
        lib.showContext('job_clothing_menu')
    else
        QBCore.Functions.Notify("Couldn't find any uniforms for your job", "error")
    end
end)

RegisterNetEvent('raid_clothes:client:loadOutfit')
AddEventHandler('raid_clothes:client:loadOutfit', function(oData, name, id)
    local ped = PlayerPedId()
    gender = "male"
    if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then gender = "female" end
    if name then
        if Config.Outfits[name][gender][id or 1] then
            data = Config.Outfits[name][gender][id or 1].outfitData
        end
    else
        data = oData.outfitData or oData.args[1].outfitData
    end

    if type(data) ~= "table" then data = json.decode(data) end

    -- Pants
    if data["pants"] ~= nil then
        SetPedComponentVariation(ped, 4, data["pants"].item, data["pants"].texture, 0)
    end

    -- Arms
    if data["arms"] ~= nil then
        SetPedComponentVariation(ped, 3, data["arms"].item, data["arms"].texture, 0)
    end

    -- T-Shirt
    if data["t-shirt"] ~= nil then
        SetPedComponentVariation(ped, 8, data["t-shirt"].item, data["t-shirt"].texture, 0)
    end

    -- Vest
    if data["vest"] ~= nil then
        SetPedComponentVariation(ped, 9, data["vest"].item, data["vest"].texture, 0)
    end

    -- Torso 2
    if data["torso2"] ~= nil then
        SetPedComponentVariation(ped, 11, data["torso2"].item, data["torso2"].texture, 0)
    end

    -- Shoes
    if data["shoes"] ~= nil then
        SetPedComponentVariation(ped, 6, data["shoes"].item, data["shoes"].texture, 0)
    end

    -- Bag
    if data["bag"] ~= nil then
        SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)
    end

    -- Badge
    if data["decals"] ~= nil then
        SetPedComponentVariation(ped, 10, data["decals"].item, data["decals"].texture, 0)
    end

    -- Accessory
    if data["accessory"] ~= nil then
        if QBCore.Functions.GetPlayerData().metadata["tracker"] then
            SetPedComponentVariation(ped, 7, 13, 0, 0)
        else
            SetPedComponentVariation(ped, 7, data["accessory"].item, data["accessory"].texture, 0)
        end
    else
        if QBCore.Functions.GetPlayerData().metadata["tracker"] then
            SetPedComponentVariation(ped, 7, 13, 0, 0)
        else
            SetPedComponentVariation(ped, 7, -1, 0, 2)
        end
    end

    -- Mask
    if data["mask"] ~= nil then
        SetPedComponentVariation(ped, 1, data["mask"].item, data["mask"].texture, 0)
    end

    -- Bag
    if data["bag"] ~= nil then
        SetPedComponentVariation(ped, 5, data["bag"].item, data["bag"].texture, 0)
    end

    -- Hat
    if data["hat"] ~= nil then
        if data["hat"].item ~= -1 and data["hat"].item ~= 0 then
            SetPedPropIndex(ped, 0, data["hat"].item, data["hat"].texture, true)
        else
            ClearPedProp(ped, 0)
        end
    end

    -- Glass
    if data["glass"] ~= nil then
        if data["glass"].item ~= -1 and data["glass"].item ~= 0 then
            SetPedPropIndex(ped, 1, data["glass"].item, data["glass"].texture, true)
        else
            ClearPedProp(ped, 1)
        end
    end

    -- Ear
    if data["ear"] ~= nil then
        if data["ear"].item ~= -1 and data["ear"].item ~= 0 then
            SetPedPropIndex(ped, 2, data["ear"].item, data["ear"].texture, true)
        else
            ClearPedProp(ped, 2)
        end
    end

    if oData and oData.outfitName ~= nil then
        QBCore.Functions.Notify("You have chosen "..oData.outfitName.."! Press Confirm to confirm outfit.")
    end
end)

RegisterNetEvent('raid_clothes:client:buyMask', function()
    local ped = PlayerPedId()
    local prop = GetPedDrawableVariation(ped, 1)
    local texture = GetPedTextureVariation(ped, 1)
    if prop ~= -1 then
        Clothing.LoadAnimDict("missfbi4")
        TaskPlayAnim(PlayerPedId(), "missfbi4", "takeoff_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
        Wait(1200)   
        SetPedComponentVariation(PlayerPedId(), 1, -1, -1, -1)
        Clothing.Data[1] = {}
        Clothing.Data[1]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 1)
        Clothing.Data[1]["Texture"] = GetPedTextureVariation(PlayerPedId(), 1)
        Clothing.Data[1]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 1)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('clothing:GiveMask', prop, texture)
    else
        QBCore.Functions.Notify("You are not wearing a mask to convert!")
    end
end)

RegisterNetEvent('raid_clothes:client:buyHat', function()
    local ped = PlayerPedId()
    local prop = GetPedPropIndex(ped, 0)
    local texture = GetPedPropTextureIndex(ped, 0)
    if prop ~= -1 then
        Clothing.LoadAnimDict("missheist_agency2ahelmet")
        TaskPlayAnim(ped, "missheist_agency2ahelmet", "take_off_helmet_stand", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
        Wait(1200)   
        Clothing.Data[0] = {}
        Clothing.Data[0]["Prop"] = GetPedPropIndex(ped, 0)
        Clothing.Data[0]["Texture"] = GetPedPropTextureIndex(ped, 0)
        ClearPedProp(ped, 0)
        ClearPedTasks(ped)
        TriggerServerEvent('clothing:GiveHat', prop, texture)
    else
        QBCore.Functions.Notify("You are not wearing a hat to convert!")
    end
end)

RegisterNetEvent('raid_clothes:client:applyMask', function(maskdata)
    if maskdata then
        Clothing.LoadAnimDict("mp_masks@on_foot")
        TaskPlayAnim(PlayerPedId(), "mp_masks@on_foot", "put_on_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
        Wait(600)
        SetPedComponentVariation(PlayerPedId(), 1, maskdata.prop, maskdata.texture, true)
        ClearPedTasks(PlayerPedId())
        Clothing.Data["mask"] = {
            item = -1,
            texture = -1
        }
    end
end)

RegisterNetEvent('raid_clothes:client:applyHat', function(hatdata)
    if hatdata then
        Clothing.LoadAnimDict("veh@common@fp_helmet@")
        TaskPlayAnim(PlayerPedId(), "veh@common@fp_helmet@", "put_on_helmet", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
        Wait(600)
        SetPedPropIndex(PlayerPedId(), 0,  hatdata.prop, hatdata.texture, 0)
        ClearPedTasks(PlayerPedId())
        Clothing.Data["hat"] = {
            item = -1,
            texture = -1
        }
    end
end)
-- LoadPed(data) Sets clothing based on the data structure given, the same structure that GetCurrentPed() returns
-- GetCurrentPed() Gives you the data structure of the currently worn clothes

function GetOutfit(name, gender, key)
    if not key then local key = 1 end
    return Config.Outfits[name][gender][key]
end

exports("GetOutfit", GetOutfit)