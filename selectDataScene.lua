-----------------------------------------------------------------------------------------
--
-- selectDataScene.lua
--
--Graphic Simulation of a Machine Learning Data Separator
--Project: Mobile App
--CSP2108 Introduction to Mobile Applcations Development 
-- Sem 2 2020
--By James Johnston - 10461776
-- This File will allow the user to select thet data file they wish to visualise and give them the option to create and add to their own csv file.
--------------------------------------------------------------------------------------------

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
    
    -- Pre-provided files
    local datafiles = {"data.csv", "data2.csv", "data3.csv","data4.csv", "data5.csv", "bigboytest.csv"}
    local filename = "data.csv"

    local topbar = display.newRect(sceneGroup, display.contentCenterX, -50, 400, 180)
    topbar:setFillColor(color.hex("323639"))

    local bottombar = display.newRect(sceneGroup, display.contentCenterX, 500, 400, 200)
    bottombar:setFillColor(color.hex("323639"))

    -- Title Text Select Data
    local titleText = display.newText(
        {
            parent = sceneGroup,
            text = "Select Data Soruce",
            x = display.contentCenterX,
            y = display.contentCenterY * 0.05,
            font = native.systemFontBold,
            fontSize = 32
        }
    )
    titleText:setFillColor( color.hex("ef3d43") )


    local function onRowRender( event )
        -- Get reference to the row group
        local row = event.row
        
        -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
        local rowHeight = row.contentHeight
        local rowWidth = row.contentWidth
        
        local rowTitle = display.newText( row,'     '.. datafiles[row.index], 0, 0, nil, 14 )
        rowTitle:setFillColor( 0 )
        
        -- Align the label left and vertically centered
        rowTitle.anchorX = 0
        rowTitle.x = 0
        rowTitle.y = rowHeight * 0.5
    end
    
    
    local function onRowTouch( event )
        local row = event.target.index
        if( "press" == event.phase) then
            filename = datafiles[row]
            print(filename)
            local options = {
                effect = 'fade',
                time = 500,
                params = {
                    sceneNumber = 3,
                    filename = filename
                }
            }
            composer:gotoScene('plotDataScene', options)
        end
    end

    -- Create the widget
    local tableView = widget.newTableView(
        {
            parent = sceneGroup,
            hideScrollBar = false,
            backgroundColor = {color.hex("edebe9")},
            x = display.contentCenterX,
            y = display.contentCenterY - 25,
            height = 350,
            width = 250,
            onRowRender = onRowRender,
            onRowTouch = onRowTouch,
            listener = scrollListener
        }
    )
    sceneGroup:insert(tableView)

    for i = 1, #datafiles do
        -- Insert a row into the tableView
        tableView:insertRow(
            {
                isCategory = false,
                rowHeight = 48,
                rowColor = { default={color.hex("edebe9")}, over={color.hex("f15937")} }
            }
        )
    end
 
    --Goto To home page event 
    local function gotoHomeScene( event )
        if ( "ended" == event.phase ) then
            local options = {
                effect = 'fade',
                time = 500,
                params = {
                    sceneNumber = 2,
                    filename = filename
                }
            }
            composer:gotoScene('HomeScene', options)
        end
    end
    
    --ReturnButton
    local returnbutton = widget.newButton(
        {
            parent = sceneGroup,
            label = "Return",
            onEvent = gotoHomeScene,
            emboss = false,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 300,
            height = 80,
            cornerRadius = 10,
            labelColor = {default = {color.hex("edebe9")}, over = {color.hex("34acbc"), 1}},
            fillColor = { default={color.hex("34acbc"),1}, over={color.hex("ff10ae"),1} },
            strokeColor = { default={color.hex("010203"),1}, over={color.hex("f15937"), 1} },
            strokeWidth = 4
        }
    )
    -- Center the button
    returnbutton.x = display.contentCenterX 
    returnbutton.y = display.contentCenterY + 220
    
    
    -- Not currently added (placeholder) 
    -- About Scence Event
    local function AddFile( event )
        if ( "ended" == event.phase ) then
            local options = {
                effect = 'fade',
                time = 500,
                params = {
                    sceneNumber = 2,
                    ilename = selectfile
                    }
                }
            composer.removeScene('selectDataScene')
            composer:gotoScene('HomeScene', options)
        end
    end
   --[[     
    --About Page Button
    local AddFileButton = widget.newButton(
        {
            parent = sceneGroup,
            label = "Add File",
            onEvent = AddFile,
            emboss = false,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 140,
            height = 80,
            cornerRadius = 10,
            labelColor = {default = {color.hex("edebe9")}, over = {color.hex("34acbc"), 1}},
            fillColor = { default={color.hex("34acbc"),1}, over={color.hex("ff10ae"),1} },
            strokeColor = { default={color.hex("010203"),1}, over={color.hex("f15937"), 1} },
            strokeWidth = 4
        }
    )
    -- Center the button
    AddFileButton.x = display.contentCenterX * 1.5
    AddFileButton.y = display.contentCenterY + 220

    sceneGroup:insert(AddFileButton)
    --]]
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