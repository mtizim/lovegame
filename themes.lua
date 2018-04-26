local red = {229.5 , 0 ,0}
local white = {229.5 ,229.5 ,229.5}
local black = {25.5, 25.5 ,25.5}
local yellowish_white = {229.5,229.5,183.6}


themes = {
    black_red = 
    {
        laser = red,
        laser_exploded = white,
        player = red,
        controller =  white,
        controller_alpha = 76.5, 
        boundaries = white,
        background = black,
    },
    white_red =
    {
        laser = black,
        laser_exploded = red,
        player = black,
        controller = black,
        controller_alpha = 178.5,
        boundaries = red,
        background = yellowish_white
    }
}

theme_names = {
    "black_red",
    "white_red"
}