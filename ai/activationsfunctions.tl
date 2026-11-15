local record Activationfunction
end

function Activationfunction.Sigmoid(x: number): number
   if x >= 0 then
      return 1 / (1 + math.exp(-x))
   end
   local et: number = math.exp(x)
   return et / (1 + et)
end

function Activationfunction.Tanh(x: number): number
   return 2 * Activationfunction.Sigmoid(2 * x) - 1
end

function Activationfunction.ReLu(x: number): number
   return math.max(0, x)
end

function Activationfunction.LeakyReLu(x: number, slope: number): number
   slope = slope or 0.01
   return math.max(0, x) + slope * math.min(0, x)
end

function Activationfunction.NFL(): number
   local t: number = love.timer.getTime()
   local u: number = t % 2 - 1
   local hot: number = math.sqrt(1 - u * u)
   if math.floor(t / 2) % 2 == 1 then
      hot = -hot
   end
   return hot
end

function Activationfunction.NFLOld(): number
   local hot: number = (1-math.pow(math.exp(0.01), 2)-math.cos(2 * math.pi)*love.timer.getTime())*0.01
   if hot >= 1 then
      -- hot - .01
      hot = hot - .01
      --hot = 0
   elseif hot == 0 then 
      hot = hot + .01 
   end
   return math.max(-1, math.min(1, hot))
end


return Activationfunction
