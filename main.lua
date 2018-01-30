-- Pong remake based on Colten Ogden's tutorial c/o cs50 @harvard

-- To run you will need love2d @ http://love2d.org/
-- Go to the directory which holds this file run using this command:
-- open -n -a love '/my/path/to/files'

-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 640
VIRTUAL_HEIGHT = 360

PADDLE_DIST_FROM_EDGE = 20
PADDLE_WIDTH = 6
PADDLE_LENGTH = 45
BALL_RADIUS = 5

PADDLE_SPEED = 400

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  math.randomseed(os.time())

  scoreFont = love.graphics.newFont('font.ttf', 64)
  smallFont = love.graphics.newFont('font.ttf', 20)

  love.graphics.setFont(smallFont)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  player1Score = 0
  player2Score = 0
  player1Y = PADDLE_LENGTH
  player2Y = VIRTUAL_HEIGHT - 2 * PADDLE_LENGTH
  ballDx = math.random(2) == 1 and 200 or -200
  ballDy = math.random(-50, 50) * 1.3
  ballX = VIRTUAL_WIDTH / 2
  ballY = VIRTUAL_HEIGHT / 2
  
  gameState = start
end

function love.update(deltaTime)
  if love.keyboard.isDown('w') then
    player1Y = player1Y + -PADDLE_SPEED * deltaTime
  elseif love.keyboard.isDown('s') then
    player1Y = player1Y + PADDLE_SPEED * deltaTime
  end

  if love.keyboard.isDown('up') then
    player2Y = player2Y + -PADDLE_SPEED * deltaTime
  elseif love.keyboard.isDown('down') then
    player2Y = player2Y + PADDLE_SPEED * deltaTime
  end

  if gameState == 'play' then
    ballX = ballX + ballDx * deltaTime
    ballY = ballY + ballDy * deltaTime
  end
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then

    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'
      ballX = VIRTUAL_WIDTH / 2
      ballY = VIRTUAL_HEIGHT / 2
      ballDx = math.random(2) == 1 and 200 or -200
      ballDy = math.random(-50, 50) * 1.5
    end
  end
end

function love.draw()

  push:apply('start')

  love.graphics.clear(40, 45, 127, 255)

  love.graphics.setFont(smallFont)

  if gameState == 'start' then
    love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
  else
    love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
  end

  love.graphics.setFont(scoreFont)
  love.graphics.setColor(127, 127, 255, 127)
  love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 100, VIRTUAL_HEIGHT / 5)
  love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 60, VIRTUAL_HEIGHT / 5)
  love.graphics.setColor(255, 255, 255, 255)

  love.graphics.rectangle('fill', PADDLE_DIST_FROM_EDGE, player1Y, PADDLE_WIDTH, PADDLE_LENGTH)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - PADDLE_DIST_FROM_EDGE - PADDLE_WIDTH, player2Y, PADDLE_WIDTH, PADDLE_LENGTH)
  love.graphics.circle('fill', ballX, ballY, BALL_RADIUS)

  push:apply('end')
end
