-- My Imports
local NN         = require("ai.nn")
local AF         = require("ai.activationsfunctions")

local CreatureNN = {}
CreatureNN.__index = CreatureNN

-- Stats of the NN
local randomInput: integer = 5
local randomWorking: integer = 4

-- Vars
local canvas_nn_screen: love.graphics.Canvas

function CreatureNN.InitNeurons(w: number, h: number, outputCount: integer)
   -- load all neurons with the weights
   -- creates a neuronal network with 5 input, 4 working and 2 output neurons,
   canvas_nn_screen = love.graphics.newCanvas(w, h)

   NN.create(0, randomWorking, outputCount)
   NN.addInput("sigmoid", function(): number return AF.Sigmoid(0.001) end)
   NN.addInput("Maus Y", function(): number return love.mouse.getY() / love.graphics.getHeight() * 2 - 1 end)
   NN.addInput("sin(t)", function(): number return math.sin(love.timer.getTime()) end)
   NN.addInput("cos(t)", function(): number return math.cos(love.timer.getTime()) end)
   -- this is a simple none linear function
   NN.addInput("NLF", AF.NFL)
   NN.addInput("NLF alt", AF.NFLOld)
   NN.createFullMesh()
   NN.update()

   for i = 1, #NN.InputNeurons do
      print("Input Neuron: " .. i .. "  Current Value:  " .. NN.InputNeurons[i]:getVal())
   end
end

function CreatureNN.addRandomInput()
   local phase = love.math.random() * 10
   NN.addInput("rnd " .. (#NN.InputNeurons + 1), function(): number
      return math.sin(love.timer.getTime() * 2 + phase)
   end)
end

function CreatureNN.removeLastInput()
   NN.removeInput(#NN.InputNeurons)
end

function CreatureNN.update()
   NN.update()
end

function CreatureNN.getOutputs(): {number}
   return NN.getOutputs()
end

function CreatureNN.draw(x: number, y: number)
   love.graphics.setCanvas(canvas_nn_screen)
   love.graphics.clear(0, 0, 0, 0)
   NN.draw(canvas_nn_screen:getWidth(), canvas_nn_screen:getHeight())
   love.graphics.setCanvas()

   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.setBlendMode("alpha", "premultiplied")
   love.graphics.draw(canvas_nn_screen, x, y)
   love.graphics.setBlendMode("alpha")
end

return CreatureNN
