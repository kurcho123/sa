fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

name 'Paradox Tuners'
author 'JnKTechstuff'
version '1.0'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "client.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "server.lua"
}

shared_scripts {
    "config.lua",
    '@ox_lib/init.lua',
}