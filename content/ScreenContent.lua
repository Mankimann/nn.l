local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local string = _tl_compat and _tl_compat.string or string; local sti = require("thirdparty.Simple-Tiled-Implementation.sti")


local content = {}
content.__index = content


local currentChunk = 0
local map
local world

local worldMeter = 32


function content.init()
   love.physics.setMeter(worldMeter)
   local mapFormat = string.format("assets/world/chunks/chunk_00_01.lua")
   map = sti("assets/world/chunks/chunk_16_02.lua", { "box2d" })
   world = love.physics.newWorld(0, 0, true)
   map:box2d_init(world)
end


function content.update(dt)
   map:update(dt)
end


function content.draw(isVisible, worldx, worldy)
   if isVisible then
      map:draw(worldx, worldy)
   end

end

return content
