local vec2 = require("utils/vec2")
local colors = require("tools/colors")

local Button = {}

local function mouseInBounds(pos, size, x, y)
  return x >= pos.x - (size.x / 2) and x <= pos.x + (size.x / 2) and
         y >= pos.y - (size.y / 2) and y <= pos.y + (size.y / 2)
end

function Button:new(x, y, w, h, label, callback, disabled)
  assert(type(callback) == "function", "callback is a required function param")

  local initialColor = colors.buttons.inactive
  if disabled then initialColor = colors.buttons.disabled end

  local button = {
    label = label or "Button",
    pos = vec2:new(x, y),
    size = vec2:new(w, h),
    color = initialColor,
    prevLeftClick = false,
    callback = callback
  }

  function button:draw()
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setColor(self.color())
    love.graphics.rectangle(
      "fill",
      self.pos.x - self.size.x / 2,
      self.pos.y - self.size.y / 2,
      self.size.x,
      self.size.y,
      4, 4
    )

    local f = love.graphics.getFont()
    local _, lines = f:getWrap(self.label, self.size.x)
    local fh = f:getHeight()

    love.graphics.setColor(colors.white())

    love.graphics.printf(self.label,
                        self.pos.x - (self.size.x / 2),
                        self.pos.y - (fh / 2 * #lines),
                        self.size.x,
                        "center")

    -- Reset color
    love.graphics.setColor(r, g, b, a)
  end

  function button:update(dt)
    -- love.mousepressed(x, y, button, istouch, pressed)
    x, y = love.mouse.getPosition()
    local leftClick = love.mouse.isDown(1)
    local inBounds = mouseInBounds(self.pos, self.size, x, y)
    if not disabled and inBounds then
      if leftClick then
        self.color = colors.buttons.active
      else
        self.color = colors.buttons.hover
        -- Detect a click
        if self.prevLeftClick then
          callback()
        end
      end
    else
      self.color = colors.buttons.inactive
    end

    self.prevLeftClick = leftClick
  end

  return button
end

return Button
