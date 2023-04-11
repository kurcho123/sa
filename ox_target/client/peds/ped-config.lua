Peds = {
	{
		model = 's_m_y_cop_01', 
		coords = vector4(480.96, -995.55, 30.69, 224.91),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_COP_IDLES',
		target = { 
			options = {
				{
					type = "client",
					event = "police:client:openArmory",
					icon = "fas fa-user-shield",
					label = "Open Armory",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	  },
	  {
		  model = 's_m_y_pilot_01', 
		  coords = vector4(459.78, -986.64, 25.7, 91.16),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "police:client:openGarage",
					  icon = "fas fa-car",
					  label = "Open Motorpool",
					  garage = nil,
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
					  num = 2,
					  type = "client",
					  event = "police:client:storeVehicle",
					  icon = "fas fa-car",
					  label = "Store Vehicle",
					  garage = "mrpd",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
					  num = 3,
					  type = "client",
					  event = "police:client:openVehiclePersonalPurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase Personal Vehicle",
					  garage = "mrpd",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
					  num = 4,
					  type = "client",
					  event = "police:client:openVehiclePoolPurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase Pool Vehicle",
					  garage = "mrpd",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 's_m_y_xmech_01', 
		  coords = vector4(-193.55, -1161.72, 24.13, 265.69),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT',
		  scenariolower = 1.0,
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "qb-garages:client:OpenMenu",
					  icon = "fas fa-car-crash",
					  label = "Open Impound Depot",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 's_m_m_security_01', 
		  coords = vector4(-154.68, -1175.67, 24.0, 267.95),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "police:client:openImpound",
					  icon = "fas fa-car-crash",
					  label = "Open Police Depot",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		model = 's_f_y_scrubs_01', 
		coords = vector4(339.02, -586.53, 28.8, 64.41),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
		target = { 
			options = {
				{
					type = "server",
					event = "prdx_healthsystem:server:sendPlayerToHospital",
					icon = "fas fa-clipboard",
					label = "Check In (Pillbox Lower)",
				},
				{
					type = "client",
					event = "prdx_stretcher:client:checkPatientIntoHospital",
					icon = "fas fa-clipboard",
					label = "Check Patient In (Pillbox Lower)",
					job = {["ambulance"] = 0, ["clinic"] = 0}
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	  },
	  {
		model = 's_f_y_scrubs_01', 
		coords = vector4(306.57, -595.43, 43.27, 10.4),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
		target = { 
			options = {
				{
					type = "server",
					event = "prdx_healthsystem:server:sendPlayerToHospital",
					icon = "fas fa-clipboard",
					label = "Check In (Pillbox Upper)",
				},
				{
					type = "client",
					event = "prdx_stretcher:client:checkPatientIntoHospital",
					icon = "fas fa-clipboard",
					label = "Check Patient In (Pillbox Upper)",
					job = {["ambulance"] = 0, ["clinic"] = 0}
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	{
		model = 's_m_m_paramedic_01', 
		coords = vector4(334.58, -590.04, 28.8, 11.01),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					num = 1,
					type = "client",
					event = "ambulance:client:openGarage",
					icon = "fas fa-car",
					label = "Open Motorpool",
					garage = "pillbox",
					job = 'ambulance',
					
				},
				{
					num = 2,
					type = "client",
					event = "ambulance:client:storeVehicle",
					icon = "fas fa-car",
					label = "Store Vehicle",
					garage = "pillbox",
					job = 'ambulance',
				},
				{
					num = 3,
					type = "client",
					event = "ambulance:client:openVehiclePurchase",
					icon = "fas fa-shopping-cart",
					label = "Purchase Vehicle",
					garage = "pillbox",
					job = {["ambulance"] = 4},
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	  },
	  
  
	  -- Garbage Job
	  {
		  model = 's_m_y_garbage', 
		  coords = vector4(-322.25, -1545.89, 31.02, 271.29),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "garbage:getTruck",
					  icon = "fas fa-warehouse",
					  label = "Start Work",
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "garbage:returnTruck",
					  icon = "fas fa-receipt",
					  label = "Collect Payslip",
				  }
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
	  {
		  model = 's_m_y_uscg_01', 
		  coords = vector4(337.92, -586.72, 74.16, 255.82),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "ambulance:client:SpawnHelicopter",
					  icon = "fas fa-helicopter",
					  label = "Request Medivac",
					  garage = "pillbox",
					  job = 'ambulance',
					  args = { coords = vector4(352.11, -588.24, 74.55, 17.01) }
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "ambulance:client:deleteHelicopter",
					  icon = "fas fa-parking",
					  label = "Store Medivac",
					  garage = "pillbox",
					  job = 'ambulance',
				  }
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },

	  -- MRPD police heli spawn
	  {
		model = 's_m_y_pilot_01', 
		coords = vector4(463.03, -982.2, 43.69, 90.75),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		target = { 
			options = {
				{
					num = 1,
					type = "client",
					event = "police:client:SpawnHelicopter",
					icon = "fas fa-helicopter",
					label = "Request Helicopter",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					args = { coords = vector4(449.168, -981.325, 43.691, 87.234) }
				},
				{
					num = 2,
					type = "client",
					event = "ambulance:client:deleteHelicopter",
					icon = "fas fa-parking",
					label = "Store Helicopter",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
				}
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},

	-- Sandy police/ems heli spawn
	{
		model = 's_m_y_pilot_01', 
		coords = vector4(1862.85, 3656.37, 33.97, 84.32),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		target = { 
			options = {
				{
					num = 1,
					type = "client",
					event = "police:client:SpawnHelicopter",
					icon = "fas fa-helicopter",
					label = "Request Helicopter",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					args = { coords = vector4(1866.38, 3646.41, 35.79, 30.47) }
				},
				{
					num = 2,
					type = "client",
					event = "ambulance:client:deleteHelicopter",
					icon = "fas fa-parking",
					label = "Store Helicopter",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
				},
				{
					num = 1,
					type = "client",
					event = "ambulance:client:SpawnHelicopter",
					icon = "fas fa-helicopter",
					label = "Request Medivac",
					garage = "pillbox",
					job = 'ambulance',
					args = { coords = vector4(1866.38, 3646.41, 35.79, 30.47) }
				},
				{
					num = 2,
					type = "client",
					event = "ambulance:client:deleteHelicopter",
					icon = "fas fa-parking",
					label = "Store Medivac",
					garage = "pillbox",
					job = 'ambulance',
				}
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},

	{
		model = 's_m_y_pilot_01',   --paleto heli fire and PD
		coords = vector4(-451.58, 5984.93, 31.35, 93.73),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		target = { 
			options = {
				{
					num = 1,
					type = "client",
					event = "police:client:SpawnHelicopter",
					icon = "fas fa-helicopter",
					label = "Request Helicopter",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					args = { coords = vector4(-480.09, 5993.8, 31.34, 316.83) }
				},
				{
					num = 2,
					type = "client",
					event = "ambulance:client:deleteHelicopter",
					icon = "fas fa-parking",
					label = "Store Helicopter",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
				},
				{
					num = 1,
					type = "client",
					event = "ambulance:client:SpawnHelicopter",
					icon = "fas fa-helicopter",
					label = "Request Medivac",
					garage = "pillbox",
					job = 'ambulance',
					args = { coords = vector4(-469.56, 5982.47, 31.34, 319.51) }
				},
				{
					num = 2,
					type = "client",
					event = "ambulance:client:deleteHelicopter",
					icon = "fas fa-parking",
					label = "Store Medivac",
					garage = "pillbox",
					job = 'ambulance',
				}
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
  
	  {
		  model = 'ig_hunter',  --hunting pelt buyer--
		  coords = vector4(1435.02, 1501.66, 114.13, 188.79),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  target = { 
			  options = {
				{
					num = 1,
					event = "AOD-HuntingBuyerMenu",
					icon = "fas fa-crow",
					label = "Talk", 
					args = {'meatsell', 'meatsell'},
				},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
	  -- Sheriff Front
	  {
		  model = 's_f_y_sheriff_01', 
		  coords = vector4(1851.42, 3685.85, 34.22, 212.54),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "server",
					  event = "QBCore:jobs:ToggleDuty",
					  icon = "fas fa-sign-in-alt",
					  label = "Go on/off duty",
					  dutyJob = "police", -- not actual job name, allows any police job (lspd, bcso, sast, hc, marshalls)
				  },	
				  {
					  type = "client",
					  event = "prdx_mdt:client:openpublic",
					  icon = "fas fa-tablet-alt",
					  label = "Access Public Records",
				  },
				  {
					type = 'server',
					serverEvent = 'QBCore:jobs:ToggleDuty',
					icon = 'fas fa-business-time',
					label = 'Clock In (Lawyer)',
					dutyJob = {["lawyer"] = 0},
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
	  -- Sheriff Armory
	  {
		  model = 's_m_y_sheriff_01', 
		  coords =vector4(1861.26, 3691.08, 35.06, 26.58),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT',
		  scenariolower = 1.45,
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "police:client:openArmory",
					  icon = "fas fa-user-shield",
					  label = "Open Armory",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},  
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  --sheriff motorpool
	  {
		  model = 's_m_y_pilot_01', 
		  coords = vector4(1885.75, 3693.92, 33.54, 64.89),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "police:client:openGarage",
					  icon = "fas fa-car",
					  label = "Open Sandy Motorpool",
					  garage = "mrpd",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
					  type = "client",
					  event = "police:client:openVehiclePersonalPurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase Sandy Personal Vehicle",
					  garage = "mrpd",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
  
					  type = "client",
					  event = "police:client:openVehiclePoolPurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase Sandy Pool Vehicle",
					  garage = "mrpd",
					  job = {["marshalls"] = 0, ["lspd"] = 4, ["bcso"] = 4, ["sast"] = 4, ["pd_cid"] = 0, ["hc"] = 0},
				  },
				  {
					  type = "client",
					  event = "police:client:storeVehicle",
					  icon = "fas fa-car",
					  label = "Store Sandy Vehicle",
					  garage = "mrpd",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
					  type = "client",
					  event = "ambulance:client:openGarage",
					  icon = "fas fa-car",
					  label = "Open EMS Sandy Motorpool",
					  garage = "pillbox",
					  job = 'ambulance',
				  },
				  {
					  type = "client",
					  event = "ambulance:client:storeVehicle",
					  icon = "fas fa-car",
					  label = "Store EMS Sandy Vehicle",
					  garage = "pillbox",
					  job = 'ambulance',
				  },
				  {
					  type = "client",
					  event = "ambulance:client:openVehiclePurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase EMS Sandy Vehicle",
					  garage = "pillbox",
					  job = {["ambulance"] = 4},
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },

	  {
		model = 's_m_y_pilot_01',  --Paleto Fire PD heli store vehicles
		coords = vector4(-452.02, 6005.93, 31.84, 137.68),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					type = "client",
					event = "police:client:openGarage",
					icon = "fas fa-car",
					label = "Open Paleto Motorpool",
					garage = "mrpd",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
				  },
				{
					type = "client",
					event = "police:client:storeVehicle",
					icon = "fas fa-car",
					label = "Store Paleto Vehicle",
					garage = "mrpd",
					job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
				  },
				{
					type = "client",
					event = "ambulance:client:openGarage",
					icon = "fas fa-car",
					label = "Open EMS Paleto Motorpool",
					garage = "pillbox",
					job = 'ambulance',
				},
				{
					type = "client",
					event = "ambulance:client:storeVehicle",
					icon = "fas fa-car",
					label = "Store EMS Paleto Vehicle",
					garage = "pillbox",
					job = 'ambulance',
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	  {
		  model = 'a_m_o_genstreet_01', 
		  coords = vector4(382.53, -1596.89, 30.05, 49.4),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
		  scenariolower = 0.0,
		  target = { 
			  options = {
				  {
					  type = "server",
					  event = "QBCore:jobs:ToggleDuty",
					  icon = "fas fa-sign-in-alt",
					  label = "Go on/off duty",
					  dutyJob = "police", -- not actual job name, allows any police job (lspd, bcso, sast, hc, marshalls)
				  },	
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 'csb_prolsec', 
		  coords = vector4(364.01, -1600.31, 25.86, 332.03),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT',
		  scenariolower = 1.0,
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "police:client:openArmory",
					  icon = "fas fa-user-shield",
					  label = "Open Armory",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 'cs_debra', 
		  coords = vector4(380.8, -1608.71, 30.2, 237.44),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
		  scenariolower = 0.0,
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "prdx_mdt:client:openpublic",
					  icon = "fas fa-tablet-alt",
					  label = "Access Public Records",
				  },
				  {
					  type = "client",
					  event = "police:client:openevidence",
					  args = 1,
					  icon = "fas fa-archive",
					  label = "Open Evidence Box",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 'mp_m_securoguard_01', 
		  coords = vector4(409.29, -1623.12, 29.29, 228.35),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "police:client:openImpound",
					  icon = "fas fa-car-crash",
					  label = "Open Impound Depot",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 's_m_y_pilot_01', 
		  coords = vector4(376.64, -1622.47, 29.29, 191.91),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "police:client:openGarage",
					  icon = "fas fa-car",
					  label = "Open Motorpool Davis",
					  garage = "davis",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
					  num = 2,
					  type = "client",
					  event = "police:client:storeVehicle",
					  icon = "fas fa-car",
					  label = "Store Vehicle Davis",
					  garage = "davis",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
					  num = 3,
					  type = "client",
					  event = "police:client:openVehiclePersonalPurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase Personal Vehicle Davis",
					  garage = "davis",
					  job = {"marshalls", "lspd", "bcso", "sast", "pd_cid", "hc"},
					},
				  {
					  num = 4,
					  type = "client",
					  event = "police:client:openVehiclePoolPurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase Pool Vehicle Davis",
					  garage = "davis",
					  job = {["marshalls"] = 0, ["lspd"] = 4, ["bcso"] = 4, ["sast"] = 4, ["pd_cid"] = 4, ["hc"] = 0},
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  { -- Sandy Check-in
		model = 's_f_y_scrubs_01', 
		coords = vector4(1833.14, 3677.57, 34.27, 249.5),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
		target = { 
			options = {
				{
					type = "server",
					event = "prdx_healthsystem:server:sendPlayerToHospital",
					icon = "fas fa-clipboard",
					label = "Check In (Sandy)",
				},
				{
					type = "client",
					event = "prdx_stretcher:client:checkPatientIntoHospital",
					icon = "fas fa-clipboard",
					label = "Check Patient In (Sandy)",
					job = {["ambulance"] = 0, ["clinic"] = 0}
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	  },
	  { -- Sandy Check-in BACK
		model = 's_f_y_scrubs_01', 
		coords = vector4(1825.11, 3689.94, 34.22, 27.92),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
		target = { 
			options = {
				{
					type = "client",
					event = "prdx_stretcher:client:checkPatientIntoHospital",
					icon = "fas fa-clipboard",
					label = "Check Patient In (Sandy)",
					job = {["ambulance"] = 0, ["clinic"] = 0}
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
		},
	  {-- Paleto Check-in
		model = 's_f_y_scrubs_01', 
		coords = vector4(-256.68, 6333.99, 32.43, 251.98),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
		target = { 
			options = {
				{
					type = "server",
					event = "prdx_healthsystem:server:sendPlayerToHospital",
					icon = "fas fa-clipboard",
					label = "Check In (Paleto)",
				},
				{
				type = "client",
				event = "prdx_stretcher:client:checkPatientIntoHospital",
				icon = "fas fa-clipboard",
				label = "Check Patient In (Paleto)",
				job = {["ambulance"] = 0, ["clinic"] = 0}
			},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	  },
	  {-- Prison Check-in
		model = 's_f_y_scrubs_01', 
		coords = vector4(1767.97, 2571.43, 45.73, 120.69),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'CODE_HUMAN_MEDIC_TIME_OF_DEATH',
		target = { 
			options = {
				{
					type = "server",
					event = "prdx_healthsystem:server:sendPlayerToHospital",
					icon = "fas fa-clipboard",
					label = "Check In (Prison)",
				},
				{
					type = "client",
					event = "prdx_stretcher:client:checkPatientIntoHospital",
					icon = "fas fa-clipboard",
					label = "Check Patient In (Prison)",
					job = {["ambulance"] = 0, ["clinic"] = 0},
					prison = true
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	  },
	  {
		  model = 's_m_m_paramedic_01', 
		  coords = vector4(-253.58, 6338.68, 32.43, 42.15),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "ambulance:client:openGarage",
					  icon = "fas fa-car",
					  label = "Open Motorpool Paleto",
					  garage = "pillbox",
					  job = 'ambulance',
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "ambulance:client:storeVehicle",
					  icon = "fas fa-car",
					  label = "Store Vehicle Paleto",
					  garage = "pillbox",
					  job = 'ambulance',
				  },
				  {
					  num = 3,
					  type = "client",
					  event = "ambulance:client:openVehiclePurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase Vehicle Paleto",
					  garage = "pillbox",
					  job = {["ambulance"] = 4},
				  },
				  {
					type = "client",
					event = "prdx_stretcher:client:checkPatientIntoHospital",
					icon = "fas fa-clipboard",
					label = "Check Patient In (Paleto)",
					job = {["ambulance"] = 0, ["clinic"] = 0}
				},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 'A_M_Y_MethHead_01',  --house robbery--
		  coords = vector4(1394.89, 3604.69, 38.94, 155.74),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_AA_SMOKE',
		  target = { 
			  options = {
				  {
					  type = "server",
					  event = "prdx_houserobbery:server:GetJob",
					  icon = "fas fa-info-circle",
					  label = "Interact",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 'S_M_M_FIBOffice_02',  --store robbery--
		  coords = vector4(-77.51, 364.34, 112.44, 156.33),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "storerobbery:RequestMission",
					  icon = "fas fa-info-circle",
					  label = "Interact",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 'a_m_m_hillbilly_01', 
		  coords = vector4(2313.53, 4888.33, 41.81, 42.49),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = 'prdx_ranching:client:OpenCattleDealer',
					  icon = "fas fa-hat-cowboy",
					  label = "Talk to Cattle Dealer",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 'u_m_o_taphillbilly', 
		  coords = vector4(2301.31, 4935.46, 41.44, 126.61),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = 'prdx_ranching:client:OpenCattleSell',
					  icon = "fas fa-utensils",
					  label = "Talk to Butcher",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 's_m_m_strvend_01', 
		  coords = vector4(-65.81, 6506.27, 31.54, 173.38),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = 'target:client:openStash',
					  args = {'farmsell', 'farmsell'},
					  icon = "fas fa-box-open",
					  label = "Open Crop Deposit",
				  },
				  {
					  num = 2,
					  type = "client",
					  event = 'prdx_farming:client:sellStashMenu',
					  icon = "far fa-money-bill-alt",
					  label = "Sell Crops",
				  },
				  {
					  num = 3,
					  type = "client",
					  event = 'qb-shops:client:OpenDynamicShop',
					  icon = "far fa-money-bill-alt",
					  shop = 'farmsell',
					  label = "Buy Crops",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 's_m_y_factory_01', 
		  coords = vector4(-67.68, 6254.5, 30.59, 175.53),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = 'target:client:openStash',
					  args = {'ranchsell', 'ranchsell'},
					  icon = "fas fa-box-open",
					  label = "Open Meat Deposit",
				  },
				  {
					  num = 2,
					  type = "client",
					  event = 'prdx_ranching:client:sellStashMenu',
					  icon = "far fa-money-bill-alt",
					  label = "Sell Meat",
				  },
				  {
					  num = 3,
					  type = "client",
					  event = 'qb-shops:client:OpenDynamicShop',
					  icon = "far fa-money-bill-alt",
					  shop = 'ranchsell',
					  label = "Buy Meat",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  { -- GoPostal Duty Front Desk lady
		  model = 'ig_jewelass', 
		  coords = vector4(82.65, 132.84, 80.53, 68.48),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
		  target = { 
			  options = {
					{
						num = 1,
						type = "client",
						event = "prdx_gopostal:client:OpenWarehouse",
						icon = "fas fa-shop",
						label = "Buy Raw Goods",
						shop = "hq",
						maxStorage = 50,
					},	
					{
						num = 2,
						type = "server",
						event = "QBCore:jobs:ToggleDuty",
						icon = "fas fa-sign-in-alt",
						label = "Clock in at GoPostal",
						dutyJob = "gopostal",
					},	
					{
						num = 3,
						type = "server",
						event = "prdx_gopostal:server:restockOrder",
						icon = "fas fa-boxes-packing",
						label = "Report Low Stock",
						shop = "hq",
					},
					{
						num = 4,
						type = "client",
						event = "prdx_gopostal:client:spawnForklift",
						icon = "fas fa-truck-ramp-box",
						label = "Request Forklift",
						spawnlocation = 'hq',
						job = "gopostal",
					},
					{
						num = 5,
						type = "client",
						event = "prdx_bossmenu:client:openMenu",
						icon = "fas fa-users",
						label = "Boss Actions",
						job = {["gopostal"] = 3},
					},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  --Fire Station Motorpool
	  {
		  model = 's_m_y_fireman_01', 
		  coords = vector4(1194.51, -1475.7, 34.86, 325.73),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "ambulance:client:openGarage",
					  icon = "fas fa-car",
					  label = "Open Motorpool ELS",
					  garage = "pillbox",
					  job = 'ambulance',
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "ambulance:client:storeVehicle",
					  icon = "fas fa-car",
					  label = "Store Vehicle ELS",
					  garage = "pillbox",
					  job = 'ambulance',
				  },
				  {
					  num = 3,
					  type = "client",
					  event = "ambulance:client:openVehiclePurchase",
					  icon = "fas fa-shopping-cart",
					  label = "Purchase Vehicle ELS",
					  garage = "pillbox",
					  job = {["ambulance"] = 4},
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  --Fire Station Motorpool
	  {
		model = 's_m_y_fireman_01', 
		coords = vector4(187.01, -1655.41, 29.93, 142.6),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					num = 1,
					type = "client",
					event = "ambulance:client:openGarage",
					icon = "fas fa-car",
					label = "Open Motorpool WLS",
					garage = "pillbox",
					job = 'ambulance',
				},
				{
					num = 2,
					type = "client",
					event = "ambulance:client:storeVehicle",
					icon = "fas fa-car",
					label = "Store Vehicle WLS",
					garage = "pillbox",
					job = 'ambulance',
				},
				{
					num = 3,
					type = "client",
					event = "ambulance:client:openVehiclePurchase",
					icon = "fas fa-shopping-cart",
					label = "Purchase Vehicle WLS",
					garage = "pillbox",
					job = {["ambulance"] = 4},
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	  --Bank Paychecks
	  {
		  model = 'u_f_m_debbie_01', 
		  coords = vector4(248.94, 224.58, 106.03, 166.5),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "server",
					  event = "prdx_bossmenu:server:cashPaychecks",
					  icon = "fas fa-file-invoice-dollar",
					  label = "Collect Payslip",
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "prdx_bossmenu:client:depositTill",
					  icon = "fas fa-file-invoice-dollar",
					  label = "Deposit Business Till",
				  },
				  {
					  num = 3,
					  type = "server",
					  event = "prdx_bossmenu:server:openBankManager",
					  icon = "fas fa-piggy-bank",
					  label = "Manage Accounts",
				  },
			  },
			  distance = 5.0,
		  },
		  currentpednumber = 0,
	  },
	  --Business Peds (General Imports)
	  {
		  model = 's_m_m_strvend_01', 
		  coords = vector4(813.69, -2982.51, 6.02, 260.28),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = 'target:client:openShop',
					  icon = "fas fa-box-open",
					  label = "General Imports",
					  sellitems = "BusinessImports",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  --Business Peds (Seed Imports)
	  {
		  model = 's_m_m_strvend_01', 
		  coords = vector4(2224.55, 5604.85, 54.92, 101.98),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  event = 'target:client:openShop',
					  icon = "fas fa-box-open",
					  label = "Seed Imports",
					  sellitems = "SeedImports",
					  job = "smokeonthewater"
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	--Illegal Peds (Seed Imports)
	  {
		  model = 'a_m_o_acult_02', 
		  coords = vector4(713.41, 4092.39, 34.73, 182.45), --weed seller
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_STAND_FISHING',
		  target = { 
			  options = {
				  {----
					event = 'target:client:openShop',
					icon = "fas fa-box-open",
					label = "Talk",
					sellitems = "IllegalImports",
				},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },

	  --Business Peds (Arcadius)
	  {
		  model = 's_m_y_valet_01', 
		  coords = vector4(-113.41, -614.68, 36.28, 242.18),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_GUARD_STAND',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = 'prdx_jobs:arcadius:openBusinessDirectory',
					  icon = "fas fa-list-ol",
					  label = "Business Directory",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 'a_m_m_business_01', 
		  coords = vector4(-148.62, -580.56, 32.42, 157.07),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_GUARD_STAND',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = 'prdx_jobs:arcadius:openBusinessDirectory',
					  icon = "fas fa-list-ol",
					  label = "Business Directory",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  -- Bikini Vehicle Checkout
	  {
		  model = 's_m_m_gardener_01', 
		  coords = vector4(835.98, -801.29, 26.37, 1.0),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "qb-tow:client:openGarage",
					  icon = "fas fa-car",
					  label = "Open City Vehicle Garage",
					  location = "city",
					  job = "tow",
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "qb-tow:client:storeVehicle",
					  icon = "fas fa-car",
					  label = "Store Vehicle (City)",
					  job = "tow",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  {
		  model = 's_m_m_gardener_01',  --sadot harmony
		  coords = vector4(1187.81, 2637.26, 38.44, 12.36),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "qb-garages:client:OpenMenu",
					  icon = "fas fa-car-crash",
					  label = "Open Impound Depot (Sandy)",
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "qb-tow:client:openGarage",
					  icon = "fas fa-car",
					  label = "Open Sandy Vehicle Garage",
					  location = "sandy",
					  job = "tow",
				  },
				  {
					  num = 3,
					  type = "client",
					  event = "qb-tow:client:storeVehicle",
					  icon = "fas fa-car",
					  label = "Store Vehicle (Sandy)",
					  job = "tow",
				  },
				  {
					type = "server",
					event = "QBCore:jobs:ToggleDuty",
					icon = "fas fa-sign-in-alt",
					label = "Go on/off duty",
					dutyJob = "tow", 
				},
				{
					num = 5,
					type = "client",
					event = "prdx_bossmenu:client:openMenu",
					icon = "fas fa-users",
					label = "Boss Actions",
					job = {["tow"] = 6},
				},
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  -- Paleto Impound
	  {
		  model = 's_m_y_xmech_01', 
		  coords = vector4(114.76, 6631.04, 31.97, 269.79),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = "qb-garages:client:OpenMenu",
					  icon = "fas fa-car-crash",
					  label = "Open Impound Depot (Paleto)",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  -- Trucking Depot
	  {
		  model = 's_m_m_ups_02', 
		  coords = vector4(-416.67, -2763.8, 6.0, 180.87),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "prdx_trucking:openMenu",
					  icon = "fas fa-truck",
					  label = "Select Trucking Route",
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "prdx_trucking:completeRoute",
					  icon = "fas fa-check",
					  label = "Complete Trucking Delivery",
				  },
				  {
					  num = 3,
					  type = "client",
					  event = "prdx_trucking:cancelRoute",
					  icon = "fas fa-ban",
					  label = "Cancel Trucking Route",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  -- Heists
	  {
		  model = 'A_M_Y_Business_02', 
		  coords = vector4(2512.33, -449.97, 92.99, 138.92),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_AA_SMOKE',
		  target = { 
			  options = {
				  {
					  event = "RobberyCooldown:client:openMenuPublic",
					  icon = "fab fa-keycdn",
					  label = "Talk",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	-- Heists 2
	{
		model = 'u_m_m_filmdirector', 
		coords = vector4(-1009.21, -475.6, 50.03, 217.49),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'PROP_HUMAN_SEAT_CHAIR_UPRIGHT',
		scenariolower = 0.45,
		target = { 
			options = {
				{
					type = "client",
					event = "RobberyCooldown:client:openMenuPrivate",
					icon = "fab fa-keycdn",
					label = "Talk",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	  -- Mining Enter
	  {
		  model = 's_m_y_construct_01', 
		  coords = vector4(2924.14, 2740.43, 44.1, 287.71),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type="client",
					  event="prdx_mining:MineMenu",
					  icon="fas fa-hard-hat",
					  label="Talk to Mine Boss"
				  }
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  -- Mining Leave
	  {
		  model = 's_m_y_construct_02', 
		  coords = vector4(2910.72, 2736.53, 43.92, 113.47),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type="client",
					  event="prdx_mining:openMineLeave",
					  icon="fas fa-hard-hat",
					  label="Leave Mine"
				  }
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  -- Mining Sell (Ores)
	  {
		  model = 's_m_y_construct_02', 
		  coords = vector4(1085.7,-2001.04, 31.41, 323.73),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = 'prdx_mining:client:OreBuyerMenu',
					  icon = "fas fa-person-digging",
					  label = "Talk to Ore Dealer",
					  args = {'minesell', 'minesell'},
  
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  -- Mining Shop
	  {
		  model = 's_m_y_construct_01', 
		  coords = vector4(2921.16, 2648.74, 43.17, 50.1),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = 'prdx_mining:openShop',
					  icon = "fas fa-certificate",
					  label = "Mining Supplies",
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
	  -- Jewelry Sell (Gems & Jewelry)
	  {
		  model = 'u_f_y_jewelass_01', 
		  coords = vector4(-630.84, -229.79, 38.06, 205.18),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT',
		  target = { 
			  options = {
				  {
					  type = "client",
					  event = 'prdx_mining:client:JewelBuyerMenu',
					  icon = "fas fa-certificate",
					  label = "Talk to Jewel Dealer",
					  args = {'jewelsell', 'jewelsell'},
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
	  -- ELS Fire Station Heli Spawner (Replace with a non-ped in prdx points)
	  {
		  model = 'ig_sacha', 
		  coords = vector4(1191.15, -1481.08, 39.33, 103.11),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "ambulance:client:SpawnHelicopter",
					  icon = "fas fa-helicopter",
					  label = "Request Medivac",
					  garage = "pillbox",
					  job = 'ambulance',
					  args = { coords = vector4(1180.23, -1474.51, 39.14, 359.43) }
				  },
				  {
					  num = 2,
					  type = "client",
					  event = "ambulance:client:deleteHelicopter",
					  icon = "fas fa-parking",
					  label = "Store Medivac",
					  garage = "pillbox",
					  job = 'ambulance',
				  }
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
	  -- Prison Gear Buyer
	  {
		  model = 's_m_y_prisoner_01', 
		  coords = vector4(1744.63, 2537.58, 43.08, 296.93),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "prdx_prison:client:prisonBuyerMenu",
					  icon = "",
					  label = "Talk to Prisoner", 
					  args = {'jailsell', 'jailsell'},
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
	  -- Mask Shop Converter
	  {
		  model = 'u_m_m_streetart_01', 
		  coords = vector4(-1336.89, -1276.79, 4.89, 96.34),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "raid_clothes:client:buyMask",
					  icon = "fas fa-shop",
					  label = "Convert Mask ($50)", 
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
		-- Hat Shop Converter
		{
			model = 's_f_y_shop_mid', 
			coords = vector4(-1193.94, -766.94, 17.32, 216.89),
			minusOne = true, 
			freeze = true, 
			invincible = true, 
			blockevents = true,
			scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
			target = { 
				options = {
					{
						num = 1,
						type = "client",
						event = "raid_clothes:client:buyHat",
						icon = "fas fa-shop",
						label = "Convert Hat ($50)", 
					},
				},
				distance = 2.5,
			},
			currentpednumber = 0,
		},
	  -- 
	  {
		  model = 's_m_y_busboy_01', 
		  coords = vector4(-50.84, 1909.6, 195.36, 69.72),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  event = "fishing:client:FishBuyerMenu",
					  icon = "fa fa-fish",
					  label = "Talk", 
					  args = {'fishsell', 'fishsell'},
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
	  { 
		  model = 'u_f_o_prolhost_01',  --illegal fishbuyer--
		  coords = vector4(3825.9, 4446.07, 2.81, 179.63),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  event = "fishing:client:ExoticFishBuyerMenu",
					  icon = "fa fa-fish",
					  label = "Talk", 
					  args = {'exoticfishsell', 'exoticfishsell'},
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },
  
	  { 
		  model = 's_m_m_autoshop_02', 
		  coords = vector4(-616.93, -1622.77, 33.01, 1.74),
		  minusOne = true, 
		  freeze = true, 
		  invincible = true, 
		  blockevents = true,
		  scenario = 'WORLD_HUMAN_CLIPBOARD',
		  target = { 
			  options = {
				  {
					  num = 1,
					  type = "client",
					  event = "target:client:openStash",
					  icon = "fas fa-recycle",
					  label = "Open Recycle Bin", 
					  args = {'recyclesell', 'recyclesell'},
				  },
				  {
					  num = 2,
					  type = "server",
					  event = "inventory:server:sellStash",
					  icon = "fas fa-recycle",
					  label = "Recycle", 
					  args = {'recyclesell', true}, 
				  },
			  },
			  distance = 2.5,
		  },
		  currentpednumber = 0,
	  },

	{ 
		model = 'a_m_m_eastsa_02', 
		coords = vector4(-54.25, -1225.8, 28.72, 53.99),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					num = 1,
					type = "client",
					event = "prdx_storagelockers:client:openLocation",
					icon = "fas fa-warehouse",
					label = "Storage Lockers", 
					location = 'VinewoodSelfStorage',
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	{ 
		model = 'a_m_m_hasjew_01', 
		coords = vector4(148.6, 6362.49, 31.53, 117.93),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					num = 1,
					type = "client",
					event = "prdx_storagelockers:client:openLocation",
					icon = "fas fa-warehouse",
					label = "Storage Lockers", 
					location = 'PaletoSelfStorage',
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},

	-- Fir Front
	{
		model = 's_m_m_paramedic_01', 
		coords = vector4(1185.8, -1468.98, 34.36, 345.0),
		minusOne = false, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'PROP_HUMAN_SEAT_ARMCHAIR',
		scenariolower = 1.0,
		target = { 
			options = {
				{
					type = "server",
					event = "QBCore:jobs:ToggleDuty",
					icon = "fas fa-sign-in-alt",
					label = "Go on/off duty",
					dutyJob = "ambulance", -- not actual job name, allows any police job (lspd, bcso, sast, hc, marshalls)
				},	
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	{
		model = 's_m_m_paramedic_01', 
		coords = vector4(197.25, -1638.22, 29.31, 305.0),
		minusOne = false, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'PROP_HUMAN_SEAT_ARMCHAIR',
		scenariolower = 1.0,
		target = { 
			options = {
				{
					type = "server",
					event = "QBCore:jobs:ToggleDuty",
					icon = "fas fa-sign-in-alt",
					label = "Go on/off duty",
					dutyJob = "ambulance", -- not actual job name, allows any police job (lspd, bcso, sast, hc, marshalls)
				},	
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},

	-- Chopshop Ped Request
	{
		model = 'ig_moodyman_02', 
		coords = vector4(969.35, -2401.09, 22.52, 262.68),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					event = "prdx_chopshop:requestJob",
					icon = "fas fa-sign-in-alt",
					label = "Request Job",
				},	
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	-- Chopshop Ped Sell
	{
		model = 's_m_y_xmech_02', 
		coords = vector4(1524.13, 1710.53, 110.01, 262.32),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_LEANING',
		target = { 
			options = {
				{
					event = "prdx_chopshop:client:turnInCar",
					icon = "fas fa-sign-in-alt",
					label = "Complete Task",
				},	
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	-- Racers Clothes -- 
	{
		model = 'ig_talcc', 
		coords = vector4(960.08, -2390.63, 22.32, 22.25),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_WINDOW_SHOP_BROWSE',
		scenariolower = 1.0,
		target = { 
			options = {
				{
					event = "raid_clothes:outfitsMenu",
					icon = "fas fa-tshirt",
					label = "Change Outfits",
				},	
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	-- Boat Impound
	{
		model = 's_m_y_xmech_01', 
		coords = vector4(-999.68, -1408.77, 1.6, 52.75),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					event = "qb-garages:client:OpenMenu",
					icon = "fas fa-car-crash",
					label = "Open Impound Depot (Boat)",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	-- Air Impound
	{
		model = 's_m_y_xmech_01', 
		coords = vector4(-1242.33, -3393.07, 13.94, 55.2),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					event = "qb-garages:client:OpenMenu",
					icon = "fas fa-car-crash",
					label = "Open Impound Depot (Air)",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	-- Small Missions
	{
		model = 'ig_mp_agent14', 
		coords = vector4(327.52, -176.24, 58.65, 251.33),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_LEANING',
		target = { 
			options = {
				{
					event = "prdx_smallmissions:client:OpenMenu",
					icon = "fas fa-question",
					label = "Talk",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	-- Trailer Rentals
	{
		model = 'a_m_y_indian_01', 
		coords = vector4(-342.16, 6065.66, 31.51, 317.27),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					event = "prdx_trailers:client:OpenTrailerMenu",
					icon = "fas fa-trailer",
					label = "Rent Trailer",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	{
		model = 'a_m_y_bevhills_02', 
		coords = vector4(346.58, 3406.14, 36.49, 27.41),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					event = "prdx_trailers:client:OpenTrailerMenu",
					icon = "fas fa-trailer",
					label = "Rent Trailer",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	{
		model = 'a_m_y_clubcust_01', 
		coords = vector4(914.06, -1273.45, 27.1, 46.71),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					event = "prdx_trailers:client:OpenTrailerMenu",
					icon = "fas fa-trailer",
					label = "Rent Trailer",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	{
		model = 'a_m_y_clubcust_02', 
		coords = vector4(51.44, 109.96, 79.16, 201.95),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					event = "prdx_trailers:client:OpenTrailerMenu",
					icon = "fas fa-trailer",
					label = "Rent Trailer",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	-- Go Postal LSIA --
	{
		model = 's_m_m_postal_02', 
		coords = vector4(-1239.88, -2357.15, 14.1, 326.32),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					num = 1,
					event = "prdx_gopostal:client:spawnPalletMenu",
					icon = "fas fa-truck-ramp-box",
					label = "Request Delivery Pallets",
					pickuplocation = 'lsia',
					job = "gopostal",
				},
				{
					num = 2,
					event = "prdx_gopostal:client:spawnForklift",
					icon = "fas fa-truck-ramp-box",
					label = "Request Forklift",
					spawnlocation = 'lsia',
					job = "gopostal",
				},
				{
					num = 3,
					event = "prdx_trailers:client:OpenTrailerMenu",
					icon = "fas fa-trailer",
					label = "Rent Trailer",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	{
		model = 'a_m_y_vinewood_02', 
		coords = vector4(1717.45, 4792.02, 41.98, 275.55),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					serverEvent = "JakeFun:server:greenKeycard",
					icon = "fas fa-key",
					label = "Talk",
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
	{ 
		model = 's_m_m_autoshop_01', 
		coords = vector4(-184.41, 6271.15, 31.68, 43.79),
		minusOne = true, 
		freeze = true, 
		invincible = true, 
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = { 
			options = {
				{
					num = 1,
					type = "client",
					event = "target:client:openStash",
					icon = "fas fa-recycle",
					label = "Open Recycle Bin", 
					args = {'recyclesell', 'recyclesell'},
				},
				{
					num = 2,
					type = "server",
					event = "inventory:server:sellStash",
					icon = "fas fa-recycle",
					label = "Recycle", 
					args = {'recyclesell', true}, 
				},
			},
			distance = 2.5,
		},
		currentpednumber = 0,
	},
}