fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

--[[-----------------------------------------------------------------------

    Wraith Radar System - v1.02
    Created by WolfKnight

-----------------------------------------------------------------------]]--


ui_page "nui/radar.html"

files {
	"nui/digital-7.regular.ttf", 
	"nui/radar.html",
	"nui/radar.css",
	"nui/radar.js"
}

client_script 'cl_radar.lua'
server_script 'sv_radar.lua'