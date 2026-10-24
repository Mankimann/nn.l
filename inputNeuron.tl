local Neuron = require("neuron")

local InputNeuron = Neuron:new()

local value: number = 0

 function InputNeuron:setVal(val: number)
   value = val
end

function InputNeuron:getVal() : number
   return value
end

return InputNeuron
