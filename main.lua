local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local string = _tl_compat and _tl_compat.string or string; local InputNeuron = require("ai.inputNeuron")
local WorkingNeuron = require("ai.workingNeuron")
local Activationfunction = require("ai.activationsfunctions")
local NN = require("ai.nn")

local output = 0
local input = InputNeuron:new()
local working = WorkingNeuron:new()

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local canvasSize = { w = width / 2, h = height }
local canvas_app_screen
local canvas_nn_screen


local function loadNeurons()
   input:setVal(3)
   working:addNeuronConnenction(input, 0.5)
   output = Activationfunction:Sigmoid(working:getVal())
end

function love.load(_args, _unfiltered)

   canvas_app_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   canvas_nn_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)

   loadNeurons()

   NN.create(5, 4, 2)
end

local function drawNN()
   input:draw({ x = 100, y = 100 }, "Input")
   working:draw({ x = 250, y = 100 }, "Working")
   input:draw({ x = 400, y = 100 }, "Output")
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.line(125, 100, 225, 100)
   love.graphics.line(275, 100, 375, 100)
   love.graphics.print("in: " .. input:getVal(), 80, 140)
   love.graphics.print("w: 0.5", 155, 80)
   love.graphics.print("sum: " .. working:getVal(), 225, 140)
   love.graphics.print("out: " .. string.format("%.3f", output), 370, 140)
end


function love.draw()

   love.graphics.setCanvas(canvas_app_screen)
   love.graphics.clear(0.1, 0.2, 0.5, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.draw(canvas_app_screen, canvasSize.w, 0)


   love.graphics.setCanvas(canvas_nn_screen)

   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()


   NN.draw(canvasSize.w, canvasSize.h)

   love.graphics.draw(canvas_nn_screen, 0, 0)
end

function love.update(dt)

end
