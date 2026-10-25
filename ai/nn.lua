local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local table = _tl_compat and _tl_compat.table or table; local Neuron = require("ai.neuron")


local InputNeurons = {}


local WorkingNeurons = {}


local OutputNeurons = {}

local layers = { InputNeurons, WorkingNeurons, OutputNeurons }
local types = { "Input", "Working", "Output" }


local function create(input, working, output)
   for _ = 1, input do
      table.insert(InputNeurons, Neuron:new())
   end
   for _ = 1, working do
      table.insert(WorkingNeurons, Neuron:new())
   end
   for _ = 1, output do
      table.insert(OutputNeurons, Neuron:new())
   end
end

local function draw(w, h)
   local dx = w / (#layers + 1)
   for l, layer in ipairs(layers) do
      local dy = h / (#layer + 1)
      for i, n in ipairs(layer) do
         n.position = { x = dx * l, y = dy * i }
      end
   end

   love.graphics.setColor(1, 1, 1, 1)
   for l = 1, #layers - 1 do
      for _, a in ipairs(layers[l]) do
         for _, b in ipairs(layers[l + 1]) do
            love.graphics.line(a.position.x, a.position.y, b.position.x, b.position.y)
         end
      end
   end

   for l, layer in ipairs(layers) do
      for _, n in ipairs(layer) do
         n:draw(n.position, types[l])
      end
   end
end

return { create = create, draw = draw }
