-- The whole class is needed so that i can iterate and add
-- lasers to the active lasers list
-- it might be easily used for any other enemy should i add them
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
            -- dev: helpful for hitboxes
            -- if current.value.hc_object then
            --     current.value.hc_object:draw("line")
            -- end
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

--Self explanatory
function check_collision(object_a,object_b)
    if object_a and object_b then
        return object_a:collidesWith(object_b)
    end
    return false
end

-- Love2d doesn't have this for some reason
-- so i needed to write one myself
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