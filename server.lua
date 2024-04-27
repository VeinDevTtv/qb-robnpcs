local QBCore = exports['qb-core']:GetCoreObject()

function printRed(text)
    print("^1" .. text)
end
printRed("Cybr Rob NPCs")

RegisterServerEvent("addmoney:addMoney")
AddEventHandler("addmoney:addMoney", function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    local amount = math.random(Config.minamount, Config.maxamount)
    if amount <= 0 then
        QBCore.Functions.Notify(src, Config.nomoneymsg, 'error')
        return
    end

    if player then
        player.Functions.AddMoney("cash", amount)
        QBCore.Functions.Notify(src, "You got from them $" .. amount, 'success')
    end
end)
