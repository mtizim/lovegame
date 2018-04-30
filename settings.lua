-- global
settings = {
    --should be constants
    font_size = 700,
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
    controller_mul = 2000, -- should be about 3 or 4 * maxspeed
                           -- then turning around takes 1/3 or 1/4 s
    controller_dotradius = 5, -- 10 for mobile
    controller_line = 1.2,  -- ok for mobile
    collectible_fade_time = 2, -- inverse of the actual time in s
                                 -- so it's lighter
    collectible_fadein = 2, --same as above                                 
    collectible_size = 7,

    --variable in settings tab
    theme = theme_names[2],
    controller_size = 70, --base at least 100 for mobile
}