fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

name 'Paradox Paintball'
version '1.0'
author 'xXJamie_Xx'

shared_script 'config.lua'

client_scripts {
    '@ox_lib/init.lua',
    '@PolyZone/client.lua',
    'client.lua'
}

server_scripts {
    'server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/app.js',
    'html/style.css'
}

lua54 'yes'