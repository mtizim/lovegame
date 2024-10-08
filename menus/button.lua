buttonClass = Class("button")

-- a backgroundless button because i like those
function buttonClass:init(x,y,text,font,alpha,action,
                          dest_time,dest_x,dest_y)
    self.x = x
    self.y = y
    self.text = text
    self.begin = {x,y}
    self.size = settings.menu_button_font_size
    self.font = font
    self.width = font:getWidth(text)
    self.alpha = alpha
    self.action = action
    self.dest_time = dest_time
    self.dest_x = dest_x
    self.dest_y = dest_y
    self.dest_x_preserve = dest_x
    self.time = 0
    self.enabled = true
end

function buttonClass:interpolate(dt)
    self.x = self.begin[1] +
            (self.dest_x - self.begin[1])*self.time/self.dest_time
    self.y = self.begin[2] +
            (self.dest_y - self.begin[2])*self.time/self.dest_time
    self.time = self.time + dt
end

function buttonClass:revert()
    self.x,self.y = self.dest_x,self.dest_y
    self.time = 0
    local t_begin = {self.begin[1],self.begin[2]}
    self.begin = {self.dest_x,self.dest_y}
    self.dest_x,self.dest_y = t_begin[1],t_begin[2]
    self.dest_x_preserve = self.dest_x
end

function buttonClass:update(dt)
    self.color = themes[settings.theme].menu_button
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
       press_y > self.y and press_y < self.y + self.size then
            self.action()
    end
    if self.time < self.dest_time then
        self:interpolate(dt)
    else
        self.time = self.dest_time + 1
        self.x = self.dest_x
        self.y = self.dest_y
    end
end

function buttonClass:draw(givencolor,bordersize)
    outlinecolor = themes[theme_names[settings.theme_number]].background
    bordersize = bordersize or 1
    if self.color or givencolor then
        if givencolor then self.color = givencolor end
        if outlinecolor then self.outlinecolor = outlinecolor end
        love.graphics.setFont(self.font)
        love.graphics.setColor(self.outlinecolor[1],self.outlinecolor[2],
                               self.outlinecolor[3],self.alpha)

        love.graphics.print(self.text,self.x - bordersize, self.y)
        love.graphics.print(self.text,self.x + bordersize, self.y)
        love.graphics.print(self.text,self.x, self.y + bordersize)
        love.graphics.print(self.text,self.x, self.y - bordersize)

        love.graphics.setColor(self.color[1],self.color[2],self.color[3],self.alpha)
        love.graphics.print(self.text,self.x,self.y)
    end
end


function buttonClass:update_textshift()
    self.dest_x = self.dest_x_preserve - self.font:getWidth(self.text)
end

