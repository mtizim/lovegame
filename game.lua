gameClass = Class()

function gameClass:init()
    --initializing appropriate things
    
    local x, y = window_width/2, window_height/2
    self.enemies = linkedlistClass()
    self.collider = hc.new()
    self.pressed_before_bool = false
    self.game_controller = gamecontrollerClass(settings.controller_size,
                                               settings.controller_mul)
    self.laser_every_timer = 0
    -- is it the first time showing the gameover screen?
    self.first_gameover_update_bool = true
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
                               settings.player_maxspeed,settings.walldamp,
                               self.collider)
    

end

--Calculates the random position pointing at the player
--adds the newly made laser to the list
function gameClass:new_laser(width,height,time,r_time,color,explodedcolor)
    local x = math.random( 2 * self.offset, window_width - 2 * self.offset )
    local y = math.random( 2 * self.offset, window_height - 2 * self.offset)
    local r = math.atan2( x - self.player.x, y - self.player.y) + math.random() * settings.laser_random_r_deviation * 2 
                                                                  - settings.laser_random_r_deviation
    local laser = laserClass(x,y,r,
                             width,height,
                             width, height * 100,
                             time,r_time,
                             color,explodedcolor,
                             self.collider)
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

function gameClass:update_normal(dt,ax,ay)
    self.player.ax = ax or 0 
    self.player.ay = ay or 0
    self.player:update(dt,self.bounding_box)
    -- so that a laser is only spawned once every
    --                                 timer seconds
    self.laser_every_timer = self.laser_every_timer + dt
    if self.laser_every_timer >= self.laser_every then
        collectgarbage()
        self:new_laser(settings.laser_width,settings.laser_height,self.laser_stay,self.laser_disappear,
                    self.theme.laser,self.theme.laser_exploded)
        self.laser_every_timer = 0
    end
    -- update all lasers and remove destroyed ones
    self.enemies:update_forall(dt)
    self.enemies:remove_destroyed()
end

function gameClass:update_gameover(dt,ax,ay)
    -- display score
    -- maybe time played
    -- max score but i have to implement that
    -- definitely need to save max score here
    local pressed
    if osString == "Windows " or osString =="Linux" or osString =="OS X" then
        pressed = love.mouse.isDown(1)
    else
        pressed = not not first -- cast too boolean
    end

    if pressed and not self.pressed_before_bool then
        application:restart_game()
    end
end

function gameClass:update_touch()
    if osString == "Windows " or osString =="Linux" or osString =="OS X" then
        self.pressed_before_bool = love.mouse.isDown(1)
    else
        self.pressed_before_bool = not not first -- cast to boolean
    end
end

--Updates appropriate objects
function gameClass:update(dt)
    --joystick reaction
    if self.player.alive then
        local ax,ay = self.game_controller:update()
        self:update_normal(dt,ax,ay)
    else
        self.game_controller.pressed.bool = false
        self:update_gameover(dt)
    end
    --needs to be called last!!!
    self:update_touch()
end

--Self explanatory
function gameClass:draw_background()
    love.graphics.setColor(self.theme.background)
    love.graphics.rectangle("fill",0,0,window_width,window_height)
end

--Self explanatory
function gameClass:destroy()
    self.collider = nil
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