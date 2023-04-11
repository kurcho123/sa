Config = {}

Config.Options =
{
    --Job restriction (Surgery/Machines)
    jobTitle = {"ambulance", "clinic"},


    --Sound files
    soundboardURL = "https://www.paradoxgaming.co/soundboard/",
    ventSound = "ambientsurgery.ogg",
    cautSound = "surgerycaut.ogg",
    suctionSound = "surgerysuction.ogg",
    mriSound = "mrisfx.ogg",
    xraySound = "xray.ogg",
    elevatorSound = "elevatording.ogg",
    blankSoundfile = "blank.ogg",

    --Volume Settings
    mriVolume = 0.05,
    xrayVolume = 0.05,
    surgeryVolume = 0.05,
    elevatorVolume = 0.05,  

    --Range/Distance to play sounds
    surgeryDistance = 10,
    mriDistance = 15,
    xrayDistance = 15,          
}

--Beds
Config.BedModels = 
{
    {  label = "Regular Hospital Bed 1",        modelname = "v_med_bed1",                          type = "client", icon = "fa-solid fa-bed", layposition = 0.9, animation = "", isSurgicalBed = false,    },
    {  label = "Regular Hospital Bed 2",        modelname = "v_med_bed2",                          type = "client", icon = "fa-solid fa-bed", layposition = 0.9, animation = "", isSurgicalBed = false,    },
    {  label = "Light Hospital Bed",            modelname = "v_med_emptybed",                      type = "client", icon = "fa-solid fa-bed", layposition = 0.7, animation = "", isSurgicalBed = false,    },
    {  label = "Diagnostic Bed (MRI/X-Ray)",    modelname = "gabz_pillbox_diagnostics_bed_02",     type = "client", icon = "fa-solid fa-bed", layposition = 1.5, animation = "", isSurgicalBed = false,    },
    {  label = "Surgical Bed",                  modelname = "gabz_pillbox_diagnostics_bed_03",     type = "client", icon = "fa-solid fa-bed", layposition = 1.5, animation = "", isSurgicalBed = true,        job = "ambulance",    },
    {  label = "Morgue Slabs",                  modelname = "v_med_cor_emblmtable",                type = "client", icon = "fa-solid fa-bed", layposition = 1.5, animation = "", isSurgicalBed = false,    },
}

Config.ChairModels =
{   --To add a new chair just add the model name here and tweak the offset
    { modelName = "p_clb_officechair_s", sittingOffset = 0.38 },
    { modelName = "v_corp_offchair",     sittingOffset = 0.45 },
    { modelName = "prop_off_chair_01",   sittingOffset = 0.38 },
    { modelName = "prop_table_05_chr",   sittingOffset = 0.45 },
    { modelName = "prop_cs_office_chair",   sittingOffset = 0.38 },
    { modelName = "v_res_m_dinechair",   sittingOffset = 0.38 },
    { modelName = "v_club_officechair",   sittingOffset = 0.38 },
    { modelName = "ba_prop_battle_club_chair_01",   sittingOffset = 0.38 },
}

