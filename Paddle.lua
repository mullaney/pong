-- PADDLE_DIST_FROM_EDGE = 20
-- PADDLE_WIDTH = 6
-- PADDLE_LENGTH = 45

Paddle = Class{}

function Paddle:init(player)
  self.y = (VIRTUAL_HEIGHT - PADDLE_LENGTH) / 2
  if player == 1 then
    self.x = PADDLE_DIST_FROM_EDGE
  else
    self.x = VIRTUAL_WIDTH - PADDLE_DIST_FROM_EDGE - PADDLE_WIDTH
  end
  self.dy = 0
end

function Paddle:update(dt)
  if self.dy < 0 then
    self.y = math.max(0, self.y + self.dy * dt)
  else
    self.y = math.min(VIRTUAL_HEIGHT - PADDLE_LENGTH, self.y + self.dy * dt)
  end
end

function Paddle:render()
  love.graphics.rectangle('fill', self.x, self.y, PADDLE_WIDTH, PADDLE_LENGTH)
end
