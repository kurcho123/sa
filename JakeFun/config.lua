Config = {}
local QBCore = exports['qb-core']:GetCoreObject()


-- StoryHint = {
--     coords = vector3(),
--     timer = 5000, -- in ms the progressbar (optional)
--     item = 'printerdocument', -- Give item (optional)
--     metadata = {label = 'codex'}, -- Applies to item (optional)
--     hint = 'A fax was left...' -- Send notifictation  (optional)
--     policealert = false, -- Alert popo
--     requireditem = 'usb', -- required to do and will be removed (optional)
-- },

Config.MaxCameras = 5
Config.MaxMotionSenors = 2
Config.MotionSensorRange = 5


Config.StoryHints = {
    RadioScannerMerryweather = {
        coords = vector3(564.05, -3124.11, 18.77),
        timer = 5000, -- in ms the progressbar
        item = 'printerdocument', -- Give item
        metadata = {label = 'J mfgu jotusvdujpot po ipx up cvjme uifn bu uif mpdbujpot.  \nEpo\'u dpoubdu nf bhbjo, uifz\'sf hfuujoh tvtqjdjpvt.  \nJ\'mm mfu zpv lopx xifo ju\'t ujnf.  \n- F.N.'}, -- Applies to item
        hint = 'A fax was left...',-- Send notifictation 
        policealert = false, -- Alert popo
        --Hint Meaning: The laptop to hack is located at Paleto PD. Take the USB there, plug it into the computer. Pass the hack and get the blueprint for the Radio Scanner.
    },
    FileLocationsLaptop = {
        coords = vector3(1209.29, -3115.2, 5.54),
        timer = 5000, -- in ms the progressbar
        hint = 'I left the software on my laptop at work. The device will piggyback their frequencies. They\'ll never know, they never use the place anyway. Do me a favor, leave my badge on the desk. - E.M.', -- Send notifictation 
        policealert = false, -- Alert popo
        --Hint Meaning: The mine shaft is located in the area of Great Chaparral. There is a computer there for the hack which if passed will give the Blueprint to Thermite. 
    },
    SmelterStickyNote = {
        coords = vector3(1081.78, -2013.7, 41.48),
        timer = 5000, -- in ms the progressbar
        item = 'stickynote', -- Give item
        metadata = {label = 'Hey John, we sent the last shipment to the site at Great Chaparral.  \nPlug the USB into the computer and it has everything you need.  \nP.S. I think someone has been using this stuff to break through the doors at the supply depot. Might want to check into it.  \n- S. King'}, -- Applies to item
        hint = 'You found a stickynote',-- Send notifictation 
        policealert = false, -- Alert popo
        --Hint Meaning: The laptop to hack is located at Paleto PD. Take the USB there, plug it into the computer. Pass the hack and get the blueprint for the Radio Scanner.
    },
    -- GREEN LAPTOP --
    LifeinvaderTrashNote = {
        coords = vector3(-1054.36, -240.35, 44.02),
        timer = 5000, -- in ms the progressbar
        item = 'stickynote', -- Give item
        metadata = {label = 'In greek he is death  \nHells fire and bone  \nUnlike how he is in astrology  \nIn the heavens, cold and stone'}, -- Applies to item
        hint = 'You found a stickynote',-- Send notifictation 
        policealert = false, -- Alert popo
    },
    TwoHootsFalls = {
        coords = vector3(-1577.64, 2100.73, 68.3),
        timer = 5000, -- in ms the progressbar
        hint = '16,12,21,__,__ The missing numbers are key to our location',-- Send notifictation 
        policealert = false, -- Alert popo
    },
}

-- HackName = {
--     coords = vec3(),
--     hacktype = 'code', -- types = code, colormatch, lockpick 
--     difficulty = 1, -- 1-3 scale (optional for code)
--     reward = 'blueprint', -- item or blueprint 
--     rewardname = 'thermite' -- name of above reward
--     rewardamount = 1, -- if item this is used (optional)
--     policealert = false, -- Alert popo
--     requireditem = 'crim_usb_lvl1', -- required to do and will be removed (optional)
--     cooldowntimer = 2,-- minutes if failed (optional)
--     cooldown = false, -- must be here
-- },

