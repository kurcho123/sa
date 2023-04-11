Config = Config or {}
Config.Injuries = {
    Contusion = {
        label = 'Deep Contusion',
        itemRequirement = 'icepack',
    },
    DeepCut = {
        label = 'Deep Cut',
        itemRequirement = 'ems_gauze',
    },
    StabWound = {
        label = 'Stab Wound',
        itemRequirement = 'quikclot',
    },
    Burns = {
        label = 'Minor Burns',
        itemRequirement = 'painkillers',
    },
    BlockedAirWay = {
        label = 'Lack of oxygen flow',
        itemRequirement = 'ems_o2mask',
    },
    Suffocate = {
        label = 'Lack of blood/oxygen flow',
        itemRequirement = 'ems_o2mask',
    },
    MildDegreeBurns = {
        label = 'Severe Burns',
        itemRequirement = 'ems_burnsheets',
    },
    BrokenNeck = {
        label = 'Neck/Spinal injury',
        itemRequirement = 'ems_neckbrace',
        BoneData = { -- If you want to have a per-bone effect this is how you do it
            {
                effects = {
                    climbinhibit = true,
                },
                bones = {
                    ['LEFT ARM'] = true, 
                    ['RIGHT ARM'] = true, 
                }
            },
            {
                effects = {
                    stability = {1, 10},
                },
                bones = {
                    ['LEFT LEG'] = true, 
                    ['LEFT FOOT'] = true,
                    ['RIGHT LEG'] = true, 
                    ['RIGHT FOOT'] = true,
                }
            },
            {
                bones = {
                    ['LEFT HAND'] = true,
                    ['LEFT FINGER'] = true,
                    ['RIGHT HAND'] = true,
                    ['RIGHT FINGER'] = true,
                }
            },
            {
                effects = {
                    speed = true,
                },
                bones = {
                    ['UPPER BODY'] = true,
                    ['LOWER BODY'] = true,
                    ['TORSO'] = true,
                    ['NECK'] = true,
                    ['HEAD'] = true,
                }
            },
        },
    },
    GunshotWoundSm = {
        label = 'Gunshot Wound (Small Caliber)',
        itemRequirement = 'ems_gauze',
    },
    GunshotWoundMed = {
        label = 'Gunshot Wound (Medium Caliber)',
        itemRequirement = 'ems_gauze',
    },
    GunshotWoundLrg = {
        label = 'Gunshot Wound (Large Caliber)',
        itemRequirement = 'quikclot',
        BoneData = { -- If you want to have a per-bone effect this is how you do it
            {
                effects = {
                    climbinhibit = true,
                },
                bones = {
                    ['LEFT ARM'] = true, 
                    ['RIGHT ARM'] = true, 
                }
            },
            {
                effects = {
                    stability = {1, 10},
                },
                bones = {
                    ['LEFT LEG'] = true, 
                    ['LEFT FOOT'] = true,
                    ['RIGHT LEG'] = true, 
                    ['RIGHT FOOT'] = true,
                }
            },
            {
                effects = {
                    weaponfail = {1, 10},
                },
                bones = {
                    ['LEFT HAND'] = true,
                    ['LEFT FINGER'] = true,
                    ['RIGHT HAND'] = true,
                    ['RIGHT FINGER'] = true,
                }
            },
            {
                bones = {
                    ['UPPER BODY'] = true,
                    ['LOWER BODY'] = true,
                    ['TORSO'] = true,
                    ['NECK'] = true,
                    ['HEAD'] = true,
                }
            },
        },
    },
    GunshotWoundSg = {
        label = 'Shotgun Wound',
        itemRequirement = 'quikclot',
        BoneData = { -- If you want to have a per-bone effect this is how you do it
            {
                effects = {
                    climbinhibit = true,
                },
                bones = {
                    ['LEFT ARM'] = true, 
                    ['RIGHT ARM'] = true, 
                }
            },
            {
                effects = {
                    speed = true,
                },
                bones = {
                    ['LEFT LEG'] = true, 
                    ['LEFT FOOT'] = true,
                    ['RIGHT LEG'] = true, 
                    ['RIGHT FOOT'] = true,
                }
            },
            {
                effects = {
                    weaponfail = {1, 10},
                },
                bones = {
                    ['LEFT HAND'] = true,
                    ['LEFT FINGER'] = true,
                    ['RIGHT HAND'] = true,
                    ['RIGHT FINGER'] = true,
                }
            },
            {
                bones = {
                    ['UPPER BODY'] = true,
                    ['LOWER BODY'] = true,
                    ['TORSO'] = true,
                    ['NECK'] = true,
                    ['HEAD'] = true,
                }
            },
        },
    },
    BrokenBone = {
        label = 'Broken Bone',
        itemRequirement = 'splint',
        BoneData = { -- If you want to have a per-bone effect this is how you do it
            {
                effects = {
                    climbinhibit = true,
                },
                bones = {
                    ['LEFT ARM'] = true, 
                    ['RIGHT ARM'] = true, 
                }
            },
            {
                effects = {
                    stability = {1, 10},
                },
                bones = {
                    ['LEFT LEG'] = true, 
                    ['LEFT FOOT'] = true,
                    ['RIGHT LEG'] = true, 
                    ['RIGHT FOOT'] = true,
                }
            },
            {
                effects = {
                    weaponfail = {1, 10},
                },
                bones = {
                    ['LEFT HAND'] = true,
                    ['LEFT FINGER'] = true,
                    ['RIGHT HAND'] = true,
                    ['RIGHT FINGER'] = true,
                }
            },
            {
                bones = {
                    ['UPPER BODY'] = true,
                    ['LOWER BODY'] = true,
                    ['TORSO'] = true,
                    ['NECK'] = true,
                    ['HEAD'] = true,
                }
            },
        },
    },
}


