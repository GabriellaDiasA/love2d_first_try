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
---@param params? table
---@return Container
function Container:new(params)
    local opts = params or {}
    local instance = setmetatable({}, self)

    instance:new_canvas(opts)

    if opts.position ~= nil then
        instance.position = Vector.new(opts.position)
    else
        instance.position = Vector.new()
    end
    return instance
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

function Container:new_canvas(opts)
    if opts.height and opts.width then
        self.canvas = love.graphics.newCanvas(opts.width, opts.height)
    elseif opts.canvas then
        self.canvas = opts.canvas
    else
        self.canvas = love.graphics.newCanvas(ScreenDimensions.x, ScreenDimensions.y)
    end
end

function Container:draw()
    love.graphics.draw(self.canvas, self.position.x, self.position.y)
end

function Container:render_to(func)
    self.canvas:renderTo(func)
end

return Container
