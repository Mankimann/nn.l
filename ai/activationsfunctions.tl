local record Activationfunction
end

-- echte Sigmoid: 0 .. 1, numerisch stabil (math.exp(x) laeuft sonst bei grossem x auf inf -> nan)
function Activationfunction.Sigmoid(x: number): number
   if x >= 0 then
      return 1 / (1 + math.exp(-x))
   end
   local et: number = math.exp(x)
   return et / (1 + et)
end

-- -1 .. 1 (das war die alte "Sigmoid": (et / (1 + et))*2 - 1 == tanh(x/2))
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

return Activationfunction
