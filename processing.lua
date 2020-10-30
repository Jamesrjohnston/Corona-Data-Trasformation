-----------------------------------------------------------------------------------------
--
-- processing.lua
--
--Graphic Simulation of a Machine Learning Data Separator
--Project: Mobile App
--CSP2108 Introduction to Mobile Applcations Development 
-- Sem 2 2020
--By James Johnston - 10461776
-- This file will handle all the processing of the data
-----------------------------------------------------------------------------------------
local math = require('math')

local M = {}

--rounding function (find link for this thing)
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end


function M.loadFile(path)
    -- Initalise table
    local points = {}
    -- Open the file handle
    local file, errorString = io.open(path, 'r')
    if not file then
        -- Error occurred; output the cause
        print('File error: ' .. errorString)
    else
        local lineIndex = 1
        -- add each line to table
        for line in file:lines() do
            -- add row to table, formatted as [x, y, classifier].
            points[lineIndex] = {}
            points[lineIndex][1], points[lineIndex][2], points[lineIndex][3] =
                string.match(line, '(.*),(.*),(%a*)', 1)
            lineIndex = lineIndex + 1
        end
        -- Close the file handle
        io.close(file)
    end
    local file = nil
    return points
end

--f(y) = sin(y+2)
function M.transformation1(data)
    for i, v in ipairs(data) do
        y = v[2]
        data[i][2] = math.sin(y+2)
    end
    return data
end
function M.transformation2(data)
    for i, v in ipairs(data) do
        y = v[2]
        data[i][2] = math.cos(y+2)
    end
    return data
end
function M.transformation3(data)
    for i, v in ipairs(data) do
        y = v[2]
        data[i][2] = math.atan(y) 
    end
    return data
end
function M.transformation4(data)
    for i, v in ipairs(data) do
        y = v[2]
        x = v[1]
        data[i][2] = math.atan2(y,x)
    end
    return data
end
function M.transformation5(data)
    for i, v in ipairs(data) do
        y = v[2]
        x = v[1]
        data[i][1] = math.atan2(y,x)
    end
    return data
end
function M.transformation6(data)
    for i, v in ipairs(data) do
        x = v[1]
        y = v[2]
        data[i][1] = x^(1/3)
    end
    return data
end
function M.transformation7(data)
    for i, v in ipairs(data) do
        x = v[1]
        y = v[2]
        data[i][2] = y^(1/3)
    end
    return data
end
function M.transformation8(data)
    for i, v in ipairs(data) do
        x = v[1]
        y = v[2]
        data[i][2] = 1/y
    end
    return data
end
function M.transformation9(data)
    for i, v in ipairs(data) do
        x = v[1]
        y = v[2]
        data[i][1] = 1/x
    end
    return data
end
function M.transformation10(data)
    for i, v in ipairs(data) do
        x = v[1]
        y = v[2]
        data[i][2] = y^x
    end
    return data
end
function M.transformation11(data)
    for i, v in ipairs(data) do
        x = v[1]
        y = v[2]
        data[i][1] = math.log(x)
    end
    return data
end
function M.transformation12(data)
    for i, v in ipairs(data) do
        x = v[1]
        y = v[2]
        data[i][2] = math.log(y)
    end
    return data
end
function M.transformation13(data)
    for i, v in ipairs(data) do
        x = v[1]
        y = v[2]
        data[i][2] = math.cosh(y)
    end
    return data
end
return M