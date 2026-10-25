local Neuron = require("ai.neuron")

local Connection = {}




function Connection.new(neuron, weight)
   return setmetatable({ neuron = neuron, weight = weight }, { __index = Connection })
end

function Connection:getVal()
   return self.neuron:getVal() * self.weight
end

return Connection
