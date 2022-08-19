
Framework = nil

CreateThread(function()
    Wait(5000)
    TriggerEvent("Players")
end)

if Config.Settings["Framework Preference"] == 'ESX' then
    Citizen.CreateThread(function()
        while Framework == nil do
            TriggerEvent('esx:getSharedObject', function(obj) Framework = obj end)
            Citizen.Wait(4)
        end

        RegisterCommand(Config.Settings["Key Combination Command"], function()
            SendNUIMessage({
                action = "help",
                data = Config.Keys,
            })
        end)

        AddEventHandler('onResourceStart', function(resourceName)
            if GetCurrentResourceName() == resourceName then
                TriggerEvent("Players")
            end
        end)


        RegisterNetEvent('Players')
        AddEventHandler('Players', function(xPlayer)
            while true do 
                Citizen.Wait(2000)
                Framework.TriggerServerCallback("data",function(result)
                  SendNUIMessage({
                      action = "player",
                      info = result
                  })
                end)
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

    RegisterCommand(Config.Settings["Key Combination Command"], function()
        SendNUIMessage({
            action = "help",
            data = Config.Keys,
        })
    end)

    AddEventHandler('onResourceStart', function(resourceName)
        if GetCurrentResourceName() == resourceName then
            TriggerEvent("Players")
        end
    end)

    RegisterNetEvent('Players')
    AddEventHandler('Players', function(xPlayer)
        while true do 
            Citizen.Wait(2000)
            Framework.Functions.TriggerCallback("data",function(result)
              SendNUIMessage({
                  action = "player",
                  info = result
              })
            end)
        end
    end)
    
    AddEventHandler('onResourceStart', function(resourceName)
        if GetCurrentResourceName() == resourceName then
            TriggerEvent("Players")
        end
    end)
    
end
