-- a light game class without controls,points and collisions
-- literally a duplicate of the game class
-- to be used as a background ONLY


game_backgroundClass = Class("game_background")

function game_backgroundClass:init()
    --initializing appropriate things
    
    local x, y = window_width/2, window_height/2
    self.enemies = linkedlistClass()
    self.collider = hc.new()
    self.laser_every_timer = 0
    -- is it the first time showing the gameover screen?
    --settings are applied here
    self.offset = settings.offset
    self.laser_stay = settings.laser_stay_base
    self.laser_disappear = settings.laser_disappear_base
    self.theme = themes[settings.theme]
    self.laser_every = settings.laser_every_base
                          --top, bottom,left,right
    self.bounding_box = { settings.offset, window_height - settings.offset,
                          settings.offset, window_width  - settings.offset}
    local theta = math.random() * 2 * math.pi
    local vx = settings.player_maxspeed * math.sin(theta)
    local vy = settings.player_maxspeed * math.cos(theta)
    self.player = playerClass( x, y,
                               vx,vy,
                               0, 0, settings.player_size, 
                               settings.player_maxspeed,1,
                               self.collider)    

end

--Calculates the random position pointing at the player
--adds the newly made laser to the list
function game_backgroundClass:new_laser(width,height,time,r_time,color,explodedcolor)
    local x = math.random( 2 * self.offset, window_width - 2 * self.offset )
    local y = math.random( 2 * self.offset, window_height - 2 * self.offset)
    local r = math.atan2( x - self.player.x, y - self.player.y)
                          + math.random() * settings.laser_random_r_deviation*2
                          - settings.laser_random_r_deviation
    local laser = laserClass(x,y,r,
                             width,height,
                             width, height * 100,
                             time,r_time,
                             self.collider)
    self.enemies:add(laser)
end


--Just draws the boundaries
function game_backgroundClass:draw_boundaries(colorArray)
    love.graphics.setColor(colorArray)
    love.graphics.rectangle("fill",0,0,window_width, self.offset)
    love.graphics.rectangle("fill",0,window_height,window_width, -self.offset)
    love.graphics.rectangle("fill",0,0,self.offset,window_height)
    love.graphics.rectangle("fill",window_width,0,-self.offset,window_height)
end

function game_backgroundClass:update_normal(dt)

    --player

    self.player:update(dt,self.bounding_box)

    -- lasers

    -- so that a laser is only spawned once every
    --                                 timer seconds
    self.laser_every_timer = self.laser_every_timer + dt
    if self.laser_every_timer >= self.laser_every then
        collectgarbage()
        self:new_laser(settings.laser_width,settings.laser_height,
                       self.laser_stay,self.laser_disappear,
                       self.theme.laser,self.theme.laser_exploded)
        self.laser_every_timer = 0
    end
    -- update all lasers and remove destroyed ones
    self.enemies:update_forall(dt)
end



function game_backgroundClass:update(dt)
    self:update_normal(dt)
end

--Self explanatory
function game_backgroundClass:draw_background()
    love.graphics.setColor(self.theme.background)
    love.graphics.rectangle("fill",0,0,window_width,window_height)
end

--Self explanatory
function game_backgroundClass:destroy()
    self.collider = nil
end


--Draws appropriate objects
function game_backgroundClass:draw()
    self:draw_background()
    self.player:draw(self.theme.player)
    self.enemies:draw_forall()
    self:draw_boundaries(self.theme.boundaries)
end