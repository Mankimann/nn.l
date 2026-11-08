local Button = require("content.Button")

local MainMenu = {}
MainMenu.__index = MainMenu

local BUTTON_HEIGHT: number = 64
local MARGIN: number = 16

local font: love.graphics.Font = nil
local buttons: {Button} = {}

local function add(text: string, fn: function())
   local w = love.graphics.getWidth() / 3
   local x = (love.graphics.getWidth() - w) * 0.5
   local y = 100 + #buttons * (BUTTON_HEIGHT + MARGIN)
   table.insert(buttons, Button:new(x, y, w, BUTTON_HEIGHT, text, fn, font))
end

function MainMenu.init()
   font = love.graphics.newFont(32)
   add("Start", function() print("Starting Evolution App") end)
   add("Load App", function() print("loading App files") end)
   add("Settings", function() print("Settings Button") end)
   add("Credits", function() print("Credits Button") end)
   add("Exit", function() love.event.quit(0) end)
end

function MainMenu.update()
   for _, b in ipairs(buttons) do b:update() end
end

function MainMenu.draw()
   for _, b in ipairs(buttons) do b:draw() end
end

return MainMenu



--/media/manuelankner/Black Arch Linux/godot/LaughTale/laughtale/assets/MainMenu/buttons/Menu/Hover/
