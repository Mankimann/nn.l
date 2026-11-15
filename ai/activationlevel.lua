local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs

local ActivationLevel = {}


function ActivationLevel.compute(neuron)
   local sum = neuron.bias
   for _, c in ipairs(neuron.connections) do
      sum = sum + c.neuron:getVal() * c.weight
   end
   return sum
end

return ActivationLevel
