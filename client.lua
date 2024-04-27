local QBCore = exports['qb-core']:GetCoreObject()

local aimAtNPC = false
local abletorob = true

local function DispatchCall()
    --QS Dispatch
    local playerData = exports['qs-dispatch']:GetPlayerInfo()

    exports['qs-dispatch']:getSSURL(function(image)
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job = { 'police'},
            callLocation = playerData.coords,
            callCode = { code = '10-32', snippet = 'Street Robbery' },
            message = "Street Robbery activity reported at ".. playerData.street_1.. " near: ".. playerData.street_2.. "",
            flashes = false,
            image = image or nil,
            blip = {
                sprite = 480,
                scale = 0.5,
                colour = 1,
                flashes = false,
                text = 'Street Robbery',
                time = (20 * 1000),
            }
        })
    end)

end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local playerPed = PlayerPedId()
        local currentWeapon = GetSelectedPedWeapon(playerPed)
        
        if abletorob == true and IsPedAPlayer(playerPed) and IsPedArmed(playerPed, 7) and currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
            local hit, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
            
            if hit and abletorob == true and IsPedHuman(entity) and not IsPedAPlayer(entity) and not IsPedInAnyVehicle(entity, true) then
                aimAtNPC = true
                local npcPed = entity
                
                SetBlockingOfNonTemporaryEvents(npcPed, true)
                SetPedFleeAttributes(npcPed, 0, false)
                SetPedCombatAttributes(npcPed, 17, true)
                SetPedCombatAttributes(npcPed, 46, true)
                
                TaskHandsUp(npcPed, -1, playerPed, -1, true)
                Citizen.Wait(5000)
                TaskPlayAnim(npcPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 1, 0, false, false, false)
                ClearPedTasks(npcPed)

                TriggerServerEvent("addmoney:addMoney")         
                DispatchCall()

                abletorob = false
                Citizen.Wait(Config.cooldown)
                abletorob = true
            else
                aimAtNPC = false
            end
        else
            aimAtNPC = false
        end
    end
end)
