local Button = require("scenes/common/ui/button")
require("utils/utilities")

local TitlesScene = {}

function TitlesScene:load()
  local handlePlay = function()
    Events:trigger("gotoDifficultySelection")
  end
  local handleHighScores = function()
    Events:trigger("gotoHighScores")
  end

  local playBtn = Button:new(
    (GetWidth() / 2),
    300,
    140,
    40,
    "Play",
    handlePlay)
  local scoresBtn = Button:new(
    (GetWidth() / 2),
    360,
    140,
    40,
    "High Scores",
    handleHighScores)

  self.bgImage = love.graphics.newImage('assets/gradient_pink.jpg')
  self.bgImage:setWrap('repeat', 'clamp')

  self.buttons = { playBtn, scoresBtn }
  self.title = "Dot Chase"

  for i = 1, #self.buttons do
    GameLoop:add(self.buttons[i])
  end
end

function TitlesScene:draw()
  -- Background
  love.graphics.draw(self.bgImage,0,0,0,GetWidth(),GetHeight()/2)

  love.graphics.printf(self.title, 0, 100, GetWidth(), "center")

  for i = 1, #self.buttons do
    self.buttons[i]:draw()
  end
end

-- function TitlesScene:update(dt)
-- end

function TitlesScene:destroy()
  -- cleanup any Event subscribers
  Lovebird.print("🧹")
  for i = 1, #self.buttons do
    GameLoop:remove(self.buttons[i])
  end

  self.bgImage = nil
  self.buttons = nil
  self.title = nil
end

return TitlesScene
