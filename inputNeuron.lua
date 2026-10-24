local Neuron = require("neuron")

local InputNeuron = Neuron:new()

local value = 0

function InputNeuron:setVal(val)
   value = val
end

function InputNeuron:getVal()
   return value
end

return InputNeuron
