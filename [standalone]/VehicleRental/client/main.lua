local pedsSpawned = false
local inRangeRental = false

local function SpawnVehicleRented(rentalname)
        local vehNetId = lib.callback.await('VehicleRental:rent', false, 't20', vec3(278.78, -340.38, 44.92))
        if not vehNetId then return end
        local veh
        repeat
            veh = NetToVeh(vehNetId)
            Wait(100)
        until DoesEntityExist(veh)
        TriggerEvent('qb-vehiclekeys:client:AddKeys', qbx.getVehiclePlate(veh))
        SetVehicleNeedsToBeHotwired(veh, false)
        SetVehicleHasBeenOwnedByPlayer(veh, true)
        SetEntityAsMissionEntity(veh, true, false)
        SetVehicleIsStolen(veh, false)
        SetVehicleIsWanted(veh, false)
        SetVehicleEngineOn(veh, true, true, true)
        SetPedIntoVehicle(cache.ped, veh, -1)
        SetVehicleOnGroundProperly(veh)
        SetVehicleRadioEnabled(veh, true)
        SetVehRadioStation(veh, 'OFF')
        print(rentalname)
end

local function deletePeds()
    if not config.peds or not next(config.peds) or not pedsSpawned then return end
    for i = 1, #config.peds do
        local current = config.peds[i]
        if current.pedHandle then
            DeletePed(current.pedHandle)
        end
    end
end


local function spawnPeds()
    if not config.peds or not next(config.peds) or pedsSpawned then return end
    for i = 1, #config.peds do

        local current = config.peds[i]
        current.model = type(current.model) == 'string' and joaat(current.model) or current.model
        lib.requestModel(current.model, 5000)
        local ped = CreatePed(0, current.model, current.coords.x, current.coords.y, current.coords.z, current.coords.w, false, false)
        SetModelAsNoLongerNeeded(current.model)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, current.scenario, 0, true)
        pedsSpawned = true
        if config.useTarget  then

            if pedsSpawned == true then
                exports.ox_target:addLocalEntity(ped, {{ 
                    name = 'Rent_Vehicle',
                    icon = 'fas fa-car-side',
                    label = 'Rent Vehicle | ' .. current.rentalname,
                    distance = 1.5,
                    debug = true,
                    onSelect = function()
                        SpawnVehicleRented()
                    end
                }})
            end
        else
            local options = current.zoneOptions
            if options then
                lib.zones.box({
                    name = 'Rent_Vehicle',
                    coords = current.coords.xyz,
                    size = vec3(2, 2, 3),
                    rotation = current.coords.w,
                    debug = true,
                    onEnter = function()
                       inRangeRental = true
                       print(inRangeRental)
                        lib.showTextUI('[E] Rent Vehicle | ' .. current.rentalname)
                    end,
                    onExit = function()
                        lib.hideTextUI()
                        inRangeRental = false
                        print(inRangeRental)
                    end,
                    inside = function()
                        if IsControlJustPressed(0, 38) then
                            SpawnVehicleRented(current.rentalname)
                            lib.hideTextUI()
                        end
                    end,
                })
            end
        end
    end
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    -- initBlips()
    spawnPeds()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= cache.resource then return end
    -- initBlips()
    spawnPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    -- deleteBlips()
    deletePeds()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= cache.resource then return end
    -- deleteBlips()
    deletePeds()
    inRangeRental = false 
end)