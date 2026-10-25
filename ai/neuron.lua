

local Vector2 = require("ai.vec")

local Val = 0
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


















local function setVal(v)
   return v
end

local function getVal()
   return Neuron.val
end

local function getValW()
   return getVal() * Neuron.weight
end

function Neuron:new()
   return setmetatable({ val = 0 }, { __index = self })
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
end

function Neuron:dispose()

end

return Neuron
