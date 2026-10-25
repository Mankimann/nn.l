local NN                 = require("ai.nn")

local width: number = love.graphics.getWidth()
local height: number = love.graphics.getHeight()
local canvasSize = {w = width/2, h = height}
local canvas_app_screen: love.graphics.Canvas
local canvas_nn_screen: love.graphics.Canvas

function love.load(_args: {string}, _unfiltered: {string})
   -- sets the size of each canvas, neuronal network and the game
   canvas_app_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   canvas_nn_screen  = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   -- load all neurons with the weights
   -- creates a neuronal network with 5 input, 4, working and 2 output neurons 
   NN.create(5, 4, 2)
   NN.createFullMesh()

-- Output: 
   for i = 1, #NN.InputNeurons do
      print("Input Neuron: "..i .." " .." Current Value:  "..NN.InputNeurons[i]:getVal())
      if i == #NN.InputNeurons then
	 for w = 1, #NN.WorkingNeurons do
      print("Working Neuron: "..w .." " .." Current Value:  "..NN.WorkingNeurons[w]:getVal())
   end
      end
   end
end

function love.draw()
   -- App Screen
   love.graphics.setCanvas(canvas_app_screen)
   love.graphics.clear(0.1, 0.2, 0.5, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.draw(canvas_app_screen, canvasSize.w, 0)

   -- Neuronal Network Screen
   love.graphics.setCanvas(canvas_nn_screen)
   --love.graphics.clear(0.1, 0.2, 0.5, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   --love.graphics.setColor(1, 1, 1, 1)
   -- draw the nn
   NN.draw(canvasSize.w, canvasSize.h)
   love.graphics.draw(canvas_nn_screen, 0, 0)
   for o = 1, #NN.OutputNeurons do
      print("Output Neuron: "..o .." " .." Current Value:  "..NN.WorkingNeurons[o]:getVal())
  end
end

function love.update(dt: number)
   NN.update(love.timer.getTime())
end
