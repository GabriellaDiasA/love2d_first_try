local Settings = {
    controller_deadzone = 0.3
}

function Settings:new(o)
    local p = o or {}
    setmetatable(p, self)
    self.__index = self
    return p
end

function Settings:set_deadzone(value)
    self.controller_deadzone = value
end

return Settings