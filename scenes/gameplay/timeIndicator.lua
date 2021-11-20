local vec2 = require("utils/vec2")
local colors = require("utils/colors")

local TimeIndicator = {}

function TimeIndicator:new(w, h, isPaused)
  local timeIndicator = {
    size = vec2:new(w, h),
    pasued = isPaused or true,
  }

  -- Convert to event subscribers
  function timeIndicator:onPause()
    self.pasued = true
  end
  function timeIndicator:onResume()
    self.pasued = false
  end

  function timeIndicator:update(dt)
    if (not self.paused) then
      local w = self.size.x - 10 * dt
      self.size = vec2:new(w, self.size.y)
      if w <= 0 then
        -- fire event to end game
      end
    end
  end

  function timeIndicator:draw()
    love.graphics.setColor(colors.white())
    love.graphics.rectangle("fill", 0, 0, self.size.x, self.size.y)
  end

  return timeIndicator
end

return TimeIndicator
