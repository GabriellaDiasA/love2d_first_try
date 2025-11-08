local Text         = require("ui.components.text")
local Container    = require("ui.components.container")
local Vector       = require("utils.vector")

---@class Button: Container
---@field text Text
---@field color table
---@field focus_color table
---@field focused boolean
local Button       = Container:new({})
Button.text        = Text:new("")
Button.color       = { 1, 1, 1 }
Button.focus_color = { 1, 1, 1 }
Button.focused     = false
Button.__index     = Button

function Button:new(params)
    local instance = params or {}
    local height = instance.height or self:get_height()
    local width = instance.width or self:get_width()
    local canvas = love.graphics.newCanvas(width, height)

    instance.position = Vector.new()

    if params.text ~= nil then
        instance.text = Text:new(params.text, width)
    end

    if params.color ~= nil then
        instance.color = params.color
    end

    if params.focus_color ~= nil then
        instance.focus_color = params.focus_color
    else
        instance.focus_color = instance.color
    end
    setmetatable(instance, self)
    instance:set_canvas(canvas)
    return instance
end

function Button:update(dt)
    self:render_to(function()
        love.graphics.clear(0, 0, 0, 0)
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", 0, 0, self:get_width(), self:get_height())
        self.text:draw(self)
    end)
end

return Button
