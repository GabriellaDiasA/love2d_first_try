local Class  = require("utils.class")
local Color  = require("ui.components.color")

---@class Text: Color
local Text   = {
    text = "PLACEHOLDER!!",
    align_x = "center",
    align_y = "center",
    font = 24,
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
    instance.align_y = Text.align_y
    instance.font = self:make_font(opts.font)
    instance.color = opts.color or Text.color
    instance.limit = opts.limit or Text.limit

    setmetatable(instance, self)
    return instance
end

local function get_y(self, container)
    if self.align_y == "center" then
        return (container:get_height() - self.font:getHeight()) / 2
    elseif self.align_y == "top" then
        return 0
    elseif self.align_y == "bottom" then
        return container:get_height() - self.font:getHeight()
    else
        return 0
    end
end

function Text:make_font(size)
    if size then
        return love.graphics.newFont(size)
    else
        return love.graphics.newFont(self.font)
    end
end

function Text:draw(container)
    self:engage_color()
    local limit = self.limit or container:get_width()
    local y = get_y(self, container)
    love.graphics.printf({ self.color, self.text }, self:get_font(), 0, y, limit, self.align_x)
    self:reset_color()
end

function Text:get_font()
    return self.font or love.graphics.getFont()
end

return Text
