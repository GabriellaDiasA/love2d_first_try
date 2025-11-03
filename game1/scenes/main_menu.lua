local Menu = require("utils.menu")
local Option = require("utils.menu.option")
local Vector = require("utils.vector")
local Scene = require("scene")

local menu_actions = {
    ["start_game"] = function() CurrentScene:set_scene("gameplay") end,
    ["settings"] = function() CurrentScene:set_scene("settings") end,
    ["quit"] = function() love.event.quit() end
}

local options = {
    { text = "Start Game", enabled = true, name = "start_game", component = { name = "big_text" } },
    { text = "Settings", enabled = true, name = "settings" },
    { text = "Credits", enabled = false, name = "credits" },
    { text = "Quit", enabled = true, name = "quit" }
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

local MainMenu = Menu:new(params)

return MainMenu
