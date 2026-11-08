local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local string = _tl_compat and _tl_compat.string or string
local NN = require("ai.nn")
local Button = require("content.Button")
local fontGlyph = require("ai.fontGlyph")
local content = require("content.ScreenContent")
local Timer = require("thirdparty.hump.timer")


local nnButton


local alpha = 1
local secs = 0.03
local fadeSpeed = alpha / secs
local isFading = false


local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local canvasSize = { w = width / 2, h = height }


local canvas_app_screen
local canvas_nn_screen

local isNNVisible = true
local isPaused = false



local MagicNumberForTheWin = 64
local buttonsize = { w = canvasSize.w - MagicNumberForTheWin, h = (canvasSize.h / 2) - MagicNumberForTheWin }

local function NFL()
   local hot = (1 - math.pow(math.exp(0.01), 2) - math.cos(2 * math.pi) * love.timer.getTime()) * 0.01
   if hot >= 1 then
      hot = hot - .01
   end
   return hot
end

local function InitNeurons()


   NN.create(0, 4, 2)
   NN.addInput("Maus X", function() return love.mouse.getX() / love.graphics.getWidth() * 2 - 1 end)
   NN.addInput("Maus Y", function() return love.mouse.getY() / love.graphics.getHeight() * 2 - 1 end)
   NN.addInput("sin(t)", function() return math.sin(love.timer.getTime()) end)
   NN.addInput("cos(t)", function() return math.cos(love.timer.getTime()) end)

   NN.addInput("NLF", NFL)
   NN.createFullMesh()
   NN.update()


   for i = 1, #NN.InputNeurons do
      print("Input Neuron: " .. i .. " " .. " Current Value:  " .. NN.InputNeurons[i]:getVal())
   end
end


local function nnButtonLogic()
   nnButton = Button:new(buttonsize.w, buttonsize.h, MagicNumberForTheWin - 10, MagicNumberForTheWin * 0.66, "NN",
   function() isNNVisible = not isNNVisible end)
end

function love.load(_args, _unfiltered)

   canvas_nn_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   canvas_app_screen = love.graphics.newCanvas(canvasSize.w, canvasSize.h)

   InitNeurons()

   fontGlyph.init()

   nnButtonLogic()

   content.init()
end

local function hideNN()
   local fade = { alpha = 1 }
   Timer.tween(fadeSpeed, fade, { alpha = 0 }, "linear", function() isNNVisible = false end)
end


local function drawContent()

   love.graphics.setCanvas(canvas_app_screen)

   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   love.graphics.setColor(1, 1, 1, 1)
   content.draw(isNNVisible, canvasSize.w, 0)
   love.graphics.draw(canvas_app_screen, canvasSize.w, 0)
end

local function drawCanvasNNButton()
   love.graphics.setColor(.33, .100, .33, 1)
   love.graphics.rectangle("fill", buttonsize.w, buttonsize.h, MagicNumberForTheWin - 10, MagicNumberForTheWin * 0.66)
end

local function drawNN()

   if isNNVisible then

      love.graphics.setCanvas(canvas_nn_screen)

      love.graphics.setBlendMode("alpha")
      love.graphics.setCanvas()

      NN.draw(canvasSize.w, canvasSize.h)
      love.graphics.setColor(1, 1, 1, alpha)
      love.graphics.draw(canvas_nn_screen, 0, 0)
      love.graphics.setColor(1, 1, 1, 1)


      love.graphics.setColor(1, 1, 1, 1)
      fontGlyph.draw(NN.getOutputs(), isPaused)
   else
      content.draw(true, 0, 0)
   end
   nnButton:draw()
end


function love.draw()
   drawNN()
   drawContent()


   for o, v in ipairs(NN.getOutputs()) do
      love.graphics.print("Output " .. o .. ": " .. string.format("%.3f", v), 10, canvasSize.h - 20 * o - 10)
   end

end

function love.update(dt)
   Timer.update(dt)

   if not isPaused then
      NN.update()
      content.update(dt)
   end

   nnButton:update()
end


local loveCallbacks = love
loveCallbacks.keypressed = function(key)
   if key == "a" then
      local phase = love.math.random() * 10
      NN.addInput("rnd " .. (#NN.InputNeurons + 1), function()
         return math.sin(love.timer.getTime() * 2 + phase) end)
   elseif key == "r" then
      NN.removeInput(#NN.InputNeurons)
   elseif key == "p" then
      isPaused = not isPaused
   elseif key == "space" then
      love.event.quit("restart")
   end
end
