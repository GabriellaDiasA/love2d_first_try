local Class        = require("utils.class")
local Box          = require("ui.components.box")

---@class Button: Container, Color, Box
---@field focus_color table
---@field focused boolean
local Button       = Box:new({})
Button.focus_color = { 0, 0, 1, 1 }
Button.focused     = false
Button.__index     = Button
Class.inherit(Button, { Box })

function Button:new(params)
    local opts = params or {}
    local instance = setmetatable(Box:new(opts), self)

    if params.focus_color ~= nil then
        instance.focus_color = params.focus_color
    else
        instance.focus_color = instance.color
    end

    return instance
end

-- function Button:update(dt)
--     self:render_to(function()
--         love.graphics.clear(0, 0, 0, 0)
--         self:engage_color()
--         love.graphics.rectangle("fill", 0, 0, self:get_width(), self:get_height(), self:corner())
--         self:reset_color()
--         self.text:draw(self)
--     end)
-- end

return Button
