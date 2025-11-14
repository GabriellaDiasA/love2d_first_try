local Vector    = require("utils.vector")
local Scene     = require("scene")
local Container = require("ui.components.container")
local Button    = require("ui.components.button")
local Box       = require("ui.components.box")
local Menu      = require("ui.menu")
local Layout    = require("ui.layout")
local Class     = require("utils.class")


local title    = Box:new({
    text = { value = "EPICSAUCE VIDEOGAEMZ XDD", align_x = "center", align_y = "center", font = 64, color = { 1, 1, 1 } },
    width = 700,
    height = 200
})
local button_1 = Button:new({
    text = { value = "START GAME", align_x = "center", align_y = "center", font = 32, color = { 0.9, 0.9, 0.9 } },
    width = 250,
    height = 80,
    color = { 0.8, 0, 0.8 },
    focus_color = { 1, 0, 1 },
    action = Button.change_scene("gameplay")
})
local button_2 = Button:new({
    text = { value = "SETTINGS", align_x = "center", align_y = "center", color = { 0.8, 0.8, 0.8 } },
    width = 200,
    height = 65,
    color = { 0.7, 0.1, 0.7 },
    focus_color = { 0.8, 0.2, 0.8 },
    action = Button.change_scene("gameplay")

})
local button_3 = Button:new({
    text = { value = "CREDITS", align_x = "center", align_y = "center", color = { 0.8, 0.8, 0.8 } },
    width = 200,
    height = 65,
    color = { 0.7, 0.1, 0.7 },
    focus_color = { 0.8, 0.2, 0.8 },
    action = Button.change_scene("credits")
})
local button_4 = Button:new({
    text = { value = "QUIT", align_x = "center", align_y = "center", color = { 0.8, 0.8, 0.8 } },
    width = 200,
    height = 65,
    color = { 0.7, 0.1, 0.1 },
    focus_color = { 1, 0, 0 },
    action = function() love.event.quit() end
})


local MainMenu   = {
    scene = Scene:new({ scale = Vector.new(1, 1) }),
    children = {
        title,
        button_1,
        button_2,
        button_3,
        button_4
    },
    container = Container:new({ canvas = TextCanvas }),
    background_color = { 0.04, 0, 0.05 },
    control_schema = "menu"
}

MainMenu.__index = MainMenu
Class.inherit(MainMenu, { Menu })

function MainMenu:load()
    Layout.vertical_bottom(self, self:get_interactible_children(), { margin = 10, spacing = 5 })
    Layout.vertical(self, self:get_static_children(), { margin = 10, spacing = 5 })
    Layout.horizontal_center(self, self.children, {})
end

return MainMenu
