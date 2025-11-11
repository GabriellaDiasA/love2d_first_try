local function keyboard(key)
    return { key = key, source = "keyboard" }
end

local function mouse(key)
    return { key = key, source = "mouse" }
end

local function joystick(key)
    return { key = key, source = "joystick" }
end

local game_joystick_to_mkboard = {
    ["a"] = mouse(1),
    ["b"] = keyboard("lshift"),
    ["x"] = mouse(2),
    ["y"] = keyboard("r"),
    ["back"] = keyboard("q"),
    ["guide"] = nil,
    ["start"] = keyboard("space"),
    ["leftstick"] = nil,
    ["rightstick"] = nil,
    ["leftshoulder"] = nil,
    ["rightshoulder"] = nil,
    ["dpup"] = keyboard("w"),
    ["dpdown"] = keyboard("s"),
    ["dpleft"] = keyboard("a"),
    ["dpright"] = keyboard("d")
}

local game_action_to_joystick = {
    ["up"] = joystick("dpup"),
    ["down"] = joystick("dpdown"),
    ["engage"] = joystick("a")
}

local Controls = {
    ["game"] = { to_mkboard = game_joystick_to_mkboard, action_to_joystick = game_action_to_joystick },
    ["menu"] = { to_mkboard = game_joystick_to_mkboard, action_to_joystick = game_action_to_joystick }
}

function Controls:action_to_key(type, input, action)
    local mapping = self[type]
    local to_joystick = mapping.action_to_joystick

    if input == "joystick" then
        return to_joystick[action]
    else
        return mapping.to_mkboard[to_joystick[action].key]
    end
end

return Controls
