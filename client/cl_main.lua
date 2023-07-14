-- Author: General Zod (Owner)
-- Discord: bilaaaaaaaaaal
-- Date: written on 01/07/2023 at 17:30
-- Name: client/cl_main.lua

--[[
    Non-Commercial Script License
    This script is licensed under the Non-Commercial Script License. You are free to use, copy, and modify 
    the script for non-commercial purposes only. You may not use this script or any derivative works for 
    commercial purposes, including but not limited to selling or distributing the script for a profit. 
    Any commercial use or sale of this script requires the express written permission of the author.
    THIS SCRIPT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT 
    LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
]]--

Citizen.CreateThread(function()
    print("^5?^1--------------------------------------^5?")
    print("^1| Script: ^5krp_bank                     ^1|")
    print("^1| ^7Author: bilaaaaaaaaaal (General ^3Zod^7) ^1|")
    print("^1| ^2Powered ^3by ZODWorks                  ^1|")
    print("^5?^1--------------------------------------^5?^7")
end)

Citizen.CreateThread(function()
    Citizen.Wait(15000)
    ZODWorks.KRPBank:haveAccount()

    while(true) do
        ZODWorks.KRPBank:checkPendingTransfer()
        Citizen.Wait(20000)
    end
end)

--- Thanks to the developer (discord: ak4therapyst) for the help
CreateThread(function()
    while(true) do
        local getObject, dst = ZODWorks.Game:getClosestObject()
        local model = GetEntityModel(getObject)
        local onMarker = false
        local ped = PlayerPedId(-1)

        for _, v in pairs(Config.ATMS) do
            if(v == model) then
                if(dst <= 2.0) then
                    onMarker =  true
                    ZODWorks.Game:helpNotify(Locales.atmHelp[CurrentLocale])

                    if IsControlJustPressed(1, 54) then
                        FreezeEntityPosition(ped, true)
                        Citizen.Wait(10)
                        SetDisplay(true)
                    end
                else
                    onMarker = false
                end
            else
                FreezeEntityPosition(ped, false)
            end
        end

        if(onMarker) then
            Citizen.Wait(1)
        else
            Citizen.Wait(500)
        end
    end
end)