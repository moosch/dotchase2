local colors = require("tools/colors")
local Button = require("scenes/common/ui/button")
local vec2 = require("tools/vec2")
require("tools/utilities")

local Dot = {}
function Dot:new()
  local dot = {
    pos = vec2:new(GetWidth() / 2, GetHeight() / 2 - 200),
    centerX = GetWidth() / 2,
    radius = 20,
    elapsedTime = 0,
  }
  function dot:draw()
    love.graphics.setColor(colors.white())
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
  end

  function dot:update(dt)
    -- This was very helpful https://yunhan.li/unity/2017/12/19/math-wave.html
    local amp = 50
    local speed = 2
    self.pos.x = amp * math.sin(speed * self.elapsedTime) + self.centerX
    self.elapsedTime = self.elapsedTime + dt
  end

  return dot
end

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

  self.buttons = {}
  self.buttons["titles:playButton"] = playBtn
  self.buttons["titles:scoresButton"] = scoresBtn
  self.title = "Dot Chase"

  self.dot = Dot:new()
  GameLoop:add("dot", self.dot)

  for id, btn in pairs(self.buttons) do
    GameLoop:add(id, btn)
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

  self.dot:draw()

  for _id, btn in pairs(self.buttons) do
    btn:draw()
  end
end

-- function TitlesScene:update(dt) end

function TitlesScene:destroy()
  for id, _btn in pairs(self.buttons) do
    GameLoop:remove(id)
  end

  GameLoop:remove("dot")
  self.dot  = nil

  self.bgImage = nil
  self.buttons = nil
  self.title = nil
end

return TitlesScene
