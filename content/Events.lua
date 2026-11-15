local Signal = require("thirdparty.hump.signal")

local Events = {}






function Events.on(name, fn)
   Signal.register(name, fn)
end

function Events.emit(name, ...)
   Signal.emit(name, ...)
end

return Events
