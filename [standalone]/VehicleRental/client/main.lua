local pedsSpawned = false
local inRangeRental = false

local function CreateBlip(data)
    local blip = AddBlipForCoord(data.blip.coords.x, data.blip.coords.y, data.blip.coords.z)
    SetBlipSprite(blip, data.blip.sprite or 1)
    SetBlipDisplay(blip, data.blip.display or 4)
    SetBlipScale(blip, data.blip.scale or 1.0)
    SetBlipColour(blip, data.blip.colour or 1)
    SetBlipAsShortRange(blip, config.bilpsSettings.shortRange or false)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(data.blip.label)
    EndTextCommandSetBlipName(blip)
    return blip
end

local function DeleteBlips()
    if not blips then return end
    for i = 1, #blips do
        local blip = blips[i]
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    blips = {}
end
local function SpawnVehicleRented(VehicleModel, VehicleSpawn)
    local veh = VehicleModel
    local spawn = VehicleSpawn
        local vehNetId = lib.callback.await('VehicleRental:rent', false, veh, spawn)
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
        SetVehicleFuelLevel(veh, 100)
        SetPedIntoVehicle(cache.ped, veh, -1)
        SetVehicleOnGroundProperly(veh)
        SetVehicleRadioEnabled(veh, true)
        SetVehRadioStation(veh, 'OFF')
end

local function CreateRental()
    if not config.RentalConfing or not next(config.RentalConfing) or pedsSpawned then return end

    for i = 1, #config.RentalConfing do
        local current = config.RentalConfing[i]

        current.ped.model = type(current.ped.model) == 'string' and joaat(current.ped.model) or current.ped.model
        lib.requestModel(current.ped.model, 5000)
        
        local ped = CreatePed(0, current.ped.model, current.ped.coords.x, current.ped.coords.y, current.ped.coords.z, current.ped.coords.w, false, false)
        SetModelAsNoLongerNeeded(current.ped.model)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStartScenarioInPlace(ped, current.ped.scenario, 0, true)

        if config.useTarget then
            exports.ox_target:addLocalEntity(ped, {{
                name = 'Rent_Vehicle_target',
                icon = 'fas fa-car-side',
                label = 'Rent Vehicle | ' .. current.rentalname,
                distance = 1.5,
                debug = config.debugPoly,
                onSelect = function()
                    if not current.VehiclesList then print(':(') return end
                    
                    local options = {}
                    for veh, desc in pairs(current.VehiclesList) do
                        options[#options+1] = {
                            title = desc.label,
                            description = desc.price .. ' $',
                            onSelect = function()
                                SpawnVehicleRented(veh, current.VehicleSpawn)
                            end
                        }
                    end

                    lib.registerContext({
                        id = 'Vehicle_Rental_Menu_target',
                        title = 'Vehicle Rental',
                        options = options
                    })

                    lib.showContext('Vehicle_Rental_Menu_target')
                end
            }})
        else
            local options = current.zoneOptions
            if options then
                lib.zones.box({
                    name = 'Rent_Vehicle_TextUI',
                    coords = current.ped.coords.xyz,
                    size = vec3(2, 2, 3),
                    rotation = current.ped.coords.w,
                    debug = config.debugPoly,
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
                            if not current.VehiclesList then print(':(') return end
                            local options = {}

                            for veh, desc in pairs(current.VehiclesList) do
                                options[#options+1] = {
                                    title = desc.label,
                                    description = desc.price .. ' $',
                                    onSelect = function()
                                        SpawnVehicleRented(veh, current.VehicleSpawn)
                                    end
                                }
                            end

                            lib.registerContext({
                                id = 'Vehicle_Rental_Menu_TextUI',
                                title = 'Vehicle Rental',
                                options = options
                            })

                            lib.showContext('Vehicle_Rental_Menu_TextUI')
                            lib.hideTextUI()
                        end
                    end,
                })
            end
        end

        if config.bilpsSettings.showBlip and current.blip then
            CreateBlip({blip = current.blip, coords = current.coords})
        end
    end
    pedsSpawned = true
end

local function DeleteRental()
    if not config.peds or not next(config.peds) or not pedsSpawned then return end
    for i = 1, #config.peds do
        local current = config.peds[i]
        if current.pedHandle then
            DeletePed(current.pedHandle)
        end
    end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateRental()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= cache.resource then return end
    CreateRental()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DeleteRental()
    DeleteBlips()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= cache.resource then return end
    DeleteRental()
    DeleteBlips()
    inRangeRental = false
end)