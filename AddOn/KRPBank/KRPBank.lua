-- Author: General Zod (Owner)
-- Discord: bilaaaaaaaaaal
-- Date: written on 03/07/2023 at 03:50
-- Name: [Zod]/ZODWorks/client/KRPBank/KRPBank

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
ZODWorks.KRPBank = {}

AccountId = nil
RegisterNetEvent("zod::receiveAccountId", function(data)
    AccountId = data
end)

--- Withdraw some money from account bank.
---@param amount number The value of the withdraw.
---@param atmlist table The all of ATM coords (Security but optionnal).
---@return void
function ZODWorks.KRPBank:withdrawMoney(amount, atmlist)
    ZODWorks.Game:Trigger("zod::withdrawMoney", amount, atmlist or nil)
end

--- Get account id XXXX-XXXX-XXXX-XXXX
--- @return string
function ZODWorks.KRPBank:getAccountId()
    if(AccountId ~= nil) then
        return AccountId
    else
        ZODWorks.Game:Trigger("zod::getAccountId")

        while(AccountId == nil) do
            Wait(0)
        end
    
        return AccountId
    end
end

--- Deposit some money from account bank.
---@param amount number The value of the withdraw.
---@param atmlist table The all of ATM coords (Security but optionnal).
---@return void
function ZODWorks.KRPBank:depositMoney(amount, atmlist)
    ZODWorks.Game:Trigger("zod::depositMoney", amount, atmlist or nil)
end

--- Check if play have account and create one if not
---@return void
function ZODWorks.KRPBank:haveAccount()
    ZODWorks.Game:Trigger("zod::haveAccount")
end

--- Check if the player have a pending transfer
---@return void
function ZODWorks.KRPBank:checkPendingTransfer()
    ZODWorks.Game:Trigger("zod::checkPendingTransfer")
end

--- Add a pending transfert for a player
function ZODWorks.KRPBank:addPendingTransfert(naccount, amount, emmiter)
    ZODWorks.Game:Trigger("zod::addPendingTransfert", naccount, amount, emmiter)
end

setmetatable(ZODWorks, { __index = ZODWorks.KRPBank })