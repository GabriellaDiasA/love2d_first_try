local Cursor = require("ui.cursor")
local Controls = require("ui.controls")
local Container = require("ui.components.container")
local SceneRouter = require("scenes.router")

---@class Menu
---@field children table
---@field background_color table
---@field container Container
local Menu = {
    children = {},
    background_color = {},
    container = Container:new()
}

function Menu:scroll(direction)
    if not self.children then return end

    local elements = self:get_interactible_children()

    elements[Cursor.index]:unfocus()

    if Cursor[direction] then Cursor[direction](Cursor, elements) end

    elements[Cursor.index]:focus()
end

function Menu:engage()
    local index = Cursor:get_index()

    self:get_interactible_children()[index]:engage()
end

function Menu:back()
    SceneRouter:back()
end

function Menu:update(dt)
    for _, element in ipairs(self.children) do
        if element.update then element:update(dt) end
    end

    Controls.update()
end

function Menu:draw()
    self.container:render_to(function()
        if self.background_color then
            love.graphics.setBackgroundColor(unpack(self.background_color))
        end
        for _, element in ipairs(self.children) do
            if Debug and element.inspect then element:inspect() end
            if element.draw then element:draw() end
        end
    end)
    self.container:draw()
end

function Menu:get_interactible_children()
    local aggregate = {}
    local position = 1

    for _, elem in ipairs(self.children) do
        if elem.action then
            table.insert(aggregate, position, elem)
            position = position + 1
        end
    end

    return aggregate
end

function Menu:get_static_children()
    local aggregate = {}
    local position = 1

    for _, elem in ipairs(self.children) do
        if not elem.action then
            table.insert(aggregate, position, elem)
            position = position + 1
        end
    end

    return aggregate
end

return Menu
