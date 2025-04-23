-- server.lua
local QBCore = exports['qb-core']:GetCoreObject()

print("^1[Cybr Rob NPCs] Loaded!^0")

-- handle successful robbery reward
RegisterServerEvent("cybr-rob:server:GiveMoney")
AddEventHandler("cybr-rob:server:GiveMoney", function(amount)
    local src    = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    player.Functions.AddMoney("cash", amount)
    TriggerClientEvent('QBCore:Notify', src, ("You received $%d"):format(amount), "success")
end)

-- optional: escalate police alert
RegisterServerEvent("cybr-rob:server:AlertPolice")
AddEventHandler("cybr-rob:server:AlertPolice", function(coords)
    local src = source
    -- give player a wanted level bump
    TriggerClientEvent("police:SetPlayerWantedLevel", src, 2)
    -- you could also log counts or stats here
end)
