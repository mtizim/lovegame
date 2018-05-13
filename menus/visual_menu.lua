visual_menuClass = Class("visual_menu")

function visual_menuClass:init(parent)
    self.super = parent
    self.open = true
    self.buttons = {}
    -- settings.player_fill_mode = fill mode
    --settings.player_model = current player model


    local f_x = settings.visual_menu_first_x
    local spac = settings.visual_menu_btn_spacing
    local siz = settings.visual_menu_btn_size
    self.size = siz
    local y = settings.vixual_menu_btns_y
    
    for i=1,#player_draw_list do
        self.buttons[i] = pl_model_btnClass(f_x + (i-1) * (spac + siz),
                                            window_height + siz/2,
                                            siz,player_draw_list[i],
                                            settings.player_fill_mode,
                                            settings.pl_btn_travel_time,
                                            f_x + (i-1) * (siz +spac),
                                            y
                                            )
        self.buttons[i].unlocked = settings.skins_unlocked[i]
    end
    self.theme_btn = buttonClass(settings.menu_settings_behind,
                                settings.themes_act_ypos,
                                theme_names[settings.theme_number],
                                menu_settings_font,
                                1,
                                cycle_themes,
                                settings.menu_travel_time,
                                settings.menu_settings_x,
                                settings.themes_act_ypos
                                )

    if settings.player_fill_mode == "line" then
        fill_btn_alpha = settings.fill_btn_inactive_a
    else
        fill_btn_alpha = 1
    end 
    self.fill_btn = buttonClass(settings.menu_settings_behind,
                                settings.themes_act_ypos -
                            settings.menu_settings_spacing,
                                settings.fill_btn_txt,
                                menu_settings_font,
                                fill_btn_alpha,
                                toggle_fill,
                                settings.menu_travel_time,
                                settings.menu_settings_x,
                                settings.themes_act_ypos -
                            settings.menu_settings_spacing
                                )
    self.theme_btn:update_textshift()
    self.fill_btn:update_textshift()
end

function cycle_themes()
    if not button_cooldown or button_cooldown < 0 then
        button_cooldown = settings.button_cooldown
        -- change the permanent ones
        settings.theme_number = ((settings.theme_number ) % (#theme_names)) + 1
        settings.theme = theme_names[settings.theme_number]
        -- change the visible ones
        application.current.visual_menu.theme_btn.text = theme_names[settings.theme_number]
        application.current.theme = themes[settings.theme]
        application.current.game_bg.theme = themes[settings.theme]
    end
end

function toggle_fill()
    if not button_cooldown or button_cooldown < 0 then
        button_cooldown = settings.button_cooldown
        local elf = application.current.visual_menu
        if settings.player_fill_mode == "line" then
            settings.player_fill_mode = "fill"
            elf.fill_btn.alpha = 1
        else
            settings.player_fill_mode = "line"
            elf.fill_btn.alpha = settings.fill_btn_inactive_a
        end 
        for i=1,#elf.buttons do
            elf.buttons[i].playermodel_mode = settings.player_fill_mode
        end    
        save_settings()
    end
end

function  visual_menuClass:draw()
    for i=1,#self.buttons do
        self.buttons[i]:draw(themes[settings.theme].pl_btn_color,self.size/4)
    end
    self.theme_btn:draw()
    self.fill_btn:draw()
end

function visual_menuClass:revert()
    self.open = false
    for i=1,#self.buttons do
        self.buttons[i]:revert()
    end
    self.theme_btn:revert()
    self.fill_btn:revert()
end

function visual_menuClass:update(dt)
    for i=1,#self.buttons do
        self.buttons[i]:update(dt)
    end
    self.theme_btn:update(dt)
    self.fill_btn:update(dt)
end