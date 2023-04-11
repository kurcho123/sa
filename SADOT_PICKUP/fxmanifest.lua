fx_version 'cerulean'
games {'gta5'}
lua54 'yes'
author 'Redneck Modifications, LLC'

files {
  'data/**/*.meta',
  }
  
  escrow_ignore {
    'data/*',
}

data_file 'HANDLING_FILE'             'data/**/*handling.meta'
data_file 'VEHICLE_METADATA_FILE'     'data/**/*vehicles.meta'
data_file 'CARCOLS_FILE'             'data/**/*carcols.meta'
data_file 'VEHICLE_VARIATION_FILE'    'data/**/*carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE'      'data/**/*vehiclelayouts.meta'

dependency '/assetpacks'