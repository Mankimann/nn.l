local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math; local Activationfunction = {}



function Activationfunction.Sigmoid(x)
   if x >= 0 then
      return 1 / (1 + math.exp(-x))
   end
   local et = math.exp(x)
   return et / (1 + et)
end


function Activationfunction.Tanh(x)
   return 2 * Activationfunction.Sigmoid(2 * x) - 1
end

function Activationfunction.ReLu(x)
   return math.max(0, x)
end

function Activationfunction.LeakyReLu(x, slope)
   slope = slope or 0.01
   return math.max(0, x) + slope * math.min(0, x)
end

return Activationfunction
