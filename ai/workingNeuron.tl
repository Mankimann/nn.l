local Neuron = require("ai.neuron")
local Activationfunction = require("ai.activationsfunctions")
local WorkingNeuron = Neuron:new()

-- Standard: -1 .. 1, passt zum Zeichnen (weiss = positiv, schwarz = negativ)
WorkingNeuron.activation = Activationfunction.Tanh

-- Summe der gewichteten Eingaenge + bias durch die Aktivierungsfunktion.
-- Wird einmal pro update aufgerufen, getVal liefert danach nur noch den gespeicherten Wert.
function WorkingNeuron:compute()
   local sum: number = self.bias
   for _, c in ipairs(self.connections) do
      sum = sum + c.neuron:getVal() * c.weight
   end
   self.val = self.activation(sum)
end

return WorkingNeuron
