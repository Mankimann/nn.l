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

function Vector2.nor(v: Vector2 ) : Vector2
   return {x = v.x / 255, y =  v.y / 255}
end

function Vector2.sq(v: Vector2) : number
   return(v.x * v.x) + (v.y * v.y)
end


return Vector2

