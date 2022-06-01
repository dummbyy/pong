Ball = Class{}

function Ball:init(x, y, w, h)
  self.x = x  
  self.y = y  
  self.w = w  
  self.h = h 

  self.dx = math.random(-50, 50)
  self.dy = math.random(2) == 1 and -100 or 100
end

--[[
    Resets ball position to start point
]]
function Ball:Reset()
  self.x = VIRTUAL_SCREEN_W / 2 - 2
  self.y = VIRTUAL_SCREEN_H / 2 - 2
  self.dx = math.random(-50, 50)
  self.dy = math.random(2) == 1 and -100 or 100
end

--[[
    Add velocity to position, scaled by Δt
]]
function Ball:Update(deltaTime)
  self.x = self.x + self.dx * deltaTime
  self.y = self.y + self.dy * deltaTime
end
--[[
    Simply renders Ball
]]
function Ball:Draw()
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end
