local Neuron = require("ai.neuron")

local record Connection
neuron: Neuron
weight: number
end

function Connection.new(neuron: Neuron, weight: number): Connection
   return setmetatable({ neuron = neuron, weight = weight }, { __index = Connection })
end

function Connection:getVal(): number
   return self.neuron:getVal() * self.weight
end

return Connection
