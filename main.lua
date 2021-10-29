require "target"

-- Can declare major vaiables in .load
function love.load()
  Score = 0
  Timer = 5000
  -- love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setTitle('Dot Chase')

  Target:load()
end

-- can update major variables and perform calcs
function love.update(dt)
  Target:update(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  if key == "space" then
    pointScored()
  end

  if key == 's' then
    Target:setSize('s')
  end
  if key == 'm' then
    Target:setSize('m')
  end
  if key == 'l' then
    Target:setSize('l')
  end
end

function love.mousepressed(x, y, button, istouch, oresses)
  if button == 1 then
    local hitpointDistanceFromTarget = distanceBetween(x, y, Target.x, Target.y)
    if (hitpointDistanceFromTarget < Target.radius) then
      pointScored()
    end
  end
end

-- .draw is for anything involving graphics and images and using variables
function love.draw()
  Target:draw()

  -- push:start()

  -- love.graphics.draw(background, 0, 0)

  -- push:finish()
end

function pointScored()
  Target:setNewPosition()
  Score = Score + 1
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
