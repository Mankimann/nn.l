

local record Activationfunction
activation: function(val: number)
end

function Activationfunction:Sigmoid(x: number): number
   local et: number = math.exp(x)
   return (et / (1 + et)*2) - 1 
end


function Activationfunction:ReLu(x: number): number
   return math.max(0, x)
end

function Activationfunction:LeakyReLu(x: number, slope: number): number
   local e: number = math.max(0, x) + slope * math.min(0, x)
   return e
end


return Activationfunction
