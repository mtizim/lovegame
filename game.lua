gameClass = Class()

function gameClass:init()
    local x, y = window_width/2, window_height/2

    --settings are applied here
    self.offset = settings.offset
    self.laser_stay = settings.laser_stay_base
    self.laser_disappear = settings.laser_disappear_base
    self.theme = themes[settings.theme]
    self.laser_every = settings.laser_every_base
                          --top, bottom,left,right
    self.bounding_box = { settings.offset, window_height - settings.offset,
                          settings.offset, window_width  - settings.offset}
    self.player = playerClass( x, y,
                               settings.player_start_vx, settings.player_start_vy,
                               0, 0, settings.player_size, 
                               settings.player_maxspeed,settings.walldamp)
    
    --initializing appropriate things
    self.enemies = linkedlistClass()

    self.game_controller = gamecontrollerClass(settings.controller_size,
                                               settings.controller_mul)

    self.laser_every_timer = 0

end

--Calculates the random position pointing at the player
--adds the newly made laser to the list
function gameClass:new_laser(width,height,time,r_time,color,explodedcolor)
    local x = math.random( 2 * self.offset, window_width - 2 * self.offset )
    local y = math.random( 2 * self.offset, window_height - 2 * self.offset)
    local r = math.atan2( x - self.player.x, y - self.player.y)
    local laser = laserClass(x,y,r,
                             width,height,
                             width, height * 100,
                             time,r_time,
                             color,explodedcolor)
    self.enemies:add(laser)
end


--Just draws the boundaries
function gameClass:draw_boundaries(colorArray)
    love.graphics.setColor(colorArray)
    love.graphics.rectangle("fill",0,0,window_width, self.offset)
    love.graphics.rectangle("fill",0,window_height,window_width, -self.offset)
    love.graphics.rectangle("fill",0,0,self.offset,window_height)
    love.graphics.rectangle("fill",window_width,0,-self.offset,window_height)
end

--Updates appropriate objects
function gameClass:update(dt)
    --joystick reaction
    self.player.ax,self.player.ay = self.game_controller:update()
    self.player:update(dt,self.bounding_box)
    -- so that a laser is only spawned once every
    --                                 timer seconds
    self.laser_every_timer = self.laser_every_timer + dt
    if self.laser_every_timer >= self.laser_every then
        collectgarbage()
        self:new_laser(settings.laser_width,100,self.laser_stay,self.laser_disappear,
                       self.theme.laser,self.theme.laser_exploded)
        self.laser_every_timer = 0
    end
    -- update all lasers and remove destroyed ones
    self.enemies:update_forall(dt)
    self.enemies:remove_destroyed()
end

--Self explanatory
function gameClass:draw_background()
    love.graphics.setColor(self.theme.background)
    love.graphics.rectangle("fill",0,0,window_width,window_height)
end

--Self explanatory
function gameClass:destroy()
    hc.remove(self.player.hc_object)
    hc.resetHash()
end

--Draws appropriate objects
function gameClass:draw()
    self:draw_background()
    self.player:draw(self.theme.player)
    self.enemies:draw_forall()
    self.game_controller:draw(self.theme.controller,settings.controller_dotradius,
                              self.theme.controller,settings.controller_line,
                              self.theme.controller_alpha)
    self:draw_boundaries(self.theme.boundaries)
end