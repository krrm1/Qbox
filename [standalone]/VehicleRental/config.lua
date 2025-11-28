config = {}

config.useTarget = true
config.debugPoly = true

config.peds = {{
        VehicleSpawn = vec4(300.28, -330.15, 44.92, 67.71),
        VehiclesList = {
            t20 = 't20 | Super Car Super fast',
            casco = 'casco | Calssic Car Sport',
            aleutian = 'aleutian | New Body Style SUV'
        },
        model = 's_m_o_busker_01',
        coords = vec4(296.58, -327.2, 43.92, 152.66),
        scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
        rentalname = 'rental 1',
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = true,
        }
    },{
        VehicleSpawn = vec4(295.87, -343.17, 44.92, 69.83),
        VehiclesList = {
            t20 = 't20',
            brigham = 'brigham',
            blade = 'blade'
        },        model = 's_m_o_busker_01',
        coords = vec4(292.16, -339.43, 43.92, 156.66),
        scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
        rentalname = 'rental 2',
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = true,
        }
    },{
        VehicleSpawn = vec4(288.91, -325.88, 44.92, 249.85),
        VehiclesList = {
            t20 = 't20',
            vader = 'vader',
            apc = 'apc'
        },        model = 's_m_o_busker_01',
        coords = vec4(293.29, -325.28, 43.92, 155.41),
        scenario = 'WORLD_HUMAN_CLIPBOARD_FACILITY',
        rentalname = 'rental 3',
        zoneOptions = { -- Used for when UseTarget is false
            length = 3.0,
            width = 3.0,
            debugPoly = true,
        }
    }
}

