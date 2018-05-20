rotating_laserClass = Class("rotating_laser")

function rotating_laserClass:init(collider,r)
    self.time = 0
    self.destroyed = false
    self.dir = 2*math.random(0,1) - 1
    self.collider = collider
    self.r = r
    self.laser_one = laserClass(
        window_width/2, window_height/2, r,
        settings.laser_width, max/2,
        settings.laser_width, max/2,
        settings.rotatinglaser_appear, settings.rotatinglaser_duration,
        collider, settings.rotatinglaser_collision_timer
    )
    self.laser_two = laserClass(
        window_width/2, window_height/2, r + math.pi/2,
        settings.laser_width, max/2,
        settings.laser_width, max/2,
        settings.rotatinglaser_appear, settings.rotatinglaser_duration,
        collider, settings.rotatinglaser_collision_timer
    )
end

function  rotating_laserClass:destroy()
    self.laser_one:destroy()
    self.laser_two:destroy()
    self.destroyed = true
end

function rotating_laserClass:update(dt)
    self.time = self.time + dt
    local dr = settings.rotatinglaser_rps * dt * self.dir
    self.r = (self.r + dr) % (2 * math.pi)
    self.laser_one.rotation = self.r
    self.laser_two.rotation = self.r + math.pi/2
    if self.laser_one.hc_object then
        self.laser_one.hc_object:rotate(-dr)
    end
    if self.laser_two.hc_object then
        self.laser_two.hc_object:rotate(-dr)
    end
    self.laser_one:update(dt)
    self.laser_two:update(dt)
    if self.time >
    settings.rotatinglaser_appear + settings.rotatinglaser_duration then
        self:destroy()
    end
end

function rotating_laserClass:draw()
    self.laser_one:draw()
    self.laser_two:draw()
    -- if self.laser_one.hc_object then
        -- self.laser_one.hc_object:draw()
        -- self.laser_two.hc_object:draw()
    -- end
end
