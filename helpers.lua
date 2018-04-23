function sgn(x)
    if x < 0 then return -1 end
    if x > 0 then return 1 end
    if x == 0 then return 0 end
end

node = Class("node")

function node:init(value,next)
    self.value ,self.next = value,next
end

linkedlistClass = Class()


function linkedlistClass:init(value)
    if value then
        self.head = node(value,nil) 
        self.tail = self.head
        self.length = 1
    end
end

function linkedlistClass:at(i)
    local current = self.head
    for i=1,(i-1) do
        current = current.next
    end
    return current
end

function linkedlistClass:update_forall(dt)
    local current
    if self.head then
        current = self.head
        while current do
            current.value:update(dt)
            current = current.next
        end
    end
end

function linkedlistClass:remove(i)
    if i == 1 then
        self.head = self:at(2)
        return
    end
    local before = self:at(i-1)
    -- so it skips the ith node
    before.next = before.next.next
    self.length = self.length -1
end

function linkedlistClass:remove_destroyed()
    local current = self.head
    local before
    if self.length then
        for i=1,self.length do
            if current.value.destroyed then
                if current == self.head then
                    self.head = self.head.next
                    current.value = nil
                else 
                    before.next = current.next
                    current.value = nil
                end
                self.length = self.length - 1
            end
            before = current
            current = current.next
        end
        self.tail.next = nil
    end
end

function linkedlistClass:draw_forall(funct)
    if self.head then
        local current = self.head
        while current do
            current.value:draw()
            current = current.next
        end
    end
end

function linkedlistClass:add(value)
    if not self.head then
        self.head = node(value,nil)
        self.tail = self.head
        self.length = 1
        return
    end
    self.tail.next = node(value,nil)
    self.tail = self.tail.next
    self.length = self.length + 1
end


function rotatedRectangle(mode, x, y, w, h, r)
    local r = r
    local ox = x + w/2
    local oy = y + h/2

    love.graphics.push()
      love.graphics.translate(ox, oy )
      love.graphics.push()
        love.graphics.rotate( -r )
        love.graphics.rectangle( mode, -w/2, -h/2, w, h)
      love.graphics.pop()
    love.graphics.pop()
end