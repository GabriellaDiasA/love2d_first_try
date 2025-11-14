local ButtonState = {}

---New button state
---@param param boolean?
---@return table
function ButtonState:new(param)
    local down = param or false
    return { down = down, down_since = 0 }
end

function ButtonState:down(dt)
    self.down = true
    self.down_since = self.down_since + dt
end

function ButtonState:up()
    self.down = false
    self.down_since = 0
end

return ButtonState
