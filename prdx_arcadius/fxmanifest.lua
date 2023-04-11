fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

name 'Paradox Arcadius Business Center'
author 'JnkTechstuff'
version '1.0'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "config.lua",
    "client/*.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "config.lua",
    "server/*.lua"
}

shared_script '@ox_lib/init.lua'