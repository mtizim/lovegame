-- This one is huge but it needs to be
-- most methods and attributes are self explanatory
laserClass = Class("laser")

function laserClass:init( x, y, r,
                          width, height,
                          width_exploded, height_exploded,
                          time, remain_time,
                          collider)
    self.x, self.y = x, y
    self.rotation = r
    self.width, self.height = width, height
    self.width_exploded, self.height_exploded = width_exploded, height_exploded
    
   

    self.time_initial = time
    self.time_left = time
    self.remain_time = remain_time
    
    self.exploded = false
    self.destroyed = false
    
    self.collider = collider
    self.alpha = 0
    self.hc_object = nil
end

-- Changes state to exploded and adds the collision object
function laserClass:explode()
    self.exploded = true
    self.hc_object = self.collider:rectangle(self.x - self.width_exploded *
                                               settings.laser_exploded_width_multiplier
                                               /2,
                                             self.y - self.height_exploded/2,
                                             self.width_exploded * settings.laser_exploded_width_multiplier,
                                             self.height_exploded)
    self.hc_object:rotate(-self.rotation)
    self.time_left = self.remain_time
end

-- Now the linked list iterator function will know to unlink
-- the node the laser instance is contained in so it gets collected with the
-- garbage
function laserClass:destroy()
    self.destroyed = true
    if self.hc_object then
        self.collider:remove(self.hc_object)
    end
    self.hc_object = nil
end

-- Ticks the timer and explodes or destroys the laser
function laserClass:update(dt)

    self.color_array = themes[settings.theme].laser
    self.color_array_exploded = themes[settings.theme].laser_exploded

    self.time_left = self.time_left - dt
    -- so that minimum value is 0
    if self.time_left<0 and not self.exploded then self.time_left = 0 end
    if self.time_left==0 and not self.exploded then self:explode() end
    if self.time_left <= 0 and self.exploded then self:destroy() end
    --so that the collision can be quick
    if self.remain_time - self.time_left > settings.laser_collision_timer
       and self.hc_object then
        self.collider:remove(self.hc_object)
        self.hc_object = nil
    end 
    -- Ok this is the one bit of spaghetti i'll allow myself
    -- checks for collisions
    if self.hc_object then
        self:player_collision(application.current.player)
    end
end

-- The appropriate function for opacity
-- It's better than a linear fade away for me
-- basically 1 - x^2
function laserClass:alpha_function_exploded()
    local x = self.remain_time - self.time_left --time passed

    return 1 - ((x * x) / (self.remain_time * self.remain_time))
end

--Checks if the laser collides with the objects
function laserClass:player_collision(player)
    if player and self.hc_object:collidesWith(player.hc_object) then
        player.alive = false
    end
end

--Self explanatory
function laserClass:draw_exploded()
    self.alpha = self:alpha_function_exploded()
    self.color_array = self.color_array_exploded
    love.graphics.setColor(self.color_array[1],self.color_array[2],
                           self.color_array[3],self.alpha)
    rotatedRectangle("fill", self.x - self.width_exploded/2, 
                             self.y - self.height_exploded/2,
                             self.width_exploded, self.height_exploded, self.rotation)
end

--Self explanatory
function laserClass:draw_normal()
    -- fade in,linear
    self.alpha = 1 - (self.time_left / self.time_initial)
    love.graphics.setColor(self.color_array[1],self.color_array[2],
                           self.color_array[3],self.alpha)
    rotatedRectangle("fill", self.x - self.width/2,
                             self.y - self.height/2,
                             self.width, self.height, self.rotation)
end

--Calls the appropriate drawing function
function laserClass:draw()
    if not self.destroyed then
        if self.exploded then
            self:draw_exploded()
        else
            self:draw_normal()
        end
    end
end