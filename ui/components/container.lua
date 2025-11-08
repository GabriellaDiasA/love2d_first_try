local Vector = require("utils.vector")

---@class Container
---@field position Vector
---@field canvas table
local Container = {
    position = Vector.new(),
    canvas = love.graphics.newCanvas()
}
Container.__index = Container

---New container
---@param opts table
---@return Container
function Container:new(opts)
    local c = {}
    local dimensions = Vector.new(love.graphics.getWidth(), love.graphics.getHeight())

    if opts.width ~= nil then
        dimensions.x = opts.width
    end

    if opts.height ~= nil then
        dimensions.y = opts.height
    end

    if opts.canvas ~= nil then
        c.canvas = opts.canvas
    else
        c.canvas = love.graphics.newCanvas(dimensions.x, dimensions.y)
    end

    if opts.position ~= nil then
        c.position = opts.position
    else
        c.position = Vector.new()
    end
    setmetatable(c, self)
    return c
end

function Container:to_transform()
    return love.math.newTransform(self:get_width(), self:get_height(), 0, 1, 1, self.position.x,
        self.position.y, 0, 0)
end

function Container:get_width()
    return self.canvas:getWidth()
end

function Container:get_height()
    return self.canvas:getHeight()
end

function Container:set_canvas(canvas)
    self.canvas = canvas
end

function Container:draw()
    love.graphics.draw(self.canvas, self.position.x, self.position.y)
end

function Container:render_to(func)
    self.canvas:renderTo(func)
end

return Container
