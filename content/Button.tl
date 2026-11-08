local isFilled: boolean = true
local record Button
   x: number
   y: number
   w: number
   h: number
   text: string
   fn: function()
   font : love.graphics.Font
   wasDown: boolean
end

local mt: metatable<Button> = { __index = Button }

function Button:new(x: number, y: number, w: number, h: number, text: string, fn: function(), font?: love.graphics.Font) : Button 
			  local self: Button = {
			     x = x,
			     y = y,
			     w = w,
			     h = h,
			     text = text,
			     fn = fn,
			     font = font or love.graphics.getFont(),
			     wasDown = love.mouse.isDown(1)
			  }
			  return setmetatable(self, mt)
end



function Button:isHot(): boolean
   local mx, my = love.mouse.getPosition()
   return mx > self.x and mx < self.x + self.w
      and my > self.y and my < self.y + self.h
end


function Button:draw(filled?: boolean, color?: {number} )

   isFilled = filled
   if self:isHot() then
      love.graphics.setColor(0.45, 0.57, 0.33, 1.0)
      elseif color ~= nil then
	 
   else
      love.graphics.setColor(0.4, 0.4, 0.5, 1.0)
   end
   love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

   love.graphics.setColor(0, 0, 0, 1)
   local textX = self.x + (self.w - self.font:getWidth(self.text)) * 0.5
   local textY = self.y + (self.h - self.font:getHeight()) * 0.5
   love.graphics.print(self.text, self.font, textX, textY)
   love.graphics.setColor(1, 1, 1, 1)
end


function Button:update()
   local isDown = love.mouse.isDown(1)
   if isDown and not self.wasDown and self:isHot() then
      self.fn()
   end
   self.wasDown = isDown
end



return Button
