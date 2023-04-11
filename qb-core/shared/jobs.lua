QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = false -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Freelancer',
                payment = 50
            },
        },
	},
	['marshalls'] = {
		label = 'Marshals',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Marshal',
				isboss = true,
				payment = 550
            },
        },
	},
	['lspd'] = {
		label = 'LSPD',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Officer',
				payment = 450
            },
			['1'] = {
                name = 'Corporal',
				payment = 475
            },
			['2'] = {
                name = 'Sergeant',
				payment = 475
            },
			['3'] = {
                name = 'Lieutenant',
				payment = 475
            },
			['4'] = {
                name = 'Captain',
				isboss = true,
				payment = 500
            },
        },
	},
	['bcso'] = {
		label = 'BCSO',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Deputy',
				payment = 450
            },
			['1'] = {
                name = 'Senior Deputy',
				payment = 475
            },
			['2'] = {
                name = 'Chief Deputy',
				payment = 475
            },
			['3'] = {
                name = 'UnderSheriff',
				payment = 475
            },
			['4'] = {
                name = 'Sheriff',
				isboss = true,
				payment = 500
            },
        },
	},
	['sast'] = {
		label = 'SAST',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Trooper',
				payment = 450
            },
			['1'] = {
                name = 'Super Trooper',
				payment = 475
            },
			['2'] = {
                name = 'Master Trooper',
				payment = 475
            },
			['3'] = {
                name = ' Lieutenant',
				payment = 475
            },
			['4'] = {
                name = 'Captain',
				isboss = true,
				payment = 500
            },
        },
	},
    ['pd_cid'] = {
		label = 'CID',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Investigator',
				payment = 450
            },
			['1'] = {
                name = 'Detective',
				payment = 475
            },
			['2'] = {
                name = 'Field Agent',
				payment = 475
            },
			['3'] = {
                name = 'Lead Agent',
				payment = 475
            },
			['4'] = {
                name = 'Director',
				isboss = true,
				payment = 500
            },
        },
	},
	['hc'] = {
		label = 'High Command',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Major',
				isboss = true,
				payment = 550
            },
			['1'] = {
                name = 'Commander',
				isboss = true,
                payment = 550
            },
			['2'] = {
                name = 'Asst. Chief',
				isboss = true,
				payment = 550
            },
			['3'] = {
                name = 'Chief',
				isboss = true,
				payment = 550
            },
			['4'] = {
                name = 'Commissioner',
				isboss = true,
				payment = 550
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'EMT',
				payment = 450
            },
			['1'] = {
                name = 'Paramedic',
				payment = 475
            },
			['2'] = {
                name = 'Lieutenant',
				payment = 500
            },
			['3'] = {
                name = 'Captain',
				payment = 525
            },
			['4'] = {
                name = 'Assistant Chief',
				isboss = true,
				payment = 550
            },
			['5'] = {
                name = 'Chief',
				isboss = true,
				payment = 550
            },
        },
	},
    ['fire'] = {
		label = 'Fire Department',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Firefighter',
				payment = 25
            },
        },
	},
	['government'] = {
		label = 'Government Employee',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Clerk',
				payment = 350
            },
			['1'] = {
                name = 'City Council',
				payment = 450
            },
            ['2'] = {
                name = 'Judge',
				payment = 450,
                isboss = true,
            },
			['3'] = {
                name = 'Mayor',
				payment = 550,
                isboss = true,
            },
			['4'] = {
                name = 'Congressman',
				isboss = true,
				payment = 10
            },
			['5'] = {
                name = 'Senator',
				isboss = true,
				payment = 10
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 50
            },
			['1'] = {
                name = 'Driver',
                payment = 75
            },
			['2'] = {
                name = 'Event Driver',
                payment = 100
            },
			['3'] = {
                name = 'Sales',
                payment = 125
            },
			['4'] = {
                name = 'Manager',
				isboss = true,
                payment = 150
            },
        },
	},
	['lawyer'] = {
		label = 'Law Firm',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Associate',
                payment = 400
            },
        },
	},
	['tow'] = {
		label = 'SADOT',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 415
            },
			['1'] = {
                name = 'Probationary Operator',
                payment = 425
            },
			['2'] = {
                name = 'Operator',
                payment = 450
            },
			['3'] = {
                name = 'Senior Operator',
                payment = 475
            },
			['4'] = {
                name = 'Team Leader',
                payment = 500
            },
			['5'] = {
                name = 'Supervisor',
                payment = 500
            },
			['6'] = {
                name = 'Manager',
                isboss = true,
                payment = 525
            },
			['7'] = {
                name = 'HR Manager',
				isboss = true,
                payment = 550
            },
			['8'] = {
                name = 'Inspector General',
				isboss = true,
                payment = 550
            },
			['9'] = {
                name = 'Deputy Chief Of Staff',
				isboss = true,
                payment = 550
            },
			['10'] = {
                name = 'Chief of Staff',
				isboss = true,
                payment = 550
            },
			['11'] = {
                name = 'Commissioner',
				isboss = true,
                payment = 550
            },
        },
	},

	-- BUSINESSES
	['yellowjack'] = { -- open road
		label = 'Open Road',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Bartender',
				payment = 0
            },
			['1'] = {
                name = 'Head Bartender',
				payment = 0
            },
            ['2'] = {
                name = 'Manager',
                isboss = true,
				payment = 0
            },
            ['3'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
	['gopostal'] = {
		label = 'GoPostal',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'New Hire',
				payment = 0
            },
			['1'] = {
                name = 'Worker',
				payment = 0
            },
			['2'] = {
                name = 'Pilot',
				payment = 0
            },
			['3'] = {
                name = 'Supervisor',
                isboss = true,
				payment = 0
            },
			['4'] = {
                name = 'CEO',
                isboss = true,
				payment = 0
            },
        },
	},
	['tequilala'] = { -- skull island
		label = 'Tequi-la-la',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'DJ',
				payment = 0
            },
			['1'] = {
                name = 'Security',
				payment = 0
            },
			['2'] = {
                name = 'Bartender',
				payment = 0
            },
			['3'] = {
                name = 'Bartender 2',
				payment = 0
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
				payment = 0
            },
			['5'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
	['glazedandglorious'] = {
		label = 'Glazed and Glorious',
		defaultDuty = true,
		grades = {
			['0'] = {
                name = 'Barista',
				payment = 0
            },
			['1'] = {
                name = 'Baker',
				payment = 0
            },
			['2'] = {
                name = 'Manager',
                isboss = true,
				payment = 0
            },
            ['3'] = {
                name = 'CEO',
                isboss = true,
				payment = 0
            },
			['4'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
	['smokeonthewater'] = {
		label = 'Smoke On The Water',
		defaultDuty = true,
		grades = {
			['0'] = {
                name = 'Budtender',
				payment = 0
            },
			['1'] = {
                name = 'Manager',
                isboss = true,
				payment = 0
            },
			['2'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
	['vanillaunicorn'] = {
		label = 'Vanilla Unicorn',
		defaultDuty = true,
		grades = {
			['0'] = {
                name = 'Bartender',
				payment = 0
            },
			['1'] = {
                name = 'Security',
				payment = 0
            },
			['2'] = {
                name = 'Dancer',
				payment = 0
            },
			['3'] = {
                name = 'Head Security',
				payment = 0
            },
			['4'] = {
                name = 'Head Dancer',
				payment = 0
            },
			['5'] = {
                name = 'Manager',
				payment = 0
            },
			['6'] = {
                name = 'CEO',
                isboss = true,
				payment = 0
            },
			['7'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
    ['finnistaxi'] = {
		label = 'Finni\'s Taxi',
		defaultDuty = true,
		grades = {
			['0'] = {
                name = 'Employee',
				payment = 0
            },
            ['1'] = {
                name = 'Manager',
                isboss = true,
				payment = 0
            },
			['2'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
    ['tenfourtwo'] = {
		label = '10-42',
		defaultDuty = true,
		grades = {
			['0'] = {
                name = 'Security',
				payment = 0
            },
            ['1'] = {
                name = 'Chef',
				payment = 0
            },
            ['2'] = {
                name = 'Bartender',
				payment = 0
            },
            ['3'] = {
                name = 'Bar Manager',
                isboss = true,
				payment = 0
            },
			['4'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
    ['nismostuning'] = {
		label = 'Nismo\'s Tuning',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Apprentice',
				payment = 0
            },
			['1'] = {
                name = 'Mechanic',
				payment = 0
            },
            ['2'] = {
                name = 'Sales',
				payment = 0
            },
            ['3'] = {
                name = 'Head Mechanic',
				payment = 0
            },
            ['4'] = {
                name = 'Supervisor',
                isboss = true,
				payment = 0
            },
            ['5'] = {
                name = 'Manager',
                isboss = true,
				payment = 0
            },
            ['6'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
    ['bikinitow'] = { -- bikini automotive
		label = 'Bikini Automotive',
		defaultDuty = true,
		grades = {
			['0'] = {
                name = 'Mechanic',
				payment = 0
            },
            ['1'] = {
                name = 'Senior Mechanic',
				payment = 0
            },
            ['2'] = {
                name = 'Supervisor',
				payment = 0
            },
            ['3'] = {
                name = 'Manager',
                isboss = true,
				payment = 0
            },
			['4'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
    ['slurpngo'] = {
		label = 'Slurp n Go',
		defaultDuty = true,
		grades = {
			['0'] = {
                name = 'Cashier',
				payment = 0
            },
            ['1'] = {
                name = 'Car Wash Attendant',
				payment = 0
            },
            ['2'] = {
                name = 'Gas Pump Attendant',
				payment = 0
            },
			['3'] = {
                name = 'Manager',
                isboss = true,
				payment = 0
            },
            ['4'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
    ['beaveraviation'] = {
		label = 'Flying Beaver Aviation',
		defaultDuty = true,
		grades = {
			['0'] = {
                name = 'Flight Instructor',
				payment = 0
            },
			['1'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
    ['paintball'] = {
		label = 'Ball Breakers',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employee',
				payment = 0
            },
			['1'] = {
                name = 'Referee',
				payment = 0
            },
			['2'] = {
                name = 'Owner',
                isboss = true,
				payment = 0
            },
        },
	},
    ['cardealer'] = {
		label = 'Vehicle Dealer',
		defaultDuty = false,
        offDutyPay = 25,
		grades = {
			['0'] = {
                name = 'Employee',
                payment = 0
            },
			['1'] = {
                name = 'Salesperson',
                payment = 0
            },
			['2'] = {
                name = 'Management',
                isboss = true,
                payment = 0
            },
			['3'] = {
                name = 'Owner',
				isboss = true,
                payment = 0
            },
        },
	},
    ['realestate'] = {
		label = 'Wolfs Real Estate',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Receptionist',
                payment = 0
            },
			['1'] = {
                name = 'Recruit',
                payment = 0
            },
			['2'] = {
                name = 'Real Estate Sales',
                payment = 0
            },
			['3'] = {
                name = 'Real Estate Manager',
                payment = 0
            },
			['4'] = {
                name = 'Owner / Broker',
				isboss = true,
                payment = 0
            },
        },
	},
    ['glizzycomics'] = {
		label = 'Glizzy Comics',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Security',
                payment = 0
            },
            ['1'] = {
                name = 'Sales Associate',
                payment = 0
            },
			['2'] = {
                name = 'Artist',
                payment = 0
            },
            ['3'] = {
                name = 'Events Manager',
                payment = 0
            },
			['4'] = {
                name = 'Management',
                isboss = true,
                payment = 0
            },
			['5'] = {
                name = 'Owner',
                isboss = true,
                payment = 0
            },
        },
	},
    ['maisonette'] = {
		label = 'Maisonette',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Employee',
                payment = 0
            },
			['1'] = {
                name = 'Supervisor',
                payment = 0
            },
            ['2'] = {
                name = 'Manager',
                isboss = true,
                payment = 0
            },
            ['3'] = {
                name = 'Lead Manager',
                isboss = true,
                payment = 0
            },
            ['4'] = {
                name = 'Owner',
                isboss = true,
                payment = 0
            },
        },
	},
    ['knifeshop'] = {
		label = 'Scythe Smiths',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'sellers',
                payment = 0
            },
            ['1'] = {
                name = 'blacksmiths',
                payment = 0
            },
            ['2'] = {
                name = 'Manager',
                isboss = true,
                payment = 0
            },
            ['3'] = {
                name = 'Owner',
                isboss = true,
                payment = 0
            },
        },
	},
    ['bikedealer'] = {
		label = 'Reapers Bike Shop',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Mechanic',
                payment = 0
            },
            ['1'] = {
                name = 'Sales',
                payment = 0
            },
            ['2'] = {
                name = 'Manager',
                payment = 0
            },
            ['3'] = {
                name = 'Owner',
                isboss = true,
                payment = 0
            },
        },
	},
    ['clinic'] = {
		label = 'Los Santos Clinic',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Nurse Trainee',
                payment = 0
            },
            ['1'] = {
                name = 'Nurse',
                payment = 0
            },
            ['2'] = {
                name = 'Doctor',
                payment = 0
            },
            ['3'] = {
                name = 'Specialist',
                payment = 0
            },
            ['4'] = {
                name = 'Mortician Director',
                payment = 0
            },
            ['5'] = {
                name = 'Medical Director',
                payment = 0
            },
            ['6'] = {
                name = 'Assistant Chief Physician',
                payment = 0
            },
            ['7'] = {
                name = 'Chief Physician',
                isboss = true,
                payment = 0
            },
        },
	},
    ['koi'] = {
		label = 'KOI',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Security',
                payment = 0
            },
            ['1'] = {
                name = 'Trainee',
                payment = 0
            },
            ['2'] = {
                name = 'Employee',
                payment = 0
            },
            ['3'] = {
                name = 'Lead Employee',
                payment = 0
            },
            ['4'] = {
                name = 'Manager',
                payment = 0
            },
            ['5'] = {
                name = 'Executive',
                isboss = true,
                payment = 0
            },
            ['6'] = {
                name = 'Owner',
                isboss = true,
                payment = 0
            },
        },
	},
    ['roseandcrown'] = {
		label = 'Rose & Crown British Pub',
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = 'Trainee',
                payment = 0
            },
            ['1'] = {
                name = 'Security',
                payment = 0
            },
            ['2'] = {
                name = 'Bartender',
                payment = 0
            },
            ['3'] = {
                name = 'Supervisor',
                isboss = true,
                payment = 0
            },
            ['4'] = {
                name = 'Manager',
                isboss = true,
                payment = 0
            },
            ['5'] = {
                name = 'Pub Owner',
                isboss = true,
                payment = 0
            },
        },
	},
}