-- multuple returns

local colors = {
  white = function(alpha) return 255/255, 255/255, 255/255, alpha or 1 end,
  black = function(alpha) return 0/255, 0/255, 0/255, alpha or 1 end,
  pink = function(alpha) return 183/255, 121/255, 155/255, alpha or 1 end,
  red = function(alpha) return 201/255, 40/255, 40/255, alpha or 1 end,
  blue = function(alpha) return 61/255, 188/255, 226/255, alpha or 1 end,
  buttons = {
    inactive = function(alpha) return 88/255, 147/255, 196/255, alpha or 1 end,
    hover = function(alpha) return 106/255, 155/255, 196/255, alpha or 1 end,
    active = function(alpha) return 62/255, 120/255, 168/255, alpha or 1 end,
    disabled = function(alpha) return 140/255, 140/255, 140/255, alpha or 1 end
  },
  setColor = function(r, g, b, a) love.graphics.setColor(r, g, b, a) end,
  setBackgroundColor = function(r, g, b, a) love.graphics.setBackgroundColor(r, g, b, a) end,
}

return colors
