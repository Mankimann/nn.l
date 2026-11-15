local Neuron = require("ai.neuron")
local Activationfunction = require("ai.activationsfunctions")
local ActivationLevel = require("ai.activationlevel")
local WorkingNeuron = Neuron:new()


WorkingNeuron.activation = Activationfunction.Tanh



function WorkingNeuron:compute()
   self.val = self.activation(ActivationLevel.compute(self))
end

return WorkingNeuron
