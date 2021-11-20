---
---Returns a table with x, y coordinates for the app center point.
---
---@return table {x: number, y: number}
local function getAppCenter()
  return {
    x = love.graphics.getWidth()/2,
    y = love.graphics.getHeight()/2
  }
end

return getAppCenter
