local ch_dlc_arcade = GetInteriorAtCoordsWithType(-45.35726000, -85.38384000, 55.75836000,"ch_dlc_arcade")

RefreshInterior(ch_dlc_arcade)

-- NOTE: Enable/Disable by changing EnableInteriorProp and DisableInteriorProp


DisableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_ceiling_flat") --BLUE SHELL COLOR
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_ceiling_beams") --BRICK SHELL COLOR + LAMPS
EnableInteriorProp(ch_dlc_arcade, "entity_set_screens") 
EnableInteriorProp(ch_dlc_arcade, "entity_set_big_screen") -- TV ON WALL
EnableInteriorProp(ch_dlc_arcade, "entity_set_constant_geometry")
EnableInteriorProp(ch_dlc_arcade, "entity_set_ret_light_no_neon")
EnableInteriorProp(ch_dlc_arcade, "ch_chint02_00_dropped_ceiling")
EnableInteriorProp(ch_dlc_arcade, "entity_set_hip_light_no_neon")
EnableInteriorProp(ch_dlc_arcade, "arcade_bar")
DisableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_streetx4") -- GLIZZY PROPS
DisableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_ceiling_mirror") -- CEILING

-- DIRTY
DisableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_derelict_carpet") -- DIRTY CARPETS
DisableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_derelict") -- DITRY SHELL
DisableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_derelict") -- MUD
DisableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_derelict_clean_up") -- DIRT
DisableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_derelict_clean_up") -- CLOSED ARCADE MACHINES

-- TROPHIES

EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_claw")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_monkey")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_patriot")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_retro")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_brawler")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_racer")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_love")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_cabs")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_gunner") 
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_teller")
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_king") 
EnableInteriorProp(ch_dlc_arcade, "entity_set_arcade_set_trophy_strife") 

-- TOYS IN OFFICE

DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_01")
DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_02")
DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_03")
DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_04")
DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_05")
DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_06")
DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_07")
DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_08")
DisableInteriorProp(ch_dlc_arcade, "entity_set_plushie_09")

-- ANIMATED WALL

DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_neon_option_01") -- CENSORED
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_neon_option_02") -- BIKE
EnableInteriorProp(ch_dlc_arcade, "entity_set_mural_neon_option_03") -- ANIME
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_neon_option_04") -- DEGENATRON
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_neon_option_05") -- CAR
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_neon_option_06") -- NEON CITY
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_neon_option_07") -- EYES
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_neon_option_08") -- SWORD

-- WALL DESIGN

DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_option_01") -- BLACK AND WHITE
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_option_02") -- LINES
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_option_03") -- ANIME
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_option_04") -- BLUE LINES
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_option_05") -- BLUE 16 BIT
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_option_06") -- NEON
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_option_07") -- DEGENATRON
DisableInteriorProp(ch_dlc_arcade, "entity_set_mural_option_08") -- BLUE

-- FLOOR DESIGN

DisableInteriorProp(ch_dlc_arcade, "entity_set_floor_option_01") -- TILES
DisableInteriorProp(ch_dlc_arcade, "entity_set_floor_option_02") -- CIRCLES
DisableInteriorProp(ch_dlc_arcade, "entity_set_floor_option_03") -- ANIME
DisableInteriorProp(ch_dlc_arcade, "entity_set_floor_option_04") -- CYAN TILES
EnableInteriorProp(ch_dlc_arcade, "entity_set_floor_option_05") -- SPACE
DisableInteriorProp(ch_dlc_arcade, "entity_set_floor_option_06") -- SPACE TILES
DisableInteriorProp(ch_dlc_arcade, "entity_set_floor_option_07") -- ???
DisableInteriorProp(ch_dlc_arcade, "entity_set_floor_option_08") -- LIGTNING

-- GLIZZY THINGS

EnableInteriorProp(ch_dlc_arcade, "entity_set_glizzy_essentials") -- GLIZZY BAR ESSENTIALS