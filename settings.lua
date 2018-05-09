-- global
-- it's a collection of magic values 
settings = {
    --should be constants
                                                        -- +- 15 is the offset
    score_font_size = window_height * 8/6,
    menu_button_font_size = window_height / 8,
    menu_buttons_x = window_height / 12                         + 15,
    menu_buttons_spacing = window_height / 7,
    menu_buttons_first_y = window_height * 1 /16                + 15,
    menu_start_text = "start",
    menu_settings_text = "settings",
    menu_controller_size_text = "joy size",
    menu_controller_text = "joy",
    menu_start_behind = - window_width / 6,
    menu_travel_time = 0.5,

    menu_settings_font_size = window_height * 6 /80,
    menu_settings_behind = window_width * 9/6 , --same as menu_start_behind
    menu_settings_first_y = window_height * 3/6                 + 15,
    menu_settings_x = window_width * 58/60                      - 15,
    menu_settings_on_text = "on",
    menu_settings_off_text= "off",
    menu_settings_remove_highscore_text = "reset highscore",
    menu_settings_spacing = window_height * 11/120,
    remove_highscore_counter = 3,
    remove_highscore_counter_reset = 2,
    removed_highscore_text = "reset",
    button_cooldown = 0.3,

    menu_themes_text = "theme",
    menu_themes_y = window_height * 4/5                         - 15,
    
    gameover_scores_x = window_width * 50/52                    - 15,
    gameover_first_score_y =0                                   + 15,
    gameover_spacing = window_height * 1/10,
    gameover_score_text = "score",
    gameover_highscore_text = "highscore",

    unpause_text = "stopped",
    unpause_font_size = window_height / 10,

    paused_main_text = "main",
    paused_main_font_size = window_height / 15,
    paused_main_y = window_height * 135/150                     - 15,
    paused_main_x = window_width * 70/80                        - 15,

    offset = 15, --15 for mobile
    player_size = 10,
    player_start_vx = 0,
    player_start_vy = 0,
    player_maxspeed = 250,
    walldamp = 0.4,

    laser_stay_base = 1.5,
    laser_width = 20, --25 for mobile?
    laser_height = 100, -- 150 for mobile?
    laser_random_r_deviation = math.pi / 23,  -- +- that
    laser_collision_timer = 0.02,
    laser_disappear_base = 0.3,
    laser_exploded_width_multiplier = 0.3, --reduces the actual collision box
    laser_every_base = 0.7,

    controller_mul = 5000, -- should be about 10 * maxspeed
    controller_dotradius = 5, -- 10 for mobile
    controller_line = 1.2,  -- ok for mobile
    controller_size_max = 121,
    controller_size_min = 60,

    collectible_fade_time = 3, -- inverse of the actual time in s
                                 -- so it's lighter
    collectible_fadein = 2, --same as above                                 
    collectible_size = 7,
    --backup
    theme_number = 1,
    controller_size = 60,
    draw_controller = true,
    highscore = 0,

    font = "Geo.otf",
}

-- font things
settings.score_font_size = window_height
score_font=love.graphics.newFont(settings.font,settings.score_font_size)
menu_button_font=love.graphics.newFont(settings.font,settings.menu_button_font_size)
menu_settings_font =love.graphics.newFont(settings.font,settings.menu_settings_font_size)
unpause_font =love.graphics.newFont(settings.font,settings.unpause_font_size)
paused_main_font=love.graphics.newFont(settings.font,settings.paused_main_font_size)

-- changeable ones that need to be saved
function read_settings()
    local file, error = love.filesystem.newFile("settings.txt")
    if not error then 
        file:open("r")
            local read = file:read("string")
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
            end
        file:close()
        file = nil
        settings.theme = theme_names[settings.theme_number]
    end
end

function save_settings()
    local file = love.filesystem.newFile("settings.txt","w")
    file:open("w")
    file:write(settings.theme_number)
        file:write("\n")
    file:write(settings.controller_size)
        file:write("\n")
    file:write(tostring(settings.draw_controller))
        file:write("\n")
    file:write(tostring(settings.highscore or 0))
        file:write("\n")
    
    file = nil
end

read_settings()
