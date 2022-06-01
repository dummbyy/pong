local GAME_STATE = 'none'
GameState = Class{}

function GameState:init()

end

function GameState:setState(state)
  GAME_STATE = state
end

function GameState:getState()
  return GAME_STATE
end