fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

-- the postal map to read from
-- change it to whatever model you want that is in this directory
local postalFile = 'ocrp-postals.json'


client_scripts {
    'config.lua',
    'cl.lua'
}
server_script 'sv.lua'

file(postalFile)
postal_file(postalFile)

file 'version.json'
