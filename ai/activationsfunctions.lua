local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math; local Activationfunction = {}



function Activationfunction:Sigmoid(x)
   local et = math.exp(x)
   return (et / (1 + et) * 2) - 1
end

function Activationfunction:ReLu(x)
   return math.max(0, x)
end

function Activationfunction:LeakyReLu(x, slope)
   local e = math.max(0, x) + slope * math.min(0, x)
   return e
end

return Activationfunction
