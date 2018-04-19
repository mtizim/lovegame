function rect_collision(x1_,y1,x2,y2, x3,y3,x4,y4)
    w1 = x2 - x1
    h1 = x2 - x1
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end