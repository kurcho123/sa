fx_version 'cerulean'

game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

client_scripts {
	'config/config.lua',
	'client/main.lua'
}

server_scripts {
	'config/config.lua',
	'server/main.lua'
}

shared_script '@ox_lib/init.lua'
