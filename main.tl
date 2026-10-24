local InputNeuron = require("inputNeuron")
local WorkingNeuron = require("workingNeuron")
local Activationfunction = require("activationsfunctions")

local output: number = 0
local width: number = love.graphics.getWidth() / 2
local height: number = love.graphics.getHeight()
local canvasSize = {w = width, h = height}
local canvas: love.graphics.Canvas

local function loadNeurons()
   InputNeuron:setVal(3)
   WorkingNeuron:addNeuronConnenction(InputNeuron, 0.5)
   output = Activationfunction:Sigmoid(WorkingNeuron:getVal())
end

function love.load(_args: {string}, _unfiltered: {string})
   canvas = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   loadNeurons()
end

function love.draw()
   InputNeuron:draw({ x = 100, y = 100 }, "Input")
   WorkingNeuron:draw({ x = 250, y = 100 }, "Working")
   InputNeuron:draw({ x = 400, y = 100 }, "Output")
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.line(125, 100,   225, 100)
   love.graphics.line(275, 100, 375, 100)
   love.graphics.print("in: " .. InputNeuron:getVal(), 80, 140)
   love.graphics.print("w: 0.5", 155, 80)
   love.graphics.print("sum: " .. WorkingNeuron:getVal(), 225, 140)
   love.graphics.print("out: " .. string.format("%.3f", output), 370, 140)

   
   love.graphics.setCanvas(canvas)
   love.graphics.clear(0.1, 0.2, 0.5, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.draw(canvas, canvasSize.w, 0)
end

function love.update(dt: number)
   print("Width:" .."%d "..width)
end
