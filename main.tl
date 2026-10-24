local InputNeuron = require("inputNeuron")
local WorkingNeuron = require("workingNeuron")
local Activationfunction = require("activationsfunctions")

local output: number = 0

function love.load(_args: {string}, _unfiltered: {string})
   InputNeuron:setVal(3)
   WorkingNeuron:addNeuronConnenction(InputNeuron, 0.5)
   output = Activationfunction:Sigmoid(WorkingNeuron:getVal())
end

function love.draw()
   InputNeuron:draw({ x = 100, y = 100 }, "Input")
   WorkingNeuron:draw({ x = 250, y = 100 }, "Working")
   InputNeuron:draw({ x = 400, y = 100 }, "Output")

   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.line(125, 100, 225, 100)
   love.graphics.line(275, 100, 375, 100)
   love.graphics.print("in: " .. InputNeuron:getVal(), 80, 140)
   love.graphics.print("w: 0.5", 155, 80)
   love.graphics.print("sum: " .. WorkingNeuron:getVal(), 225, 140)
   love.graphics.print("out: " .. string.format("%.3f", output), 370, 140)
end

function love.update(dt: number)

end
