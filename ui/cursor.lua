---@class Cursor
---@field vertical number
---@field horizontal number
local Cursor = {
    vertical = 1,
    horizontal = 1
}
Cursor.__index = Cursor

function Cursor:new(params)
    local instance = setmetatable(params or {}, Cursor)
    instance.vertical = 1
    instance.horizontal = 1
    return instance
end

function Cursor:down(elements)
    if self.vertical == #elements then
        self.vertical = 1
    else
        self.vertical = self.vertical + 1
    end
end

function Cursor:up(elements)
    if self.vertical == 1 then
        self.vertical = #elements
    else
        self.vertical = self.vertical - 1
    end
end

function Cursor:get_vertical()
    return self.vertical
end

return Cursor
