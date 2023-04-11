fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'Paradox Vehicle Controller'
version '1.0.0'

shared_script 'config/*.lua'
server_script 'server/*.lua'
server_script '@oxmysql/lib/MySQL.lua'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua',
}

lua54 'yes'