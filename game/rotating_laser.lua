rotating_laserClass = Class("rotating_laser")

function rotating_laserClass:init(collider,r)
    self.destroyed = false
    self.collider = collider
    self.r = r
    self.laser = laserClass(
        window_width/2, window_height/2, r,
        settings.laser_width, settings.laser_height * 100,
        settings.laser_width, settings.laser_height * 100,
        settings.rotatinglaser_appear, settings.rotatinglaser_duration,
        collider, settings.rotatinglaser_collision_timer
    )
end

function  rotating_laserClass:destroy()
    self.laser:destroy()
    self.destroyed = true
end

function rotating_laserClass:update(dt)
    self.r = (self.r + settings.rotatinglaser_rps * dt) % 6.28
    self.laser:update(dt)
end

function rotating_laserClass:draw()
    self.laser:draw()
end
