
local fontGlyph = {}
fontGlyph.__index = fontGlyph

local canvas_nn_glyph_output: love.graphics.Canvas
local canvasGlyphHeight: number = 50
local canvasGlyphPosition = {x = 10, y = 20}
local width: number = love.graphics.getWidth()
local alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

local numbers  = {

   [0] = {{1, 1, 1}, {1, 0, 1}, {1, 0, 1}, {1, 1, 1, 1}},
   [1] = {{0, 1, 1}, {0, 0, 1}, {0, 0, 1}, {1, 1, 1, 1}},
   
   [2] = {{1, 1, 1}, {1, 0, 1}, {1, 0, 1}, {1, 1, 1, 1}},
   [3] = {{0, 1, 1}, {0, 0, 1}, {0, 0, 1}, {1, 1, 1, 1}},

   
   [4] = {{1, 1, 1}, {1, 0, 1}, {1, 0, 1}, {1, 1, 1, 1}},
   [5] = {{0, 1, 1}, {0, 0, 1}, {0, 0, 1}, {1, 1, 1, 1}},

   
   [6] = {{1, 1, 1}, {1, 0, 1}, {1, 0, 1}, {1, 1, 1, 1}},
   [7] = {{0, 1, 1}, {0, 0, 1}, {0, 0, 1}, {1, 1, 1, 1}},
   
   [8] = {{1, 1, 1}, {1, 0, 1}, {1, 0, 1}, {1, 1, 1, 1}},
   [9] = {{0, 1, 1}, {0, 0, 1}, {0, 0, 1}, {1, 1, 1, 1}},
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

local function drawOutInGlyphFormat(glyph: {{integer}}, x: number, y: number, glyph_size: number)
   for cell_y, row in pairs(glyph) do
      for cell_x, cell in ipairs(row) do
	 if cell ~= 0 then
	    love.graphics.rectangle("fill", x + (cell_x- 1)*glyph_size, y + (cell_y- 1)*glyph_size, glyph_size, glyph_size)
	 end
      end
   end
   
end
-- @Param = size_ofOutputs = means tbf 2 output neurons
-- @Param = last output and current output to calculate the difference the output and adds to the count 

local function countOutput(size_ofOutputs: integer, currentOutpuOfOutputNeurons: number, lastOutpuOfOutputNeurons: number) : number
   local outputSize: number = 0.000000000000000
   assert(n >= outputSize )
   if n == 0  then
      return 1
   end
   local count: number = 0
   local diff:  number = 0
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
  -- drawOutInGlyphFormat()   
end



return fontGlyph