Config.StoryHacks = {
    Event1 = {
        coords = vector3(5000.41, -5166.7, 2.22),
        hacktype = 'colormatch', -- types = code, colormatch, lockpick 
        difficulty = 2, -- 1-3 scale 
        reward = 'item', -- item or blueprint 
        rewardname = 'weapon_appistol', --
        rewardamount = 10, -- if item this is used 
        policealert = false, -- Alert popo
        cooldowntimer = 2,-- minutes if failed 
        cooldown = false, -- must be here
        countDown = 600000
    },
    Event2 = {
        coords = vector3(4999.42, -5163.71, 2.52),
        hacktype = 'colormatch', -- types = code, colormatch, lockpick 
        difficulty = 2, -- 1-3 scale 
        reward = 'item', -- item or blueprint 
        rewardname = 'weapon_dbshotgun', -- 
        rewardamount = 10, -- if item this is used 
        policealert = false, -- Alert popo
        cooldowntimer = 2,-- minutes if failed 
        cooldown = false, -- must be here
        countDown = 600000
    },
    PaletoPD = {
        coords = vector3(-450.7, 6012.96, 31.72),
        hacktype = 'code', -- types = code, colormatch, lockpick 
        difficulty = 1, -- 1-3 scale (optional for code)
        reward = 'blueprint', -- item or blueprint 
        rewardname = 'radioscanner', -- name of above reward
        policealert = false, -- Alert popo
        requireditem = 'crim_usb_lvl1', -- required to do and will be removed (optional)
        cooldowntimer = 5,-- minutes if failed (optional)
        cooldown = false, -- must be here
        -- Radio Scanner Blueprint
    },
    Mineshaft = {
        coords = vector3(-532.76, 1903.58, 123.08),
        hacktype = 'code', -- types = code, colormatch, lockpick 
        difficulty = 1, -- 1-3 scale (optional for code)
        reward = 'blueprint', -- item or blueprint 
        rewardname = 'thermite', -- name of above reward
        policealert = false, -- Alert popo
        requireditem = 'crim_usb_lvl1', -- required to do and will be removed (optional)
        cooldowntimer = 5,-- minutes if failed (optional)
        cooldown = false, -- must be here
        -- Thermite Blueprint
    },
    -- GREEN LAPTOP --
    LifeinvaderStartHack = {
        coords = vector3(-1051.84, -230.67, 44.02),
        hacktype = 'code', -- types = code, colormatch, lockpick 
        difficulty = 1, -- 1-3 scale (optional for code)
        reward = 'item', -- item or blueprint 
        rewardname = {
            green_cdrom = 1,
            notepad = {
                noteId = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)),
                noteText = 'To whom it may concern- Well, I just found out that this company is working with the local banks to scam people out of their money. I dont know how high it goes but I know for a fact Fleeca is in on the con. I am done working for this capitalist society, I would rather be homeless fish than a slave to them. I designed a laptop that will help bring these banks to their knees. This company found out and stole the information from me, stashing it somewhere in the building. I have the key to their whole game.  They are knocking on the door, I dont have much time, the key is in the basket. Find the location of my design and make them pay. -Volcan Rockefeller - IT lead',
            },
        }, -- name of above reward
        notify = 'The briefcase opens and you take what is inside...',
        policealert = false, -- Alert popo
        requireditem = 'crim_usb_lvl2', -- required to do and will be removed (optional)
        cooldowntimer = 5,-- minutes if failed (optional)
        cooldown = false, -- must be here
        -- Green keycard
    },
    LifeinvaderEndHack = {
        coords = vector3(-1083.78, -246.57, 37.72),
        hacktype = 'colormatch', -- types = code, colormatch, lockpick 
        difficulty = 2, -- 1-3 scale (optional for code)
        reward = 'item', -- item or blueprint 
        rewardname = {
            green_card = 1,
            notepad = {
                noteId = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4)),
                noteText = 'To: Jay Norris\nFrom: Rickie Lukens\nFormer IT lead Mr. Rockefeller has designed a laptop that could bypass all the security in place at our banks. I was able to remove the blueprint from his computer before he was terminated. I have sent them to one of our trusted partners to see if a patch can be made for this exploit. Don\'t worry sir, I added failsafe clues in case someone was watching the dropoff. The first clue was:\n\n \"They\'re awake when you are sleeping, They watch you from high above. They like solitude but here they\'re a pair, Perched near the falling water that fills the air.\"\n\nSorry for this bad news sir. I will keep you updated',
            },
        }, -- name of above reward
        notify = 'A paper comes out of the printer...',
        policealert = false, -- Alert popo
        requireditem = 'green_cdrom', -- required to do and will be removed (optional)
        cooldowntimer = 5,-- minutes if failed (optional)
        cooldown = false, -- must be here
        -- Thermite Blueprint
    },
}

Config.Bombs = {
    `hei_prop_heist_emp`,
    `sm_prop_smug_crate_s_jewellery`,
    `ch_prop_ch_explosive_01a`,
    `prop_sh_mr_rasp_01`
}

--[[ 
    Holiday Items
            name = "blinker_fluid",
            price = 0,
            amount = 1,
            info = {
                overrideImage = 'holiday_blinker_fluid.webp',
                overrideName = 'Blinker Fluid Holiday Brew',
                overrideDesc = 'Loaded with caffeine and holiday spirit this special treat from your friends down at Bikini Automotive is sure to brighten your holiday season!',
            },
            type = "item",
            slot = 1,
 ]]