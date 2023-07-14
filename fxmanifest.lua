-- Author: General Zod (Owner)
-- Discord: bilaaaaaaaaaal
-- Date: written on 01/07/2023 at 17:31
-- Name: /fxmanifest.lua

--[[
    Non-Commercial Script License
    This script is licensed under the Non-Commercial Script License. You are free to use, copy, and modify 
    the script for non-commercial purposes only. You may not use this script or any derivative works for 
    commercial purposes, including but not limited to selling or distributing the script for a profit. 
    Any commercial use or sale of this script requires the express written permission of the author.
    THIS SCRIPT IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT 
    LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
]]--

fx_version 'adamant'
game 'gta5'
lua54 'yes'

author "General Zod | Discord: bilaaaaaaaaaal"
description "Bank script for Metropolis"

ui_page {
    "ui/main.html"
}

files {
    "ui/assets/coin_logo.gif",
    "ui/assets/discord_logo.png",
    "ui/assets/server_logo.png",
    "ui/assets/exit_logo.png",
    "ui/main.html",
    "ui/main.js",
    "ui/main.css",
}

client_scripts {
    "locales/locales.lua",
    "client/cl_uiFn.lua",
    "client/cl_main.lua",
    "config.lua",
    "AddOn/KRPBank/locales/locales.lua",
    "AddOn/KRPBank/KRPBank.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "AddOn/KRPBank/locales/locales.lua",
    "AddOn/KRPBank/SKRPBank.lua"
}

shared_scripts {
    "@ZODWorks/shared/ZODWorks.lua"
}