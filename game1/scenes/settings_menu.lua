local Menu = require("utils.menu")
local Vector = require("utils.vector")
local Scene = require("scene")

local menu_actions = {
    ["deadzone"] = function() CurrentScene:set_scene("gameplay") end,
    ["return"] = function() CurrentScene:set_scene("main_menu") end
}

local options = {
    { text = "Controller Deadzone", enabled = true,  name = "deadzone" },
    { text = "Return", enabled = true, name = "return" }
}

local params = {
    scene = Scene:new({ scale = Vector.new(1, 1) }),
    cursor_position = 1,
    font = love.graphics.newFont(32, "mono"),
    options = options,
    menu_roll_time = 0.2,
    time_since_last_menu_roll = 0,
    menu_actions = menu_actions
}

local SettingsMenu = Menu:new(params)

return SettingsMenu
