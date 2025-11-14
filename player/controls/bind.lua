---@class Bind
---@field mkboard string mouse1, mouse2 etc
---@field joystick string a, b, x, y etc
---@field mode string pressed, released, held, down, up
local Bind = {
    mkboard = "",
    joystick = "",
    mode = ""
}

function Bind:new(mkboard, joystick, mode)
    local opt = mode or "pressed"
    local instance = { mkboard = mkboard, joystick = joystick, mode = opt }
    return setmetatable(instance, self)
end

function Bind:bind(type, input)
    self[type] = input
end

function Bind:unbind(type)
    self[type] = nil
end
