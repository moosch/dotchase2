local flux = require("libs/flux")
local vec2 = require("tools/vec2")
local colors = require("utils/colors")

local Target = {}

function Target:new(r, x, y)
  local target = {
    pos = vec2:new(
      x or math.random(r, love.graphics.getWidth() - r),
      y or math.random(r, love.graphics.getHeight() - r)),
    radius = r,
    moveAnimSpeed = 0.05,
    resizeAnimSpeed = 0.03
  }

  function target:updateTarget(x, y, r)
    -- Maybe don't have :move, instead use event that gets listened to in :update? So we can animate
    flux.to(self.pos, self.moveAnimSpeed, {
      x = x or self.pos.x,
      y = y or self.pos.y
    }):ease("sineout")

    flux.to(self, self.moveAnimSpeed, {
      radius = r or self.radius
    }):ease("sineout")
  end

  function target:update(dt)
    flux.update(dt)
  end

  function target:draw()
    love.graphics.setColor(colors.red())
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
  end

  return target
end

return Target
