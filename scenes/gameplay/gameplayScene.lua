local colors = require("tools/colors")
local TimeIndicator = require("scenes/gameplay/timeIndicator")
local Target = require("scenes/gameplay/target")
require("tools/difficulties")
require("utils/utilities")

local GameplayScene = {}
local gameState = {
  playing = "playing",
  paused = "paused",
  ended = "ended"
}

function GameplayScene:load()
  Events:addType("scorePoint")

  self.score = 0
  self.state = gameState.paused
  self.paused = true
  self.timeIndicator = TimeIndicator:new(GetWidth(), 5)
  self.target = Target:new(Difficulty.radius)

  GameLoop:add(self.timeIndicator)
  GameLoop:add(self.target)

  local function scorePoint() GameplayScene:scorePoint() end
  local function difficultyUpdated() GameplayScene:difficultyUpdated() end

  Events:subscribe("scorePoint", scorePoint)
  Events:subscribe("difficultyUpdated", difficultyUpdated)

  function love.mousepressed(x, y, button, istouch, presses)
    self:mousepressed(x, y, button, istouch, presses)
  end
end

function GameplayScene:scorePoint()
  self.score = self.score + 1
  self.target:updateTarget(
    math.random(Difficulty.radius, GetWidth() - Difficulty.radius),
    math.random(Difficulty.radius, GetHeight() - Difficulty.radius),
    Difficulty.radius
  )
end

function GameplayScene:difficultyUpdated()
  if Difficulty ~= nil then
    self.target:updateTarget(nil, nil, Difficulty.radius)
  end
end

function GameplayScene:draw()
  -- background
  love.graphics.setBackgroundColor(colors.white())

  self.target:draw()
  self.timeIndicator:draw()

  -- Temp
  love.graphics.setColor(colors.black())
  love.graphics.print(tostring(self.score), 20, 20)

  if self.state == gameState.paused then
    love.graphics.setColor(colors.white(0.7))
    love.graphics.rectangle("fill", 0, 0, GetWidth(), GetHeight())

    love.graphics.setColor(colors.black())
    love.graphics.printf("Tap the dot to play", 0, (GetHeight() / 2) - 150, GetWidth(), "center")
  end
end

local function playingHandleMousepressed(self, x, y, button, istouch, presses)
  if self.target then
    local distance = DistanceBetween(x, y, self.target.pos.x, self.target.pos.y)
    if distance < self.target.radius then
      Events:trigger("scorePoint")
    end
  end
end

local function pausedHandleMousepressed(self, x, y, button, istouch, presses)
  if self.target then
    local distance = DistanceBetween(x, y, self.target.pos.x, self.target.pos.y)
    if distance < self.target.radius then
      self.state = gameState.playing
      Events:trigger("scorePoint")
    end
  end
end

local function endedHandleMousepressed(self, x, y, button, istouch, presses)
end

local gameStateMousePresses = {
  [gameState.paused] = function(...) pausedHandleMousepressed(...) end,
  [gameState.playing] = function(...) playingHandleMousepressed(...) end,
  [gameState.ended] = function(...) endedHandleMousepressed(...) end
}

function GameplayScene:mousepressed(x, y, button, istouch, presses)
  gameStateMousePresses[self.state](self, x, y, button, istouch, presses)
end

-- function GameplayScene:update(dt)
-- end

function GameplayScene:destroy()
  -- cleanup any Event subscribers
  Lovebird.print("🧹")
  GameLoop:remove(self.timeIndicator)
  GameLoop:remove(self.target)

  self.score = nil
  self.state = nil
  self.paused = nil
  self.timeIndicator = nil
  self.target = nil
end

return GameplayScene
