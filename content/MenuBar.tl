local Button = require("content.Button")

local record MenuBar
   HEIGHT: number
end

MenuBar.HEIGHT = 32

local PADDING: number = 4
local BUTTON_WIDTH: number = 64

local buttons: {Button} = {}

function MenuBar.add(text: string, fn: function()): Button
   local x = PADDING + #buttons * (BUTTON_WIDTH + PADDING)
   local button = Button:new(x, PADDING, BUTTON_WIDTH, MenuBar.HEIGHT - 2 * PADDING, text, fn)
   table.insert(buttons, button)
   return button
end

function MenuBar.ignoreCurrentClick()
   for _, b in ipairs(buttons) do
      b.wasDown = true
   end
end

function MenuBar.update()
   for _, b in ipairs(buttons) do
      b:update()
   end
end

function MenuBar.draw()
   love.graphics.setColor(0.15, 0.15, 0.2, 1)
   love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), MenuBar.HEIGHT)
   love.graphics.setColor(1, 1, 1, 1)
   for _, b in ipairs(buttons) do
      b:draw()
   end
end

return MenuBar
