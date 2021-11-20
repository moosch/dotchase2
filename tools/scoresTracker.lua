local ScoresTracker = {}

function ScoresTracker:load()
  -- TODO: Load scores from persistence
  self.scores = {
    easy = {},
    medium = {},
    hard = {}
  }
end

function ScoresTracker:add(score, difficulty)
  -- TODO: Add to scores from persistence
  if self.scores[difficulty] then
    local scores = self.scores[difficulty]
    table.insert(scores, score)
    self.scores[difficulty] = scores
  end
end

function ScoresTracker:get()
  return self.scores
end

function ScoresTracker:getByDifficulty(difficulty)
  if self.scores[difficulty] then
    return self.scores[difficulty]
  end
  return {}
end

return ScoresTracker
