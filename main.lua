Class = require("30log")
hc = require("hardoncollider")

require("game")
require("app")
require("helpers")
require("laser")
require("player")
require("gameController")
math.randomseed(os.time())

osString = love.system.getOS( )
window_width, window_height = love.graphics.getDimensions()


DEBUG = false
STEPTIME = 0
DISPLAY_FRAMES = false


function love.load()
    
    application:init()
    
    if DEBUG then
        local clock = os.clock
        function sleep(n)  -- seconds
            local t0 = clock()
            while clock() - t0 <= n do end
        end
    end
end

if DISPLAY_FRAMES then delta_time, total_time = 0 , 0 end

function love.update(dt)

    application:update(dt)


    if DISPLAY_FRAMES then delta_time = dt; total_time =total_time + dt end
    if DEBUG then sleep(STEPTIME) end
end

function love.draw()

    application:draw()


    if DISPLAY_FRAMES then love.graphics.print(1/delta_time,30,10);
                           love.graphics.print(total_time,400,10) end
    if DEBUG then
        -- love.graphics.print(tostring(laser.exploded), 30, 30)
        -- love.graphics.print(game.laser.x, 30, 50)
        -- love.graphics.print(game.laser.y, 30, 70)
        -- love.graphics.print(game.laser.rotation, 30, 90)
    end

end