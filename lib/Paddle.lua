Paddle = Class{}

function Paddle:init(x, y, w, h)
  self.x = x
  self.y = y
  self.w = w
  self.h = h

  self.dy = 0
end

--[[
    Add velocity to position, scaled by Δt
]]
function Paddle:Update(deltaTime)
  if self.dy < 0 then
    self.y = math.max(0, self.y + self.dy * deltaTime)
  else
    self.y = math.min(VIRTUAL_SCREEN_H - self.h, self.y + self.dy * deltaTime)
  end
end

--[[
    Simply renders Paddle
]]
function Paddle:Draw()
  love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end
