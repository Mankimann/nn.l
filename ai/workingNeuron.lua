local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local Neuron = require("ai.neuron")
local Activationfunction = require("ai.activationsfunctions")
local WorkingNeuron = Neuron:new()


WorkingNeuron.activation = Activationfunction.Tanh



function WorkingNeuron:compute()
   local sum = self.bias
   for _, c in ipairs(self.connections) do
      sum = sum + c.neuron:getVal() * c.weight
   end
   self.val = self.activation(sum)
end

return WorkingNeuron
