Class = require "libs/class"

require "target"

require "states/StateMachine"
require "states/BaseState"
require "states/MenuState"
require "states/PlayState"
require "states/ScoresState"

--[[
AppState holds the current StateMachine of the application.
It also holds any upper-level state, such as the selected difficulty,
and the current score.
]]--

AppState = {}

Difficulty = {
  easy = "l",
  medium = "m",
  hard = "s"
}

time = 200
timer = 0
score = 0
selectedDifficulty = Difficulty["medium"]

function AppState:load()
  self.state = StateMachine {
    ['title'] = function(params) return MenuState(params) end,
    ['play'] = function(params) return PlayState(params) end,
    ['scores'] = function(params) return ScoresState(params) end,
  }
  self.state:change('title')
end

function AppState:change(moveTo, params)
  self.state:change(moveTo, params)
end

function AppState:draw()
  self.state:draw()
end

function AppState:update(dt)
  local newTime = time - 1 * dt
  if (newTime < 0) then
    newTime = 0
  end
  time = newTime

  self.state:update(dt)
end

function AppState:keypressed(key)
  self.state:keypressed(key)
end

function AppState:mousepressed(x, y, button, istouch, presses)
  self.state:mousepressed(x, y, button, istouch, presses)
end

function OnPointScored()
  score = score + 1
end

function OnDifficultySelection(difficulty)
  if (
    (not difficulty == selectedDifficulty)
    and Difficulty[difficulty]
  ) then
    selectedDifficulty = Difficulty[difficulty]
  end
end
