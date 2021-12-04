--[[
This module handles adding and removing mouse event callbacks for scenes
]]--
local Mouse = {}

function Mouse:load()
  self.handlers = {}
end

function Mouse:add(id, callback)
  assert(id, "id is a required parameter")
  assert(callback, "callback is a required parameter")
  self.handlers[id] = callback
end

function Mouse:remove(id)
  self.handlers[id] = nil
end

function Mouse:handleMousePressed(x, y, button, istouch, presses)
  for _id, handler in pairs(self.handlers) do
    handler(x, y, button, istouch, presses)
  end
end

return Mouse
