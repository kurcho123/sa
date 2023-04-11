Config = {}


--[[    ---Example --- 
    cone = {
        label = 'Cone', -- Label for menu: Pickup .. label
        model = `prop_roadcone02a`, -- Model HASH see ` 
        bone = 28422, -- Ped Bone ID
        offset = vec3(0.6, -0.15, -0.1), -- Offset from bone
        rotation = vec3(315.0, 288.0, 0.0), -- Rotational values
        anim = 'pick', -- Animation type (pick, hold)
        hidden = true -- Don't allow creation with "P" command

    }, 
]]
Config.PropList = {
    cone = {
        label = 'Cone',
        model = `prop_roadcone02a`,
        bone = 28422,
        offset = vec3(0.6, -0.15, -0.1),
        rotation = vec3(315.0, 288.0, 0.0),
        anim = 'pick'
    }, 
    trolley = {
        label = 'Trolly',
        model = `prop_cs_trolley_01`,
        bone = 28422,
        offset = vec3(0.0, -0.6, -0.8),
        rotation = vec3(-180.0, -165.0, 90.0),
        anim = 'hold'
    },
    table = {
        label = 'Table',
        model = `bkr_prop_weed_table_01b`,
        bone = 28422,
        offset = vec3(0.0, -0.58, -0.94),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    tablewood = {
        label = 'Wood Table',
        model = `prop_table_08`,
        bone = 28422,
        offset = vec3(0.0, -0.58, -0.94),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    umbtable = {
        label = 'Umbrella Table',
        model = `prop_table_para_comb_04`,
        bone = 28422,
        offset = vec3(0.0, -0.58, -0.94),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    chair = {
        label = 'Chair',
        model = `prop_skid_chair_01`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 180.0),
        anim = 'hold'
    },
    toolbox = {
        label = 'Toolbox',
        model = `prop_tool_box_04`,
        bone = 28422,
        offset = vec3(0.4, -0.1, -0.1),
        rotation = vec3(315.0, 288.0, 0.0),
        anim = 'pick'
    },
    medbox = {
        label = 'Medbox',
        model = `xm_prop_smug_crate_s_medical`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    medbag = {
        label = 'Medbag',
        model = `xm_prop_x17_bag_med_01a`,
        bone = 28422,
        offset = vec3(0.4, -0.1, -0.1),
        rotation = vec3(315.0, 298.0, 0.0),
        anim = 'pick'
    },
    ekg = {
        label = 'EKG',
        model = `lifepak15`,
        bone = 28422,
        offset = vec3(0.4, -0.1, -0.1),
        rotation = vec3(315.0, 298.0, 0.0),
        anim = 'pick'
    },
    bag = {
        label = 'Small Bag',
        model = `bkr_prop_duffel_bag_01a`,
        bone = 28422,
        offset = vec3(0.26, 0.04, 0.0),
        rotation = vec3(90.00, 0.00, -78.99),
        anim = 'pick'
    },
    cleaning = {
        label = 'Cleaning Trolly',
        model = `prop_cleaning_trolly`,
        bone = 28422,
        offset = vec3(-0.2, -0.4, -1.2),
        rotation = vec3(-188.0, -178.0, 180.0),
        anim = 'hold'
    },
    boombox = {
        label = 'Boombox',
        model = `prop_mp3_dock`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    terryhat = {
        label = 'Terry\'s Hat',
        model = `reh_prop_reh_hat_cowboy_01a`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    yoga = {
        label = 'Yoga Mat',
        model = `prop_yoga_mat_01`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    bbq = {
        label = 'BBQ Grill',
        model = `prop_bbq_5`,
        bone = 28422,
        offset = vec3(0.0, -0.3, -0.2),
        rotation = vec3(0.0, 0.0, -180.0),
        anim = 'hold'
    },
    case = {
        label = 'Case',
        model = `prop_security_case_01`,
        bone = 28422,
        offset = vec3(0.09, 0.02, 0.0),
        rotation = vec3(-90.0, -10.0, 70.0),
        anim = 'pick'
    },
    guitarcase = {
        label = 'Guitar Case',
        model = `sf_prop_sf_guitar_case_01a`,
        bone = 28422,
        offset = vec3(0.3, 0.0, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'pick'
    },
    cooler = {
        label = 'Cooler',
        model = `prop_coolbox_01`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 90.0),
        anim = 'hold'
    },    
    tent = {
        label = 'Tent',
        model = `prop_gazebo_01`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 90.0),
        anim = 'hold'
    }, 
    box = {
        label = 'Box',
        model = `prop_cs_cardbox_01`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 90.0),
        anim = 'hold'
    },
    bear = {
        label = 'Bear',
        model = `prop_mr_raspberry_01`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    bigcone = {
        label = 'Road Cone',
        model = `prop_mp_cone_04`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    barrier = {
        label = 'Person Barrier',
        model = `ba_prop_battle_barrier_02a`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    roadbarrier = {
        label = 'Road Barrier',
        model = `prop_mp_barrier_02`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    woodbarrier = {
        label = 'Wood Barrier',
        model = `prop_barrier_work06a`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    roadsign = {
        label = 'Road Work Sign',
        model = `prop_consign_01a`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    barrier = {
        label = 'Road Barrier',
        model = `prop_barier_conc_01b`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold'
    },
    duffel = {
        label = 'Duffel Bag',
        model = `ba_prop_battle_bag_01a`,
        bone = 28422,
        offset = vec3(0.33, -0.09, 0.05),
        rotation = vec3(-100.0, -24.0, 67.0),
        anim = 'pick'
    },
    tunerjack = {
        label = 'Jackstand',
        model = `xs_prop_x18_engine_hoist_02a`,
        bone = 24816,
        offset = vec3(-1.16, 1.3, 0.0),
        rotation = vec3(180.0, 90.0, 7.0),
        anim = 'hold',
        hidden = true -- no command
    },
    weedtable = {
        label = 'Weed Table',
        model = `bkr_prop_weed_table_01a`,
        bone = 28422,
        offset = vec3(0.0, -0.58, -0.94),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
        hidden = true, -- no command
        item = 'weed_table'
    },
    coketable = {
        label = 'Coke Table',
        model = `bkr_prop_coke_table01a`,
        bone = 28422,
        offset = vec3(0.0, -0.58, -0.94),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
        hidden = true, -- no command
        item = 'coke_table'
    },
    crate = {
        label = 'Crate',
        model = `sm_prop_smug_crate_s_narc`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 180.0),
        anim = 'hold',
    },
    paperbag = {
        label = 'Paper Bag',
        model = `prop_paper_bag_01`,
        bone = 28422,
        offset = vec3(0.28, 0.0, -0.03),
        rotation = vec3(110.0651988, -79.9999997, 0.0017365),
        anim = 'pick',
    },
    moneybag = {
        label = 'Money Bag',
        model = `prop_poly_bag_money`,
        bone = 28422,
        offset = vec3(0.33, 0.0, -0.03),
        rotation = vec3(110.0651988, -79.9999997, 0.0017365),
        anim = 'pick',
    },
    easterbasket = {                                                 --easter temp props
        label = 'Easter Basket',
        model = `bzzz_event_easter_basket_b`,
        bone = 57005,
        offset = vec3(0.35, 0.05, -0.06),
        rotation = vec3(110.0651988, -79.9999997, 0.0017365),
        anim = 'pick',
    },
    eastereggpink = {
        label = 'Easter Egg',
        model = `bzzz_event_easter_flag_a`,
        bone = 57005,
        offset = vec3(0.12, 0.0, -0.24),
        rotation = vec3(-184.0, -21.0, -52.0),
        anim = 'hold',
    },
    eastereggblue = {
        label = 'Easter Egg',
        model = `bzzz_event_easter_flag_b`,
        bone = 57005,
        offset = vec3(0.12, 0.0, -0.24),
        rotation = vec3(-184.0, -21.0, -52.0),
        anim = 'hold',
    },
    easteregggreen = {
        label = 'Easter Egg',
        model = `bzzz_event_easter_flag_c`,
        bone = 57005,
        offset = vec3(0.12, 0.0, -0.24),
        rotation = vec3(-184.0, -21.0, -52.0),
        anim = 'hold',                                              --end easter temp props
    },
    bodybag = {
        label = 'Body Bag',
        model = `xm_prop_body_bag`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 90.0),
        anim = 'hold',
    },
    lamp = {
        label = 'Lamp',
        model = `v_res_fa_lamp1on`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 90.0),
        anim = 'hold',
    },
    speaker = {
        label = 'Speaker',
        model = `ba_prop_battle_club_speaker_small`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
    },
    djbooth = {
        label = 'DJ Booth',
        model = `h4_prop_battle_dj_stand`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
    },
    smokemachine = {
        label = 'Smoke Machine',
        model = `ba_prop_club_smoke_machine`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        vip = true,
        particles = {
            {
                lib = 'scr_ba_club',
                dict = 'scr_ba_club_smoke',
                offset = vec3(0.0, -5.0, 1.1),
                rotation = vec3(0.0, 0.0, 90.0),
            },
            {
                lib = 'scr_ba_club',
                dict = 'scr_ba_club_smoke_machine',
                offset = vec3(0.0, 0.0, 0.2),
                rotation = vec3(0.0, 1.0, -90.0)
            },
        },
        anim = 'hold',
    },
    campsite = {
        label = 'Campsite -SCENE-',
        model = `h4_prop_h4_bag_djlp_01a`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        vip = true,
        scene = {
            {model = `ba_prop_battle_tent_02`, offset = vec3(0.0, 5.0, 0.0), rotation = vec3(0.0, 0.0, 0.0)},
            {model = `prop_skid_chair_03`, offset = vec3(2.5, 2.0, 0.0), rotation = vec3(0.0, 0.0, 15.0)},
            {model = `prop_skid_chair_03`, offset = vec3(3.5, 2.0, 0.0), rotation = vec3(0.0, 0.0, -15.0)},
            {model = `prop_beach_fire`, offset = vec3(3.0, -0.5, -0.5), rotation = vec3(0.0, 0.0, -15.0), override = -0.6},
            {model = `prop_skid_sleepbag_1`, offset = vec3(-2.5, 2.0, 0.0), rotation = vec3(0.0, 0.0, -85.0)},
            {model = `prop_skid_sleepbag_1`, offset = vec3(-3.5, 2.0, 0.0), rotation = vec3(0.0, 0.0, -85.0)},

        },
        anim = 'hold',
    },
    water_pump = {
        label = 'Water Pump',
        model = `prop_generator_01a`,
        bone = 28422,
        offset = vec3(0.0, -0.65, -0.7),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
        item = 'water_pump',
        hidden = true, -- no command
        scene = {
            {model = `prop_etricmotor_01`, offset = vec3(0.0, -7.0, -0.5), rotation = vec3(0.0, 180.0, 90.0)},
        }
    },
    water_tank = {
        label = 'Water Tank',
        model = `prop_watercrate_01`,
        bone = 28422,
        offset = vec3(0.0, -0.65, -0.7),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
        hidden = true, -- no command
        item = 'water_tank',
    },
    flare = {
        label = 'Flare',
        model = `prop_flare_01`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
        particles = {
            lib = 'core',
            dict = 'exp_grd_flare',
            offset = vec3(0.0, 0.0, 0.1),
            rotation = vec3(0.0, 1.0, -90.0)
        },
    },
    worklight = {
        label = 'Spotlight',
        model = `prop_worklight_03b`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
    },
    skeleton = {
        label = 'Skeleton',
        model = `reh_prop_reh_skeleton_01a`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
    },
    slippery = {
        label = 'Slippery',
        model = `v_serv_wetfloorsn`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
    },
    flag = {
        label = 'Flag',
        model = `tr_prop_tr_flag_01a`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
    },
    rose = {
        label = 'Rose',
        model = `prop_single_rose`,
        bone = 18905,
        offset = vec3(0.13, 0.15, 0.0),
        rotation = vec3(-100.0, 0.0, -20.0),
        anim = 'holdhand',

    },
    bouquet = {
        label = 'Bouquet',
        model = `prop_snow_flower_02`,
        bone = 18905,
        offset = vec3(0.07, 0.0, 0.0),
        rotation = vec3(-30.0, 90.0, 0.0),
        anim = 'holdhand',

    },
    menuboardgg = {
        label = 'Menuboard GG',
        model = `menuboard_gg`,
        bone = 18905,
        offset = vec3(0.37, -0.0, 0.45),
        rotation = vec3(0.0, 90.0, 110.0),
        vip = true,
        anim = 'hold',

    },
    menuboardsi = {
        label = 'Menuboard SI',
        model = `menuboard_si`,
        bone = 18905,
        offset = vec3(0.37, -0.0, 0.45),
        rotation = vec3(0.0, 90.0, 110.0),
        vip = true,
        anim = 'hold',

    },
    skull = {
        label = 'Skull',
        model = `vw_prop_casino_art_skull_01b`,
        bone = 18905,
        offset = vec3(0.37, -0.0, 0.45),
        rotation = vec3(0.0, 90.0, 110.0),
        vip = true,
        anim = 'hold',

    },
    skull1 = {
        label = 'Skull 2',
        model = `vw_prop_casino_art_skull_03a`,
        bone = 18905,
        offset = vec3(0.37, -0.0, 0.45),
        rotation = vec3(0.0, 90.0, 110.0),
        vip = true,
        anim = 'hold',

    },
    pmms = {
        label = 'PMMS',
        model = `pmms_stand`,
        bone = 18905,
        offset = vec3(0.37, -0.0, 0.45),
        rotation = vec3(10.0, 90.0, 150.0),
        vip = true,
        anim = 'hold',
    },
    bottles = {
        label = 'Bottles',
        model = `v_ret_ml_6bottles`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        vip = true,
        anim = 'hold',
    },
    target = {
        label = 'Target',
        model = `gr_prop_gr_target_05b`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        vip = true,
        anim = 'hold',
    },
    startbanner = {
        label = 'Starting Banner',
        model = `prop_tri_start_banner`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        vip = true,
        anim = 'hold',
    },
    
--[[     still = {
        label = 'Still',
        model = `prop_still`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
    },
    c4 = {
        label = 'C4',
        model = `stt_prop_c4_stack`,
        bone = 28422,
        offset = vec3(0.0, -0.1, -0.1),
        rotation = vec3(0.0, 0.0, 0.0),
        anim = 'hold',
    }, ]]
    -- projector = {
    --     label = 'Projector',
    --     model = `v_med_cor_tvstand`,
    --     bone = 28422,
    --     offset = vec3(0.0, -0.1, -0.1),
    --     rotation = vec3(0.0, 0.0, 0.0),
    --     anim = 'hold',
    --     scene = {
    --         [`xs_prop_arena_screen_tv_01`] = {offset = vec3(0.0, 0.0, 0.0), rotation = vec3(0.0, 0.0, 0.0),}
    --     }
    -- },

}
