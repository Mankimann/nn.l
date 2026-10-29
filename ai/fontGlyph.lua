local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local assert = _tl_compat and _tl_compat.assert or assert; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local pairs = _tl_compat and _tl_compat.pairs or pairs
local fontGlyph = {}
fontGlyph.__index = fontGlyph

local canvas_nn_glyph_output
local canvasGlyphHeight = 50
local canvasGlyphPosition = { x = 10, y = 20 }
local width = love.graphics.getWidth()
local alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

local numbers = {

   [0] = { { 1, 1, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 1, 1, 1 } },
   [1] = { { 0, 1, 1 }, { 0, 0, 1 }, { 0, 0, 1 }, { 1, 1, 1, 1 } },

   [2] = { { 1, 1, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 1, 1, 1 } },
   [3] = { { 0, 1, 1 }, { 0, 0, 1 }, { 0, 0, 1 }, { 1, 1, 1, 1 } },


   [4] = { { 1, 1, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 1, 1, 1 } },
   [5] = { { 0, 1, 1 }, { 0, 0, 1 }, { 0, 0, 1 }, { 1, 1, 1, 1 } },


   [6] = { { 1, 1, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 1, 1, 1 } },
   [7] = { { 0, 1, 1 }, { 0, 0, 1 }, { 0, 0, 1 }, { 1, 1, 1, 1 } },

   [8] = { { 1, 1, 1 }, { 1, 0, 1 }, { 1, 0, 1 }, { 1, 1, 1, 1 } },
   [9] = { { 0, 1, 1 }, { 0, 0, 1 }, { 0, 0, 1 }, { 1, 1, 1, 1 } },
}

function fontGlyph.init()

   canvas_nn_glyph_output = love.graphics.newCanvas((width / 2) - canvasGlyphPosition.y, canvasGlyphHeight)

end

local function drawCanvas()

   love.graphics.setCanvas(canvas_nn_glyph_output)
   love.graphics.clear(1, 1, 1, 1)
   love.graphics.setBlendMode("alpha")
   love.graphics.setCanvas()
   love.graphics.draw(canvas_nn_glyph_output, canvasGlyphPosition.x, canvasGlyphPosition.y)
end

local function drawOutInGlyphFormat(glyph, x, y, glyph_size)
   for cell_y, row in pairs(glyph) do
      for cell_x, cell in ipairs(row) do
         if cell ~= 0 then
            love.graphics.rectangle("fill", x + (cell_x - 1) * glyph_size, y + (cell_y - 1) * glyph_size, glyph_size, glyph_size)
         end
      end
   end

end



local function countOutput(size_ofOutputs, currentOutpuOfOutputNeurons, lastOutpuOfOutputNeurons)
   local outputSize = 0.000000000000000
   assert(n >= outputSize)
   if n == 0 then
      return 1
   end
   local count = 0
   local diff = 0
   while n < 1 do
      diff = math.floor(currentOutpuOfOutputNeurons - lastOutpuOfOutputNeurons)
      currentOutpuOfOutputNeurons = diff
      count = count + diff
   end
   return count
end

local function drawCount()

end

function fontGlyph.draw()
   drawCanvas()

end



return fontGlyph
