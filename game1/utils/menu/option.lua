local Component = require("utils.menu.component")

---@class Option
---@field text string
---@field enabled boolean
---@field name string
---@field component Component
local Option = {
    text = "Start Game",
    enabled = true,
    name = "start_game",
    font = nil,
    component = Component:new()
}

function Option:new(o)
    if o.component ~= nil then
        o.component = Component:new(o.component)
    end
    local p = o or {}
    setmetatable(p, self)
    self.__index = self
    return p
end

function Option:draw(menu, i)
    if self.font ~= nil then
        love.graphics.setFont(self.font)
    elseif menu.font ~= nil then
        love.graphics.setFont(menu.font)
    end
    self.component:draw(self, menu, i)
end

return Option
