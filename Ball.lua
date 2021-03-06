Ball  = Class{}

BALL_ACCELERATOR = 1.2

function Ball:init(radius)
  self.radius = radius
end

function Ball:collides(paddle)
  if self.y + self.radius < paddle.y or self.y - self.radius > paddle.y + PADDLE_LENGTH then
    return false
  end

  if self.x + self.radius < paddle.x or self.x - self.radius > paddle.x + PADDLE_WIDTH then
    return false
  end 
  
  return true
end

function Ball:reset(moving)
  self.x = VIRTUAL_WIDTH / 2
  self.y = VIRTUAL_HEIGHT / 2
  if moving == true then
    self.dx = math.random(2) == 1 and -160 or 160
    self.dy = math.random(-90, 90)
  else
    self.dy = 0
    self.dx = 0
  end
end

function Ball:update(dt)
  self.x = self.x + self.dx * dt
  self.y = self.y + self.dy * dt
end

function Ball:render()
  love.graphics.circle('fill', self.x, self.y, self.radius)
end

function Ball:getVelocity()
  return math.sqrt(ball.dx * ball.dx + ball.dy * ball.dy)
end

function Ball:setDeltaX(ballVelocity)
  return math.sqrt(ballVelocity * ballVelocity * BALL_ACCELERATOR - ball.dy * ball.dy)
end

function Ball:clear() 
  ball.x = -100
  ball.y = -100
  ball.dx = 0
  ball.dy = 0
end