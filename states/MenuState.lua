require "../utils"

--[[
TODO: 
- [ ] Ask difficulty EASY | MEDIUM | HARD
- [ ] Add countdown timer
- [ ] Display score when timer ends
- [ ] Allow "replay"
]]--

MenuState = Class{__includes = BaseState}


local playButton = GenerateCenteredTextTbl("Play")
local scoresText = GenerateCenteredTextTbl("High Scores")
scoresText.y = love.graphics.getHeight()/2 - scoresText.height/2 + (playButton.height * 2)

function MenuState:init()
  love.graphics.setBackgroundColor(183/255, 121/255, 155/255)
end

function MenuState:draw()
  love.graphics.setColor(255/255, 255/255, 255/255, 0.2)
  love.graphics.rectangle(
    "fill",
    playButton.x,
    playButton.y,
    playButton.width,
    playButton.height)

  love.graphics.setColor(255/255, 255/255, 255/255, 0.2)
  love.graphics.rectangle(
    "fill",
    scoresText.x,
    scoresText.y,
    scoresText.width,
    scoresText.height)

  love.graphics.setColor(255/255, 255/255, 255/255)

  love.graphics.draw(playButton.text, playButton.x, playButton.y)

  love.graphics.draw(scoresText.text, scoresText.x, scoresText.y)

  love.graphics.circle(
    "line",
    love.graphics.getWidth()/2,
    love.graphics.getHeight()/2 - 150,
    100)
end

function MenuState:update(dt)
  if love.keypressed('enter') or love.keypressed('return') then
    AppState:change('play', 'hard')
  end
end

-- IO

function MenuState:mousepressed(x, y, button, istouch, presses)
  if button == 1 then
    if (x >= playButton.x and x <= (playButton.x + playButton.width)
    and y >= playButton.y and y <= (playButton.y + playButton.height)) then
      AppState:change('play', 'hard')
    end

    if (x >= scoresText.x and x <= (scoresText.x + scoresText.width)
    and y >= scoresText.y and y <= (scoresText.y + scoresText.height)) then
      AppState:change('scores')
    end
  end
end
