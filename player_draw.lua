player_draw = {}
-- all the balls are hardcoded here

function player_draw:draw(x,y,rot,rad)
    self.width = settings.lineball_width
    self.mode = settings.player_fill_mode
    self.current = drawable[settings.player_model]
    love.graphics.setLineWidth(self.width)
    self.current.draw(x,y,rot,rad,self.mode)
    -- drawable.ball.draw(x,y,rot,rad,"line")
end

drawable = {}

drawable.ball = {}
function drawable.ball.draw(x,y,rot,rad,mode)
    love.graphics.circle(mode,x,y,rad)
end

drawable.square = {}
function drawable.square.draw(x,y,rot,rad,mode)
    local a = 1.77 * rad -- sqrt(pi) * r
    x = x - a/2
    y = y - a/2
    rotatedRectangle(mode,x,y,a,a,rot)
end

drawable.square_hypno = {}
function drawable.square_hypno.draw(x,y,rot,rad,mode)
    local a = 1.77 * rad -- sqrt(pi) * r
    local diff = 1/3 * a
    for n=0,2 do
        local shift  = - a/2
        love.graphics.push()
            love.graphics.translate(x,y)
            love.graphics.rotate( - rot)
            love.graphics.rectangle("line",shift,shift,a,a)
        love.graphics.pop()
        a = a - diff
    end
end

drawable.triangle = {}
function drawable.triangle.draw(x,y,rot,rad,mode)
    local a = rad * 2.69 -- * 4 pi / sqrt(3)
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate( - rot)
        local on = math.sqrt(3) * a / 6
        love.graphics.polygon(mode,
                              0,  2*on,
                              a / 2, -on,
                              -a / 2,-on)
        
    love.graphics.pop()
end

drawable.triangle_circle = {}
function drawable.triangle_circle.draw(x,y,rot,rad,mode)
    local a = rad * 2.69 -- * 4 pi / sqrt(3)
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate( - rot)
        local on = math.sqrt(3) * a / 6
        love.graphics.polygon(mode,
                              0,  2*on,
                              a / 2, -on,
                              -a / 2,-on)
        love.graphics.circle("line",0,0,2*on)
    love.graphics.pop()
end

drawable.hypno = {}
function drawable.hypno.draw(x,y,_,rad)
    local diff = 1/3 * rad
    for n=0,2 do
        love.graphics.circle("line",x,y,rad - (n * diff))
    end
end


player_draw_list = {"ball","square","hypno","square_hypno","triangle","triangle_circle"}