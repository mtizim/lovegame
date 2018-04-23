application = {}

function application:init()
    local offset = 10
    local game = gameClass(offset)
    self.current = game
end

 sum = 0
 
function application:update(dt)
    self.current:update(dt)
    sum = sum + dt
    if sum > 1000 then
        self.current:destroy()
        self.current = nil
        collectgarbage()
        self.current = gameClass(10)
        sum = 0 
    end
end

function application:draw()
    self.current:draw()
end