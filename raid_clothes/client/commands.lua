Clothing = {}

RegisterNetEvent('clothing:setupCommandsData')
AddEventHandler('clothing:setupCommandsData', function()

    Clothing.Data[0] = {}
    Clothing.Data[0]["Prop"] = GetPedPropIndex(PlayerPedId(), 0)
    Clothing.Data[0]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), 0)

    Clothing.Data[1] = {}
    Clothing.Data[1]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 1)
    Clothing.Data[1]["Texture"] = GetPedTextureVariation(PlayerPedId(), 1)
    Clothing.Data[1]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 1)

    Clothing.Data[2] = {}
    Clothing.Data[2]["Prop"] = GetPedPropIndex(PlayerPedId(), 2)
    Clothing.Data[2]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), 2)

    Clothing.Data[3] = {}
    Clothing.Data[3]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 3)
    Clothing.Data[3]["Texture"] = GetPedTextureVariation(PlayerPedId(), 3)
    Clothing.Data[3]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 3)

    Clothing.Data[4] = {}
    Clothing.Data[4]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 4)
    Clothing.Data[4]["Texture"] = GetPedTextureVariation(PlayerPedId(), 4)
    Clothing.Data[4]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 4)

    Clothing.Data[6] = {}
    Clothing.Data[6]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 6)
    Clothing.Data[6]["Texture"] = GetPedTextureVariation(PlayerPedId(), 6)
    Clothing.Data[6]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 6)

    Clothing.Data[7] = {}
    Clothing.Data[7]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 7)
    Clothing.Data[7]["Texture"] = GetPedTextureVariation(PlayerPedId(), 7)
    Clothing.Data[7]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 7)

    Clothing.Data[8] = {}
    Clothing.Data[8]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 8)
    Clothing.Data[8]["Texture"] = GetPedTextureVariation(PlayerPedId(), 8)
    Clothing.Data[8]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 8)

    Clothing.Data[9] = {}
    Clothing.Data[9]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 9)
    Clothing.Data[9]["Texture"] = GetPedTextureVariation(PlayerPedId(), 9)
    Clothing.Data[9]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 9)

    Clothing.Data[10] = {}
    Clothing.Data[10]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 10)
    Clothing.Data[10]["Texture"] = GetPedTextureVariation(PlayerPedId(), 10)
    Clothing.Data[10]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 10)

    Clothing.Data[11] = {}
    Clothing.Data[11]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 11)
    Clothing.Data[11]["Texture"] = GetPedTextureVariation(PlayerPedId(), 11)
    Clothing.Data[11]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 11)

    Clothing.Data[12] = {}
    Clothing.Data[12]["Prop"] = GetPedPropIndex(PlayerPedId(), 1)
    Clothing.Data[12]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), 1)
    print('Updated Commands',  Clothing.Data[12]["Prop"])
end)

Clothing.Default = {
    [100] = { ["dict"] = "mp_masks@on_foot", ["animation"] = "put_on_mask",["animTime"] = 600, ["texure"] = 0 }
}

Clothing.Data = {
   [100] = { ["Prop"] = 1, ["Texture"] = 1, ["Palette"] = 1 }
}

RegisterCommand('t0', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1000)

    Clothing.Data[11] = {}
    Clothing.Data[11]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 11)
    Clothing.Data[11]["Texture"] = GetPedTextureVariation(PlayerPedId(), 11)
    Clothing.Data[11]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 11)

    Clothing.Data[6] = {}
    Clothing.Data[6]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 6)
    Clothing.Data[6]["Texture"] = GetPedTextureVariation(PlayerPedId(), 6)
    Clothing.Data[6]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 6)

    Clothing.Data[8] = {}
    Clothing.Data[8]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 8)
    Clothing.Data[8]["Texture"] = GetPedTextureVariation(PlayerPedId(), 8)
    Clothing.Data[8]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 8)

    Clothing.Data[3] = {}
    Clothing.Data[3]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 3)
    Clothing.Data[3]["Texture"] = GetPedTextureVariation(PlayerPedId(), 3)
    Clothing.Data[3]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 3)

    Clothing.Data[10] = {}
    Clothing.Data[10]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 10)
    Clothing.Data[10]["Texture"] = GetPedTextureVariation(PlayerPedId(), 10)
    Clothing.Data[10]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 10)

    if GetEntityModel(PlayerPedId()) == joaat("mp_m_freemode_01") then
        SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0)
    else
        SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0)
    end

    ClearPedTasks(PlayerPedId())
