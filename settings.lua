-- global
settings = {
    --should be constants
    offset = 5, --15 for mobile
    player_size = 15,
    player_start_vx = 0,
    player_start_vy = 0,
    player_maxspeed = 5,
    walldamp = 0.5,
    laser_stay_base = 1.5,
    laser_width = 20, --30 for mobile
    laser_height = 100, -- 150 for mobile?
    -- TODO some kind of randomness to the initial rotation of the lasers
    laser_random_r_deviation = math.pi / 23,  -- +- 
    laser_collision_timer = 0.02,
    laser_disappear_base = 0.3,
    laser_exploded_width_multiplier = 0.3,
    laser_every_base = 0.7,
    controller_mul = 0.5,
    controller_dotradius = 5, -- 10 for mobile
    controller_line = 1.2,  -- ok for mobile
    --variable in settings tab
    theme = theme_names[1],
    controller_size = 60, --base at least 120 for mobile
}