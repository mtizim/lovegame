laserClass = Class()

function laserClass:init( x, y
                          time, remain_time)
    self.x, self.y = x, y
    self.time_left = time
    self.exploded = false
    self.destroyed = false
    self.remain_time = remain_time
end

function laserClass:explode( )
    self.exploded = true
    self.time_left = self.remain_time
end

function laserClass:destroy()
    self.destroyed = true
end

function laserClass:update(dt)
    time_left = time_left - dt
    -- so that minimum value is 0
    if time_left<0 and not self.exploded then time_left = 0 end
    if time_left=0 and not self.exploded then laserClass:explode()

    if time_left <= 0 and self.exploded then self:destroy() end
end

function laserClass:draw_exploded()

end

function laserClass:draw_normal()

end

function laserClass:draw( color_array )
    love.graphics.setColor(color_array)
    if self.exploded then
        self:draw_exploded()
    else
        self:draw_normal()
    end
end