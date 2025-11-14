local Scene = require("scene")
local Vector = require("utils.vector")
local SceneRouter = require("scenes.router")

local Gameplay = {
    scene = Scene:new({ scale = Vector.new(2, 2) }),
    control_schema = "game"
}

function Gameplay:load()
    for _, p in ipairs(Players) do
        p:init(Graphics)
    end
end

function Gameplay:update(dt)
    for _, p in ipairs(Players) do
        p:update(dt)
    end
    if Players[1].input:get_pressed("start") then
        SceneRouter:next("main_menu")
    end
end

function Gameplay:draw()
    for x = 0, Tiles_x do
        for y = 0, Tiles_y do
            love.graphics.draw(Graphics, Background_tile, x * 16, y * 16)
        end
    end
    for _, p in ipairs(Players) do
        p:draw()
    end
end

return Gameplay
