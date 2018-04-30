Class = require("dependencies.30log")
hc = require("dependencies.hardoncollider")
-- inspect = require("inspect")


require("app")
require("game")
require("gameController")
require("collectible")
require("helpers")
require("laser")
require("player")
require("themes")
require("settings")
math.randomseed(os.time())

osString = love.system.getOS( )
window_width, window_height = love.graphics.getDimensions()

settings.font_size = window_height 
font = love.graphics.newFont("Geo.otf",settings.font_size)
love.graphics.setFont(font)

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
    if DEBUG then
        sleep(STEPTIME)
        print(collectgarbage("count"))
    end
end

function love.draw()

    application:draw()


    if DISPLAY_FRAMES then 
        love.graphics.setColor({1,1,1})
        love.graphics.print(1/delta_time,30,10);
        love.graphics.print(total_time,400,10) 
    end
    if DEBUG then
        -- love.graphics.print(tostring(laser.exploded), 30, 30)
        -- love.graphics.print(game.laser.x, 30, 50)
        -- love.graphics.print(game.laser.y, 30, 70)
        -- love.graphics.print(game.laser.rotation, 30, 90)
    end

end

--I only ever need the first touch
-- so this function gives me the fist touch 
-- as a global first
first = nil
function love.touchpressed(id, x, y)
  if not first then first = id end
end
function love.touchreleased(id, x, y)
  if id == first then first = nil end
end

