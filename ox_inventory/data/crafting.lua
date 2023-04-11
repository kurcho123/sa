return {
    -- BUSINESSES
    { -- glazedandglorious 1
        items = {
            { -- Glazed Special Donut
                name = 'glazed_special_donut',
                ingredients = {
                    flour = 1,
                    sugar = 1,
                    egg = 1,
                    milk = 1,
                    butter = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 6
            },
            { -- bagcon egg cheese bagel
                name = 'glazed_cookies',
                ingredients = {
                    raw_pork = 1,
                    egg = 1,
                    cheese = 1,
                    dough = 1,
                },
                duration = math.random(2000, 5000) * 6,
                count = 5
            },
            { -- croissant
                name = 'glazed_cakepops',
                ingredients = {
                    flour = 1,
                    butter = 1,
                    milk = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            { -- cheesecake
                name = 'glazed_tea',
                ingredients = {
                    milk = 1,
                    cheese = 1,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 5
            }
        },
        zones = {
            {
                coords = vec3(-590.81, -1059.77, 22.34),
                size = vec3(0.8, 0.4, 22.14 - 23.14),
                distance = 1.0,
                rotation = 0,
            }
        },
        groups = {['glazedandglorious'] = 0}
    },
    { -- glazedandglorious 2
        items = {
            { -- orange juice
                name = 'glazed_bubble_tea',
                ingredients = {
                    fresh_fruits = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            { -- Smoothie
                name = 'glazed_smoothie',
                ingredients = {
                    fresh_fruits = 1,
                    milk = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
        },
        zones = {
            {
                coords = vec3(-587.93, -1059.59, 22.36),
                size = vec3(0.4, 0.4, 22.21 - 22.61),
                distance = 1.0,
                rotation = 359,
            },
        },
        groups = {['glazedandglorious'] = 0}
    },
    { -- glazedandglorious 3
        items = {
            { -- ince coffee
                name = 'glazed_latte',
                ingredients = {
                    coffee_grounds = 1,
                    milk = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 5
            },
            { -- tea
                name = 'glazed_hotchocolate',
                ingredients = {
                    milk = 1,
                    spices = 1,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 5
            },
        },
        zones = {
            {
                coords = vec3(-586.91, -1061.91, 22.34),
                size = vec3(0.55, 0.75, 22.46 - 22.26),
                distance = 1.0,
                rotation = 0.0,
            }
        },
        groups = {['glazedandglorious'] = 0}
    },
    { -- glazedandglorious 4
        items = {
            { -- Grilled Cheese
                name = 'glazed_mochi',
                ingredients = {
                    tomato = 1,
                    cheese = 1,
                    dough = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 5
            },
            { -- Ramen
                name = 'glazed_cupcakes',
                ingredients = {
                    dough = 1,
                    egg = 1,
                    spices = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 6
            },
        },
        zones = {
            {
                coords = vec3(-591.08, -1056.52, 22.36),
                size = vec3(1.0, 0.75, 22.46 - 22.26),
                distance = 1.0,
                rotation = 89.53,
            }
        },
        groups = {['glazedandglorious'] = 0}
    },
    { -- glazedandglorious 5
        items = {
            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'ice_cream',
                ingredients = {
                    milk = 1,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'butter',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'cheese',
                ingredients = {
                    milk = 2
                },
                duration = math.random(2000, 5000) * 5,
                count = 3
            }
        },
        zones = {
            {
                coords = vec3(-591.0, -1063.14, 22.61),
                size = vec3(2.6, 0.75, 22.66 - 21.36),
                distance = 1.0,
                rotation = 89.65,
            }
        },
        groups = {['glazedandglorious'] = 0}
    },

    { -- glazedandglorious 6
    items = {
        {
            name = 'catplushie_red',
            ingredients = {
                plastic = 5,
                rubber = 5,
                raw_fabric = 5,
            },
            duration = math.random(2000, 5000) * 4,
            count = 1
        },
    },
    zones = {
        {
            coords = vec3(-580.29, -1061.78, 26.61),
            size = vec3(0.6, 0.4, 26.51 - 26.91),
            distance = 1.0,
            rotation = 0,
        }
    },
    groups = {['glazedandglorious'] = 0}
},

{ -- glazedandglorious 7
items = {
    {
        name = 'bs_drink',
        ingredients = {
            water_bottle = 1,
            sugar = 1
        },
        duration = math.random(2000, 5000) * 4,
        count = 6
    },
    {
        name = 'bs_burger',
        ingredients = {
            raw_beef = 1,
            spices = 1,
        },
        duration = math.random(2000, 5000) * 4,
        count = 6
    },
    {
        name = 'bs_heartstopper',
        ingredients = {
            raw_beef = 1,
            spices = 1,
        },
        duration = math.random(2000, 5000) * 4,
        count = 1
    },
    {
        name = 'bs_chickenwrap',
        ingredients = {
            raw_chicken = 1,
            lettuce = 1,
        },
        duration = math.random(2000, 5000) * 4,
        count = 6
    },
    {
        name = 'bs_fries',
        ingredients = {
            potato = 1,
            spices = 1,
        },
        duration = math.random(2000, 5000) * 4,
        count = 6
    },
},
zones = {
    {
        coords = vec3(-599.57, -1068.14, 22.34),
        size = vec3(0.6, 1, 22.34 - 22.94),
        distance = 1.0,
        rotation = 0,
    }
},
groups = {['glazedandglorious'] = 0}
},

    { -- yellowjack 1
        items = {
            { -- Turkey Leg
                name = 'skywalker_sausage',
                ingredients = {
                    raw_pork = 1,
                    spices = 1,
                },
                duration = math.random(2000, 5000) * 8,
                count = 4
            },
            { -- peanuts
                name = 'chicken_tay_quito',
                ingredients = {
                    raw_beef = 1,
                    spices = 1,
                },
                duration = math.random(2000, 5000) * 8,
                count = 4
            },
            { -- Sloppy joe
                name = 'bar_peanuts',
                ingredients = {
                    raw_beef = 1,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 4
            },
            { -- Jam
                name = 'sandy_shot_glass',
                ingredients = {
                    spices = 1,
                    fresh_fruits = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 4
            },
            { -- Open Road Bag
                name = 'shoey_dirty_boot',
                ingredients = {
                    rubber = 1,
                    plastic = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            {
                name = 'yellowjack_coke',
                ingredients = {
                    raw_alcohol_forty = 1,
                    kurkakola = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            {
                name = 'rootbeer_float',
                ingredients = {
                    ice_cream = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },
            { -- JBs Pipe
                name = 'katie_knives',
                ingredients = {
                    raw_tobacco = 1,
                    plastic = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            { -- Shans sweet tea
                name = 'tennesse_whiskey',
                ingredients = {
                    sugar = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 4
            },
            { -- Malt liquor
                name = 'rangers_moon_shine',
                ingredients = {
                    raw_grains = 1,
                    raw_alcohol_eighty = 1,
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },

            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1,
                    butter = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'butter',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'raw_alcohol_twenty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_forty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_eighty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'ice_cream',
                ingredients = {
                    milk = 1,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 5
            },
            {
                name = 'cheese',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 5
            },
        },
        zones = {
            {
                coords = vec3(2511.07, 4098.29, 38.58),
                size = vec3(1, 0.6, 37.73 - 338.73),
                distance = 1.0,
                rotation = 335,
            },
            {
                coords = vec3(2518.18, 4109.98, 42.8),
                size = vec3(0.6, 0.4, 42.95 - 42.55),
                distance = 1.0,
                rotation = 335.0,
            }
        },
        groups = {['yellowjack'] = 0}
    },

    { -- vanillaunicorn 1
        items = {
            {
                name = 'vu_chicken_wings', --Mozzerella sticks
                ingredients = {
                    cheese = 2,
                    dough = 2,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'vu_mac_n_cheese', --Buffalo Wings
                ingredients = {
                    raw_chicken = 1,
                    spices = 2
                },
                duration = math.random(2000, 5000) * 2,
                count = 2
            },
            {
                name = 'henny', --Golden Shower
                ingredients = {
                    raw_alcohol_twenty = 1,
                    fresh_fruits = 1
                },
                duration = math.random(2000, 5000) * 2,
                count = 2
            },
            {
                name = 'vu_pear_cocktail', --Fancyson Ipa
                ingredients = {
                    raw_alcohol_forty = 1,
                    fresh_fruits = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'blue_lagoon', --Cream soda
                ingredients = {
                    sugar = 1,
                    milk = 2
                },
                duration = math.random(2000, 5000) * 2,
                count = 2
            },
            {
                name = 'southside_special_jello', --bloody mary
                ingredients = {
                    raw_alcohol_forty = 1,
                    spices = 2
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'bottled_dreams', --shrimp cocktail
                ingredients = {
                    tomato = 1,
                    fresh_fruits = 1,
                    raw_shrimp = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'unicorn_ice', --sticky buns
                ingredients = {
                    sugar = 2,
                    egg = 1,
                    dough = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            }
        },
        zones = {
            {
                coords = vec3(129.69, -1279.95, 29.27),
                size = vec3(2.5, 1.0, 29.72 - 28.30),
                distance = 1.0,
                rotation = 120.0,
            }
        },
        groups = {['vanillaunicorn'] = 0}
    },
    { -- vanillaunicorn 2
        items = {
            {
                name = 'dirty_panties', 
                ingredients = {
                    raw_fabric = 2,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 2,
                count = 2
            },
            {
                name = 'unicorn_charm', --handcuffs
                ingredients = {
                    goldbar = 2,
                    emerald = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            }
        },
        zones = {
            {
                coords = vec3(103.62, -1297.95, 28.77),
                size = vec3(3.75, 0.85, 29.25 - 28.0),
                distance = 1.0,
                rotation = 300.22,
            }
        },
        groups = {['vanillaunicorn'] = 0}
    },
    { -- vanillaunicorn 3
        items = {
            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'raw_pasta',
                ingredients = {
                    flour = 1,
                    egg = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'raw_alcohol_twenty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_forty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_eighty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'cheese',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
        },
        zones = {
            {
                coords = vec3(131.13, -1282.47, 29.27),
                size = vec3(3.25, 1.0, 29.72 - 28.30),
                distance = 1.0,
                rotation = 120.0,
            }
        },
        groups = {['vanillaunicorn'] = 0}
    },

    { -- tequilala 1
        items = {
            { --carna asada fries
                name = 'tequilala_sunrise',
                ingredients = {
                    raw_beef = 1,
                    potato = 1,
                    tomato = 1,
                },
                duration = math.random(2000, 5000) * 2,
                count = 4
            },
            { -- Horchata
                name = 'revolver_tonic_wine',
                ingredients = {
                    water_bottle = 1,
                    spices = 1,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            { -- Elotay
                name = 'white_duck_vodka',
                ingredients = {
                    raw_corn = 1,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 2,
                count = 4
            },
            { -- snakebite
                name = 'silver_captain_whiskey',
                ingredients = {
                    raw_alcohol_forty = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            { --skillpods
                name = 'cuban_cigar',
                ingredients = {
                    spices = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            { --islandlite
                name = 'bandit_bombs',
                ingredients = {
                    raw_alcohol_eighty = 1,
                    fresh_fruits = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            { --masonada
                name = 'tll_orange_juice',
                ingredients = {
                    fresh_fruits = 2,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 2,
                count = 2
            },
            { --pina colada
                name = 'psycho_juice',
                ingredients = {
                    raw_alcohol_eighty = 1,
                    fresh_fruits = 1,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            { --enchiladas
                name = 'tll_chicken_wings',
                ingredients = {
                    raw_chicken = 1,
                    spices = 1,
                    butter = 1,
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },
            { --case adila
                name = 'tll_nachos', 
                ingredients = {
                    cheese = 1,
                    raw_pork = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 4
            }
        },
        zones = {
            {
                coords = vec3(-562.94, 285.62, 82.18),
                size = vec3(0.8, 0.4, 82.38 - 82.78),
                distance = 1.0,
                rotation = 355.0,
            }
        },
        groups = {['tequilala'] = 0}
    },
    { -- tequilala 2
        items = {
            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'butter',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'raw_alcohol_twenty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_forty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_eighty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'cheese',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            }
        },
        zones = {
            {
                coords = vec3(-563.12, 284.59, 82.18),
                size = vec3(0.8, 0.6, 81.53 - 82.33),
                distance = 1.0,
                rotation = 355.0,
            }
        },
        groups = {['tequilala'] = 0}
    },

    { -- smokeonthewater 1
        items = {
            {
                name = 'joint_legion_diesel',
                ingredients = {
                    weed_legion_diesel = 3,
                    blunt_wrap = 3,
                    raw_tobacco = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'joint_sparkplug',
                ingredients = {
                    weed_sparkplug = 2,
                    blunt_wrap = 2,
                    raw_tobacco = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'joint_seebeedeebees',
                ingredients = {
                    weed_seebeedeebees = 2,
                    blunt_wrap = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'joint_vss',
                ingredients = {
                    weed_vss = 2,
                    blunt_wrap = 4,
                    raw_tobacco = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            { --Moon Juice
                name = 'iced_tea',
                ingredients = {
                    sugar = 1,
                    water_bottle = 1,
                    weed_vss = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            { -- Cannabis Cane
                name = 'sotw_gummies',
                ingredients = {
                    sugar = 1,
                    water_bottle = 1,
                    weed_vss = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'sotw_brownie',
                ingredients = {
                    sugar = 1,
                    chocolate = 1,
                    milk = 1,
                    flour = 1,
                    weed_vss = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'sotw_bong',
                ingredients = {
                    raw_tobacco = 2,
                    weed_sparkplug = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'sotw_dab_pen',
                ingredients = {
                    mushrooms = 1,
                    spices = 1,
                    weed_sparkplug = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'blunt_wrap',
                ingredients = {
                    raw_fabric = 3
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            }
        },
        zones = {
            {
                coords = vec3(375.58, -824.5, 29.3),
                size = vec3(1.75, 0.85, 29.5 - 28.3),
                distance = 1.0,
                rotation = 0.0,
            }
        },
        groups = {['smokeonthewater'] = 0}
    },

    { -- tenfourtwo 1
        items = {
            {
                name = 'tft_masons_moonshine',
                ingredients = {
                    raw_alcohol_twenty = 1,
                    raw_alcohol_forty = 1,
                    raw_alcohol_eighty = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'tft_firefighter_fireball',
                ingredients = {
                    raw_alcohol_eighty = 1,
                    fresh_fruits = 1,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            { -- Petrovics white russian
                name = 'tft_ambulance',
                ingredients = {
                    raw_alcohol_eighty = 1,
                    milk = 1,
                    coffee_grounds = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            { -- County Green Tea
                name = 'tft_state_whiskey',
                ingredients = {
                    spices = 1,
                    water_bottle = 1,
                    fresh_fruits = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            { -- LSPD Lager
                name = 'tft_sly_shandy',
                ingredients = {
                    raw_alcohol_twenty = 1,
                    water_bottle = 1,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'tft_probie',
                ingredients = {
                    fresh_fruits = 1,
                    water_bottle = 1,
                    sugar = 2
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'tft_waterhose',
                ingredients = {
                    fresh_fruits = 1,
                    water_bottle = 2,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            { -- the 10-69 Rueben
                name = 'tft_chicken_wings',
                ingredients = {
                    raw_beef = 1,
                    spices = 1,
                    butter = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'tft_crinkle_fries',
                ingredients = {
                    potato = 1,
                    spices = 1,
                    butter = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            { -- The Famouse 10-50 Eggnog
                name = 'tft_burger_sliders',
                ingredients = {
                    egg = 1,
                    milk = 1,
                    raw_alcohol_forty = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'butter',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'raw_alcohol_twenty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_forty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_eighty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'cheese',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            }
        },
        zones = {
            {
                coords = vec3(1230.25, -415.37, 67.77),
                size = vec3(3.0, 0.6, 68.77 - 66.77),
                distance = 1.0,
                rotation = 346.38,
            }
        },
        groups = {['tenfourtwo'] = 0}
    },

    { -- nismostuning 1
        items = {
            {
                name = 'nitrous',
                ingredients = {
                    steel = 6
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'harness',
                ingredients = {
                    plastic = 2,
                    raw_fabric = 1,
                    steel = 1,
                    carbon = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'turbocharger',
                ingredients = {
                    iron = 35,
                    rubber = 15,
                    carbon = 10,
                    screwdriverset = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'nitrous_system_2',
                ingredients = {
                    iron = 100,
                    steel = 20,
                    goldbar = 5,
                    carbon = 20,
                    rubber = 20,
                    nitrous = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'repairkit',
                ingredients = {
                    plastic = 7,
                    iron = 45
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            }
        },
        zones = {
            {
                coords = vec3(-1619.31, -831.72, 9.83),
                size = vec3(1.3, 1.3, 11.0 - 9.07),
                distance = 1.0,
                rotation = 48.322,
            }
        },
        groups = {['nismostuning'] = 0}
    },
    { -- nismostuning 2
        items = {
            {
                name = 'engineblock',
                ingredients = {
                    iron = 30,
                    aluminum = 21
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'crankshaft',
                ingredients = {
                    iron = 14,
                    steel = 10
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'pistons',
                ingredients = {
                    copper = 8,
                    rubber = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'camshaft',
                ingredients = {
                    iron = 25
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'cylinderhead',
                ingredients = {
                    aluminum = 28
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'intakemanifold',
                ingredients = {
                    plastic = 3,
                    iron = 3,
                    aluminum = 3
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'exhaustmanifold',
                ingredients = {
                    iron = 2,
                    steel = 3
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'fuelsystem',
                ingredients = {
                    plastic = 5,
                    rubber = 5,
                    iron = 5
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            }
        },
        zones = {
            {
                coords = vec3(-1630.14, -823.3, 10.07),
                size = vec3(1.0, 0.6, 10.83 - 8.83),
                distance = 1.0,
                rotation = 346.38,
            }
        },
        groups = {['nismostuning'] = 0}
    },
    { -- nismostuning 3
        items = {
            {
                name = 'billet_engineblock',
                ingredients = {
                    iron = 30,
                    aluminum = 21,
                    steel = 50
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'billet_crankshaft',
                ingredients = {
                    iron = 30,
                    steel = 30
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'billet_pistons',
                ingredients = {
                    copper = 10,
                    rubber = 5,
                    steel = 10
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'billet_camshaft',
                ingredients = {
                    steel = 30
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'billet_cylinderhead',
                ingredients = {
                    aluminum = 35,
                    steel = 35
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'billet_intakemanifold',
                ingredients = {
                    plastic = 10,
                    steel = 10,
                    aluminum = 10
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'billet_exhaustmanifold',
                ingredients = {
                    iron = 15,
                    steel = 10
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'billet_fuelsystem',
                ingredients = {
                    plastic = 25,
                    rubber = 25,
                    steel = 5
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            }
        },
        zones = {
            {
                coords = vec3(-1633.67, -820.21, 10.08),
                size = vec3(3.0, 0.6, 10.83 - 8.83),
                distance = 1.0,
                rotation = 348.8,
            }
        },
        groups = {['nismostuning'] = 0}
    },

    { -- bikinitow 1
        items = {
            {
                name = 'nitrous',
                ingredients = {
                    steel = 6
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'harness',
                ingredients = {
                    plastic = 2,
                    raw_fabric = 1,
                    steel = 1,
                    carbon = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'repairkit',
                ingredients = {
                    plastic = 7,
                    iron = 45
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'comealong',
                ingredients = {
                    plastic = 7,
                    iron = 45,
                    steel = 3
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },           
        },
        zones = {
            {
                coords = vec3(836.96, -808.28, 26.41),
                size = vec3(2.0, 0.6, 27.35 - 25.0),
                distance = 1.0,
                rotation = 246.47,
            }
        },
        groups = {['bikinitow'] = 0}
    },
    { -- bikinitow 2
        items = {
            {
                name = 'engineblock',
                ingredients = {
                    iron = 30,
                    aluminum = 21
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'crankshaft',
                ingredients = {
                    iron = 14,
                    steel = 10
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'pistons',
                ingredients = {
                    copper = 8,
                    rubber = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'camshaft',
                ingredients = {
                    iron = 25
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'cylinderhead',
                ingredients = {
                    aluminum = 28
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'intakemanifold',
                ingredients = {
                    plastic = 3,
                    iron = 3,
                    aluminum = 3
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'exhaustmanifold',
                ingredients = {
                    iron = 2,
                    steel = 3
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'fuelsystem',
                ingredients = {
                    plastic = 5,
                    rubber = 5,
                    iron = 5
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'nitrous_system_2',
                ingredients = {
                    iron = 100,
                    steel = 20,
                    goldbar = 5,
                    carbon = 20,
                    rubber = 20,
                    nitrous = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'turbocharger',
                ingredients = {
                    iron = 35,
                    rubber = 15,
                    carbon = 10,
                    screwdriverset = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            }
        },
        zones = {
            {
                coords = vec3(837.02, -814.66, 26.33),
                size = vec3(2.4, 0.6, 25.58 - 27.18),
                distance = 1.0,
                rotation = 0,
            }
        },
        groups = {['bikinitow'] = 0}
    },

    { -- bikinitow 3
        items = {       
            {
                name = 'blinker_fluid',
                ingredients = {
                    fresh_fruits = 1,
                    sugar = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            {
                name = 'blinker_fluid_red',
                ingredients = {
                    fresh_fruits = 1,
                    sugar = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            {
                name = 'blinker_fluid_baja',
                ingredients = {
                    fresh_fruits = 1,
                    sugar = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            {
                name = 'beefy_oil_burrito',
                ingredients = {
                    raw_beef = 1,
                    raw_corn = 1,
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            {
                name = 'bikini_pizza',
                ingredients = {
                    raw_beef = 1,
                    dough = 1,
                },
                duration = math.random(2000, 5000) * 3,
                count = 4
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1,
                    butter = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 6
            },
            {
                name = 'butter',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 6
            },
        },
        zones = {
            {
                coords = vec3(834.04, -823.99, 26.35),
                size = vec3(0.6, 1.2, 26.35 - 26.75),
                distance = 1.0,
                rotation = 0,
            }
        },
        groups = {['bikinitow'] = 0}
    },

    { -- maisonette 1
        items = {
            {
                name = 'raw_alcohol_twenty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 3
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'raw_alcohol_forty',
                ingredients = {
                    raw_grains = 2,
                    water_bottle = 2
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'raw_alcohol_eighty',
                ingredients = {
                    raw_grains = 3,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            }
        },
        zones = {
            {
                coords = vec3(-1386.33, -609.19, 30.32),
                size = vec3(0.6, 0.08, 31.17 - 29.37),
                distance = 1.0,
                rotation = 305.0,
            }
        },
        groups = {['maisonette'] = 0}
    },
    { -- maisonette 2
        items = {
            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1,
                    butter = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'butter',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            }
        },
        zones = {
            {
                coords = vec3(-1390.08, -601.02, 30.32),
                size = vec3(0.4, 1.0, 30.72 - 30.32),
                distance = 1.0,
                rotation = 304.0,
            }
        },
        groups = {['maisonette'] = 0}
    },
    { -- maisonette 3
        items = {
            {
                name = 'maisonette_burnside',
                ingredients = {
                    raw_alcohol_forty = 1,
                    spices = 2,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'maisonette_jimmycooler',
                ingredients = {
                    raw_alcohol_forty = 1,
                    spices = 2,
                    water_bottle = 2
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'maisonette_tickler',
                ingredients = {
                    raw_alcohol_twenty = 1,
                    spices = 2,
                    water_bottle = 2
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'maisonette_flaming',
                ingredients = {
                    raw_alcohol_twenty = 1,
                    spices = 2,
                    water_bottle = 2
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'maisonette_fizzler',
                ingredients = {
                    spices = 3,
                    water_bottle = 2
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'maisonette_444',
                ingredients = {
                    water_bottle = 2,
                    sugar = 2
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'maisonette_pinkslip',
                ingredients = {
                    raw_alcohol_twenty = 1,
                    spices = 2,
                    water_bottle = 2
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            }
        },
        zones = {
            {
                coords = vec3(-1391.09, -603.91, 30.32),
                size = vec3(0.4, 1.0, 30.77 - 30.37),
                distance = 1.0,
                rotation = 18.0,
            }
        },
        groups = {['maisonette'] = 0}
    },
    { -- maisonette 4
        items = {
            {
                name = 'maisonette_prawntoast',
                ingredients = {
                    dough = 1,
                    spices = 1,
                    raw_shrimp = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'maisonette_rocher',
                ingredients = {
                    chocolate = 1,
                    dough = 1,
                    butter = 1,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            },
            {
                name = 'maisonette_platter',
                ingredients = {
                    spices = 2,
                    butter = 2,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 4,
                count = 4
            }
        },
        zones = {
            {
                coords = vec3(-1387.13, -605.93, 30.32),
                size = vec3(0.6, 0.6, 30.72 - 30.32),
                distance = 1.0,
                rotation = 304.0,
            }
        },
        groups = {['maisonette'] = 0}
    },

    { -- knifeshop 1
        items = {
            {
                name = 'knifesharpeningkit',
                ingredients = {
                    iron = 3,
                    carbon = 5,
                    screwdriverset = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'knifeshop_bag',
                ingredients = {
                    rubber = 5,
                    plastic = 2,
                    raw_fabric = 3,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'knifebag',
                ingredients = {
                    rubber = 5,
                    plastic = 2,
                    raw_fabric = 3,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'WEAPON_KNIFE',
                ingredients = {
                    iron = 1,
                    plastic = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'huntingknife',
                ingredients = {
                    iron = 1,
                    plastic = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'WEAPON_RAINBOW',
                ingredients = {
                    rubber = 10,
                    iron = 10,
                    steel = 5,
                    screwdriverset = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'WEAPON_GUTKNIFE',
                ingredients = {
                    rubber = 10,
                    iron = 10,
                    steel = 5,
                    screwdriverset = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'WEAPON_BUTTERFLY',
                ingredients = {
                    rubber = 10,
                    iron = 10,
                    steel = 5,
                    screwdriverset = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'WEAPON_KARAMBIT',
                ingredients = {
                    rubber = 10,
                    iron = 10,
                    steel = 5,
                    screwdriverset = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'WEAPON_STATGEAR',
                ingredients = {
                    rubber = 10,
                    iron = 10,
                    steel = 5,
                    screwdriverset = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'WEAPON_HATCHET_SMITHS',
                ingredients = {
                    rubber = 20,
                    iron = 20,
                    steel = 5,
                    screwdriverset = 3,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
        },
        zones = {
            {
                coords = vec3(-669.31, 5834.24, 17.34),
                size = vec3(0.8, 2.0, 17.14 - 18.14),
                distance = 1.0,
                rotation = 315,
            }
        },
        groups = {['knifeshop'] = 0}
    },

    { -- Glizzy Comics 1
        items = {
            {
                name = 'hotdog_water',
                ingredients = {
                    sugar = 1,
                    water_bottle = 1,
                    raw_beef = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 4
            },
            {
                name = 'glizzy_hotdog',
                ingredients = {
                    dough = 1,
                    water_bottle = 1,
                    raw_beef = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 4
            },
            {
                name = 'glizzys_cotton_candy',
                ingredients = {
                    sugar = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 3
            },
        },
        zones = {
            {
                coords = vec3(-40.22, -76.25, 56.77),
                size = vec3(0.8, 0.4, 56.77 - 57.37),
                distance = 1.0,
                rotation = 67.0,
            }
        },
        groups = {['glizzycomics'] = 0}
    },

    { -- Glizzy Comics 2
        items = {
            {
                name = 'glizzy_mason_bodypillow',
                ingredients = {
                    raw_fabric = 3,
                    plastic = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 3
            },
            {
                name = 'glizzy_jynx_bodypillow',
                ingredients = {
                    raw_fabric = 3,
                    plastic = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 3
            },
            {
                name = 'arthur_kildare_plushie',
                ingredients = {
                    raw_fabric = 5,
                    plastic = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
        },
           -- {
   --             name = 'bikinitow_plushie',
   --             ingredients = {
   --                 raw_fabric = 5,
   --                 plastic = 2,
   --             },
   --             duration = math.random(2000, 5000) * 1,
   --             count = 1
   --         },
   --     },
        zones = {
            {
                coords = vec3(-35.46, -78.03, 56.77),
                size = vec3(0.6, 1.6, 56.87 - 57.27),
                distance = 1.0,
                rotation = 340.0,
            }
        },
        groups = {['glizzycomics'] = 0}
    },

    { -- Glizzy Comics 3
        items = {
            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1,
                    butter = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'butter',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            }
        },
        zones = {
            {
                coords = vec3(-38.24, -76.97, 56.77),
                size = vec3(0.4, 1, 56.82 - 57.22),
                distance = 1.0,
                rotation = 340.0,
            }
        },
        groups = {['glizzycomics'] = 0}
    },

    { -- Glizzy Comics 4
        items = {
            {
                name = 'glizzy_statue',
                ingredients = {
                    plastic = 20,
                },
                duration = math.random(2000, 5000) * 1,
                count = 3
            },
        },
        zones = {
            {
                coords = vec3(-37.08, -77.37, 56.77),
                size = vec3(0.4, 0.6, 56.82 - 57.22),
                distance = 1.0,
                rotation = 340.0,
            }
        },
        groups = {['glizzycomics'] = 0}
    },

    { -- Glizzy Comics 5
        items = {
            {
                name = 'gacha_capsule',
                ingredients = {
                    plastic = 8,
                    glizzy_statue = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'collectible_pouch',
                ingredients = {
                    raw_fabric = 9,
                    plastic = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
        },
        zones = {
            {
                coords = vec3(-36.28, -82.29, 56.77),
                size = vec3(1.0, 0.4, 56.77 - 557.17),
                distance = 1.0,
                rotation = 340.0,
            }
        },
        groups = {['glizzycomics'] = 0}
    },

    { -- reapers bike shop
        items = {
            {
                name = 'reapers_popcorn',
                ingredients = {
                    raw_corn = 2,
                    spices = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 4
            },
            {
                name = 'reapers_energy',
                ingredients = {
                    sugar = 2,
                    water_bottle = 1,
                    spices = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 4
            },
            {
                name = 'reapers_vest',
                ingredients = {
                    animalcarcassb = 1,
                    iron = 5,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 3
            },
            {
                name = 'bike_repairkit',
                ingredients = {
                    iron = 35,
                    plastic = 5,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
        },
        zones = {
            {
                coords = vec3(46.89, 6487.83, 31.44),
                size = vec3(1.6, 0.6, 30.64 - 32.64),
                distance = 1.0,
                rotation = 45,
            }
        },
        groups = {['bikedealer'] = 0}
    },

    { -- reapers bike shop 2
        items = {
            {
                name = 'engineblock',
                ingredients = {
                    iron = 30,
                    aluminum = 21
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'crankshaft',
                ingredients = {
                    iron = 14,
                    steel = 10
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'pistons',
                ingredients = {
                    copper = 8,
                    rubber = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'camshaft',
                ingredients = {
                    iron = 25
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'cylinderhead',
                ingredients = {
                    aluminum = 28
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'intakemanifold',
                ingredients = {
                    plastic = 3,
                    iron = 3,
                    aluminum = 3
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'exhaustmanifold',
                ingredients = {
                    iron = 2,
                    steel = 3
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'fuelsystem',
                ingredients = {
                    plastic = 5,
                    rubber = 5,
                    iron = 5
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'nitrous_system_1',
                ingredients = {
                    iron = 25,
                    goldbar = 1,
                    carbon = 5,
                    rubber = 5,
                    nitrous = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'turbocharger',
                ingredients = {
                    iron = 35,
                    rubber = 15,
                    carbon = 10,
                    screwdriverset = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'nitrous',
                ingredients = {
                    steel = 6
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
        },
        zones = {
            {
                coords = vec3(49.65, 6485.95, 31.44),
                size = vec3(1.0, 0.6, 30.64 - 31.64),
                distance = 1.0,
                rotation = 45,
            }
        },
        groups = {['bikedealer'] = 0}
    },

    { -- los santos clinic
        items = {
            {
                name = 'bepto_pismol',
                ingredients = {
                    water_bottle = 2,
                    raw_medical = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 5
            },
            {
                name = 'clinic_prescription',
                ingredients = {
                    plastic = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'sertraline',
                ingredients = {
                    raw_medical = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 5
            },
            {
                name = 'painkillers',
                ingredients = {
                    raw_medical = 2,
                },
                duration = math.random(2000, 5000) * 1,
                count = 5
            },
        },
        zones = {
            {
                coords = vec3(309.97, -560.39, 43.28),
                size = vec3(0.6, 0.8, 43.28 - 43.88),
                distance = 1.0,
                rotation = 340,
            }
        },
        groups = {['clinic'] = 0}
    },

    { -- los santos clinic 2
        items = {
            {
                name = 'clinic_wheelchair',
                ingredients = {
                    iron = 20,
                    rubber = 5,
                    steel = 1,
                    plastic = 5,
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'bandage',
                ingredients = {
                    raw_fabric = 3,
                    steel = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 8
            },
        },
        zones = {
            {
                coords = vec3(306.69, -566.79, 43.28),
                size = vec3(1.2, 0.8, 42.63 - 43.43),
                distance = 1.0,
                rotation = 340,
            }
        },
        groups = {['clinic'] = 0}
    },

    { -- Finnis Taxi
        items = {
            {
                name = 'finnis_airfresh',
                ingredients = {
                    plastic = 3,
                    rubber = 1,
                },
                duration = math.random(2000, 5000) * 1,
                count = 4
            },
        },
        zones = {
            {
                coords = vec3(884.92, -158.07, 76.89),
                size = vec3(1.6, 0.6, 75.99 - 76.79),
                distance = 1.0,
                rotation = 327,
            }
        },
        groups = {['finnistaxi'] = 0}
    },

    { -- Kildares
        items = {
            {
                name = 'repairkit',
                ingredients = {
                    plastic = 7,
                    iron = 45
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'zebra_bar',
                ingredients = {
                    chocolate = 1,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 4
            },
        },
        zones = {
            {
                coords = vec3(-949.86, -2041.09, 9.51),
                size = vec3(1.2, 0.8, 8.66 - 9.46),
                distance = 1.0,
                rotation = 315,
            }
        },
        groups = {['cardealer'] = 0}
    },

    { -- Koi 1
        items = {
            {
                name = 'flour',
                ingredients = {
                    raw_grains = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'dough',
                ingredients = {
                    flour = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = 'ice_cream',
                ingredients = {
                    milk = 1,
                    sugar = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'sugar',
                ingredients = {
                    raw_sugar_cane = 1
                },
                duration = math.random(2000, 5000) * 3,
                count = 3
            },
            {
                name = 'butter',
                ingredients = {
                    milk = 1
                },
                duration = math.random(2000, 5000) * 5,
                count = 5
            },
            {
                name = 'cheese',
                ingredients = {
                    milk = 2
                },
                duration = math.random(2000, 5000) * 5,
                count = 3
            },
            {
                name = 'raw_alcohol_twenty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_forty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
            {
                name = 'raw_alcohol_eighty',
                ingredients = {
                    raw_grains = 1,
                    water_bottle = 1,
                    hops = 1,
                },
                duration = math.random(2000, 5000) * 5,
                count = 10
            },
        },
        zones = {
            {
                coords = vec3(-1025.34, -1470.45, 5.3),
                size = vec3(0.6, 0.6, 5.25 - 5.45),
                distance = 1.0,
                rotation = 305,
            }
        },
        groups = {['koi'] = 0}
    },

    { -- Koi 2
        items = {
            {
                name = 'koi_thaitea',
                ingredients = {
                    water_bottle = 1,
                    spices = 1,
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },
            {
                name = 'koi_soju',
                ingredients = {
                    raw_alcohol_eighty = 1,
                    water_bottle = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },
        },
        zones = {
            {
                coords = vec3(-1023.46, -1473.24, 5.3),
                size = vec3(0.8, 0.4, 5.3 - 5.7),
                distance = 1.0,
                rotation = 35,
            }
        },
        groups = {['koi'] = 0}
    },

    { -- Koi 3
        items = {
            {
                name = "koi_cookie",
                ingredients = {
                    dough = 1,
                    sugar = 1,
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },
            {
                name = "koi_dumplings",
                ingredients = {
                    raw_pork = 1,
                    carrot = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },
            {
                name = "koi_sushi",
                ingredients = {
                    raw_salmon = 1,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 6
            },
            {
                name = "koi_omurice",
                ingredients = {
                    egg = 1,
                    spices = 1
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },
            {
                name = "koi_pho",
                ingredients = {
                    dough = 1,
                    water_bottle = 1,
                    spices = 1,
                },
                duration = math.random(2000, 5000) * 6,
                count = 5
            },
            {
                name = "koi_rangoon",
                ingredients = {
                    raw_crab = 1,
                    dough = 1,
                    cheese = 1,
                },
                duration = math.random(2000, 5000) * 6,
                count = 5
            },
            
        },
        zones = {
            {
                coords = vec3(-1025.51, -1472.11, 5.3),
                size = vec3(0.4, 1.4, 5.1 - 5.5),
                distance = 1.0,
                rotation = 305,
            }
        },
        groups = {['koi'] = 0}
    },

    { -- Koi 4
        items = {
            {
                name = "koi_taiyaki",
                ingredients = {
                    ice_cream = 2
                },
                duration = math.random(2000, 5000) * 6,
                count = 4
            },
        },
        zones = {
            {
                coords = vec3(-1023.95, -1472.48, 5.3),
                size = vec3(0.6, 0.4, 5.3 - 5.7),
                distance = 1.0,
                rotation = 305,
            }
        },
        groups = {['koi'] = 0}
    },

    { -- Koi 5
        items = {
            {
                name = "koi_bentobox",
                ingredients = {
                    plastic = 5,
                    rubber = 2,
                },
                duration = math.random(2000, 5000) * 6,
                count = 1
            },
        },
        zones = {
            {
                coords = vec3(-1020.35, -1473.34, 5.3),
                size = vec3(0.4, 1.2, 4.9 - 6.1),
                distance = 1.0,
                rotation = 305,
            }
        },
        groups = {['koi'] = 0}
    },

    -- MISC
    { -- prison crafting 1
        items = {
            {
                name = 'prison_plate',
                ingredients = {
                    prison_plastic = 5,
                    prison_varnish = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'prison_uniform',
                ingredients = {
                    prison_fabric = 5,
                    prison_thread = 3,
                    prison_sewing_needle = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'prison_lingerie',
                ingredients = {
                    prison_fabric = 3,
                    prison_laces = 3,
                    prison_sewing_needle = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'prison_circuit_board',
                ingredients = {
                    prison_broken_circuit = 1,
                    prison_elec_comps = 2,
                    prison_plastic = 3,
                    prison_kitchenoil = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'prison_boombox',
                ingredients = {
                    prison_broken_boombox = 1,
                    prison_elec_wires = 3,
                    prison_circuit_board = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'prison_tablet',
                ingredients = {
                    prison_broken_tablet = 1,
                    prison_circuit_board = 1,
                    prison_elec_wires = 3
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'prison_phone',
                ingredients = {
                    prison_broken_phone = 1,
                    prison_circuit_board = 2,
                    prison_elec_wires = 2,
                    prison_metal_wire = 2
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'phone',
                ingredients = {
                    prison_broken_phone = 1,
                    prison_circuit_board = 8,
                    prison_elec_wires = 5,
                    prison_metal_wire = 5
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'prison_thread',
                ingredients = {
                    prison_sewing_needle = 1,
                    prison_fabric = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'prison_sewing_needle',
                ingredients = {
                    prison_metal_wire = 1
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            },
            {
                name = 'plastic',
                ingredients = {
                    prison_plastic = 5
                },
                duration = math.random(2000, 5000) * 1,
                count = 1
            }
        },
        points = {
            vec3(1661.51, 2583.52, 45.61),
        },
        zones = {
            {
                coords = vec3(1661.51, 2583.52, 45.61),
                size = vec3(1.3, 0.7, 45.66 - 44.56),
                distance = 1.0,
                rotation = 135.29,
            }
        },
    },
    -- Bunker --
    { -- Bunker AR Parts
        items = {
            {
                name = 'assaultrifle_reciever',
                ingredients = {
                    steel = 50,
                    carbon = 20,
                    metalscrap = 25,
                    aluminum = 25,
                    plastic = 10,
                    raw_wood = 1,
                    screwdriverset = 1,
                },
                duration = math.random(12000, 15000),
                count = 1
            },
            {
                name = 'assaultrifle_barrel',
                ingredients = {
                    steel = 150,
                    carbon = 10,
                    metalscrap = 5,
                    aluminum = 5,
                    screwdriverset = 1,
                },
                duration = math.random(12000, 15000),
                count = 1
            },
            {
                name = 'assaultrifle_stock',
                ingredients = {
                    steel = 50,
                    carbon = 30,
                    aluminum = 25,
                    metalscrap = 5,
                },
                duration = math.random(12000, 15000),
                count = 1
            },
        },
        zones = {
            {
                coords = vec3(883.0, -3208.0, -98.0),
                size = vec3(1.05, 1, 1),                
                distance = 2.0,
                rotation = 116.25,
            }
        },
        groups = {["collective"] = 0, ["srr"] = 0, ["ballas"] = 0, ["nismos"] = 0, ["madrazo"] = 0, ["chaotek"] = 0, ["reapers"] = 0}
    },
    { -- Bunker AR
        items = {
            {
                name = 'WEAPON_COMPACTRIFLE',
                ingredients = {
                    assaultrifle_reciever = 1,
                    assaultrifle_barrel = 1,
                    assaultrifle_stock = 1,
                },
                duration = math.random(27000, 35000),
                count = 1
            },
        },
        zones = {
            {
                coords = vec3(884.4, -3199.5, -98.1),
                size = vec3(1.05, 0.35, 0.5),
                distance = 2.0,
                rotation = 51.25,
            }
        },
        groups = {["collective"] = 0, ["srr"] = 0, ["ballas"] = 0, ["nismos"] = 0, ["madrazo"] = 0, ["chaotek"] = 0, ["reapers"] = 0}
    },
}