---@class Text
local Text = {
    text = "PLACEHOLDER!!",
    align_x = "center",
    font = love.graphics.newFont(24),
    color = { 1, 1, 1, 1 },
    limit = nil
}
Text.__index = Text

function Text:new(text, limit)
    local instance = {text = text}
    instance.align_x = Text.align_x
    instance.font = Text.font
    instance.color = Text.color
    instance.limit = limit or 100

    setmetatable(instance, self)
    return instance
end

function Text:draw(container)
    local r, g, b, a = love.graphics.getColor()

    -- Love2D uses LuaJIT, which still doesn't have table.unpack. To avoid warnings, we do it the long way.
    love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
    local limit = self.limit or container:get_width()
    love.graphics.printf({self.color, self.text}, self:get_font(), 0, 0, limit, self.align_x)
    love.graphics.setColor(r, g, b, a)
end

function Text:get_font()
    return self.font or love.graphics.getFont()
end

return Text
