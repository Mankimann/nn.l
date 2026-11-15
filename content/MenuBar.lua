local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local table = _tl_compat and _tl_compat.table or table; local Button = require("content.Button")

local MenuBar = {}



MenuBar.HEIGHT = 32

local PADDING = 4
local BUTTON_WIDTH = 64

local buttons = {}

function MenuBar.add(text, fn)
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
