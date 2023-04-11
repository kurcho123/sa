fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'
description 'Paradox Crypto System'
version '1.0.0'

shared_scripts {
	'config/*.lua',
	'@ox_lib/init.lua',
} 

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}