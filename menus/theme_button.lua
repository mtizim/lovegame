theme_btnClass = Class("theme_button")

-- a backgroundless button because i like those
function theme_btnClass:init(x,y,w,theme_number,
                          dest_time,dest_x,dest_y)
    self.x = x
    self.y = y
    self.width = w
    self.begin = {x,y}
    self.dest_time = dest_time
    self.dest_x = dest_x
    self.dest_y = dest_y
    self.time = 0
    self.enabled = true
    self.theme_number = theme_number
end

function theme_btnClass:interpolate(dt)
    self.x = self.begin[1] + 
            (self.dest_x - self.begin[1])*self.time/self.dest_time
    self.y = self.begin[2] + 
            (self.dest_y - self.begin[2])*self.time/self.dest_time
    self.time = self.time + dt
end

function theme_btnClass:revert()
    self.time = 0
    local t_begin = {self.begin[1],self.begin[2]}
    self.begin = {self.dest_x,self.dest_y}
    self.dest_x,self.dest_y = t_begin[1],t_begin[2]
end

function theme_btnClass:update(dt)
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

    if self.enabled and press_state  and self.unlocked and
       press_x > self.x and press_x < self.x + self.width and
       press_y > self.y and press_y < self.y + self.width
       and (not button_cooldown or button_cooldown < 0) then
            button_cooldown = settings.button_cooldown

            settings.theme_number = self.theme_number
            settings.theme = theme_names[settings.theme_number]
            -- change the visible ones
            application.current.theme = themes[settings.theme]
            application.current.game_bg.theme = themes[settings.theme]
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

function theme_btnClass:draw(model_size)
    love.graphics.setLineWidth(settings.pl_btn_line_width)
    -- love.graphics.rectangle("line",self.x,self.y,self.width,self.width)
    if self.unlocked then 
        love.graphics.setColor(themes[theme_names[self.theme_number]].primary)
        love.graphics.polygon("fill",self.x,self.y,self.x + self.width,self.y,self.x,self.y + self.width)
        love.graphics.setColor(themes[theme_names[self.theme_number]].secondary)
        love.graphics.polygon("fill",self.x + self.width ,self.y + self.width,
                        self.x + self.width,self.y,self.x,self.y + self.width)
        local lw = love.graphics.getLineWidth() /2
        love.graphics.rectangle("line",self.x + lw ,self.y + lw,
                self.width - lw,self.width - lw)
    else
        -- yo magic number here and it's not gonna make it to the settings
        draw_lock(self.x + self.width/2,
                  self.y + self.width/2,model_size * 2)
    end
end
