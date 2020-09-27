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

--f(x) = sin(y+2)
function M.transformation1(data)
    for i, v in ipairs(data) do
        y = v[2]
        data[i][2] = math.sin(y+2)
    end
    return data
end
--f(x) = y3 + y2 – 3y – 1
function M.transformation2(data)
    for i, v in ipairs(data) do
        y = v[2]
        data[i][2] = y*3 + y*2 - 3*y - 1
    end
    return data
end
function M.transformation3(data)

    for i, v in ipairs(data) do
        y = v[2]
        data[i][2] = -y-3*y-4
    end
    return data
end
function M.transformation4(data)
    for i, v in ipairs(data) do
        y = v[2]
        data[i][2] = (y + 4) * 2
    end
    return data
end
function M.transformation5(data)
    for i, v in ipairs(data) do
        y = v[2]
        data[i][2] = y * 3 + y * 2 -3 * y - 1
    end
    return data
end

return M