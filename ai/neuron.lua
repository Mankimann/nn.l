local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math; local table = _tl_compat and _tl_compat.table or table
local Vector2 = require("ai.vec")
local Connection = require("ai.connection")

local OUTER_RADIUS = 25
local INNER_RADIUS_STATE = 22

local InputNeuronInnerColor = {
   1, 0, 0, 1,
}

local WorkingNeuronInnerColor = {
   0, 1, 0, 1,
}

local OutputNeuronInnerColor = {
   0, 0, 1, 1,
}

local Neuron = {}




















function Neuron:new()
   return setmetatable({ val = 0, bias = 0, connections = {} }, { __index = self })
end

function Neuron:setVal(val)
   self.val = val
end

function Neuron:getVal()
   return self.val
end

function Neuron:setId(id)
   self.id = id
end

function Neuron:getId()
   return self.id
end


function Neuron:compute()
end

function Neuron:addNeuronConnenction(neuron, weight)
   table.insert(self.connections, Connection.new(neuron, weight))
end

function Neuron:removeNeuronConnection(neuron)
   for i = #self.connections, 1, -1 do
      if self.connections[i].neuron == neuron then
         table.remove(self.connections, i)
      end
   end
end

function Neuron:clearConnections()
   self.connections = {}
end

function Neuron:draw(position, t)
   if t == "Input" then
      love.graphics.setColor(InputNeuronInnerColor)
   elseif t == "Working" then
      love.graphics.setColor(WorkingNeuronInnerColor)
   else
      love.graphics.setColor(OutputNeuronInnerColor)
   end
   love.graphics.circle("fill", position.x, position.y, OUTER_RADIUS)
   if self:getVal() > 0 then
      love.graphics.setColor(1, 1, 1, 1)
   else
      love.graphics.setColor(0, 0, 0, 1)
   end

   love.graphics.circle("fill", position.x, position.y, INNER_RADIUS_STATE * math.min(1, math.abs(self:getVal())))
end

function Neuron:dispose()
   self.connections = {}
   self.source = nil
end

return Neuron
