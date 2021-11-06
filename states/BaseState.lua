-- Used as a base class for any game states to avoid unimplimented functions being called

BaseState = Class{}

function BaseState:init(_params) end
function BaseState:enter(_params) end
function BaseState:exit() end
function BaseState:update(_dt) end
function BaseState:draw() end
function BaseState:keypressed(_key) end
function BaseState:mousepressed(_x, _y, _button, _istouch, _presses) end
