--[[
Items added/removed to GameLoop to remove the need to call :update on each item
--]]

local GameLoop = {}

function GameLoop:load()
  self.items = {}
end

function GameLoop:add(obj)
  table.insert(self.items, obj)
end

-- This may become a bottleneck in complex games. Could use key/value...but that brings it's own management overhead ¯\_(ツ)_/¯
function GameLoop:remove(obj)
  for i = 0, #self.items do
    if obj == self.items[i] then
      table.remove(self.items, i)
      break
    end
  end
end

function GameLoop:update(dt)
  for i = 0, #self.items do
    local obj = self.items[i]
    if obj ~= nil then
      obj:update(dt)
    end
  end
end

return GameLoop
