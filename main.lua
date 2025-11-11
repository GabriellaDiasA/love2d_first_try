if arg[2] == "debug" then
    require("lldebugger").start()
end

local Player = require("player")
local SceneRouter = require("scenes.router")
require("global_variables")

local function register_players()
    if #Players == 0 then
        for n, _ in ipairs(love.joystick.getJoysticks()) do
            Players[n] = Player:new({ joystick_index = n })
            Players[n]:init(Graphics)
        end
    end
end

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    MainCanvas = love.graphics.newCanvas()
    DebugCanvas = love.graphics.newCanvas()
    TextCanvas = love.graphics.newCanvas()
    GameplayCanvas = love.graphics.newCanvas()
    Graphics = love.graphics.newImage(GraphicsPath)
    Tiles_x = math.ceil(love.graphics.getWidth() / 16) + 1
    Tiles_y = math.ceil(love.graphics.getHeight() / 16) + 1
    Background_tile = love.graphics.newQuad(0, 0, 16, 16, Graphics)
    register_players()
    SceneRouter:load()
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
        if Debug then love.graphics.draw(DebugCanvas) end
    end)
    love.graphics.draw(MainCanvas)
end
