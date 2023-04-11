fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-TruckRobbery'
version '2.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
	'@ox_lib/init.lua',
	'locales/en.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'config.lua'
}

server_script 'server/main.lua'

lua54 'yes'