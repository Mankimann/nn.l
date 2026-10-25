-- Teal declarations for anim8 v2.3.1 (thirdparty/anim8.lua)

local record anim8
   record Grid
      frameWidth: number
      frameHeight: number
      imageWidth: number
      imageHeight: number
      left: number
      top: number
      border: number

      -- g('1-4', 1) or g(1, 1, 2, 1, ...): columns/rows as numbers or 'a-b' ranges
      getFrames: function(self, ...: integer | string): {love.graphics.Quad}
      metamethod __call: function(self, ...: integer | string): {love.graphics.Quad}
   end

   -- onLoop: a function, or the name of an Animation method ("pauseAtEnd")
   type OnLoop = function(Animation, integer) | string

   record Animation
      frames: {love.graphics.Quad}
      durations: {number}
      intervals: {number}
      totalDuration: number
      timer: number
      position: integer
      status: string          -- "playing" | "paused"
      flippedH: boolean
      flippedV: boolean
      onLoop: OnLoop

      update: function(self, dt: number)
      draw: function(self, image: love.graphics.Texture, x: number, y: number, r?: number, sx?: number, sy?: number, ox?: number, oy?: number, kx?: number, ky?: number)
      getFrameInfo: function(self, x: number, y: number, r?: number, sx?: number, sy?: number, ox?: number, oy?: number, kx?: number, ky?: number): love.graphics.Quad, number, number, number, number, number, number, number, number, number
      getDimensions: function(self): number, number
      clone: function(self): Animation
      flipH: function(self): Animation
      flipV: function(self): Animation
      gotoFrame: function(self, position: integer)
      pause: function(self)
      resume: function(self)
      pauseAtEnd: function(self)
      pauseAtStart: function(self)
   end

   _VERSION: string

   newGrid: function(frameWidth: number, frameHeight: number, imageWidth: number, imageHeight: number, left?: number, top?: number, border?: number): Grid
   -- durations: seconds per frame, or a table like { 0.1, ['3-5'] = 0.2 }
   newAnimation: function(frames: {love.graphics.Quad}, durations: number | {any: number}, onLoop?: OnLoop): Animation
end

return anim8
