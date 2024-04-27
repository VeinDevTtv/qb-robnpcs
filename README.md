# qb-robnpcs
A script that lets you rob NPCs
# What is missing?
- Add dipatch call (easy).
- Add it that sometimes the NPC can fight with you as well (not bad).
# Follow these steps to make the script work well:
- if you got ps-dispatch add this section to alerts.lua

local function TestAlert() -- change name to your liking
    local coords = GetEntityCoords(cache.ped)
    local vehicle = GetVehicleData(cache.vehicle)

    local dispatchData = {
        message = locale('testalert'), -- add this into your locale
        codeName = 'testalert', -- this should be the same as in config.lua
        code = '10-35',
        icon = 'fas fa-car-burst',
        priority = 2, -- change to your liking
        coords = coords,
        street = GetStreetAndZone(coords),
        heading = GetPlayerHeading(),
        jobs = { 'leo' } -- change to your liking
    }

    TriggerServerEvent('ps-dispatch:server:notify', dispatchData)
end
exports('TestAlert', TestAlert) -- change to your liking

- Add this section to config.lua

    ['testalert'] = { -- Need to match the codeName in alerts.lua
        radius = 0, -- change to your liking
        sprite = 119, -- change to your liking 
        color = 1, -- change to your liking
        scale = 1.5, -- change to your liking
        length = 2, -- change to your liking
        sound = 'Lose_1st', -- change to your liking
        sound2 = 'GTAO_FM_Events_Soundset', -- change to your liking
        offset = false,
        flash = false
    },

  - After doin the 2 steps up top, go to qb-robnps/client.lua to line 
