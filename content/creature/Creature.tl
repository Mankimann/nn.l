local Events = require("content.Events")
local CreatureSkills = require("content.creature.CreatureSkills")

-- The stats of the creature
local record Creature
-- TODO: with the nn function (the brain of nn) the creature becomes hes own neuronal network with NN.create(randominput, randomworking, randomoutput)
   nn: function()
   x: number
   y: number
   radius: number
   name: string
   age: number
   hearts: number
   genericDiv: {number, number, number, number}
   mutationRate: number
   feelerMaxLength: number
   feelerOcclusion: number
   learnRate: number
   isAlive: boolean
   skills: CreatureSkills
   wasDown: boolean
end

local mt: metatable<Creature> = { __index = Creature }

function Creature.new(x: number, y: number, name: string): Creature
   local self: Creature = {
      x = x,
      y = y,
      radius = 16,
      name = name,
      age = 0,
      hearts = 3,
      genericDiv = {0, 0, 0, 0},
      mutationRate = 0.01,
      feelerMaxLength = 64,
      feelerOcclusion = 0,
      learnRate = 0.1,
      isAlive = true,
      skills = CreatureSkills.new(),
      wasDown = love.mouse.isDown(1),
   }
   return setmetatable(self, mt)
end

function Creature:isHot(ox: number, oy: number): boolean
   local mx, my = love.mouse.getPosition()
   local dx = mx - (ox + self.x)
   local dy = my - (oy + self.y)
   return dx * dx + dy * dy <= self.radius * self.radius
end

-- if you have clicked on a creature -> event -> button clicked event -> opens the creature nn
function Creature:checkClick(ox: number, oy: number)
   local isDown = love.mouse.isDown(1)
   if isDown and not self.wasDown and self:isHot(ox, oy) then
      Events.emit("creatureClicked", self)
   end
   self.wasDown = isDown
end

function Creature:update(dt: number)
   self.age = self.age + dt
end

-- Todo: load a final image for all creatures
function Creature:draw(ox: number, oy: number)
   love.graphics.setColor(0.9, 0.6, 0.2, 1)
   love.graphics.circle("fill", ox + self.x, oy + self.y, self.radius)
   love.graphics.setColor(1, 1, 1, 1)
end

return Creature
