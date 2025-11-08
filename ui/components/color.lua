---@class Color
---@field color table
local Color = {
    pre_color = nil,
    color = { 1, 1, 1, 1 }
}
Color.__index = Color

function Color:engage_color()
    local r, g, b, a = love.graphics.getColor()
    self:set_pre_color({ r, g, b, a })
    love.graphics.setColor(unpack(self.color))
end

function Color:set_pre_color(rgba)
    self.pre_color = rgba
end

function Color:set_color(rgba)
    self.color = rgba
end

function Color:reset_color()
    love.graphics.setColor(unpack(self.pre_color))
end

return Color
