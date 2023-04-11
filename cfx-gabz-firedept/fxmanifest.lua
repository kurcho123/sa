fx_version 'cerulean'
game 'gta5'
author 'Gabz'
description 'Fire Department'
version '8.0.0'
lua54 'yes'
this_is_a_map 'yes'

dependencies {
    '/server:4960',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 4960.
    '/gameBuild:2189',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2189.
}

server_scripts {
    'version_check.lua',
}

escrow_ignore {
    'stream/**/*.ytd',
    'firedept.lua',
}

data_file 'TIMECYCLEMOD_FILE' 'gabz_firedept.xml'

files {
    'gabz_firedept.xml',
}
dependency '/assetpacks'