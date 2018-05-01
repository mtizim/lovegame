main_menuClass = Class("main menu")


function main_menuClass:init()
    self.game_bg = game_backgroundClass()
    self.theme = themes[settings.theme]
    self.time = 0
    self.settings_bool = false
    self.remove_highscore_counter = settings.remove_highscore_counter
    self.start = buttonClass(settings.menu_start_behind,
                            settings.menu_buttons_first_y,               
                            settings.menu_start_text,
                            menu_button_font,
                            1,
                            start_game,
                            settings.menu_travel_time,
                            settings.menu_buttons_x,
                            settings.menu_buttons_first_y
                            )

    self.settings = buttonClass(settings.menu_start_behind,
                            settings.menu_buttons_first_y +
                        settings.menu_buttons_spacing,               
                            settings.menu_settings_text,
                            menu_button_font,
                            1,
                            toggle_settings,
                            settings.menu_travel_time,
                            settings.menu_buttons_x,
                            settings.menu_buttons_first_y +
                        settings.menu_buttons_spacing
                            )

    self.themes = buttonClass(settings.menu_start_behind,
                            settings.menu_themes_y,               
                            settings.menu_themes_text,
                            menu_button_font,
                            1,
                            cycle_themes,
                            settings.menu_travel_time,
                            settings.menu_buttons_x,
                            settings.menu_themes_y
                            )

    local gameover_highscore_text = settings.gameover_highscore_text .. " "
                                   .. settings.highscore
    local highscore_alpha = 1
    if settings.highscore == 0 then highscore_alpha = 0 end
    self.highscore = buttonClass(settings.menu_settings_behind,
                            settings.gameover_first_score_y,              
                            gameover_highscore_text,
                            menu_button_font, --might be ok
                            1,
                            empty,
                            settings.menu_travel_time,
                            settings.gameover_scores_x -
                    menu_button_font:getWidth(gameover_highscore_text),
                            settings.gameover_first_score_y
                            )
end

function start_game()
    application:restart_game()
end

function cycle_themes()
    
    if not button_cooldown or button_cooldown < 0 then
        button_cooldown = settings.button_cooldown
        settings.theme_number = ((settings.theme_number) % (#theme_names)) + 1
        settings.theme = theme_names[settings.theme_number]
        application.current.theme = settings.theme
        update_themes()
        save_settings()
    end
end

-- i could refactor some code or do this
function update_themes()
    application.current.game_bg.theme = themes[settings.theme]
end

function toggle_settings()
    local elf = application.current
    if not elf.settings_bool then
        --fuck style here
        self.remove_highscore_counter = settings.remove_highscore_counter
        elf.settings_bool = true
        elf.controller_size = buttonClass(settings.menu_settings_behind,
                            settings.menu_settings_first_y,               
                            settings.menu_controller_size_text .. "  " ..
                        settings.controller_size,
                            menu_settings_font,
                            1,
                            change_controller_size,
                            settings.menu_travel_time,
                            settings.menu_settings_x,
                            settings.menu_settings_first_y
                            )
        local controller_state = ""
        if settings.draw_controller then
            controller_state = settings.menu_settings_on_text
        else
            controller_state = settings.menu_settings_off_text
        end
        elf.controller = buttonClass(settings.menu_settings_behind,
                            settings.menu_settings_first_y +
                        settings.menu_settings_spacing,               
                            settings.menu_controller_text .. " " .. 
                        controller_state,
                            menu_settings_font,
                            1,
                            toggle_draw_controller,
                            settings.menu_travel_time,
                            settings.menu_settings_x,
                            settings.menu_settings_first_y +
                        settings.menu_settings_spacing
                            )

        elf.remove_highscore = buttonClass(settings.menu_settings_behind,
                            settings.menu_settings_first_y +
                       2 * settings.menu_settings_spacing,               
                            settings.menu_settings_remove_highscore_text,
                            menu_settings_font,
                            1,
                            remove_highscore,
                            settings.menu_travel_time,
                            settings.menu_settings_x,
                            settings.menu_settings_first_y +
                       2 *  settings.menu_settings_spacing
                            )                    
    end
end

function remove_highscore()
    if not button_cooldown or button_cooldown < 0 then
        button_cooldown = settings.button_cooldown
        elf = application.current
        elf.remove_highscore_counter = elf.remove_highscore_counter - 1
        if elf.remove_highscore_counter ==
                settings.remove_highscore_counter - 1 then
            remove_highscore_start = elf.time
        end

        if elf.remove_highscore_counter > 0 then
            elf.remove_highscore.text =
                settings.menu_settings_remove_highscore_text ..
                " (" .. elf.remove_highscore_counter .. ")"
        else
            elf.remove_highscore.text = settings.removed_highscore_text
            
            reset_highscore()
            elf.highscore.alpha = math.min(settings.highscore,1)
            elf.highscore.text = settings.gameover_highscore_text .. " "
                                   .. settings.highscore
        end
    end
end

function toggle_draw_controller()
    if not button_cooldown or button_cooldown < 0 then
        button_cooldown = settings.button_cooldown
        settings.draw_controller = not settings.draw_controller
        save_settings()
        local controller_state = ""
        if settings.draw_controller then
            controller_state = settings.menu_settings_on_text
        else
            controller_state = settings.menu_settings_off_text
        end
        application.current.controller.text = 
            settings.menu_controller_text .. " " .. 
            controller_state
    end
end

function change_controller_size()
    if not button_cooldown or button_cooldown < 0 then
        button_cooldown = settings.button_cooldown
        local elf = application.current
        settings.controller_size = settings.controller_size + 10
        if settings.controller_size > settings.controller_size_max then
            settings.controller_size = settings.controller_size_min
        end
        --update text
        elf.controller_size.text = settings.menu_controller_size_text .. "  " ..
                            settings.controller_size
        save_settings()
    end
end

function main_menuClass:destroy()
    --empty for now
end

function main_menuClass:revert_settings()
    self.settings_bool = false
    self.controller_size:revert()
    self.controller:revert()
    self.remove_highscore:revert()
    self.controller_size.enabled = false          
    self.controller.enabled = false
end
    

function main_menuClass:draw()
    self.game_bg:draw()
    self.start:draw()
    self.settings:draw()
    self.themes:draw()
    self.highscore:draw(themes[settings.theme].highscore)
    if self.controller_size then 
            self.controller_size:update_textshift()
        self.controller_size:draw()
            self.controller:update_textshift()
        self.controller:draw()
            self.remove_highscore:update_textshift()
        self.remove_highscore:draw(themes[settings.theme].player)
    end
end

function main_menuClass:update(dt)
    self.time = self.time + dt
    if button_cooldown and button_cooldown > 0 then
        button_cooldown = button_cooldown - dt
    end
    if self.remove_highscore and 
            remove_highscore_start and self.time - remove_highscore_start >
        settings.remove_highscore_counter_reset then
        self.remove_highscore_counter = settings.remove_highscore_counter
        self.time = 0
        self.remove_highscore_start = nil
        self.remove_highscore.text = 
            settings.menu_settings_remove_highscore_text
    end
    self.game_bg:update(dt)
    self.start:update(dt)
    self.settings:update(dt)
    self.highscore:update(dt)
    self.themes:update(dt)
    if self.controller_size then
        self.controller_size:update(dt)
        self.controller:update(dt)
        self.remove_highscore:update(dt)
    end
end