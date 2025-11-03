local Vector = require("utils.vector")

---Scene object
---@class Scene
---@field name string
local Scene = {
    scale = Vector.new(1, 1)
}

---Creates a new Scene object
---@param o table
---@return Scene
function Scene:new(o)
    local p = o or {}
    setmetatable(p, self)
    self.__index = self
    return p
end

function Scene:do_scale()
    love.graphics.scale(self.scale.x, self.scale.y)
end

function Scene:undo_scale()
    love.graphics.scale(1 / self.scale.x, 1 / self.scale.y)
end

function Scene:dimensions()
    return Vector.new(ScreenDimensions.x / self.scale.x, ScreenDimensions.y / self.scale.y)
end

return Scene