end)

RegisterCommand('t1', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1000)

    if Clothing.Data[11] then
        SetPedComponentVariation(PlayerPedId(), 11, Clothing.Data[11]["Prop"], Clothing.Data[11]["Texture"], Clothing.Data[11]["Palette"])
    end

    if Clothing.Data[8] then
        SetPedComponentVariation(PlayerPedId(), 8, Clothing.Data[8]["Prop"], Clothing.Data[8]["Texture"], Clothing.Data[8]["Palette"])
    end

    if Clothing.Data[3] then
        SetPedComponentVariation(PlayerPedId(), 3, Clothing.Data[3]["Prop"], Clothing.Data[3]["Texture"], Clothing.Data[3]["Palette"])
    end

    if Clothing.Data[10] then
        SetPedComponentVariation(PlayerPedId(), 10, Clothing.Data[10]["Prop"], Clothing.Data[10]["Texture"], Clothing.Data[10]["Palette"])
    end

    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/j0", 'Take off jacket')
RegisterCommand('j0', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1000)

    Clothing.Data[11] = {}
    Clothing.Data[11]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 11)
    Clothing.Data[11]["Texture"] = GetPedTextureVariation(PlayerPedId(), 11)
    Clothing.Data[11]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 11)

    Clothing.Data[6] = {}
    Clothing.Data[6]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 6)
    Clothing.Data[6]["Texture"] = GetPedTextureVariation(PlayerPedId(), 6)
    Clothing.Data[6]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 6)

    Clothing.Data[8] = {}
    Clothing.Data[8]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 8)
    Clothing.Data[8]["Texture"] = GetPedTextureVariation(PlayerPedId(), 8)
    Clothing.Data[8]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 8)

    Clothing.Data[3] = {}
    Clothing.Data[3]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 3)
    Clothing.Data[3]["Texture"] = GetPedTextureVariation(PlayerPedId(), 3)
    Clothing.Data[3]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 3)

    Clothing.Data[10] = {}
    Clothing.Data[10]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 10)
    Clothing.Data[10]["Texture"] = GetPedTextureVariation(PlayerPedId(), 10)
    Clothing.Data[10]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 10)

    if GetEntityModel(PlayerPedId()) == joaat("mp_m_freemode_01") then
        SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0)
    else
        SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
        SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 0)
    end

    ClearPedTasks(PlayerPedId())
end)
TriggerEvent("chat:addSuggestion", "/j1", 'Put on jacket')
RegisterCommand('j1', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_negative_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1000)

    if Clothing.Data[11] then
        SetPedComponentVariation(PlayerPedId(), 11, Clothing.Data[11]["Prop"], Clothing.Data[11]["Texture"], Clothing.Data[11]["Palette"])
    end

    if Clothing.Data[6] then
        SetPedComponentVariation(PlayerPedId(), 6, Clothing.Data[6]["Prop"], Clothing.Data[6]["Texture"], Clothing.Data[6]["Palette"])
    end

    if Clothing.Data[8] then
        SetPedComponentVariation(PlayerPedId(), 8, Clothing.Data[8]["Prop"], Clothing.Data[8]["Texture"], Clothing.Data[8]["Palette"])
    end

    if Clothing.Data[3] then
        SetPedComponentVariation(PlayerPedId(), 3, Clothing.Data[3]["Prop"], Clothing.Data[3]["Texture"], Clothing.Data[3]["Palette"])
    end

    if Clothing.Data[10] then
        SetPedComponentVariation(PlayerPedId(), 10, Clothing.Data[10]["Prop"], Clothing.Data[10]["Texture"], Clothing.Data[10]["Palette"])
    end

    ClearPedTasks(PlayerPedId())

end)


TriggerEvent("chat:addSuggestion", "/p0", 'Take off pants')
RegisterCommand('p0', function(source)
    Clothing.LoadAnimDict("re@construction")
    TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1300)

    Clothing.Data[4] = {}
    Clothing.Data[4]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 4)
    Clothing.Data[4]["Texture"] = GetPedTextureVariation(PlayerPedId(), 4)
    Clothing.Data[4]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 4)
    
    
    if GetEntityModel(PlayerPedId()) == joaat("mp_m_freemode_01") then
        SetPedComponentVariation(PlayerPedId(), 4, 21, 0, 0)
    else
        SetPedComponentVariation(PlayerPedId(), 4, 14, 0, 0)
    end

    ClearPedTasks(PlayerPedId())
