-- global
-- it's a collection of magic values
settings = {
    paid = true,
    please_text = "please purchase the game \n if you're enjoying it!",
    game_name = "lasers!",
    game_name_size = window_height /5,
    my_name = "mtizim",
    my_name_x = window_width                                    - 15,
    --paused_main_font_size       \/\/\/\/\/\/\/\/
    my_name_y = window_height    - window_height/12             - 15,

    --should be constants
    -- after this much delay the game will pause
    pause_dt = 0.2,
    -- +- 15 is the offset
    score_font_size = window_height * 8/6,
    unpause_font_size = window_height / 10,
    paused_main_font_size = window_height / 12,
    menu_settings_font_size = window_height * 8 /80,
    menu_button_font_size = window_height / 8,
    menu_buttons_x = window_height / 12                         + 15,
    menu_buttons_spacing = window_height / 7,
    menu_buttons_first_y = window_height * 1 /16                + 15,
    menu_highscore_y = window_height * 4/20                     + 15,
    menu_highscore_font_size = window_height  / 12,
    menu_start_text = "start",
    menu_settings_text = "settings",
    menu_controller_size_text = "joy size",
    menu_controller_text = "joy",
    menu_start_behind = - window_width / 3,
    menu_travel_time = 0.5,

    menu_settings_behind = window_width * 9/6 , --same as menu_start_behind
    menu_settings_first_y = window_height * 3/6                 + 15,
    menu_settings_x = window_width * 58/60                      - 15,
    menu_name_y = window_height / 2/20                          + 15,
    menu_settings_on_text = "on",
    menu_settings_off_text= "off",
    menu_settings_remove_highscore_text = "reset highscore",
    menu_settings_spacing = window_height * 11/120,
    remove_highscore_counter = 3,
    remove_highscore_counter_reset = 2,
    removed_highscore_text = "reset",
    button_cooldown = 0.3,

    menu_themes_text = "skins",
    menu_themes_y = window_height * 4/5                         - 15,

    visual_menu_first_x = window_width *0                       + 15,
    visual_menu_wrap =5,
    visual_menu_wrap_themes = 2,
    visual_menu_btn_size = window_width /13,
    visual_menu_btn_spacing =0,-- window_width / 200 ,
    theme_button_spacing = window_width / 80,
    visual_menu_btns_y = window_height - window_width/10          ,
    pl_btn_travel_time = 0.3,
    pl_btn_line_width = 2,
    -- menu settings font size       \/\/\/\/\/\/\/\/\/\/\/
    themes_act_ypos = window_height - window_height * 8 /80     - 15,


    gameover_scores_x = window_width * 50/52                    - 15,
    gameover_first_score_y = window_height * 1/20               + 15,
    gameover_spacing = window_height * 3/20,
    gameover_score_text = "score: ",
    gameover_highscore_text = "highscore: ",

    unpause_text = "stopped",

    paused_main_text = "main",
    paused_main_y = window_height * 135/150                     - 15,
    paused_main_x = window_width * 50/52                        - 15,

    offset = 15 * window_width/800, --15 for mobile
    player_size = 10 * window_width/800,
    player_collision_size = 5 * window_width/800,
    player_start_vx = 0,
    player_start_vy = 0,
    player_maxspeed = 300 * window_width/800,
    walldamp = 0.4,

    lineball_width = 2,

    laser_stay_base = 1.5,
    -- there is a laser tim adjusting function in game.lua
    -- won't parametrize it here but remember about it being there
    laser_width = 20 * window_width/800, --25 for mobile?
    laser_height = 100 * window_width/800, -- 150 for mobile?
    laser_random_r_deviation = math.pi / 23,  -- +- that
    laser_collision_timer = 0.02,
    laser_disappear_base = 0.3,
    laser_exploded_width_red = 0, --reduces the actual collision box by x
    laser_every_base = 1.5,
    laser_every_min = 0.8,

    inverted_laser_delay = 2,
    -- to 2/3 screen width and height
    -- 3 means that the random bounding box is from 1/3 screen width and height
    inverted_laser_stay = 2,
    inverted_laser_min_score = 15,
    inverted_laser_prob = 0.20, -- chance to spawn on normal laser spawn
    inverted_laser_displ = 3,
    inverted_laser_gap = 100 * window_width/800,
    inverted_laser_width = 1000 * window_width/800,
    inverted_laser_length = 2000 * window_width/800,

    missile_height = 40  * window_width/800,
    missile_width = 10 * window_width/800,
    missile_disappear_time = 0.5,
    missile_force_mul = 200,
    missile_min_score = 5,
    missile_prob = 0.34,
    missiles_lifetime = 3,
    missile_incut = 20 * window_height/800,
    missile_delay = 3.7,

    triplelaser_delay = 6,
    triplelaser_laser_delay = 0.2,
    -- same as inverted_laser_stay
    -- 3 means from 1/3 to 1 - 1/3
    triplelaser_explode_time = 3,
    --increments missile timer
    triplelaser_missiles_inc = 3,
    triplelaser_area = 3,
    triplelaser_prob = 0.2,
    triplelaser_collision_timer = 1.44,
    triplelaser_min_score = 10,
    triplelaser_stay_time = 2,

    rotatinglaser_rps = math.pi/4,
    rotatinglaser_appear = 1.5,
    rotatinglaser_duration = 2.5,
    rotatinglaser_collision_timer = 1.8,
    rotatinglaser_delay = 5,
    rotatinglaser_min_score = 20,
    rotatinglaser_prob = 0.2,

    -- now the controller controls vx vy directly
    -- controller_mul = 500000, -- should be about 10 * maxspeed
    controller_dotradius = 5 * window_width/800, -- 10 for mobile
    controller_line = 1.2,  -- ok for mobile
    controller_size_max = 201,
    controller_size_min = 40,

    collectible_fade_time = 4, -- inverse of the actual time in s
                                 -- so it's lighter
    collectible_fadein = 2, --same as above
    collectible_size = 7 * window_width/800,

    coin_time = 6,
    coin_prob = 0.75,
    coin_x = 15                                                 + 15,
    coin_y = 15                                                 + 15,
    coin_scale = 1.5,
    coin_scale_game = 1.5,
    coin_display_time = 2,
    coin_font_size = 32,

    unlocked_button_y =2/5 * window_height                      + 15,
    unlocked_button_theme_text = "theme unlocked!",
    unlocked_button_skin_text = "skin unlocked!",

    unlock_at = {
        1,3,7,12,18,25,33,
        42,52,63,75,88,102,117,133,150
    },
    unlock_themes_at = {
        20,40,60,80,100
    },

    font = "Geo.otf",
    --defaults
    theme_number = 1,
    controller_size = 100,
    draw_controller = true,
    highscore = 0,
    player_model = "ball_fill",
    skins_unlocked = {
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        false,
        false,
        false,
        false
    },
    themes_unlocked ={
        true,
        true,
        true,
        true,
        false,
    },
    unlock_which = 1,
    unlock_which_theme = 1,
    coins = 0,
    -- main font
}
-- font things
settings.score_font_size = window_height
score_font=love.graphics.newFont(settings.font,settings.score_font_size)
menu_button_font=love.graphics.newFont(settings.font,settings.menu_button_font_size)
menu_highscore_font=love.graphics.newFont(settings.font,settings.menu_highscore_font_size)
menu_settings_font =love.graphics.newFont(settings.font,settings.menu_settings_font_size)
unpause_font =love.graphics.newFont(settings.font,settings.unpause_font_size)
paused_main_font=love.graphics.newFont(settings.font,settings.paused_main_font_size)
game_name_font=love.graphics.newFont(settings.font,settings.game_name_size)

