fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

description 'QB-Multicharacter Diseñit wapo de Macro'
version '1.0.0'
server_script '@oxmysql/lib/MySQL.lua'
shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/script.js',
    'html/musica.mp3',
    'html/click.wav',
    'html/*.png',
}

dependencies {
}