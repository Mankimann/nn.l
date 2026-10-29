-- The Neuron class
local Vector2 = require("ai.vec")
local Connection = require("ai.connection")

local OUTER_RADIUS: number = 25
local INNER_RADIUS_STATE: number = 22

local InputNeuronInnerColor = {
   1,0,0,1
}

local WorkingNeuronInnerColor = {
   0,1,0,1
}

local OutputNeuronInnerColor = {
   0,0,1,1
}

local record Neuron is {Neuron}
enum Type
 "Input"
 "Working"
 "Output"
end

id: integer
layer: number
val: number
bias: number
name: string
position: Vector2
-- eingehende Verbindungen (nur Working/Output Neuronen haben welche)
connections: {Connection}
-- Input Neuronen: liefert pro update den neuen Wert (Maus, Zeit, Sensor, ...)
source: function(): number
-- Working/Output Neuronen
activation: function(x: number): number
end

function Neuron:new(): Neuron
   return setmetatable({ val = 0, bias = 0, connections = {} }, { __index = self })
end

function Neuron:setVal(val: number)
   self.val = val
end

function Neuron:getVal(): number
   return self.val
end

function Neuron:setId(id: integer)
   self.id = id
end

function Neuron:getId(): integer
   return self.id
end

-- berechnet self.val neu, Basis-Neuron macht nichts
function Neuron:compute()
end

function Neuron:addNeuronConnenction(neuron: Neuron, weight: number)
   table.insert(self.connections, Connection.new(neuron, weight))
end

function Neuron:removeNeuronConnection(neuron: Neuron)
   for i = #self.connections, 1, -1 do
      if self.connections[i].neuron == neuron then
         table.remove(self.connections, i)
      end
   end
end

function Neuron:clearConnections()
   self.connections = {}
end

function Neuron:draw(position: Vector2, t: Neuron.Type)
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
   -- Inputs koennen > 1 sein, Kreis darf nicht groesser als der Rand werden
   love.graphics.circle("fill", position.x, position.y, INNER_RADIUS_STATE * math.min(1, math.abs(self:getVal())))
end

function Neuron:dispose()
   self.connections = {}
   self.source = nil
end

return Neuron
