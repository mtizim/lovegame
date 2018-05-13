pl_model_btnClass = Class("playermode_button")

-- a backgroundless button because i like those
function pl_model_btnClass:init(x,y,w,playermodel,mode,
                          dest_time,dest_x,dest_y)
    self.x = x
    self.y = y
    self.width = w
    self.begin = {x,y}
    self.dest_time = dest_time
    self.dest_x = dest_x
    self.dest_y = dest_y
    self.time = 0
    self.rot = 0
    self.enabled = true
    self.playermodel = playermodel
    self.playermodel_mode = mode
end

function pl_model_btnClass:interpolate(dt)
    self.x = self.begin[1] + 
            (self.dest_x - self.begin[1])*self.time/self.dest_time
    self.y = self.begin[2] + 
            (self.dest_y - self.begin[2])*self.time/self.dest_time
    self.time = self.time + dt
end

function pl_model_btnClass:revert()
    self.time = 0
    local t_begin = {self.begin[1],self.begin[2]}
    self.begin = {self.dest_x,self.dest_y}
    self.dest_x,self.dest_y = t_begin[1],t_begin[2]
end

function pl_model_btnClass:update(dt)
    self.rot = self.rot + dt * 0.2 * 3.14 % 6.28
    local press_state
    local press_x
    local press_y
    if osString=="Windows" or osString=="Linux" or osString=="OS X" then
        press_state = love.mouse.isDown(1)
        press_x, press_y = love.mouse.getPosition()
    else
        press_state = not not first
        if first then
            press_x, press_y = love.touch.getPosition(first)
        end
    end

    if self.enabled and press_state and
       press_x > self.x and press_x < self.x + self.width and
       press_y > self.y and press_y < self.y + self.width
       and (not button_cooldown or button_cooldown < 0) then
            button_cooldown = settings.button_cooldown
            settings.player_model = self.playermodel 
            save_settings()
    end
    if self.time < self.dest_time then
        self:interpolate(dt)
    else
        self.time = self.dest_time + 1
        self.x = self.dest_x
        self.y = self.dest_y
    end
end

function pl_model_btnClass:draw(color, model_size)
    love.graphics.setColor(color)
    love.graphics.setLineWidth(settings.pl_btn_line_width)
    -- love.graphics.rectangle("line",self.x,self.y,self.width,self.width)
    drawable[self.playermodel].draw(self.x + self.width/2,
                               self.y + self.width/2,
                               self.rot,model_size,self.playermodel_mode)
end
