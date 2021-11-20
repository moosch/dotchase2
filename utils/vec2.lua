local Vec2 = {}

function Vec2:new(x, y)
  local vec2 = {
    x = x,
    y = y
  }

  function vec2:set(x, y)
    self.x = x
    self.y = y
  end

  return vec2
end


return Vec2
