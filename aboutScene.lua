-----------------------------------------------------------------------------------------
--
-- aboutScene.lua
--
--Graphic Simulation of a Machine Learning Data Separator
--Project: Mobile App
--CSP2108 Introduction to Mobile Applcations Development 
-- Sem 2 2020
--By James Johnston - 10461776
--This Scene will provide info about the APP
-----------------------------------------------------------------------------------------


local composer = require( "composer" )
local color = require("convertcolor")
local widget = require("widget") 

local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen


    ------------------------------------------------
    -- Page Text
    ------------------------------------------------

    -- About Page Top TEXT
    local titleText = display.newText(
        {
            parent = sceneGroup,
            text = "APP Info",
            x = display.contentCenterX,
            y = display.contentCenterY * 0.1,
            font = native.systemFontBold,
            fontSize = 40
        }
    )
    
    titleText:setFillColor( color.hex("ef3d43") )
    sceneGroup:insert(titleText)

    -- Info TEXT
    local infoText = display.newText(
        {
            parent = sceneGroup,
            text = "Graphic Simulation of Machine Learing Data Separator \n\n CSP2108 - Inroduction to Mobile Applications Development \n\n Semester 2 2020 \n\n\n By \n James Johnston - 10461776",
            x = display.contentCenterX,
            y = display.contentCenterY * 0.9,
            fontSize = 18,
            width = 300,
            align = "center"
        }
    )
    
    infoText:setFillColor(color.hex("323639"))
    sceneGroup:insert(infoText)
 
    ------------------------------------------------
    -- Ruturn Button
    ------------------------------------------------
    --About Scence Event
    local function gotoHomeScene( event )
    
        if ( "ended" == event.phase ) then
            local options = {
                effect = 'fade',
                time = 500,
                params = {
                    sceneNumber = 2,
                }
            }
            composer.removeScene('aboutScene')
            composer:gotoScene('HomeScene', options)
        end
    end

    --About Page Button
    local returnbutton = widget.newButton(
        {
            label = "Return",
            onEvent = gotoHomeScene,
            emboss = false,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 2,
            labelColor = {default = {color.hex("edebe9")}, over = {color.hex("34acbc"), 1}},
            fillColor = { default={color.hex("34acbc"),1}, over={color.hex("ff10ae"),1} },
            strokeColor = { default={color.hex("010203"),1}, over={color.hex("f15937"), 1} },
            strokeWidth = 4
        }
    )
    -- Center the button
    returnbutton.x = display.contentCenterX 
    returnbutton.y = display.contentCenterY * 1.8

    sceneGroup:insert(returnbutton)

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene