fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-Logs'
version '1.0.0'

client_script 'client/client.lua'

server_scripts {
    'server/server.lua',
    'server/hooks.lua',
    'config.lua'
}

lua54 'yes'