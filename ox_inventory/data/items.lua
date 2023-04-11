return {
	['10kgoldchain'] = {
		label = '10k Gold Chain',
		weight = 2000,
		stack = true,
		close = true,
		description = "10 carat golden chain"
	},

	['food_voucher'] = {
		label = 'Food Voucher',
		weight = 100,
		stack = true,
		close = true,
		description = "Good For One Food Basket From A Local Business. Provided By Your Local Government. Welcome To Our Beautiful City!"
	},

	['2021christmascoin'] = {
		label = '2021 Christmas Coin',
		weight = 2500,
		stack = true,
		close = false,
		description = "2021 Christmas Commemorative Coin, only obtained on 12/25/2021"
	},

	['2022_snowglobe'] = {
		label = 'SnowGlobe',
		weight = 2500,
		stack = true,
		close = false,
		description = "LIMITED EDITION SNOWGLOBE 2022 Christmas"
	},

	['2022aprilfoolscoin'] = {
		label = 'ParaCoin',
		weight = 2500,
		stack = true,
		close = false,
		description = "LIMITED EDITION ParaCoin only available on 4/1/2022"
	},

	['2023aprilfoolsmoney'] = {
		label = 'Paramopoly Money',
		weight = 2500,
		stack = true,
		close = false,
		description = "LIMITED EDITION Paramopoly Money only available on 4/1/2023"
	},

	['2022christmascoin'] = {
		label = '2022 Christmas Coin',
		weight = 2500,
		stack = true,
		close = false,
		description = "2022 Christmas Commemorative Coin, only obtained on 12/25/2022"
	},

	['acetone'] = {
		label = 'Acetone',
		weight = 500,
		stack = true,
		close = true,
		description = "Jug of acetone"
	},

	['advancedlockpick'] = {
		label = 'Advanced Lockpick',
		weight = 1500,
		stack = false,
		close = true,
		description = "If you lose your keys a lot this is very useful... Also useful to open your beers"
	},

	['advancedrepairkit'] = {
		label = 'Advanced Repairkit',
		weight = 7000,
		stack = false,
		close = true,
		description = "nice toolbox with stuff to repair your vehicle"
	},

	['advguncleaningkit'] = {
		label = 'Military Gun Cleaning Kit',
		weight = 10000,
		stack = false,
		close = true,
		description = "Marked: Property of US Army | Kit containing tools to clean large weapons"
	},

	['aluminum'] = {
		label = 'Aluminium',
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something"
	},

	['aluminumore'] = {
		label = 'Bauxite Ore',
		weight = 1000,
		stack = true,
		close = false,
		description = "Aluminum, a base ore."
	},

	['aluminumoxide'] = {
		label = 'Aluminium Powder',
		weight = 100,
		stack = true,
		close = false,
		description = "Some powder to mix with"
	},

	['animalcarcassa'] = {
		label = 'Animal Carcass',
		weight = 1000,
		stack = true,
		close = true,
		description = "High quality animal carcass"
	},

	['animalcarcassb'] = {
		label = 'Animal Carcass',
		weight = 1000,
		stack = true,
		close = true,
		description = "Average quality animal carcass"
	},

	['animalcarcassc'] = {
		label = 'Animal Carcass',
		weight = 1000,
		stack = true,
		close = true,
		description = "Low quality animal carcass"
	},

	['animalcarcasss'] = {
		label = 'Animal Carcass',
		weight = 1500,
		stack = true,
		close = true,
		description = "Extremely high quality animal carcass"
	},

	['antipatharia_coral'] = {
		label = 'Antipatharia',
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as black corals or thorn corals"
	},

	['armor'] = {
		label = 'Armor',
		weight = 5000,
		stack = true,
		close = true,
		description = "Level II-A Lightweight Armor"
	},

	['art'] = {
		label = 'Art',
		weight = 1000,
		stack = true,
		close = false,
		description = "Precious art work"
	},

	['atm_usb'] = {
		label = 'USB Drive (A)',
		weight = 1000,
		stack = false,
		close = true,
		description = "USB Device with encrypted files"
	},

	['baking_soda'] = {
		label = 'Baking Soda',
		weight = 500,
		stack = true,
		close = true,
		description = "Box of baking soda"
	},
	
	['bank_drill'] = {
		label = 'Metal Drill',
		weight = 7000,
		stack = true,
		close = false,
		description = "A large drill with a 2 inch chuck. Usually used in metalwork"
	},

	['bankroll'] = {
		label = 'Bank Roll',
		weight = 1000,
		stack = true,
		close = true,
		description = "Roll of non-sequencial bills"
	},

	['bass'] = {
		label = 'Bass',
		weight = 1250,
		stack = true,
		close = false,
		description = "A normal fish Tatses pretty good!"
	},

	['beer'] = {
		label = 'Pibwasser Beer',
		description = "Cheap water downed beer",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 20,}, time = 10, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Beer
			prop = {
				model = 'prop_cs_beer_bot_01',
				bone = 57005,
				pos = {x = 0.12, y = -0.02, z = -0.04},
				rot = {x = -88.0, y = 146.0, z = 10.0},
			},
			usetime = 5000,
		},
	},

	['bikelock'] = {
		label = 'Bicycle Lock',
		weight = 500,
		stack = false,
		close = true,
		description = "Someone call for the Lockpicking Lawyer?"
	},

	['billet_camshaft'] = {
		label = 'Billet Camshaft',
		weight = 2000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['billet_crankshaft'] = {
		label = 'Billet Crankshaft',
		weight = 2000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['billet_cylinderhead'] = {
		label = 'Billet Cylinder Head',
		weight = 5000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['billet_engineblock'] = {
		label = 'Billet Engine Block',
		weight = 11000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['billet_exhaustmanifold'] = {
		label = 'Billet Exhaust Manifold',
		weight = 4000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['billet_fuelsystem'] = {
		label = 'High-Flow Fuel Rails',
		weight = 3000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['billet_intakemanifold'] = {
		label = 'Billet Intake Manifold',
		weight = 4000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['billet_pistons'] = {
		label = 'Billet Pistons',
		weight = 8000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['binoculars'] = {
		label = 'Binoculars',
		weight = 1000,
		stack = true,
		close = true,
		description = "Sneaky Breaky..."
	},

	['blueprint'] = {
		label = 'Blueprint',
		weight = 100,
		stack = false,
		close = true,
		description = "Instructions on how to make something"
	},
	
	['book'] = {
		label = 'Book',
		weight = 1000,
		stack = false,
		close = true,
		description = "Just a book 4 head"
	},

	
	['bookbag'] = {
		label = 'Bookbag',
		weight = 1000,
		stack = false,
		close = true,
		description = "A nice bag to store all your books!"
	},

	['bottle'] = {
		label = 'Bottle (S)',
		weight = 1000,
		stack = true,
		close = true,
		description = "Maybe this could be broken into glass!"
	},
	
	['breaching_charge'] = {
		label = 'Breaching Charge',
		weight = 7500,
		stack = true,
		close = true,
		description = "Breaching charges for doors | For official police use only"
	},

	['bunker_card'] = {
		label = 'Unlabeled Security Card',
		weight = 100,
		stack = false,
		close = true,
		description = "A blank high tech security card"
	},

	['business_till'] = {
		label = 'Register Till',
		weight = 100,
		stack = false,
		close = true,
		description = "Piece of paper"
	},

	['butter'] = {
		label = 'Stick of Butter',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['camshaft'] = {
		label = 'Camshaft',
		weight = 1000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['car_bomb'] = {
		label = 'Car Bomb',
		weight = 15000,
		stack = false,
		close = true,
		description = "Ever seen the movie speed? | MARKED FOR POLICE SEIZURE"
	},

	['carbon'] = {
		label = 'Carbon',
		weight = 100,
		stack = true,
		close = false,
		description = "Carbon, a base ore."
	},

	['carparts'] = {
		label = 'Car Parts',
		weight = 1000,
		stack = true,
		close = false,
		description = "Various parts with serial numbers scratched | MARKED FOR POLICE SEIZURE"
	},

	['carrot'] = {
		label = 'Carrot',
		weight = 1000,
		stack = true,
		close = true,
		description = "Bojack's favorite treat"
	},

	['carrot_seed'] = {
		label = 'Carrot Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a carrot plant"
	},

	['hops'] = {
		label = 'Hops',
		weight = 1000,
		stack = true,
		close = true,
		description = "Used in crafting Alcohol"
	},

	['hops_seed'] = {
		label = 'Hops Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a hops plant"
	},

	['tobacco_seed'] = {
		label = 'Tobacco Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a hops plant"
	},

	['casinochips'] = {
		label = 'Casino Chips',
		weight = 0,
		stack = true,
		close = false,
		description = "Chips For Casino Gambling"
	},

	['cattle_feed'] = {
		label = 'Animal Feed',
		weight = 5000,
		stack = false,
		close = true,
		description = "Feed for animals"
	},

	['certificate'] = {
		label = 'Certificate',
		weight = 0,
		stack = true,
		close = true,
		description = "Certificate that proves you own certain stuff"
	},

	['cheese'] = {
		label = 'Cheese',
		weight = 1000,
		stack = true,
		close = true,
		description = "Shred it or slice it"
	},
	
	['chlorine_tablet'] = {
		label = 'Chlorine Tablets',
		weight = 100,
		stack = true,
		close = true,
		description = "Chlorine Tablets, commonly known as \"Water Purification Tablets\", are used to disinfect unclean water"
	},

	['chocolate'] = {
		label = 'Raw Cocoa Mass',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['cleaningkit'] = {
		label = 'Cleaning Kit',
		weight = 1250,
		stack = false,
		close = true,
		description = "microfiber cloth with some soap will let your car sparkle again!"
	},

	['codfish'] = {
		label = 'Cod',
		weight = 2500,
		stack = true,
		close = false,
		description = "Cod"
	},

	['coffee'] = {
		label = 'Coffee',
		description = "Pump 4 Caffeine",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 20,}, time = 10},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'p_ing_coffeecup_02',
				bone = 57005,
				pos = {x = 0.13, y = -0.05, z = -0.05},
				rot = {x = 84.0, y = 27.0, z = 185.0},
			},
			usetime = 5000,
		},
	},

	['coffee_grounds'] = {
		label = 'Coffee Grounds',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['coffeemaker'] = {
		label = 'Coffee Maker',
		weight = 5000,
		stack = true,
		close = false,
		description = "Coffee Maker... it makes coffee"
	},

	['coke_brick'] = {
		label = 'Cocaine Brick',
		weight = 10000,
		stack = true,
		close = true,
		description = "Heavy package of cocaine, mostly used for deals and takes a lot of space"
	},

	['coke_leaves'] = {
		label = 'Coca Plant Leaves',
		weight = 1000,
		stack = false,
		close = true,
		description = "Coca plant leaves"
	},

	['coke_paste'] = {
		label = 'Cocaine Paste',
		weight = 1000,
		stack = true,
		close = true,
		description = "Slurry of ground up coca leaves and other chemicals"
	},

	['coke_seed'] = {
		label = 'Coca Seed',
		weight = 100,
		stack = true,
		close = true,
		description = "Coca plant seed"
	},

	['coke_small_brick'] = {
		label = 'Coke Package',
		weight = 1000,
		stack = false,
		close = true,
		description = "Small package of cocaine, mostly used for deals and takes a lot of space"
	},

	['coke_table'] = {
		label = 'Cocaine Table',
		weight = 5000,
		stack = false,
		close = true,
		description = "A fold-out table with scales and powder residue"
	},

	['cokebaggy'] = {
		label = 'Bag of Cocaine',
		weight = 100,
		stack = true,
		close = true,
		description = "To get happy real quick"
	},

	['copper'] = {
		label = 'Copper',
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something"
	},

	['copperore'] = {
		label = 'Copper Ore',
		weight = 1000,
		stack = true,
		close = false,
		description = "Copper, a base ore."
	},

	['corn_seed'] = {
		label = 'Corn Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a corn plant"
	},

	['crack_baggy'] = {
		label = 'Bag of Crack',
		weight = 100,
		stack = true,
		close = true,
		description = "Crack Cocaine"
	},

	['crack_brick'] = {
		label = 'Crack Brick',
		weight = 100,
		stack = true,
		close = false,
		description = "Dry brick of pure crack cocaine"
	},

	['crack_paste'] = {
		label = 'Crack Paste',
		weight = 100,
		stack = true,
		close = false,
		description = "A mix of cocaine, water, and baking soda"
	},

	['crankshaft'] = {
		label = 'Crankshaft',
		weight = 1000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['crim_usb_lvl1'] = {
		label = 'Gray USB Drive',
		weight = 100,
		stack = false,
		close = false,
		description = "USB Device with encrypted files"
	},

	['crim_usb_lvl2'] = {
		label = 'Green USB Drive ',
		weight = 100,
		stack = false,
		close = false,
		description = "USB Device with encrypted files"
	},

	['crim_usb_lvl3'] = {
		label = 'Blue USB Drive ',
		weight = 100,
		stack = false,
		close = false,
		description = "USB Device with encrypted files"
	},

	['cryptostick'] = {
		label = 'PRDX Stick',
		weight = 200,
		stack = false,
		close = true,
		description = "Why would someone ever buy money that doesn't exist.. How many would it contain..?"
	},
	
	['cylinderhead'] = {
		label = 'Cylinder Head',
		weight = 4000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['dendrogyra_coral'] = {
		label = 'Dendrogyra',
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as pillar coral"
	},

	['diamond'] = {
		label = 'Diamond',
		weight = 100,
		stack = true,
		close = false,
		description = "A Diamond that shimmers"
	},

	['diamond_necklace'] = {
		label = 'Diamond Necklace',
		weight = 1000,
		stack = true,
		close = false,
		description = "A diamond necklace seems like the jackpot to me!"
	},

	['diamond_ring'] = {
		label = 'Diamond Ring',
		weight = 1000,
		stack = true,
		close = false,
		description = "A diamond ring seems like the jackpot to me!"
	},

	['dirty_bomb'] = {
		label = 'Mr. Raspberry Jam',
		weight = 15000,
		stack = false,
		close = true,
		description = "He just wants a hug..."
	},
	
	['dirty_water_bottle'] = {
		label = 'Bottle of Dirty Water',
		weight = 1000,
		stack = true,
		close = true,
		description = "Looks a bit merky..."
	},

	['diving_gear'] = {
		label = 'Diving Gear',
		weight = 30000,
		stack = false,
		close = true,
		description = "Oxygen tank and a rebreather"
	},

	['dnatestingkit'] = {
		label = 'DNA Testing Kit',
		weight = 1000,
		stack = false,
		close = true,
		description = "Swab kit for DNA | For official police use only"
	},

	['dog_treats'] = {
		label = 'Scooby Snacks',
		description = "K9 Dog Treats",
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = {effects = {stamina = 5, speed = 1.49},  time = 60},
			anim = {dict = "mp_player_inteat@burger", clip = 'mp_player_int_eat_burger'},  
			prop = {
				model = 'prop_cs_hotdog_01',
				bone = 18905,
				pos = {x = 0.13, y = 0.01, z = 0.04},
				rot = {x = -148.0, y = 308.0, z = 184.0},
			},
			usetime = 500,
		},
	},

	['dolphin'] = {
		label = 'Dolphin',
		weight = 5000,
		stack = false,
		close = false,
		description = "Dolphin | MARKED FOR POLICE SEIZURE"
	},

	['dough'] = {
		label = 'Dough',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['drag_till'] = {
		label = 'Drag Slip',
		weight = 100,
		stack = false,
		close = true,
		description = "Piece of paper"
	},

	['drill'] = {
		label = 'Stone Drill',
		weight = 7000,
		stack = true,
		close = false,
		description = "A large drill with a 2 inch chuck. Usually used in mining"
	},

	['drillbit'] = {
		label = 'Drill Bit',
		weight = 100,
		stack = true,
		close = false,
		description = "A drill bit"
	},

	['drillbit_steel'] = {
		label = 'Steel Dremmel Bit',
		weight = 100,
		stack = true,
		close = false,
		description = "A Dremmel bit, needs to be used with a Dremmel"
	},

	['driver_license'] = {
		label = 'Drivers License',
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can drive a vehicle"
	},

	['dry_coke'] = {
		label = 'Cured Coca Leaves',
		weight = 500,
		stack = true,
		close = true,
		description = "Dried coca plant leaves, faint smell of gasoline"
	},

	['dry_weed'] = {
		label = 'Dried Marijuana Buds',
		weight = 500,
		stack = true,
		close = true,
		description = "Buds of unknown strain of marijuana"
	},

	['egg'] = {
		label = 'Egg',
		weight = 1000,
		stack = true,
		close = true,
		description = "Splat"
	},

	['electronickit'] = {
		label = 'Electronic Kit',
		weight = 1000,
		stack = true,
		close = true,
		description = "Basic circuit board used in many electronics"
	},

	['electronickit_b'] = {
		label = 'Advanced Electronic Kit',
		weight = 1000,
		stack = true,
		close = true,
		description = "Advanced circuit board used in many electronics"
	},

	['electronickit_c'] = {
		label = 'Professional Electronic Kit',
		weight = 1000,
		stack = true,
		close = true,
		description = "Professional grade circuit board found in only rare industrial equipment"
	},

	['emerald'] = {
		label = 'Emerald',
		weight = 100,
		stack = true,
		close = false,
		description = "A Emerald that shimmers"
	},

	['emerald_necklace'] = {
		label = 'Emerald Necklace',
		weight = 1000,
		stack = true,
		close = false,
		description = "A emerald necklace seems like the jackpot to me!"
	},

	['emerald_ring'] = {
		label = 'Emerald Ring',
		weight = 1000,
		stack = true,
		close = false,
		description = "A emerald ring seems like the jackpot to me!"
	},

	['empty_evidence_bag'] = {
		label = 'Empty Evidence Bag',
		weight = 100,
		stack = true,
		close = false,
		description = "Used a lot to keep DNA from blood, bullet shells and more | For official police use only"
	},

	['empty_water_bottle'] = {
		label = 'Empty Waterbottle',
		weight = 500,
		stack = true,
		close = true,
		description = "Empty plastic bottle"
	},

	['empty_weed_bag'] = {
		label = 'Empty Plastic Bag',
		weight = 100,
		stack = true,
		close = true,
		description = "small empty bag"
	},

	['engineblock'] = {
		label = 'Engine Block',
		weight = 10000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['exhaustmanifold'] = {
		label = 'Exhaust Manifold',
		weight = 3000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['extendedclip'] = {
		label = 'Extended Magazine',
		weight = 1000,
		stack = true,
		close = true,
		description = "Extended magazine"
	},

	['filled_evidence_bag'] = {
		label = 'Filled Evidence Bag',
		weight = 1000,
		stack = false,
		close = false,
		description = "A filled evience bag with case information written down | For official police use only",
		buttons = {
			{
				label = "Copy evidence data",
				action = function(slot)
					TriggerServerEvent('qb-policejob:server:copyData', slot)
				end
			}
		}
	},

	['firstaid'] = {
		label = 'First Aid Kit',
		weight = 1000,
		stack = true,
		close = true,
		description = "You can use this First Aid kit to get people back on their feet"
	},

	['fishbait'] = {
		label = 'Fish Bait',
		weight = 400,
		stack = true,
		close = true,
		description = "Fishing bait"
	},

	['fishicebox'] = {
		label = 'Fishing Ice Chest',
		weight = 1000,
		stack = false,
		close = false,
		description = "Ice Box to store all of your fish"
	},

	['fishingboot'] = {
		label = 'Fishing Boot',
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Boot"
	},

	['fishingkey'] = {
		label = 'Corroded Key',
		weight = 100,
		stack = true,
		close = true,
		description = "A weathered key that looks usefull"
	},

	['fishingloot'] = {
		label = 'Metal Box',
		weight = 500,
		stack = true,
		close = true,
		description = "Seems to be a corroded from the salt water, Should be easy to open"
	},

	['fishinglootbig'] = {
		label = 'Treasure Chest',
		weight = 2500,
		stack = true,
		close = true,
		description = "The lock seems to be intact, Might need a key"
	},

	['fishingrod'] = {
		label = 'Fishing Rod',
		weight = 750,
		stack = true,
		close = true,
		description = "A fishing rod for adventures with friends!!"
	},

	['fishingtin'] = {
		label = 'Fishing Tin',
		weight = 2500,
		stack = true,
		close = false,
		description = "Fishing Tin"
	},

	['fishtacklebox'] = {
		label = 'Tackle Box',
		weight = 1000,
		stack = true,
		close = true,
		description = "Seems to be left over tackle box from another fisherman"
	},

	['fleeca_data'] = {
		label = 'Security System Data',
		weight = 1000,
		stack = false,
		close = true,
		description = "Security system data | MARKED FOR POLICE SEIZURE"
	},

	['flounder'] = {
		label = 'Flounder',
		weight = 2500,
		stack = true,
		close = false,
		description = "Flounder"
	},

	['flour'] = {
		label = 'Flour',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['fresh_fruits'] = {
		label = 'Fresh Fruit',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['fuelsystem'] = {
		label = 'Fuel Rails',
		weight = 2000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['garlic'] = {
		label = 'Garlic',
		weight = 1000,
		stack = true,
		close = true,
		description = "Vampires beware"
	},

	['garlic_seed'] = {
		label = 'Garlic Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a garlic plant"
	},

	['gas_mask'] = {
		label = 'Gas Mask',
		weight = 5000,
		stack = false,
		close = true,
		description = "Military grade respirator"
	},

	['gatecrack'] = {
		label = 'Gatecrack',
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to tear down some fences"
	},

	['glass'] = {
		label = 'Glass',
		weight = 100,
		stack = true,
		close = false,
		description = "It is very fragile, watch out"
	},
	
	['gold_ring'] = {
		label = 'Gold Ring',
		weight = 1000,
		stack = true,
		close = false,
		description = "A gold ring seems like the jackpot to me!"
	},

	['goldbar'] = {
		label = 'Small Gold Bar',
		weight = 1000,
		stack = true,
		close = true,
		description = "Smelted bar of gold"
	},

	['goldchain'] = {
		label = 'Golden Chain',
		weight = 1500,
		stack = true,
		close = true,
		description = "golden chain seems like the jackpot to me!"
	},

	['goldore'] = {
		label = 'Gold Ore',
		weight = 1000,
		stack = true,
		close = false,
		description = "Gold Ore, a base ore."
	},

	['gpsdisabler'] = {
		label = 'GPS Disabler',
		weight = 2000,
		stack = false,
		close = true,
		description = "A thingie-madoo-hicky | MARKED FOR POLICE SEIZURE"
	},

	['grape'] = {
		label = 'Grape',
		weight = 1000,
		stack = true,
		close = false,
		description = "Mmmmh yummie, grapes"
	},

	['grapejuice'] = {
		label = 'Grape Juice',
		weight = 1000,
		stack = true,
		close = false,
		description = "Grape juice is said to be healthy"
	},

	['green_card'] = {
		label = 'Green Keycard',
		weight = 100,
		stack = false,
		close = false,
		description = "A green security keycard"
	},

	['green_cdrom'] = {
		label = 'Green CD-ROM',
		weight = 100,
		stack = false,
		close = false,
		description = "or internal LifeInvader use only"
	},

	['guncleaningkit'] = {
		label = 'Gun Cleaning Kit',
		weight = 10000,
		stack = false,
		close = true,
		description = "A wooden case containing tools to clean small weapons"
	},

	['handcuffs'] = {
		label = 'Handcuffs',
		weight = 1000,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else? | For official police use only"
	},

	['handdrill'] = {
		label = 'Dremmel',
		weight = 1000,
		stack = false,
		close = false,
		description = "A Dremmel tool, can be used for fine cutting"
	},

	['harness'] = {
		label = 'Race Harness',
		weight = 2000,
		stack = false,
		close = true,
		description = "Racing Harness so no matter what you stay in the car"
	},

	['heavyarmor'] = {
		label = 'Heavy Armor',
		weight = 5000,
		stack = true,
		close = true,
		description = "Level III-A Heavy Armor"
	},
	
	['humaneye'] = {
		label = 'Human Eyeball',
		weight = 1000,
		stack = false,
		close = true,
		description = "A human eyeball"
	},

	['huntingbait'] = {
		label = 'Hunting Bait',
		weight = 1000,
		stack = false,
		close = true,
		description = "Bait for hunting"
	},

	['huntingknife'] = {
		label = 'Hunting Knife',
		weight = 2000,
		stack = false,
		close = true,
		description = "Hunting Knife."
	},

	['ice_cream'] = {
		label = 'Ice Cream',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},
	
	['id_card'] = {
		label = 'ID Card',
		weight = 0,
		stack = false,
		close = false,
		description = "card containing all your information to identify yourself"
	},

	['ifak'] = {
		label = 'IFAK',
		weight = 1000,
		stack = false,
		close = true,
		description = "Individual First Aid Kit"
	},

	['itk'] = {
		label = 'ITK',
		weight = 2000,
		stack = false,
		close = true,
		description = "An Individual Trauma Kit containing illegal medical items"
	},

	['intakemanifold'] = {
		label = 'Intake Manifold',
		weight = 3000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['iron'] = {
		label = 'Iron',
		weight = 100,
		stack = true,
		close = false,
		description = "Handy piece of metal that you can probably use for something"
	},

	['ironore'] = {
		label = 'Iron Ore',
		weight = 1000,
		stack = true,
		close = false,
		description = "Iron, a base ore."
	},

	['ironoxide'] = {
		label = 'Iron Powder',
		weight = 100,
		stack = true,
		close = false,
		description = "Some powder to mix with."
	},

	['joint'] = {
		label = 'Joint',
		weight = 100,
		stack = true,
		close = true,
		description = "Sidney would be very proud at you"
	},
	
	['key_judge'] = {
		label = 'Key',
		weight = 1000,
		stack = true,
		close = true,
		description = "A key to a door..."
	},

	['killerwhale'] = {
		label = 'Whale',
		weight = 15000,
		stack = false,
		close = false,
		description = "Killer Whale | MARKED FOR POLICE SEIZURE"
	},

	['knifesharpeningkit'] = {
		label = 'Knife Sharpening Kit',
		weight = 10000,
		stack = false,
		close = true,
		description = "A kit containing tools to sharpen blades and pointy weapons"
	},

	['kurkakola'] = {
		label = 'eCola',
		description = "For all the thirsty out there",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 20,}, time = 10,},
			anim = {dict = "mp_player_inteat@pnq", clip = "loop"},  --Drink can
			prop = {
				model = 'prop_ecola_can',
				bone = 18905,
				pos = {x = 0.12, y = 0.0, z = 0.04},
				rot = {x = -88.0, y = 146.0, z = 10.0},
			},
			usetime = 5000,
		},
	},

	['sprunk'] = {
		label = 'Sprunk',
		description = "For all the thirsty out there",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 20,}, time = 10,},
			anim = {dict = "mp_player_inteat@pnq", clip = "loop"},  --Drink can
			prop = {
				model = 'v_res_tt_can03',
				bone = 18905,
				pos = {x = 0.12, y = 0.0, z = 0.04},
				rot = {x = -88.0, y = 146.0, z = 10.0},
			},
			usetime = 5000,
		},
	},

	['cereal'] = {
		label = 'Happy-Os Cereal', 
		description = "Big bowl of cereal to make you happy!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 20, water = 20}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --eat bowl one--
			prop = {
				{
					model = 'prop_cs_bowl_01',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'scully_spoon_pho',
					bone = 28422,
					pos = {x = 0.00, y = 0.00, z = 0.0},
					rot = {x = 0.0, y = 0.0, z = 0.0},
				}
			},
			usetime = 15000,
		},
	},

	['juicebox'] = {
		label = 'Juicebox', 
		description = "Juice in a box",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 15,}, time = 15},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'h4_prop_battle_coconutdrink_01a',
				bone = 57005,
				pos = {x = 0.13, y = 0.03, z = -0.04},
				rot = {x = 91.0, y = -56.0, z = 155.0},
			},
			usetime = 5000,
		},	
	},

	['bs_burger'] = {   --temp food items to help a small business
		label = 'Burger', 
		description = "Burgershot Burger",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 55}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},
			prop = {
					model = 'prop_cs_burger_01',
					bone = 18905,
					pos = {x = 0.11, y = 0.03, z = 0.03},
					rot = {x = -10.0, y = -39.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['bs_chickenwrap'] = { --temp food items to help a small business
		label = 'Chicken Wrap', 
		description = "Burgershot chicken wrap",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 20,}, time = 10,},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Drink can
			prop = {
				model = 'prop_sandwich_01',
				bone = 18905,
				pos = {x = 0.12, y = 0.02, z = 0.01},
				rot = {x = -88.0, y = 62.0, z = -130.0},
			},
			usetime = 5000,
		},
	},

	['bs_drink'] = { --temp food items to help a small business
		label = 'Burgershot Cola', 
		description = "Litter of cola",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {water = 20}, time = 15},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Eat Plate Fast--
			prop = {
				{
					model = 'prop_cs_bs_cup',
					bone = 57005,
					pos = {x = 0.12, y = -0.02, z = -0.04},
					rot = {x = 80.0, y = -27.0, z = 157.0},
				},
			},
			usetime = 5000,
		},
	},
	
	['bs_fries'] = { --temp food items to help a small business
		label = 'Fries', 
		description = "Fries or Chips?",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 30}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = 'mp_player_int_eat_burger'}, 
			prop = {
				{
					model = 'prop_food_bs_chips',
					bone = 18905,
					pos = {x = 0.11, y = -0.02, z = 0.0},
					rot = {x = 96.0, y = -21.0, z = 165.0},
				},
			},
			usetime = 5000,
		},
	},

	['bs_heartstopper'] = { --temp food items to help a small business
		label = 'The Heartstopper', 
		description = "So much greese it will stop your heart",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 30}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},
			prop = {
					model = 'prop_cs_burger_01',
					bone = 18905,
					pos = {x = 0.11, y = 0.03, z = 0.03},
					rot = {x = -10.0, y = -39.0, z = 6.0},
			},
			usetime = 5000,
		},
	},


	['labkey'] = {
		label = 'Key',
		weight = 1000,
		stack = false,
		close = true,
		description = "Key for a lock...?"
	},

	['laptop'] = {
		label = 'Laptop',
		weight = 5000,
		stack = true,
		close = true,
		description = "Expensive laptop"
	},

	['laptop_blue'] = {
		label = 'Blue Laptop',
		weight = 15000,
		stack = false,
		close = true,
		degrade = 120, -- 2 hours
		description = "Laptop with weird software"
	},

	['laptop_gold'] = {
		label = 'Gold Laptop',
		weight = 15000,
		stack = false,
		close = true,
		degrade = 120, -- 2 hours
		description = "Laptop with weird software"
	},

	['laptop_green'] = {
		label = 'Green Laptop',
		weight = 15000,
		stack = false,
		close = true,
		degrade = 120, -- 2 hours
		description = "Laptop with weird software"
	},

	['laptop_pink'] = {
		label = 'Pink Laptop',
		weight = 15000,
		stack = false,
		close = true,
		description = "Laptop with weird software"
	},

	['laptop_red'] = {
		label = 'Red Laptop',
		weight = 15000,
		stack = false,
		close = true,
		degrade = 120, -- 2 hours
		description = "Laptop with weird software"
	},

	['large_goldbar'] = {
		label = 'Large Gold Bar',
		weight = 5000,
		stack = true,
		close = true,
		description = "Large and heavy gold bar stamped with union depostiory seal"
	},

	['largeinkedbag'] = {
		label = 'Large Inked Duffel Bag',
		weight = 10000,
		stack = true,
		close = false,
		description = "Large duffel bag of inked money"
	},

	['lawyer_license'] = {
		label = 'Lawyer License',
		weight = 0,
		stack = false,
		close = false,
		description = "license proving passing of bar exam and right to practice law"
	},

	['lettuce'] = {
		label = 'Lettuce',
		weight = 1000,
		stack = true,
		close = true,
		description = "That healthy green leaf"
	},

	['lettuce_seed'] = {
		label = 'Lettuce Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a lettuce plant"
	},

	['lighter'] = {
		label = 'Lighter',
		weight = 0,
		stack = true,
		close = true,
		description = "On new years eve a nice fire to stand next to"
	},

	['lime'] = {
		label = 'Powder Cleaner',
		weight = 500,
		stack = true,
		close = true,
		description = "Box of lime"
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 1000,
		stack = false,
		close = true,
		description = "Very useful if you lose your keys a lot.. or if you want to use it for something else..."
	},

	['mackerel'] = {
		label = 'Mackerel',
		weight = 2500,
		stack = true,
		close = false,
		description = "Mackerel"
	},
	
	['markedbills'] = {
		label = 'Inked Money Bag',
		weight = 2000,
		stack = true,
		close = false,
		description = "Small bag of inked money"
	},

	['medinkedbag'] = {
		label = 'Inked Duffel Bag',
		weight = 5000,
		stack = true,
		close = false,
		description = "Duffel bag of inked money"
	},

	['megaphone'] = {
		label = 'Megaphone',
		weight = 5000,
		stack = false,
		close = false,
		description = "A loudspeaker to yell at civilians | For official use only"
	},

	['metaldetector'] = {
		label = 'Metal Detector',
		weight = 5000,
		stack = false,
		close = true,
		description = "Usefull for finding stuff in the ground."
	},

	['metalscrap'] = {
		label = 'Metal Scrap',
		weight = 100,
		stack = true,
		close = false,
		description = "You can probably make something nice out of this"
	},

	['meth'] = {
		label = 'Meth',
		weight = 1000,
		stack = true,
		close = true,
		description = "baggie of Meth"
	},

	['microwave'] = {
		label = 'Microwave',
		weight = 5000,
		stack = true,
		close = false,
		description = "1100 WATT Microwave"
	},

	['milk'] = {
		label = 'Milk',
		weight = 1000,
		stack = true,
		close = true,
		description = "Bag or box?"
	},

	['mushrooms'] = {
		label = 'Mushrooms',
		weight = 1000,
		stack = true,
		close = true,
		description = "Wild mushrooms gathered by following a pig"
	},

	['moneybag'] = {
		label = 'Money Bag',
		weight = 0,
		stack = false,
		close = true,
		description = "Bag with cash"
	},
	
	['night_vision'] = {
		label = 'Night Vision Goggles',
		weight = 5000,
		stack = false,
		close = true,
		description = "Bravo-6 going dark..."
	},

	['nitrous'] = {
		label = 'Nitrous Bottle',
		weight = 5000,
		stack = false,
		close = true,
		description = "\"When in doubt, add nitrous!\""
	},

	['nitrous_system_1'] = {
		label = 'Nitrous System Level 1',
		weight = 3000,
		stack = false,
		close = true,
		description = "Nitrous system level 1"
	},

	['nitrous_system_2'] = {
		label = 'Nitrous System Level 2',
		weight = 3000,
		stack = false,
		close = true,
		description = "Nitrous system level 2"
	},

	['nitrous_system_3'] = {
		label = 'Nitrous System Level 3',
		weight = 3000,
		stack = false,
		close = true,
		description = "Nitrous system level 3"
	},

	['notepad'] = {
		label = 'Notepad',
		weight = 100,
		stack = false,
		close = true,
		description = "A peice of paper to write things down on"
	},

	['onion'] = {
		label = 'Onion',
		weight = 1000,
		stack = true,
		close = true,
		description = "A true sob story"
	},

	['onion_seed'] = {
		label = 'Onion Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a onion plant"
	},

	['oredictionary'] = {
		label = 'Ore Dictionary',
		weight = 1000,
		stack = false,
		close = true,
		description = "Contains important information about mining"
	},

	['oxy'] = {
		label = 'Prescription Oxy',
		weight = 100,
		stack = true,
		close = true,
		description = "The Label Has Been Ripped Off"
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 10000,
		stack = false,
		close = true,
		description = "The sky is the limit! Woohoo!"
	},

	['pdcamera'] = {
		label = 'PD Camera',
		weight = 1000,
		stack = false,
		close = true,
		description = "Camera | For official use only"
	},

	['pearlscard'] = {
		label = 'Pearls Seafood',
		weight = 100,
		stack = false,
		close = true,
		description = "A special member of Pearl's Seafood Restaurant"
	},

	['pericopapers'] = {
		label = 'Cayo Perico Permit',
		weight = 100,
		stack = false,
		close = true,
		description = "\"Can you show me your party papers!?\""
	},

	['phone'] = {
		label = 'Phone',
		weight = 1000,
		stack = false,
		close = false,
		description = "Neat phone ya got there"
	},

	['pinger'] = {
		label = 'Pinger',
		weight = 1000,
		stack = true,
		close = true,
		description = "With a pinger and your phone you can send out your location"
	},

	['pistons'] = {
		label = 'Pistons',
		weight = 7000,
		stack = false,
		close = true,
		description = "Vehicle part"
	},

	['plant_nutrition'] = {
		label = 'Plant Fertilizer',
		weight = 5000,
		stack = false,
		close = true,
		description = "Plant nom noms"
	},

	['gold_pan'] = {
		label = 'Gold pan',
		weight = 2500,
		stack = false,
		close = true,
		description = "Gold feaver is on the horizon"
	},

	['metal_shovel'] = {
		label = 'Metal shovel',
		weight = 5000,
		stack = false,
		close = true,
		description = "Usefull for digging stuff up"
	},

	['dirt_pile'] = {
		label = 'A pile of dirt',
		weight = 5000,
		stack = false,
		close = true,
		description = "Maybe i should wash this in some water"
	},

	['copperpowder'] = {
		label = 'Pile of copper powder',
		weight = 100,
		stack = true,
		close = true,
		description = "Could probably smelt this down."
	},

	['ironpowder'] = {
		label = 'Pile of iron powder',
		weight = 100,
		stack = true,
		close = true,
		description = "Could probably smelt this down."
	},

	['goldpowder'] = {
		label = 'Pile of gold powder',
		weight = 100,
		stack = true,
		close = true,
		description = "Could probably smelt this down."
	},

	['plastic'] = {
		label = 'Plastic',
		weight = 100,
		stack = true,
		close = false,
		description = "RECYCLE!"
	},

	['plastictrash'] = {
		label = 'Plastic trash',
		weight = 100,
		stack = true,
		close = false,
		description = "This could be usefull."
	},

	['player_hat'] = {
		label = 'Hat',
		weight = 100,
		stack = false,
		close = true,
		description = "Its a hat"
	},

	['player_mask'] = {
		label = 'Mask',
		weight = 100,
		stack = false,
		close = true,
		description = "Its a mask"
	},

	['poison'] = {
		label = 'Special Needle',
		weight = 1000,
		stack = false,
		close = true,
		description = "A single dose of death..."
	},

	['police_stormram'] = {
		label = 'THE ENFORCER',
		weight = 20000,
		stack = false,
		close = true,
		description = "KNOCK KNOCK | For official police use only"
	},

	['potassium'] = {
		label = 'Potassium Tablets',
		weight = 500,
		stack = true,
		close = true,
		description = "Potassium tablets"
	},

	['potato'] = {
		label = 'Potato',
		weight = 1000,
		stack = true,
		close = true,
		description = "Oh hi! How are you doing? Because I am a potato..."
	},

	['potato_seed'] = {
		label = 'Potato Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a potato plant"
	},

	['prdxlaptop'] = {
		label = 'Laptop',
		weight = 10000,
		stack = false,
		close = true,
		description = "Looks like it has malware on it | MARKED FOR POLICE SEIZURE"
	},

	['printerdocument'] = {
		label = 'Document',
		weight = 1000,
		stack = false,
		close = true,
		description = "Nice document"
	},

	['prison_boombox'] = {
		label = 'Reconditioned Boombox',
		weight = 500,
		stack = true,
		close = true,
		description = "A box that plays music."
	},

	['prison_broken_boombox'] = {
		label = 'Broken Boombox',
		weight = 100,
		stack = true,
		close = true,
		description = "A box that hasn't played music for a long time."
	},

	['prison_broken_circuit'] = {
		label = 'Damaged Circuit Board',
		weight = 100,
		stack = true,
		close = true,
		description = "A circuit board missing critical parts needed to conduct electricity."
	},

	['prison_broken_phone'] = {
		label = 'Broken Phone',
		weight = 100,
		stack = true,
		close = true,
		description = "A phone that won't turn on, try putting it in rice?"
	},

	['prison_broken_tablet'] = {
		label = 'Broken Tablet',
		weight = 100,
		stack = true,
		close = true,
		description = "An old tablet with floppy birds frozen on the loading screen."
	},

	['prison_circuit_board'] = {
		label = 'Circuit Board',
		weight = 100,
		stack = true,
		close = true,
		description = "A circuit board with a little juice in it, useful for repairing things."
	},

	['prison_elec_comps'] = {
		label = 'Electrical Components',
		weight = 100,
		stack = true,
		close = true,
		description = "Electronic components that can be used to fix, or fry, electronic devices."
	},

	['prison_elec_wires'] = {
		label = 'Copper Wire',
		weight = 100,
		stack = true,
		close = true,
		description = "Roll of copper wire that could be recycled or used in science fair projects."
	},

	['prison_fabric'] = {
		label = 'Scraps of Fabric',
		weight = 100,
		stack = true,
		close = true,
		description = "Thick squares of fabric collected from soiled bedding in the cells."
	},

	['prison_kitchenoil'] = {
		label = 'Vegetable Oil',
		weight = 100,
		stack = true,
		close = true,
		description = "Some sort of used oil with a strong smell, better put it to use before they use it in the canteen again."
	},

	['prison_laces'] = {
		label = 'Loose Shoelace',
		weight = 100,
		stack = true,
		close = true,
		description = "A string that resembles your cellmate's missing shoelace."
	},

	['prison_lingerie'] = {
		label = 'Premium Lingerie',
		weight = 150,
		stack = true,
		close = true,
		description = "Lingerie, made in prison? A perfect gift for that special someone."
	},

	['prison_metal_wire'] = {
		label = 'Metal Wires',
		weight = 100,
		stack = true,
		close = true,
		description = "Thin metal wire that can be used for delicate crafting."
	},

	['prison_phone'] = {
		label = 'Reconditioned Phone',
		weight = 350,
		stack = true,
		close = true,
		description = "An old phone with no signal, basically a paperweight."
	},

	['prison_plastic'] = {
		label = 'Scraps of Plastic',
		weight = 100,
		stack = true,
		close = true,
		description = "Plastic scraps, recycle, trash, utilize - whatever you do, it'll never go away."
	},

	['prison_plate'] = {
		label = 'License Plate',
		weight = 250,
		stack = true,
		close = true,
		description = "A specially crafted license plate that'll end up in a junkyard."
	},

	['prison_sewing_needle'] = {
		label = 'Crude Sewing Needle',
		weight = 100,
		stack = true,
		close = true,
		description = "A poorly made needle that is better suited for sewing than stabbing."
	},

	['prison_tablet'] = {
		label = 'Reconditioned Tablet',
		weight = 400,
		stack = true,
		close = true,
		description = "Only useful for playing floppy birds."
	},

	['prison_thread'] = {
		label = 'Loose Thread',
		weight = 100,
		stack = true,
		close = true,
		description = "Simple thread that can be used in many ways."
	},

	['prison_uniform'] = {
		label = 'Public Safety Uniform',
		weight = 250,
		stack = true,
		close = true,
		description = "I went to prison and all I got was this t-shirt."
	},

	['prison_varnish'] = {
		label = 'Can of Varnish',
		weight = 100,
		stack = true,
		close = true,
		description = "Pigmented varnish used to stain and coat items, can also be used to cover other types of stains."
	},
	
	['pumpkin'] = {
		label = 'Pumpkin',
		weight = 1000,
		stack = true,
		close = true,
		description = "Apples, peaches, pumpkin pie. Soon your love will be all mine!"
	},

	['pumpkin_seed'] = {
		label = 'Pumpkin Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a pumpkin"
	},

	['puregoldcoin'] = {
		label = 'Pure Gold Coin',
		weight = 1000,
		stack = false,
		close = true,
		description = "Looks pretty expensive to me"
	},

	['race_dongle'] = {
		label = 'Race SD Card',
		weight = 1000,
		stack = false,
		close = true,
		description = "Racer's SD Card | MARKED FOR POLICE SEIZURE"
	},

	['race_tablet'] = {
		label = 'Tablet',
		weight = 1000,
		stack = false,
		close = true,
		description = "Weird Tablet | MARKED FOR POLICE SEIZURE"
	},

	['radio'] = {
		label = 'Radio',
		weight = 2000,
		stack = false,
		close = true,
		description = "You can communicate with this through a signal"
	},

	['radioscanner'] = {
		label = 'Radio Scanner',
		weight = 1000,
		stack = false,
		close = true,
		description = "Looks like it uses police radios to scan special frequencies..."
	},

	['raw_alcohol_eighty'] = {
		label = '80% Alcohol',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['raw_alcohol_forty'] = {
		label = '40% Alcohol',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['raw_alcohol_twenty'] = {
		label = '20% Alcohol',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['raw_beef'] = {
		label = 'Raw Beef',
		weight = 1000,
		stack = true,
		close = true,
		description = "Raw beef meat from cows"
	},

	['raw_chicken'] = {
		label = 'Raw Chicken',
		weight = 1000,
		stack = true,
		close = true,
		description = "Raw chicken"
	},

	['raw_corn'] = {
		label = 'Corn',
		weight = 1000,
		stack = true,
		close = true,
		description = "Raw corn from corn plants"
	},

	['raw_fabric'] = {
		label = 'Raw Fabric',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['raw_grains'] = {
		label = 'Raw Grains',
		weight = 1000,
		stack = true,
		close = true,
		description = "Raw grains from wheat plants"
	},

	['raw_pasta'] = {
		label = 'Raw Pasta',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['raw_pork'] = {
		label = 'Raw Pork',
		weight = 1000,
		stack = true,
		close = true,
		description = "Raw pork from pigs"
	},

	['raw_salmon'] = {
		label = 'Raw Salmon',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['raw_crab'] = {
		label = 'Raw Crab Meat',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['raw_shrimp'] = {
		label = 'Raw Shrimp And Prawns',
		weight = 1000,
		stack = true,
		close = true,
		description = "Bags of either Raw Shrimp or Prawns"
	},

	['raw_sugar_cane'] = {
		label = 'Raw Sugar Cane',
		weight = 1000,
		stack = true,
		close = true,
		description = "Raw sugar cane"
	},

	['raw_tobacco'] = {
		label = 'Raw Tobacco',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['raw_wood'] = {
		label = 'Wood Logs',
		weight = 1000,
		stack = true,
		close = false,
		description = "Raw cut wood log"
	},

	['receipt'] = {
		label = 'Receipt',
		weight = 100,
		stack = false,
		close = true,
		description = "Piece of paper"
	},

	['repairkit'] = {
		label = 'Repairkit',
		weight = 5500,
		stack = false,
		close = true,
		description = "nice toolbox with stuff to repair your vehicle"
	},

	['bike_repairkit'] = {
		label = 'Bike Repairkit',
		weight = 5500,
		stack = false,
		close = true,
		description = "nice toolbox with stuff to repair your motorcycle"
	},

	['revive_pen'] = {
		label = 'Medical Syringe',
		weight = 1000,
		stack = true,
		close = true,
		description = "Contains a strange goo, we don't know what is in it just that people spring back up to their feet..."
	},

	['rolex'] = {
		label = 'Golden Watch',
		weight = 1500,
		stack = true,
		close = true,
		description = "golden watch seems like the jackpot to me!"
	},

	['rolling_paper'] = {
		label = 'Rolling Paper',
		weight = 0,
		stack = true,
		close = true,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis."
	},

	['rubber'] = {
		label = 'Rubber',
		weight = 100,
		stack = true,
		close = false,
		description = "Rubber, I believe you can make your own rubber ducky with it :D"
	},

	['rubber_seed'] = {
		label = 'Rubber Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a rubber tree"
	},

	['ruby'] = {
		label = 'Ruby',
		weight = 100,
		stack = true,
		close = false,
		description = "A Ruby that shimmers"
	},

	['ruby_necklace'] = {
		label = 'Ruby Necklace',
		weight = 1000,
		stack = true,
		close = false,
		description = "A ruby necklace seems like the jackpot to me!"
	},

	['ruby_ring'] = {
		label = 'Ruby Ring',
		weight = 1000,
		stack = true,
		close = false,
		description = "A ruby ring seems like the jackpot to me!"
	},

	['sandwich'] = {
		label = 'Meatball Sub',
		description = "12 foot sub filled with balls",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 20,}, time = 10,},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Drink can
			prop = {
				model = 'prop_food_bs_burger2',
				bone = 18905,
				pos = {x = 0.12, y = 0.02, z = 0.07},
				rot = {x = -22.0, y = 158.0, z = -172.0},
			},
			usetime = 5000,
		},
	},

	['sapphire'] = {
		label = 'Sapphire',
		weight = 100,
		stack = true,
		close = false,
		description = "A Sapphire that shimmers"
	},

	['sapphire_necklace'] = {
		label = 'Sapphire Necklace',
		weight = 1000,
		stack = true,
		close = false,
		description = "A sapphire necklace seems like the jackpot to me!"
	},

	['sapphire_ring'] = {
		label = 'Sapphire Ring',
		weight = 1000,
		stack = true,
		close = false,
		description = "A sapphire ring seems like the jackpot to me!"
	},

	['screwdriverset'] = {
		label = 'Toolkit',
		weight = 1000,
		stack = true,
		close = false,
		description = "Very useful to screw... screws..."
	},

	['security_card_01'] = {
		label = 'Security Card A',
		weight = 0,
		stack = true,
		close = true,
		description = "security card... I wonder what it goes to"
	},

	['security_card_02'] = {
		label = 'Security Card B',
		weight = 0,
		stack = true,
		close = true,
		description = "security card... I wonder what it goes to"
	},

	['sharkhammer'] = {
		label = 'Shark',
		weight = 5000,
		stack = false,
		close = false,
		description = "Hammerhead Shark | MARKED FOR POLICE SEIZURE"
	},

	['sharktiger'] = {
		label = 'Shark',
		weight = 5000,
		stack = false,
		close = false,
		description = "Tigershark | MARKED FOR POLICE SEIZURE"
	},

	['slushy'] = {
		label = 'Slushy',
		weight = 1000,
		stack = true,
		close = true,
		description = "Flavorful drink to chill your vibe"
	},
	
	['snikkel_candy'] = {
		label = 'Snikkel',
		description = "Some delicious candy :O",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 20}, time = 10,},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'prop_choc_ego',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['phat_chips'] = {
		label = 'Phat Chips',
		description = "Phat Chips Big Cheese Flavor",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 20}, time = 10},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'v_ret_ml_chips4',
				bone = 18905,
				pos = {x = 0.13, y = -0.1, z = 0.00},
				rot = {x = 80.0, y = 86.0, z = 174.0},
			},
			usetime = 5000,
		},
	},
		
	['spices'] = {
		label = 'Various Spices',
		weight = 1000,
		stack = true,
		close = true,
		description = "Various spices to send you to flavortown"
	},

	['spices_seed'] = {
		label = 'Various Spice Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a various spices"
	},

	['spikestrip'] = {
		label = 'Stinger Spikes',
		weight = 10000,
		stack = false,
		close = true,
		description = "Spikestrips deployed... | For official police use only"
	},

	['steel'] = {
		label = 'Steel',
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something"
	},

	['stickynote'] = {
		label = 'Sticky note',
		weight = 0,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)"
	},

	['stingray'] = {
		label = 'Stingray',
		weight = 2500,
		stack = true,
		close = false,
		description = "Stingray"
	},

	['stone'] = {
		label = 'Stone',
		weight = 10000,
		stack = true,
		close = false,
		description = "Stone that may hold more"
	},

	['sugar'] = {
		label = 'Bag of Sugar',
		weight = 1000,
		stack = true,
		close = true,
		description = "Ingredient"
	},

	['sugar_cane_seed'] = {
		label = 'Sugar Cane Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a sugar cane plant"
	},

	['tablet'] = {
		label = 'Tablet',
		weight = 7000,
		stack = true,
		close = true,
		description = "Expensive tablet"
	},

	['taser_ammo'] = {
		label = 'Taser Ammo',
		weight = 1000,
		stack = true,
		close = true,
		description = "Cartridge for taser | FOR OFFICIAL USE ONLY",
		allowArmed = true
	},

	['telescope'] = {
		label = 'Telescope',
		weight = 1000,
		stack = true,
		close = false,
		description = "High Power Telescope"
	},
	
	['thermite'] = {
		label = 'Thermite',
		weight = 5000,
		stack = true,
		close = true,
		description = "Sometimes you'd wish for everything to burn"
	},

	['timed_bomb'] = {
		label = 'Timed Bomb',
		weight = 15000,
		stack = false,
		close = true,
		description = "Improvised explosive with a timer and radio signal interaface | MARKED FOR POLICE SEIZURE"
	},
	
	['tomato'] = {
		label = 'Tomato',
		weight = 1000,
		stack = true,
		close = true,
		description = "Tomotto or Tomato"
	},

	['tomato_seed'] = {
		label = 'Tomato Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a tomato plant"
	},

	['tosti'] = {
		label = 'Grilled Cheese Sandwich',
		description = "Nice to eat",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 20,}, time = 10,},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Drink can
			prop = {
				model = 'prop_sandwich_01',
				bone = 18905,
				pos = {x = 0.12, y = 0.02, z = 0.01},
				rot = {x = -88.0, y = 62.0, z = -130.0},
			},
			usetime = 5000,
		},
	},

	['turbocharger'] = {
		label = 'Turbocharger',
		weight = 2000,
		stack = false,
		close = true,
		description = "It's a turbski"
	},

	['tv'] = {
		label = 'TV',
		weight = 9000,
		stack = true,
		close = false,
		description = "4K Television"
	},

	['twerks_candy'] = {
		label = 'Twerks',
		description = "Some delicious candy :O",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 20}, time = 10,},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'prop_choc_ego',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['uncut_diamond'] = {
		label = 'Uncut Diamond',
		weight = 1000,
		stack = true,
		close = false,
		description = "A rough Diamond"
	},

	['uncut_emerald'] = {
		label = 'Uncut Emerald',
		weight = 1000,
		stack = true,
		close = false,
		description = "A rough Emerald"
	},

	['uncut_ruby'] = {
		label = 'Uncut Ruby',
		weight = 1000,
		stack = true,
		close = false,
		description = "A rough Ruby"
	},

	['uncut_sapphire'] = {
		label = 'Uncut Sapphire',
		weight = 1000,
		stack = true,
		close = false,
		description = "A rough Sapphire"
	},
	
	['valuable_jewelry'] = {
		label = 'Valuable Jewelry',
		weight = 1000,
		stack = true,
		close = true,
		description = "Assortment of expensive looking jewelry"
	},

	['vodka'] = {
		label = 'Vodka',
		description = "For all the thirsty out there",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 20,}, time = 10, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "mp_player_inteat@pnq", clip = 'loop'},
			prop = {
				model = 'prop_vodka_bottle',
				bone = 18905,
				pos = {x = -0.05, y = -0.28, z = 0.11},
				rot = {x = 56.0, y = 98.0, z = 168.0},
			},
			usetime = 5000,
		},
	},

	['walkstick'] = {
		label = 'Walking Stick',
		description = "Walking stick for ya'll grannies out there.. HAHA",
		weight = 5000,
		stack = false,
		close = true,
		client = {
			anim = {dict = "missbigscore2aleadinout@bs_2a_2b_int", clip = 'lester_base_idle'}, 
			prop = {
				model = 'prop_cs_walking_stick', 
				bone = 18905,
				pos = {x = 0.14, y = 0.02, z = 0.08},
				rot = {x = 260.0, y = 70, z = -10.0},
			},
			usetime = 0,
		},
	},

	['wallet'] = {
		label = 'Wallet',
		weight = 2500,
		stack = false,
		close = false,
		description = "Stores your most personal items"
	},

	['water_bottle'] = {
		label = 'Bottle of Water',
		description = "For all the thirsty out there",
		weight = 1000,
		stack = true,
		close = true,
	},

	['watering_can'] = {
		label = 'Watering Can',
		weight = 10000,
		stack = false,
		close = true,
		repairable = true, -- allows use when broken
		description = "For all the thirsty plants and animals out there"
	},

	['weed_brick'] = {
		label = 'Weed Brick',
		weight = 9000,
		stack = true,
		close = true,
		description = "1KG brick of unmarked cannabis, tightly packaged together"
	},

	['weed_legion_diesel'] = {
		label = 'Legion Diesel 2g',
		weight = 1000,
		stack = true,
		close = false,
		description = "weed bag with 2g Legion Diesel"
	},

	['weed_legion_diesel_seed'] = {
		label = 'Legion Diesel Seed',
		weight = 100,
		stack = true,
		close = false,
		description = "weed seed of Legion Diesel"
	},

	['weed_og_kush_seed'] = {
		label = 'OG-Kush Seed',
		weight = 100,
		stack = true,
		close = true,
		description = "weed seed of OG Kush"
	},

	['weed_seebeedeebees'] = {
		label = 'Seebeedeebees 2g',
		weight = 1000,
		stack = true,
		close = false,
		description = "weed bag with 2g Seebeedeebees CBD"
	},

	['weed_seebeedeebees_seed'] = {
		label = 'Seebeedeebees Seed',
		weight = 100,
		stack = true,
		close = true,
		description = "weed seed of Seebeedeebees"
	},

	['weed_seed'] = {
		label = 'Weed Seed',
		weight = 100,
		stack = true,
		close = true,
		description = "weed seed of unknown strain"
	},

	['weed_small_brick'] = {
		label = 'Weed Baggie',
		weight = 1000,
		stack = true,
		close = true,
		description = "20g baggie of unmarked cannabis"
	},

	['weed_sparkplug'] = {
		label = 'Hawick Haze 2g',
		weight = 1000,
		stack = true,
		close = false,
		description = "weed bag with 2g Hawick Haze"
	},

	['weed_sparkplug_seed'] = {
		label = 'Hawick Haze Seed',
		weight = 100,
		stack = true,
		close = true,
		description = "weed seed of Hawick Haze"
	},

	['weed_table'] = {
		label = 'Weed Table',
		weight = 5000,
		stack = false,
		close = true,
		description = "A fold-out table with scales and baggies"
	},

	['weed_vss'] = {
		label = 'Rockford OG 2g',
		weight = 1000,
		stack = true,
		close = false,
		description = "weed bag with 2g Rockford OG"
	},

	['weed_vss_seed'] = {
		label = 'Rockford OG Seed',
		weight = 100,
		stack = true,
		close = true,
		description = "weed seed of Rockford OG"
	},

	['wet_coke'] = {
		label = 'Soaked Coca Leaves',
		weight = 1000,
		stack = false,
		close = true,
		degrade = 120, -- 2 hours
		description = "Wet coca plant leaves, smells of gasoline"
	},

	['wet_coke_brick'] = {
		label = 'Wet Brick of Cocaine',
		weight = 10000,
		stack = false,
		close = true,
		description = "Uncompressed and brick of raw cocaine"
	},

	['wet_weed'] = {
		label = 'Fresh Marijuana Plant',
		weight = 1000,
		stack = false,
		close = true,
		degrade = 120, -- 2 hours
		description = "Wet and fresh plant of unknown strain of marijuana"
	},

	['wheat_seed'] = {
		label = 'Wheat Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Seeds for a wheat plant"
	},

	['whiskey'] = {
		label = 'Whiskey',
		description = "For all the thirsty out there",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 20,}, time = 10, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "mp_player_inteat@pnq", clip = 'loop'},
			prop = {
				model = 'prop_whiskey_bottle',
				bone = 18905,
				pos = {x = -0.01, y = -0.17, z = 0.07},
				rot = {x = 56.0, y = 98.0, z = 168.0},
			},
			usetime = 5000,
		},
	},

	['wine'] = {
		label = 'Wine',
		weight = 1000,
		stack = true,
		close = false,
		description = "Some good wine to drink on a fine evening"
	},

	['wingsuit'] = {
		label = 'Wingsuit',
		weight = 10000,
		stack = false,
		close = true,
		description = "WARNING: MUST BE USED IN AIR!"
	},

	['weaponlicense'] = {
		label = 'Weapon License',
		weight = 0,
		stack = false,
		close = true,
		description = "Weapon License"
	},

	['xtcbaggy'] = {
		label = 'Bag of XTC',
		weight = 100,
		stack = true,
		close = true,
		description = "Pop those pills baby"
	},

	['yeast'] = {
		label = 'Bag of Yeast',
		weight = 1000,
		stack = true,
		close = true,
		description = "Used for baking or fermentation"
	},

    --------------------
    --   Other Items  --
    --------------------
	
	--EASTER--
	['easter_egg'] = {
		label = 'Easter Egg',
		weight = 0,
		stack = false,
		close = true,
		description = "Easter Egg with a random surprise inside"
	},

	['easter_bunny'] = {
		label = 'Chocolate Easter Bunny',
		description = "Happy Easter",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 30, stress = -10}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'bzzz_event_easter_bunny_a',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.02},
				rot = {x = 86.0, y = -138.0, z = 220.0},
			},
			usetime = 5000,
		},
	},


    --------------------
    --    Job Items   --
    --------------------

    -- Ingredients --

    -- PD --

    -- EMS --
	['ems_bag'] = {
		label = 'Medical Bag',
		weight = 100,
		stack = false,
		close = false,
		description = "A strip of rigid material used for supporting and immobilizing a broken bone when it has been set"
	},
	['bandage'] = {
		label = 'Bandages',
		weight = 1000,
		stack = true,
		close = true,
		description = "Box of Band-Aids to heal minor Boo Boos"
	},
	['icepack'] = {
		label = 'Ice Pack',
		weight = 100,
		stack = true,
		close = true,
		description = "A bag filled with ice or cooling agent. Applied to the body to reduce swelling or lower temperature"
	},
	['quikclot'] = {
		label = 'Quikclot',
		weight = 100,
		stack = true,
		close = true,
		description = "Quikclot combat gauze stops bleeding nearly instantly"
	},
	['painkillers'] = {
		label = 'Naproxen',
		weight = 100,
		stack = true,
		close = true,
		description = "For pain you can't stand anymore, take this pill that'd make you feel great again"
	},
	['sertraline'] = {
		label = 'Sertraline',
		weight = 100,
		stack = true,
		close = true,
		description = "Sertraline affects chemicals in the brain that may be unbalanced in people with depression, panic, anxiety, or obsessive-compulsive symptoms"
	},
	['splint'] = {
		label = 'Splint',
		weight = 100,
		stack = true,
		close = true,
		description = "A strip of rigid material used for supporting and immobilizing a broken bone when it has been set"
	},
	['ems_neckbrace'] = {
		label = 'Cervical Collar',
		weight = 100,
		stack = true,
		close = true,
		description = "Treatment option for neck injuries, neck surgeries, and some instances of neck pain."
	},
	['ems_o2mask'] = {
		label = 'Oxygen Mask',
		weight = 100,
		stack = true,
		close = true,
		description = "Oxygen mask provides a method to transfer breathing oxygen gas from a storage tank to the lungs."
	},
	['ems_gauze'] = {
		label = 'Medical Gauze',
		weight = 100,
		stack = true,
		close = true,
		description = "Roll of gauze for bandaging wounds"
	},
	['ems_burnsheets'] = {
		label = 'Burnsheets',
		weight = 100,
		stack = true,
		close = true,
		description = "Blankets that aid in protecting burn patients against infection."
	},
    -- Tow --

	-- Mechanic/Tunning --

    -- Other --

    --------------------
    -- Criminal Items --
    --------------------

    -- Reward Items --
	['banktruck_lockbox'] = {
		label = 'Fleeca Lockbox (Locked)',
		weight = 15000,
		stack = false,
		description = "A fleeca bank secure lockbox with a tracking device"
	},
    -- Tools --
	['motionsensor'] = {
		label = 'Motion Sensor',
		weight = 2500,
		stack = false,
		close = true,
		description = "A remote sensing device"
	},
	['spycam'] = {
		label = 'Spy Camera',
		weight = 2500,
		stack = false,
		close = true,
		description = "A small placeable camera"
	},
	['remote_monitor'] = {
		label = 'Remote Monitor',
		weight = 2500,
		stack = false,
		close = true,
		description = "A high powered remote monitor"
	},
    -- Drugs --
	['moonshine'] = {
		label = 'Moonshine',
		weight = 1000,
		stack = true,
		close = false,
		description = "Deadly Alcohol"
	},
	['moonshine_mash'] = {
		label = 'Moonshine Mash Mix',
		weight = 5000,
		stack = false,
		close = false,
		description = "A barrel of fermenting mash"
	},
	['moonshine_still'] = {
		label = 'Moonshine Still',
		weight = 25000,
		stack = false,
		close = true,
		description = "A fire powered copper pot that leads to a cap down to a doubler and then a condensor"
	},
	['water_pump'] = {
		label = 'Water Pump',
		weight = 2500,
		stack = false,
		close = true,
		description = "Gas powered pump"
	},
	['water_tank'] = {
		label = 'Water Tank',
		weight = 2500,
		stack = false,
		close = true,
		description = "A plastic container rated for water"
	},
	['poppy'] = {
		label = 'Poppy',
		weight = 1000,
		stack = true,
		close = true,
		description = "Main Ingredient Used in making oxy"
	},
	['poppyseed'] = {
		label = 'Poppy Seeds',
		weight = 100,
		stack = true,
		close = true,
		description = "Poppy Seeds"
	},
	
    -- Other --

	--Death Needle--
	['enzymes'] = {
		label = 'Enzymes',
		weight = 1000,
		stack = true,
		close = true,
		description = "Small vile of illegal Enzymes"
	},

    --------------------
    -- Business Items --
    --------------------

	----------------------------
	-- Generic Crafting Items --
	----------------------------

	

    -- 10-42 Items --
    ['tft_ambulance'] = { -- Actual item name
		label = 'Petrovic\'s White Russian ',
		description = 'A memory of the motherland just dont ask Petrovic',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { water = 50, stress = -45}, time = 90, visualEffects = {['Drunk'] = 1.0}},
			anim = {dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a'},
			prop = {
				model = 'prop_drink_whisky',
				bone = 57005,
				pos = { x = 0.11, y = -0.04, z = -0.06,},
				rot = {x = -76.0,  y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
	},

	['tft_burger_sliders'] = { --eggnog--
		label = '10-50',
		description = 'That shit grandma was drinking when she got hit by Rudolph.',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { water = 65, stress = -35}, time = 30, visualEffects = {['Drunk'] = 1.0}},
			anim = {dict = 'mp_player_inteat@pnq', clip = 'loop'},
			prop = {
				model = 'p_cs_shot_glass_2_s',
				bone = 18905,
				pos = {x = 0.13, y = 0.01, z = 0.02},
				rot = {x = 241.0, y = 264.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['tft_chicken_wings'] = {
		label = '10-69 Reuben',
		description = 'Reuben Sandwich for when times are tough for you and the government.',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 75,}, time = 15},
			anim = {dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger'},
			prop = {
				model = 'prop_cs_burger_01',
				bone = 18905,
				pos = {x = 0.13, y = 0.05,  z = 0.02},
				rot = {x = 0.0,  y = 180.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['tft_crinkle_fries'] = {
		label = 'Crinkle Fries',
		description = "The only fries that you should be eating, crinkle or nothing baby.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 50 }, time = 15},
			anim = {dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger'},
			prop = {
				model = 'prop_choc_ego',
				bone = 57005,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['tft_firefighter_fireball'] = {
		label = 'Firefighter Fireball',
		description = "Sponsored by our local fire department, won't put out a fire though.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 65, stress = -35}, toxicity = 2.5, time = 45, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = 'mp_player_inteat@pnq', clip = 'loop'},
			prop = {
				model = 'p_cs_shot_glass_2_s',
				bone = 18905,
				pos = {x = 0.13, y = 0.01, z = 0.02},
				rot = {x = 241.0, y = 264.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['tft_masons_moonshine'] = {
		label = 'Mason\'s Moonshine',
		description = 'Narcisism at its finest. Cold brew themed moonshine that packs a punch.',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = -25, water = 50, stress = -33, strength = 2.0, speed = 0.75}, visualEffects = {["drug_drive_blend01"] = 1.0}, time = 45},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},
			prop = {
				model = 'prop_cs_beer_bot_40oz_03',
				bone = 57005,
				pos = {x = 0.12, y = -0.03, z = -0.06},
				rot = {x = -78.0, y = 81.0, z = 11.0},
			},
			usetime = 7000,
		},
	},

	['tft_probie'] = {
		label = 'The Probie',
		description = "It's a starter, won't get you going. Might eventually right?",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 75, stress = -15}, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},
			prop = {
				model = 'prop_orang_can_01',
				bone = 57005,
				pos = {x = 0.11, y = 0.01, z = -0.03},
				rot = {x = -60.0, y = 45.0, z = -7.0},
			},
			usetime = 5000,
		},
	},

	['tft_sly_shandy'] = {
		label = 'LSPD Lager',
		description = "Shiny sheer to quench your thirst, not dug up or copyrighted.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { water = 60, stress = -25}, time = 25, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},
			prop = {
				model = 'prop_cs_beer_bot_40oz_03',
				bone = 57005,
				pos = {x = 0.12, y = -0.03, z = -0.06},
				rot = {x = -78.0, y = 81.0, z = 11.0},
			},
			usetime = 5000,
		},
	},

	['tft_state_whiskey'] = {
		label = 'County Green Tea',
		description = "Tea for the far and wide, a homestead of Sandy. Non-Alcoholic, stress reliever.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 40, stress = -30}, time = 30},
			anim = {dict = "mp_player_inteat@pnq", clip = 'idle_a'},
			prop = {
				model = 'prop_food_coffee',
				bone = 57005,
				pos = {x = 0.11, y = 0.0, z = -0.05},
				rot = {x = -70.0, y = 110.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['tft_waterhose'] = {
		label = 'Waterhose',
		description = "Like a SWAT cannon or a fire hydrant, this goes down easy and not to the floor.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 40, stress = -30}, time = 30},
			anim = {dict = "mp_player_inteat@pnq", clip = 'idle_a'},
			prop = {
				model = 'prop_food_coffee',
				bone = 57005,
				pos = {x = 0.11, y = 0.0, z = -0.05},
				rot = {x = -70.0, y = 110.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

    -- Glazed and Glorious --
    ['glazed_bubble_tea'] = {
		label = 'Orange Juice',
		description = "A cold glass of sunshine!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {water = 60}, time = 15},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_tequsunrise',
				bone = 57005,
				pos = {x = 0.13, y = -0.11, z = -0.09},
				rot = {x = -66.0, y = 36.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['glazed_cakepops'] = {
		label = 'Croissant',
		description = "A little bit flakey",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 30,}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'bzzz_foodpack_croissant001',
				bone = 18905,
				pos = {x = 0.12, y = 0.02, z = 0.04},
				rot = {x = -168.0, y = 57.0, z =-18.0},
			},
			usetime = 5000,
		},
	},

	['glazed_cookies'] = {
		label = 'Bacon,Egg,Cheese Bagel',
		description = "Don't go bacon my heart!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 55}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},
			prop = {
					model = 'prop_cs_burger_01',
					bone = 18905,
					pos = {x = 0.11, y = 0.03, z = 0.03},
					rot = {x = -10.0, y = -39.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['glazed_cupcakes'] = {
		label = 'Ramen',
		description = 'The pig made me do it.',
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 60}, time = 30},
			anim = {dict = 'anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1', clip = 'base_idle'},
			prop = {
				{
					model = 'prop_cs_bowl_01',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				}
			},
			usetime = 15000,
		},
	},

	['glazed_hotchocolate'] = {
		label = 'Matcha Tea',
		description = "Spill the tea!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 40, stress = -40}, time = 15},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'bzzz_food_xmas_mulled_wine_a',
				bone = 57005,
				pos = {x = 0.14, y = 0.04, z = -0.04},
				rot = {x = -70.0, y = 31.0, z = -2.0},
			},
			usetime = 5000,
		},
	},

	['glazed_latte'] = {
		label = 'Ice Coffee',
		description = "Better latte than never!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, stress = -25}, time = 15},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'denis3d_catcafe_boobaa_pink',
				bone = 57005,
				pos = {x = 0.14, y = -0.08, z = -0.04},
				rot = {x = -84.0, y = -22.0, z = 2.0},
			},
			usetime = 5000,
		},
	},

	['glazed_mochi'] = {
		label = 'Grilled Cheese & Soup',
		description = "Bring forth the Grilled Cheese!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 40, water = 25}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --eat bowl one--
			prop = {
				{
					model = 'prop_cs_bowl_01',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_sandwich_01',
					bone = 57005,
					pos = {x = 0.17, y = 0.06, z = -0.04},
					rot = {x = 43.0, y = 187.0, z = 160.0},
				}
			},
			usetime = 15000,
		},
	},

	['glazed_smoothie'] = {
		label = 'Smoothie',
		description = "Feeling fruity? Grab a Smoothie.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 20, water = 60}, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'scully_boba',
				bone = 57005,
				pos = {x = 0.13, y = -0.05, z = -0.05},
				rot = {x = 84.0, y = 27.0, z = 185.0},
			},
			usetime = 5000,
		},
	},

	['glazed_special_donut'] = {
		label = 'Glazed Special Donut',
		description = "Time to get that dough.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {stress = -10, speed = 1.2, stamina = 1, food = 75, water = -55}, time = 30, toxicity = 2.5, visualEffects = {["LostTimeFlash"] = 1.0}},
			anim = {dict = "mp_player_inteat@burger", clip = 'mp_player_int_eat_burger'}, --Eat Donut one--
			prop = {
				model = 'bzzz_foodpack_donut001',
				bone = 60309,
				pos = {x = 0.00, y = -0.03, z = -0.01},
				rot = {x = 10.0, y = 0.0, z = 1.0},
			},
			usetime = 5000,
		},
	},

	['glazed_tea'] = {
		label = 'Cheesecake',
		description = "Wana piece of me? I know, what a cheesy joke!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 65}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	['catplushie_red'] = {
		label = 'Cat Plushie', --special effect
		weight = 2500,
		stack = false,
		close = true,
		description = "Limited Edition Cat Plushie "
	},

	--OpenRoad--
	['skywalker_sausage'] = {
		label = 'Smoked Turkey Leg',
		description = "How much meat can you fit in your mouth?",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 50, water = -10}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --eat donut one--
			prop = {
				model = 'prop_turkey_leg_01',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00,},
				rot = {x = 448.0, y = 408.0, z = 239.0},
			},
			usetime = 7000,
		},
	},

	['chicken_tay_quito'] = {
		label = "Kato's Boiled Peanuts",
		description = "Kato's nuts, sweet and salty.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 30, water = -15 }, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'prop_choc_ego',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['bar_peanuts'] = {
		label = 'Sloppy Joe',
		description = "Sloppy Joe's for Sloppy Hoe's",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 75,}, time = 15},
			anim = {dict = 'mp_player_inteat@burger', clip = 'mp_player_int_eat_burger'},
			prop = {
				model = 'prop_cs_burger_01',
				bone = 18905,
				pos = {x = 0.13, y = 0.05,  z = 0.02},
				rot = {x = 0.0,  y = 180.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['sandy_shot_glass'] = {
		label = "Glenda's Jelly",
		description = "I don't think you're ready for this Jelly",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { notaze = 1}, time = 90, toxicity = 2.5},
			anim = {dict = "mp_player_inteat@pnq", clip = "loop"},  --Drink Shot--
			prop = {
				model = 'p_cs_shot_glass_2_s',
				bone = 18905,
				pos = {x = 0.13, y = 0.01, z = 0.02},
				rot = {x = 241.0, y = 264.0, z = 0.0},
			},
			usetime = 5000,
			},
	},

	['shoey_dirty_boot'] = {  --Special Effects Head Bag--
		label = 'Open Road Bag ',
		description = 'To-Go Doggy Bag for your Open Road Food and more! Not safe for children.',
		weight = 1000,
		stack = true,
		close = true,
		
	},

	['yellowjack_coke'] = {
		label = 'Jack n Coke',
		description = "Our Open Road Jack n' Coke features whiskey, molasses and cola. Time to relax.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 40, stress = -10}, time = 30, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Whiskey--
			prop = {
				model = 'prop_drink_whisky',
				bone = 57005,
				pos = {x = 0.11, y = -0.04, z = -0.06},
				rot = {x = -76.0, y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
	},

	['rootbeer_float'] = {
		label = 'Root Beer Float',
		description = "Scoops of fresh vanilla ice cream in bubble foamy root beer",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = 60 }, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'p_ing_coffeecup_02',
				bone = 57005,
				pos = {x = 0.13, y = -0.05, z = -0.05},
				rot = {x = 84.0, y = 27.0, z = 185.0},
			},
			usetime = 5000,
		},
	},

	['katie_knives'] = {
		label = 'JBs Pipe',
		description = "Smoking pipe hand made in Sandy Shores, finished with a natural coating and carnauba wax, giving it the final beautiful look.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { stress = -50, time = 30}},
			anim = {dict = "amb@world_human_aa_smoke@male@idle_a", clip = "idle_c"},  --Smoke Cigar One--
			prop = {
				model = 'prop_cigar_01',
				bone = 57005,
				pos = {x = 0.16, y = 0.02, z = 0.02},
				rot = {x = 0.0, y = -95.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['tennesse_whiskey'] = {
		label = "Shan's Sweet Tea",
		description = "Anytime is tea time",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 60, food = -10, time = 15}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'prop_cocktail',
				bone = 57005,
				pos = {x = 0.08, y = -0.13, z = -0.04},
				rot = {x = -67.0, y = 115.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['rangers_moon_shine'] = {
		label = 'Sandy Malt Liquor',
		description = "If you can't shotgun it, you can't have it",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = -15, water = 50}, time = 90, visualEffects = {["BlackOut"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},  --Drink Beer Bottle one--
			prop = {
				model = 'v_res_tt_can02',
				bone = 57005,
				pos = {x = 0.14, y = -0.01, z = -0.03},
				rot = {x = -77.0, y = 98.0, z = 19.0},
			},
			usetime = 5000,
		},
	},

	--Vanilla Unicorn--
	['vu_chicken_wings'] = {
		label = 'Mozzarella Sticks',
		description = "Cheesy Mouthwatering Sticks",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 50, }, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'prop_choc_ego',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['vu_mac_n_cheese'] = {
		label = 'Buffalo Wings',
		description = "A mouthful of spice",
		
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 50}, time = 30},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --eat donut one--
			prop = {
				model = 'prop_turkey_leg_01',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00,},
				rot = {x = 448.0, y = 408.0, z = 239.0},
			},
			usetime = 7000,
		},
	},

	['vu_pear_cocktail'] = {
		label = 'Fancyson IPA',
		description = "What is that aftertaste...?",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50}, time = 60, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},  --Drink Beer Bottle one--
			prop = {
				model = 'prop_cs_beer_bot_40oz_03',
				bone = 57005,
				pos = {x = 0.12, y = -0.03, z = -0.06},
				rot = {x = -78.0, y = 81.0, z = 11.0},
			},
			usetime = 5000,
		},
	},

	['henny'] = {
		label = 'The Golden Shower',
		description = "Pop that and spray it",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { water = 60, stress = -25}, time = 25, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},  
			prop = {
				model = 'ba_prop_battle_champ_open_02',
				bone = 57005,
				pos = {x = 0.16, y = -0.14, z = -0.05},
				rot = {x = -80.0, y = -20.0, z = 0.0},
			},
			usetime = 7000,
		},
	},

	['blue_lagoon'] = {
		label = 'Vanilla Cream Soda',
		description = "The creaming soda",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 60}, time = 60,},
			anim = {dict = "mp_player_inteat@pnq", clip = "loop"},  --Drink Shot--
			prop = {
				model = 'ng_proc_sodabot_01a',
				bone = 12844,
				pos = {x = -0.11, y = 0.42, z = -0.03},
				rot = {x = -67.0, y = 53.0, z = -173.0},
			},
			usetime = 5000,
		},
	},

	['southside_special_jello'] = {
		label = 'Bloody Mary',
		description = "The more bloody, the better",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = 10}, time = 30, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "mp_player_inteat@pnq", clip = "loop"},  --Drink Shot--
			prop = {
				model = 'p_cs_shot_glass_2_s',
				bone = 18905,
				pos = {x = 0.13, y = 0.01, z = 0.02},
				rot = {x = 241.0, y = 264.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['bottled_dreams'] = {
		label = 'Shrimp cocktail',
		description = "Raw, Firm and Saucy",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { food = 65}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				}
			},
			usetime = 15000,
		},
	},

	['unicorn_charm'] = {
		label = 'The Unicorn Charm', --handcuffs
		description = "Lock me up and throw away the keys",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {}, --Special Effects--
			anim = {dict = "mp_arresting", clip = "a_uncuff"},  
			prop = {
				model = 'prop_cuff_keys_01',
				bone = 18905,
				pos = {x = 0.12, y = 0.03, z = 0.04, },
				rot = {x = 15.00, y = -65.00, z = 5.00},
			},
			usetime = 5000,
		},
	},

	['unicorn_ice'] = {
		label = 'Sticky buns',
		description = "Get your hands on these buns",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 40}, time = 10},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  -- eat candy--
			prop = {
				model = 'prop_peyote_gold_01',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = 448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['dirty_panties'] = {
		label = 'Dancers Panties',
		description = "Dancer's Choice, lingerie",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { stress = -100}, time = 30,},
			anim = {dict = "move_p_m_two_idles@generic", clip = "fidget_sniff_fingers"},  
			prop = {
				model = 'prop_cs_panties_02',
				bone = 57005,
				pos = {x = 0.12, y = 0.01, z = 0.00},
				rot = {x = -89.0, y = 105.0, z = 285.0},
			},
			usetime = 5000,
		},
	},

	--Skull Island--
	['tll_chicken_wings'] = {
		label = 'Enchiladas',
		description = "You Make My Enchilada Tingle",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { food = 65}, time = 15},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	['tll_nachos'] = {
		label = 'Case-adilla',
		description = "You, Me, Quesadillas.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 30,}, time = 10,},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Drink can
			prop = {
				model = 'prop_sandwich_01',
				bone = 18905,
				pos = {x = 0.12, y = 0.02, z = 0.01},
				rot = {x = -88.0, y = 62.0, z = -130.0},
			},
			usetime = 5000,
		},
	},

	['tll_orange_juice'] = {
		label = 'Masonada',
		description = "Spicy and sweet, just like us.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 60}, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_tequsunrise',
				bone = 57005,
				pos = {x = 0.13, y = -0.11, z = -0.09},
				rot = {x = -66.0, y = 36.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['tequilala_sunrise'] = {
		label = 'Carna Asada Fries',
		description = "Carna Asada Fries Never Dies!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { food = 65, armor = 45,}, time = 45, toxicity = 3.6, visualEffects = {["LostTimeFlash"] = 1.0}},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	['white_duck_vodka'] = {
		label = 'Elotay',
		description = "I love you Elote",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 50,}, time = 15,},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eatcorn
			prop = {
				model = 'luno_corn',
				bone = 18905,
				pos = {x = 0.1, y = 0.0, z = 0.04},
				rot = {x = -10.0, y = 46.0, z = 48.0},
			},
			usetime = 5000,
		},
	},

	['silver_captain_whiskey'] = {
		label = 'SnakeBite',
		description = "A shot that bites back.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = 5}, time = 30, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "mp_player_inteat@pnq", clip = "loop"},  --Drink Shot--
			prop = {
				model = 'p_cs_shot_glass_2_s',
				bone = 18905,
				pos = {x = 0.13, y = 0.01, z = 0.02},
				rot = {x = 241.0, y = 264.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['cuban_cigar'] = {
		label = 'SkullPods',
		description = "I dont blow Smoke, I blow Clouds...",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { stress = -45, water = -15}, time = 20},
			anim = {dict = "amb@world_human_smoking@male@male_b@base", clip = 'base'}, --Eat Plate
			prop = {
				model = 'ba_prop_battle_vape_01',
				bone = 28422,
				pos = {x = -0.029, y = 0.007, z = -0.005},
				rot = {x = 91.00, y = 270.00, z = -360.00},
			},
			usetime = 15000,
		},
	},

	['bandit_bombs'] = {
		label = 'IslandLite',
		description = "As close as your gonna get to a Corona",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 55, stress = -25}, time = 50, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_wheat_grass_glass',
				bone = 57005,
				pos = {x = 0.13, y = -0.11, z = -0.09},
				rot = {x = -66.0, y = 36.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['psycho_juice'] = {
		label = 'Pina-Colada',
		description = "If you like Pina Coladas and like songs stuck in your head",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, stress = -75}, time = 90, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_pinacolada',
				bone = 57005,
				pos = {x = 0.15, y = -0.12, z = -0.04},
				rot = {x = 91.0, y = 52.0, z = 182.0},
			},
			usetime = 5000,
		},
	},

	['revolver_tonic_wine'] = {
		label = 'Horchata',
		description = "If you can't say it right, then don't say it's name.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 40, stress = -10}, time = 15},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Whiskey--
			prop = {
				model = 'prop_drink_whisky',
				bone = 57005,
				pos = {x = 0.11, y = -0.04, z = -0.06},
				rot = {x = -76.0, y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
	},

	--Smoke On The Water--
	['joint_legion_diesel'] = {
		label = 'Joint Legion Diesel',
		description = "Some of the most potent weed in existance, proceed with caution",
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = {effects = { health = 40, food = -20, stress = -75 }, time = 100, visualEffects = {["rply_saturation"] = 1.0}},
			anim = {dict = "amb@world_human_aa_smoke@male@idle_a", clip = "idle_c"},  --Smoke Joint One--
			prop = {
				model = 'prop_sh_joint_01',
				bone = 57005,
				pos = {x = 0.16, y = 0.01, z = 0.02},
				rot = {x = -158.0, y = 78.0, z = 16.0},
			},
			usetime = 5000,
		},
	},

	['joint_seebeedeebees'] = {
		label = 'Joint CBD',
		description = "All of the healing with none of the intoxication",
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = {effects = { stress = -40, food = -10}, time = 30,},
			anim = {dict = "amb@world_human_aa_smoke@male@idle_a", clip = "idle_c"},  --Smoke Joint One--
			prop = {
				model = 'prop_sh_joint_01',
				bone = 57005,
				pos = {x = 0.16, y = 0.01, z = 0.02},
				rot = {x = -158.0, y = 78.0, z = 16.0},
			},
			usetime = 5000,
		},
	},

	['joint_sparkplug'] = {
		label = 'Joint Hawick Haze',
		description = "Far better than anything grown in a ditch",
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = -15, stress = -65 }, time = 55, visualEffects = {["rply_saturation"] = 1.0}},
			anim = {dict = "amb@world_human_aa_smoke@male@idle_a", clip = "idle_c"},  --Smoke Joint One--
			prop = {
				model = 'prop_sh_joint_01',
				bone = 57005,
				pos = {x = 0.16, y = 0.01, z = 0.02},
				rot = {x = -158.0, y = 78.0, z = 16.0},
			},
			usetime = 5000,
		},
	},

	['joint_vss'] = {
		label = 'Joint Rockford OG',
		description = "Guaranteed to contain no more than 10% orgegano",
		weight = 100,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = -12, stress = -55 }, time = 40, visualEffects = {["rply_saturation"] = 1.0}},
			anim = {dict = "amb@world_human_aa_smoke@male@idle_a", clip = "idle_c"},  --Smoke Joint One--
			prop = {
				model = 'prop_sh_joint_01',
				bone = 57005,
				pos = {x = 0.16, y = 0.01, z = 0.02},
				rot = {x = -158.0, y = 78.0, z = 16.0},
			},
			usetime = 5000,
		},
	},

	['sotw_bong'] = {
		label = 'Eighth Of Hawick Haze', --Special useage--
		description = "A do it yourself kit for getting stoned.",
		weight = 1000,
		stack = true,
		close = true,
	    
	},

	['sotw_brownie'] = {
		label = 'Brownie',
		description = "The classic pot brownie.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 55, water = -5}, time = 80, visualEffects = {["rply_saturation"] = 1.0}},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'prop_choc_ego',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['sotw_dab_pen'] = {
		label = 'Magic Mushrooms',
		description = "Forgetting about reality one Fungi at a time.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 30, water = 20, stress = -60, speed = 0.68}, toxicity = 2.5,  time = 240, visualEffects = {["rply_saturation"] = 1.0}},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  -- eat candy--
			prop = {
				model = 'prop_candy_pqs',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = 448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['sotw_gummies'] = {
		label = 'Cannabis Cane',
		description = "A peppermint candy cane that will have you laid back and relaxed this holiday season.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 55, stress = -25}, time = 80, visualEffects = {["rply_saturation"] = 1.0}},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat candycane customprop--
			prop = {
				model = 'bzzz_food_xmas_lollipop_b',
				bone = 18905,
				pos = {x = 0.16, y = 0.02, z = 0.03},
				rot = {x = 73.0, y = 146.0, z = 5.0},
			},
			usetime = 5000,
		},
	},

	['iced_tea'] = {
		label = 'Moon Juice',
		description = "A blue raspberry cannabis infused drink that will send you to the moon!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 75, stress = -20}, time = 10, visualEffects = {["rply_saturation"] = 1.0}},
			anim = {dict = "mp_player_inteat@pnq", clip = "loop"},  --Drink bottle Water--
			prop = {
				model = 'vw_prop_casino_water_bottle_01a',
				bone = 18905,
				pos = {x = 0.05, y = -0.1, z = 0.07},
				rot = {x = -72.0, y = 58.0, z = -30.0},
			},
			usetime = 5000,
		},
	},

	['blunt_wrap'] = {
		label = 'Blunt Wrap', --Special Effects--
		description = "Tobacco leaves to wrap your weed.",
		weight = 1000,
		stack = true,
		close = true,
	},

	--Slurp n Go--
	['sng_banana_cream'] = {
		label = 'Fender Bender Banana  Rollup',
		description = "Mind your manners as you eat these nanners.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 40,  stress = -30}, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Hot two--
			prop = {
				model = 'prop_food_coffee',
				bone = 57005,
				pos = {x = 0.11, y = 0.0, z = -0.05},
				rot = {x = -70.0, y = 110.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['sng_coconut_slushy'] = {
		label = 'Crankshaft Coconut Slushy',
		description = "Get off that butt and slurp my coconut.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { water = 50, stress = -40}, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_orang_can_01',
				bone = 57005,
				pos = {x = 0.11, y = 0.01, z = -0.03},
				rot = {x = -60.0, y = 45.0, z = -7.0},
			},
			usetime = 5000,
		},
	},

	['sng_dragon_cream'] = {
		label = 'Driftin Dragon Fruit Rollup',
		description = "With this sweet dragon fruit, you'll be baggin loot.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 50,  stress = -40}, time = 30,},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Hot two--
			prop = {
				model = 'prop_food_coffee',
				bone = 57005,
				pos = {x = 0.11, y = 0.0, z = -0.05},
				rot = {x = -70.0, y = 110.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['sng_grape_slushy'] = {
		label = 'Gearshitin Grape Slushy',
		description = "Kicking these grapes, spittin on mixtapes.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 35, stress = -25}, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_orang_can_01',
				bone = 57005,
				pos = {x = 0.11, y = 0.01, z = -0.03},
				rot = {x = -60.0, y = 45.0, z = -7.0},
			},
			usetime = 5000,
		},
	},

	['sng_icepack'] = {
		label = 'Slurp N Go Ice', --Special Effects--
		description = "Hit your head off the dash while on a cruise, don't worry put this ice pack on that bruise.",
		weight = 1000,
		stack = true,
		close = true,
	},

	['sng_melon_slushy'] = {
		label = 'Motor Oil Melon Slushy',
		description = "Smashing melons, so we don't become felons.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 40, stress = -30}, time = 30,},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_orang_can_01',
				bone = 57005,
				pos = {x = 0.11, y = 0.01, z = -0.03},
				rot = {x = -60.0, y = 45.0, z = -7.0},
			},
			usetime = 5000,
		},
	},

	['sng_rootbeer_cream'] = {
		label = 'Revin Rootbeer Rollup',
		description = "Ice cream flavored with root beer, so you don't shoot y'hear.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 35,  stress = -25}, time = 30,},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Hot two--
			prop = {
				model = 'prop_food_coffee',
				bone = 57005,
				pos = {x = 0.11, y = 0.0, z = -0.05},
				rot = {x = -70.0, y = 110.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['sng_strawberry_cream'] = {
		label = 'Speedin Strawberry Rollup',
		description = "Best to be wary, now eat the strawberry.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = { food = 60,  stress = -50}, time = 30,},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Hot two--
			prop = {
				model = 'prop_food_coffee',
				bone = 57005,
				pos = {x = 0.11, y = 0.0, z = -0.05},
				rot = {x = -70.0, y = 110.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['sng_tangerine_slushy'] = {
		label = 'Tyre Spin Tangerine Slushy',
		description = "Mmm tasty tangerine, better wipe that mouth clean.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 60, stress = -50}, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_orang_can_01',
				bone = 57005,
				pos = {x = 0.11, y = 0.01, z = -0.03},
				rot = {x = -60.0, y = 45.0, z = -7.0},
			},
			usetime = 5000,
		},
	},

	--Maisonette--
    ['maisonette_burnside'] = {
		label = 'Burnside Bastard',
		description = "Theres no coming back from the Burnside Bastard!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 60, food = -10,}, visualEffects = {["Drunk"] = 1.0}, time = 30},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Whiskey--
			prop = {
				model = 'prop_drink_whisky',
				bone = 57005,
				pos = {x = 0.11, y = -0.04, z = -0.06},
				rot = {x = -76.0, y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
	},

	['maisonette_jimmycooler'] = {
		label = 'Jimmy Cooler',
		description = "Feel cool, like Jimmy Cool!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 30, food = -10}, time = 30, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Whiskey--
			prop = {
				model = 'prop_drink_whisky',
				bone = 57005,
				pos = {x = 0.11, y = -0.04, z = -0.06},
				rot = {x = -76.0, y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
    },

	['maisonette_prawntoast'] = {
		label = 'Prawn Toast',
		description = "Why did the prawn leave the night club early? Because he pulled a muscle.......",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 50, water = -10 }, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				}
			},
			usetime = 15000,
		},
	},

	['maisonette_rocher'] = {
		label = 'Chocolate Rocher',
		description = "For those with a sweet tongue.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {water = -15, food = 15}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'prop_choc_ego',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	['maisonette_tickler'] = {
		label = 'Tony Tickler',
		description = "You will feel this one going alllllll the way down……",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = -15,}, time = 10},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Whiskey--
			prop = {
				model = 'prop_cocktail_glass',
				bone = 57005,
				pos = {x = 0.11, y = -0.04, z = -0.06},
				rot = {x = -76.0, y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
	},

	['maisonette_flaming'] = {
		label = 'The Flaming Fae-tality',
		description = "It's Poppin!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 30, food = -10}, visualEffects = {["Drunk"] = 1.0}, time = 20},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Whiskey--
			prop = {
				model = 'prop_drink_whisky',
				bone = 57005,
				pos = {x = 0.11, y = -0.04, z = -0.06},
				rot = {x = -76.0, y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
	},

	['maisonette_444'] = {
		label = '444 Energy',
		description = "For that pick me up",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 15, food = -10}, time = 30, visualEffects = {["WATER_muddy"] = 1.0}}, 
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'sf_prop_sf_can_01a',
				bone = 57005,
				pos = {x = 0.13, y = 0.01, z = -0.03},
				rot = {x = 8-75.0, y = 0.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['maisonette_fizzler'] = {
		label = 'Rizzle Fizzler',
		description = " Fizzzzzzz Rizzzzzzzzzz",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = -10}, time = 25},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'sf_prop_sf_can_01a',
				bone = 57005,
				pos = {x = 0.13, y = 0.01, z = -0.03},
				rot = {x = 8-75.0, y = 0.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['maisonette_pinkslip'] = {
		label = 'Pink Slip',
		description = " PINK PINK PINK!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = -10}, time = 25, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Whiskey--
			prop = {
				model = 'prop_drink_whisky',
				bone = 57005,
				pos = {x = 0.11, y = -0.04, z = -0.06},
				rot = {x = -76.0, y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
	},

	['maisonette_platter'] = {
		label = 'The Paulie Platter',
		description = " In Memory of an Old Legend",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = -10, food = 20, armor = 15}, toxicity = 4.5, time = 60},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'prop_choc_ego',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	--Glizzy Comics--
	['glizzy_statue'] = {
		label = 'Glizzy\'s Blank Action Figurine', --Special Effects--
		weight = 500,
		stack = true,
		close = true,
		description = "An unpainted and unmolded action figurine"
	},

	['gacha_capsule'] = {
		label = 'Glizzy\'s Gacha Capsule', --Special Effects--
		description = "Random figurine from Glizzy Comics",
		weight = 1000,
		stack = false,
		close = true,
		client = {
			anim = {dict = "impexp_int-0", clip = 'mp_m_waremech_01_dual-0'}, 
			prop = {
				model = 'glizzy_gacha', --custom prop inside mlo
				bone = 18905,
				pos = {x = 0.14, y = 0.02, z = 0.08},
				rot = {x = 260.0, y = 70, z = -10.0},
			},
			usetime = 5000,
		},
	},
		

	['collectible_pouch'] = {
		label = 'Glizzy\'s Collectible Pouch', --Special Effects--
		description = "Pouch to store all your figurines from Glizzys!",
		weight = 1000,
		stack = false,
		close = false,
	},

	['arthur_kildare_plushie'] = {
		label = 'Arthur Kildare Plushie', --Seasonal Item--
		description = "His name is on a building",
		weight = 1000,
		stack = false,
		close = false,
	},

	['bikinitow_plushie'] = {
		label = 'Bikini Tow Plushie', --Seasonal Item--
		description = "Limted Edition Bikini Tow Plushie. Only 50 Made",
		weight = 1000,
		stack = false,
		close = false,
	},

	['hotdog_water'] = {
		label = 'Hotdog Water',
		description = "Chunky HotDogs stewed in a warm drink",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 15, water = 30, stress = 20}, time = 15},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink water--
			prop = {
				model = 'prop_ld_flow_bottle',
				bone = 57005,
				pos = {x = 0.14, y = 0.01, z = -0.02},
				rot = {x = -117.0, y = -108.0, z = 0.02},
			},
			usetime = 5000,
		},
	},

	['glizzy_mason_bodypillow'] = {
		label = 'Mason Body Pillow',
		description = "A great alternative for a friend ",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { stress = -30}, time = 10},
			anim = {dict = "random@shop_gunstore", clip = '_idle'}, --Hold pillow--
			prop = {
				model = 'glizzy_pillow_mason',
				bone = 18905,
				pos = {x = 0.0, y = -0.03, z = 0.59},
				rot = {x = -6.0, y = 180.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['glizzy_jynx_bodypillow'] = {
		label = 'Jynx Body Pillow',
		description = "A great alternative for a friend ",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { stress = -30}, time = 10},
			anim = {dict = "random@shop_gunstore", clip = '_idle'}, --Hold pillow--
			prop = {
				model = 'glizzy_pillow_jynx',
				bone = 18905,
				pos = {x = 0.0, y = -0.03, z = 0.59},
				rot = {x = -6.0, y = 180.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['glizzy_hotdog'] = {
		label = 'Glizzys Glizzy',
		description = "The wiener the world awaited",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 75}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = 'mp_player_int_eat_burger'},  
			prop = {
				model = 'prop_cs_hotdog_01',
				bone = 18905,
				pos = {x = 0.13, y = 0.01, z = 0.04},
				rot = {x = -148.0, y = 308.0, z = 184.0},
			},
			usetime = 5000,
		},
	},

	['glizzys_cotton_candy'] = {
		label = 'Glizzys Cotton Candy ',
		description = "Don't be rotten, eat some cotton ",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 75}, time = 15},
			anim = {dict = "anim@heists@humane_labs@finale@keycards", clip = 'ped_a_enter_loop'},  
			prop = {
				model = 'glizzy_cc',
				bone = 18905,
				pos = {x = 0.11, y = 0.02, z = 0.02},
				rot = {x = -83.0, y = 57.0, z = -12.0},
			},
			usetime = 7000,
		},
	},

	--Bikini Automotive--
	['blinker_fluid'] = {
		label = 'Blinker Fluid',
		description = "All Natural, Organic, but with a Kick of caffeine.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, stress = 10, stamina = 1, speed = 1.15 }, toxicity = 1.0, time = 30,},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  
			prop = {
				model = 'blinker_normal',
				bone = 57005,
				pos = {x = 0.09, y = -0.15, z = -0.07},
				rot = {x = 68.0, y = 44.0, z = 178.0},
			},
			usetime = 5000,
		},
	},

	['blinker_fluid_red'] = {
		label = 'Blinker Fluid Code Red',
		description = "All Natural, Organic, but with a rush of cherry flavor.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 30, stress = -30},time = 15,},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  
			prop = {
				model = 'blinker_red',
				bone = 57005,
				pos = {x = 0.09, y = -0.15, z = -0.07},
				rot = {x = 68.0, y = 44.0, z = 178.0},
			},
			usetime = 5000,
		},
	},

	['blinker_fluid_baja'] = {
		label = 'Blinker Fluid Baja Blast',
		description = "All Natural, Organic, but with a Kick of Baja Blast.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 60,},time = 15,},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  
			prop = {
				model = 'blinker_baja',
				bone = 57005,
				pos = {x = 0.09, y = -0.15, z = -0.07},
				rot = {x = 68.0, y = 44.0, z = 178.0},
			},
			usetime = 5000,
		},
	},

	['beefy_oil_burrito'] = {
		label = 'Beefy Oil Burrito',
		description = "So much beef you won't know what to do with it",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 75}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = 'mp_player_int_eat_burger'},  
			prop = {
				model = 'monster_burrito_01a',
				bone = 18905,
				pos = {x = 0.07, y = -0.11, z = 0.07},
				rot = {x = -66.0, y = 112.0, z = -11.0},
			},
			usetime = 5000,
		},
	},

	['bikini_pizza'] = {
		label = 'Bikini Pizza Slice',
		description = "Giant Slice Of Peperoni Pizza",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { food = 75}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = 'mp_player_int_eat_burger'},  
			prop = {
				model = 'knjgh_pizzaslice5',
				bone = 18905,
				pos = {x = 0.14, y = -0.07, z = 0.05},
				rot = {x = 20.0, y = 146.0, z = -4.0},
			},
			usetime = 5000,
		},
	},

	['comealong'] = {  --Special Effect--
		label = 'Ratchet Straps',
		description = "Can't drive? Flipped your car? Then just hook me up and flip it over.",
		weight = 10000,
		stack = false,
		close = true,
	},

	--Scythes smiths--
	['knifeshop_bag'] = {
		label = ' Apparel Bag', --storage effects
		weight = 1000,
		stack = false,
		close = true,
		description = "Carry your hats and masks with you anywhere you go!"
	},

	['knifebag'] = {
		label = 'Knife Bag', --storage effects
		weight = 1000,
		stack = false,
		close = true,
		description = "Carry all you knifes in a nice bag!"
	},

	--reapers bike shop
	['reapers_popcorn'] = {
		label = 'Fire in the Sky Popcorn', 
		description = "Caution: Youll probably need some water after this snack.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = -15, stress = 10, food = 50},time = 15},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --eat popcorn
			prop = {
				model = 'xs_prop_trinket_cup_01a',
				bone = 18905,
				pos = {x = 0.16, y = 0.0, z = 0.03},
				rot = {x = -70.0, y = 14.0, z = 42.0},
			},
			usetime = 15000
		},
	},

	['reapers_energy'] = {
		label = 'Tar Snakes Energy Drink', 
		description = "Get your adrenaline going as if you were on a bike with this drink!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = -10}, time = 15}, 
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'sf_prop_sf_can_01a',
				bone = 57005,
				pos = {x = 0.13, y = 0.01, z = -0.03},
				rot = {x = 8-75.0, y = 0.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['reapers_vest'] = {
		label = 'Leather Vest', --Armor effects
		description = "Protect yourself from road rash with a leather vest!",
		weight = 5000,
		stack = true,
		close = true,
		
	},

	--Clinic--
	['bepto_pismol'] = {
		label = 'Bepto Pismol', 
		description = " A medicine to treat heartburn and indigestion",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 40, stress = -50, health = 20}, time = 110},
			anim = {dict = "mp_player_inteat@pnq", clip = "loop"},  --Drink Shot--
			prop = {
				model = 'p_cs_shot_glass_2_s',
				bone = 18905,
				pos = {x = 0.13, y = 0.01, z = 0.02},
				rot = {x = 241.0, y = 264.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	['clinic_wheelchair'] = {
		label = 'Wheelchair', 
		description = "A Medical Transportation Device",
		weight = 10000,
		stack = false,
		close = true,
		degrade = 2880 -- 48 hours
	},

	['clinic_prescription'] = { --no effects just used for RP 
		label = 'Prescription Medication',  
		description = "General Prescription Medicine",
		weight = 1000,
		stack = false,
		close = true,
		degrade = 10080 -- 168 hours or 7 days
	},

	['raw_medical'] = { --
		label = 'Medical Ingredients',  
		description = "A box of general medical ingredients to make medication",
		weight = 1000,
		stack = true,
		close = true,
	},

	---Finnis Taxi---
	['finnis_airfresh'] = {
		label = 'Car AirFreshener', 
		description = "A Strong Scented AirFreshener",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { stress = -50, water = -10}, time = 15},
			anim = {dict = "move_p_m_two_idles@generic", clip = 'fidget_sniff_fingers'},   --snifff --
			prop = {
				model = 'reh_prop_reh_keycard_01a',
				bone = 57005,
				pos = {x = 0.12, y = -0.03, z = -0.03},
				rot = {x = -90.0, y = 180.0, z = 0.0},
			},
			usetime = 5000,
		},
	},

	---Kildares---
	['zebra_bar'] = {
		label = 'Zebra Bar', 
		description = "Zebra Candy",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 30, water = -15 }, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'prop_choc_ego',
				bone = 18905,
				pos = {x = 0.13, y = 0.06, z = 0.00},
				rot = {x = -448.0, y = 408.0, z = 239.0},
			},
			usetime = 5000,
		},
	},

	
	---KOI---
	['koi_soju'] = {
		label = 'Soju', 
		description = "Traditional Korean distilled spirit",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = -10}, time = 60, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},  --Drink Beer Bottle one--
			prop = {
				model = 'prop_beer_logopen',
				bone = 57005,
				pos = {x = 0.12, y = -0.12, z = -0.06},
				rot = {x = -78.0, y = 81.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['koi_thaitea'] = {
		label = 'Thai Tea', 
		description = "Relaxing orange tea",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 60, stress = -20}, time = 15},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Orange--
			prop = {
				model = 'prop_tequsunrise',
				bone = 57005,
				pos = {x = 0.13, y = -0.11, z = -0.09},
				rot = {x = -66.0, y = 36.0, z = 6.0},
			},
			usetime = 5000,
		},	
	},

	['koi_rangoon'] = {
		label = 'Rangoon', 
		description = "Scrumptious and stuffed puffed pastry",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 30, water = -10 }, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'bzzz_foodpack_croissant001',
				bone = 18905,
				pos = {x = 0.12, y = 0.02, z = 0.04},
				rot = {x = -168.0, y = 57.0, z =-18.0},
			},
			usetime = 5000,
		},
	},

	['koi_pho'] = {
		label = 'Pho', 
		description = "Pho-king delicious!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 55, water = 20, stress = -10}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate Fast--
			prop = {
				{
					model = 'scully_pho',
					bone = 60309,
					pos = {x = 0.00, y = 0.03, z = 0.01},
					rot = {x = 0.00, y = 0.00, z = 0.00},
				},
				{
					model = 'scully_spoon_pho',
					bone = 28422,
					pos = {x = 0.00, y = 0.00, z = 0.0},
					rot = {x = 0.0, y = 0.0, z = 0.0},
				}
			},
			usetime = 15000,
		},
	},

	['koi_omurice'] = {
		label = 'Omurice', 
		description = "Homemade Japanese staple of rice covered in a thin layer of fried scrambled eggs.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 55, water = 20}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate Fast--
			prop = {
				{
					model = 'prop_cs_bowl_01b',
					bone = 60309,
					pos = {x = 0.00, y = 0.03, z = 0.01},
					rot = {x = 0.00, y = 0.00, z = 0.00},
				},
				{
					model = 'scully_spoon_pho',
					bone = 28422,
					pos = {x = 0.00, y = 0.00, z = 0.0},
					rot = {x = 0.0, y = 0.0, z = 0.0},
				}
			},
			usetime = 15000,
		},
	},
	
	['koi_sushi'] = {
		label = 'Sushi', 
		description = "Fresher than Vinny himself.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 65}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'koi_sushi_plate',
					bone = 18905,
					pos = {x = 0.23, y = 0.04, z = 0.08},
					rot = {x = -55.0, y = -55.0, z = -5.0},
				},
				{
					model = 'koi_chopsticks',
					bone = 57005,
					pos = {x = 0.11, y = 0.03, z = 0.00},
					rot = {x = -48.0, y = -104.0, z = -30.0},
				}
			},
			usetime = 15000,
		},
	},

	['koi_dumplings'] = {
		label = 'Dumplings ', 
		description = "Boiled, steamed, pan seared, or fried deliciousness.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 30, water = -10}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'bzzz_foodpack_croissant001',
				bone = 18905,
				pos = {x = 0.12, y = 0.02, z = 0.04},
				rot = {x = -168.0, y = 57.0, z =-18.0},
			},
			usetime = 5000,
		},
	},

	['koi_taiyaki'] = {
		label = 'Taiyaki', 
		description = "Koi shaped cake cone with fillings as sweet as Violet",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 30, stress = -20}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'bzzz_icecream_cherry',
				bone = 18905,
				pos = {x = 0.14, y = 0.03, z = 0.01},
				rot = {x = 85.00, y = 70.0, z = -203.0},
			},
			usetime = 5000,
		},
	},

	['koi_bentobox'] = {   --storage effects
		label = 'Bento Box',  
		description = "Sleek container to keep your food fresh.",
		weight = 1000,
		stack = false,
		close = true,
	},

	['koi_cookie'] = {
		label = 'Fortune Cookie', 
		description = "Caution: Paper & ominous fortune inside.",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = {food = 30, water = -10}, time = 15},
			anim = {dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger"},  --Eat Choco--
			prop = {
				model = 'bzzz_foodpack_croissant001',
				bone = 18905,
				pos = {x = 0.12, y = 0.02, z = 0.04},
				rot = {x = -168.0, y = 57.0, z =-18.0},
			},
			usetime = 5000,
		},
	},

	---Rose and crown---
	['rc_tonicwine'] = {
		label = 'Buckfast Tonic Wine', 
		description = "We took it from the French, to give it to you...",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = -10}, time = 60, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},  --Drink Beer Bottle one--
			prop = {
				model = 'prop_beer_logopen',
				bone = 57005,
				pos = {x = 0.12, y = -0.12, z = -0.06},
				rot = {x = -78.0, y = 81.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['rc_crumpets'] = {
		label = 'Crumpets', 
		description = "What's round and sounds like a trumpet? A Crumpet of course!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 50}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	['rc_fishchips'] = {
		label = 'Fish and Chips', 
		description = "You just can't go worng with some Fish & Chips, can you?",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 65}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	['rc_gingerbeer'] = {
		label = 'Ginger Beer Soda Pop', 
		description = "Want some ginger tang?",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 50, food = -10}, time = 60, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'},  --Drink Beer Bottle one--
			prop = {
				model = 'prop_beer_logopen',
				bone = 57005,
				pos = {x = 0.12, y = -0.12, z = -0.06},
				rot = {x = -78.0, y = 81.0, z = 6.0},
			},
			usetime = 5000,
		},
	},

	['rc_honeymead'] = {
		label = 'Honey Mead', 
		description = "Let the bees do the hard work for you, while you sip away....",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 40, stress = -10}, time = 30, visualEffects = {["Drunk"] = 1.0}},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a"},  --Drink Whiskey--
			prop = {
				model = 'prop_drink_whisky',
				bone = 57005,
				pos = {x = 0.11, y = -0.04, z = -0.06},
				rot = {x = -76.0, y = 112.0, z = 17.0},
			},
			usetime = 5000,
		},
	},
	
	['rc_cornishpasty'] = {
		label = 'Cornish Pasty', 
		description = "Make sure to clean the crumbs up!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 65}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	['rc_roast'] = {
		label = 'English Roast Dinner', 
		description = "Beef, turkey & lamb... The choice is yours to make!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 65}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	['rc_spongcake'] = {
		label = 'Victoria Sponge Cake', 
		description = "MMmm... Cake!",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 65}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	['rc_tea'] = {   
		label = 'English Tea',  
		description = "Make tea, not war...",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = {effects = { water = 20, stress = -10}, time = 10},
			anim = {dict = "amb@world_human_drinking@coffee@male@idle_a", clip = 'idle_a'}, --Drink Cocktail--
			prop = {
				model = 'p_ing_coffeecup_02',
				bone = 57005,
				pos = {x = 0.13, y = -0.05, z = -0.05},
				rot = {x = 84.0, y = 27.0, z = 185.0},
			},
			usetime = 5000,
		},
	},

	['rc_bangersmash'] = {
		label = 'Bangers And Mash', 
		description = "Want some more gravy on that mash, sir?",
		weight = 1000,
		stack = true,
		close = true,
		client = {
			status = { effects = {food = 65}, time = 30},
			anim = {dict = "anim@scripted@island@special_peds@pavel@hs4_pavel_ig5_caviar_p1", clip = 'base_idle'}, --Eat Plate-
			prop = {
				{
					model = 'prop_plate_03',
					bone = 18905,
					pos = {x = 0.17, y = 0.05, z = 0.06},
					rot = {x = -55.0, y = -20.0, z = 10.0},
				},
				{
					model = 'prop_cs_fork',
					bone = 57005,
					pos = {x = 0.12, y = 0.05, z = 0.0},
					rot = {x = -18.0, y = -59.0, z = -12.0},
				},
			},
			usetime = 15000,
		},
	},

	-- Weapon Stuffs --
	['assaultrifle_reciever'] = {
		label = 'Assault Rifle Reciever',
		weight = 5000,
		stack = true,
		close = false,
		description = "Parts to an assault rifle\'s lower reciever"
	},
	['assaultrifle_barrel'] = {
		label = 'Assault Rifle Barrel',
		weight = 1500,
		stack = true,
		close = false,
		description = "An assault rifle\'s barrel"
	},
	['assaultrifle_stock'] = {
		label = 'Assault Rifle Stock',
		weight = 2000,
		stack = true,
		close = false,
		description = "An assault rifle\'s stock"
	},
}