fx_version 'cerulean'
game 'gta5'
author 'Gabz'
description 'CatCafe'
version '8.0.0'
lua54 'yes'
this_is_a_map 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/finn_menuboard/menuboard_gg.ytyp' 

dependencies {
    '/server:4960',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 4960.
    '/gameBuild:2189',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2189.
}

server_scripts {
    'version_check.lua',
}

escrow_ignore {
    'stream/**/*.ytd',
    'catcafe.lua',
}

data_file 'TIMECYCLEMOD_FILE' 'gabz_catcafe.xml'

files {
    'gabz_catcafe.xml',
}

dependency '/assetpacks'