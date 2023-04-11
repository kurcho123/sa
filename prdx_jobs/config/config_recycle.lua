-- -- -- -- -- -- -- -- -- -- -- -- -- --
--           RECYCLE CONFIG            --
-- -- -- -- -- -- -- -- -- -- -- -- -- --
Config = Config or {}
Config.RecycleList = {
    ['ifak'] = {
        reward = 'bandage',
        count = 1,
    },
    ['itk'] = {
        reward = 'bandage',
        count = 3,
    },
    ['lockpick'] = {
        reward = 'metalscrap',
        count = 1,
    },
    ['gpsdisabler'] = {
        reward = {
            ['plastic'] = 2,
            ['metalscrap'] = 1,
            ['glass'] = 1,
        }
    },
    ['prdxlaptop'] = {
        reward = {
            ['plastic'] = 2,
            ['glass'] = 1,
            ["metalscrap"] = 1,
        }
    },
    ['guncleaningkit'] = {
        reward = {
            ["iron"] = 2,
            ["carbon"] = 1,
        }
    },
    ['knifesharpeningkit'] = {
        reward = {
            ["iron"] = 1,
            ["carbon"] = 1,
        }
    },
    ['advancedlockpick'] = {
        reward = 'metalscrap',
        count = 3,
    },
    ['radioscanner'] = {
        reward = {
            ["metalscrap"] = 1,
            ["plastic"] = 1,
            ["glass"] = 1,
        }
    },
    ['laptop_green'] = {
        reward = {
            ["steel"] = 1,
            ["metalscrap"] = 1,
            ["plastic"] = 1,
        }
    },
    ['bank_drill'] = {
        reward = {
            ["steel"] = 1,
            ["metalscrap"] = 1,
            ["plastic"] = 1,
        }
    },
    ['laptop_pink'] = {
        reward = {
            ["glass"] = 1,
            ["metalscrap"] = 1,
            ["carbon"] = 1,
        }
    },
    ['metal_shovel'] = {
        reward = {
            ["iron"] = 5,
        }
    },
    ['weapon_p226'] = {
        reward = {
            ["steel"] = 1,
            ["metalscrap"] = 1,
            ["carbon"] = 1,
        }
    },
    ['weapon_g17'] = {
        reward = {
            ["steel"] = 1,
            ["metalscrap"] = 1,
            ["carbon"] = 1,
        }
    },
    ['weapon_fbiarb'] = {
        reward = {
            ["steel"] = 2,
            ["metalscrap"] = 2,
            ["carbon"] = 1,
        }
    },
    ['weapon_appistol'] = {
        reward = {
            ["steel"] = 2,
            ["metalscrap"] = 2,
            ["carbon"] = 1,
        }
    },
    ['weapon_knife'] = {
        reward = {
            ["iron"] = 1,
            ["metalscrap"] = 1,
        }
    },
    ['weapon_wrench'] = {
        reward = {
            ["iron"] = 1,
            ["metalscrap"] = 1,
        }
    },
    ['weapon_hammer'] = {
        reward = {
            ["iron"] = 1,
            ["metalscrap"] = 1,
        }
    },
    ['weapon_bat'] = {
        reward = {
            ["iron"] = 1,
            ["metalscrap"] = 1,
        }
    }, 
    ['fishingtin'] = {
        reward = {
            ["iron"] = 1,
            ["metalscrap"] = 2,
        }
    }, 
    ['fishingboot'] = {
        reward = {
            ["iron"] = 3,
            ["rubber"] = 1,
        }
    }, 
    ['plant_nutrition'] = {
        reward = {
            ["plastic"] = 1,
        }
    }, 
    ['huntingbait'] = {
        reward = {
            ["plastic"] = 1,
        }
    },
    -- Parts -- 
    ['engineblock'] = {
        reward = {
            ["iron"] = 15,
            ["aluminum"] = 8
        }
    }, 
    ['crankshaft'] = {
        reward = {
            ["steel"] = 2,
            ["iron"] = 8,
        }
    }, 
    ['pistons'] = {
        reward = {
            ["copper"] = 3,
            ["rubber"] = 1,
        }
    }, 
    ['camshaft'] = {
        reward = {
            ["iron"] = 12,
        }
    }, 
    ['cylinderhead'] = {
        reward = {
            ["aluminum"] = 12,
        }
    }, 
    ['intakemanifold'] = {
        reward = {
            ["iron"] = 1,
            ["plastic"] = 1,
        }
    }, 
    ['exhaustmanifold'] = {
        reward = {
            ["iron"] = 1,
            ["steel"] = 1,
        }
    }, 
    ['fuelsystem'] = {
        reward = {
            ["iron"] = 2,
            ["rubber"] = 2,
        }
    }, 
    -- BILLET --
    ['billet_engineblock'] = {
        reward = {
            ["steel"] = 15,
            ["aluminum"] = 8,
            ["iron"] = 15,

        }
    }, 
    ['billet_crankshaft'] = {
        reward = {
            ["steel"] = 12,
            ["iron"] = 15,
        }
    },
    ['billet_pistons'] = {
        reward = {
            ["steel"] = 3,
            ["copper"] = 4,
        }
    },
    ['billet_camshaft'] = {
        reward = {
            ["steel"] = 12,
        }
    },
    ['billet_cylinderhead'] = {
        reward = {
            ["steel"] = 12,
            ["aluminum"] = 15,
        }
    },
    ['billet_intakemanifold'] = {
        reward = {
            ["steel"] = 3,
            ["plastic"] = 3,
            ["aluminum"] = 3,
        }
    },
    ['billet_exhaustmanifold'] = {
        reward = {
            ["steel"] = 2,
            ["iron"] = 6,
        }
    }, 
    ['billet_fuelsystem'] = {
        reward = {
            ["steel"] = 1,
            ["rubber"] = 12,
            ["plastic"] = 12,
        }
    },     
    ['carparts'] = {
        reward = {
            ["rubber"] = 1,
            ["carbon"] = 1,
            ["goldbar"] = 1,
            ["plastic"] = 2,
        }
    }, 
    ['cleaningkit'] = {
        reward = {
            ["plastic"] = 1,
        }
    }, 
    ['bottle'] = {
        reward = {
            ["glass"] = 1,
        }
    }, 
    ['plastictrash'] = {
        reward = {
            ["plastic"] = 2,
        }
    }, 
    ['advguncleaningkit'] = {
        reward = {
            ["carbon"] = 2,
            ["iron"] = 1,
        }
    }, 
    ['cattle_feed'] = {
        reward = {
            ["plastic"] = 2,
        }
    }, 
    ['repairkit'] = {
        reward = {
            ["plastic"] = 2,
            ["iron"] = 5,
        }
    }, 
    ['bike_reapairkit'] = {
        reward = {
            ["plastic"] = 2,
            ["iron"] = 5,
        }
    }, 
    ['clinic_wheelchair'] = {
        reward = {
            ["plastic"] = 2,
            ["iron"] = 5,
        }
    }, 
    ['clinic_prescription'] = {
        reward = {
            ["plastic"] = 1,
        }
    }, 
    
    
        
}