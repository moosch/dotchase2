Keyboard = require("tools/keyboard")
Events = require("tools/events")
ScoresTracker = require("tools/scoresTracker")
GameLoop = require("tools/gameLoop")
Lovebird = require("libs/lovebird")
require("tools/difficulties")
-- SceneManager = require("tools/sceneManager")
SceneRenderer = require("tools/sceneRenderer")
local titlesScene = require("scenes/titles/titlesScene")
local difficultySelectionScene = require("scenes/difficultySelection/difficultySelectionScene")
local gameplayScene = require("scenes/gameplay/gameplayScene")
local highScoresScene = require("scenes/highScores/highScoresScene")

-- physical screen dimensions
-- WINDOW_WIDTH = 1280
-- WINDOW_HEIGHT = 720

-- virtual resolution dimensions
-- VIRTUAL_WIDTH = 512
-- VIRTUAL_HEIGHT = 288

Difficulty = Difficulties.easy

GetWidth = love.graphics.getWidth
GetHeight = love.graphics.getHeight

function love.load()
  love.window.setTitle("Dot Chase")

  math.randomseed(os.time())

  local font = love.graphics.newFont("assets/font/roboto/Roboto-Light.ttf", 20)
  love.graphics.setFont(font)

  GameLoop:load()
  Keyboard:add_love_events()
  Events:load()
  ScoresTracker:load()

  -- Register the screen change events
  Events:addType("gotoTitles")
  Events:addType("gotoGame")
  Events:addType("gotoHighScores")
  Events:addType("gotoDifficultySelection")
  Events:addType("setDifficulty")
  Events:addType("difficultyUpdated")

  SceneRenderer:load()
  SceneRenderer:add(titlesScene, "titles")
  SceneRenderer:add(difficultySelectionScene, "difficultySelection")
  SceneRenderer:add(gameplayScene, "gameplay")
  SceneRenderer:add(highScoresScene, "highScores")

  local function gotoDifficultySelection() SceneRenderer:change("difficultySelection") end
  local function gotoGame() SceneRenderer:change("gameplay") end
  local function gotoHighScores() SceneRenderer:change("highScores") end
  local function gotoTitles() SceneRenderer:change("titles") end

  local function setDifficulty(difficulty)
    assert(difficulty ~= nil, "difficulty param cannot be nil")
    -- Reset
    if difficulty == nil then
      Difficulty = nil
    else
      assert(Difficulties[difficulty] ~= nil, difficulty.." is not a valid Difficulty")
      Difficulty = Difficulties[difficulty]
    end
    -- Events:trigger("difficultyUpdated")
  end

  -- setup scene change callbacks
  Events:subscribe("gotoDifficultySelection", gotoDifficultySelection)
  Events:subscribe("gotoGame", gotoGame)
  Events:subscribe("gotoHighScores", gotoHighScores)
  Events:subscribe("gotoTitles", gotoTitles)
  Events:subscribe("setDifficulty", setDifficulty)

  -- Starting scene to draw
  SceneRenderer:change("titles")
  -- SceneRenderer:change("difficultySelection")
  -- SceneRenderer:change("gameplay")

  -- SceneManager:load()
  -- ObjectManager:load()

  -- local scene = titlesScene:load()
  -- SceneManager:add(titlesScene)


  -- initialize state machine with all state-returning functions
  -- gStateMachine = StateMachine {
  --   ['start'] = function() return StartState() end,
  --   ['main-menu-state'] = function() return MainMenuState() end,
  --   ['menu-state'] = function() return MenuState() end,
  --   ['explore'] = function() return ExploreState() end,
  --   ['game-over'] = function() return GameOverState() end,
  -- }

  -- gStateMachine:change('start')
end

function love.draw()
  -- love.graphics.push:start()
  -- gStateMachine:render()
  -- love.graphics.push:finish()
  SceneRenderer:draw()
end

function love.update(dt)
  Lovebird.update()
  if Keyboard:key("escape") then
    love.event.quit()
  end
  -- gStateMachine:update(dt)
  -- SceneRenderer:update(dt)
  GameLoop:update(dt)
  Keyboard:update(dt)
end
