--- This module interfaces joysticks only.
local Vector = require("utils.vector")
local mode_dictionary = require("player.controls.mode_dictionary")
local ButtonState = require("player.controls.button_state")

local buttons_down = {
    ["a"] = ButtonState:new(),
    ["b"] = ButtonState:new(),
    ["x"] = ButtonState:new(),
    ["y"] = ButtonState:new(),
    ["back"] = ButtonState:new(),
    ["guide"] = ButtonState:new(),
    ["start"] = ButtonState:new(),
    ["leftstick"] = ButtonState:new(),
    ["rightstick"] = ButtonState:new(),
    ["leftshoulder"] = ButtonState:new(),
    ["rightshoulder"] = ButtonState:new(),
    ["dpup"] = ButtonState:new(),
    ["dpdown"] = ButtonState:new(),
    ["dpleft"] = ButtonState:new(),
    ["dpright"] = ButtonState:new()
}

---@class Joystick
---@field index number?
---@field movement Vector
---@field buttons_down table
local Joystick = {
    index = nil,
    movement = Vector.new(),
    buttons_down = buttons_down
}

function Joystick:new(joystick_index)
    local p = { index = joystick_index }
    setmetatable(p, self)
    self.__index = self
    return p
end

function Joystick:get_by_mode(mode, name)
    local func = mode_dictionary[mode]

    self[func](self, name)
end

function Joystick:get_joystick()
    local index = self.index
    local joysticks = love.joystick.getJoysticks()
    return joysticks[index]
end

function Joystick:update(dt)
    local joystick = self:get_joystick()

    for button_name, state in pairs(self.buttons_down) do
        if joystick ~= nil then
            if joystick:isGamepadDown(button_name) then
                state:down(dt)
            else
                state:up()
            end
        else
            state:up()
        end
    end
end

function Joystick:update_button()

end

---Checks whether a button was recently pressed
---Using the "down_sice" state could result in this function
---returning true in two consecutive updates
---@param name string
---@return boolean
function Joystick:get_pressed(name)
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
function Joystick:get_released(name)
    local joystick = self:get_joystick()
    if joystick ~= nil then
        local down_now = joystick:isGamepadDown(name)
        local down_before = self:get_down(name)
        return (down_before and not down_now)
    else
        return false
    end
end

---Checks whether a button is down
function Joystick:get_down(name)
    return self.buttons_down[name].down
end

---Checks whether a button is up (not down)
function Joystick:get_up(name)
    return not self.buttons_down[name].down
end

---Checks whether a button is held
function Joystick:get_held(name)
    return self.buttons_down[name].down_since >= BUTTON_HOLD_THRESHOLD
end

function Joystick:get_movement()
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

return Joystick
