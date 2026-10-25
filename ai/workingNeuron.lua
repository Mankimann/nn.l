local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local table = _tl_compat and _tl_compat.table or table; local Neuron = require("ai.neuron")
local Connection = require("ai.connection")
local Activationfunction = require("ai.activationsfunctions")
local WorkingNeuron = Neuron:new()
local connections = {}

function WorkingNeuron:getVal()
   local sum = 0
   for _, c in ipairs(connections[self] or {}) do
      sum = sum + c:getVal()
   end
   return Activationfunction:Sigmoid(sum)
end

function WorkingNeuron:addNeuronConnenction(neuron, weight)
   connections[self] = connections[self] or {}
   table.insert(connections[self], Connection.new(neuron, weight))
end

return WorkingNeuron
