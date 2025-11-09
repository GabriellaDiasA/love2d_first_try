local Text      = require("ui.components.text")
local Container = require("ui.components.container")
local Vector    = require("utils.vector")
local Class     = require("utils.class")
local Color     = require("ui.components.color")

---@class Box: Container, Color
---@field text Text
---@field inspected boolean
---@field color table
local Box       = Container:new({})
Box.text        = Text:new()
Box.color       = { 0, 0, 0, 0 }
Box.inspected   = false
Box.__index     = Box
Class.inherit(Box, { Container, Color })

function Box:new(params)
    local opts = params or {}
    local instance = setmetatable(Container:new(opts), self)
    local width = instance:get_width()
    local text_opts = params.text or { limit = width }
    if text_opts.limit == nil then text_opts.limit = width end

    if params.text ~= nil then
        instance.text = Text:new(params.text.value, text_opts)
    end

    if params.color ~= nil then
        instance.color = params.color
    end

    return instance
end

function Box:inspect()
    if not self.inspected then
        print("BOX with dimensions x=", self:get_width(), " and y=",
            self:get_height(), "COLORS=", unpack(self.color))
        self.inspected = true
    end
end

function Box:update(dt)
    self:render_to(function()
        love.graphics.clear(0, 0, 0, 0)
        self:engage_color()
        love.graphics.rectangle("fill", 0, 0, self:get_width(), self:get_height(), self:corner())
        self:reset_color()
        self.text:draw(self)
    end)
end

function Box:corner()
    return self:get_width() / 30
end

return Box
