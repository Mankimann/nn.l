local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math
local NN = require("ai.nn")
local AF = require("ai.activationsfunctions")

local CreatureNN = {}
CreatureNN.__index = CreatureNN


local randomInput = 5
local randomWorking = 4


local canvas_nn_screen

function CreatureNN.InitNeurons(w, h, outputCount)


   canvas_nn_screen = love.graphics.newCanvas(w, h)

   NN.create(0, randomWorking, outputCount)
   NN.addInput("sigmoid", function() return AF.Sigmoid(0.001) end)
   NN.addInput("Maus Y", function() return love.mouse.getY() / love.graphics.getHeight() * 2 - 1 end)
   NN.addInput("sin(t)", function() return math.sin(love.timer.getTime()) end)
   NN.addInput("cos(t)", function() return math.cos(love.timer.getTime()) end)

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
   NN.addInput("rnd " .. (#NN.InputNeurons + 1), function()
      return math.sin(love.timer.getTime() * 2 + phase)
   end)
end

function CreatureNN.removeLastInput()
   NN.removeInput(#NN.InputNeurons)
end

function CreatureNN.update()
   NN.update()
end

function CreatureNN.getOutputs()
   return NN.getOutputs()
end

function CreatureNN.draw(x, y)
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
