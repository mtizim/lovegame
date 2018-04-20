laserClass = Class()

function laserClass:init( x, y, r,
                          width, height,
                          width_exploded, height_exploded,
                          time, remain_time)
    self.x, self.y = x, y
    self.rotation = r
    self.width, self.height = width, height
    self.width_exploded, self.height_exploded = width_exploded, height_exploded
    self.time_left = time
    self.remain_time = remain_time
    self.exploded = false
    self.destroyed = false
end

function laserClass:explode( )
    self.exploded = true
    self.time_left = self.remain_time
end

function laserClass:destroy()
    self.destroyed = true
end

function laserClass:update(dt)
    self.time_left = self.time_left - dt
    -- so that minimum value is 0
    if self.time_left<0 and not self.exploded then self.time_left = 0 end
    if self.time_left==0 and not self.exploded then self:explode() end

    if self.time_left <= 0 and self.exploded then self:destroy() end
end

function laserClass:draw_exploded()
    rotatedRectangle("fill", self.x, self.y, self.width_exploded, self.height_exploded, self.rotation)
end

function laserClass:draw_normal()
    rotatedRectangle("fill", self.x, self.y, self.width, self.height, self.rotation)
end

function laserClass:draw( color_array, color_array_exploded )
    if not self.destroyed then
        if self.exploded then color_array = color_array_exploded end
        love.graphics.setColor(color_array)
        if self.exploded then
            self:draw_exploded()
        else
            self:draw_normal()
        end
    end
end