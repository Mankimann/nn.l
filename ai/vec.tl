local record Vector2
x: number
y: number
end

function Vector2.add(v: Vector2, v2: Vector2 ) : Vector2
   return {x = v.x + v2.x, y = v.y + v2.y}
end


function Vector2.minus(v: Vector2, v2:  Vector2) : Vector2
   return {x = v.x - v2.x, y = v.y - v2.y}
end


function Vector2.mull(v: Vector2, v2: Vector2) : Vector2
   return {x = v.x * v2.x, y = v.y * v2.y}
end


function Vector2.div(v: Vector2, v2: Vector2) : Vector2
  
   return {x = v.x / v2.x, y = v.y / v2.y}
end

return Vector2

