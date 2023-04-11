fx_version 'cerulean'
this_is_a_map 'yes'
games {'gta5'}
lua54 'yes'

files {
    "audio/vespmech_game.dat151.rel",
    "audio/vespmech_mix.dat15.rel"
}

data_file "AUDIO_GAMEDATA" "audio/vespmech_game.dat"
data_file "AUDIO_DYNAMIXDATA" "audio/vespmech_mix.dat"

description "bamboozled iplLoader"
client_scripts {
"stream/main.lua"
}

escrow_ignore {
  'stream/main.lua', 
}

dependency '/assetpacks'