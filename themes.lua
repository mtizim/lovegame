local red = {0.9 , 0 ,0}
local white = {0.9 ,0.9 ,0.9}
local white_transparent = {white[1],white[2],white[3], 0.1}
local black = {0.1, 0.1 ,0.1}
local black_transparent = {black[1],black[2],black[3], 0.1}
local yellowish_white = {0.9,0.9,0.82}
local blue = {0.1,0.1,0.9}
local blue_less = {0.1,0.1,0.8}

themes = {
    black_red = 
    {
        laser = red,
        laser_exploded = white,
        player = red,
        controller =  white,
        controller_alpha = 0.3, 
        boundaries = white,
        background = black,
        collectible = blue,
        score = white_transparent,
    },
    white_red =
    {
        laser = black,
        laser_exploded = red,
        player = black,
        controller = black,
        controller_alpha = 0.7,
        boundaries = red,
        background = yellowish_white,
        collectible = blue_less,
        score = black_transparent,
    }
}

theme_names = {
    "black_red",
    "white_red"
}