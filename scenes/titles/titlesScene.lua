local colors = require("tools/colors")
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

  local centerY = GetHeight() / 2
  local centerX = GetWidth() / 2

  local playBtn = Button:new(centerX, centerY + 50, 140, 40, "Play", handlePlay)
  local scoresBtn = Button:new(centerX, centerY + 100, 140, 40, "High Scores", handleHighScores)

  self.bgImage = love.graphics.newImage('assets/gradient_pink.jpg')
  self.bgImage:setWrap('repeat', 'clamp')

  self.buttons = { playBtn, scoresBtn }
  self.title = "Dot Chase"

  for i = 1, #self.buttons do
    GameLoop:add(self.buttons[i])
  end
end

function TitlesScene:draw()
  local centerY = GetHeight() / 2
  local centerX = GetWidth() / 2

  -- Background
  love.graphics.draw(self.bgImage, 0, 0, 0, GetWidth(), centerY)

  love.graphics.setColor(colors.white())
  love.graphics.circle("line", centerX, centerY - 200, 100)

  love.graphics.printf(self.title, 0, centerY - 50, GetWidth(), "center")

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
