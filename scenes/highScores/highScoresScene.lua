local Button = require("scenes/common/ui/button")

local HighScoresScene = {}

function HighScoresScene:load()
  local handleBack = function()
    Events:trigger("gotoTitles")
  end

  self.backBtn = Button:new(GetWidth() / 2, GetHeight() - 50, 140, 40, "Back", handleBack)

  self.bgImage = love.graphics.newImage('assets/gradient_blue.jpg')
  self.bgImage:setWrap('repeat', 'clamp')

  GameLoop:add(self.backBtn)
end

function HighScoresScene:draw()
  -- Background
  love.graphics.draw(self.bgImage, 0, 0, 0, GetWidth(), GetHeight()/2)

  self.backBtn:draw()
end

-- function HighScoresScene:update(dt)
-- end

function HighScoresScene:destroy()
  -- cleanup any Event subscribers
  Lovebird.print("🧹")
  GameLoop:remove(self.backBtn)
  self.backBtn = nil
end

return HighScoresScene
