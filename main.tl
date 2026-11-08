-- imports
local NN = require("ai.nn")
local Button = require("content.Button")
local fontGlyph = require("ai.fontGlyph")
local content = require("content.ScreenContent")
local Timer = require("thirdparty.hump.timer")

-- Buttons
local nnButton: Button

-- Sets the timer stats
local alpha: number = 1
local secs: number = 0.03
local fadeSpeed: number = alpha / secs
local isFading: boolean = false

-- Window handling
local width: number = love.graphics.getWidth()
local height: number = love.graphics.getHeight()
local canvasSize = {w = width/2, h = height}

-- Maybe screens
local canvas_app_screen: love.graphics.Canvas
local canvas_nn_screen: love.graphics.Canvas

local isNNVisible: boolean = true
local isPaused: boolean = false

-- NN Button stuff
--local btn = {} 
local MagicNumberForTheWin: integer = 64
local buttonsize = {w = canvasSize.w - MagicNumberForTheWin, h = (canvasSize.h / 2) - MagicNumberForTheWin}

local function NFL (): number
   local hot: number = (1-math.pow(math.exp(0.01), 2)-math.cos(2 * math.pi)*love.timer.getTime())*0.01
   if hot >= 1 then
      hot = hot - .01
   end
   return hot
end

local function InitNeurons()
   -- load all neurons with the weights
   -- creates a neuronal network with 5 input, 4 working and 2 output neurons,
   NN.create(0, 4, 2)
   NN.addInput("Maus X", function(): number return love.mouse.getX() / love.graphics.getWidth() * 2 - 1 end)
   NN.addInput("Maus Y", function(): number return love.mouse.getY() / love.graphics.getHeight() * 2 - 1 end)
   NN.addInput("sin(t)", function(): number return math.sin(love.timer.getTime()) end)
   NN.addInput("cos(t)", function(): number return math.cos(love.timer.getTime()) end)
   -- this is a simple none linear function
   NN.addInput("NLF", NFL)
   NN.createFullMesh()
   NN.update()

-- Output: 
   for i = 1, #NN.InputNeurons do
      print("Input Neuron: "..i .." " .." Current Value:  "..NN.InputNeurons[i]:getVal())
   end
end


local function nnButtonLogic()
   nnButton = Button:new(buttonsize.w, buttonsize.h, MagicNumberForTheWin - 10, MagicNumberForTheWin * 0.66, "NN",
			 function()  isNNVisible = not isNNVisible  end)
end

function love.load(_args: {string}, _unfiltered: {string})
   -- sets the size of each canvas, neuronal network and the game
   canvas_nn_screen       = love.graphics.newCanvas(canvasSize.w, canvasSize.h)
   canvas_app_screen      = love.graphics.newCanvas(canvasSize.w, canvasSize.h)

   InitNeurons()
   
   fontGlyph.init()

   nnButtonLogic()
   
   content.init()
end

local function hideNN()
   local fade = {alpha = 1}
   Timer.tween(fadeSpeed, fade as table, {alpha = 0} as table ,"linear", function() isNNVisible = false end)
end


local function drawContent()
   -- Canvas of the  App Screen
   love.graphics.setCanvas(canvas_app_screen)
   --love.graphics.clear(0.1, 0.2, 0.5, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   love.graphics.setColor(1, 1, 1, 1)
   content.draw(isNNVisible,canvasSize.w, 0)
   love.graphics.draw(canvas_app_screen, canvasSize.w, 0)
end

local function drawCanvasNNButton()
   love.graphics.setColor(.33, .100, .33, 1)
   love.graphics.rectangle("fill", buttonsize.w, buttonsize.h, MagicNumberForTheWin - 10, MagicNumberForTheWin * 0.66)
end

local function drawNN()

   if isNNVisible then 
   -- Canvas of the Neuronal Network Screen
   love.graphics.setCanvas(canvas_nn_screen)
   --love.graphics.clear(0.1, 0.2, 0.5, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   -- draw the nn
   NN.draw(canvasSize.w, canvasSize.h)
   love.graphics.setColor(1, 1, 1, alpha)
   love.graphics.draw(canvas_nn_screen, 0, 0)
   love.graphics.setColor(1, 1, 1, 1)

   -- Canvas of the nn output in glyph format style
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

   --prints the current output of each output neuron
   for o, v in ipairs(NN.getOutputs()) do
      love.graphics.print("Output " .. o .. ": " .. string.format("%.3f", v), 10, canvasSize.h - 20 * o - 10)
   end

end

function love.update(dt: number)
   Timer.update(dt)
   
   if not isPaused then
      NN.update()
      content.update(dt)
   end

   nnButton:update()
end


local loveCallbacks = love as {string:any}
loveCallbacks.keypressed = function(key: string)
   if key == "a" then
      local phase = love.math.random() * 10
      NN.addInput("rnd " .. (#NN.InputNeurons + 1), function(): number
		  return math.sin(love.timer.getTime() * 2 + phase) end)
   elseif key == "r" then
      NN.removeInput(#NN.InputNeurons)
   elseif key == "p" then
      isPaused = not isPaused
   elseif key == "space" then
      love.event.quit("restart")
   end
end
