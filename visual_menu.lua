visual_menuClass = Class("visual_menu")

function visual_menuClass:init(parent)
    self.super = parent
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
    end
    self.theme_btn = buttonClass(settings.menu_settings_behind,
                                settings.themes_act_ypos,
                                theme_names[settings.theme_number]
                                menu_settings_font,
                                1,
                                cycle_themes,
                                settings.menu_travel_time,
                                settings.menu_settings_x,
                                settings.themes_act_ypos
                                )
    self.theme_btn:update_textshift()
end

function cycle_themes()
    settings.theme_number = (settings.theme_number + 1) % #theme_names + 1
    settings.theme = theme_names[settings.theme_number]
end

function  visual_menuClass:draw()
    for i=1,#self.buttons do
        self.buttons[i]:draw(themes[settings.theme].pl_btn_color,self.size/4)
    end
    self.theme_btn:draw()
end

function visual_menuClass:revert()
    for i=1,#self.buttons do
        self.buttons[i]:revert()
    end
    self.theme_btn:revert()
end

function visual_menuClass:update(dt)
    for i=1,#self.buttons do
        self.buttons[i]:update(dt)
    end
    self.theme_btn:update(dt)
end