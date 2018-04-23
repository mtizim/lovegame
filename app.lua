application = {}

function application:init()
    local offset = 10
    game = gameClass(offset)
    self.current = game
end

function application:update(dt)
    self.current:update(dt)
end

function application:draw()
    self.current:draw()
end