local SceneRouter = require("scenes.router")
local Controls = {}

function Controls.update()
    local input = Players[1].input
    local scene = SceneRouter:get_scene()
    if input:get_pressed("dpdown") then
        if scene.scroll then scene:scroll("down") end
    elseif input:get_pressed("dpup") then
        if scene.scroll then scene:scroll("up") end
    elseif input:get_pressed("a") then
        if scene.engage then scene:engage() end
    elseif input:get_pressed("y") then
        if scene.back then scene:back() end
    end
end

return Controls
