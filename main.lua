


local NN = require("ai.nn")





local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local canvasSize = { w = width / 2, h = height }
local canvas_app_screen
local canvas_nn_screen

function love.load(_args, _unfiltered)

   canvas_app_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   canvas_nn_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)


   NN.create(5, 4, 2)
   NN.createFullMesh()
   for i = 1, #NN.InputNeurons do
      print("Input: Neuron " .. i .. " " .. " Current Value:  " .. NN.InputNeurons[i]:getVal())
      if i == #NN.InputNeurons then
         for w = 1, #NN.WorkingNeurons do
            print("Working: Neuron " .. w .. " " .. " Current Value:  " .. NN.WorkingNeurons[w]:getVal())
         end
      end
   end
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
   NN.update(love.timer.getTime())
end
