require 'app'

function love.load()
  App:load()
end

function love.draw()
  love.graphics.push()
  App:draw()
  love.graphics.pop()
end

function love.update(dt)
  App:update(dt)
end
