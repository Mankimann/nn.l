local Neuron = require("ai.neuron")

local InputNeuron = Neuron:new()

function InputNeuron:setVal(val)
   self.val = val
end

function InputNeuron:getVal()
   return self.val
end

return InputNeuron
