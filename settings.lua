-- global
-- it's a collection of magic values 
print(window_height,window_width)
settings = {
    --should be constants
    score_font_size = 700,
    menu_button_font_size = 50,
    menu_buttons_x = 50,
    menu_buttons_spacing = 80,
    menu_buttons_first_y = 50,
    menu_start_text = "start",
    menu_settings_text = "settings",
    menu_controller_size_text = "joy size",
    menu_controller_text = "joy",
    menu_start_behind = -200,
    menu_travel_time = 0.8,

    menu_settings_font_size = 35,
    menu_settings_behind = window_width + 200,
    menu_settings_first_y = window_height - 100,
    menu_settings_x = window_width - 250,
    menu_settings_on_text = "on",
    menu_settings_off_text= "off",
    menu_settings_spacing = 50,

    menu_themes_text = "theme",
    
    unpause_text = "stopped",
    unpause_font_size = 60,

    paused_main_text = "main",
    paused_main_font_size = 30,
    paused_main_y = window_height - 80,
    paused_main_x = window_width - 100,

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

    controller_mul = 2700, -- should be about 10 * maxspeed
    controller_dotradius = 5, -- 10 for mobile
    controller_line = 1.2,  -- ok for mobile
    controller_size_max = 121,
    controller_size_min = 60,

    collectible_fade_time = 3, -- inverse of the actual time in s
                                 -- so it's lighter
    collectible_fadein = 2, --same as above                                 
    collectible_size = 7,

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
    local file = love.filesystem.newFile("settings.txt")
    file:open("r")
        local read = file:read("string")
        local index = 1
        local valtab = {}
        for val in string.gmatch(read, "%S+") do
            valtab[index] = val
            index = index + 1
        end
        settings.theme_number = tonumber(valtab[1])
        settings.controller_size = tonumber(valtab[2])
        settings.draw_controller = (tostring(valtab[3]) == "true")
    file = nil
    settings.theme = theme_names[settings.theme_number]
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
    
    file = nil
end

read_settings()
