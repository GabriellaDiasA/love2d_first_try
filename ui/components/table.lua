local Container = require("ui.components.container")
local Class     = require("utils.class")
local Cursor    = require("ui.cursor")

---@class Table: Container
---@field cells table
---@field rows number
---@field columns number
---@field focused boolean
---@field cursor Cursor
local Table     = Container:new({})
Table.cells     = {}
Table.rows      = 2
Table.columns   = 2
Table.focused   = false
Table.cursor    = Cursor:new()
Table.__index   = Table
Class.inherit(Table, { Container })

function Table:new(params)
    local opts = params or {}
    local instance = setmetatable(Container:new(opts), self)
    instance.rows = opts.rows or Table.rows
    instance.columns = opts.columns or Table.columns
    instance.focused = opts.focused or Table.focused
    instance.cursor = Cursor:new()

    return instance
end

function Table:update(dt)
    self:render_to(function()
        love.graphics.clear(0, 0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, self:get_width(), self:get_height())
    end)
end

return Table
