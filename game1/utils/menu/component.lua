---@class Component
---@field name string?
local Component = {
    name = nil
}

function Component:new(o)
    local p = o or {}
    setmetatable(p, self)
    self.__index = self
    return p
end

function Component:draw(option, menu, i)
    if self.name ~= nil then
        require("utils.menu.components." .. self.name).draw(menu, option, i)
    else
        require("utils.menu.components.default").draw(menu, option, i)
    end
end

return Component
