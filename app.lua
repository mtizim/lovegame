application = {}

function application:init()
    local offset = 10
    local game = gameClass(offset,themes.black_red)
    self.current = game
    self.time_elapsed = 0
end

function application:change_scene_to(scene)
    self.current:destroy()
    self.current = nil
    collectgarbage()
    self.current = scene
end
 
function application:update(dt)
    self.current:update(dt)
end

function application:draw()
    self.current:draw()
end