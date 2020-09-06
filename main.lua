-----------------------------------------------------------------------------------------
--
-- main.lua
--
--Graphic Simulation of a Machine Learning Data Separator
--Project: Mobile App
--CSP2108 Introduction to Mobile Applcations Development 
-- Sem 2 2020
--By James Johnston - 10461776
-----------------------------------------------------------------------------------------
local composer = require('composer')
local color = require("convertcolor")

display.setDefault( "background", color.hex("edebe9") )

-- scene loading options
local options = {
    effect = "crossFade",
    time = 2000,
    params = {
        sceneNumber = 1
    }
}

-- load first screen
composer.gotoScene('HomeScene', options)

