fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-Prison'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
	'config.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'client/**.lua'
}

server_script 'server/main.lua'

lua54 'yes'