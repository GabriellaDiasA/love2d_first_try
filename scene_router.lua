---SceneRouter object
---@class SceneRouter
---@field name string
local SceneRouter = {
    current_scene = InitialScene
}
local ScenesDirectory = "scenes."

function SceneRouter:update_scene(dt)
    self:get_scene():update(dt)
end

function SceneRouter:draw_scene()
    self:get_scene():draw()
end

function SceneRouter:set_scene(string)
    self.current_scene = string
    self:get_scene():load()
end

function SceneRouter:dimensions()
    return self:get_scene().scene:dimensions()
end

function SceneRouter:get_scene()
    return require(ScenesDirectory .. self.current_scene)
end

return SceneRouter
