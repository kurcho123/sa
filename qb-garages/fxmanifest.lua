fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-Garages'
version '1.0.0'
author 'JDev'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/poly.lua',
    'client/main.lua'
}

server_scripts {	
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

lua54 'yes'