local s = 'settings.txt'
-- changeable ones that need to be saved
function read_settings()
    local file = love.filesystem.getInfo(s)
    if not file then
        save_settings()
    end
    local file = love.filesystem.getInfo(s)
    if file then
        local read = love.filesystem.read(s)
        if not (read == nil) then
            local index = 1
            local valtab = {}
            for val in string.gmatch(read, "%S+") do
                valtab[index] = val
                index = index + 1
            end
            settings.theme_number = tonumber(valtab[1]) or settings.theme_number
            settings.controller_size = tonumber(valtab[2]) or settings.controller_size
            settings.draw_controller = (tostring(valtab[3]) == "true") or settings.draw_controller
            settings.highscore = tonumber(valtab[4]) or settings.highscore
            settings.player_model = tostring(valtab[5] or settings.player_model)
            settings.coins = tonumber(valtab[6]) or 0
            local n = 7
            for i=n,#settings.skins_unlocked + n - 1 do
                settings.skins_unlocked[i - n + 1] =
                    tostring(valtab[i] or settings.skins_unlocked[i - n + 1]) == "true"
            end
            local n = n + #settings.skins_unlocked
            settings.unlock_which = tonumber(valtab[n+1]) or settings.unlock_which
            settings.unlock_which_theme = tonumber(valtab[n + 2]) or settings.unlock_which_theme
            n = n + 2
            for i=n,#settings.themes_unlocked + n - 1 do

                settings.themes_unlocked[i - n + 1] =
                    tostring(valtab[i] or settings.themes_unlocked[i - n + 1]) == "true"
            end
            local n = n + #settings.themes_unlocked



        end
        file = nil
        settings.theme = theme_names[settings.theme_number]
    end
end

function save_settings()
    love.filesystem.getInfo(s)
    love.filesystem.write(s, "")

    love.filesystem.append(s,settings.theme_number)
        love.filesystem.append(s,"\n")
    love.filesystem.append(s,settings.controller_size)
        love.filesystem.append(s,"\n")
    love.filesystem.append(s,tostring(settings.draw_controller))
        love.filesystem.append(s,"\n")
    love.filesystem.append(s,tostring(settings.highscore or 0))
        love.filesystem.append(s,"\n")
    love.filesystem.append(s,tostring(settings.player_model))
        love.filesystem.append(s,"\n")
    love.filesystem.append(s,tostring(settings.coins))
        love.filesystem.append(s,"\n")
    for _,val in pairs(settings.skins_unlocked) do
        love.filesystem.append(s,tostring(val))
            love.filesystem.append(s,"\n")
    end
    love.filesystem.append(s,tostring(settings.unlock_which))
        love.filesystem.append(s,"\n")
    love.filesystem.append(s,tostring(settings.unlock_which_theme))
        love.filesystem.append(s,"\n")
    for _,val in pairs(settings.themes_unlocked) do
        love.filesystem.append(s,tostring(val))
            love.filesystem.append(s,"\n")
    end
    file = nil
end
read_settings()
