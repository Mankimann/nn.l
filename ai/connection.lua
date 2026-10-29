



local Connection = {}




function Connection.new(neuron, weight)
   return setmetatable({ neuron = neuron, weight = weight }, { __index = Connection })
end

return Connection
