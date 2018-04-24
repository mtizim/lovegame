gameClass = Class()

function gameClass:init(offset,theme)
    local x, y = window_width/2, window_height/2
    local vx, vy = 0, 7
    local size = 15
    local maxspeed = 5
    local walldamp = 0.3

    self.offset = offset
    -- top bottom left right
    self.bounding_box = { offset, window_height - offset,
                          offset, window_width  - offset}
    -- x y vx vy ax ay size
    self.player = playerClass( x, y,
                               vx, vy,
                               0, 0, size, 
                               maxspeed,walldamp)
    
    self.laser_stay = 1.5
    self.laser_disappear = 0.3

    self.enemies = linkedlistClass()

    self.game_controller = gamecontrollerClass(60,0.5)

    self.laser_every = 0.9 --seconds
    self.laser_every_timer = 0

    self.theme = theme
end

function gameClass:new_laser(width,height,time,r_time,color,explodedcolor)
    local offset = self.offset
    local player = self.player
    local x = math.random( 2 * offset, window_width - 2 * offset )
    local y = math.random( 2 * offset, window_height - 2 * offset)
    local r = math.atan2( x - player.x, y - player.y)
    local laser = laserClass(x,y,r,
                             width,height,
                             width, height * 100,
                             time,r_time,
                             color,explodedcolor)
    self.enemies:add(laser)
end


-- really basic
function gameClass:draw_boundaries(colorArray)
    love.graphics.setColor(colorArray)
    love.graphics.rectangle("fill",0,0,window_width, self.offset)
    love.graphics.rectangle("fill",0,window_height,window_width, -self.offset)
    love.graphics.rectangle("fill",0,0,self.offset,window_height)
    love.graphics.rectangle("fill",window_width,0,-self.offset,window_height)
end

function gameClass:update(dt)
    --joystick reaction
    self.player.ax,self.player.ay = self.game_controller:update()
    self.player:update(dt,self.bounding_box)
    -- so that a laser is only spawned once every
    --                                 timer seconds
    self.laser_every_timer = self.laser_every_timer + dt
    if self.laser_every_timer >= self.laser_every then
                                                    --magic constants here should change when possible
        self:new_laser(10,100,self.laser_stay,self.laser_disappear,
                       self.theme.laser,self.theme.laser_exploded)
        self.laser_every_timer = 0
    end
    -- update all lasers and remove destroyed ones
    self.enemies:update_forall(dt)
    self.enemies:remove_destroyed()

    collectgarbage()
end

function gameClass:draw_background()
    love.graphics.setColor(self.theme.background)
    love.graphics.rectangle("fill",0,0,window_width,window_height)
end

function gameClass:destroy()
    hc.remove(self.player.hc_object)
    hc.resetHash()
end

function gameClass:draw()
    self:draw_background()
    self.player:draw(self.theme.player)
    self.enemies:draw_forall()
    self.game_controller:draw(self.theme.controller,5,self.theme.controller,
                              1.2,self.theme.controller_alpha)
    self:draw_boundaries(self.theme.boundaries)
end