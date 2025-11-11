---@class Color
---@field color table
---@field focus_color table
---@field focused? boolean
local Color = {
    pre_color = nil,
    color = { 1, 1, 1, 1 }
}
Color.__index = Color

function Color:engage_color()
    local r, g, b, a = love.graphics.getColor()
    local color = self.color
    if self.focused and self.focus_color then color = self.focus_color end
    self:set_pre_color({ r, g, b, a })
    love.graphics.setColor(unpack(color))
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
