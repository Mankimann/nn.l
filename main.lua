local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local string = _tl_compat and _tl_compat.string or string
local MenuBar = require("content.MenuBar")
local fontGlyph = require("ai.fontGlyph")
local content = require("content.ScreenContent")
local MenuScreen = require("content.MenuScreen")
local Events = require("content.Events")
local Creature = require("content.creature.Creature")
local CreatureNN = require("content.creature.CreatureNN")


local width = love.graphics.getWidth()
local height = love.graphics.getHeight()
local canvasSize = { w = width / 2, h = height }

local isMenuVisible = true
local isNNVisible = true
local isPaused = false

local outputNeurons = 2

local creature

local function appOffsetX()
   if isNNVisible then
      return canvasSize.w
   end
   return 0
end

local function startApp()
   isMenuVisible = false
   MenuBar.ignoreCurrentClick()
   creature.wasDown = true
end

function love.load(_args, _unfiltered)
   MenuScreen.init()
   CreatureNN.InitNeurons(canvasSize.w, canvasSize.h - MenuBar.HEIGHT, outputNeurons)
   fontGlyph.init(MenuBar.HEIGHT + 10)
   content.init()


   MenuBar.add("NN", function() isNNVisible = not isNNVisible; if isNNVisible then isNNVisible = false end end)
   creature = Creature.new(200, 200, "Creature 1")

   Events.on("startApp", startApp)
   Events.on("creatureClicked", function() isNNVisible = true end)
end

local function drawContent()
   local x = appOffsetX()
   content.draw(true, x, MenuBar.HEIGHT)
   creature:draw(x, MenuBar.HEIGHT)
end

local function drawNN()
   if isNNVisible then
      CreatureNN.draw(0, MenuBar.HEIGHT)

      fontGlyph.draw(CreatureNN.getOutputs(), isPaused)
   end
end

function love.draw()
   if isMenuVisible then
      MenuScreen.draw()
      return
   end

   drawContent()
   drawNN()
   MenuBar.draw()


   for o, v in ipairs(CreatureNN.getOutputs()) do
      love.graphics.print("Output " .. o .. ": " .. string.format("%.3f", v), 10, canvasSize.h - 20 * o - 10)
   end
end

function love.update(dt)
   if isMenuVisible then
      MenuScreen.update()
      return
   end

   if not isPaused then
      CreatureNN.update()
      content.update(dt)
      creature:update(dt)
   end

   MenuBar.update()
   creature:checkClick(appOffsetX(), MenuBar.HEIGHT)
end

local loveCallbacks = love
loveCallbacks.keypressed = function(key)

   if key == "a" then
      CreatureNN.addRandomInput()

   elseif key == "r" then
      CreatureNN.removeLastInput()

   elseif key == "p" then
      isPaused = not isPaused

   elseif key == "space" then
      love.event.quit("restart")

   elseif key == "escape" then
      love.event.quit(0)
   end
end
