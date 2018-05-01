function gameClass:draw_gameover()
    if self.gameover_main then
        self.gameover_main:draw()
        self.gameover_score:draw()

        local color = nil
        if self.highscore_bool then
            color = themes[settings.theme].beaten_highscore
        end
        self.gameover_highscore:draw(color)
    end
end

function gameClass:update_gameover(dt)

    if self.first_gameover_update_bool then
        self.first_gameover_update_bool = false
        self:init_gameover()
    end

    self.gameover_main:update(dt)
    self.gameover_score:update(dt)
    self.gameover_highscore:update(dt)
    -- display score
    -- maybe time played
    -- max score but i have to implement that
    -- definitely need to save max score here
    -- handling the touches
    local pressed
    if osString == "Windows " or osString =="Linux" or osString =="OS X" then
        pressed = love.mouse.isDown(1)
    else
        pressed = not not first -- cast too boolean
    end

    if pressed and not self.pressed_before_bool
        and application.current:instanceOf(gameClass) then
        application:restart_game()
    end





end

function gameClass:init_gameover()
    if self.player.score > settings.highscore then
            self.highscore_bool = true
            settings.highscore = self.player.score
            save_settings()
    end

    self.gameover_main = buttonClass(settings.menu_settings_behind,
                            settings.paused_main_y,              
                            settings.paused_main_text,
                            paused_main_font,
                            1,
                            go_to_menu,
                            settings.menu_travel_time,
                            settings.paused_main_x,
                            settings.paused_main_y
                            )
    local gameover_score_text = settings.gameover_score_text .. " "
                                .. self.player.score
    self.gameover_score = buttonClass(settings.menu_settings_behind,
                            settings.gameover_first_score_y,              
                            gameover_score_text,
                            menu_button_font, --might be ok
                            1,
                            empty,
                            settings.menu_travel_time,
                            settings.gameover_scores_x -
                    menu_button_font:getWidth(gameover_score_text),
                            settings.gameover_first_score_y
                            )
    local start_text= settings.gameover_highscore_text
    if self.highscore_bool then
        start_text = "new highscore"
    end
    local gameover_highscore_text = start_text .. " "
                                   .. settings.highscore
    local highscore_alpha = 1
    if settings.highscore == 0 then highscore_alpha = 0 end
    self.gameover_highscore = buttonClass(settings.menu_settings_behind,
                            settings.gameover_first_score_y +
                        settings.gameover_spacing,              
                            gameover_highscore_text,
                            paused_main_font, --might be ok
                            highscore_alpha,
                            empty,
                            settings.menu_travel_time,
                            settings.gameover_scores_x -
                    paused_main_font:getWidth(gameover_highscore_text),
                            settings.gameover_first_score_y +
                        settings.gameover_spacing
                            )
        
end