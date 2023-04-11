exports('GetMpSecurityOffice4Object', function()
    return MpSecurityOffice4
end)

MpSecurityOffice4 = {
    InteriorId = 287745,

    Ipl = {
        Interior = {
            ipl = {
                'sf_fixeroffice_kt1_08'
            }
        },

        Load = function()
            EnableIpl(MpSecurityOffice4.Ipl.Interior.ipl, true)
        end,
        Remove = function()
            EnableIpl(MpSecurityOffice4.Ipl.Interior.ipl, false)
        end,
    },
    Entities = {
        Entity_Set_Armoury = false,
        Entity_Set_Standard_Office = true,
        Entity_Set_Blocker = false,
        Entity_Set_Wpaper_1 = false,
        Entity_Set_Wpaper_3 = false,
        Entity_Set_Wpaper_2 = true,
        Entity_Set_Wpaper_4 = false,
        Entity_Set_Wpaper_5 = false,
        Entity_Set_Wpaper_6 = false,
        Entity_Set_Wpaper_7 = false,
        Entity_Set_Wpaper_8 = false,
        Entity_Set_Wpaper_9 = false,
        Entity_Set_Moving = false,
        Entity_Set_Tint_AG = true,
        Entity_Set_Spare_Seats = false,
        Entity_Set_Player_Seats = false,
        Entity_Set_Player_Desk = false,
        Entity_Set_M_Golf_Intro = false,
        Entity_Set_M_Setup = false,
        Entity_Set_M_Nightclub = false,
        Entity_Set_M_Yacht = false,
        Entity_Set_M_Promoter = false,
        Entity_Set_M_Limo_Photo = false,
        Entity_Set_M_Limo_Wallet = false,
        Entity_Set_M_The_Way = false,
        Entity_Set_M_Billionaire = false,
        Entity_Set_M_Families = false,
        Entity_Set_M_Ballas = false,
        Entity_Set_M_Hood = false,
        Entity_Set_M_Fire_Booth = false,
        Entity_Set_M_50 = false,
        Entity_Set_M_Taxi = false,
        Entity_Set_M_Gone_Golfing = false,
        Entity_Set_M_Motel = false,
        Entity_Set_M_Construction = false,
        Entity_Set_M_Hit_List = false,
        Entity_Set_M_Tuner = false,
        Entity_Set_M_Attack = false,
        Entity_Set_M_Vehicles = false,
        Entity_Set_M_Trip_01 = false,
        Entity_Set_M_Trip_02 = false,
        Entity_Set_M_Trip_03 = false,
        Entity_set_disc_01 = false,
        Entity_set_disc_02 = false,
        Entity_set_disc_03 = false,
        Entity_set_disc_04 = false,
        Entity_set_disc_05 = false,
        Entity_set_disc_06 = false,
        Entity_Set_Art_1 = false,
        Entity_Set_Art_2 = false,
        Entity_Set_Art_3 = false,

        Set = function(name, state)
            for entity, _ in pairs(MpSecurityOffice4.Entities) do
                if entity == name then
                    MpSecurityOffice4.Entities[entity] = state
                    MpSecurityOffice4.Entities.Clear()
                    MpSecurityOffice4.Entities.Load()
                end
            end
        end,
        Load = function()
            for entity, state in pairs(MpSecurityOffice4.Entities) do
                if type(entity) == 'string' and state then
                    ActivateInteriorEntitySet(MpSecurityOffice4.InteriorId, entity)
                end
            end
        end,
        Clear = function()
            for entity, _ in pairs(MpSecurityOffice4.Entities) do
                if type(entity) == 'string' then
                    DeactivateInteriorEntitySet(MpSecurityOffice4.InteriorId, entity)
                end
            end
        end,
    },

    LoadDefault = function()
        MpSecurityOffice4.Ipl.Load()
        MpSecurityOffice4.Entities.Load()

        RefreshInterior(MpSecurityOffice4.interiorId)
    end
}

local WolfsRealty = BoxZone:Create(vector3(-589.3, -716.16, 113.01), 27.4, 38.0, {
    name="WolfsRealty",
    heading=0,
    --debugPoly=true,
    minZ=107.41,
    maxZ=128.81
})
local inside = false

CreateThread(function()
    WolfsRealty:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
        inside = isPointInside 
    end, 5000)
end) 

CreateThread(function()
	while true do
		Wait(0)
		if inside then
            EnableExteriorCullModelThisFrame(`hei_kt1_08_buildingtop_a`)
            DisableOcclusionThisFrame()
		else
			Wait(5000)
		end
	end
end)