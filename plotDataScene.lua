-----------------------------------------------------------------------------------------
--
-- plotDataScene.lua
--
--Graphic Simulation of a Machine Learning Data Separator
--Project: Mobile App
--CSP2108 Introduction to Mobile Applcations Development 
-- Sem 2 2020
--By James Johnston - 10461776
-- This File will plot the data on a graph
--------------------------------------------------------------------------------------------

local composer = require( "composer" )
local color = require("convertcolor")
local proc = require 'processing'
local widget = require('widget')
local math = require 'math'

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
    local proc = require 'processing'
    local sceneGroup = self.view
    
    --defining some stuff
    local graphSize = 230

    --scene objects
    local topbar = display.newRect(sceneGroup, display.contentCenterX, -40, 400, 160)
    topbar:setFillColor(color.hex("323639"))
    
    local bottombar = display.newRect(sceneGroup, display.contentCenterX, 400, 400, 140)
    bottombar:setFillColor(color.hex("323639"))
    local graphbackground = display.newRect(sceneGroup, display.contentCenterX, 190, 400, 315)
    graphbackground:setFillColor(color.hex("ffffff"))
    -- -----------------------------------------------------------------------------------
    -- TEMP DRIVER
    -- -----------------------------------------------------------------------------------
    local path = system.pathForFile("data.csv", system.ResourceDirectory)
    local data = proc.loadFile(path)
    

    
    
    


    local function displayPlot(data)
        --Get Data points for scaling (x,y)
        local tableX = {}
        local tableY = {}
        for i, v in ipairs(data) do 
            tableX[i] = v[1]
            tableY[i] = v[2]
        end
    
        -- table.sort(tableX)
        -- table.sort(tableY)
        
        -- Sort table to make shit easier
        table.sort(
            tableX,
            function(a, b)
                return tonumber(a) < tonumber(b)
            end
        )
        table.sort(
            tableY,
            function(a, b)
                return tonumber(a) < tonumber(b)
            end
        )
    
        -- Finding the range for x,y cords
        local rangeX = tableX[#tableX] - tableX[1] -- abeleX[#tableX] = max  tableX[1] = min
        local rangeY = tableY[#tableY] - tableY[1] -- abeleX[#tableY] = max  tableY[1] = min
        local range = nil
        local range = {rangeX, rangeY}
        

        local graphScaleX = graphSize / range[1]
        local graphScaleY = graphSize / range[2]
        
    
      --[[  
        --Find range mid points
        local x = nil local y = nil
        local x = ((tableX[#tableX] + tableX[1]) / 2) * graphScale
        local y = ((tableY[#tableY] + tableY[1]) / 2) * graphScale
        ]]--
        
        midX = (tableX[#tableX] + tableX[1]) / 2 
        midY = (tableY[#tableY] + tableY[1]) / 2

        x = midX * graphScaleX
        y = midY * graphScaleY

    
        --remove graph
        if graph ~= nil then
            display.remove(graph)
        end
        
        --Creating Graph
        graph = display.newGroup()
        graph.x = display.contentCenterX - x
        graph.y = display.contentCenterY + y - 50
        sceneGroup:insert(graph)
        
        --Displaying points
        for i, v in ipairs(data) do
            --Creating display group for current point and adding point to the graph
            local point =  display.newGroup()
            graph:insert(point) 
    
            local dot = display.newCircle(point, 0, 0, 3)
            
            --Dot Fill Colour (BAD FIX IN REAL IMPLATIONS -- make more robust not hard set) <-- like a random range or some shit
    
            if v[3] == 'B' then
                dot:setFillColor(color.hex("0000ff"))
            elseif v[3] == 'M' then
                dot:setFillColor(color.hex("00ff00"))
            elseif v[3] == 'Z' then
                dot:setFillColor(color.hex("ff0000"))
            else  
                dot:setFillColor(color.hex("ffffff"))
            end
            
            point.x = graphScaleX * v[1]
            point.y = -graphScaleY * v[2]
        end
    end
    displayPlot(data)


   

    local widget = require( "widget" )
 
    -- Set up the picker wheel columns
    local columnData = 
    { 
        { 
            align = "center",
            labelPadding = 20,
            startIndex = 2,
            labels = { "Test1", "Test2", "Test3", "Test4" }
        }
    }
     
    -- Create the widget
    local pickerWheel = widget.newPickerWheel(
    {
        x = display.contentCenterX,
        top = display.contentHeight - 140,
        columns = columnData,
        style = "resizable",
        width = 180,
        rowHeight = 18,
        fontSize = 12,
        fontColor = {color.hex("323639")},
        fontColorSelected = {color.hex("f15937")},
        columnColor = {color.hex("edebe9")}
    })
     
    -- Get the table of current values for all columns
    -- This can be performed on a button tap, timer execution, or other event
    local values = pickerWheel:getValues()
     
    --About Scence Event
    local function applyEvent( event )
 
        if ( "ended" == event.phase ) then
            local values = pickerWheel:getValues() 
            local currentfunction = values[1].value
            print(currentfunction)

            if currentfunction == "Test1" then
                data = proc.cubeRoot1(data)
                displayPlot(data)
            end
        end
    end

    --About Page Button
    local applybutton = widget.newButton(
        {
            label = "Apply",
            onEvent = applyEvent,
            emboss = false,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 180,
            height = 45,
            cornerRadius = 2,
            labelColor = {default = {color.hex("edebe9")}, over = {color.hex("34acbc"), 1}},
            fillColor = { default={color.hex("34acbc"),1}, over={color.hex("ff10ae"),1} },
            strokeColor = { default={color.hex("010203"),1}, over={color.hex("f15937"), 1} },
            strokeWidth = 4
        }
    )
    sceneGroup:insert(applybutton)

    -- Center the button
    applybutton.x = display.contentCenterX + 95
    applybutton.y = display.contentCenterY + 125



    -- -----------------------------------------------------------------------------------
    -- TEMP DRIVER
    -- -----------------------------------------------------------------------------------

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