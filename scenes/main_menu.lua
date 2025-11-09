local Vector    = require("utils.vector")
local Scene     = require("scene")
local Container = require("ui.components.container")
local Button    = require("ui.components.button")
local Box       = require("ui.components.box")
local Menu      = require("ui.menu")
local Layout    = require("ui.layout")
local Class     = require("utils.class")


local title    = Box:new({
    text = { value = "EPICSAUCE VIDEOGAMEZ XDD", align_x = "center", align_y = "center", font = 64, color = { 1, 1, 1 } },
    width = 700,
    height = 200
})
local button_1 = Button:new({
    text = { value = "START GAME", align_x = "center", align_y = "center", font = 32, color = { 0.9, 0.9, 0.9 } },
    width = 250,
    height = 80,
    color = { 0.8, 0, 0.8 }
})
local button_2 = Button:new({
    text = { value = "SETTINGS", align_x = "center", align_y = "center", color = { 0.8, 0.8, 0.8 } },
    width = 200,
    height = 65,
    color = { 0.7, 0.1, 0.7 }
})
local button_3 = Button:new({
    text = { value = "CREDITS", align_x = "center", align_y = "center", color = { 0.8, 0.8, 0.8 } },
    width = 200,
    height = 65,
    color = { 0.7, 0.1, 0.7 }
})
local button_4 = Button:new({
    text = { value = "QUIT", align_x = "center", align_y = "center", color = { 0.8, 0.8, 0.8 } },
    width = 200,
    height = 65,
    color = { 0.7, 0.1, 0.1 }
})


local MainMenu   = {
    scene = Scene:new({ scale = Vector.new(1, 1) }),
    ui_components = {
        button_1,
        button_2,
        button_3,
        button_4
    },
    hud_elements = { title },
    container = Container:new({ canvas = TextCanvas }),
    background_color = { 0.04, 0, 0.05 }
}

MainMenu.__index = MainMenu
Class.inherit(MainMenu, { Menu })

function MainMenu:load()
    Layout.vertical_bottom(self, self.ui_components, { margin = 10, spacing = 5 })
    Layout.vertical(self, self.hud_elements, { margin = 10, spacing = 5 })
    Layout.horizontal_center(self, self:get_all_children(), {})
end

return MainMenu
