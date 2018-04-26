local red = {0.9 , 0 ,0}
local white = {0.9 ,0.9 ,0.9}
local black = {0.1,, 0.1 ,0.1}
local yellowish_white = {0.9,0.9,0.72}


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
    },
    white_red =
    {
        laser = black,
        laser_exploded = red,
        player = black,
        controller = black,
        controller_alpha = 0.7,
        boundaries = red,
        background = yellowish_white
    }
}

theme_names = {
    "black_red",
    "white_red"
}