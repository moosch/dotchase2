require "states/AppState"

App = {}

function App:load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  self.w, self.h, self.flags = love.window.getMode()
  self:resize(self.w, self.h)

  math.randomseed(os.time())

  love.window.setTitle('Dot Chase')
  love.graphics.setBackgroundColor(125/255, 125/255, 125/255)

  AppState:load()
end

function App:resize(w, h)
  self.scale = math.floor(math.min(
    w/self.flags.minwidth,
    h/self.flags.minheight
  ))
  self.w = math.floor(w/self.scale)
  self.h = math.floor(h/self.scale)
  self.x = math.floor(w*0.5 - self.flags.minwidth*self.scale*0.5)
  self.y = math.floor(h*0.5 - self.flags.minheight*self.scale*0.5)
end

function App:draw()
  AppState:draw()

  love.graphics.translate(self.x, self.y)
  love.graphics.scale(self.scale)
end

function App:update(dt)
  AppState:update(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  AppState:keypressed(key)
end

function love.mousepressed(x, y, button, istouch, presses)
  AppState:mousepressed(x, y, button, istouch, presses)
end

function love.resize(w, h)
  App:resize(w, h)
end
