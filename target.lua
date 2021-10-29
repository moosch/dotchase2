require 'math'
local flux = require 'libs/flux' -- https://github.com/rxi/flux/

Target = {}

Radiuses = {
  s = 40,
  m = 70,
  l = 100,
}
CurrentRadius = Radiuses.s

Position = {
  x = love.graphics.getWidth() / 2,
  y = love.graphics.getHeight() / 2,
}

function Target:load()
  self.x = Position.x
  self.y = Position.y

  self.radius = CurrentRadius
  -- self.velocity = 200
  self.moveAnimSpeed = 0.05
  self.resizeAnimSpeed = 0.03
end

function Target:update(dt)
  self:updatePosition()
  self:updateSize()
  flux.update(dt)
end

function Target:draw()
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Target:setNewPosition()
  Position = {
    x = math.random(CurrentRadius, love.graphics.getWidth() - CurrentRadius),
    y = math.random(CurrentRadius, love.graphics.getHeight() - CurrentRadius),
  }
end

function Target:updatePosition()
  flux.to(self, self.moveAnimSpeed, {
    x = Position.x,
    y = Position.y,
  }):ease("sineout")
end

function Target:setSize(size)
  CurrentRadius = Radiuses[size] or Radiuses.s
end

function Target:updateSize()
  flux.to(self, self.resizeAnimSpeed, {
    radius = CurrentRadius,
  }):ease("sineout")
end
