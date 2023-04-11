fx_version "cerulean"

game { "gta5" }

data_file 'TIMECYCLEMOD_FILE' 'timecycle/timecycle_mods_1.xml'
data_file 'TIMECYCLEMOD_FILE' 'timecycle/w_blizzard.xml'
data_file 'TIMECYCLEMOD_FILE' 'timecycle/w_snow.xml'
data_file 'TIMECYCLEMOD_FILE' 'timecycle/w_snowlight.xml'
data_file 'TIMECYCLEMOD_FILE' 'timecycle/w_xmas.xml'
data_file 'FIVEM_LOVES_YOU_341B23A2F0E0F131' 'popgroups.ymt'
data_file 'DLC_ITYP_REQUEST' 'stream/mads_no_exp_pumps.ytyp'

files {
    "meta/gta5.meta",
    "meta/weather.xml",
	"meta/water.xml",
    'popgroups.ymt',
    "timecycle/timecycle_mods_1.xml",
	"timecycle/w_blizzard.xml",
	"timecycle/w_snow.xml",
	"timecycle/w_snowlight.xml",
	"timecycle/w_xmas.xml"
}

replace_level_meta "meta/gta5"
before_level_meta 'data'
replace_level_meta "meta/gta5"