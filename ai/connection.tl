-- nur Typ-Import, sonst gibt es einen require-Zyklus mit ai.neuron
-- (deshalb kein getVal hier, das rechnet WorkingNeuron:compute)
local type Neuron = require("ai.neuron")

local record Connection
neuron: Neuron
weight: number
end

function Connection.new(neuron: Neuron, weight: number): Connection
   return setmetatable({ neuron = neuron, weight = weight }, { __index = Connection })
end

return Connection
