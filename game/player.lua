-- A big one but it's the main thing 
playerClass = Class("Player")

function playerClass:init( x, y,
                           vx, vy,
                           ax, ay, size,
                           maxspeed, walldamp,
                           collider)
    self.x, self.y = x, y
    self.vx, self.vy = vx, vy
    self.ax, self.ay = ax, ay
    self.alive = true
    self.size = size
    self.maxspeed = maxspeed
    self.walldamp = walldamp
    self.collider = collider
    self.hc_object = collider:circle(x,y,size - settings.player_collision_size)
    self.score = 0
end

--Bounces off the wall
function playerClass:bounce_x()
    self.vx = self.vx * (-1) * self.walldamp
end

function playerClass:bounce_y()
    self.vy = self.vy * (-1) * self.walldamp
end

--Self explanatory
function playerClass:move(x,y)
    self.x , self.y = x, y
end

--Check bounds and calls the bounce functions
function playerClass:check_bounds_rect_bounce(box_array)
    local top_y = box_array[1]
    local bottom_y = box_array[2]
    local left_x = box_array[3]
    local right_x = box_array[4]
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

--So that the speed is limited
function playerClass:normalize_speed()
    local speed =  math.sqrt(self.vx*self.vx + self.vy*self.vy)
    if speed and speed > self.maxspeed then
        self.vx = self.vx * self.maxspeed / speed
        self.vy = self.vy * self.maxspeed / speed
    end
end

--Updates the whole thing
function playerClass:update(dt,box_array)
    self:move(self.x + self.vx * dt,
              self.y + self.vy * dt)
    self.hc_object:moveTo(self.x, self.y)
    self.vx = self.vx + self.ax * dt
    self.vy = self.vy + self.ay * dt
    self:normalize_speed()
    self:check_bounds_rect_bounce(box_array)
    
end

-- Draws the player
function playerClass:draw(color_array)
    love.graphics.setColor(color_array)
    -- if self.hc_object then self.hc_object:draw() end
    local rot = math.atan2(self.vx,self.vy)
    player_draw:draw(self.x,self.y,rot,self.size)
end
