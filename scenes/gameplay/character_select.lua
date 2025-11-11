local Scene       = require("scene")
local Vector      = require("utils.vector")
local SceneRouter = require("scenes.router")
local Container   = require("ui.components.container")
local Layout      = require("ui.layout")
local Class       = require("utils.class")
local Button      = require("ui.components.button")
local Box         = require("ui.components.box")
local Menu        = require("ui.menu")


local title    = Box:new({
    text = { value = "SELECT A CHARACTER", align_x = "center", align_y = "center", font = 64, color = { 1, 1, 1 } },
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


---@class CharacterSelect: Menu
---@field scene Scene
---@field controls string
local CharacterSelect = {
    scene = Scene:new({ scale = Vector.new(1, 1) }),
    children = {
        title,
        button_1,
        button_2
    },
    container = Container:new({ canvas = TextCanvas }),
    background_color = { 0.04, 0, 0.05 },
    controls = "menu"
}
CharacterSelect.__index = CharacterSelect
Class.inherit(CharacterSelect, { Menu })

function CharacterSelect:load()
    for _, p in ipairs(Players) do
        p:init(Graphics)
    end
end

function CharacterSelect:update(dt)

end

function CharacterSelect:draw()

end

return CharacterSelect
