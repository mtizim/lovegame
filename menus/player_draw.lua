player_draw = {}
-- all the balls are hardcoded here

function player_draw:draw(x,y,rot,rad)
    self.width = settings.lineball_width
    self.current = drawable[settings.player_model]
    love.graphics.setLineWidth(self.width)
    self.current.draw(x,y,rot,rad)
    -- drawable.ball.draw(x,y,rot,rad,"line")
end

drawable = {}

drawable.ball = {}
function drawable.ball.draw(x,y,rot,rad)
    love.graphics.circle("line",x,y,rad)
end

drawable.square = {}
function drawable.square.draw(x,y,rot,rad)
    local a = 1.77 * rad -- sqrt(pi) * r
    x = x - a/2
    y = y - a/2
    rotatedRectangle("line",x,y,a,a,rot)
end

drawable.square_hypno = {}
function drawable.square_hypno.draw(x,y,rot,rad)
    local a = 1.77 * rad -- sqrt(pi) * r
    local diff = 1/4 * a
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate( - rot)
        for i=0,3 do
            local shift  = - a/2
            love.graphics.rectangle("line",shift,shift,a,a)
            love.graphics.rotate(math.pi * 0.05)
            a = a - diff
        end
    love.graphics.pop()
end

drawable.triangle = {}
function drawable.triangle.draw(x,y,rot,rad)
    local a = rad * 2.69 -- * 4 pi / sqrt(3)
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate( - rot)
        local on = math.sqrt(3) * a / 6
        love.graphics.polygon("line",
                              0,  2*on,
                              a / 2, -on,
                              -a / 2,-on)
        
    love.graphics.pop()
end

drawable.triangle_hypno = {}
function drawable.triangle_hypno.draw(x,y,rot,rad)
    local a = rad * 2.69 -- * 4 pi / sqrt(3)
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate( - rot)
        for i=0,3 do
            a = a * (3-i)/3
            local on = math.sqrt(3) * a / 6
            love.graphics.polygon("line",
                                0,  2*on,
                                a / 2, -on,
                                -a / 2,-on)
            love.graphics.rotate(math.pi * 0.05)
        end
        
    love.graphics.pop()
end

drawable.triangle_circle = {}
function drawable.triangle_circle.draw(x,y,rot,rad)
    local a = rad * 2.69 -- * 4 pi / sqrt(3)
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate( - rot)
        local on = math.sqrt(3) * a / 6
        love.graphics.polygon("line",
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

drawable.ball_fill = {}
function drawable.ball_fill.draw(x,y,rot,rad)
    love.graphics.circle("fill",x,y,rad)
end

drawable.square_fill = {}
function drawable.square_fill.draw(x,y,rot,rad)
    local a = 1.77 * rad -- sqrt(pi) * r
    x = x - a/2
    y = y - a/2
    rotatedRectangle("fill",x,y,a,a,rot)
end

drawable.star_fill = {}
function drawable.star_fill.draw(x,y,rot,rad)
    local a = 1.77 * rad -- sqrt(pi) * r
    x = x - a/2
    y = y - a/2
    rotatedRectangle("fill",x,y,a,a,rot)
    rotatedRectangle("fill",x,y,a,a,rot + math.pi/4)
end

drawable.star = {}
function drawable.star.draw(x,y,rot,rad)
    local a = 1.77 * rad -- sqrt(pi) * r
    x = x - a/2
    y = y - a/2
    rotatedRectangle("line",x,y,a,a,rot)
    rotatedRectangle("line",x,y,a,a,rot + math.pi/4)
end

drawable.star_hypno = {}
function drawable.star_hypno.draw(x,y,rot,rad)
    drawable.star.draw(x,y,rot,rad)
    drawable.star.draw(x,y,rot + math.pi/2,rad/1.41)
end

drawable.triangle_fill = {}
function drawable.triangle_fill.draw(x,y,rot,rad)
    local a = rad * 2.69 -- * 4 pi / sqrt(3)
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate( - rot)
        local on = math.sqrt(3) * a / 6
        love.graphics.polygon("fill",
                              0,  2*on,
                              a / 2, -on,
                              -a / 2,-on)
        
    love.graphics.pop()
end

drawable.pentagon = {}
function drawable.pentagon.draw(x,y,rot,r)
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate(math.pi/2 - rot)
        love.graphics.polygon("line",
                              0, r,
                              r*(-0.951), r*0.309,
                              r*(-0.5877),r*(-0.809),
                              r*0.5877,r*(-0.809),
                              r*0.951, r*0.309)
    love.graphics.pop()
end

drawable.pentagram_help = {}
function drawable.pentagram_help.draw(x,y,rot,rad)
    local r = rad * 1.21
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate(math.pi/2 - rot)
        love.graphics.polygon("line",
                              0, r,
                              r*(-0.5877),r*(-0.809),
                              r*0.951, r*0.309,
                              r*(-0.951), r*0.309,
                              r*0.5877,r*(-0.809))
    love.graphics.pop()
end

drawable.pentagram = {}
function drawable.pentagram.draw(x,y,rot,rad)
    local r = rad * 1.21
    drawable.pentagram_help.draw(x,y,rot,r)
    drawable.pentagram_help.draw(x,y,rot,r*0.8)
end

drawable.pentagram_hypno = {}
function drawable.pentagram_hypno.draw(x,y,rot,rad)
    local r = rad * 1.21
    drawable.pentagram_help.draw(x,y,rot,r)
    drawable.pentagram_help.draw(x,y,rot,r*0.45)
    -- drawable.pentagram_help.draw(x,y,rot,r*0.016)
end

drawable.plus_fill = {}
function drawable.plus_fill.draw(x,y,rot,rad)
    rad = rad * 1.2
    local w = rad / 2
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate(-rot)
        love.graphics.rectangle("fill",-w/2,-rad,w,2*rad)
        love.graphics.rectangle("fill",-rad,-w/2,2*rad,w)
    love.graphics.pop()
end

drawable.plus = {}
function drawable.plus.draw(x,y,rot,rad)
    rad = rad * 1.2
    local w = rad / 2
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate(-rot)
        for i=1,4 do
        love.graphics.line(-w/2,-w/2,
                            -w/2,-rad,
                            w/2,-rad,
                            w/2,-w/2)
        love.graphics.rotate(math.pi/2)
        end
    love.graphics.pop()
end

drawable.plus_hypno = {}
function drawable.plus_hypno.draw(x,y,rot,rad)
    drawable.plus.draw(x,y,rot,rad)
    rad = rad * 0.8
    local w = rad *0.2
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate(-rot)
        for i=1,4 do
        love.graphics.line(-w/2,-w/2,
                            -w/2,-rad,
                            w/2,-rad,
                            w/2,-w/2)
        love.graphics.rotate(math.pi/2)
        end
    love.graphics.pop()
end

drawable.pentagon_fill = {}
function drawable.pentagon_fill.draw(x,y,rot,r)
    love.graphics.push()
        love.graphics.translate(x,y)
        love.graphics.rotate( - rot)
        love.graphics.polygon("fill",
                              0, r,
                              r*(-0.951), r*0.309,
                              r*(-0.5877),r*(-0.809),
                              r*0.5877,r*(-0.809),
                              r*0.951, r*0.309)
    love.graphics.pop()
end

player_draw_list = {"ball_fill","ball","hypno","pentagon_fill","pentagon",
                    "star","star_fill","star_hypno","square","square_fill","square_hypno",
                    "triangle","triangle_fill","triangle_hypno","triangle_circle",
                    "pentagram","pentagram_hypno","plus","plus_fill","plus_hypno"
                    }                    