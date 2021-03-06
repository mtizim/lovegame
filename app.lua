application = {}

--Takes care of scenes
function application:init()
    local scene = main_menuClass()
    self.current = scene
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