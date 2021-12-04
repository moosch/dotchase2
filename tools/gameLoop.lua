--[[
An abstraction to not have to call :update on all game element's in each scene.
Just add them and remove them from this GameLoop.
--]]

local GameLoop = {}

function GameLoop:load()
  self.items = {}
end

function GameLoop:add(id, obj)
  assert(self.items[id] == nil, "Object "..id.." is already in GameLoop")
  self.items[id] = obj
end

function GameLoop:remove(id)
  self.items[id] = nil
end

function GameLoop:update(dt)
  for _, obj in pairs(self.items) do
    if obj ~= nil then obj:update(dt) end
  end
end

return GameLoop
