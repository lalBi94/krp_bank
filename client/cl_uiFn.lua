-- Author: General Zod (Owner)
-- Discord: bilaaaaaaaaaal
-- Date: written on 01/07/2023 at 20:48
-- Name: [COURS]/krp_bank/client/cl_uiFn

--[[
    Non-Commercial Script License
    This script is licensed under the Non-Commercial Script License. You are free to use, copy, and modify 
    the script for non-commercial purposes only. You may not use this script or any derivative works for 
    commercial purposes, including but not limited to selling or distributing the script for a profit. 
    Any commercial use or sale of this script requires the express written permission of the author.
    THIS SCRIPT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT 
    LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
]]--

ZODWorks = exports["ZODWorks"]:getSharedObject()
onFocus = false

Citizen.CreateThread(function()
    while(onFocus) do
        Citizen.Wait(0)
        DisableControlAction(0, 142, onFocus)
        DisableControlAction(0, 18, onFocus)
        DisableControlAction(0, 322, onFocus)
        DisableControlAction(0, 106, onFocus)
    end
end)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("discord", function(data)
    ZODWorks.Player:notify(Locales.discord[CurrentLocale])
end)

RegisterNUICallback("submit", function(data)
    local method = data.method
    local value = data.value

    if(method == "RETRAIT") then
        ZODWorks.KRPBank:withdrawMoney(value, {})
    elseif method == "DEPOT" then
        ZODWorks.KRPBank:depositMoney(value, {})
    end

    SetDisplay(false)
end)

RegisterNuiCallback("error", function(data)
    local msg = data.msg
    ZODWorks.Player:notify(msg)
end)

RegisterNUICallback("transfer", function(data)
    local nAccount = data.naccount
    local amount = data.amount
    local emmiter = ZODWorks.Player:getIndentity()

    ZODWorks.KRPBank:addPendingTransfert(nAccount, amount, ("%s %s"):format(emmiter.firstname, emmiter.lastname))

    SetDisplay(false)
end)

---Display the UI interface.
---@param bool boolean Set true for active.
function SetDisplay(bool)
    local playerData = ZODWorks.Player:getIndentity()
    local client = ("%s %s"):format(playerData.firstname, playerData.lastname)
    local amount = ZODWorks.Player:getMoneyFrom("bank")
    local label = ZODWorks.Utils:formatCurrency(tostring(amount))
    local naccount = ZODWorks.KRPBank:getAccountId()

    onFocus = bool
    SetNuiFocus(bool, bool)

    SendNUIMessage({
        type = "ui",
        status = bool,
        client = client,
        balance = label,
        amount = amount,
        naccount = naccount
    })
end