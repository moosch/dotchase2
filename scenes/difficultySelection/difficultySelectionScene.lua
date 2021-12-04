local Button = require("scenes/common/ui/button")

local DifficultySelectionScene = {}

function DifficultySelectionScene:load()
  local handlePlayEasy = function()
    Events:trigger("setDifficulty", 'easy')
    Events:trigger("gotoGame")
  end
  local handlePlayModerate = function()
    Events:trigger("setDifficulty", 'moderate')
    Events:trigger("gotoGame")
  end
  local handlePlayHard = function()
    Events:trigger("setDifficulty", 'hard')
    Events:trigger("gotoGame")
  end

  local handleBack = function()
    Events:trigger("gotoTitles")
  end

  local centerY = GetHeight() / 2
  local centerX = GetWidth() / 2

  local easyBtn = Button:new(centerX, centerY - 50, 140, 40, "Easy", handlePlayEasy)
  local moderateBtn = Button:new(centerX, centerY, 140, 40, "Moderate", handlePlayModerate)
  local hardBtn = Button:new(centerX, centerY + 50, 140, 40, "Hard", handlePlayHard)
  local backBtn = Button:new(centerX, GetHeight() - 50, 140, 40, "Back", handleBack)

  self.bgImage = love.graphics.newImage('assets/gradient_blue.jpg')
  self.bgImage:setWrap('repeat', 'clamp')

  self.buttons = {}
  self.buttons["difficultySelection:easyButton"] = easyBtn
  self.buttons["difficultySelection:moderateButton"] = moderateBtn
  self.buttons["difficultySelection:hardButton"] = hardBtn
  self.buttons["difficultySelection:backButton"] = backBtn
  self.title = "Select Difficulty"

  for id, btn in pairs(self.buttons) do
    GameLoop:add(id, btn)
  end
end

-- function DifficultySelectionScene:update(dt) end

function DifficultySelectionScene:draw()
  love.graphics.draw(self.bgImage, 0, 0, 0, GetWidth(), GetHeight() / 2)

  love.graphics.printf(self.title, 0, (GetHeight() / 2) - 150, GetWidth(), "center")

  for _, btn in pairs(self.buttons) do
    btn:draw()
  end
end

function DifficultySelectionScene:destroy()
  for id, _btn in pairs(self.buttons) do
    GameLoop:remove(id)
  end
  self.buttons = nil
  self.bgImage = nil
  self.title = nil
end

return DifficultySelectionScene
