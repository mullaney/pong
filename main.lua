-- Pong remake based on Colten Ogden's tutorial c/o cs50 @harvard

-- To run you will need love2d @ http://love2d.org/
-- Go to the directory which holds this file run using this command:
-- open -n -a love .

-- https://github.com/Ulydev/push
push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

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

  love.window.setTitle('Pong')

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

  player1 = Paddle(1)
  player2 = Paddle(2)
  ball = Ball(BALL_RADIUS)
  ball:reset(false)
  
  gameState = 'start'
end

function love.update(dt)
  if love.keyboard.isDown('w') then
    player1.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('s') then
    player1.dy = PADDLE_SPEED
  else
    player1.dy = 0
  end

  if love.keyboard.isDown('up') then
    player2.dy = -PADDLE_SPEED
  elseif love.keyboard.isDown('down') then
    player2.dy = PADDLE_SPEED
  else
    player2.dy = 0
  end

  if gameState == 'play' then
    ball:update(dt)
  end

  player1:update(dt)
  player2:update(dt)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'
    end
    ball:reset(true)
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

  player1:render()
  player2:render()
  ball:render()

  displayFPS()

  push:apply('end')
end

function displayFPS()
  love.graphics.setFont(smallFont)
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end