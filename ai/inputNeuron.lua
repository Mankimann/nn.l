local Neuron = require("ai.neuron")

local InputNeuron = Neuron:new()


function InputNeuron:compute()
   if self.source then
      local v = self.source()

      if v == nil or v ~= v then
         v = 0
      end
      self.val = v
   end
end

return InputNeuron
