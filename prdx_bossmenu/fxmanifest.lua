fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'Paradox Boss Menu NUI'
version '1.0.0'

shared_script '@ox_lib/init.lua'

client_scripts {
    'config.lua',
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua',
    'server/sv_functions.lua',
    'server/sv_data.lua',
    'server/sv_commands.lua'
} 

server_export 'GetAccount'

ui_page 'nui/ui.html'

files {
    'nui/ui.html',
    'nui/panel.js',
    'nui/style.css'
}

lua54 'yes'