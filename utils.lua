
function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

font = love.graphics.newFont(20)

---
---Creates a table containing love.Font, width, height, x and y.
---
---@param textstring string # The string that the love.graphics.newText will contain
---@return table {text: love.Font, width: number, height: number, x: number, y: number}
function GenerateCenteredTextTbl(textstring)
  local button = {}
  button.text = love.graphics.newText(font, textstring)
  button.width = button.text:getWidth()
  button.height = 30
  button.height = button.text:getHeight()
  button.x = love.graphics.getWidth()/2 - button.width/2
  button.y = love.graphics.getHeight()/2 - button.height/2
  return button
end
