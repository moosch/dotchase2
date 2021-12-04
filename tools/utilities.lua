---
---Returns a slice of a table (must be an array-like table)
---
---@param t table # Table to be sliced.
---@param n1 number # Starting index of slice.
---@param n2 number # Ending indx of slice.
---@return table slice
function Slice(t, n1, n2)
  local newT = {}
  for i = n1, n2-n1 do
    if t[i] then table.insert(newT, t[i]) end
  end
  return newT
end


---
---Returns the distance between coordinate points
---
---@param x1 number # First x-axis coordinate.
---@param y1 number # First y-axis coordinate.
---@param x2 number # Second x-axis coordinate.
---@param y2 number # Second y-axis coordinate.
---@return number distance
function DistanceBetween(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

---
---Creates a table containing love.Font, width, height, x and y.
---
---@param textstring string # The string that the love.graphics.newText will contain
---@return table {text: love.Font, width: number, height: number, x: number, y: number}
function GenerateCenteredTextTbl(textstring, font)
  local button = {}
  button.text = love.graphics.newText(font, textstring)
  button.width = button.text:getWidth()
  button.height = 30
  button.height = button.text:getHeight()
  button.x = love.graphics.getWidth()/2 - button.width/2
  button.y = love.graphics.getHeight()/2 - button.height/2
  return button
end

---
---Returns a table with x, y coordinates for the app center point.
---
---@return table {x: number, y: number}
function GetAppCenter()
  return {
    x = love.graphics.getWidth()/2,
    y = love.graphics.getHeight()/2
  }
end
