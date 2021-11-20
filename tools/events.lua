local Events = {}

local function indexOf(tbl, callback)
  if tbl == nil or callback == nil then return -1 end
  for i=1, #tbl do
    if tbl[i] == callback then return i end
  end
  return -1
end

function Events:load(strict_events)
  self.handlers = {}
  self.subscribers = {}
  -- self.eventTypes = {}
  self.strict_events = strict_events or true
end

function Events:addType(eventType)
  -- assert(self.handlers[eventType] == nil, "Event "..eventType.." already exists")
  if self.handlers[eventType] == nil then
    self.handlers[eventType] = {}
  end
end

function Events:removeType(eventType)
  self.handlers[eventType] = nil
end

function Events:subscribe(eventType, callback)
  assert(type(callback) == "function", "Callback must be a function")
  if self.strict_events then
    assert(self.handlers[eventType] ~= nil, "Event type "..eventType.." does not exist")
  end
  local tbl = self.handlers[eventType]
  if tbl == nil then
    self.addType(eventType)
    tbl = self.handlers[eventType]
  end

  assert(indexOf(tbl, callback) == -1, "This callback is already registered")
  -- if indexOf(tbl, callback) > -1 then return end

  table.insert(tbl, callback)
end

function Events:unsubscribe(eventType, callback)
  assert(type(callback) == "function", "Callback must be a function")
    local idx = indexOf(self.handlers[eventType], callback)
    if idx > -1 then
      table.remove(self.handlers[eventType], idx)
    end
end

function Events:trigger(eventType, ...)
  local tbl = self.handlers[eventType]
  -- assert(tbl ~=  nil, eventType.." is not a registered eventType")
  if self.handlers[type] ~= nil then return end
  -- assert(tbl ~= nil, "Event type does not exist")
  for i=1, #tbl do
    tbl[i](...)
  end
end

function Events:clear(eventType)
  assert(eventType ~= nil, "eventType is required")
  assert(self.handlers[eventType] ~= nil, "Event "..eventType.." does not exist")
  self.handlers[eventType] = {}
end

function Events:clearAll()
  self.handlers = {}
end

return Events
