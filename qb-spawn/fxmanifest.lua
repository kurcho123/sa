fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-Spawn'
version '1.0.0'

shared_scripts {
	'config.lua',
	'@qb-houses/config/config.lua',
	'@qb-apartments/config.lua'
}

client_script 'client.lua'
server_script 'server.lua'
server_script '@oxmysql/lib/MySQL.lua'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/script.js',
	'html/reset.css'
}

lua54 'yes'