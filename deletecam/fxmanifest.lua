fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

name 'Look to delete'
description 'Turn around, look at things to deleeeeet'
author 'Jaymo'
version 'v1.0.0'

dependancy "freecam"

server_script 'server.lua'
client_scripts {
	'helpers.lua',
	'client.lua',
}