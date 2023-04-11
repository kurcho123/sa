-- Wowow an epic shared file
Config = {} -- We must initialise the config table to be able to do config.anything

Config.ShiftJobs = {
    -- public safety
    ["ambulance"] = {}, 
    ["lspd"] = {}, 
    ["bcso"] = {}, 
    ["sast"] = {},
    ["pd_cid"] = {},
    ["tow"] = {},
    ["hc"] = {},
    ["marshalls"] = {},
    ["government"] = {},
    ["lawyer"] = {},

    -- businesses
    ["glazedandglorious"] = {},
    ["yellowjack"] = {},
    ["vanillaunicorn"] = {},
    ["tequilala"] = {},
    ["smokeonthewater"] = {},
    ["finnistaxi"] = {},
    ["tenfourtwo"] = {},
    ["bikinitow"] = {},  
    ["slurpngo"] = {},
    ["nismostuning"] = {},
    ["realestate"] = {},
    ["cardealer"] = {},
    ["beaveraviation"] = {},
    ["gopostal"] = {},
    ["maisonette"] = {},
    ["knifeshop"] = {},
    ["glizzycomics"] = {},
    ["bikedealer"] = {},
    ["clinic"] = {},
    ["koi"] = {},
    ["roseandcrown"] = {},
}

Config.Webhooks = {
    ["ambulance"] = {url = "https://discord.com/api/webhooks/935292712154964018/_cKJ9OsVErKIsp1dJzhO0YPGW9oX6NOBOHLDnjmftqF1-7mgy8h0UrLYdsd1LhGLwH_T", color = 15158332, header = "EMS/Fire Shift"},
    ["lspd"] = {url = "https://discord.com/api/webhooks/935291707359125514/EbdkFX5SUtwQKi6IQwoXyUIlGbJaFLv21gCrgbL016JfdFYOJQFyEyLrwAM80mGDHL-G", color = 3447003, header = "LSPD Shift"},
    ["bcso"] = {url = "https://discord.com/api/webhooks/935292247543533679/aOLiMgVl_dzCusPn_i1GvOY0J4g2BsDB-4PELwjOfI5BBmqT2yD1BgW3Iqf1YQOrQ-Pv", color = 3066993, header = "BCSO Shift"},
    ["sast"] = {url = "https://discord.com/api/webhooks/935292527169384448/wI_zj20Z9rlSgKSP-__Xu1L7axvuMooD5273SLWnLiXmNo79DhU60zy0rkFKKrVCMamQ", color = 2123412, header = "SAST Shift"},
    ["pd_cid"] = {url = "https://discord.com/api/webhooks/954476374603743262/Czrt7rSGCFo-QqAeVIQSvmtGhxt7yOFPAzlmvkf5Piv_l7gDZ5v_xEjoAcyvhZTDGjNq", color = 2123412, header = "CID Shift"},
    ["tow"] = {url = "https://discord.com/api/webhooks/919614140522315886/ufyTmVZchlVQMC4mpEJq3F1m3Tj-XAG9g4hzYyIG5mQVGXt-ePHjhX_tNwAMwS37Hc4t", color = 13400320, header = "SADOT Shift"},
    ["hc"] = {url = "https://discord.com/api/webhooks/935136400376995893/a4a5XA5fDvduK4CHEWp3V63OQjULzTs1W_X3DGOhCc4mu_3qZE96Z-n0yPDCz7vnF4iG", color = 8359053, header = "Command Shift"},
    ["marshalls"] = {url = "https://discord.com/api/webhooks/935136400376995893/a4a5XA5fDvduK4CHEWp3V63OQjULzTs1W_X3DGOhCc4mu_3qZE96Z-n0yPDCz7vnF4iG", color = 2067276, header = "Marshals Shift"},
    ["government"] = {url = "https://discord.com/api/webhooks/988095978005479455/d4Oj_sJii-MQlH_yNRCVeBO-kek18QvSTpCeerEHiA8F2D7aLGqMoS_nXafWW9FqD1vd", color = 2067276, header = "DOJ Shift"},
    ["lawyer"] = {url = "https://discord.com/api/webhooks/988095978005479455/d4Oj_sJii-MQlH_yNRCVeBO-kek18QvSTpCeerEHiA8F2D7aLGqMoS_nXafWW9FqD1vd", color = 2067276, header = "DOJ Shift"},

    -- businesses
    ["glazedandglorious"] = {url = "https://discord.com/api/webhooks/959868738558132248/q9BIJkmwRV64gpd6rqD9icq_aN9Zl5AePm1DW0LNtDwNL2VWlB5lN5MS1upCutcqwaRa", color = 13400320, header = "Glazed and Glorious Shift"},
    ["yellowjack"] = {url = "https://discord.com/api/webhooks/959868813397090345/Zs4NOtD1fX-Hlrj4Ts3tE86tOIKrd5bk2ALZ7tlkUJ-sFW2_mYlnKCPyghMifa0YKV8K", color = 13400320, header = "Open Road Shift"},
    ["vanillaunicorn"] = {url = "https://discord.com/api/webhooks/959868886214410310/S2MbJ8ovFK5yR3Ggtf625189e_P_BounjXw_cKTNWPqULUsGTjQdEDypsyDkqXU5o9Az", color = 13400320, header = "Vanilla Unicorn Shift"},
    ["tequilala"] = {url = "https://discord.com/api/webhooks/959868956431245372/w1zSYrS7i36M5ad4oiAwpfN7N0vNnm3CkAo7twz3lX13do82HZPfnnWaCohoVYu5qQ8d", color = 13400320, header = "Tequilala Shift"},
    ["smokeonthewater"] = {url = "https://discord.com/api/webhooks/959869062610026576/xFDZ590urfbXVs3ATqHq-JTza4udmCIm_FRHH3PEAlBCYmAmb-WtlZJgqbwqVfK3rQNv", color = 13400320, header = "Smoke on the Water Shift"},
    ["finnistaxi"] = {url = "https://discord.com/api/webhooks/975399322248159262/mCwa5dcVVaEoqIK52DCt0gy-vB4r1vzjv9WIvTQLu40rTID-lO_rM5OTS-ncRipmqeI8", color = 13400320, header = "Taxi Shift"},
    ["tenfourtwo"] = {url = "https://discord.com/api/webhooks/976138864139853854/pypcAvMMsflxdut_FxnVNo2K-6z3o-2xAwCxcSwHflp3aPkOaFizapQvQHTnELHc73X_", color = 13400320, header = "10-42 Shift"},
    ["bikinitow"] = {url = "https://discord.com/api/webhooks/997931029996261406/ARgQ8ndWQVRYwgsDo4f4w4GtqCbrZ-MjCA50cuEpZ_9xGwqH2wjd-SUc3PUw5C2EnQO7", color = 13400320, header = "Bikini Autoshop Shift"},
    ["nismostuning"] = {url = "https://discord.com/api/webhooks/998024774729076786/poV3P95FzfaYmipvC9BDTgb7QP6mPi-r0AHHkyKfDOxt8r5tn1XSYS8ChubVRoLgxDFm", color = 13400320, header = "Nismos Tuning Shift"},
    ["realestate"] = {url = "https://discord.com/api/webhooks/998024632789643284/D7EDywL4MJcn7GJCW48PiWd8KRUYjVKVz5s_1hLUyNaYjayQ7LweqXj1Z3gHF7FLgTmj", color = 13400320, header = "Wolfs Real Estate Shift"},
    ["cardealer"] = {url = "https://discord.com/api/webhooks/998025021488386088/5TMsZdFooIcCGmcjPpB8mOss5C916-jWOM-EbRN9EEwoE1O9wpIvviZzGd2MUSA1H1AZ", color = 13400320, header = "Kildare Autos Shift"},
    ["slurpngo"] = {url = "https://discord.com/api/webhooks/998024198112940123/qUkFKg2x7BS0cf5D78Gp8SgP52oiOGyrNw6jBJp8f1g-cEtO6wif_4bJUtxilX_g9iY5", color = 13400320, header = "Slurp n Go Shift"},
    ["beaveraviation"] = {url = "https://discord.com/api/webhooks/1010519456088334456/pt9FM4knZJqOK82ESjb3AesWHpr-yYgmRKq_0fO6xoz0_CUFI2Vh1oReem9NaTD648Nh", color = 13400320, header = "Flying Beaver Aviation Shift"},
    ["gopostal"] = {url = "https://discord.com/api/webhooks/1046971606708260985/Go1GVhfxEUcQ_urO-YDsmEv1It7pef80KRM8z6FbkKG7An_rAvgajJq_bcAoIastpwkr", color = 13400320, header = "GoPostal Shift"},
    ["maisonette"] = {url = "https://discord.com/api/webhooks/1052667188483457084/2QyAgWCCMrM1onukqHNGu-C_YXUK923v0I5xlY6R1fdioX801Vaq9-db5lkppGFiN5HR", color = 13400320, header = "Maisonette Shift"},
    ["knifeshop"] = {url = "https://discord.com/api/webhooks/1054129126602195035/eQzARdqptJutdGqL_nLA29j4TRUcVJmFpLnu6UrALrlUNroME9T6jGMke2lkV2qJZVum", color = 13400320, header = "Sycthe Smiths Shift"},
    ["glizzycomics"] = {url = "https://discord.com/api/webhooks/1068272108968358039/0iPTVyt-ymPpUH7rwEfG8Nlxy-Gc4TuUQrSQpGzYCTTvu93Vw575bm_TGyd5nhXnLweb", color = 13400320, header = "Glizzy Comics Shift"},
    ["bikedealer"] = {url = "https://discord.com/api/webhooks/1071550940869558293/EZfCyfBjv6cU6qKAk_dTYWFR3RKtqIQ4UkgwtCFUYo3JwT6r4zyP9PW3YzkMcyIO06lk", color = 13400320, header = "Reapers Bike Shop Shift"},
    ["clinic"] = {url = "https://discord.com/api/webhooks/1072323681151352892/tUCYPbVGacNk4yMi3aCLd79w3YHLsREGLD4Rm_c-Aw66QRFZ9OY-fpYS4XgitPX1rt76", color = 1769676, header = "Clinic Shift"},
    ["koi"] = {url = "https://discord.com/api/webhooks/1080225654123012217/V0pp4wHJwYnC9GVx2Ok8H0TB3u6pP8MuWFQ-0AMfmxqAIp1epvXUowllpJGDxP0mLlOu", color = 13400320, header = "KOI Shift"},
    ["roseandcrown"] = {url = "https://discord.com/api/webhooks/1081028014344777788/xLnsnDbb2pIqOUq2vf19p_v47KV-wS-dkn0CcUbWmUvXbUxbXka3AMA_eogvPXanvRd_", color = 13400320, header = "Rose And Crown Shift"},
} 





