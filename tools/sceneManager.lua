--[[
NOT USED
SceneManager
]]--

local SceneManager = {}

function SceneManager:load()
  self.objects = {}

  GameLoop:add(self)
end

function SceneManager:tick(dt)
  -- For animating in/out of scenes

  -- for i = #self.objects, 1, -1 do
  --   local obj = self.objects[i]
  --   if obj.remove then
  --     table.remove(self.objects, i)
  --   end
  -- end
end

function SceneManager:add(scene)
  scene:load()
  table.insert(self.objects, scene)
end

return SceneManager
