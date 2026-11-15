local Events = require("content.Events")
local CreatureSkills = require("content.creature.CreatureSkills")


local Creature = {}


















local mt = { __index = Creature }

function Creature.new(x, y, name)
   local self = {
      x = x,
      y = y,
      radius = 16,
      name = name,
      age = 0,
      hearts = 3,
      genericDiv = { 0, 0, 0, 0 },
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

function Creature:isHot(ox, oy)
   local mx, my = love.mouse.getPosition()
   local dx = mx - (ox + self.x)
   local dy = my - (oy + self.y)
   return dx * dx + dy * dy <= self.radius * self.radius
end


function Creature:checkClick(ox, oy)
   local isDown = love.mouse.isDown(1)
   if isDown and not self.wasDown and self:isHot(ox, oy) then
      Events.emit("creatureClicked", self)
   end
   self.wasDown = isDown
end

function Creature:update(dt)
   self.age = self.age + dt
end


function Creature:draw(ox, oy)
   love.graphics.setColor(0.9, 0.6, 0.2, 1)
   love.graphics.circle("fill", ox + self.x, oy + self.y, self.radius)
   love.graphics.setColor(1, 1, 1, 1)
end

return Creature
