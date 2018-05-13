gameClass = Class("game")

function gameClass:init()
    --initializing appropriate things
    
    local x, y = window_width/2, window_height/2
    self.enemies = linkedlistClass()
    self.collectibles = linkedlistClass()
    self.collider = hc.new()
    self.game_controller = gamecontrollerClass(settings.controller_size,
                                               settings.player_maxspeed)
    self.laser_every_timer = 0
    -- is it the first time showing the gameover screen?
    self.first_gameover_update_bool = true
    --settings are applied here
    self.offset = settings.offset
    self.laser_stay = settings.laser_stay_base
    self.laser_disappear = settings.laser_disappear_base
    self.theme = themes[settings.theme]
    self.laser_every = settings.laser_every_base
    self.inverted_laser_timetonext = settings.inverted_laser_delay
    self.missiles_timetonext = settings.missile_delay

                          --top, bottom,left,right
    self.bounding_box = { settings.offset, window_height - settings.offset,
                          settings.offset, window_width  - settings.offset}
    self.player = playerClass( x, y,
                               settings.player_start_vx,
                               settings.player_start_vy,
                               0, 0, settings.player_size, 
                               settings.player_maxspeed,settings.walldamp,
                               self.collider)    
    self.paused = false
    self.highscore_bool = false
    self.pressed_before_bool = false
end

--Calculates the random position pointing at the player
--adds the newly made laser to the list
function gameClass:new_laser(width,height,time,r_time)
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

function gameClass:new_missiles(r_time)
    -- corners
    local first = math.random(4)
    local second = math.random(4)
    if second == first then 
        local pm
        if math.random() < 0.5 then 
            pm = 1
        else
            pm = -1
        end
        second = (second + pm)
    end
    if second > 4 then second = 1 end
    if second < 1 then second = 4 end
    print(first,second)
    if first == 1 or second == 1 then
        self.enemies:add( missileClass(0,0,r_time,self.collider))
    end
    if first == 2 or second == 2 then
        self.enemies:add(missileClass(0,window_height,r_time,self.collider))
    end
    if first == 3 or second == 3 then
        self.enemies:add(missileClass(window_width,0,r_time,self.collider))
    end
    if first == 4 or second == 4 then
        self.enemies:add(missileClass(window_width,window_height,r_time,self.collider))
    end
    
end

function gameClass:new_inverted_laser(time,r_time)
    local displ = settings.inverted_laser_displ
    local x = math.random( window_width / displ, window_width * (1 - 1/displ))
    local y = math.random( window_height / displ ,window_height * (1 - 1/displ))
    local r = math.pi * 2 * math.random() -- just a random rotation
    local laser = inverted_laserClass(x,y,r,time,r_time,self.collider)
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

function gameClass:update_normal(dt)

    --player

    if (self.player.score > settings.highscore) then 
        self.highscore_bool = true
    end

    local vx,vy,r = self.game_controller:update()
    if r then 
        self.player.maxspeed = settings.player_maxspeed * r
    end
    self.player.vx = vx or self.player.vx
    self.player.vy = vy or self.player.vy
    self.player:update(dt,self.bounding_box)

    -- timers    
    self.inverted_laser_timetonext = self.inverted_laser_timetonext - dt
    self.missiles_timetonext = self.missiles_timetonext - dt 
    self.laser_every_timer = self.laser_every_timer + dt
    
    -- lasers
    
    if self.laser_every_timer >= self.laser_every then
        self:adjust_laser_timer()
        collectgarbage()
        self:new_laser(settings.laser_width,settings.laser_height,
                       settings.laser_stay_base,
                       settings.laser_disappear_base)
        self.laser_every_timer = 0

        -- inverted and missiles spawn with normal
        if self.player.score > settings.missile_min_score and
                math.random() < settings.missile_prob and
                self.missiles_timetonext <= 0 then
            self.missiles_timetonext = settings.missile_delay
            self:new_missiles(settings.missiles_lifetime)
        end

        if self.player.score > settings.inverted_laser_min_score and
                math.random() < settings.inverted_laser_prob and
                self.inverted_laser_timetonext <= 0 then
            self.inverted_laser_timetonext = settings.inverted_laser_delay
            self:new_inverted_laser(settings.inverted_laser_stay,
                                settings.laser_disappear_base)
        end

    end


    -- update all enemies and remove destroyed ones
    self.enemies:update_forall(dt)

    -- collectibles
    self.collectibles:update_forall(dt)
    if  self.collectibles.length == 0 then
        local x = math.random(2*self.offset, window_width - 2*self.offset)
        local y = math.random(2*self.offset, window_height - 2*self.offset)
        local new = collectibleClass(x, y,
                                     settings.collectible_size,
                                     self.theme.collectible,
                                     self.collider)
        self.collectibles:add(new)
    end
end

function gameClass:adjust_laser_timer()
    self.laser_every = math.max(- math.log(0.3 * self.player.score + 4) + 2.8,
        settings.laser_every_min)
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
    -- if something is stopping the drawing or if the game is really slow
    self.player.alive = true

    
    if dt > settings.pause_dt and self.player.alive then 
        self:pause()
        return
    end
    if not self.paused then
        if self.player.alive then
            self:update_normal(dt)
        else
            self.game_controller.pressed.bool = false
            self:update_gameover(dt)
        end
        --needs to be called last!!!
        self:update_touch()
    end

    
    if self.pause_button then
        self.main_button:update(dt)
        self.pause_button:update(dt)
    end
end

function unpause_game()
    local elf = application.current
    elf.paused = false
    elf.pause_button = nil
    elf.main_button = nil
end

function go_to_menu()
    application:change_scene_to(main_menuClass())
end

function gameClass:pause()
    self.paused = true
    self.pause_button = buttonClass(window_width/2 -
                    unpause_font:getWidth(settings.unpause_text)/2,
                            window_height/2 -
                    settings.unpause_font_size * 0.5,              
                            settings.unpause_text,
                            unpause_font,
                            1,
                            unpause_game,
                            1,
                            window_width/2 -
                    unpause_font:getWidth(settings.unpause_text)/2,
                            window_height/2 -
                    settings.unpause_font_size * 0.5
                            )
    self.main_button = buttonClass(settings.paused_main_x,
                            settings.paused_main_y,              
                            settings.paused_main_text,
                            paused_main_font,
                            1,
                            go_to_menu,
                            0,
                            settings.paused_main_x,
                            settings.paused_main_y
                            )                
    self.main_button:update_textshift()
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

function gameClass:drawScore()
    love.graphics.setFont(score_font)
    local score = self.player.score
    local x, y = window_width/2, - 0.1 * window_height
    local width = score_font:getWidth(score)
    x = x - width / 2
    local score_theme = self.theme.score
    if (self.highscore_bool and not(settings.highscore == 0)) then
        score_theme = self.theme.beaten_score
    end
    love.graphics.setColor(score_theme)
    love.graphics.print(score,x,y)
    
end

--Draws appropriate objects
function gameClass:draw()
    self:draw_background()
    self:drawScore()
    self.collectibles:draw_forall()
    self.player:draw(self.theme.player)
    self.enemies:draw_forall()
    self.game_controller:draw(self.theme.controller,
                              settings.controller_dotradius,
                              self.theme.controller,settings.controller_line,
                              self.theme.controller_alpha)
    self:draw_boundaries(self.theme.boundaries)
    if not self.player.alive then
        self:draw_gameover()
    end
    if self.pause_button then
        self.pause_button:draw()
        self.main_button:draw()
    end
end