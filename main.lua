local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local string = _tl_compat and _tl_compat.string or string; local NN = require("ai.nn")

local fontGlyph = require("ai.fontGlyph")

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local canvasSize = { w = width / 2, h = height }
local canvas_app_screen
local canvas_nn_screen

function love.load(_args, _unfiltered)

   canvas_nn_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   canvas_app_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   fontGlyph.init()



   NN.create(0, 4, 2)
   NN.addInput("Maus X", function() return love.mouse.getX() / love.graphics.getWidth() * 2 - 1 end)
   NN.addInput("Maus Y", function() return love.mouse.getY() / love.graphics.getHeight() * 2 - 1 end)
   NN.addInput("sin(t)", function() return math.sin(love.timer.getTime()) end)
   NN.addInput("cos(t)", function() return math.cos(love.timer.getTime()) end)
   NN.addInput("const", function() return 1 end)
   NN.createFullMesh()
   NN.update()


   for i = 1, #NN.InputNeurons do
      print("Input Neuron: " .. i .. " " .. " Current Value:  " .. NN.InputNeurons[i]:getVal())
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


   fontGlyph.draw()



   NN.draw(canvasSize.w, canvasSize.h)
   love.graphics.draw(canvas_nn_screen, 0, 0)



   for o, v in ipairs(NN.getOutputs()) do
      love.graphics.print("Output " .. o .. ": " .. string.format("%.3f", v), 10, canvasSize.h - 20 * o - 10)
   end

end

function love.update(_dt)
   NN.update()
end



local loveCallbacks = love
loveCallbacks.keypressed = function(key)
   if key == "a" then
      local phase = love.math.random() * 10
      NN.addInput("rnd " .. (#NN.InputNeurons + 1), function() return math.sin(love.timer.getTime() * 2 + phase) end)
   elseif key == "r" then
      NN.removeInput(#NN.InputNeurons)
   end
end
