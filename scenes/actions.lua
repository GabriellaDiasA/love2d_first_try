local SceneRouter = require("scenes.router")
local Bindings    = require("player.controls.bindings")
local Control     = require("player.control")
local Actions     = {}
local ui_actions  = {
    "engage", "up", "down", "left", "right", "back"
}

function Actions.update(schema)
    local scene = SceneRouter:get_scene()

    for _, action in ipairs(ui_actions) do
        local bind = Bindings:key(schema, action)
        if Control.check(bind, 1) then
            if scene[action] then scene[action](scene) end
        end
    end
end

return Actions
