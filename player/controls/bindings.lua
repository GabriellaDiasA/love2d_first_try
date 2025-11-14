local Bind = require("player.controls.bind")

local Bindings = {
    ["game"] = {
        ["strike"] = Bind:new("z", "a"),
        ["dash"] = Bind:new("c", "rightshoulder")
    },
    ["menu"] = {
        ["engage"] = Bind:new("mouse1", "a"),
        ["return"] = Bind:new("escape", "b"),
        ["up"] = Bind:new("up", "dpup"),
        ["down"] = Bind:new("down", "dpdown"),
        ["right"] = Bind:new("down", "dpdown"),
        ["left"] = Bind:new("left", "dpleft")
    }
}

---Returns the required key
---@param schema string menu or game
---@param action string actions for the desired schema
---@return Bind
function Bindings:key(schema, action)
    return self[schema][action]
end

function Bindings:bind(schema, action, input_type, key)
    self[schema][action]:bind(input_type, key)
end

function Bindings:unbind(schema, action, input_type)
    self[schema][action]:unbind(input_type)
end

return Bindings
