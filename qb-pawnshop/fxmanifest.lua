fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-Pawnshop'
version '1.0.0'

shared_script 'config.lua'
server_script 'server/main.lua'

client_scripts {
	'client/main.lua',
	'client/melt.lua'
}

lua54 'yes'