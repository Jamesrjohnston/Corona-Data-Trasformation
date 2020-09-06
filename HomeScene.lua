-----------------------------------------------------------------------------------------
--
-- HomeScene.lua
--
--Graphic Simulation of a Machine Learning Data Separator
--Project: Mobile App
--CSP2108 Introduction to Mobile Applcations Development 
-- Sem 2 2020
--By James Johnston - 10461776
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local widget = require('widget')
local color = require("convertcolor")

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
    

    -- Home Page TEXT
    local homeText = display.newText(
        {
            parent = sceneGroup,
            text = "Home Page",
            x = display.contentCenterX,
            y = display.contentCenterY * 0.4,
            fontSize = 40
        }
    )

    homeText:setFillColor( color.hex("010203") )
    sceneGroup:insert(homeText)
    
    --About Scence Event
    local function gotoAboutScence( event )
 
        if ( "ended" == event.phase ) then
            local options = {
                effect = 'fade',
                time = 500,
                params = {
                    sceneNumber = 2,
                }
            }
            composer:gotoScene('aboutScene', options)
        end
    end

    --About Page Button
    local AboutScencebutton = widget.newButton(
        {
            label = "About Page",
            onEvent = gotoAboutScence,
            emboss = false,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 2,
            labelColor = {default = {color.hex("ef3d43")}, over = {color.hex("34acbc"), 1}},
            fillColor = { default={color.hex("34acbc"),1}, over={color.hex("ff10ae"),1} },
            strokeColor = { default={color.hex("010203"),1}, over={color.hex("f15937"), 1} },
            strokeWidth = 4
        }
    )
    sceneGroup:insert(AboutScencebutton)

    -- Center the button
    AboutScencebutton.x = display.contentCenterX 
    AboutScencebutton.y = display.contentCenterY * 0.8

    --Select Data Event
    local function gotoSelectData( event )
 
        if ( "ended" == event.phase ) then
            local options = {
                effect = 'fade',
                time = 200,
                params = {
                    sceneNumber = 3,
                }
            }
            composer:gotoScene('selectData', options)
        end
    end

    --Select Data Button
    local SelectDatabutton = widget.newButton(
        {
            label = "Select Data",
            onEvent = gotoSelectData,
            emboss = false,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 200,
            height = 40,
            cornerRadius = 2,
            labelColor = {default = {color.hex("ef3d43")}, over = {color.hex("34acbc"), 1}},
            fillColor = { default={color.hex("34acbc"),1}, over={color.hex("ff10ae"),1} },
            strokeColor = { default={color.hex("010203"),1}, over={color.hex("f15937"), 1} },
            strokeWidth = 4
        }
    )
    sceneGroup:insert(SelectDatabutton)

    -- Center the button
    SelectDatabutton.x = display.contentCenterX 
    SelectDatabutton.y = display.contentCenterY * 1.2



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