Ball  = Class{}

function Ball:init(radius)
  self.x = VIRTUAL_WIDTH / 2
  self.y = VIRTUAL_HEIGHT / 2
  self.radius = radius
end

function Ball:reset(moving)
  self.x = VIRTUAL_WIDTH / 2
  self.y = VIRTUAL_HEIGHT / 2
  if moving == true then
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
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