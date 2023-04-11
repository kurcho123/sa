fx_version "cerulean"
game "gta5"
description "Gang Management System"
lua54 "yes"

shared_script '@ox_lib/init.lua'

client_scripts {
    "config.lua",
    "client.lua"
}

server_scripts {
    "config.lua",
    "server.lua",
}