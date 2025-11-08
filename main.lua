if arg[2] == "debug" then
    require("lldebugger").start()
end

GraphicsPath = "colored.png"
local Player = require("player")
local SceneRouter = require("scene_router")
require("global_variables")

function love.load()
    Players = {}

    for n, _ in ipairs(love.joystick.getJoysticks()) do
        Players[n] = Player:new({ joystick_index = n })
    end

    love.graphics.setDefaultFilter("nearest", "nearest")
    MainCanvas = love.graphics.newCanvas()
    DebugCanvas = love.graphics.newCanvas()
    TextCanvas = love.graphics.newCanvas()
    GameplayCanvas = love.graphics.newCanvas()
    Debug = false
    Graphics = love.graphics.newImage(GraphicsPath)
    Tiles_x = math.ceil(love.graphics.getWidth() / 16) + 1
    Tiles_y = math.ceil(love.graphics.getHeight() / 16) + 1
    SceneRouter:set_scene("main_menu")
    for _, p in ipairs(Players) do
        p:init(Graphics)
    end

    Background_tile = love.graphics.newQuad(0, 0, 16, 16, Graphics)
end

function love.update(dt)
    SceneRouter:update_scene(dt)

    for _, p in ipairs(Players) do
        p.input:update()
    end
end

function love.draw()
    love.graphics.reset()
    MainCanvas:renderTo(function()
        love.graphics.clear()
        DebugCanvas:renderTo(function()
            love.graphics.clear()
        end)
        TextCanvas:renderTo(function()
            love.graphics.clear()
        end)
        GameplayCanvas:renderTo(function()
            love.graphics.clear()
        end)
        SceneRouter:draw_scene()
    end)
    love.graphics.draw(MainCanvas)
end
