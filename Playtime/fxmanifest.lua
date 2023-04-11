fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

-- https://wiki.fivem.net/wiki/Resource_manifest


description 'Paradox Personnel Logs'

version '1.1.0'

-- server scripts
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"server/main.lua",
}

-- client scripts
client_scripts {
	"client/main.lua",
}