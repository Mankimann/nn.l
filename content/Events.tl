local Signal = require("thirdparty.hump.signal")

local record Events
   enum Name
      "startApp"
      "creatureClicked"
   end
end

function Events.on(name: Events.Name, fn: function(...: any))
   Signal.register(name, fn)
end

function Events.emit(name: Events.Name, ...: any)
   Signal.emit(name, ...)
end

return Events
