local neuron = require("neuron")

function love.load(_args, _unfiltered)

end

function love.draw()

   love.graphics.setColor(1, 1, 1, 1)
   love.graphics.circle("fill", 100, 100, 25)


   love.graphics.setColor(1, 0, 0, 1)
   love.graphics.circle("fill", 100, 100, 22)

end

function love.update(dt)

end
