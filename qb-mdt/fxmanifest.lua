fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

author 'Flawws, Flakey, Idris and the Project Sloth team'
description 'EchoRP MDT Rewrite for QBCore'
version '0.9.9'

lua54 'yes'

shared_script 'shared/**.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@qb-apartments/config.lua',
    'server/utils.lua',
    'server/dbm.lua',
    'server/main.lua',
    'server/migrate.lua'
}
client_scripts{
    'client/main.lua',
    'client/cl_impound.lua'
} 

ui_page 'ui/dashboard.html'

files {
    'ui/img/**.png',
    'ui/dashboard.html',
    'ui/app.js',
    'ui/style.css',
}