--- Example ---
--[[ 
    InjuryIDName = {
        label = 'Frontend label of injury',
        effectPack = { -- Pack of effects to apply upon injury (see effects.lua) (Optional)
            NameOfEffect = {1, 10}, -- If toggle then true/false; else if a range then define in table with min/max {1,10}
        },
        BoneData = { -- If you want to have a per-bone effect this is how you do it (optional)
            { -- Option 1
                effects = {
                    climbinhibit = true,
                },
                bones = {
                    ['LARM'] = true, 
                    ['RARM'] = true, 
                }
            },
            { -- Option 2
                effects = {
                    stability = {1, 10},
                },
                bones = {
                    ['LLEG'] = true, 
                    ['LFOOT'] = true,
                    ['RLEG'] = true, 
                    ['RFOOT'] = true,
                }
            },
            { -- Option 3
                effects = {
                    weaponfail = {1, 10},
                },
                bones = {
                    ['LHAND'] = true,
                    ['LFINGER'] = true,
                    ['RHAND'] = true,
                    ['RFINGER'] = true,
                }
            },
        },
    },
    Config.BloodPressures = {
        HypertensiveCrisis = {
            label = 'Hypertensive Crisis',
            minHR = 179,
            maxHR = 210,
            diastolic = {120, 140},
        },
        HypertensionStage2 = {
            label = 'Hypertension Stage 2',
            minHR = 140,
            maxHR = 179,
            diastolic = {90, 120},
        },
        HypertensionStage1 = {
            label = 'Hypertension Stage 1',
            minHR = 130,
            maxHR = 139,
            diastolic = {80, 90},
        },
        Elevated = {
            label = 'Elevated Blood Pressure',
            minHR = 120,
            maxHR = 129,
            diastolic = {70, 80},
        },
        Normal = {
            label = 'Normal Blood Pressure',
            minHR = 120,
            maxHR = 91,
            diastolic = {60, 80},
        },
        Low = {
            label = 'Low Blood Pressure',
            minHR = 40,
            maxHR = 90,
            diastolic = {40, 60},
        },
    }
 ]]