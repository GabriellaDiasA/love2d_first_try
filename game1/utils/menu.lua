local Option = require("utils.menu.option")

---@class Menu
---@field cursor_position number
---@field font table
---@field options table
---@field menu_roll_time number
---@field time_since_last_menu_roll number
---@field menu_actions table
local Menu = {
    cursor_position = 1,
    font = love.graphics.newFont(16),
    options = {},
    menu_roll_time = 0.2,
    time_since_last_menu_roll = 0,
    menu_actions = {}
}

---New Menu item
---@param o table
---@return Menu
function Menu:new(o)
    local options = {}

    if o.options ~= nil then
        for i, option in ipairs(o.options) do
            options[i] = Option:new(option)
        end

        o.options = options
    end

    local p = o or {}
    setmetatable(p, self)
    self.__index = self
    return p
end

function Menu:update(dt)
    local player = Players[1]

    if self.time_since_last_menu_roll > self.menu_roll_time then
        if player.input:get_down("dpup") then
            self:option_up()
        elseif player.input:get_down("dpdown") then
            self:option_down()
        end
    end

    if player.input:get_pressed("a") then
        self:execute_item()
    end

    self.time_since_last_menu_roll = self.time_since_last_menu_roll + dt
end

function Menu:execute_item()
    local opt = self.options[self.cursor_position]

    if opt ~= nil then
        local action = self.menu_actions[opt.name]
        if action ~= nil then
            action()
        end
    end
end

function Menu:option_up()
    self.time_since_last_menu_roll = 0

    self.cursor_position = self.cursor_position - 1

    if self.cursor_position == 0 then
        self.cursor_position = #self.options
    end
end

function Menu:option_down()
    self.time_since_last_menu_roll = 0

    self.cursor_position = self.cursor_position + 1

    if self.cursor_position > #self.options then
        self.cursor_position = 1
    end
end

function Menu:draw()
    TextCanvas:renderTo(function()
        love.graphics.clear()
        for i, option in ipairs(self.options) do
            option:draw(self, i)
        end
        love.graphics.setColor({ 1, 1, 1, 1 })
    end)
end

return Menu
