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

function Activationfunction.NFL()
   local t = love.timer.getTime()
   local u = t % 2 - 1
   local hot = math.sqrt(1 - u * u)
   if math.floor(t / 2) % 2 == 1 then
      hot = -hot
   end
   return hot
end

function Activationfunction.NFLOld()
   local hot = (1 - math.pow(math.exp(0.01), 2) - math.cos(2 * math.pi) * love.timer.getTime()) * 0.01
   if hot >= 1 then

      hot = hot - .01

   elseif hot == 0 then
      hot = hot + .01
   end
   return math.max(-1, math.min(1, hot))
end


return Activationfunction
