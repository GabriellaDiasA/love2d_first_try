local Vector    = require("utils.vector")
local Scene     = require("scene")
local Container = require("ui.components.container")
local Button    = require("ui.components.button")
local Layout    = require("ui.layout")


local MainMenu = {
    scene = Scene:new({ scale = Vector.new(1, 1) }),
    elements = {
        Button:new({ text = "Button1", width = 200, height = 80, color = { 0, 1, 0 } }),
        Button:new({ text = "Button2", width = 200, height = 80, color = { 0, 0, 1 } }),
        Button:new({ text = "Button3", width = 200, height = 80, color = { 1, 0, 0 } })
    },
    container = Container:new({ canvas = TextCanvas, position = Vector.new() })
}

function MainMenu:load()
    Layout.vertical_bottom(self, { margin = 10, spacing = 5 })
    Layout.horizontal_center(self, {})
end

function MainMenu:update(dt)
    for _, element in ipairs(self.elements) do
        element:update(dt)
    end
end

function MainMenu:draw()
    self.container:render_to(function()
        for _, element in ipairs(self.elements) do
            element:draw()
        end
    end)
    self.container:draw()
end

return MainMenu
