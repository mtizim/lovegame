playerClass = Class("Player")

local function sgn(x)
    if x < 0 then return -1 end
    if x > 0 then return 1 end
    if x == 0 then return 0 end
end

function playerClass:init( x, y,
                           vx, vy,
                           ax, ay, size)
    self.x, self.y = x, y
    self.vx, self.vy = vx, vy
    self.ax, self.ay = ax, ay
    self.state = "alive"
    self.size = size
    self.hc_object = hc.circle(x,y,size)
end

function playerClass:bounce_x()
    self.x = self.x - self.vx
    self.vx = self.vx * (-1)
end

function playerClass:bounce_y()
    self.y = self.y - self.vy
    self.vy = self.vy * (-1)
end

function playerClass:move(x,y)
    self.x , self.y = x, y
end

function playerClass:check_bounds_rect_bounce(top_y, bottom_y, left_x, right_x)
    if self.y <= top_y or self.y >= bottom_y then
        self:bounce_y()
    end
    if self.x<=left_x or self.x>=right_x then
        self:bounce_x()
    end
end

function playerClass:update(dt,box_array)
    self:move(self.x + self.vx,
              self.y + self.vy)

    self.hc_object:moveTo(self.x, self.y)
    self.vx = self.vx + self.ax
    self.vy = self.vy + self.ay
    
    self:check_bounds_rect_bounce(box_array[1], box_array[2],
                                  box_array[3], box_array[4])
    
end

function playerClass:draw(color_array)
    -- For now it's a circle
    love.graphics.setColor(color_array)
    love.graphics.circle("fill",self.x ,self.y , self.size)
end


return playerClass