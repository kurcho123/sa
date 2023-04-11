fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

name 'Paradox Public Jobs'
author 'xXJamie_Xx & JnKTechstuff'
version '69.0'

shared_scripts {'@ox_lib/init.lua','config/*.lua'}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    "client/*.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "server/*.lua"
}

ui_page 'nui/ui.html'

files {
    "nui/ui.html",
	"nui/panel.js",
	"nui/style.css"
}