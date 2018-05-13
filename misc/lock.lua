function draw_lock(x,y,height)
    -- 10 x 14 lock
    local ps = height / 14
    love.graphics.push()
    love.graphics.translate(x - 5*ps,y - 9 * ps)
    -- lock 
    love.graphics.rectangle("fill",ps,0,8*ps,ps)
    love.graphics.rectangle("fill",ps,ps,ps,4*ps)
    love.graphics.rectangle("fill",8*ps,ps,ps,4*ps)
    -- rectangle
    love.graphics.rectangle("fill",0,5*ps,ps,9*ps)
    love.graphics.rectangle("fill",9*ps,5*ps,ps,9*ps)
    love.graphics.rectangle("fill",0,5*ps,10*ps,ps)
    love.graphics.rectangle("fill",0,13*ps,10*ps,ps)
    -- keyspace
    love.graphics.rectangle("fill",3*ps,8*ps,ps,2*ps)
    love.graphics.rectangle("fill",6*ps,8*ps,ps,2*ps)
    love.graphics.rectangle("fill",4*ps,7*ps,2*ps,4*ps)
    love.graphics.pop()
end
