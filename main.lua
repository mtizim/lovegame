Class = require("dependencies.30log")
hc = require("dependencies.hardoncollider")
polygon = require("dependencies.hardoncollider.polygon")
-- inspect = require("inspect")

osString = love.system.getOS( )
if osString == "Web" then
    -- Some small fakery
    osString = "Windows"
end

window_width, window_height = love.graphics.getDimensions()
max = 2 * math.sqrt(window_height ^ 2 + window_width ^2)

require("misc.themes")
require("misc.settings")

require("app")
require("game.game")
require("game.gameover")
require("game.gameController")
require("game.collectible")
require("game.coin")
require("misc.helpers")
require("menus.game_background")
require("menus.change_player_button")
require("menus.theme_button")
require("menus.visual_menu")
require("menus.main_menu")
require("menus.button")
require("game.laser")
require("game.missile")
require("game.triple_laser")
require("game.inverted_laser")
require("game.rotating_laser")
require("menus.player_draw")
require("game.player")
require("misc.keypressed")
require("misc.lock")



math.randomseed(os.time())

function empty() end

DEBUG = false
STEPTIME = 0
DISPLAY_FRAMES = false



function love.load()

    coin_image = love.graphics.newImage("coin.png")
    settings.coin_font_size = coin_image:getHeight() * settings.coin_scale
    coin_font = love.graphics.newFont(settings.font,settings.coin_font_size)

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
    -- dt = dt*10
    -- print(collectgarbage("count"))
    application:update(dt)
    -- print(collectgarbage("count"))

    if DISPLAY_FRAMES then delta_time = dt; total_time =total_time + dt end
    if DEBUG then
        sleep(STEPTIME)
        print(collectgarbage("count"))
    end
end
-- for the lulz
-- xxxx = 0
function love.draw()

    love.graphics.scale(sx,sy)
    -- for the lulz
    -- xxxx = xxxx + 0.002
    -- love.graphics.translate(window_width/2,window_height/2)
    -- love.graphics.rotate(xxxx,window_height/2,window_width/2)
    -- love.graphics.translate(-window_width/2,-window_height/2)
    application:draw()

    if DISPLAY_FRAMES then
        love.graphics.setColor({1,1,1})
        love.graphics.print(1/delta_time,30,10);
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

