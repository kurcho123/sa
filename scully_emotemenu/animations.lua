-- Place any of your custom animations in here and keep a backup of this file for future updates.
local custom = {
    Walks = {},
    Scenarios = {},
    Expressions = {},
    Emotes = {
        {
            Label = 'Give',
            Command = 'give',
            Animation = 'givetake1_a',
            Dictionary = 'mp_common',
            Options = {
                Duration = 2500,
                Flags = {
                    Move = true,
                },
            },
        },
        {
            Label = 'Smoke Pipe',
            Command = 'smokepipe',
            Animation = 'trev_smoking_meth_loop',
            Dictionary = 'switch@trevor@trev_smoking_meth',
            Options = {
                Flags = {
                    Loop = true,
                    Move = true,
                },
            },
        },
        {
            Label = 'Snort Coke',
            Command = 'snortcoke',
            Animation = 'snort_coke_b_male3',
            Dictionary = 'missfbi3_party',
            Options = {
                Flags = {
                    Loop = false,
                    Move = true,
                },
            },
        },
    },
    PropEmotes = {
        {
            Label = 'Watering',
            Command = 'watering',
            Animation = 'fire',
            Dictionary = 'weapons@misc@jerrycan@',
            Options = {
                Flags = {
                    Loop = true,
                    Move = false,
                },
                Props = {
                    {
                        Bone = 57005,
                        Name = 'prop_wateringcan',
                        Placement = {
                            vector3(0.1800, 0.1300, -0.2400),
                            vector3(-165.8693883, -11.2122753, -32.9453021),
                        },
                    },
                },
            },
        },
        {
            Label = 'Moonshine',
            Command = 'moonshine',
            Animation = 'loop_bottle',
            Dictionary = 'mp_player_intdrink',
            Options = {
                Flags = {
                    Loop = true,
                    Move = true,
                },
                Props = {
                    {
                        Bone = 18905,
                        Name = 'prop_ceramic_jug_01',
                        Placement = {
                            vector3(0.040000, -0.140000, 0.100000),
                            vector3(240.000000, -60.000000, 0.000000),
                        },
                    },
                },
            },
        },
        {
            Label = 'Drug Deal',
            Command = 'drugdeal',
            Animation = 'package_dropoff',
            Dictionary = 'mp_safehouselost@',
            Options = {
                Duration = 3000,
                Wait = 1500,
                Props = {
                    {
                        Bone = 28422,
                        Name = 'prop_meth_bag_01',
                        Placement = {
                            vector3(0.01000, -0.02000, 0.010000),
                            vector3(0.000000, 90.000000, 0.000000),
                        },
                    },
                },
            },
        },
        {
            Label = 'Drill Horizontal',
            Command = 'drill2',
            Animation = 'drill_straight_start',
            Dictionary = 'anim@heists@fleeca_bank@drilling',
            Options = {
                Flags = {
                    Loop = true,
                    Move = false,
                },
                Props = {
                    {
                        Bone = 57005,
                        Name = 'hei_prop_heist_drill',
                        Placement = {
                            vector3(0.14, 0, -0.01),
                            vector3(90.0, -90.0, 180.0),
                        },
                    },
                },
            },
        },
    },
    ConsumableEmotes = {},
    DanceEmotes = {},
    SynchronizedEmotes = {},
    AnimalEmotes = {}
}

for _type, emoteList in pairs(custom) do
    for i = 1, #emoteList do
        AnimationList[_type][#AnimationList[_type] + 1] = emoteList[i] 
    end
end