--Chairs (Box Zone Chairs)
Config.Seats = 
{
    { anim = "", lname = "Pillbox Seat 01", sname = "pb_seat_01",   seatposition = vector3(312.5, -585.9, 42.78),     minz = 42.68,  maxz = 43.18,  heading = 158.77,   sitposition = vector3(312.18, -586.35, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 02", sname = "pb_seat_02",   seatposition = vector3(314.43, -586.5, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 158.77,   sitposition = vector3(314.26, -587.07, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 03", sname = "pb_seat_03",   seatposition = vector3(360.92, -598.85, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 80.47,    sitposition = vector3(360.33, -598.73, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 04", sname = "pb_seat_04",   seatposition = vector3(342.78, -590.93, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 258.94,   sitposition = vector3(343.28, -591.09, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 05", sname = "pb_seat_05",   seatposition = vector3(343.29, -589.1, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 242.98,   sitposition = vector3(343.84, -589.38, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 06", sname = "pb_seat_06",   seatposition = vector3(353.8, -596.71, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 331.94,   sitposition = vector3(354.06, -596.06, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 07", sname = "pb_seat_07",   seatposition = vector3(303.43, -595.05, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 338.03,   sitposition = vector3(303.68, -594.44, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 08", sname = "pb_seat_08",   seatposition = vector3(302.56, -594.76, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 343.99,   sitposition = vector3(302.67, -594.08, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 09", sname = "pb_seat_09",   seatposition = vector3(300.56, -593.98, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 342.69,   sitposition = vector3(300.73, -593.35, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 10", sname = "pb_seat_10",   seatposition = vector3(299.57, -593.64, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 341.17,   sitposition = vector3(299.77, -593.0, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 11", sname = "pb_seat_11",   seatposition = vector3(298.02, -590.77, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 249.95,   sitposition = vector3(298.67, -590.95, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 12", sname = "pb_seat_12",   seatposition = vector3(298.75, -588.63, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 253.7,    sitposition = vector3(299.43, -588.82, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 13", sname = "pb_seat_13",   seatposition = vector3(301.51, -590.33, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 74.65,    sitposition = vector3(300.84, -590.17, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 14", sname = "pb_seat_14",   seatposition = vector3(301.09, -591.5, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 77.3,     sitposition = vector3(300.41, -591.36, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 15", sname = "pb_seat_15",   seatposition = vector3(322.34, -601.88, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 344.71,   sitposition = vector3(322.61, -601.27, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 16", sname = "pb_seat_16",   seatposition = vector3(321.23, -601.49, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 336.5,    sitposition = vector3(321.35, -600.87, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 17", sname = "pb_seat_17",   seatposition = vector3(320.2, -601.01, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 338.71,   sitposition = vector3(320.28, -600.42, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 18", sname = "pb_seat_18",   seatposition = vector3(318.05, -600.24, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 338.68,   sitposition = vector3(318.2, -599.68, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 19", sname = "pb_seat_19",   seatposition = vector3(317.07, -599.95, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 334.3,    sitposition = vector3(317.2, -599.32, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 20", sname = "pb_seat_20",   seatposition = vector3(315.0, -599.15, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 316.93,   sitposition = vector3(315.39, -598.55, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 21", sname = "pb_seat_21",   seatposition = vector3(320.08, -597.21, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 70.8,     sitposition = vector3(319.47, -597.06, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 22", sname = "pb_seat_22",   seatposition = vector3(317.56, -595.23, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 165.89,   sitposition = vector3(317.47, -595.84, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 23", sname = "pb_seat_23",   seatposition = vector3(318.45, -595.56, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 160.57,   sitposition = vector3(318.34, -596.16, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 24", sname = "pb_seat_24",   seatposition = vector3(319.39, -595.93, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 157.63,   sitposition = vector3(319.31, -596.51, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 25", sname = "pb_seat_25",   seatposition = vector3(338.56, -585.86, 43.8),    minz = 42.68,  maxz = 43.18,  heading = 342.68,   sitposition = vector3(338.69, -585.24, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 26", sname = "pb_seat_26",   seatposition = vector3(335.56, -584.82, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 341.33,   sitposition = vector3(335.68, -584.1, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 27", sname = "pb_seat_27",   seatposition = vector3(339.89, -582.18, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 157.51,   sitposition = vector3(339.75, -582.78, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 28", sname = "pb_seat_28",   seatposition = vector3(342.69, -583.24, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 153.28,   sitposition = vector3(342.45, -583.75, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 29", sname = "pb_seat_29",   seatposition = vector3(343.56, -583.45, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 171.41,   sitposition = vector3(343.54, -584.16, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 31", sname = "pb_seat_31",   seatposition = vector3(345.57, -584.15, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 156.7,    sitposition = vector3(345.43, -584.85, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 32", sname = "pb_seat_32",   seatposition = vector3(334.5, -584.4, 42.93),     minz = 42.68,  maxz = 43.18,  heading = 331.43,   sitposition = vector3(334.81, -583.71, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 33", sname = "pb_seat_33",   seatposition = vector3(349.36, -599.99, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 76.79,    sitposition = vector3(348.64, -599.93, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 34", sname = "pb_seat_34",   seatposition = vector3(346.8, -595.74, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 250.7,    sitposition = vector3(347.4, -595.84, 43.28),   xsize = 0.45, ysize = 0.70,  },
    { anim = "", lname = "Pillbox Seat 35", sname = "pb_seat_35",   seatposition = vector3(348.19, -591.81, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 256.74,   sitposition = vector3(348.87, -591.85, 43.28), xsize = 0.45, ysize = 0.70,   }, 
    { anim = "", lname = "Pillbox Seat 36", sname = "pb_seat_36",   seatposition = vector3(357.83, -576.91, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 74.85,    sitposition = vector3(357.11, -576.74, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 37", sname = "pb_seat_37",   seatposition = vector3(357.04, -578.76, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 65.82,    sitposition = vector3(356.46, -578.66, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 38", sname = "pb_seat_38",   seatposition = vector3(337.94, -581.48, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 171.89,   sitposition = vector3(337.75, -582.08, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 39", sname = "pb_seat_39",   seatposition = vector3(337.69, -585.42, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 344.43,   sitposition = vector3(337.83, -584.9, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 40", sname = "pb_seat_40",   seatposition = vector3(356.52, -588.19, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 163.55,   sitposition = vector3(356.34, -588.95, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 41", sname = "pb_seat_41",   seatposition = vector3(357.47, -588.65, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 162.72,   sitposition = vector3(357.33, -589.35, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 42", sname = "pb_seat_42",   seatposition = vector3(359.55, -589.35, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 165.84,   sitposition = vector3(359.38, -589.98, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 43", sname = "pb_seat_43",   seatposition = vector3(362.21, -590.4, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 155.52,   sitposition = vector3(362.03, -591.01, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 44", sname = "pb_seat_44",   seatposition = vector3(364.29, -591.16, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 163.48,   sitposition = vector3(364.15, -591.72, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 45", sname = "pb_seat_45",   seatposition = vector3(329.41, -592.1, 42.23),    minz = 42.73,  maxz = 43.73,  heading = 187.94,   sitposition = vector3(329.43, -592.75, 43.28), xsize = 0.45, ysize = 0.70,   },  
    { anim = "", lname = "Pillbox Seat 46", sname = "pb_seat_46",   seatposition = vector3(361.9, -594.28, 43.79),    minz = 42.68,  maxz = 43.18,  heading = 338.39,   sitposition = vector3(362.14, -593.73, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 47", sname = "pb_seat_47",   seatposition = vector3(360.89, -593.95, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 343.01,   sitposition = vector3(361.01, -593.34, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 48", sname = "pb_seat_48",   seatposition = vector3(355.36, -591.99, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 344.81,   sitposition = vector3(355.59, -591.27, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 49", sname = "pb_seat_49",   seatposition = vector3(354.35, -591.56, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 343.94,   sitposition = vector3(354.49, -590.97, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 50", sname = "pb_seat_50",   seatposition = vector3(308.99, -571.01, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 169.76,   sitposition = vector3(308.91, -571.63, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 51", sname = "pb_seat_51",   seatposition = vector3(311.06, -571.72, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 168.53,   sitposition = vector3(310.88, -572.42, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 52", sname = "pb_seat_52",   seatposition = vector3(314.81, -573.1, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 153.27,   sitposition = vector3(314.64, -573.68, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 53", sname = "pb_seat_53",   seatposition = vector3(360.89, -593.95, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 343.01,   sitposition = vector3(361.01, -593.34, 43.28), xsize = 0.45, ysize = 0.70,   },    
    { anim = "", lname = "Pillbox Seat 54", sname = "pb_seat_54",   seatposition = vector3(358.23, -592.88, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 339.59,   sitposition = vector3(358.28, -592.35, 43.28), xsize = 0.45, ysize = 0.70,   },  
    { anim = "", lname = "Pillbox Seat 55", sname = "pb_seat_55",   seatposition = vector3(316.93, -573.97, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 154.85,   sitposition = vector3(316.65, -574.49, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 56", sname = "pb_seat_56",   seatposition = vector3(320.77, -575.23, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 166.83,   sitposition = vector3(320.63, -575.85, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 57", sname = "pb_seat_57",   seatposition = vector3(322.11, -575.7, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 169.46,   sitposition = vector3(322.03, -576.37, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 58", sname = "pb_seat_58",   seatposition = vector3(321.18, -579.46, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 341.95,   sitposition = vector3(321.33, -578.88, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 59", sname = "pb_seat_59",   seatposition = vector3(320.24, -579.22, 43.85),   minz = 42.68,  maxz = 43.18,  heading = 335.11,   sitposition = vector3(320.4, -578.56, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 60", sname = "pb_seat_60",   seatposition = vector3(319.39, -578.85, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 337.12,   sitposition = vector3(319.49, -578.22, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 61", sname = "pb_seat_61",   seatposition = vector3(314.87, -577.24, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 340.3,    sitposition = vector3(315.12, -576.56, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 62", sname = "pb_seat_62",   seatposition = vector3(312.8, -576.37, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 341.44,   sitposition = vector3(312.98, -575.83, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 63", sname = "pb_seat_63",   seatposition = vector3(312.0, -576.13, 43.81),    minz = 42.68,  maxz = 43.18,  heading = 344.23,   sitposition = vector3(312.05, -575.52, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 64", sname = "pb_seat_64",   seatposition = vector3(311.12, -575.85, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 344.82,   sitposition = vector3(311.16, -575.2, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 65", sname = "pb_seat_65",   seatposition = vector3(348.93, -601.11, 42.93),   minz = 42.68,  maxz = 43.18,  heading = 70.2,     sitposition = vector3(348.33, -600.94, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 66", sname = "pb_seat_66",   seatposition = vector3(319.83, -598.1, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 71.47,    sitposition = vector3(319.16, -597.93, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 67", sname = "pb_seat_67",   seatposition = vector3(348.7, -590.91, 42.93),    minz = 42.68,  maxz = 43.18,  heading = 243.21,   sitposition = vector3(349.2, -590.99, 43.28), xsize = 0.45, ysize = 0.70,    },
    { anim = "", lname = "Pillbox Seat 68", sname = "pb_seat_68",   seatposition = vector3(331.7, -592.82, 42.23),    minz = 42.73,  maxz = 43.73,  heading = 155.73,   sitposition = vector3(331.49, -593.43, 43.28), xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Pillbox Seat 69", sname = "pb_seat_69",   seatposition = vector3(332.73, -593.22, 42.73),   minz = 42.73,  maxz = 43.73,  heading = 155.73,   sitposition = vector3(331.49, -593.43, 43.28), xsize = 0.45, ysize = 0.70,   },
   --Toilets
    { anim = "", lname = "Staff Toilet",    sname = "st_01",        seatposition = vector3(295.92, -596.71, 42.93),   minz = 41.65,  maxz = 43.85,  heading = 252.39,   sitposition = vector3(296.21, -596.84, 43.3),    xsize = 0.45, ysize = 0.70,   },
    --Unsorted
    { anim = "sitchair4", lname = "Morgue_bench_1_1",sname = "mb_1_1",       seatposition = vector3(267.54, -1352.26, 24.10),  minz = 23.75,  maxz = 24.45,  heading = 152.06,   sitposition = vector3(267.31, -1352.57, 24.61),   xsize = 0.55, ysize = 0.70,   },
    { anim = "sitchair4", lname = "Morgue_bench_1_2",sname = "mb_1_2",       seatposition = vector3(268.24, -1352.74, 24.10),  minz = 23.75,  maxz = 24.45,  heading = 136.06,   sitposition = vector3(267.83, -1353.05, 24.54),   xsize = 0.55, ysize = 0.70,   },
    { anim = "sitchair4", lname = "Morgue_bench_2_1",sname = "mb_2_1",       seatposition = vector3(268.85, -1353.25, 24.10),  minz = 23.75,  maxz = 24.45,  heading = 139.56,   sitposition = vector3(268.52, -1353.63, 24.54),   xsize = 0.55, ysize = 0.70,   },
    { anim = "sitchair4", lname = "Morgue_bench_2_2",sname = "mb_2_2",       seatposition = vector3(269.44, -1353.75, 24.10),  minz = 23.75,  maxz = 24.45,  heading = 137.65,   sitposition = vector3(269.05, -1354.08, 24.54),   xsize = 0.55, ysize = 0.70,   },
    --Staff Room Seats
    { anim = "", lname = "Staff_Room_1",   sname = "staff_rm_1",    seatposition = vector3(311.44, -599.29, 43.23),   minz = 42.73,  maxz = 43.73,  heading = 165.19,   sitposition = vector3(311.23, -599.71, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Staff_Room_2",   sname = "staff_rm_2",    seatposition = vector3(310.54, -598.76, 43.23),   minz = 42.73,  maxz = 43.73,  heading = 158.97,   sitposition = vector3(310.22, -599.19, 43.28),  xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Staff_Room_3",   sname = "staff_rm_3",    seatposition = vector3(309.6, -601.3, 43.23),     minz = 42.73,  maxz = 43.73,  heading = 337.78,   sitposition = vector3(309.78, -600.9, 43.28),   xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "Staff_Room_4",   sname = "staff_rm_4",    seatposition = vector3(310.68, -601.52, 43.23),   minz = 42.73,  maxz = 43.73,  heading = 34.81,    sitposition = vector3(310.33, -601.1, 43.28),   xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "bench_001",      sname = "bench_001",     seatposition = vector3(300.58, -599.04, 42.71),   minz = 41.73,  maxz = 43.73,  heading = 249.85,   sitposition = vector3(301.04, -599.2, 43.25),   xsize = 0.45, ysize = 0.70,   },
    { anim = "", lname = "bench_002",      sname = "bench_002",     seatposition = vector3(299.74, -598.58, 42.71),   minz = 41.73,  maxz = 43.73,  heading = 70.47,    sitposition = vector3(299.31, -598.42, 43.25),  xsize = 0.45, ysize = 0.70,   },
    
    --ELS Seats
    { anim = "sittv", lname = "els_back_01",    sname = "els_back_01",     seatposition = vector3(1195.23, -1480.02, 34.2),    minz = 34.1,  maxz = 34.8,  heading = 95.26,    sitposition = vector3(1194.62, -1480.03, 34.73),    xsize = 0.80, ysize = 0.85,   },
    { anim = "sittv", lname = "els_back_02",    sname = "els_back_02",     seatposition = vector3(1195.27, -1482.05, 34.2),   minz = 34.1,  maxz = 34.8,  heading = 85.13,     sitposition = vector3(1194.64, -1481.95, 34.73),     xsize = 0.80, ysize = 0.85,   },
    { anim = "sittv", lname = "els_back_03",    sname = "els_back_03",     seatposition = vector3(1197.29, -1482.55, 34.2),   minz = 34.1,  maxz = 34.8,  heading = 80.29,     sitposition = vector3(1196.64, -1482.54, 34.73),    xsize = 0.80, ysize = 0.85,   },
    { anim = "sittv", lname = "els_back_04",    sname = "els_back_04",     seatposition = vector3(1197.43, -1481.0, 34.2),    minz = 34.1,  maxz = 34.8,  heading = 90.09,     sitposition = vector3(1196.84, -1480.94, 34.73),    xsize = 0.80, ysize = 0.85,   },
    { anim = "sittv", lname = "els_back_05",    sname = "els_back_05",     seatposition = vector3(1197.22, -1479.55, 34.2),   minz = 34.1,  maxz = 34.8,  heading = 100.17,    sitposition = vector3(1196.61, -1479.59, 34.73),    xsize = 0.80, ysize = 0.85,   },
}

--Surgery Machines
Config.SurgerySoundboxes = 
{
    {        name = "Surgery Room 1",        label = "Room 1", icon = "fas fa-heartbeat", icontwo = "fas fa-syringe", iconthree = "fas fa-burn",        boxPosition = vector3(316.82, -567.08, 43.58),  heading = 63.35,            minz =  43.28,   maxz =  43.88,        xsize = 0.5,        ysize =   0.5,    },
    {        name = "Surgery Room 2",        label = "Room 2", icon = "fas fa-heartbeat", icontwo = "fas fa-syringe", iconthree = "fas fa-burn",        boxPosition = vector3(319.47, -567.05, 43.58),  heading = 244.64,           minz =  43.28,   maxz =  43.88,        xsize = 0.6,        ysize =   1.0,    },
    {        name = "Surgery Room 3",        label = "Room 3", icon = "fas fa-heartbeat", icontwo = "fas fa-syringe", iconthree = "fas fa-burn",        boxPosition = vector3(327.7, -569.39, 44.28),   heading = 125.92,           minz =  44.18,   maxz =  44.38,        xsize = 0.5,        ysize =   0.5,    },
}

--Elevators
Config.Elevators = 
{
    {        name = "Morgue Entrance",        label = "Enter Morgue",       icon = "fas fa-skull-crossbones",     boxPosition = vector3(333.12, -568.54, 43.28),  exitPoint = vector4(254.34, -1372.44, 24.54, 55.45),  heading = 336.89,           minz =  42.28,   maxz =  44.58,         tooltiptext = "Morgue",                xsize = 0.4,         ysize =   2.7,     },
    {        name = "Exit From Morgue",       label = "Exit",               icon = "far fa-hospital",             boxPosition = vector3(254.66, -1372.81, 24.54), exitPoint = vector4(332.86, -569.22, 43.28, 160.06),  heading = 225.82,           minz =  23.54,   maxz =  25.84,         tooltiptext = "Leaving Morgue",        xsize = 0.6,         ysize =   2.3,     },
    {        name = "To Helipad",             label = "Helipad",            icon = "fas fa-hospital-symbol",      boxPosition = vector3(325.69, -603.36, 43.60),  exitPoint = vector4(339.77, -584.46, 74.16, 250.58),  heading = 162.72,           minz =  43.40,    maxz =  43.80,          tooltiptext = "Using Elevator",        xsize = 0.25,        ysize =   0.25,    },
    {        name = "To Motorpool Right",     label = "Motorpool",          icon = "fas fa-chevron-circle-down",  boxPosition = vector3(329.97, -602.62, 43.60),  exitPoint = vector4(341.31, -581.06, 28.80, 73.76),    heading = 249.51,           minz =  43.40,    maxz =  43.80,          tooltiptext = "Using Elevator",        xsize = 0.25,        ysize =   0.25,    },
    {        name = "To Motorpool Left",      label = "Motorpool",          icon = "fas fa-chevron-circle-down",  boxPosition = vector3(332.00, -597.25, 43.60),  exitPoint = vector4(339.7, -584.71, 28.80, 75.81),     heading = 249.51,           minz =  43.40,    maxz =  43.80,          tooltiptext = "Using Elevator",        xsize = 0.25,        ysize =   0.25,    },
    {        name = "From Helipad",           label = "Pillbox Main Floor", icon = "fas fa-chevron-circle-down",  boxPosition = vector3(338.55, -583.7, 74.16),   exitPoint = vector4(327.11, -603.56, 43.28, 329.01),  heading = 251,              minz =  72.76,   maxz =  75.66,         tooltiptext = "Using Elevator",        xsize = 0.6,         ysize =   2.6,     },
    {        name = "To Upper Pillbox3",      label = "Pillbox Main Floor", icon = "fas fa-chevron-circle-up",    boxPosition = vector3(344.85, -584.72, 29.10),  exitPoint = vector4(332.44, -595.64, 43.28, 69.6),    heading = 69.4,             minz =  28.80,    maxz =  29.30,          tooltiptext = "Using Elevator",        xsize = 0.5,         ysize =   0.5,     },
    {        name = "To Upper Pillbox 4",     label = "Pillbox Main Floor", icon = "fas fa-chevron-circle-up",    boxPosition = vector3(346.1, -580.99, 29.10),   exitPoint = vector4(330.06, -601.26, 43.28, 62.78),   heading = 69.4,             minz =  28.80,    maxz =  29.30,          tooltiptext = "Using Elevator",        xsize = 0.5,         ysize =   0.5,     },
    {        name = "ELS Helipad",            label = "Helipad",            icon = "fas fa-chevron-circle-up",    boxPosition = vector3(1193.12, -1471.58, 34.86),   exitPoint = vector4(1192.32, -1483.05, 39.37, 94.37),   heading = 0,             minz =  35.06,    maxz =  35.66,          tooltiptext = "Helipad",        xsize = 0.5,         ysize =   0.5,     },
    {        name = "ELS Garage",             label = "ELS Garage",         icon = "fas fa-chevron-circle-up",    boxPosition = vector3(1192.73, -1483.13, 39.34),   exitPoint = vector4(1193.21, -1472.93, 34.86, 270.81),   heading = 0,             minz =  39.34,    maxz =  39.94,          tooltiptext = "Garage",        xsize = 0.5,         ysize =   0.5,     },
}

--Not in use yet [To do] 
Config.SurgeryOptions = 
{
        -- { 
        --     type = "client", 
        --     event = "prdx_clinic:client:triggersounds", 
        --     icon = "",
        --     icon_2 = "",
        --     icon_3 = "",
        --     label = 'Ventilator', 
        --     job = 'ambulance',
        --     name = "",
        --     url = "https://slypandainteractive.com/sounds/ambientsurgery.ogg",
        --     volume = 0.05,
        --     range = 10.0,
        --     position = "", 
        --     barname = "vent_on",
        --     tooltip = "Activating Ventilator",
        --     startuptime = 1000,
        --     animD = "",
        --     anim = "",
        --     loopAudio = true,
        --     duration = 1000,
        -- },
        -- { 
        --     type = "client", 
        --     event = "prdx_clinic:client:triggersounds", 
        --     icon = "",
        --     icon_2 = "",
        --     icon_3 = "",
        --     label = 'Suction', 
        --     job = 'ambulance',
        --     name = "",
        --     url = "https://slypandainteractive.com/sounds/surgerysuction.ogg",
        --     volume = 0.05,
        --     range = 10.0,
        --     position = "", 
        --     barname = "suction_on",
        --     tooltip = "Running Suctionotron",
        --     startuptime = 1000,
        --     animD = "",
        --     anim = "",
        --     loopAudio = true,
        --     duration = 1000,
        -- },
        -- { 
        --     type = "client", 
        --     event = "prdx_clinic:client:triggersounds", 
        --     icon = "",
        --     icon_2 = "",
        --     icon_3 = "",
        --     label = 'Cauterize', 
        --     job = 'ambulance',
        --     name = "",
        --     url = "https://slypandainteractive.com/sounds/surgerycaut.ogg",
        --     volume = 0.05,
        --     range = 10.0,
        --     position = "", 
        --     barname = "caut_on",
        --     tooltip = "Starting Cauterizer",
        --     startuptime = 1000,
        --     animD = "",
        --     anim = "",
        --     loopAudio = true,
        --     duration = 1000,
        -- },
        -- { 
        --     type = "client", 
        --     event = "prdx_clinic:client:triggersounds", 
        --     icon = "far fa-stop-circle",
        --     label = 'Switch Off', 
        --     job = 'ambulance',
        --     name = "",
        --     url = "https://slypandainteractive.com/sounds/blank.ogg",
        --     volume = 0.0,
        --     range = 10.0,
        --     position = "", 
        --     barname = "vent_off",
        --     tooltip = "Deactivating Ventilator",
        --     startuptime = 500,
        --     animD = "",
        --     anim = "",
        --     loopAudio = false,
        --     duration = 5,
        -- },
}
