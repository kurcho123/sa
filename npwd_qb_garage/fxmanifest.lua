fx_version "cerulean"
game "gta5"
lua54 'yes'
use_fxv2_oal 'yes'

client_script 'client/client.lua'
server_script {
    'server/server.lua',
    '@oxmysql/lib/MySQL.lua',
}

shared_scripts {
    '@qb-garages/config.lua',
  }

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/*.js',
}
