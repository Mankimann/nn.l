local sti = require ("thirdparty.Simple-Tiled-Implementation.sti")

--class definition
local content = {}
content.__index = content

--local variablen
local currentChunk: integer = 0
local map: sti.Map
local world: love.physics.World
-- World Meter in pixel
local worldMeter: integer = 32


function content.init()
   love.physics.setMeter(worldMeter)
   local mapFormat = string.format("assets/world/chunks/chunk_00_01.lua") 
   map = sti("assets/world/chunks/chunk_16_02.lua", {"box2d"})
   world = love.physics.newWorld(0, 0, true)
   map:box2d_init(world)
end


function content.update(dt: number)
   map:update(dt)
end


function content.draw(isVisible: boolean, worldx: number, worldy: number)
   if isVisible then
      map:draw(worldx, worldy)
   end
   
end

return content
