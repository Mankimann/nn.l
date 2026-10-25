local Neuron = require("ai.neuron")

-- List Of Input Neurons
local InputNeurons: {Neuron} = {}

-- List Of Working Neurons
local WorkingNeurons: {Neuron} = {}

-- List Of Output Neurons
local OutputNeurons: {Neuron} = {}

local layers: {{Neuron}} = {InputNeurons, WorkingNeurons, OutputNeurons}
local types: {Neuron.Type} = {"Input", "Working", "Output"}


local function create(input: integer, working: integer, output: integer)
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

local function draw(w: number, h: number)
    local dx = w / (#layers + 1)
   for l, layer in ipairs(layers) do
      local dy = h / (#layer + 1)
      for i, n in ipairs(layer) do
         n.position = { x = dx * l, y = dy * i }
      end
   end
   -- the white circle
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

return {create = create, draw = draw}




