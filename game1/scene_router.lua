local MainMenu = require("scenes.main_menu")
local SettingsMenu = require("scenes.settings_menu")
local Gameplay = require("scenes.gameplay")

---SceneRouter object
---@class SceneRouter
---@field name string
local SceneRouter = {
    current_scene = nil
}

local routing = {
    ["main_menu"] = MainMenu,
    ["gameplay"] = Gameplay,
    ["settings_menu"] = SettingsMenu
}

---Creates a new SceneRouter object
---@param o table
---@return SceneRouter
function SceneRouter:new(o)
    local p = o or {}
    setmetatable(p, self)
    self.__index = self
    return p
end

function SceneRouter:update_scene(dt)
    routing[self.current_scene]:update(dt)
end

function SceneRouter:draw_scene()
    routing[self.current_scene].scene:do_scale()
    routing[self.current_scene]:draw()
    routing[self.current_scene].scene:undo_scale()
end

function SceneRouter:set_scene(string)
    self.current_scene = string
end

function SceneRouter:dimensions()
    return routing[self.current_scene].scene:dimensions()
end

return SceneRouter
