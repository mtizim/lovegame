main_menuClass = Class("main menu")


function main_menuClass:init()
    self.game_bg = game_backgroundClass()
    self.theme = themes[settings.theme]
    self.settings_bool = false
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
                            window_height -
                      settings.menu_buttons_spacing,               
                            settings.menu_themes_text,
                            menu_button_font,
                            1,
                            cycle_themes,
                            settings.menu_travel_time,
                            settings.menu_buttons_x,
                            window_height -
                      settings.menu_buttons_spacing
                            )

end

function start_game()
    application:restart_game()
end

function cycle_themes()
    
    if not button_cooldown or button_cooldown < 0 then
        button_cooldown = 0.3
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
    end
end

function toggle_draw_controller()
    if not button_cooldown or button_cooldown < 0 then
        button_cooldown = 0.3
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
        button_cooldown = 0.3
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
    self.controller_size.enabled = false          
    self.controller.enabled = false
end
    

function main_menuClass:draw()
    self.game_bg:draw()
    self.start:draw()
    self.settings:draw()
    self.themes:draw()
    if self.controller_size then 
        self.controller_size:draw()
        self.controller:draw()
    end
end

function main_menuClass:update(dt)
    if button_cooldown and button_cooldown > 0 then
        button_cooldown = button_cooldown - dt
    end
    self.game_bg:update(dt)
    self.start:update(dt)
    self.settings:update(dt)
    self.themes:update(dt)
    if self.controller_size then
        self.controller_size:update(dt)
        self.controller:update(dt)
    end
end