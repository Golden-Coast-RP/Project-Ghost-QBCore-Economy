Framework = nil

if Config.Settings["Framework Preference"] == "ESX" then
    Citizen.CreateThread(function()
        while Framework == nil do
            TriggerEvent('esx:getSharedObject', function(obj) Framework = obj end)
            Citizen.Wait(4)
        end
        
        Framework.RegisterServerCallback("data", function(source, cb)
            local xPlayer = Framework.GetPlayerFromId(source)
            local  Players = Framework.GetPlayers()
        
            for i = 1, #Players do
                local xPlayer = Framework.GetPlayerFromId(Players[i])
            cb({
                cash = xPlayer.getMoney(source),
                bank = xPlayer.getAccount('bank').money,
                time = os.date("%H:%M"),
                date = os.date('%Y-%m-%d'),
                id = source,
                all = i
            })
            end
        end)
    end)

elseif Config.Settings["Framework Preference"] == 'QBCore' or Config.Settings["Framework Preference"] == 'OLDQBCore'  then
    if Config.Settings["Framework Preference"] == "OLDQBCore" then
        while Framework == nil do
            TriggerEvent('QBCore:GetObject', function(obj) Framework = obj end)
            Citizen.Wait(4)
        end
    else  Framework = exports['qb-core']:GetCoreObject() end

    Framework.Functions.CreateCallback("data", function(source, cb)
        local xPlayer = Framework.Functions.GetPlayer(source)
        local  Players = Framework.Functions.GetPlayers()
        for i = 1, #Players do
            local xPlayer = Framework.Functions.GetPlayer(Players[i])
        cb({
            cash = xPlayer.PlayerData.money["cash"],
            bank = xPlayer.PlayerData.money["bank"],
            time = os.date("%H:%M"),
            date = os.date('%Y-%m-%d'),
            id = source,
            all = i
        })
        end
    end)
   
end
