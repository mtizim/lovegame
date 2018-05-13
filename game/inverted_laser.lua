inverted_laserClass = Class("inverted_laser")

function inverted_laserClass:init( x, y, r,
                          time, remain_time,
                          collider)
    self.x, self.y = x, y
    self.rotation = r

    self.time_initial = time
    self.time_left = time
    self.remain_time = remain_time
    
    self.exploded = false
    self.destroyed = false
    
    self.collider = collider
    self.alpha = 0
    self.hc_objects = {nil,nil}
end

function inverted_laserClass:alpha_function_exploded()
    local x = self.remain_time - self.time_left --time passed
    return 1 - ((x * x) / (self.remain_time * self.remain_time))
end

function inverted_laserClass:explode()
    self.exploded = true
    self.hc_objects[1] = self.collider:rectangle( self.x -
            settings.inverted_laser_width - settings.inverted_laser_gap / 2 ,
        self.y - settings.inverted_laser_length / 2,
        settings.inverted_laser_width - settings.laser_exploded_width_red,
        settings.inverted_laser_length)
    self.hc_objects[2] = self.collider:rectangle( self.x +
            settings.inverted_laser_gap/2 + settings.laser_exploded_width_red,
        self.y - settings.inverted_laser_length / 2,
        settings.inverted_laser_width - settings.laser_exploded_width_red,
        settings.inverted_laser_length)
    self.hc_objects[1]:rotate(-self.rotation ,self.x,self.y)
    self.hc_objects[2]:rotate(-self.rotation ,self.x,self.y)
    self.time_left = self.remain_time
end

function inverted_laserClass:destroy()
    self.destroyed = true
    if self.hc_objects[1] then
        self.collider:remove(self.hc_objects[1])
        self.collider:remove(self.hc_objects[2])
    end
    self.hc_objects[1] = nil
    self.hc_objects[2] = nil
end


function inverted_laserClass:update(dt)
    self.time_left = self.time_left - dt
    -- so that minimum value is 0
    if self.time_left<0 and not self.exploded then self.time_left = 0 end
    if self.time_left==0 and not self.exploded then self:explode() end
    if self.time_left <= 0 and self.exploded then self:destroy() end
    --so that the collision can be quick
    if self.remain_time - self.time_left > settings.laser_collision_timer
       and self.hc_objects[1] then
        self.collider:remove(self.hc_objects[1])
        self.collider:remove(self.hc_objects[2])
        self.hc_objects[1] = nil
        self.hc_objects[2] = nil
    end 
    if self.hc_objects[1] then
        self:player_collision(application.current.player)
    end
end


function inverted_laserClass:player_collision(player)
    if player and (self.hc_objects[1]:collidesWith(player.hc_object) or
                  self.hc_objects[2]:collidesWith(player.hc_object)) then
        player.alive = false
    end
end

-- this will be problematic but ok
-- graphics pop and rotate for sure
function inverted_laserClass:draw_rectangles() 
    love.graphics.push()
        love.graphics.translate(self.x,self.y)
        love.graphics.rotate( - self.rotation)
        love.graphics.rectangle("fill", - settings.inverted_laser_width  -
                settings.inverted_laser_gap /2,
            - settings.inverted_laser_length / 2,
            settings.inverted_laser_width, settings.inverted_laser_length)
        love.graphics.rectangle("fill", settings.inverted_laser_gap / 2,
            - settings.inverted_laser_length / 2,
            settings.inverted_laser_width, settings.inverted_laser_length)
    love.graphics.pop()
end


function inverted_laserClass:draw_exploded()
    self.alpha = self:alpha_function_exploded()
    local color_array = themes[settings.theme].laser_exploded
    love.graphics.setColor(color_array[1],color_array[2],
                           color_array[3],self.alpha)
    self:draw_rectangles()
end

function inverted_laserClass:draw_normal()
    self.alpha = 1 - (self.time_left / self.time_initial)
    local color_array = themes[settings.theme].laser
    love.graphics.setColor(color_array[1],color_array[2],
                           color_array[3],self.alpha)
    self:draw_rectangles()
end

function inverted_laserClass:draw()
    -- if self.hc_objects[1] then
        -- self.hc_objects[1]:draw()
        -- self.hc_objects[2]:draw()
    -- end
    if not self.destroyed then
        if self.exploded then
            self:draw_exploded()
        else
            self:draw_normal()
        end
    end
end