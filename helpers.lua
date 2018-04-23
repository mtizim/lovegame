function rect_collision(x1,y1,x2,y2, x3,y3,x4,y4)
    w1 = x2 - x1
    h1 = x2 - x1
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end


function sgn(x)
    if x < 0 then return -1 end
    if x > 0 then return 1 end
    if x == 0 then return 0 end
end


function rotatedRectangle(mode, x, y, w, h, r)
    r = r
    ox = x + w/2
    oy = y + h/2

    love.graphics.push()
      love.graphics.translate(ox, oy )
      love.graphics.push()
        love.graphics.rotate( -r )
        love.graphics.rectangle( mode, -w/2, -h/2, w, h)
      love.graphics.pop()
    love.graphics.pop()
  end