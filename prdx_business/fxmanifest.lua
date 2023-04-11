fx_version "cerulean"
game "gta5"
description "Paradox Business Management System"
lua54 'yes'
use_fxv2_oal 'yes'

client_scripts {
    '@ox_lib/init.lua',
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}

shared_scripts {
    "config/*.lua"
}