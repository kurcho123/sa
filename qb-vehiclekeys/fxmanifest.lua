fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-VehicleKeys'
version '1.0.0'

shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'
server_script '@oxmysql/lib/MySQL.lua'
shared_script '@ox_lib/init.lua'

lua54 'yes'