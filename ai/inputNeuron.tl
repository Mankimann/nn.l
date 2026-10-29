local Neuron = require("ai.neuron")

local InputNeuron = Neuron:new()

-- holt den Wert aus der Quelle, ohne Quelle bleibt der per setVal gesetzte Wert
function InputNeuron:compute()
   if self.source then
      local v = self.source()
      -- nan oder nil wuerde das ganze Netz vergiften
      if v == nil or v ~= v then
         v = 0
      end
      self.val = v
   end
end

return InputNeuron
