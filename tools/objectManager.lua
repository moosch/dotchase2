--[[
NOT USED
ObjectMangager is responsible for cleaning up entities marked as deleted
]]--

local ObjectManager = {}

function ObjectManager:new()
  local objectManager = {}
  self.objects = {}
  -- GameLoop:add(self)

  function objectManager:tick(dt)
    for i = #self.objects, 1, -1 do
      local obj = self.objects[i]
      if obj.remove then
        table.remove(self.objects, i)
      end
    end
  end

  function objectManager:add(obj)
    obj:load()
    table.insert(self.objects, obj)
  end

  return objectManager
end

return ObjectManager
