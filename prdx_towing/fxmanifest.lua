fx_version 'adamant'
game 'gta5'
use_fxv2_oal 'yes'
lua54 'yes'

description 'Flatbeds Script v3'
author 'Theebu'

version '0.3.5'

client_scripts {
	'client/utils.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
	'config.lua',
	'server/server.lua'
}

escrow_ignore {
	'config.lua',
	'client/utils.lua'
}
dependency '/assetpacks'