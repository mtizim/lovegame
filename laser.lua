-- This one is huge but it needs to be
-- most methods and attributes are self explanatory
laserClass = Class("laser")

function laserClass:init( x, y, r,
                          width, height,
                          width_exploded, height_exploded,
                          time, remain_time,
                          color_array, color_array_exploded)
    self.x, self.y = x, y
    self.rotation = r
    self.width, self.height = width, height
    self.width_exploded, self.height_exploded = width_exploded, height_exploded
    
    self.color_array = color_array
    self.color_array_exploded = color_array_exploded

    self.time_left = time
    self.remain_time = remain_time
    
    self.exploded = false
    self.destroyed = false
    
    self.alpha = 1
    self.hc_object = nil
end

-- Changes state to exploded and adds the collision object
function laserClass:explode()
    self.exploded = true
    self.hc_object = hc.rectangle(self.x + self.width_exploded/2,
                                  self.y + self.height_exploded/2,
                                  self.width, self.height)
    self.time_left = self.remain_time
end

-- Now the linked list iterator function will know to unlink
-- the node the laser instance is contained in so it gets collected with the
-- garbage
function laserClass:destroy()
    self.destroyed = true
    hc.remove(self.hc_object)
end

-- Ticks the timer and explodes or destroys the laser
function laserClass:update(dt)
    self.time_left = self.time_left - dt
    -- so that minimum value is 0
    if self.time_left<0 and not self.exploded then self.time_left = 0 end
    if self.time_left==0 and not self.exploded then self:explode() end

    if self.time_left <= 0 and self.exploded then self:destroy() end
end

-- The appropriate function for opacity
-- It's better than a linear fade away for me
-- basically 1 - x^2
function laserClass:alpha_function_exploded()
    local x = self.remain_time - self.time_left --time passed

    return 1 - ((x * x) / (self.remain_time * self.remain_time))
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
    love.graphics.setColor(self.color_array)
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