-- client.lua
local QBCore = exports['qb-core']:GetCoreObject()
local isRobbing = false

-- helper: trigger QS dispatch
local function SendDispatch(coords, street1, street2)
    exports['qs-dispatch']:getSSURL(function(image)
        TriggerServerEvent('qs-dispatch:server:CreateDispatchCall', {
            job          = Config.dispatch.job,
            callLocation = coords,
            callCode     = { code = Config.dispatch.code, snippet = Config.dispatch.text },
            message      = ("Robbery reported at %s near %s"):format(street1, street2),
            flashes       = false,
            image         = image or nil,
            blip          = {
                sprite  = Config.dispatch.blipData.sprite,
                scale   = Config.dispatch.blipData.scale,
                colour  = Config.dispatch.blipData.colour,
                flashes = false,
                text    = Config.dispatch.text,
                time    = Config.dispatch.blipData.time
            }
        })
    end)
end

-- attempt to rob a specific ped
local function RobPed(targetPed)
    if isRobbing then return end
    isRobbing = true

    local pedCoords = GetEntityCoords(targetPed)
    local street1, street2 = table.unpack(GetStreetNameAtCoord(pedCoords))
    street1 = GetStreetNameFromHashKey(street1)
    street2 = GetStreetNameFromHashKey(street2)

    -- Skill-check (if installed)
    local success = true
    if Config.useSkillCheck and exports['ps-ui'] then
        success = exports['ps-ui']:Skillbar({
            duration = 3,     -- seconds
            pos      = math.random(5, 35),
            width    = math.random(5, 10),
        })
    else
        success = (math.random() < Config.skillCheckSuccessChance)
    end

    if success then
        exports['progressBars']:startUI(5000, "Robbing NPC...")  -- requires progressBars resource
        Wait(5000)

        TriggerServerEvent('cybr-rob:server:GiveMoney', math.random(Config.minAmount, Config.maxAmount))
        QBCore.Functions.Notify("You robbed them successfully!", "success")
        SendDispatch(pedCoords, street1, street2)
    else
        QBCore.Functions.Notify("They got away and called the cops!", "error")
        SendDispatch(pedCoords, street1, street2)
        -- optionally give wanted level
        TriggerServerEvent('cybr-rob:server:AlertPolice', pedCoords)
    end

    Wait(Config.cooldown)
    isRobbing = false
end

-- main loop: look for Aimed-at NPCs
Citizen.CreateThread(function()
    while true do
        Wait(5)
        if isRobbing then goto continue end

        local playerPed    = PlayerPedId()
        local weaponHash   = GetSelectedPedWeapon(playerPed)
        local canRob       = Config.allowedWeapons[weaponHash] or false

        if canRob and IsPlayerFreeAiming(PlayerId()) then
            local hit, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if hit and DoesEntityExist(target)
            and IsEntityAPed(target)
            and not IsPedAPlayer(target)
            and not IsPedInAnyVehicle(target, true)
            and #(GetEntityCoords(playerPed) - GetEntityCoords(target)) <= Config.robRange
            then
                RobPed(target)
            end
        end

        ::continue::
    end
end)

-- optional: Key mapping to manually rob nearest ped
RegisterCommand("robped", function()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local closest, dist = nil, 999.0
    for ped in EnumeratePeds() do
        local d = #(coords - GetEntityCoords(ped))
        if d < dist and not IsPedAPlayer(ped) and d <= Config.robRange then
            closest, dist = ped, d
        end
    end
    if closest then RobPed(closest) end
end)
RegisterKeyMapping("robped", "Rob nearest NPC", "keyboard", "E")
