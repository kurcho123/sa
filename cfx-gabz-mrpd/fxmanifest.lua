fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Gabz'
description 'MRPD'
version '4.0.0s'

this_is_a_map 'yes'

dependencies {
    '/server:4960',
    '/gameBuild:2189'
}

escrow_ignore {
    'stream/**/*.ytd',
    'mrpd.lua',
}

data_file 'TIMECYCLEMOD_FILE' 'gabz_mrpd_timecycle.xml'

files {
	'gabz_mrpd_timecycle.xml',
}

client_script {
    "gabz_mrpd_entitysets.lua"
}
dependency '/assetpacks'