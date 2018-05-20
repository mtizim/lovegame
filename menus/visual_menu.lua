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
    local y = settings.visual_menu_btns_y
    self.buttons = {}
    for i=0,#player_draw_list-1 do
        local wrap = siz * math.floor((i)/settings.visual_menu_wrap)
        local x = f_x + (i%(settings.visual_menu_wrap))* (siz + spac)
        self.buttons[i+1] = pl_model_btnClass(f_x + (i) * (spac + siz),
                                            window_height + siz/2,
                                            siz,
                                            player_draw_list[i+1],
                                            settings.pl_btn_travel_time,
                                            x,
                                            y - wrap
                                            )
        self.buttons[i+1].unlocked = settings.skins_unlocked[i+1]
    end
    self.theme_buttons = {}
    spac = settings.theme_button_spacing
    for i=0,#theme_names-1 do
        local wrap = math.floor(i/settings.visual_menu_wrap_themes)
        local x = window_width - f_x 
            - (i%settings.visual_menu_wrap +1 ) * (siz +spac) 
            + wrap * (siz + spac) * settings.visual_menu_wrap_themes
        self.theme_buttons[i+1] = theme_btnClass(window_width - f_x - (i) * (spac + siz) - siz,
                                            window_height + siz/2,
                                            siz,
                                            i+1,
                                            settings.pl_btn_travel_time,
                                            x,
                                            y - wrap * (siz + spac) - spac)
        self.theme_buttons[i+1].unlocked = settings.themes_unlocked[i+1]
    end
end

function  visual_menuClass:draw()
    for i=1,#self.buttons do
        self.buttons[i]:draw(themes[settings.theme].player,self.size/4)
    end
    for i=1,#self.theme_buttons do
        self.theme_buttons[i]:draw(self.size/4)
    end
    if self.open then self:draw_coins() end
end

function visual_menuClass:draw_coins()
    local x = settings.gameover_scores_x - coin_image:getWidth() * settings.coin_scale,
      - settings.offset
    local y = settings.game_name_size +  2 * settings.offset
    love.graphics.setFont(coin_font)
    local d = coin_font:getWidth(tostring(settings.coins)) + settings.offset
    love.graphics.setColor(gold)
    love.graphics.draw(coin_image,x - coin_image:getWidth() * settings.coin_scale,y
            ,0,settings.coin_scale)
    love.graphics.setColor(themes[settings.theme].coin)
    love.graphics.print(settings.coins,x - d,y)
end

function visual_menuClass:revert()
    self.open = false
    for i=1,#self.buttons do
        self.buttons[i]:revert()
    end
    for i=1,#self.theme_buttons do
        self.theme_buttons[i]:revert()
    end
end

function visual_menuClass:update(dt)
    for i=1,#self.buttons do
        self.buttons[i]:update(dt)
    end
    for i=1,#self.theme_buttons do
        self.theme_buttons[i]:update(dt)
    end
end