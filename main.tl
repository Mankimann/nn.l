local NN        = require("ai.nn")

local fontGlyph = require("ai.fontGlyph")

local width: number = love.graphics.getWidth()
local height: number = love.graphics.getHeight()
local canvasSize = {w = width/2, h = height}
local canvas_app_screen: love.graphics.Canvas
local canvas_nn_screen: love.graphics.Canvas

function love.load(_args: {string}, _unfiltered: {string})
   -- sets the size of each canvas, neuronal network and the game
   canvas_nn_screen       = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   canvas_app_screen      = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   fontGlyph.init()
   -- load all neurons with the weights
   -- creates a neuronal network with 0 input, 4 working and 2 output neurons,
   -- inputs kommen dynamisch dazu: name + function die den Wert liefert (am besten -1 .. 1)
   NN.create(0, 4, 2)
   NN.addInput("Maus X", function(): number return love.mouse.getX() / love.graphics.getWidth() * 2 - 1 end)
   NN.addInput("Maus Y", function(): number return love.mouse.getY() / love.graphics.getHeight() * 2 - 1 end)
   NN.addInput("sin(t)", function(): number return math.sin(love.timer.getTime()) end)
   NN.addInput("cos(t)", function(): number return math.cos(love.timer.getTime()) end)
   NN.addInput("const", function(): number return 1 end)
   NN.createFullMesh()
   NN.update()

-- Output: 
   for i = 1, #NN.InputNeurons do
      print("Input Neuron: "..i .." " .." Current Value:  "..NN.InputNeurons[i]:getVal())
   end
end

function love.draw()
   -- Canvas of the  App Screen
   love.graphics.setCanvas(canvas_app_screen)
   love.graphics.clear(0.1, 0.2, 0.5, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.draw(canvas_app_screen, canvasSize.w, 0)

   -- Canvas of the Neuronal Network Screen
   love.graphics.setCanvas(canvas_nn_screen)
   --love.graphics.clear(0.1, 0.2, 0.5, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()

   -- Canvas of the nn output in glyph format style
   fontGlyph.draw()
   
   --love.graphics.setColor(1, 1, 1, 1)
   -- draw the nn
   NN.draw(canvasSize.w, canvasSize.h)
   love.graphics.draw(canvas_nn_screen, 0, 0)

  
   --prints the current output of each output neuron
   for o, v in ipairs(NN.getOutputs()) do
      love.graphics.print("Output " .. o .. ": " .. string.format("%.3f", v), 10, canvasSize.h - 20 * o - 10)
   end

end

function love.update(_dt: number)
   NN.update()
end

-- a = neuen zufaelligen Input dazu, r = letzten Input entfernen
-- (love.keypressed ist in den Typen polymorph deklariert, daher der Cast)
local loveCallbacks = love as {string:any}
loveCallbacks.keypressed = function(key: string)
   if key == "a" then
      local phase = love.math.random() * 10
      NN.addInput("rnd " .. (#NN.InputNeurons + 1), function(): number return math.sin(love.timer.getTime() * 2 + phase) end)
   elseif key == "r" then
      NN.removeInput(#NN.InputNeurons)
   end
end
