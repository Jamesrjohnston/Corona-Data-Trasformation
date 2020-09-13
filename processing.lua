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

local M = {}

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


return M