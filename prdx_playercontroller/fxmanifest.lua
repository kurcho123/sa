fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'Paradox Player Controller'
version '1.0.0'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'devmode.lua'
}  
server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}  
client_scripts {
	'client/*.lua',
	'client/radialmenu/*.lua'
} 

exports {
	'HasHarness'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js',
}