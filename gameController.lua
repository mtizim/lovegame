gamecontrollerClass = Class()

function gamecontrollerClass:init(size,multiplier)
    self.size = size
    self.multiplier = multiplier
    self.pressed = {}
    self.pressed.bool = false
    self.pressed.x , self.pressed.y= 0
end

--Calculates the appropriate accelerations
-- both ifs are the same thing for different platforms
function gamecontrollerClass:update(dt)
    --windows/linux
    if osString == "Windows " or osString =="Linux" or osString =="OS X" then
        local mouse_state = love.mouse.isDown(1)
        if (not self.pressed.bool) and mouse_state then
            self.pressed.bool = true
            -- position at which the mouse was first pressed
            self.pressed.x,self.pressed.y = love.mouse.getPosition()
            return 0,0
        elseif mouse_state then
            local x,y = love.mouse.getPosition()
            -- deviations from the center of the first press
            local delta_y,delta_x = y - self.pressed.y,x - self.pressed.x
            -- conversion into radial coordinates
            local theta = math.atan2(delta_x,delta_y)
            -- so that the max vaule of r is for deviation of radius size
            local r = math.min(math.sqrt( delta_x*delta_x + delta_y*delta_y ),
                               self.size)
            -- then return of appropriate values given the radial coords
            -- changing into cartesian
            local ax,ay = math.sin(theta)*r,math.cos(theta)*r
            -- adjustments
            local ax = ax * self.multiplier / self.size
            local ay = ay * self.multiplier / self.size
            return ax,ay
        elseif not mouse_state then
            self.pressed.bool = false
            return nil,nil
        end
    -- android/ios
    -- same things as above won't bother commenting twice
    else
        local mouse_state = first
        if (not self.pressed.bool) and mouse_state then
            self.pressed.bool = true
            self.pressed.x,self.pressed.y = love.touch.getPosition(first)
            return 0,0
        elseif mouse_state then
            local x,y = love.touch.getPosition(first)
            local delta_y,delta_x = y - self.pressed.y,x - self.pressed.x
            local theta = math.atan2(delta_x,delta_y)
            local r = math.min(math.sqrt( delta_x*delta_x + delta_y*delta_y ),
                                          self.size)
            local ax,ay = math.sin(theta)*r,math.cos(theta)*r
            ax = ax * self.multiplier / self.size
            ay = ay * self.multiplier / self.size
            return ax,ay
        elseif not mouse_state then
            self.pressed.bool = false
            return 0,0
        end
    end
end

function gamecontrollerClass:draw(inner_circle,size,outer_circle,line_width,alpha)
    if self.pressed.bool then
        --inner
        love.graphics.setColor(inner_circle[1],inner_circle[2],inner_circle[3],alpha)
        love.graphics.circle("fill",self.pressed.x,self.pressed.y,size)
        --outer
        love.graphics.setColor(outer_circle[1],outer_circle[2],outer_circle[3],alpha)
        love.graphics.setLineWidth(line_width)
        love.graphics.circle("line",self.pressed.x,self.pressed.y,self.size)
    end
end