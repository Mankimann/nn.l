local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local table = _tl_compat and _tl_compat.table or table; local Neuron = require("neuron")
local Connection = require("connection")
local WorkingNeuron = Neuron:new()
local connection = {}

function WorkingNeuron:getVal()
   local sum = 0
   for _, c in ipairs(connection) do
      sum = sum + c:getVal()
   end
   return sum
end


function WorkingNeuron:addNeuronConnenction(neuron, weight)
   table.insert(connection, Connection.new(neuron, weight))
end

local function addConnection(con)
   table.insert(connection, con)
end

return WorkingNeuron
