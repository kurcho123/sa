fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

shared_script '@ox_lib/init.lua'
server_script('@oxmysql/lib/MySQL.lua')
server_script('server.lua')
server_script('skins.lua')
client_script('client/config.lua')
client_script('client/tattooshop.lua')
client_script('skins.lua')
client_script('client/client.lua')
client_script('client/commands.lua')

ui_page('html/index.html')

files({
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/webfonts/fa-brands-400.eot',
    'html/webfonts/fa-brands-400.svg',
    'html/webfonts/fa-brands-400.ttf',
    'html/webfonts/fa-brands-400.woff',
    'html/webfonts/fa-brands-400.woff2',
    'html/webfonts/fa-regular-400.eot',
    'html/webfonts/fa-regular-400.svg',
    'html/webfonts/fa-regular-400.ttf',
    'html/webfonts/fa-regular-400.woff',
    'html/webfonts/fa-regular-400.woff2',
    'html/webfonts/fa-solid-900.eot',
    'html/webfonts/fa-solid-900.svg',
    'html/webfonts/fa-solid-900.ttf',
    'html/webfonts/fa-solid-900.woff',
    'html/webfonts/fa-solid-900.woff2',
    'html/css/all.min.css',
    'server.lua'
})
