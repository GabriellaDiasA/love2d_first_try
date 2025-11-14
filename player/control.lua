local MKBoard = require("player.controls.mkboard")

local Control = {}

---Checks whether a certain bind is currently fullfilled
---@param bind Bind
---@param player_index number? which player
---@return boolean
function Control.check(bind, player_index)
    local idx = player_index or 1
    local player_joystick = Players[idx].input

    local mkboard = MKBoard.get_by_mode(bind.mode, bind.mkboard)
    local joystick = player_joystick:get_by_mode(bind.mode, bind.joystick)

    return mkboard or joystick
end

return Control
