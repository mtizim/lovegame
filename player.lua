playerClass = Class("Player")

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
    self.vx = self.vx * (-1)
end

function playerClass:bounce_y()
    self.vy = self.vy * (-1)
end

function playerClass:move(x,y)
    self.x , self.y = x, y
end

function playerClass:check_bounds_rect_bounce(top_y, bottom_y, left_x, right_x)
    if self.y <= top_y then
        self:bounce_y()
        self:move(self.x, top_y)
    else if self.y >= bottom_y then
        self:bounce_y()
        self:move(self.x, bottom_y)
    end end
    if self.x<=left_x then
        self:bounce_x()
        self:move(left_x, self.y)
    else if self.x>=right_x then
        self:bounce_x()
        self:move(right_x, self.y)
    end end
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