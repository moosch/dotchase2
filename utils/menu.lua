-- local vector = require("libs/vector")
local vec2 = require("tools/vec2")
-- local class = require("libs/class")

-- Menu = class("Menu")
Menu = {}

function Menu:initialize(pos)
  self.pos = pos
  self.buttons = {}
  self.visible = true
  self.padding = 50
  self.selectedIndex = 1
end

function Menu:mousepressed(pos)
  -- return
  -- These menus will be keyboard controlled
  if self.visible then
    for i, button in ipairs(self.buttons) do
      button:mousepressed(pos)
    end
  end
end

function Menu:mousereleased(pos)
  if self.visible then
    for i, button in ipairs(self.buttons) do
      button:mousereleased(pos)
    end
  end
end

function Menu:keypressed(key, unicode)

end

function Menu:update(dt)
  local mousePosition = vec2:new(love.mouse.getX(), love.mouse.getY())
  if self.visible then
    for i, button in ipairs(self.buttons) do
      button.selected = button:containsPosition(mousePosition)
    end
  end
end

function Menu:addButton(button)
  table.insert(self.buttons, button)
  self:layoutButtons()
end

function Menu:layoutButtons()
  local y = self.pos.y
  for i, button in ipairs(self.buttons) do
    button.pos = vec2:new(self.pos.x, y)
    y = y + self.padding
  end
end

function Menu:draw()
  if self.visible then
    for i, button in ipairs(self.buttons) do
      button:draw()
    end
  end
end
