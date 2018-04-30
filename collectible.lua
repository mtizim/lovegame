collectibleClass = Class("collectible")

function collectibleClass:init(x,y,
                               size,color,
                               collider)
    self.x = x
    self.y = y
    self.size = size
    self.collider = collider
    self.hc_object = collider:circle(x,y,size)
    self.destroyed = false
    self.chomped = false
    self.alpha = 0
    self.color = color
end

function collectibleClass:collision_check()
    local player = application.current.player
    if self.hc_object:collidesWith(player.hc_object) then
        self.chomped = true
        player.score = player.score + 1
    end
end

function collectibleClass:destroy()
    self.destroyed = true
    self.collider:remove(self.hc_object)
    self.hc_object = nil
end

function collectibleClass:fadeStep(dt)
    self.alpha = self.alpha - dt * settings.collectible_fade_time
end

function collectibleClass:update(dt)
    if not self.chomped then
        self:collision_check()
        self.alpha = math.min(self.alpha + settings.collectible_fadein * dt, 1)
    else self:fadeStep(dt) end 
    if self.alpha <= 0 and self.chomped then self:destroy() end
end

function collectibleClass:draw()
    love.graphics.setColor(self.color[1],self.color[2],self.color[3],
                           self.alpha)
    love.graphics.circle("fill", self.x, self.y, self.size)
end
