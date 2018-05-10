application = {}

--Takes care of scenes
function application:init()
    local scene = gameClass()
    self.current = scene
    self.time_elapsed = 0
end

function application:change_scene_to(scene)
    self.current:destroy()
    self.current = nil
    collectgarbage()
    self.current = scene
end
 
function application:restart_game()
    self:change_scene_to( gameClass() )
end

function application:update(dt)
    self.current:update(dt)
end

function application:draw()
    self.current:draw()
end