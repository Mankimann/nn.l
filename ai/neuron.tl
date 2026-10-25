-- The Neuron class

local Vector2 = require("ai.vec")

local Val: number = 0
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
weight: number
name: string
position: Vector2
setVal: function(self: Neuron, val: number)
getVal: function(self: Neuron): number
addNeuronConnenction: function(self: Neuron, neuron: Neuron, weight: number)
end


local function setVal(v: number): number
   return v
end

local function getVal(): number
   return Neuron.val
end

local function getValW(): number
   return getVal() * Neuron.weight
end

function Neuron:new(): Neuron
   return setmetatable({ val = 0 }, { __index = self })
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
end

function Neuron:dispose()

end

return Neuron
