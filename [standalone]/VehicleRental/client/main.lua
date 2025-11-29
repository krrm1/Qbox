local pedsSpawned = false
local inRangeRental = false

local function createBlip(data)
    local blip = AddBlipForCoord(data.coords.x, data.coords.y, data.coords.z)
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

local function deleteBlips()
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
        SetPedIntoVehicle(cache.ped, veh, -1)
        SetVehicleOnGroundProperly(veh)
        SetVehicleRadioEnabled(veh, true)
        SetVehRadioStation(veh, 'OFF')
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
                    name = 'Rent_Vehicle_target',
                    icon = 'fas fa-car-side',
                    label = 'Rent Vehicle | ' .. current.rentalname,
                    distance = 1.5,
                    debug = config.debugPoly,
                    onSelect = function()
                        if current.VehiclesList == nil then print(':(') return end
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
            end
        else
            local options = current.zoneOptions
            if options then
                lib.zones.box({
                    name = 'Rent_Vehicle_TextUI',
                    coords = current.coords.xyz,
                    size = vec3(2, 2, 3),
                    rotation = current.coords.w,
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
                            if current.VehiclesList == nil then print(':(') return end
                            local options = {}

                            for veh, desc in pairs(current.VehiclesList) do
                                options[#options+1] = {
                                    title = veh,
                                    description = desc,
                                    onSelect = function()
                                        SpawnVehicleRented(current.rentalname, veh, current.VehicleSpawn)
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
        if not config.bilpsSettings.showBlip or not current.blip then return end
        createBlip({blip = current.blip, coords = current.coords})
    end
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

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    spawnPeds()
end)

AddEventHandler('onResourceStart', function(resource)
    if resource ~= cache.resource then return end
    spawnPeds()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    deletePeds()
    deleteBlips()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= cache.resource then return end
        deletePeds()
        deleteBlips()
    inRangeRental = false
end)