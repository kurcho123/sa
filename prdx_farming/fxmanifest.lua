fx_version 'cerulean'
games {'gta5' }

author 'AnDylek'
description 'Voxel Studio Farming'
version 'CUSTOM'


shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'cl_edit_me.lua',
    'client/cl_main.lua',
    'client/cl_utils.lua',
    'client/cl_menu.lua',
}
server_scripts {
    'server/sv_main.lua',
    'sv_edit_me.lua',
}
files {
    "plantData.json",
}

lua54 'yes'
use_fxv2_oal 'yes'