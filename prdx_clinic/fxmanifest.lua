fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'Pillbox Hospital Functionality'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_script 'server/main.lua'

client_script 'client/main.lua'

files
{   
   'client/sounds/*.ogg',
}

lua54 'yes'