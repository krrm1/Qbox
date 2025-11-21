
lib.callback.register('VehicleRental:rent', function(source, model, coords)
        local ped = GetPlayerPed(source)
        local netId, vehicle = qbx.spawnVehicle({
            model = model,
            spawnSource = coords,
            warp = true,
        })

        exports.qbx_vehiclekeys:GiveKeys(source, vehicle)
    return netId
end)




