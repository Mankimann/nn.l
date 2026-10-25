local Neuron = require("ai.neuron")

local InputNeuron = Neuron:new()

function InputNeuron:setVal(val: number)
   self.val = val
end

function InputNeuron:getVal() : number
   return self.val
end

return InputNeuron
