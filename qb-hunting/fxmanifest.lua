fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'
description 'hunting activity for the QBCore framework https://forum.cfx.re/t/aod-hunting-esx/3492981'
author 'AgentofDeath'
version '1.2.0'

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'cfg_hunting.lua',
	'cl_hunting.lua',
}

server_scripts {'cfg_hunting.lua','sv_hunting.lua'}

shared_script '@ox_lib/init.lua'