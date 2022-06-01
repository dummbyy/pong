
--[[
    Constant variables for screen size.
]]
SCREEN_WIDTH = 1280
SCREEN_HEIGHT  = 720

--[[
    Constant variables for virtual screen.
]]
VIRTUAL_SCREEN_W = 432
VIRTUAL_SCREEN_H = 243

-- https://github.com/ulydev/push
local push = require 'push'

-- The constant speed variable for our paddles
local SPEED = 200

--[[
    Runs when game first startup.
    local loadFont = love.graphics.newFont(font, 8)
]]
function love.load()
  -- Set default filter to nearest value
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  -- Thanks to https://www.fontspace.com/press-start-2p-font-f11591
  local loadDefaultFont = love.graphics.newFont('fonts/font.ttf', 8)
  -- Score font, actually same font only size changed.
  local loadScoreFont = love.graphics.newFont('fonts/font.ttf', 32)
  love.graphics.setFont(loadDefaultFont)

  player1PaddleY = 30
  player2PaddleY = VIRTUAL_SCREEN_H - 50

  player1ScorePoint = 0
  player2ScorePoint = 0

  push:setupScreen(VIRTUAL_SCREEN_W, VIRTUAL_SCREEN_H, SCREEN_WIDTH, SCREEN_HEIGHT, {
      fullscreen= false,
      resiable= false,
      vsync= true,
      title="Hello"
  })
end

function love.update(dt)
  -- Player 1 Movement
  if love.keyboard.isDown('w') then
    player1PaddleY = player1PaddleY + -SPEED * dt
  elseif love.keyboard.isDown('s') then
    player1PaddleY = player1PaddleY + SPEED * dt
  end

  -- Player 2 Movement
  if love.keyboard.isDown('up') then
    player2PaddleY = player2PaddleY + -SPEED * dt
  elseif love.keyboard.isDown('down') then
    player2PaddleY = player2PaddleY + SPEED * dt
  end
  
end

function love.keypressed(key)
  -- If user pressed the escape key quit game
  if key == "escape" then
    love.event.quit()
  end
end



function love.draw()
  -- Begin to draw 
  push:apply('start')

  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  love.graphics.printf('Hello pong!', 0, 20, VIRTUAL_SCREEN_W, 'center')

  -- Top left paddle
  love.graphics.rectangle('fill', 10, 30, 5, 20)

  -- Bottom right paddle
  love.graphics.rectangle('fill', VIRTUAL_SCREEN_W - 10, VIRTUAL_SCREEN_H - 50, 2, 20)

  -- Center ball
  love.graphics.rectangle('fill', VIRTUAL_SCREEN_W / 2 - 2, VIRTUAL_SCREEN_H / 2 - 2, 4, 4)

  -- End draw
  push:apply('end')
end

