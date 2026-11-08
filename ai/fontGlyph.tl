
local fontGlyph = {}
fontGlyph.__index = fontGlyph

local canvas_nn_glyph_output: love.graphics.Canvas
local canvasGlyphHeight: number = 50
local canvasGlyphPosition = {x = 10, y = 20}
local width: number = love.graphics.getWidth()
local alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

local digits: {{{integer}}} = {
   [0] = {{1,1,1}, {1,0,1}, {1,0,1}, {1,0,1}, {1,1,1}},
   [1] = {{0,1,0}, {1,1,0}, {0,1,0}, {0,1,0}, {1,1,1}},
   [2] = {{1,1,1}, {0,0,1}, {1,1,1}, {1,0,0}, {1,1,1}},
   [3] = {{1,1,1}, {0,0,1}, {1,1,1}, {0,0,1}, {1,1,1}},
   [4] = {{1,0,1}, {1,0,1}, {1,1,1}, {0,0,1}, {0,0,1}},
   [5] = {{1,1,1}, {1,0,0}, {1,1,1}, {0,0,1}, {1,1,1}},
   [6] = {{1,1,1}, {1,0,0}, {1,1,1}, {1,0,1}, {1,1,1}},
   [7] = {{1,1,1}, {0,0,1}, {0,0,1}, {0,0,1}, {0,0,1}},
   [8] = {{1,1,1}, {1,0,1}, {1,1,1}, {1,0,1}, {1,1,1}},
   [9] = {{1,1,1}, {1,0,1}, {1,1,1}, {0,0,1}, {1,1,1}},
}

local comma: {{integer}} = {{0}, {0}, {0}, {0}, {1}, {1}}

function fontGlyph.init()

   canvas_nn_glyph_output = love.graphics.newCanvas((width / 2) - canvasGlyphPosition.y, canvasGlyphHeight)

end

local function render_glyph(glyph: {{integer}}, x: number, y: number, glyph_size: number)
   for cell_y,row in ipairs(glyph) do
      for cell_x,cell in ipairs(row) do
         if cell ~= 0 then
            love.graphics.rectangle("fill", x + (cell_x-1)*glyph_size, y + (cell_y-1)*glyph_size, glyph_size, glyph_size)
         end
      end
   end
end

local function count_digits(n: integer): integer
   assert(n >= 0)
   if n == 0 then
      return 1
   end
   local count = 0
   while n > 0 do
      count = count + 1
      n = math.floor(n/10)
   end
   return count
end

local function render_number(n: integer, x: number, y: number, glyph_size: number)
   assert(n >= 0)
   if n == 0 then
      render_glyph(digits[0], x, y, glyph_size)
      return
   end
   x = x + (count_digits(n)-1)*4*glyph_size
   while n > 0 do
      render_glyph(digits[n%10], x, y, glyph_size)
      n = math.floor(n/10)
      x = x - 4*glyph_size
   end
end

local enum FontGlyphs
   "p"
   "a"
   "u"
   "s"
   "e"
   "d"
end

local font: {FontGlyphs:{{integer}}} = {
   ["p"] = {{1,1,1}, {1,0,1}, {1,1,1}, {1,0,0}, {1,0,0}},
   ["a"] = {{1,1,1}, {1,0,1}, {1,1,1}, {1,0,1}, {1,0,1}},
   ["u"] = {{1,0,1}, {1,0,1}, {1,0,1}, {1,0,1}, {1,1,1}},
   ["s"] = digits[5],
   ["e"] = {{1,1,1}, {1,0,0}, {1,1,1}, {1,0,0}, {1,1,1}},
   ["d"] = {{1,1,0}, {1,0,1}, {1,0,1}, {1,0,1}, {1,1,0}},
}

local function number_width(n: integer, glyph_size: number): number
   local count = count_digits(n)
   return count*3*glyph_size + (count - 1)*glyph_size
end

local function text_width(text: {FontGlyphs}, glyph_size: number): number
   local count = #text
   return count*3*glyph_size + (count - 1)*glyph_size
end

local function render_text(text: {FontGlyphs}, x: number, y: number, glyph_size: number)
   for _,glyph in ipairs(text) do
      render_glyph(font[glyph], x, y, glyph_size)
      x = x + 4*glyph_size
   end
end

local function drawPaused()
   local glyph_size: number = 6
   local text: {FontGlyphs} = {"p", "a", "u", "s", "e", "d"}
   local x: number = canvas_nn_glyph_output:getWidth() - text_width(text, glyph_size) - glyph_size
   local y: number = (canvasGlyphHeight - 5*glyph_size) / 2
   love.graphics.setColor(0, 0, 0, 1)
   render_text(text, x, y, glyph_size)
   love.graphics.setColor(1, 1, 1, 1)
end

local function drawOutputs(outputs: {number})
   local glyph_size: number = 6
   local y: number = (canvasGlyphHeight - 5*glyph_size) / 2
   local x: number = glyph_size
   love.graphics.setColor(0, 0, 0, 1)
   for _,value in ipairs(outputs) do
      if value < 0 then
         love.graphics.rectangle("fill", x, y + 2*glyph_size, 3*glyph_size, glyph_size)
      end
      local scaled: integer = math.floor(math.abs(value)*1000 + 0.5)
      local frac: integer = scaled % 1000
      render_number(math.floor(scaled/1000), x + 4*glyph_size, y, glyph_size)
      render_glyph(comma, x + 8*glyph_size, y, glyph_size)
      render_glyph(digits[math.floor(frac/100)], x + 10*glyph_size, y, glyph_size)
      render_glyph(digits[math.floor(frac/10)%10], x + 14*glyph_size, y, glyph_size)
      render_glyph(digits[frac%10], x + 18*glyph_size, y, glyph_size)
      x = x + 26*glyph_size
   end
   love.graphics.setColor(1, 1, 1, 1)
end

local function drawCanvas(outputs: {number}, isPaused: boolean)
   love.graphics.setCanvas(canvas_nn_glyph_output)
   love.graphics.clear(1, 1, 1, 1)
   love.graphics.setBlendMode("alpha")
   drawOutputs(outputs)
   if isPaused then
      drawPaused()
   end
   love.graphics.setCanvas()
   love.graphics.draw(canvas_nn_glyph_output, canvasGlyphPosition.x, canvasGlyphPosition.y)
end

function fontGlyph.draw(outputs: {number}, isPaused: boolean)
   drawCanvas(outputs, isPaused)
end



return fontGlyph
