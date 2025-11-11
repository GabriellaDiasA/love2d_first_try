local Vector = require("utils.vector")

local buttons_down = {
    ["a"] = false,
    ["b"] = false,
    ["x"] = false,
    ["y"] = false,
    ["back"] = false,
    ["guide"] = false,
    ["start"] = false,
    ["leftstick"] = false,
    ["rightstick"] = false,
    ["leftshoulder"] = false,
    ["rightshoulder"] = false,
    ["dpup"] = false,
    ["dpdown"] = false,
    ["dpleft"] = false,
    ["dpright"] = false
}

---@class Input
---@field index number?
---@field movement Vector
---@field buttons_down table
local Input = {
    index = nil,
    movement = Vector.new(),
    buttons_down = buttons_down
}

function Input:new(joystick_index)
    local p = { index = joystick_index }
    setmetatable(p, self)
    self.__index = self
    return p
end

function Input:get_joystick()
    local index = self.index
    local joysticks = love.joystick.getJoysticks()
    return joysticks[index]
end

function Input:set_down(name, down)
    self.buttons_down[name] = down
end

function Input:get_down(name)
    return self.buttons_down[name]
end

function Input:update()
    local joystick = self:get_joystick()

    for button_name, _ in pairs(self.buttons_down) do
        if joystick ~= nil then
            self:set_down(button_name, joystick:isGamepadDown(button_name))
        else
            self:set_down(button_name, false)
        end
    end
end

---Checks whether a button was recently pressed
---@param name string
---@return boolean
function Input:get_pressed(name)
    local joystick = self:get_joystick()
    if joystick ~= nil then
        local down_now = joystick:isGamepadDown(name)
        local down_before = self:get_down(name)
        return (not down_before and down_now)
    else
        return false
    end
end

---Checks whether a button was recently released
---@param name string
---@return boolean
function Input:get_released(name)
    local joystick = self:get_joystick()
    if joystick ~= nil then
        local down_now = joystick:isGamepadDown(name)
        local down_before = self:get_down(name)
        return (down_before and not down_now)
    else
        return false
    end
end

function Input:get_movement()
    local joystick = self:get_joystick()

    if joystick ~= nil then
        self.movement.x = joystick:getGamepadAxis("leftx")
        self.movement.y = joystick:getGamepadAxis("lefty")

        if joystick:isGamepadDown("dpleft") then
            self.movement.x = -1
        end

        if joystick:isGamepadDown("dpright") then
            self.movement.x = 1
        end

        if joystick:isGamepadDown("dpup") then
            self.movement.y = -1
        end

        if joystick:isGamepadDown("dpdown") then
            self.movement.y = 1
        end

        return self.movement
    else
        return Vector.new()
    end
end

return Input
