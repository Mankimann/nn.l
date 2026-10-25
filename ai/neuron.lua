local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math
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
   if self:getVal() > 0 then
      love.graphics.setColor(1, 1, 1, 1)
   else
      love.graphics.setColor(0, 0, 0, 1)
   end
   love.graphics.circle("fill", position.x, position.y, INNER_RADIUS_STATE * math.abs(self:getVal()))
end

function Neuron:dispose()

end

return Neuron
