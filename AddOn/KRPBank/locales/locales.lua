-- Author: General Zod (Owner)
-- Discord: bilaaaaaaaaaal
-- Date: written on 03/07/2023 at 04:54
-- Name: [Zod]/ZODWorks/shared/AddOns/KRPBank/locales/locales

--[[
    Non-Commercial Script License
    This script is licensed under the Non-Commercial Script License. You are free to use, copy, and modify 
    the script for non-commercial purposes only. You may not use this script or any derivative works for 
    commercial purposes, including but not limited to selling or distributing the script for a profit. 
    Any commercial use or sale of this script requires the express written permission of the author.
    THIS SCRIPT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT 
    LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
]]--

CurrentLocale = "fr"
Locales = Locales or {}
Locales.KRPBank = {}
Locales.KRPBank.texts = {}

Locales.KRPBank.texts.depositMoney = {
    wrong = {
        ["fr"] = "~r~Vous n'avez pas assez d'argent sur vous !",
        ["en"] = "~r~You dont have enought money on you!"
    }, succes = {
        ["fr"] = "~g~Vous venez de deposer %d$ !",
        ["en"] = "~g~You have just deposited %d$!"
    }
}

Locales.KRPBank.texts.withdrawMoney = {
    wrong = {
        ["fr"] = "~r~Vous n'avez pas assez d'argent sur votre compte !",
        ["en"] = "~r~You dont have enought money in your bank!"
    }, succes = {
        ["fr"] = "~g~Vous venez de retirer %d$ !",
        ["en"] = "~g~You have just withdrawn %d$!"
    }
}

Locales.KRPBank.texts.checkPendingTransfer = {
    ["fr"] = "%s vient de vous envoyer %s$",
    ["en"] = "%s send you %s$"
}

Locales.KRPBank.texts.addPendingTransfert = {
    wrong = {
        ["fr"] = "Vous n'avez pas assez d'argent sur votre compte pour effectue un tranfert !",
        ["en"] = "You don't have enought money in your bank account to make this transfer!"
    }, succes = {
        ["fr"] = "Votre transfert de %s$ a bien ete effectue !",
        ["en"] = "Your transfer of %s$ was succesfully send!"
    }
}