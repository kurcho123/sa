fx_version 'bodacious'
games { 'gta5' }

version '1.2.0'

client_scripts {
    'config.lua',
    'client/*.lua'
}

server_scripts {
    'config.lua',
    'server/*.lua',
}

lua54 'yes'

escrow_ignore {
    'config.lua',
    'client/editable_game_setup.lua',
    'client/editable_client.lua',
    'client/editable_racket.lua',
    'client/blip.lua',
}
dependency '/assetpacks'