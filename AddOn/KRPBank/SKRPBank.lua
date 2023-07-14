-- Author: General Zod (Owner)
-- Discord: bilaaaaaaaaaal
-- Date: written on 02/07/2023 at 07:06
-- Name: [Zod]/ZODWorks/shared/AddOns/KRPBank/SKRPBank.lua

--[[
    Non-Commercial Script License
    This script is licensed under the Non-Commercial Script License. You are free to use, copy, and modify 
    the script for non-commercial purposes only. You may not use this script or any derivative works for 
    commercial purposes, including but not limited to selling or distributing the script for a profit. 
    Any commercial use or sale of this script requires the express written permission of the author.
    THIS SCRIPT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT 
    LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
]]--

ESX = exports["es_extended"]:getSharedObject()

--- Withdraw a money.
---@param amount number The value of cash to withdraw.
---@param atmlist table The all of ATM coords (Security but optionnal).
RegisterNetEvent("zod::withdrawMoney", function(amount, atmlist)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local curBalance = xPlayer.getAccount("bank").money

    if(amount <= curBalance) then
        xPlayer.removeAccountMoney("bank", amount)
        xPlayer.addAccountMoney("money", amount)
        xPlayer.showNotification((Locales.KRPBank.texts.withdrawMoney.succes[CurrentLocale]):format(amount))
    else
        xPlayer.showNotification((Locales.KRPBank.texts.withdrawMoney.wrong[CurrentLocale]):format(amount))
    end
end)

--- Withdraw a money.
---@param amount number The value of cash to withdraw.
---@param atmlist table The all of ATM coords (Security but optionnal).
RegisterNetEvent("zod::depositMoney", function(amount, atmlist)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local curBalance = xPlayer.getAccount("money").money
    print(amount)

    if(amount <= curBalance) then
        xPlayer.removeAccountMoney("money", amount)
        xPlayer.addAccountMoney("bank", amount)
        xPlayer.showNotification((Locales.KRPBank.texts.depositMoney.succes[CurrentLocale]):format(amount))
    else
        xPlayer.showNotification((Locales.KRPBank.texts.depositMoney.wrong[CurrentLocale]):format(amount))
    end
end)

--- Private function to generate a XXXX-XXXX-XXXX id without double.
---@param existingIDs table The all of account registrered number in the server.
function genAccountID(existingIDs)
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local generatedCode = ""

    local existingSet = {}
    for _, id in ipairs(existingIDs) do
        existingSet[id] = true
    end

    repeat
        generatedCode = ""
        for i = 1, 16 do
            local randomIndex = math.random(1, #characters)
            local randomChar = characters:sub(randomIndex, randomIndex)
            generatedCode = generatedCode .. randomChar

            if i % 4 == 0 and i ~= 16 then
                generatedCode = generatedCode .. "-"
            end
        end
    until not existingSet[generatedCode]

    return generatedCode
end

--- Check if the player have an account in krp_bank
--- if not, created one shadowing.
RegisterNetEvent("zod::haveAccount", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll("SELECT `identifier` FROM krp_bank WHERE identifier=@i", {["i"] = identifier},
        function(data)
            if(#data == 0) then
                MySQL.Async.fetchAll("SELECT `naccount` FROM `krp_bank`", {},
                    function(identifiers)
                        local allID = {}

                        for _, v in pairs(identifiers) do
                            table.insert(allID, v.naccount)
                        end

                        uniqueId = genAccountID(allID)

                        MySQL.Async.execute(
                            "INSERT INTO `krp_bank` VALUES(@i, @g, @p, @b)", {
                                ["i"] = identifier, 
                                ["g"] = uniqueId, 
                                ["p"] = 0, ["b"] = nil
                            }, function() end)
                    end
                )
            end
        end)
end)

--- Check if player have a panding transfer
RegisterNetEvent("zod::checkPendingTransfer", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll(
            "SELECT `pendingTransfer`, `emmiter` FROM `krp_bank` WHERE identifier=@i", {["i"] = identifier},
            function(data)
                local pending = tonumber(data[1].pendingTransfer)

                if(pending > 0) then
                    local emitter = data[1].emmiter
                    xPlayer.addAccountMoney("bank", pending)
                    xPlayer.showNotification((Locales.KRPBank.texts.checkPendingTransfer[CurrentLocale]):format(emitter, pending))

                    MySQL.Async.execute(
                        "UPDATE `krp_bank` SET pendingTransfer=@pt, emmiter=@e WHERE identifier=@i",{
                            ["pt"] = 0, 
                            ["e"] = nil, 
                            ["i"] = identifier
                        }, function() end
                    )
                end
            end)
end)

RegisterNetEvent("zod::addPendingTransfert", function(naccount, amount, emmiter)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local curBalance = xPlayer.getAccount("bank").money
    amount = tonumber(amount)

    if(amount <= curBalance) then
        MySQL.Async.execute(
            "UPDATE `krp_bank` SET pendingTransfer=@pt, emmiter=@e WHERE naccount=@na",
            {
                ["pt"] = amount, 
                ["e"] = emmiter, 
                ["na"] = naccount
            }, function()
                xPlayer.removeAccountMoney("bank", amount)
                xPlayer.showNotification((Locales.KRPBank.texts.addPendingTransfert.succes[CurrentLocale]):format(amount, emmiter))
            end
        )
    else
        xPlayer.showNotification(Locales.KRPBank.texts.addPendingTransfert.wrong[CurrentLocale])
    end
end)

RegisterNetEvent("zod::getAccountId", function() 
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll(
        "SELECT `naccount` FROM `krp_bank` WHERE identifier=@i", {
            ["i"] = identifier
        }, function(data) 
            local naccount = data[1].naccount
            TriggerClientEvent("zod::receiveAccountId", _src, naccount)
        end
    )
end)