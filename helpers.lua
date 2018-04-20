function rect_collision(x1_,y1,x2,y2, x3,y3,x4,y4)
    w1 = x2 - x1
    h1 = x2 - x1
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end


function rotatedRectangle( mode, x, y, w, h, r)
    -- Check to see if you want the rectangle to be rounded or not:
    -- Set defaults for rotation, offset x and y
    r = r or 0
    ox = x + w / 2
    oy = y + h / 2
    -- You don't need to indent these; I do for clarity
    love.graphics.push()
      love.graphics.translate( x + ox, y + oy )
      love.graphics.push()
        love.graphics.rotate( -r )
        love.graphics.rectangle( mode, -ox, -oy, w, h)
      love.graphics.pop()
    love.graphics.pop()
  end