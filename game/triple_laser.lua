triplelaserClass = Class("triple laser")

function triplelaserClass:init(collider)
    self.collider = collider
    self.time = 0
    self.destroyed = false
    self.spawned_all = false
end

function triplelaserClass:update(dt)
    self.time = self.time + dt
    if not self.one then
        local x = math.random(window_width / settings.triplelaser_area,
                              window_width * (1 - 1/settings.triplelaser_area))
        local y = math.random(window_height / settings.triplelaser_area,
                              window_height * (1 - 1/settings.triplelaser_area))
        local r = math.pi * 2 * math.random()
        self.one = laserClass(x,y,r,
                            settings.laser_width,
                            max,
                            settings.laser_width,
                            max,
                            settings.triplelaser_explode_time,
                            settings.triplelaser_stay_time,
                            self.collider,
                            settings.triplelaser_collision_timer)
    end
    if not self.two and self.one and self.time > settings.triplelaser_laser_delay then
        local x = math.random(window_width / settings.triplelaser_area,
                              window_width * (1 - 1/settings.triplelaser_area))
        local y = math.random(window_height / settings.triplelaser_area,
                              window_height * (1 - 1/settings.triplelaser_area))
        local r = self.one.rotation +  math.pi / 2 * (0.5 * math.random() + 0.25)
        self.two = laserClass(x,y,r,
                            settings.laser_width,
                            max,
                            settings.laser_width,
                            max,
                            settings.triplelaser_explode_time,
                            settings.triplelaser_stay_time,
                            self.collider,
                            settings.triplelaser_collision_timer)
    end
    if not self.three and self.two and 
    self.time > 2 * settings.triplelaser_laser_delay then
        self.spawned_all = true
        local x = math.random(window_width / settings.triplelaser_area,
                              window_width * (1 - 1/settings.triplelaser_area))
        local y = math.random(window_height / settings.triplelaser_area,
                              window_height * (1 - 1/settings.triplelaser_area))
        local r = self.two.rotation +  math.pi / 2 * (0.5 * math.random() + 0.25)
        self.three = laserClass(x,y,r,
                            settings.laser_width,
                            max,
                            settings.laser_width,
                            max,
                            settings.triplelaser_explode_time,
                            settings.triplelaser_stay_time,
                            self.collider,
                            settings.triplelaser_collision_timer)
    end

    if self.spawned_all and self.three.destroyed then
        self.one = nil
        self.two = nil
        self.three = nil
        self.destroyed = true
    end

    if self.one then self.one:update(dt) end
    if self.two then self.two:update(dt) end
    if self.three then self.three:update(dt) end
end


function triplelaserClass:draw()
    if self.one then self.one:draw() end
    if self.two then self.two:draw() end
    if self.three then self.three:draw() end
end
    