end)
TriggerEvent("chat:addSuggestion", "/p1", 'Put on pants')
RegisterCommand('p1', function(source)
    Clothing.LoadAnimDict("re@construction")
    TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1300)

    if Clothing.Data[4] then
        SetPedComponentVariation(PlayerPedId(), 4, Clothing.Data[4]["Prop"], Clothing.Data[4]["Texture"], Clothing.Data[4]["Palette"])
    end

    ClearPedTasks(PlayerPedId())

end)

TriggerEvent("chat:addSuggestion", "/s0", 'Take off shoes')
RegisterCommand('s0', function(source)
    Clothing.LoadAnimDict("re@construction")
    TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1300)

    Clothing.Data[6] = {}
    Clothing.Data[6]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 6)
    Clothing.Data[6]["Texture"] = GetPedTextureVariation(PlayerPedId(), 6)
    Clothing.Data[6]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 6)

    if GetEntityModel(PlayerPedId()) == joaat("mp_m_freemode_01") then
        SetPedComponentVariation(PlayerPedId(), 6, 34, 0, 0)
    else
        SetPedComponentVariation(PlayerPedId(), 6, 35, 0, 0)
    end

    ClearPedTasks(PlayerPedId())
end)

TriggerEvent("chat:addSuggestion", "/s1", 'Put on shoes')
RegisterCommand('s1', function(source)
    Clothing.LoadAnimDict("random@domestic")
    TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    if Clothing.Data[6] then
        SetPedComponentVariation(PlayerPedId(), 6, Clothing.Data[6]["Prop"], Clothing.Data[6]["Texture"], Clothing.Data[6]["Palette"])
    end

    ClearPedTasks(PlayerPedId())

end)

TriggerEvent("chat:addSuggestion", "/g0", 'Take off glasses')
RegisterCommand('g0', function(source)
    Clothing.LoadAnimDict("nmt_3_rcm-10")
    TaskPlayAnim(PlayerPedId(), "nmt_3_rcm-10", "cs_nigel_dual-10", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    Clothing.Data[3] = {}
    Clothing.Data[3]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 3)
    Clothing.Data[3]["Texture"] = GetPedTextureVariation(PlayerPedId(), 3)
    Clothing.Data[3]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 3)

    SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 0)
    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/g1", 'Put on glasses')
RegisterCommand('g1', function(source)
    Clothing.LoadAnimDict("nmt_3_rcm-10")
    TaskPlayAnim(PlayerPedId(), "nmt_3_rcm-10", "cs_nigel_dual-10", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    if Clothing.Data[3] then
        SetPedComponentVariation(PlayerPedId(), 3, Clothing.Data[3]["Prop"], Clothing.Data[3]["Texture"], Clothing.Data[3]["Palette"])
    end

    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/n0", 'Take off tie/holster')
RegisterCommand('n0', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_neutral_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(5000)

    Clothing.Data[7] = {}
    Clothing.Data[7]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 7)
    Clothing.Data[7]["Texture"] = GetPedTextureVariation(PlayerPedId(), 7)
    Clothing.Data[7]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 7)

    SetPedComponentVariation(PlayerPedId(), 7, 0, 0, 0)
    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/n1", 'Put on tie/holster')
RegisterCommand('n1', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_neutral_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(5000)

    if Clothing.Data[7] then
        SetPedComponentVariation(PlayerPedId(), 7, Clothing.Data[7]["Prop"], Clothing.Data[7]["Texture"], Clothing.Data[7]["Palette"])
    end

    ClearPedTasks(PlayerPedId())

end)

TriggerEvent("chat:addSuggestion", "/b0", 'Take off bag')
RegisterCommand('b0', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_positive_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    Clothing.Data[5] = {}
    Clothing.Data[5]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 5)
    Clothing.Data[5]["Texture"] = GetPedTextureVariation(PlayerPedId(), 5)
    Clothing.Data[5]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 5)

    SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/b1", 'Put on bag')
