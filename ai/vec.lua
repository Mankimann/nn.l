local Vector2 = {}




function Vector2.add(v, v2)
   return { x = v.x + v2.x, y = v.y + v2.y }
end


function Vector2.minus(v, v2)
   return { x = v.x - v2.x, y = v.y - v2.y }
end


function Vector2.mull(v, v2)
   return { x = v.x * v2.x, y = v.y * v2.y }
end


function Vector2.div(v, v2)

   return { x = v.x / v2.x, y = v.y / v2.y }
end

return Vector2
