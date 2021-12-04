JSON = require("libs/JSON")
require("tools/utilities")

local Scores = {}

local maxLvlScores = 10

function Scores:load()
  self.scores = {
    easy = {},
    moderate = {},
    hard = {}
  }

  -- love.filesystem.remove("DotChase-scores") -- testing

  local contents, _resp = love.filesystem.read("string", "DotChase-scores")
  if contents then
    self.scores = JSON:decode(contents)
  else
    love.filesystem.write("DotChase-scores", JSON:encode(self.scores))
  end
end

function Scores:save(score, difficulty)
  assert(difficulty == "easy" or difficulty == "moderate" or difficulty == "hard", difficulty.." is an invalid difficulty")
  local tbl
  if difficulty == "easy" then
    tbl = self.scores.easy
    -- table.insert(self.scores.easy, score)
    -- table.sort(self.scores.easy, function(a, b) return a > b end)
    -- slice(self.scores.easy, 1, maxLvlScores)
  elseif difficulty == "moderate" then
    tbl = self.scores.moderate
    -- table.insert(self.scores.moderate, score)
    -- table.sort(self.scores.moderate, function(a, b) return a > b end)
    -- slice(self.scores.moderate, 1, maxLvlScores)
  elseif difficulty == "hard" then
    tbl = self.scores.hard
    -- table.insert(self.scores.hard, score)
    -- table.sort(self.scores.hard, function(a, b) return a > b end)
    -- slice(self.scores.hard, 1, maxLvlScores)
  end

  table.insert(tbl, score)
  table.sort(tbl, function(a, b) return a > b end)
  -- Only keep top 10 scores
  Slice(tbl, 1, maxLvlScores)

  love.filesystem.write("DotChase-scores", JSON:encode(self.scores))
end

return Scores
