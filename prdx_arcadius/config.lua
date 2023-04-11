-- -- -- -- -- -- -- -- -- -- -- -- -- --
--             Arcadius CONFIG         --
-- -- -- -- -- -- -- -- -- -- -- -- -- --
Config = {}
Config.ShowTargetZones = false

Config.Arcadius = {
    Offices = {
        ['madrazo'] = {
            instanceid = 78001, -- for instance
            label = 'Madrazo Inc.',
            ipl = 'ex_dt1_02_office_03c', -- Polished
            keys = {
                'QCE51214', -- Miguel
                'UPB26715', -- Millie
                'QYU76328', -- ISLA
                'KXX24599', -- Cass
            }
        },
        ['ludwig'] = {
            instanceid = 78002, -- for instance
            label = 'L&B LAW FIRM',
            ipl = 'ex_dt1_02_office_02a', -- contrast
            keys = {
                'QCE51214', -- Miguel
                'UPB26715', -- Millie
                'QYU76328', -- ISLA
                'KXX24599', -- Cass
                'OAI97990',
                'XFR20227',
                'HID14514',
                'GEE40280',
            }
        },
        ['finntaxi'] = {
            instanceid = 78003, -- for instance
            label = 'FINNIS TAXI',
            ipl = 'ex_dt1_02_office_01c', -- Vintage
            keys = {
                'QCE51214', -- Miguel
                'UPB26715', -- Millie
                'QYU76328', -- ISLA
                'KXX24599', -- Cass
                'AZX34256',
            }
        },
        ['rs'] = {
            instanceid = 78004, -- for instance
            label = 'RSM',
            ipl = 'ex_dt1_02_office_01b', -- Vintage
            keys = {
                'QCE51214', -- Miguel
                'UPB26715', -- Millie
                'KXX24599', -- Cass
                'QYU76328', -- ISLA
                'RDH21400', --violet
                'CZB18275', --vinny
                'IDQ82613', --richard
                'KBM16644', --bobby
            }
        },
    },
}

--[[             
        warm = {interiorId = 236289, ipl = "ex_dt1_02_office_01a", safe = "ex_prop_safedoor_office1a"},
        classical = {interiorId = 236545, ipl = "ex_dt1_02_office_01b", safe = "ex_prop_safedoor_office1b"},
        vintage = {interiorId = 236801, ipl = "ex_dt1_02_office_01c", safe = "ex_prop_safedoor_office1c"},
        contrast = {interiorId = 237057, ipl = "ex_dt1_02_office_02a", safe = "ex_prop_safedoor_office2a"},
        rich = {interiorId = 237313, ipl = "ex_dt1_02_office_02b", safe = "ex_prop_safedoor_office2a"},
        cool = {interiorId = 237569, ipl = "ex_dt1_02_office_02c", safe = "ex_prop_safedoor_office2a"},
        ice = {interiorId = 237825, ipl = "ex_dt1_02_office_03a", safe = "ex_prop_safedoor_office3a"},
        conservative = {interiorId = 238081, ipl = "ex_dt1_02_office_03b", safe = "ex_prop_safedoor_office3a"},
        polished = {interiorId = 238337, ipl = "ex_dt1_02_office_03c", safe = "ex_prop_safedoor_office3c"}
        ['munja'] = {
            instanceid = 78003, -- for instance
            label = 'Family Inc',
            ipl = 'ex_dt1_02_office_03a', -- Ice
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'JRX55796', -- Jimmy
                'PNR84292', -- Tony
                'CZB18275', -- Vinny
            }
        },
        ['weazel'] = {
            instanceid = 78004, -- for instance
            label = 'Weazel News',
            ipl = 'ex_dt1_02_office_03a', -- Ice
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'OZY47546', -- Jeremy
                'EJH58609', -- Leroy
                'SNT45942', -- Vincent
                'NRT91618', -- Jenkins
            }
        },
        ['finnistaxi'] = {
            instanceid = 78005, -- for instance
            label = 'Finnis Taxi',
            ipl = 'ex_dt1_02_office_01c', -- vintage
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'BXK16364', -- Finn
            }
        },
        ['baycity'] = {
            instanceid = 78006, -- for instance
            label = 'Bay City Inc',
            ipl = 'ex_dt1_02_office_03c', -- polished
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'ZIS46946', -- Bjorn
                'IDQ82613', -- Richard
                'LUF50661', -- Ruby
                'HBB42281', -- Brandon
                'SGJ51301', -- Zack
                'VML65752', -- Jacob
                'OAQ12596', -- Token
            }
        },
        ['winedesign'] = {
            instanceid = 78008, -- for instance
            label = 'Wine & Design',
            ipl = 'ex_dt1_02_office_02b', -- vintage
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'HHJ72018', -- Riley
            }
        },
        ['dreamdesign'] = {
            instanceid = 78010, -- for instance
            label = 'Dream Home',
            ipl = 'ex_dt1_02_office_01b', -- classical
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'SSA87831', -- Cherry
            }
        },
        ['southsiderecords'] = {
            instanceid = 78011, -- for instance
            label = 'South Side',
            ipl = 'ex_dt1_02_office_03a', -- ice
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'MNC47667', -- Crispy
                'LJU64522', -- Ace
            }
        },
        ['tenfourtwo'] = {
            instanceid = 78012, -- for instance
            label = '10-42',
            ipl = 'ex_dt1_02_office_02c', -- ice
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'DSE45573', -- Mason
                'ILH81758', -- Bojack
                'WAT02181', -- Petrovic
                'AHL95149', -- Benny
            }
        },
        ['spyglass'] = {
            instanceid = 78013, -- for instance
            label = 'Spyglass',
            ipl = 'ex_dt1_02_office_01a', -- Warm
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'EMX64638', -- James
                'JAE00222', -- Wynnslow 
                'RIS25316 ', -- Billy
            }
        },
        ['trinitylaw'] = {
            instanceid = 78014, -- for instance
            label = 'Trinity Law',
            ipl = 'ex_dt1_02_office_02c', -- ice
            keys = {
                'QCE51214', -- Miguel
                'QYB19583', -- Emily
                'LSJ46123', -- Malfo
                'PLV28667', -- Paulie Walnuts
            }
        },
]]--