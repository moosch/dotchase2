local colors = require("tools/colors")
local TimeIndicator = require("scenes/gameplay/timeIndicator")
local Target = require("scenes/gameplay/target")
local Button = require("scenes/common/ui/button")
require("tools/difficulties")
require("tools/utilities")

local GameplayScene = {}
local gameState = {
  playing = "playing",
  paused = "paused",
  ended = "ended"
}

local function triggerGameOver(score)
  Events:trigger("gameOver", score)
end

function GameplayScene:load()
  Events:addType("scorePoint")
  Events:addType("gameOver")

  self.score = 0
  self.state = gameState.paused

  local function scorePoint() GameplayScene:scorePoint() end
  local function handleGameOver() GameplayScene:handleGameOver() end
  local function handleTimeUp()
    triggerGameOver(self.score)
  end
  local function resetGame() GameplayScene:resetGame() end
  local function handleBack()
    Events:trigger("gotoTitles")
  end

  self.timeIndicator = TimeIndicator:new(GetWidth(), 5, handleTimeUp)
  self.target = Target:new(Difficulty.radius)
  self.newGameBtn = Button:new(GetWidth() / 2, GetHeight() - 100, 140, 40, "Play again", resetGame)
  self.backBtn = Button:new(GetWidth() / 2, GetHeight() - 50, 140, 40, "Back", handleBack)

  GameLoop:add("gameplay:target", self.target)

  Events:subscribe("scorePoint", scorePoint)
  Events:subscribe("gameOver", handleGameOver)

  local function handleMousePressed(...) GameplayScene:mousepressed(...) end
  Mouse:add("gameplay:handleMousePressed", handleMousePressed)
end

function GameplayScene:scorePoint()
  self.score = self.score + 1
  self.target:updateTarget(
    math.random(Difficulty.radius, GetWidth() - Difficulty.radius),
    math.random(Difficulty.radius, GetHeight() - Difficulty.radius),
    Difficulty.radius
  )
end

function GameplayScene:handleGameOver()
  -- TODO: Save self.score
  -- Make it a main level module that subscribed to "gameOver" event. No need to register it here
  -- and gameplayScene doesn't care about saving implementation
  self.state = gameState.ended
  Scores:save(self.score, Difficulty.slug)
  GameLoop:add("gameplay:newGameBtn", self.newGameBtn)
  GameLoop:add("gameplay:backBtn", self.backBtn)
end

function GameplayScene:resetGame()
  self.score = 0
  self.state = gameState.paused
  GameLoop:remove("gameplay:timeIndicator")
  GameLoop:remove("gameplay:newGameBtn")
  GameLoop:remove("gameplay:backBtn")
  local endGameCb = function()
    triggerGameOver(self.score)
  end
  self.timeIndicator = TimeIndicator:new(GetWidth(), 5, endGameCb)
end

function GameplayScene:draw()
  love.graphics.setBackgroundColor(colors.white())

  self.target:draw()
  self.timeIndicator:draw()

  if self.state == gameState.paused then
    love.graphics.setColor(colors.white(0.7))
    love.graphics.rectangle("fill", 0, 0, GetWidth(), GetHeight())

    love.graphics.setColor(colors.black())
    love.graphics.printf("Tap the dot to play", 0, (GetHeight() / 2) - 50, GetWidth(), "center")
  elseif self.state == gameState.ended then
    love.graphics.setColor(colors.white(0.7))
    love.graphics.rectangle("fill", 0, 0, GetWidth(), GetHeight())

    love.graphics.setColor(colors.black())
    love.graphics.printf("Well done!", 0, (GetHeight() / 2) - 50, GetWidth(), "center")
    love.graphics.printf("You scored "..tostring(self.score), 0, (GetHeight() / 2), GetWidth(), "center")

    self.newGameBtn:draw()
    self.backBtn:draw()
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
      GameLoop:add("gameplay:timeIndicator", self.timeIndicator)
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

-- function GameplayScene:update(dt) end

function GameplayScene:destroy()
  GameLoop:remove("gameplay:timeIndicator")
  GameLoop:remove("gameplay:target")
  GameLoop:remove("gameplay:newGameBtn")
  GameLoop:remove("gameplay:backBtn")

  Events:remove("scorePoint")
  Events:remove("gameOver")

  Mouse:remove("gameplay:handleMousePressed")

  self.score = nil
  self.state = nil
  self.timeIndicator = nil
  self.target = nil
  self.newGameBtn = nil
  self.backBtn = nil
end

return GameplayScene
