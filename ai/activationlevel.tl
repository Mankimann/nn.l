local type Neuron = require("ai.neuron")

local record ActivationLevel
end

function ActivationLevel.compute(neuron: Neuron): number
   local sum: number = neuron.bias
   for _, c in ipairs(neuron.connections) do
      sum = sum + c.neuron:getVal() * c.weight
   end
   return sum
end

return ActivationLevel
