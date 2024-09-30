-- basically the same as the collectible class
-- but i might want the flexibility idk so i made the mdifferent files
coinClass = Class("coin")

function coinClass:init(x,y,
                               size,color,
                               collider)
    self.x = x
    self.y = y
    self.size = size
    self.collider = collider
    -- yeah magic numbers here but it's definitely here to stay
    self.hc_object = collider:circle(x,y,
            size + 2*(settings.player_size - settings.player_collision_size))
    self.destroyed = false
    self.chomped = false
    self.alpha = 0
    self.disappearing_time = settings.coin_time
    self.hit = false
    self.color = color
end

function coinClass:collision_check()
    local player = application.current.player
    if self.hc_object:collidesWith(player.hc_object) then
        self.chomped = true
        self.disappearing_time = 1 / settings.collectible_fade_time
        self.alpha = 1
        self.hit = true
        settings.coins = settings.coins + 1
        application.current:coin_collision()
    end
end

function coinClass:destroy()
    self.destroyed = true
    self.collider:remove(self.hc_object)
    self.hc_object = nil
end

function coinClass:fadeStep(dt)
    self.alpha = self.alpha - dt / self.disappearing_time
end

function coinClass:update(dt)
    if not self.hit then self:collision_check() end
    if not self.chomped then
        self.alpha = math.min(self.alpha + settings.collectible_fadein * dt, 1)
    else self:fadeStep(dt) end
    if self.alpha == 1 then self.chomped = true end
    if self.alpha <= 0 and self.chomped then self:destroy() end
end

function coinClass:draw()
    drawCoin(self.color,self.x + 7,self.y - 8,self.alpha)
end


function drawCoin(color, x,y, alpha)
    love.graphics.setColor(color[1],color[2],color[3],alpha)
    rotatedRectangle("fill",x - 7,y + 8,14,22,0)

    love.graphics.setColor(0,0,0,0.5*alpha)
    local dx = 5
    local dy = 5
    rotatedRectangle("fill",x - 7 + dx,y + 8 + dy,14 - 2*dx,22 - 2*dy ,0)
    love.graphics.setColor(0,0,0,0.3 * alpha)

end