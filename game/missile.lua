missileClass = Class("missile")


function missileClass:init( x, y,
                          remain_time,
                          collider)
    -- x and y are centers
    self.x, self.y = x, y
    self.rotation = 0
    self.vx = 0
    self.vy = 0
    self.ax = 0
    self.ay = 0

    self.width  = settings.missile_width
    self.height = settings.missile_height
    self.incut = settings.missile_incut
    self.disappear_time = settings.missile_disappear_time

    self.time_left = remain_time

    self.disappearing = false
    self.destroyed = false
    
    self.collider = collider
    self.alpha = 1
    local h = self.height
    local w = self.width 
    local incut = self.incut
    self.hc_object = collider:polygon(  self.x +w, self.y,
                                        self.x , self.y + incut,
                                        self.x - w, self.y,
                                        self.x, self.y + h)
end



function missileClass:destroy()
    self.destroyed = true
    if self.hc_object then
        self.collider:remove(self.hc_object)
    end
    self.hc_object = nil
end

function missileClass:start_disappearing()
    self.disappearing = true
    self.time_left = self.disappear_time
end

function missileClass:alpha_function()
    local x = (self.disappear_time - self.time_left) / self.disappear_time
    return (2 / (x + 1)) -1
end

function missileClass:update_position(dt,player)
    self.x = self.x + self.vx * dt
    self.y = self.y + self.vy * dt
    self.vx = self.vx + self.ax * dt
    self.vy = self.vy + self.ay * dt
    if self.hc_object then 
        self.hc_object:moveTo(self.x, self.y)
        self.hc_object:setRotation(- self.rotation + math.pi)
    end

    self.rotation = math.atan2(self.vx,self.vy)

    local player_dir = math.atan2( self.x - player.x, self.y - player.y)
    self.rotation = player_dir

    self.ax = - settings.missile_force_mul * math.sin(player_dir)
    self.ay =  - settings.missile_force_mul * math.cos(player_dir)
end

function missileClass:update(dt)
    self.time_left = self.time_left - dt
    -- so that minimum value is 0
    if self.time_left<0 then self.time_left = 0 end

    if self.time_left==0 and not self.disappearing then 
        self:start_disappearing()
    end
    if self.time_left == 0 and self.disappearing then self:destroy() end

    if self.disappearing then 
        self.alpha = self:alpha_function()
    end

    self:update_position(dt,application.current.player)
    
    if self.hc_object and not self.disappearing then
        self:player_collision(application.current.player)
    end
end


function missileClass:player_collision(player)
    if player and self.hc_object:collidesWith(player.hc_object) then
        player.alive = false
    end
end

function missileClass:draw()
    if not self.destroyed then
        local color = themes[settings.theme].missile
        love.graphics.setColor(color[1],color[2],color[3],self.alpha)
        -- if self.hc_object then self.hc_object:draw() end
        local triangles = self.hc_object._polygon:triangulate()
        love.graphics.polygon("fill",triangles[1]:unpack())
        love.graphics.polygon("fill",triangles[2]:unpack())

    end
end