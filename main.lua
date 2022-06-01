
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
]]
function love.load()
  -- Set default filter to nearest value
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  -- Thanks to https://www.fontspace.com/press-start-2p-font-f11591
  loadDefaultFont = love.graphics.newFont('fonts/font.ttf', 8)
  -- Score font, actually same font only size changed.
  loadScoreFont = love.graphics.newFont('fonts/font.ttf', 22)
  love.graphics.setFont(loadDefaultFont)

  player1PaddleY = 30
  player2PaddleY = VIRTUAL_SCREEN_H - 50

  player1ScorePoint = 0
  player2ScorePoint = 0

  ballX = VIRTUAL_SCREEN_W / 2 - 2
  ballY = VIRTUAL_SCREEN_H / 2 - 2

  ballDX = math.random(2) == 1 and 100 or -100
  ballDY = math.random(-50, 50)

  -- Set game state to start
  GAME_STATE = "menu"

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
      player1PaddleY = math.max(0, player1PaddleY + -SPEED * dt)
    elseif love.keyboard.isDown('s') then
      player1PaddleY = math.min(VIRTUAL_SCREEN_H - 20, player1PaddleY + SPEED * dt)
    end
    
    -- Player 2 Movement
    if love.keyboard.isDown('up') then
      player2PaddleY = math.max(0, player2PaddleY + -SPEED * dt)
    elseif love.keyboard.isDown('down') then
      player2PaddleY = math.min(VIRTUAL_SCREEN_H - 20, player2PaddleY + SPEED * dt)
    end
    
    if GAME_STATE == "play" then
      ballX = ballX + ballDX * dt
      ballY = ballY + ballDY * dt
    end
    -- function love.draw()      
    --   love.graphics.setFont(loadScoreFont)
    --   love.graphics.printf('BingBong', 0, VIRTUAL_SCREEN_H, VIRTUAL_SCREEN_W * 3, 'center')  
      --  Button
      -- rectangle = love.graphics.rectangle("fill", VIRTUAL_SCREEN_W * 1.2, VIRTUAL_SCREEN_H * 1.5 - 2, 250, 32)

end


function love.keypressed(key)
  -- If user pressed the escape key quit game
  if key == "escape" then
    love.event.quit()
  end
  if key == "space" then
    GAME_STATE = "play"
    if GAME_STATE == "play" then
      ballX = VIRTUAL_SCREEN_W / 2 - 2
      ballY = VIRTUAL_SCREEN_H / 2 - 2

      ballDX = math.random(2) == 1 and 100 or -100
      ballDY = math.random(-50, 50) * 1.5
    end
  end
end



function love.draw()
  -- Begin to draw 
  push:apply('start')
    
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  love.graphics.setFont(loadDefaultFont)
  love.graphics.printf('Hello pong!', 0, 20, VIRTUAL_SCREEN_W, 'center')

  love.graphics.setFont(loadScoreFont)
  -- Render player 1 score point
  love.graphics.print(tostring(player1ScorePoint), VIRTUAL_SCREEN_W / 2 - 50, VIRTUAL_SCREEN_H / 3)
  -- Render player 2 score point
  love.graphics.print(tostring(player2ScorePoint), VIRTUAL_SCREEN_W / 2 + 30, VIRTUAL_SCREEN_H / 3)

  -- Top left paddle
  love.graphics.rectangle('fill', 10, player1PaddleY, 3, 25)

  -- Bottom right paddle
  love.graphics.rectangle('fill', VIRTUAL_SCREEN_W - 10, player2PaddleY, 3, 25)

  -- Center ball
  love.graphics.rectangle('fill', ballX, ballY, 4, 4)

  -- End draw
  push:apply('end')
end

