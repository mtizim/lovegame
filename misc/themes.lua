local red = {0.9 , 0 ,0}
local white = {0.9 ,0.9 ,0.9}
local white_transparent = {white[1],white[2],white[3], 0.1}
local black = {0.1, 0.1 ,0.1}
local black_transparent = {black[1],black[2],black[3], 0.1}
local yellowish_white = {0.9,0.9,0.82}
local blue = {0.1,0.1,0.9}
local blue_less = {0.1,0.1,0.8}
local golden = {1,0.84,0}
local golden_transparent = {golden[1],golden[2],golden[3], 0.1}

themes = {}
themes["black/red"] = 
    {
        laser = red,
        laser_exploded = white,
        player = red,
        controller =  white,
        controller_alpha = 0.3, 
        boundaries = white,
        background = black,
        collectible = blue,
        coin = golden,
        score = white_transparent,
        missile = white,
        pl_btn_color = white,

        menu_button = white,
        beaten_highscore = golden,
        beaten_score = golden_transparent,
        highscore = red,
    }
themes["white/red"] =
    {
        laser = black,
        laser_exploded = red,
        player = black,
        controller = black,
        controller_alpha = 0.7,
        boundaries = red,
        background = yellowish_white,
        collectible = blue_less,
        coin = golden,
        score = black_transparent,
        missile = red,
        pl_btn_color = red,

        menu_button = red,
        beaten_highscore = black,
        beaten_score = golden_transparent,
        highscore = black,
    }



    -- for key,_ in pairs(themes) do
        -- theme_names[#theme_names + 1] = key
    -- end
    theme_names = {"black/red","white/red"}