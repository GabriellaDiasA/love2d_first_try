local mode_dictionary = require("player.controls.mode_dictionary")
local ButtonState     = require("player.controls.button_state")
local Vector          = require("utils.vector")


local buttons_down = {
    ["mouse1"] = ButtonState:new(),
    ["mouse2"] = ButtonState:new(),
    ["mouse3"] = ButtonState:new(),
    ["mouse4"] = ButtonState:new(),
    ["mouse5"] = ButtonState:new()
}

local MKBoard      = {
    buttons_down = buttons_down,
    movement = Vector.new()
}

function MKBoard.register(key)
    if buttons_down[key] == nil then
        buttons_down[key] = ButtonState:new(true)
    end
end

function MKBoard.get_button_type(button_name)
    return string.match(button_name, "mouse")
end

function MKBoard.get_true_down(button_name)
    if MKBoard.get_button_type(button_name) == "mouse" then
        local substring = string.match(button_name, "(%d)")
        local index = tonumber(substring) or 1
        return love.mouse.isDown(index)
    else
        return love.keyboard.isDown(button_name)
    end
end

function MKBoard.get_by_mode(mode, key)
    local func = mode_dictionary[mode]

    MKBoard[func](key)
end

function MKBoard.update(dt)
    for button_name, state in pairs(MKBoard.buttons_down) do
        if MKBoard.get_true_down(button_name) then
            state:down(dt)
        else
            state:up()
        end
    end
end

---Checks whether a button was recently pressed
---Using the "down_sice" state could result in this function
---returning true in two consecutive updates
---@param name string
---@return boolean
function MKBoard.get_pressed(name)
    local down_now = MKBoard.get_true_down(name)
    local down_before = MKBoard.get_down(name)
    return (down_now and not down_before)
end

---Checks whether a button was recently released
---@param name string
---@return boolean
function MKBoard.get_released(name)
    local down_now = MKBoard.get_true_down(name)
    local down_before = MKBoard.get_down(name)
    return (down_before and not down_now)
end

---Checks whether a button is down
function MKBoard.get_down(name)
    return MKBoard.buttons_down[name].down
end

---Checks whether a button is up (not down)
function MKBoard.get_up(name)
    return not MKBoard.buttons_down[name].down
end

---Checks whether a button is held
function MKBoard.get_held(name)
    return MKBoard.buttons_down[name].down_since >= BUTTON_HOLD_THRESHOLD
end

return MKBoard
