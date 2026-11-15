local Neuron = require("ai.neuron")
local Activationfunction = require("ai.activationsfunctions")
local ActivationLevel = require("ai.activationlevel")
local WorkingNeuron = Neuron:new()

-- Standard: -1 .. 1, passt zum Zeichnen (weiss = positiv, schwarz = negativ)
WorkingNeuron.activation = Activationfunction.Tanh

-- Summe der gewichteten Eingaenge + bias durch die Aktivierungsfunktion.
-- Wird einmal pro update aufgerufen, getVal liefert danach nur noch den gespeicherten Wert.
function WorkingNeuron:compute()
   self.val = self.activation(ActivationLevel.compute(self))
end

return WorkingNeuron
