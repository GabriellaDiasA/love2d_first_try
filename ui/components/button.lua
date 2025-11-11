local Class        = require("utils.class")
local Box          = require("ui.components.box")
local SceneRouter  = require("scenes.router")

---@class Button: Container, Color, Box
---@field focus_color table
---@field focused boolean
---@field action function
local Button       = Box:new({})
Button.focus_color = { 0, 0, 1, 1 }
Button.focused     = false
Button.action      = function(self) print("hi!") end
Button.__index     = Button
Class.inherit(Button, { Box })

function Button:new(params)
    local opts = params or {}
    local instance = setmetatable(Box:new(opts), self)

    if params.focus_color ~= nil then
        instance.focus_color = params.focus_color
    else
        instance.focus_color = instance.color
    end

    if params.action then instance.action = params.action end

    return instance
end

function Button:focus()
    self.focused = true
end

function Button:unfocus()
    self.focused = false
end

function Button:engage()
    if self.action then self.action() end
end

function Button.change_scene(scene)
    return function(self) SceneRouter:next(scene) end
end

return Button
