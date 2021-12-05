JSON = require("libs/JSON")
local colors = require("tools/colors")
local Button = require("scenes/common/ui/button")
require("tools/difficulties")

local HighScoresScene = {}

function HighScoresScene:load()
  local handleBack = function()
    Events:trigger("gotoTitles")
  end

  self.backBtn = Button:new(GetWidth() / 2, GetHeight() - 50, 140, 40, "Back", handleBack)

  self.bgImage = love.graphics.newImage('assets/gradient_blue.jpg')
  self.bgImage:setWrap('repeat', 'clamp')

  self.scores = Scores.scores

  GameLoop:add("highScores:backButton", self.backBtn)
end

function HighScoresScene:draw()
  local width = GetWidth()
  love.graphics.draw(self.bgImage, 0, 0, 0, width, GetHeight()/2)

  -- Title
  love.graphics.setColor(colors.white())
  love.graphics.printf("High Scores", 0, 50, width, "center")

  local segmentWidth = width / 4

  -- Difficulties titles and scores
  for key, value in pairs(Difficulties) do
    local posX = segmentWidth * value.id
    love.graphics.setColor(colors.white())
    love.graphics.printf(tostring(key), posX - (segmentWidth / 2), 200, segmentWidth, "center")

    -- Difficulty dot
    love.graphics.circle("fill", posX, 140, value.radius)

    -- Column of high scores
    local scores = self.scores[tostring(key)]
    table.sort(scores, function(a, b) return a > b end)
    for i = 1, #scores do
      love.graphics.printf(tostring(scores[i]), posX - (segmentWidth / 2), 200 + (30*i), segmentWidth, "center")
    end
  end


  self.backBtn:draw()
end

-- function HighScoresScene:update(dt) end

function HighScoresScene:destroy()
  GameLoop:remove("highScores:backButton")
  self.backBtn = nil
end

return HighScoresScene
