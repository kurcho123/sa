fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

client_scripts {
    '@JayMenu/jaymenu.lua',
	'config.lua',
	'client.lua',
	'ce_names.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

file 'AllTattoos.json'