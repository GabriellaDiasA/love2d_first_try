local Box    = require("ui.components.container")
local Class  = require("utils.class")

---@class Cell: Box
---@field cells table
---@field color table
local Cell   = Box:new({})
Cell.cells   = {}
Cell.rows    = 2
Cell.columns = 2
Cell.__index = Cell
Class.inherit(Cell, { Box })

function Cell:new(params)
    local opts = params or {}
    local instance = setmetatable(Box:new(opts), self)

    return instance
end

function Cell:update(dt)
    self:render_to(function()
        love.graphics.clear(0, 0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, self:get_width(), self:get_height())
    end)
end

return Cell
