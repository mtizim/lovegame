application = {}

--Takes care of scenes
function application:init()
    local game = gameClass()
    self.current = game
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
    collectgarbage()
    print(collectgarbage("count"))
    self.current:update(dt)
end

function application:draw()
    self.current:draw()
end