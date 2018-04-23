Class = require("30log")
hc = require("hardoncollider")

require("helpers")
require("laser")
require("player")


DEBUG = true
STEPTIME = 0
DISPLAY_FRAMES = true

function love.load()
    local x, y = 30, 100
    local vx, vy = 7, 3
    local ax, ay = 0,0
    local size = 15

    player = playerClass( x, y,
                         vx, vy,
                         ax, ay, size)
               
    laser = laserClass(x, y, math.pi,
                       10, 50,
                       20, 80,
                       6, 6)

    if DEBUG then
        local clock = os.clock
        function sleep(n)  -- seconds
            local t0 = clock()
            while clock() - t0 <= n do end
        end
    end
end

if DISPLAY_FRAMES then delta_time, total_time = 0 ,0 end

function love.update(dt)
    player:update(dt,{0,500,0,500})

    laser:update(dt)

    laser.rotation = laser.rotation + 1/50

    if DISPLAY_FRAMES then delta_time = dt; total_time =total_time + dt end
    if DEBUG then sleep(STEPTIME) end
end

function love.draw()
    player:draw({1,0,0})

    laser:draw({1,0,0},{0,1,1})

    if DISPLAY_FRAMES then love.graphics.print(1/delta_time,30,10);
                           love.graphics.print(total_time,400,10) end
    if DEBUG then
        -- love.graphics.print(tostring(laser.exploded), 30, 30)
        love.graphics.print(laser.x, 30, 50)
        love.graphics.print(laser.y, 30, 70)
        love.graphics.print(laser.rotation, 30, 90)
    end

end