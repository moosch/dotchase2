require("utils/utilities")

local HighScoresScene = {}

function HighScoresScene:load()
  self.bgImage = love.graphics.newImage('assets/gradient_blue.jpg')
  self.bgImage:setWrap('repeat', 'clamp')
end

function HighScoresScene:draw()
  -- Background
  love.graphics.draw(self.bgImage, 0, 0, 0, GetWidth(), GetHeight()/2)
end

-- function HighScoresScene:update(dt)
-- end

function HighScoresScene:destroy()
  -- cleanup any Event subscribers
end

return HighScoresScene
