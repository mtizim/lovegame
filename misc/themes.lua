local red = {0.85 , 0 ,0}
local white = {0.9 ,0.9 ,0.9}
local white_transparent = {white[1],white[2],white[3], 0.1}
local black = {0.1, 0.1 ,0.1}
local black_transparent = {black[1],black[2],black[3], 0.1}
local yellowish_white = {0.9,0.9,0.82}
local blue = {0.1,0.1,0.9}
local blue_less = {0.1,0.1,0.8}
gold = {1,0.84,0}
local gold_dark = {0.64, 0.55, 0.1}
local gold_dark_transparent = {gold_dark[1],gold_dark[2],gold_dark[3], 0.3}
local gold_transparent = {gold[1],gold[2],gold[3], 0.1}

function invert(color)
    if not color[4] then
        return {1 - color[1],1- color[2],1 - color[3]}
    else
        return {1 - color[1],1- color[2],1 - color[3],color[4]}
    end
end


themes = {}
themes["blackredwhite"] = 
    {
        primary = black,
        secondary = red,
        laser = red,
        laser_exploded = white,
        player = red,
        controller =  white,
        controller_alpha = 0.3, 
        boundaries = white,
        background = black,
        collectible = blue,
        coin = gold,
        score = white_transparent,
        missile = white,

        menu_button = white,
        beaten_highscore = gold,
        beaten_score = gold_transparent,
        highscore = red,
    }

themes["whiteredblack"] =
    {
        primary = white,
        secondary = red,
        laser = black,
        laser_exploded = red,
        player = black,
        controller = black,
        controller_alpha = 0.7,
        boundaries = red,
        background = yellowish_white,
        collectible = blue_less,
        coin = gold_dark,
        score = black_transparent,
        missile = red,

        menu_button = red,
        beaten_highscore = black,
        beaten_score = gold_dark_transparent,
        highscore = black,
    }
themes["whiteredblack_inv"] =
    {
        primary = invert(white),
        secondary = invert(red),
        laser = invert(black),
        laser_exploded = invert(red),
        player = invert(black),
        controller = invert(black),
        controller_alpha = 0.7,
        boundaries = invert(red),
        background = invert(yellowish_white),
        collectible = invert(blue_less),
        coin = invert(gold_dark),
        score = invert(black_transparent),
        missile = invert(red),

        menu_button = invert(red),
        beaten_highscore = invert(black),
        beaten_score = invert(gold_dark_transparent),
        highscore = invert(black),
    }

    theme_names = {}
    for key,_ in pairs(themes) do
        theme_names[#theme_names + 1] = key
    end
    -- theme_names = {"black/red","white/red"}