RegisterCommand('b1', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_positive_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    if Clothing.Data[5] then
        SetPedComponentVariation(PlayerPedId(), 5, Clothing.Data[5]["Prop"], Clothing.Data[5]["Texture"], Clothing.Data[5]["Palette"])
    end

    ClearPedTasks(PlayerPedId())

end)

TriggerEvent("chat:addSuggestion", "/v0", 'Take off vest')
RegisterCommand('v0', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_positive_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    Clothing.Data[9] = {}
    Clothing.Data[9]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 9)
    Clothing.Data[9]["Texture"] = GetPedTextureVariation(PlayerPedId(), 9)
    Clothing.Data[9]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 9)

    SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0)
    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/v1", 'Put on vest')
RegisterCommand('v1', function(source)
    Clothing.LoadAnimDict("clothingtie")
    TaskPlayAnim(PlayerPedId(), "clothingtie", "try_tie_positive_a", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    if Clothing.Data[9] then
        SetPedComponentVariation(PlayerPedId(), 9, Clothing.Data[9]["Prop"], Clothing.Data[9]["Texture"], Clothing.Data[9]["Palette"])
    end

    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/m0", 'Take off mask')
RegisterCommand('m0', function(source)
    Clothing.LoadAnimDict("missfbi4")
    TaskPlayAnim(PlayerPedId(), "missfbi4", "takeoff_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    Clothing.Data[1] = {}
    Clothing.Data[1]["Prop"] = GetPedDrawableVariation(PlayerPedId(), 1)
    Clothing.Data[1]["Texture"] = GetPedTextureVariation(PlayerPedId(), 1)
    Clothing.Data[1]["Palette"] = GetPedPaletteVariation(PlayerPedId(), 1)

    SetPedComponentVariation(PlayerPedId(), 1, -1, -1, -1)
    ClearPedTasks(PlayerPedId())

end)

-- TriggerEvent("chat:addSuggestion", "/m1", 'Put on mask')
-- RegisterCommand('m1', function(source)
--     Clothing.LoadAnimDict("mp_masks@on_foot")
--     TaskPlayAnim(PlayerPedId(), "mp_masks@on_foot", "put_on_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
--     Wait(600)

--     if Clothing.Data[1] then
--         SetPedComponentVariation(PlayerPedId(), 1, Clothing.Data[1]["Prop"], Clothing.Data[1]["Texture"], Clothing.Data[1]["Palette"])
--     end

--     ClearPedTasks(PlayerPedId())

-- end)
TriggerEvent("chat:addSuggestion", "/e0", 'Take off ear accs')
RegisterCommand('e0', function(source)
    Clothing.LoadAnimDict("mp_cp_stolen_tut")
    TaskPlayAnim(PlayerPedId(), "mp_cp_stolen_tut", "b_think", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(900)

    Clothing.Data[2] = {}
    Clothing.Data[2]["Prop"] = GetPedPropIndex(PlayerPedId(), 2)
    Clothing.Data[2]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), 2)

    ClearPedProp(PlayerPedId(), 2)

    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/e1", 'Put on ear accs')
RegisterCommand('e1', function(source)
    Clothing.LoadAnimDict("mp_cp_stolen_tut")
    TaskPlayAnim(PlayerPedId(), "mp_cp_stolen_tut", "b_think", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(900)

    if Clothing.Data[2] then
        SetPedPropIndex(PlayerPedId(), 2, Clothing.Data[2]["Prop"], Clothing.Data[2]["Texture"], true)
    end

    ClearPedTasks(PlayerPedId())

end)

TriggerEvent("chat:addSuggestion", "/g0", 'Take off glasses')
RegisterCommand('g0', function(source)
    Clothing.LoadAnimDict("clothingspecs")
    TaskPlayAnim(PlayerPedId(), "clothingspecs", "take_off", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1400)

    Clothing.Data[12] = {}
    Clothing.Data[12]["Prop"] = GetPedPropIndex(PlayerPedId(), 1)
    Clothing.Data[12]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), 1)

    ClearPedProp(PlayerPedId(), 1)

    ClearPedTasks(PlayerPedId())

end)

TriggerEvent("chat:addSuggestion", "/g1", 'Put on glasses')
RegisterCommand('g1', function(source)
    Clothing.LoadAnimDict("clothingspecs")
    TaskPlayAnim(PlayerPedId(), "clothingspecs", "take_off", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1400)

    if Clothing.Data[12] then
        print('HAS GLASSES DATA:', Clothing.Data[12]["Prop"], GetPedPropIndex(PlayerPedId(), 1))
        SetPedPropIndex(PlayerPedId(), 1, Clothing.Data[12]["Prop"], Clothing.Data[12]["Texture"], true)
    end

    ClearPedTasks(PlayerPedId())

end)

TriggerEvent("chat:addSuggestion", "/w0", 'Take off watch')
RegisterCommand('w0', function(source)
	Clothing.LoadAnimDict("nmt_3_rcm-10")
    TaskPlayAnim(PlayerPedId(), "nmt_3_rcm-10", "cs_nigel_dual-10", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    Clothing.Data[6] = {}
    Clothing.Data[6]["Prop"] = GetPedPropIndex(PlayerPedId(), 6)
    Clothing.Data[6]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), 6)

    ClearPedProp(PlayerPedId(), 6)

    ClearPedTasks(PlayerPedId())

end)
TriggerEvent("chat:addSuggestion", "/w1", 'Put on watch')
RegisterCommand('w1', function(source)
	Clothing.LoadAnimDict("nmt_3_rcm-10")
    TaskPlayAnim(PlayerPedId(), "nmt_3_rcm-10", "cs_nigel_dual-10", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(1200)

    if Clothing.Data[6] then
        SetPedPropIndex(PlayerPedId(), 6, Clothing.Data[6]["Prop"], Clothing.Data[6]["Texture"], true)
    end

    ClearPedTasks(PlayerPedId())

end)

TriggerEvent("chat:addSuggestion", "/h0", 'Take off hat')
RegisterCommand('h0', function(source)
    Clothing.LoadAnimDict("missheist_agency2ahelmet")
    TaskPlayAnim(PlayerPedId(), "missheist_agency2ahelmet", "take_off_helmet_stand", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(800)

    Clothing.Data[0] = {}
    Clothing.Data[0]["Prop"] = GetPedPropIndex(PlayerPedId(), 0)
    Clothing.Data[0]["Texture"] = GetPedPropTextureIndex(PlayerPedId(), 0)

    ClearPedProp(PlayerPedId(), 0)

    ClearPedTasks(PlayerPedId())

end)

--[[ TriggerEvent("chat:addSuggestion", "/h1", 'Put on hat')
RegisterCommand('h1', function(source)
    Clothing.LoadAnimDict("mp_masks@standard_car@ds@")
    TaskPlayAnim(PlayerPedId(), "mp_masks@standard_car@ds@", "put_on_mask", 4.0, 3.0, -1, 49, 1.0, 0, 0, 0 )
    Wait(600)

    if Clothing.Data[0] then
        SetPedPropIndex(PlayerPedId(), 0, Clothing.Data[0]["Prop"], Clothing.Data[0]["Texture"], true)
    end

    ClearPedTasks(PlayerPedId())

end) ]]

TriggerEvent("chat:addSuggestion", "/cleanself", 'Clean youself off')
RegisterCommand('cleanself', function(source)
    Clothing.Restore()
    ClearPedBloodDamage(PlayerPedId())
    Clothing.LoadAnimDict("reaction@shake_it_off@")
    TaskPlayAnim(PlayerPedId(), "reaction@shake_it_off@", "dustoff", 4.0, 3.0, 1800, 49, 1.0, 0, 0, 0 )
    local items = GetGamePool('CObject')
    for k,v in pairs(items) do
        if IsEntityAttachedToEntity(v, cache.ped) then
            print(v)
            DetachEntity(v, false, false)
            DeleteEntity(v)
        end
    end
    TriggerEvent('xnTattoos:resetSkin')
end)

Clothing.Restore = function()
    for k,v in pairs(Clothing.Data) do
        if v["Palette"] then
            SetPedComponentVariation(PlayerPedId(), k, v["Prop"], v["Texture"], v["Palette"])
        else
            SetPedPropIndex(PlayerPedId(), k, v["Prop"], v["Texture"], true)
        end
    end
end

Clothing.LoadAnimDict = function( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Wait(5)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        Clothing.Restore()
    end
end)

RegisterNetEvent('clothing:reset', function()
    Clothing.Restore()
    ClearPedBloodDamage(PlayerPedId())
    ClearPedDecorationsLeaveScars(PlayerPedId())
end)