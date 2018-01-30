-- Pong remake based on Colten Ogden's tutorial c/o cs50 @harvard

-- To run you will need love2d @ http://love2d.org/
-- Go to the directory which holds this file run using this command:
-- open -n -a love '/my/path/to/files'

-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
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

  push.apply('start')

  love.graphics.printf(
    'Hello Pong!',
    0,
    WINDOW_HEIGHT / 2 - 6,
    WINDOW_WIDTH,
    'center'
  )

  push.apply('end')
end
