local Vector2 = {}




function Vector2.add(v)
   local self = setmetatable({}, { __index = Vector2 })
   self.x = self.x + v.x or 0
   self.y = self.y + v.y or 0
   return { x = self.x, y = self.y }
end


function Vector2.minus(v)
   local self = setmetatable({}, { __index = Vector2 })
   self.x = self.x - v.x or 0
   self.y = self.y - v.y or 0
   return { x = self.x, y = self.y }
end


function Vector2.mull(v)
   local self = setmetatable({}, { __index = Vector2 })
   self.x = self.x * v.x or 0
   self.y = self.y * v.y or 0
   return { x = self.x, y = self.y }
end


function Vector2.div(v)
   local self = setmetatable({}, { __index = Vector2 })
   self.x = self.x / v.x or 0
   self.y = self.y / v.y or 0
   return { x = self.x, y = self.y }
end
