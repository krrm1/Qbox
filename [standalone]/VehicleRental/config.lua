config = {}

config.useTarget = true
config.debugPoly = false
config.bilpsSettings = {
    showBlip = true,
    shortRange = true,
}

config.RentalConfing = {{
        VehicleSpawn = vec4(104.34, -1078.51, 28.19, 342.44),
        rentalname = 'Public Service Rental',
        VehiclesList = {
            ["cypher"] = {
                label = "cypher | sport",
                price = 900
            },
            ["elegy"] = {
                label = "elegy | sport",
                price = 500
            },
            ["futo"] = {
                label = "futo | sport",
                price = 150
            },
        },
        ped = {
            model = 'IG_Manuel',
            scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
            coords = vec4(109.82, -1087.16, 28.19, 346.59),
        },
        blip = {
            label = 'Public Car Rental',
            coords = vec3(109.82, -1087.16, 28.19),
            sprite = 810,
            display = 4,
            scale = 0.65,
            colour = 2,
        },
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = config.debugPoly,
        },
    },{
        VehicleSpawn = vec4(895.24, -4.71, 78.76, 146.78),
        rentalname = 'Diamond Rental',
        VehiclesList = {
            ["niobe"] = {
                label = "niobe | sport",
                price = 2500
            },
            ["stingertt"] = {
                label = "stingertt | sport",
                price = 3000
            },
            ["comet7"] = {
                label = "comet7 | sport",
                price = 2400
            },
            ['banshee3'] = {
                label = "banshee3 | sport",
                price = 3000
            },
        },
        ped = {
            model = 'CSB_IslDJ_03',
            scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
            coords = vec4(888.47, -1.09, 77.77, 210.43),
        },
        blip = {
            label = 'Diamond Car Rental',
            coords = vec3(888.47, -1.09, 77.77),
            sprite = 810,
            display = 4,
            scale = 0.65,
            colour = 2,
        },
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = config.debugPoly ,
        }
    },{
        VehicleSpawn = vec4(-429.12, -1716.78, 19.12, 339.25),
        rentalname = 'Scrap Yard Rental',
        VehiclesList = {
            ["rebel"] = {
                label = "rebel | ",
                price = 50
            },
            ["ratloader"] = {
                label = "ratloader | ",
                price = 10
            },
            ["Emperor2"] = {
                label = "Emperor2 | ",
                price = 50
            },
            ['voodoo2'] = {
                label = "voodoo2 | ",
                price = 100
            },
            ['Surfer2'] = {
                label = "Surfer2 | ",
                price = 100
            },
        },
        ped = {
            model = 'IG_Old_Man2',
            scenario = 'amb@world_human_aa_smoke@male@idle_a',
            coords = vec4(-429.13, -1723.45, 18.05, 335.52),
        },
        blip = {
            label = 'Scrap Yard Car Rental',
            coords = vec3(-429.13, -1723.45, 18.05),
            sprite = 810,
            display = 4,
            scale = 0.65,
            colour = 2,
        },
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = config.debugPoly,
        }
    },{
        VehicleSpawn = vec4(97.3, -1957.28, 20.74, 322.07),
        rentalname = 'Hood Bikes',
        VehiclesList = {
            ["BMX"] = {
                label = "BMX | ",
                price = 5
            },
            ["cruiser"] = {
                label = "cruiser | ",
                price = 10
            },
            ["fixter"] = {
                label = "fixter | ",
                price = 50
            },
        },
        ped = {
            model = 'A_M_Y_SouCent_02',
            scenario = 'WORLD_HUMAN_AA_SMOKE',
            coords = vec4(100.21, -1958.43, 19.78, 344.55),
        },
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = config.debugPoly,
        }
    },{
        VehicleSpawn = vec4(-1644.81, -1161.15, -0.12, 160.65),
        rentalname = 'Boats & Jetskis Rental',
        VehiclesList = {
            ["avisa"] = {
                label = "Avisa | 2 seat",
                price = 500
            },
            ["dinghy"] = {
                label = "dinghy | 4 seat",
                price = 1000
            },
            ["jetmax"] = {
                label = "jetmax | big seat",
                price = 1500
            },
            ["longfin"] = {
                label = "longfin | big seat",
                price = 1900
            },
            ["seashark"] = {
                label = "seashark | 2 seat ",
                price = 200
            },
            ["squalo"] = {
                label = "squalo fashing | 2 seat ",
                price = 900
            },
            ["suntrap"] = {
                label = "suntrap fashing | big seat ",
                price = 900
            },
        },
        ped = {
            model = 'a_m_y_beach_02',
            scenario = 'WORLD_HUMAN_AA_SMOKE',
            coords = vec4(-1611.74, -1133.41, 1.15, 179.87),
        },
        blip = {
            label = 'Boats & Jetskis Rental',
            coords = vec3(-1611.74, -1133.41, 2.15),
            sprite = 810,
            display = 4,
            scale = 0.65,
            colour = 2,
        },
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = config.debugPoly,
        }
    }
}

