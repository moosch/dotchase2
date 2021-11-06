require "../utils"

PlayState = Class{__includes = BaseState}

function PlayState:init(params)
  -- Create Target

  love.graphics.setBackgroundColor(183/255, 121/255, 155/255)

  Target:load(params)
end

function love.keypressed(key)
  Target:keypressed(key)
end

function PlayState:draw()
  Target:draw()
end

function PlayState:update(dt)
  -- timer update
  -- event listener
  Target:update(dt)
end

-- IO

function PlayState:keypressed(key)
  Target:keypressed(key)
end

function PlayState:mousepressed(x, y, button, istouch, presses)
  if button == 1 then
    local hitpointDistanceFromTarget = distanceBetween(x, y, Target.x, Target.y)
    if (hitpointDistanceFromTarget <= Target.radius) then
      pointScored()
    end
  end
end

-- Move this into Target?? Where does this logic live?
function pointScored()
  OnPointScored()
  Target:move()
  -- score = score + 1
end
