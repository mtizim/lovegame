gamecontrollerClass = Class()

function gamecontrollerClass:init(size,multiplier)
    self.size = size
    self.multiplier = multiplier
    self.pressed = {}
    self.pressed.bool = false
    self.pressed.x , self.pressed.y= 0
end

function gamecontrollerClass:update(dt)
    if osString == "Windows " or osString =="Linux" then
        local mouse_state = love.mouse.isDown(1)
        if (not self.pressed.bool) and mouse_state then
            self.pressed.bool = true
            self.pressed.x,self.pressed.y = love.mouse.getPosition()
            return 0,0
        elseif mouse_state then
            local x,y = love.mouse.getPosition()
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

function gamecontrollerClass:draw(inner_circle,size,outer_circle,line_width)
    if self.pressed.bool then
        love.graphics.setColor(inner_circle)
        love.graphics.circle("fill",self.pressed.x,self.pressed.y,size)
        love.graphics.setColor(outer_circle)
        love.graphics.setLineWidth(line_width)
        love.graphics.circle("line",self.pressed.x,self.pressed.y,self.size)
    end
end