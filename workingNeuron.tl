local Neuron = require("neuron")
local Connection = require("connection")
local WorkingNeuron = Neuron:new()
local connection: {Connection} = {}

function WorkingNeuron:getVal(): number
   local sum: number = 0
   for _, c in ipairs(connection) do
      sum = sum + c:getVal()
   end
   return sum
end


function WorkingNeuron:addNeuronConnenction(neuron: Neuron, weight: number)
   table.insert(connection, Connection.new(neuron, weight))
end

local function addConnection(con: Connection)
   table.insert(connection, con)
end

return WorkingNeuron
