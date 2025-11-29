config = {}

config.useTarget = true
config.debugPoly = true
config.bilpsSettings = {
    showBlip = true,
    shortRange = true,
}

config.peds = {{
        model = 's_m_o_busker_01',
        scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
        coords = vec4(296.58, -327.2, 43.92, 152.66),
        VehicleSpawn = vec4(300.28, -330.15, 44.92, 67.71),
        rentalname = 'rental 1',
        VehiclesList = {
            ["cypher"] = {
                label = "cypher | sport",
                price = 500
            },
            ["elegy"] = {
                label = "elegy | sport",
                price = 500
            },
            ["paragon"] = {
                label = "paragon | sport",
                price = 500
            },
            ['paragon3'] = {
                label = "paragon3 | sport",
                price = 500
            },
        },
        blip = {
        label = 'Vehicle Rental 1',
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
        model = 's_m_o_busker_01',
        scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
        coords = vec4(292.16, -339.43, 43.92, 156.66),
        VehicleSpawn = vec4(295.87, -343.17, 44.92, 69.83),
        rentalname = 'rental 2',
        VehiclesList = {
            ["sentinel4"] = {
                label = "sentinel4 | sport",
                price = 500
            },
            ["stingertt"] = {
                label = "stingertt | sport",
                price = 500
            },
            ["flashgt"] = {
                label = "flashgt | sport",
                price = 500
            },
            ['banshee3'] = {
                label = "banshee3 | sport",
                price = 500
            },
        },
        blip = {
        label = 'Vehicle Rental 2',
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
        model = 's_m_o_busker_01',
        scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
        coords = vec4(293.29, -325.28, 43.92, 155.41),
        VehicleSpawn = vec4(288.91, -325.88, 44.92, 249.85),
        rentalname = 'rental 3',
        VehiclesList = {
            ["rt3000"] = {
                label = "rt3000 | sport",
                price = 500
            },
            ["envisage"] = {
                label = "envisage | sport",
                price = 500
            },
            ["omnisegt"] = {
                label = "omnisegt | sport",
                price = 500
            },
            ['r300'] = {
                label = "r300 | sport",
                price = 500
            },
        },
        blip = {
        label = 'Vehicle Rental 3',
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

