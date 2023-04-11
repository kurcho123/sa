fx_version 'adamant'
games { 'gta5' }

client_script 'client/*.lua'


server_script 'server/*.lua'


shared_scripts { 
	'config.lua',
	'@ox_lib/init.lua',
}

lua54 'yes'
use_fxv2_oal 'yes'