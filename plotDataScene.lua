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
    local detailcheck = false

    --scene objects
    local topbar = display.newRect(sceneGroup, display.contentCenterX, -40, 400, 160)
    topbar:setFillColor(color.hex("edebe9"))
    
    local bottombar = display.newRect(sceneGroup, display.contentCenterX, 400, 400, 200)
    bottombar:setFillColor(color.hex("edebe9"))
    local graphbackground = display.newRect(sceneGroup, display.contentCenterX, 190, 400, 315)
    graphbackground:setFillColor(color.hex("ffffff"))

    -- -----------------------------------------------------------------------------------
    -- TEMP DRIVER
    -- -----------------------------------------------------------------------------------
    local filename = event.params.filename
    local path = system.pathForFile(filename, system.ResourceDirectory)
    local data = proc.loadFile(path)
    
    


    local function displayPlot(data)
        --Get Data points for scaling (x,y)
        local tableX = {}
        local tableY = {}
        local tableC = {}
        for i, v in ipairs(data) do
            tableX[i] = tonumber(v[1])
            tableY[i] = tonumber(v[2])
            tableC[i] = v[3]
        end
        
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
        

        --remove graph details 
        if graphDetails ~= nil then
            display.remove(graphDetails)
        end

        --for graph details
        maxX = tableX[#tableX]
        maxY = tableY[#tableY]
        minX = tableX[1]
        minY = tableY[1]

        --Creating Graph details
        graphDetails = display.newGroup()

        local optionsMinX = 
        {
            parent = graphDetails,
            text = minX,     
            x = display.contentCenterX - 115,
            y = display.contentCenterY + 80,
            width = 30,
            height = 15,
            font = native.systemFont,   
            fontSize = 12,
            align = "center"
        }
        local minxText = display.newText( optionsMinX )
        
        local optionsMinY = 
        {
            parent = graphDetails,
            text = minY,     
            x = display.contentCenterX - 143,
            y = display.contentCenterY + 65,
            width = 30,
            height = 15,
            font = native.systemFont,   
            fontSize = 12,
            align = "center"
        }
        local minyText = display.newText( optionsMinY ) 

        local optionsMidX = 
        {
            parent = graphDetails,
            text = midX,     
            x = display.contentCenterX,
            y = display.contentCenterY + 80,
            width = 30,
            height = 15,
            font = native.systemFont,   
            fontSize = 12,
            align = "center"
        }
        local midxText = display.newText( optionsMidX ) 

        local optionsMidY = 
        {
            parent = graphDetails,
            text = midY,     
            x = display.contentCenterX - 143,
            y = display.contentCenterY - 50,
            width = 30,
            height = 15,
            font = native.systemFont,   
            fontSize = 12,
            align = "center"
        }
        local midyText = display.newText( optionsMidY )

        local optionsMaxX = 
        {
            parent = graphDetails,
            text = maxX,     
            x = display.contentCenterX + 115,
            y = display.contentCenterY + 80,
            width = 30,
            height = 15,
            font = native.systemFont,   
            fontSize = 12,
            align = "center"
        }
        local maxxText = display.newText( optionsMaxX )

        local optionsMaxY = 
        {
            parent = graphDetails,
            text = maxY,     
            x = display.contentCenterX -143,
            y = display.contentCenterY -165,
            width = 30,
            height = 15,
            font = native.systemFont,   
            fontSize = 12,
            align = "center"
        }
        local maxyText = display.newText( optionsMaxY )


        minxText:setFillColor(color.hex("010203"))
        minyText:setFillColor(color.hex("010203"))
        midxText:setFillColor(color.hex("010203"))
        midyText:setFillColor(color.hex("010203"))
        maxxText:setFillColor(color.hex("010203"))
        maxyText:setFillColor(color.hex("010203"))

        local plotdividerLine1 =
        display.newLine(
        graphDetails,
        display.contentCenterX - 146 ,
        display.contentCenterY - 153,
        display.contentCenterX - 146 ,
        display.contentCenterY - 65
        )
        plotdividerLine1.strokeWidth = 1
        plotdividerLine1:setStrokeColor(color.hex("010203"))
    
        local plotdividerLine2 =
        display.newLine(
        graphDetails,
        display.contentCenterX - 146 ,
        display.contentCenterY - 36,
        display.contentCenterX - 146 ,
        display.contentCenterY + 52
        )
        plotdividerLine2.strokeWidth = 1
        plotdividerLine2:setStrokeColor(color.hex("010203"))

        local plotdividerLine3 =
        display.newLine(
        graphDetails,
        display.contentCenterX + 95,
        display.contentCenterY + 80,
        display.contentCenterX + 17,
        display.contentCenterY + 80
        )
        plotdividerLine3.strokeWidth = 1
        plotdividerLine3:setStrokeColor(color.hex("010203"))
    
        local plotdividerLine4 =
        display.newLine(
        graphDetails,
        display.contentCenterX - 20 ,
        display.contentCenterY + 80,
        display.contentCenterX - 98,
        display.contentCenterY + 80
        )
        plotdividerLine4.strokeWidth = 1
        plotdividerLine4:setStrokeColor(color.hex("010203"))

        sceneGroup:insert(graphDetails)

        --finding all unique classes
        local hash = {}
        local uniqueClass = {}

        for _,v in ipairs(tableC) do
            if (not hash[v]) then
                uniqueClass[#uniqueClass+1] = v -- you could print here instead of saving to result table if you wanted
                hash[v] = true
            end
        end

        --find # of dot to scale width
        local dotScale = 3
        if #tableX <= 10 then
            dotScale = 4
        elseif #tableX >= 11 and #tableX <= 40 then
            dotScale = 3
        elseif #tableX >= 41 and #tableX <= 100 then
            dotScale = 2
        elseif #tableX >= 101 then
            dotScale = 1
        end

        --Displaying points
        for i, v in ipairs(data) do
            --Creating display group for current point and adding point to the graph
            local point =  display.newGroup()
            graph:insert(point) 
    
            local dot = display.newCircle(point, 0, 0, dotScale)
            
            --Dot Fill Colour
            if v[3] == uniqueClass[1] then
                dot:setFillColor(color.hex("4472C4"))
            elseif v[3] == uniqueClass[2] then
                dot:setFillColor(color.hex("ED7D31"))
            elseif v[3] == uniqueClass[3] then
                dot:setFillColor(color.hex("FFC000"))
            elseif v[3] == uniqueClass[4] then
                dot:setFillColor(color.hex("5B9BD5"))
            elseif v[3] == uniqueClass[5] then
                dot:setFillColor(color.hex("70AD47"))
            else  
                dot:setFillColor(color.hex("ffffff"))
            end
            point.x = graphScaleX * v[1]
            point.y = -graphScaleY * v[2]
        end
    end
    --ploting the default data first time
    displayPlot(data)
    
    --Garph Detaling
    local graphtTile = 
    {
        parent = sceneGroup,
        text = filename,     
        x = display.contentCenterX,
        y = display.contentCenterY - 190,
        width = 128,
        height = 15,
        font = native.systemFont,   
        fontSize = 12,
        align = "center"
    }
    local GraphTitleText = display.newText( graphtTile )
    GraphTitleText:setFillColor(color.hex("010203"))
  
    -- Set up the picker wheel columns
    local columnData = 
    { 
        { 
            align = "center",
            labelPadding = 20,
            startIndex = 2,
            labels = { "f(y) = sin(y+2)", "f(y) = cos(y+2)", "f(y) = atan(y)", "f(y) = atan2(y,x) ","f(x) = atan2(y,x)", "f(y) = abs(log(y+8)","f(y) = y^(1/3)","f(y) = 1/y","f(x) = 1/x","f(y) = y^x","f(x) = log(x)","f(y) = log(y)","f(y) = cosh(y)"  }
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
        rowHeight = 19,
        fontSize = 12,
        fontColor = {color.hex("323639")},
        fontColorSelected = {color.hex("f15937")},
        columnColor = {color.hex("edebe9")}
    })
       
     
    --Apply Function button Event
    local function applyEvent( event )
 
        if ( "ended" == event.phase ) then
            local values = pickerWheel:getValues()
            local currentfunction = values[1].index
            print(currentfunction)
            if currentfunction == 1 then
                data = proc.transformation1(data)
                displayPlot(data)
            elseif currentfunction == 2 then
                data = proc.transformation2(data)
                displayPlot(data)
            elseif currentfunction == 3 then
                data = proc.transformation3(data)
                displayPlot(data)
            elseif currentfunction == 4 then
                data = proc.transformation4(data)
                displayPlot(data)
            elseif currentfunction == 5 then
                data = proc.transformation5(data)
                displayPlot(data)
            elseif currentfunction == 6 then
                data = proc.transformation6(data)
                displayPlot(data)
            elseif currentfunction == 7 then
                data = proc.transformation7(data)
                displayPlot(data)
            elseif currentfunction == 8 then
                data = proc.transformation8(data)
                displayPlot(data)
            elseif currentfunction == 9 then
                data = proc.transformation9(data)
                displayPlot(data)
            elseif currentfunction == 10 then
                data = proc.transformation10(data)
                displayPlot(data)
            elseif currentfunction == 11 then
                data = proc.transformation11(data)
                displayPlot(data)
            elseif currentfunction == 12 then
                data = proc.transformation12(data)
                displayPlot(data)
            elseif currentfunction == 13 then
                data = proc.transformation13(data)
                displayPlot(data)
            end 
        end
    end

    --Apply Function button
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
            strokeWidth = 3
        }
    )

    -- Center the button
    applybutton.x = display.contentCenterX + 95
    applybutton.y = display.contentCenterY + 125

    --Return to Default Button Event
    local function dataDefaultEvent( event )
        if ( "ended" == event.phase ) then
            data = proc.loadFile(path)
            displayPlot(data)
        end
    end

    --Return to Default Button
    local dataDefaultButton = widget.newButton(
        {
            label = "Default",
            onEvent = dataDefaultEvent,
            emboss = false,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 180,
            height = 45,
            cornerRadius = 2,
            labelColor = {default = {color.hex("edebe9")}, over = {color.hex("34acbc"), 1}},
            fillColor = { default={color.hex("34acbc"),1}, over={color.hex("ff10ae"),1} },
            strokeColor = { default={color.hex("010203"),1}, over={color.hex("f15937"), 1} },
            strokeWidth = 3
        }
    )

    sceneGroup:insert(dataDefaultButton)
    sceneGroup:insert(applybutton)
    sceneGroup:insert(pickerWheel)

    -- Center the button
    dataDefaultButton.x = display.contentCenterX + 95
    dataDefaultButton.y = display.contentCenterY + 170

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
            composer.removeScene('plotDataScene')
            composer:gotoScene('HomeScene', options)
        end
    end
    
    --ReturnButton
    local returnbutton = widget.newButton(
        {
            parent = sceneGroup,
            label = "<",
            onEvent = gotoHomeScene,
            emboss = false,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 48,
            height = 32,
            cornerRadius = 14,
            labelColor = {default = {color.hex("edebe9")}, over = {color.hex("34acbc"), 1}},
            fillColor = { default={color.hex("34acbc"),1}, over={color.hex("ff10ae"),1} },
            strokeColor = { default={color.hex("010203"),1}, over={color.hex("f15937"), 1} },
            strokeWidth = 4
        }
    )

    sceneGroup:insert(returnbutton)

    -- Center the button
    returnbutton.x = display.contentCenterX - 120
    returnbutton.y = display.contentCenterY - 240

    -- Title Text Select Data
    local titleText = display.newText(
        {
            parent = sceneGroup,
            text = "Graph",
            x = display.contentCenterX,
            y = display.contentCenterY -240,
            font = native.systemFontBold,
            fontSize = 46
        }
    )
    titleText:setFillColor( color.hex("ef3d43") )

    local dividerLine1 =
        display.newLine(
        sceneGroup,
        display.contentCenterX - 250,
        display.contentCenterY - 209,
        display.contentCenterX + 250,
        display.contentCenterY - 209
    )
    dividerLine1.strokeWidth = 3
    dividerLine1:setStrokeColor(color.hex("010203"))

    local dividerLine2 =
    display.newLine(
    sceneGroup,
    display.contentCenterX - 250,
    display.contentCenterY + 102,
    display.contentCenterX + 250,
    display.contentCenterY + 102
    )
    dividerLine2.strokeWidth = 3
    dividerLine2:setStrokeColor(color.hex("010203"))

    local dividerLine3 =
    display.newLine(
    sceneGroup,
    display.contentCenterX - 250,
    display.contentCenterY + 193,
    display.contentCenterX + 250,
    display.contentCenterY + 193
    )
    dividerLine3.strokeWidth = 3
    dividerLine3:setStrokeColor(color.hex("010203"))

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