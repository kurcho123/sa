fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'GABZ'
description 'PILLBOX'
version '4.0.0s'

this_is_a_map 'yes'

dependencies {
  '/server:4960',
  '/gameBuild:2189'
}

escrow_ignore {
    'stream/**/*.ytd',
    'pillbox.lua',
}

file 'gabztimecyclemods.xml'
data_file 'TIMECYCLEMOD_FILE' 'gabztimecyclemods.xml'

client_script {
  "main.lua"
}