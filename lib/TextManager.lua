TextManager = Class{}

function TextManager:init()
end

function TextManager:Printf(text, x, y, limit, align)
  love.graphics.printf(text, x, y, limit, align)
end

function TextManager:Print(text, w, h)
  love.graphics.print(text, w, h)
end

function TextManager:LoadFont(font)
  if font == not nil then
    love.graphics.setFont(font)
  end
end

function TextManager:ImportFont(path, size)
  love.graphics.newFont(path, size)
end
