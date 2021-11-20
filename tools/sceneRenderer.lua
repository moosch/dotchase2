--[[
SceneRenderer takes scenes, loads the current scene, and calls draw and update on that scene
--]]

local SceneRenderer = {}

function SceneRenderer:load()
  self.scenes = {}
  self.current = nil
end

function SceneRenderer:add(scene, id)
  -- scene:load()
  self.scenes[id] = scene
end

function SceneRenderer:change(id)
  local scene = self.scenes[id]
  assert(scene ~= nil, id.." is an unregistered scene id")

  -- Cleanup
  if self.current then self.current:destroy() end

  self.current = scene
  scene:load()
end

function SceneRenderer:update(dt)
  if self.current then
    self.current:update(dt)
  end
end

function SceneRenderer:draw()
  if self.current then
    self.current:draw()
  end
end

return SceneRenderer
