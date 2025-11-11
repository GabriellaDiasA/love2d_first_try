---Router object
---@class Router
---@field current_scene string
local Router = {
    current_scene = InitialScene,
    history = {}
}
local ScenesDirectory = "scenes."

function Router:update_scene(dt)
    self:get_scene():update(dt)
end

function Router:draw_scene()
    self:get_scene():draw()
end

function Router:load()
    self:get_scene():load()
end

function Router:set_scene(string)
    self.current_scene = string
end

function Router:next(string)
    table.insert(self.history, #self.history + 1, string)
    self:set_scene(string)
end

function Router:back()
    if #self.history == 0 then
        love.event.quit()
    else
        local last_scene = self.history[#self.history]
        table.remove(self.history, #self.history)
        self:set_scene(last_scene)
        self:load()
    end
end

function Router:dimensions()
    return self:get_scene().scene:dimensions()
end

function Router:get_scene()
    if self.current_scene then
        return require(ScenesDirectory .. self.current_scene)
    else
        self:set_scene(InitialScene)
        return require(ScenesDirectory .. self.current_scene)
    end
end

function Router:control_scheme()
    return self:get_scene().controls
end

return Router
