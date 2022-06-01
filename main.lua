-- https://github.com/ulydev/push
push    = require 'push'
Class   = require 'lib.class'
require 'lib.Paddle'
require 'lib.Ball'
require 'lib.StateManager'
require 'lib.TextManager'

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


-- The constant speed variable for our paddles
SPEED = 200


--[[
    Runs when game first startup.
]]
function love.load()
  -- Set default filter to nearest value
  love.graphics.setDefaultFilter('nearest', 'nearest')
  math.randomseed(os.time())
  
  -- Thanks to https://www.fontspace.com/press-start-2p-font-f11591
  gameTextManager = TextManager()
  gameTextManager:ImportFont('fonts/font.ttf', 8)
  
  -- Score font, actually same font only size changed.
  scoreTextManager1 = TextManager()
  scoreTextManager2 = TextManager()

  stx1 = scoreTextManager1:ImportFont('fonts/font.ttf', 22)
  stx2 = scoreTextManager2:ImportFont('fonts/font.ttf', 22)

  gameTextManager:LoadFont()

  player1ScorePoint = 0
  player2ScorePoint = 0

  
  push:setupScreen(VIRTUAL_SCREEN_W, VIRTUAL_SCREEN_H, SCREEN_WIDTH, SCREEN_HEIGHT, {
    fullscreen= false,
    resiable= false,
    vsync= true,
    title="Hello"
  })
  
  StateManager = GameState()
  player1 = Paddle(10, 30, 5, 20)
  player2 = Paddle(VIRTUAL_SCREEN_W - 10, VIRTUAL_SCREEN_H - 30, 5, 20)
  
  -- place a ball in the middle of the screen
  ball = Ball(VIRTUAL_SCREEN_W / 2 - 2, VIRTUAL_SCREEN_H / 2 - 2, 4, 4)
  -- Set game state to start
  StateManager:setState('menu')
end

function love.update(dt)
  -- Player 1 Movement
  if love.keyboard.isDown('w') then
    player1.dy = -SPEED
  elseif love.keyboard.isDown('s') then
    player1.dy = SPEED
  else
    player1.dy = 0
  end
    
  -- Player 2 Movement
  if love.keyboard.isDown('up') then
    player2.dy = -SPEED
  elseif love.keyboard.isDown('down') then
    player2.dy = SPEED
  else
    player2.dy = 0
  end
    
  if StateManager:getState() == "play" then
    ball:Update(dt)
  end

  player1:Update(dt)
  player2:Update(dt)
end


function love.keypressed(key)
  -- If user pressed the escape key quit game
  if key == "escape" then
    love.event.quit()
  end
  if key == "space" then
    StateManager:setState('play')
  end
end



function love.draw()
  -- Begin to draw 
  push:apply('start')
    
  love.graphics.clear(40/255, 45/255, 52/255, 255/255)

  gameTextManager:LoadFont()
  gameTextManager:Printf('Hello pong!', 0, 20, VIRTUAL_SCREEN_W, 'center')

  scoreTextManager1:LoadFont()
  scoreTextManager2:LoadFont()
  -- Render player 1 score point
  scoreTextManager1:Print(tostring(player1ScorePoint), VIRTUAL_SCREEN_W / 2 - 50, VIRTUAL_SCREEN_H / 3)
  -- Render player 2 score point
  scoreTextManager2:Print(tostring(player2ScorePoint), VIRTUAL_SCREEN_W / 2 + 30, VIRTUAL_SCREEN_H / 3)

  player1:Draw()
  player2:Draw()
  ball:Draw()

  -- End draw
  push:apply('end')
end

