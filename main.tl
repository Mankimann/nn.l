local neuron = require("neuron")

function love.load(_args: {string}, _unfiltered: {string})

end

function love.draw()
   -- Neuron
   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.circle("fill", 100, 100, 25)

      -- current state
   love.graphics.setColor(1, 0, 0, 1)
   love.graphics.circle("fill", 100, 100, 22)
   
end

function love.update(dt: number)

end
