local vec2 = require("tools/vec2")
local colors = require("tools/colors")

local TimeIndicator = {}

function TimeIndicator:new(w, h, callback)
  self.paused = false
  local timeIndicator = {
    w = w,
    size = vec2:new(w, h),
    callback = callback or function() end,
  }

  function timeIndicator:update(dt)
    if (not self.paused) then
      local w = self.size.x - (self.w * (0.1 * dt)) -- roughly 10 seconds
      self.size = vec2:new(w, self.size.y)
      if w <= 0 then
        self.paused = true
        callback()
      end
    end
  end

  function timeIndicator:draw()
    love.graphics.setColor(colors.pink())
    love.graphics.rectangle("fill", 0, 0, self.size.x, self.size.y)
  end

  return timeIndicator
end

return TimeIndicator
