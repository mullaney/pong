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

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  smallFont = love.graphics.newFont('font.ttf', 24)
  love.graphics.setFont(smallFont)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()

  push:apply('start')

  love.graphics.clear(40, 45, 52, 255)

  love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

  love.graphics.rectangle('fill', PADDLE_DIST_FROM_EDGE, PADDLE_LENGTH, PADDLE_WIDTH, PADDLE_LENGTH)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - PADDLE_DIST_FROM_EDGE - PADDLE_WIDTH, VIRTUAL_HEIGHT - PADDLE_LENGTH * 2, PADDLE_WIDTH, PADDLE_LENGTH)
  love.graphics.circle('fill', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, BALL_RADIUS)

  push:apply('end')
end
