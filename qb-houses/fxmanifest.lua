fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-Houses'
version '2.1.0'

ui_page 'html/index.html'

shared_scripts {
	'config/**.lua',
    '@qb-core/shared/locale.lua',
	'locales/en.lua',
	'locales/*.lua',
    '@ox_lib/init.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua',
	'client/decorate.lua',
}

files {
	'html/index.html',
	'html/reset.css',
	'html/style.css',
	'html/script.js',
	'html/img/dynasty8-logo.png'
}

dependencies {
	'qb-core',
	'ox_lib'
}