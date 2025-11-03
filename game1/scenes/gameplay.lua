local Scene = require("scene")
local Vector = require("utils.vector")

local Gameplay = {
    scene = Scene:new({ scale = Vector.new(2, 2) })
}

function Gameplay:update(dt)
    for _, p in ipairs(Players) do
        p:update(dt)
    end
    if Players[1].input:get_pressed("start") then
        CurrentScene:set_scene("main_menu")
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
