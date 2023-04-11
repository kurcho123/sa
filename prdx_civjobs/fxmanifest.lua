fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author "Darahz"
description "Civilian jobs"
version "v1.0.0"

server_scripts {'server/*.lua'}

client_script { 'client/*.lua'}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}