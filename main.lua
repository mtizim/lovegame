class = require("30log")

local player = require("player")


local playerClass = Class("Player")
-- Where the whole player object will go
function playerClass:init(x,y)
    self.x, self.y = x, y
    self.vx, self.vy = 0, 0
    self.state = "Alive"
end

function playerClass:bounce_x()
    self.vx = self.vx * (-1)
end

function playerClass:bounce_y()
    self.vy = self.vy * (-1)
end


local player = playerClass()

function love.load()

end

function love.update(dt)

end

function love.draw()
    -- love.graphics.print("xdddd",50,50)
end