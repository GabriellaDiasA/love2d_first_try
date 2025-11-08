local Class = require("utils.class")
local Color = require("ui.components.color")

---@class Text: Color
local Text   = {
    text = "PLACEHOLDER!!",
    align_x = "center",
    font = love.graphics.newFont(24),
    color = { 1, 1, 1, 1 },
    limit = 100
}
Text.__index = Text
Class.inherit(Text, { Color })

function Text:new(text, params)
    local opts = params or {}
    local text_default = Text.text
    local instance = { text = text or text_default }
    instance.align_x = Text.align_x
    instance.font = opts.font or Text.font
    instance.color = opts.color or Text.color
    instance.limit = opts.limit or Text.limit

    setmetatable(instance, self)
    return instance
end

function Text:draw(container)
    self:engage_color()
    local limit = self.limit or container:get_width()
    love.graphics.printf({ self.color, self.text }, self:get_font(), 0, 0, limit, self.align_x)
    self:reset_color()
end

function Text:get_font()
    return self.font or love.graphics.getFont()
end

return Text
