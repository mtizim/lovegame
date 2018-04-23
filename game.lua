gameClass = Class()


function gameClass:init(offset)
    local x, y = 30, 100
    local vx, vy = 7, 3
    local ax, ay = 0,0
    local size = 15
    
    window_width, window_height = love.graphics.getDimensions()
    self.offset = offset
    -- top bottom left right
    self.bounding_box = { offset, window_height - offset,
    offset, window_width  - offset}
    -- x y vx vy ax ay size
    self.player = playerClass( x, y,
    vx, vy,
    ax, ay, size)
    
    self.enemies = linkedlistClass()
end

function gameClass:new_laser(width,height,time,r_time,color,explodedcolor)
    local offset = self.offset
    local player = self.player
    local x = math.random( 2 * offset, window_width - 2 * offset )
    local y = math.random( 2 * offset, window_height - 2 * offset)
    local r = math.atan2( x - player.x, y - player.y)
    laser = laserClass(x,y,r,
                       width,height,
                       width, height * 100,
                       time,r_time,
                       color,explodedcolor)
    self.enemies:add(laser)
end


-- really basic
function gameClass:drawBoundaries(colorArray)
    love.graphics.setColor(colorArray)
    love.graphics.rectangle("fill",0,0,window_width, self.offset)
    love.graphics.rectangle("fill",0,window_height,window_width, -self.offset)
    love.graphics.rectangle("fill",0,0,self.offset,window_height)
    love.graphics.rectangle("fill",window_width,0,-self.offset,window_height)
end

function gameClass:update(dt)
    self.player:update(dt,self.bounding_box)
    self:new_laser(10,100,8,1,{1,0,0},{0,1,1})
    self.enemies:remove_destroyed()
    self.enemies:update_forall(dt)
    print(self.enemies.length)
end

function gameClass:draw()
    self.player:draw({1,0,0})
    self.enemies:draw_forall()
    self:drawBoundaries({1,1,1})
end