-- local colors = require("utils/colors")
-- -- local vector = require("libs/vector")
-- local vec2 = require("tools/vec2")
-- require("utils/textbutton")

-- require("utils/menu")

-- local scene = Gamestate.new()

-- function scene:enter(pre)
--   self.menu = Menu(vec2:new((love.graphics.getWidth() / 2) - 150, (love.graphics.getHeight() / 2 - 30)))
-- end

-- function scene:update(dt)
--   self.menu:update(dt)
-- end

-- function scene:draw()
--   love.graphics.clear()
--   colors.setBackgroundColor(colors.pink())
--   colors.setColor(colors.white())

--   self.menu = Menu(vec2:new((love.graphics.getWidth() / 2) - 150, (love.graphics.getHeight() / 2 - 30)))
--   local playButton = TextButton("Play")
--   playButton.action = function()
--     self:startGame()
--   end
--   self.menu:addButton(playButton)

--   local quitButton = TextButton("Quit")
--   quitButton.action = function()
--     self:quit()
--   end
--   self.menu:addButton(quitButton)

--   self.menu:draw()
-- end

-- function scene:startGame()
--   -- Gamestate.switch(game)
-- end

-- function scene:keypressed(key, unicode)
--   if key == "escape" then
--     self:quit()
--   end
-- end

-- function scene:mousepressed(x, y, button)
-- end

-- function scene:mousereleased(x, y, button)
-- end

-- function scene:quit()
-- end

-- function scene:leave()
-- end

-- return scene
