local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local table = _tl_compat and _tl_compat.table or table; local Neuron = require("ai.neuron")
local InputNeuron = require("ai.inputNeuron")
local WorkingNeuron = require("ai.workingNeuron")

local InputNeurons = {}


local WorkingNeurons = {}


local OutputNeurons = {}

local layers = { InputNeurons, WorkingNeurons, OutputNeurons }
local types = { "Input", "Working", "Output" }
local weights = {}


local function create(input, working, output)
   for _ = 1, input do
      table.insert(InputNeurons, InputNeuron:new())
   end
   for _ = 1, working do
      table.insert(WorkingNeurons, WorkingNeuron:new())
   end
   for _ = 1, output do
      table.insert(OutputNeurons, WorkingNeuron:new())
   end
end

local function createFullMesh()
   for i = 1, #InputNeurons do
      InputNeurons[i]:setVal(3)
   end

   for l = 1, #layers - 1 do
      weights[l] = {}
      for i, a in ipairs(layers[l]) do
         weights[l][i] = {}
         for j, b in ipairs(layers[l + 1]) do
            local weight = love.math.random() * 2 - 1
            weights[l][i][j] = weight
            b:addNeuronConnenction(a, weight)
         end
      end
   end
end

local function update(t)
   for i = 1, #InputNeurons do
      InputNeurons[i]:setVal(math.sin(t + i))
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

   for l = 1, #layers - 1 do
      for i, a in ipairs(layers[l]) do
         for j, b in ipairs(layers[l + 1]) do
            local weight = weights[l][i][j]
            local signal = 0.1 + math.abs(a:getVal() * weight)
            if weight > 0 then
               love.graphics.setColor(0.3, 0.6, 1, signal)
            else
               love.graphics.setColor(1, 0.3, 0.3, signal)
            end
            love.graphics.setLineWidth(1 + math.abs(weight) * 3)
            love.graphics.line(a.position.x, a.position.y, b.position.x, b.position.y)
         end
      end
   end
   love.graphics.setLineWidth(1)

   for l, layer in ipairs(layers) do
      for _, n in ipairs(layer) do
         n:draw(n.position, types[l])
      end
   end
end

return { create = create, draw = draw, createFullMesh = createFullMesh, update = update, InputNeurons = InputNeurons, WorkingNeurons = WorkingNeurons, OutputNeurons = OutputNeurons }
