local Vector = require("utils.vector")
local Config = require("player.config")
local Settings = require("player.settings")
local SceneRouter = require("scenes.router")
local Joystick = require("player.controls.joystick")


---@class Player
---@field input Joystick
local Player = {
    acceleration = Vector.new(),
    velocity = Vector.new(),
    last_position = Vector.new(),
    position = Vector.new(),
    dimension = Vector.new(16, 16),
    boostable = true,
    time_since_last_boost = 0,
    collision = { horizontal = false, vertical = false },
    display = nil,
    action = "idle",
    flipped = false,
    input = Joystick,
    joystick_index = nil,
    input_mode = "controller",
    settings = Settings:new()
}
Player.__index = Player


function Player:new(o)
    local p = o or {}
    setmetatable(p, self)
    return p
end

function Player:init(graphics)
    local player_tile = love.graphics.newQuad(0, 0, 16, 16, graphics)
    self.input = Joystick:new(self.joystick_index)
    self:model(player_tile)
    return self
end

function Player:update(dt)
    self:move(dt)
end

function Player:move(dt)
    local movement_input = self.input:get_movement()
    self.acceleration = Vector.new()

    self:update_acceleration(movement_input, dt)
    self:update_position()
    self:update_action()

    if self.acceleration.x < 0 and movement_input.x < 0.15 then
        self.flipped = true
    elseif self.acceleration.x > 0 and movement_input.x > 0.15 then
        self.flipped = false
    end
end

function Player:update_acceleration(movement_input, dt)
    local deadzone = self.settings.controller_deadzone
    local input_magnitude = Vector.magnitude(movement_input)
    local manual_acceleration_factor = 10

    -- relevant input detected
    if input_magnitude > deadzone then
        local effective_input = (input_magnitude - deadzone) / (1 - deadzone) -- Normalize to 0-1
        self.acceleration = Vector.scale(movement_input, effective_input * dt * manual_acceleration_factor)

        -- Handling turning with a 0, 0 velocity vector can lead to unforseen consequences
        if Vector.magnitude(self.velocity) > 0.1 then
            self:handle_turning(movement_input)
        end
    end

    self:compute_friction(movement_input, dt)
    self.acceleration = Vector.min_scale(self.acceleration, Config.max_acceleration)
    self:handle_boost(dt)
    self:update_velocity()
end

function Player:compute_friction(movement_input, dt)
    local speed = Vector.magnitude(self.velocity)
    if speed > Config.friction_threshold then
        -- Dynamic friction based on input state
        local friction_factor = speed * Config.friction * dt
        if Vector.magnitude(movement_input) <= 0.3 then
            friction_factor = friction_factor * 3 -- Quick stop when no input
        end

        local friction_force = Vector.scale(self.velocity, -friction_factor)
        self.acceleration = Vector.add(self.acceleration, friction_force)
    elseif Vector.magnitude(movement_input) <= 0.3 then
        self.velocity = Vector.new()
    end
end

function Player:update_velocity()
    local next_velocity = Vector.add(self.velocity, self.acceleration)
    self.velocity = Vector.max_scale(Vector.min_scale(next_velocity, Config.max_speed), Config.min_speed)
end

function Player:update_position()
    self.last_position.x = self.position.x
    self.last_position.y = self.position.y
    local border = Vector.subtract(SceneRouter:dimensions(), self.dimension)
    local next_position = Vector.add(self.position, self.velocity)

    self:handle_collisions(next_position, border)

    self.position = Vector.max(Vector.min(next_position, border), Origin)
end

function Player:update_action()
    if Vector.magnitude(self.velocity) > 0 then
        self.action = "moving"
    else
        self.action = "idle"
    end
end

function Player:handle_turning(movement_input)
    local angle = Vector.angle_between(movement_input, self.velocity)
    local turning_factor = (angle * angle * Config.turning_factor) + 1
    self.acceleration = Vector.multiply(self.acceleration, turning_factor)
end

function Player:handle_boost(dt)
    self.time_since_last_boost = self.time_since_last_boost + dt
    local boost = self.input:get_pressed("a")
    if self.time_since_last_boost > Config.boost_recharge_seconds and not boost then
        self.boostable = true
    end

    if
        boost
        and self.boostable
        and Vector.magnitude(self.input:get_movement()) > self.settings.controller_deadzone then
        local boost_acceleration = Vector.scale(Vector.normalize(self.input:get_movement()), Config.boost_factor)
        self.acceleration = Vector.add(self.acceleration, boost_acceleration)
        self.boostable = false
        self.time_since_last_boost = 0
    end
end

function Player:handle_collisions(next_position, border)
    local collision_detected = false
    local horizontal_collision = false
    local vertical_collision = false
    local normal = Vector.new()

    if next_position.x > border.x then
        normal.x = -self.velocity.x * Config.damping
        collision_detected = true
        horizontal_collision = true
        self.velocity.x = 0
    elseif next_position.x < Origin.x then
        normal.x = -self.velocity.x * Config.damping
        collision_detected = true
        horizontal_collision = true
        self.velocity.x = 0
    end

    if next_position.y > border.y then
        normal.y = -self.velocity.y * Config.damping
        collision_detected = true
        vertical_collision = true
        self.velocity.y = 0
    elseif next_position.y < Origin.y then
        normal.y = -self.velocity.y * Config.damping
        collision_detected = true
        vertical_collision = true
        self.velocity.y = 0
    end

    if collision_detected and Vector.magnitude(normal) > Config.bounce_threshold then
        if horizontal_collision then
            self.velocity.x = normal.x
        end

        if vertical_collision then
            self.velocity.y = normal.y
        end
    end

    next_position = Vector.add(self.position, self.velocity)
end

function Player:model(quad)
    local tile_x = 18
    local tile_y = 7
    local step = 17

    if self.action == "idle" then
        tile_x = 18
        tile_y = 7
    elseif self.action == "moving" then
        tile_x = 20
    end

    local start_x = tile_x * step
    local end_x = self.dimension.x
    local start_y = tile_y * step
    local end_y = self.dimension.y
    quad:setViewport(start_x, start_y, end_x, end_y)
    self.display = quad
end

function Player:draw()
    self:model(self.display)

    local scale_x = 1
    local offset_x = 0

    if self.flipped then
        scale_x = -1
        offset_x = self.dimension.x
    end

    local transform = love.math.newTransform(math.floor(self.position.x), math.floor(self.position.y), 0, scale_x, 1,
        offset_x, 0)

    love.graphics.draw(Graphics, self.display, transform)

    Vector.draw(self.position, self.velocity, { color = { 255, 0, 0 }, scale = 10, rotation = 0 })
    Vector.draw(self.position, self.acceleration, { color = { 0, 255, 0 }, scale = 100, rotation = 0.01 })
end

return Player
