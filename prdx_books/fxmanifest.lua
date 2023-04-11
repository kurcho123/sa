fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'
author 'Paradox Gaming'
ui_page 'html/index.html'

shared_script '@ox_lib/init.lua'

client_script 'client/*.lua'

server_scripts {
    'server.lua',
    '@oxmysql/lib/MySQL.lua',
}

files {
    "html/*.html",
    "html/*.css",
    "html/*.js"
} 