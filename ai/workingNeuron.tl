local Neuron = require("ai.neuron")
local Connection = require("ai.connection")
local WorkingNeuron = Neuron:new()
local connections: {Neuron:{Connection}} = {}

function WorkingNeuron:getVal(): number
   local sum: number = 0
   for _, c in ipairs(connections[self] or {}) do
      sum = sum + c:getVal()
   end
   return sum
end

function WorkingNeuron:addNeuronConnenction(neuron: Neuron, weight: number)
   connections[self] = connections[self] or {}
   table.insert(connections[self], Connection.new(neuron, weight))
end

return WorkingNeuron
