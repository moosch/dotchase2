require("tools/difficulties")
Keyboard = require("tools/keyboard")
Mouse = require("tools/mouse")
Events = require("tools/events")
GameLoop = require("tools/gameLoop")
Scores = require("tools/scores")
Lovebird = require("libs/lovebird")
SceneRenderer = require("tools/sceneRenderer")

local titlesScene = require("scenes/titles/titlesScene")
local difficultySelectionScene = require("scenes/difficultySelection/difficultySelectionScene")
local gameplayScene = require("scenes/gameplay/gameplayScene")
local highScoresScene = require("scenes/highScores/highScoresScene")

Difficulty = Difficulties.easy
GetWidth = love.graphics.getWidth
GetHeight = love.graphics.getHeight

function love.load()
  love.window.setTitle("Dot Chase")
  _ = math.randomseed(os.time())

  -- love.graphics.setDefaultFilter('nearest', 'nearest')
  -- self.w, self.h, self.flags = love.window.getMode()
  -- self:resize(self.w, self.h)

  local font = love.graphics.newFont("assets/font/roboto/Roboto-Light.ttf", 22)
  love.graphics.setFont(font)

  Scores:load()
  Mouse:load()
  GameLoop:load()
  Keyboard:add_love_events()
  Events:load()

  -- Register the screen change events
  Events:addType("gotoTitles")
  Events:addType("gotoGame")
  Events:addType("gotoHighScores")
  Events:addType("gotoDifficultySelection")
  Events:addType("setDifficulty")

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
  end

  -- setup scene change callbacks
  Events:subscribe("gotoDifficultySelection", gotoDifficultySelection)
  Events:subscribe("gotoGame", gotoGame)
  Events:subscribe("gotoHighScores", gotoHighScores)
  Events:subscribe("gotoTitles", gotoTitles)
  Events:subscribe("setDifficulty", setDifficulty)

  -- Starting scene to draw
  SceneRenderer:change("titles")
end

function love.draw()
  SceneRenderer:draw()
end

function love.update(dt)
  Lovebird.update()
  if Keyboard:key("escape") then
    love.event.quit()
  end
  GameLoop:update(dt)
  Keyboard:update(dt)
end

function love.mousepressed(x, y, button, istouch, presses)
  Mouse:handleMousePressed(x, y, button, istouch, presses)
end
