local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table; local Neuron = require("ai.neuron")
local InputNeuron = require("ai.inputNeuron")
local WorkingNeuron = require("ai.workingNeuron")

local InputNeurons = {}


local WorkingNeurons = {}


local OutputNeurons = {}

local layers = { InputNeurons, WorkingNeurons, OutputNeurons }
local types = { "Input", "Working", "Output" }
local meshed = false

local function randomWeight()
   return love.math.random() * 2 - 1
end

local function clear(list)
   for i = #list, 1, -1 do
      list[i]:dispose()
      list[i] = nil
   end
end

local function addInput(name, source)
   local n = InputNeuron:new()
   n.name = name or ("in " .. (#InputNeurons + 1))
   n.source = source
   table.insert(InputNeurons, n)
   n:setId(#InputNeurons)
   if meshed then
      for _, w in ipairs(WorkingNeurons) do
         w:addNeuronConnenction(n, randomWeight())
      end
   end
   return #InputNeurons
end

local function removeInput(i)
   local n = InputNeurons[i]
   if not n then
      return
   end
   for _, w in ipairs(WorkingNeurons) do
      w:removeNeuronConnection(n)
   end
   n:dispose()
   table.remove(InputNeurons, i)
   for k, rest in ipairs(InputNeurons) do
      rest:setId(k)
   end
end

local function create(input, working, output)
   clear(InputNeurons)
   clear(WorkingNeurons)
   clear(OutputNeurons)
   meshed = false
   for _ = 1, input do
      addInput()
   end
   for w = 1, working do
      local n = WorkingNeuron:new()
      n:setId(w)
      table.insert(WorkingNeurons, n)
   end
   for o = 1, output do
      local n = WorkingNeuron:new()
      n:setId(o)
      n.name = "out " .. o
      table.insert(OutputNeurons, n)
   end
end

local function createFullMesh()
   for l = 2, #layers do
      for _, b in ipairs(layers[l]) do
         b:clearConnections()
         b.bias = randomWeight()
         for _, a in ipairs(layers[l - 1]) do
            b:addNeuronConnenction(a, randomWeight())
         end
      end
   end
   meshed = true
end

local function setInput(i, val)
   InputNeurons[i]:setVal(val)
end

local function setInputs(values)
   for i, v in ipairs(values) do
      if InputNeurons[i] then
         InputNeurons[i]:setVal(v)
      end
   end
end

local function setInputSource(i, source)
   InputNeurons[i].source = source
end

local function update()
   for _, layer in ipairs(layers) do
      for _, n in ipairs(layer) do
         n:compute()
      end
   end
end

local function getOutputs()
   local out = {}
   for i, n in ipairs(OutputNeurons) do
      out[i] = n:getVal()
   end
   return out
end

local function draw(w, h)
   local dx = w / (#layers + 1)
   for l, layer in ipairs(layers) do
      local dy = h / (#layer + 1)
      for i, n in ipairs(layer) do
         n.position = { x = dx * l, y = dy * i }
      end
   end

   for l = 2, #layers do
      for _, b in ipairs(layers[l]) do
         for _, c in ipairs(b.connections) do
            local a = c.neuron
            local weight = c.weight
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
         love.graphics.setColor(1, 1, 1, 1)
         local label = string.format("%.2f", n:getVal())
         if n.name then
            label = n.name .. "\n" .. label
         end
         love.graphics.print(label, n.position.x + 30, n.position.y - 12)
      end
   end
end

return {
   create = create,
   createFullMesh = createFullMesh,
   addInput = addInput,
   removeInput = removeInput,
   setInput = setInput,
   setInputs = setInputs,
   setInputSource = setInputSource,
   update = update,
   getOutputs = getOutputs,
   draw = draw,
   InputNeurons = InputNeurons,
   WorkingNeurons = WorkingNeurons,
   OutputNeurons = OutputNeurons,
}
