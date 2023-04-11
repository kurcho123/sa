Config = {}

if lib.context == 'server' then
    Config.SoundScriptName = 'xsound'
    Config.SoundPath = '/html/sounds'
end

Config.Linux = false

Config.Commands = {
    ['usemenu'] = 'mod',
    ['noclip'] = 'mod',
    ['names'] = 'mod',
    ['blips'] = 'mod',
    ['setmodel'] = 'god'
}

Config.Events = {
    ['giveallweapons'] = 'god',
    ['getradiolist'] = 'mod',
    ['usemenu'] = 'mod',
    ['playeroptionsgeneral'] = 'mod',
    ['kick'] = 'mod',
    ['ban'] = 'admin',
    ['changeperms'] = 'god',
    ['clothing menu'] = 'admin',
    ['play sounds'] = 'admin',
    ['changeplayerdata'] = 'god'
}

Config.Weaponlist = {
    ['pistol'] = {
        'weapon_pistol',
        'weapon_pistol_mk2',
        'weapon_combatpistol',
        'weapon_appistol',
        'weapon_stungun',
        'weapon_pistol50',
        'weapon_snspistol',
        'weapon_heavypistol',
        'weapon_vintagepistol',
        'weapon_flaregun',
        'weapon_marksmanpistol',
        'weapon_revolver',
        'weapon_revolver_mk2',
        'weapon_doubleaction',
        'weapon_snspistol_mk2',
        'weapon_raypistol',
        'weapon_ceramicpistol',
        'weapon_navyrevolver',
        'weapon_gadgetpistol',
    },
    ['smg'] = {
        'weapon_microsmg',
        'weapon_smg',
        'weapon_smg_mk2',
        'weapon_assaultsmg',
        'weapon_combatpdw',
        'weapon_machinepistol',
        'weapon_minismg',
        'weapon_raycarbine',
    },
    ['shotgun'] = {
        'weapon_pumpshotgun',
        'weapon_sawnoffshotgun',
        'weapon_assaultshotgun',
        'weapon_bullpupshotgun',
        'weapon_musket',
        'weapon_heavyshotgun',
        'weapon_dbshotgun',
        'weapon_autoshotgun',
        'weapon_pumpshotgun_mk2',
        'weapon_combatshotgun',
    },
    ['assault'] = {
        'weapon_assaultrifle',
        'weapon_assaultrifle_mk2',
        'weapon_carbinerifle',
        'weapon_carbinerifle_mk2',
        'weapon_advancedrifle',
        'weapon_specialcarbine',
        'weapon_bullpuprifle',
        'weapon_compactrifle',
        'weapon_specialcarbine_mk2',
        'weapon_bullpuprifle_mk2',
        'weapon_militaryrifle',
    },
    ['lmg'] = {
        'weapon_mg',
        'weapon_combatmg',
        'weapon_gusenberg',
        'weapon_combatmg_mk2',
    },
    ['sniper'] = {
        'weapon_sniperrifle',
        'weapon_heavysniper',
        'weapon_marksmanrifle',
        'weapon_remotesniper',
        'weapon_heavysniper_mk2',
        'weapon_marksmanrifle_mk2',
    },
    ['heavy'] = {
        'weapon_rpg',
        'weapon_grenadelauncher',
        'weapon_grenadelauncher_smoke',
        'weapon_minigun',
        'weapon_firework',
        'weapon_railgun',
        'weapon_hominglauncher',
        'weapon_compactlauncher',
        'weapon_rayminigun',
    }
}
