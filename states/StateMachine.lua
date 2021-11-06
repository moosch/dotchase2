-- Usage
-- AppState = StateMachine {
--   ['MainMenu'] = function() return MainMenu() end,
--   ['InnerGame'] = function() return InnerGame() end,
--   ['Scores'] = function() return Scores() end,
-- }

StateMachine = Class{}

function StateMachine:init(states)
  self.empty = {
    draw = function() end,
    update = function(_dt) end,
    enter = function(_params) end,
    exit = function() end,
    keypressed = function(_key) end,
    mousepressed = function(_x, _y, _button, _istouch, _presses) end,
  }

  self.states = states or {}
  self.current = self.empty
end

function StateMachine:change(state, params)
  assert(self.states[state])

  self.current:exit()
  self.current = self.states[state](params)
  self.current:enter(params)
end

function StateMachine:update(dt)
  self.current:update(dt)
end

function StateMachine:draw()
  self.current:draw()
end

function StateMachine:keypressed(key)
  self.current:keypressed(key)
end

function StateMachine:mousepressed(x, y, button, istouch, presses)
  self.current:mousepressed(x, y, button, istouch, presses)
end
