require("libs/middleclass")
local vector = require("libs/vector")
local colors = require("utils/colors")

TextButton = class("TextButton")

function TextButton:initialize(text)
  self.pos = vector(0, 0)
  self.text = text
  self.color = colors.white()
  self.font = love.graphics.newFont(20)
  self.fontSelected = love.graphics.newFont(20)

  self.width = self.font:getWidth(self.text)
  self.height = self.font:getHeight()
  self.selectedHeight = self.fontSelected:getHeight()

  self.selected = false

  self.action = nil

end

function TextButton:mousepressed(pos)
  self.mousePos = pos
  if self:containsPosition(pos) then
    self.selected = true
  end
end

function TextButton:mousereleased(pos)
  self.mousePos = pos
  self.selected = false

  if self:containsPosition(pos) then
    self:runAction()
  end
end

function TextButton:runAction()
  if self.action ~= nil then
    self:action()
  end
end

function TextButton:containsPosition(pos)
  local lineWidth = self.font:getWidth(self.text)
  local halfWidth = lineWidth / 2
  local halfHeight = self.height / 2

  if pos.x >= self.pos.x - halfWidth and
     pos.x <= self.pos.x + halfWidth and
     pos.y >= self.pos.y - halfHeight and
     pos.y <= self.pos.y + halfHeight then
    return true
  else
    return false
  end
end


function TextButton:draw()
  local font = self.font
  local height = self.height
  if self.selected then
    font = self.fontSelected
    height = self.selectedHeight
  end

  love.graphics.setFont(font)
  local lineWidth = font:getWidth(self.text)


  love.graphics.print(self.text,
                      (self.pos.x - lineWidth / 2) + 1,
                      self.pos.y - height / 2 + 1)

  love.graphics.setColor(colors.black())

  love.graphics.print(self.text,
                      self.pos.x - lineWidth / 2,
                      self.pos.y - height / 2)

end