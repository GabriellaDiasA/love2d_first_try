---Bi-dimensional vector
---@class Vector
---@field x number
---@field y number
local Vector = {
    x = 0,
    y = 0
}

---New vector from two numbers
---@param x? number
---@param y? number
---@return Vector
function Vector.new(x, y)
    local horizontal = x or 0
    local vertical = y or 0
    local v = { x = horizontal, y = vertical }
    return v
end

---Prints vector coordinates to the command line
---@param v Vector
function Vector.print(pre, v)
    print(pre, v.x, v.y)
end

---Adds to vectors together
---@param a Vector
---@param b Vector
---@return Vector
function Vector.add(a, b)
    return Vector.new(a.x + b.x, a.y + b.y)
end

---Increases a vector's magnitude by a certain value
---@param v Vector
---@param n number
---@return Vector
function Vector.add_scalar(v, n)
    local m = Vector.multiply(Vector.normalize(v), n)
    return Vector.add(v, m)
end

---Subtracts the second vector from the first one
---@param a Vector
---@param b Vector
---@return Vector
function Vector.subtract(a, b)
    return Vector.new(a.x - b.x, a.y - b.y)
end

---A vector's magnitude
---@param v Vector
---@return number
function Vector.magnitude(v)
    return math.sqrt(v.x ^ 2 + v.y ^ 2)
end

---A vector's angle with the x axis
---@param v Vector
---@return number
function Vector.angle(v)
    return math.atan(v.y / v.x)
end

---Multiplies a vector with a number
---@param v Vector
---@param n number
---@return Vector
function Vector.multiply(v, n)
    return Vector.new(v.x * n, v.y * n)
end

---Scales a vector to a certain magnitude
---@param v Vector
---@param n number
---@return Vector
function Vector.scale(v, n)
    local magnitude = Vector.magnitude(v)
    if magnitude ~= 0 then
        local factor = (n / magnitude)
        local result = Vector.multiply(v, factor)
        return result
    else
        return Vector.new()
    end
end

---Normalizes a vector. Floating point imprecision applies.
---@param v Vector
---@return Vector
function Vector.normalize(v)
    return Vector.scale(v, 1)
end

---Returns the dot product value for two given vectors
---@param a Vector
---@param b Vector
---@return number
function Vector.dot_product(a, b)
    return a.x * b.x + a.y * b.y
end

---The angle between two vectors. Due to floats, we must limit the dot product.
---@param a Vector
---@param b Vector
---@return number
function Vector.angle_between(a, b)
    local dot = Vector.dot_product(Vector.normalize(a), Vector.normalize(b))
    dot = math.max(math.min(dot, 1), -1)
    return math.acos(dot)
end

---Rotates a vector counter-clockwise on an angle
---@param v Vector
---@param angle number
---@return Vector
function Vector.rotate(v, angle)
    local cos_angle = math.cos(angle)
    local sin_angle = math.sin(angle)
    local x_prime = v.x * cos_angle - v.y * sin_angle
    local y_prime = v.x * sin_angle + v.y * cos_angle

    return Vector.new(x_prime, y_prime)
end

---Maximizes each vector coordinate
---@param v Vector
---@param max Vector
---@return Vector
function Vector.max(v, max)
    return Vector.new(math.max(v.x, max.x), math.max(v.y, max.y))
end

---Minimizes each vector coordinate
---@param v Vector
---@param min Vector
---@return Vector
function Vector.min(v, min)
    return Vector.new(math.min(v.x, min.x), math.min(v.y, min.y))
end

---Scales a vector up to a maximum magnitude if smaller
---@param v Vector
---@param max_scale number
---@return Vector
function Vector.max_scale(v, max_scale)
    if Vector.magnitude(v) < max_scale then
        local r = Vector.scale(v, max_scale)
        return r
    else
        return v
    end
end

---Scales a vector down to a minimum magnitude if bigger
---@param v Vector
---@param min_scale number
---@return Vector
function Vector.min_scale(v, min_scale)
    if Vector.magnitude(v) > min_scale then
        local r = Vector.scale(v, min_scale)
        return r
    else
        return v
    end
end

---Draws a vector according to given opts or defaults
---@param from Vector starting position
---@param v Vector vector to be drawn
---@param opts table options such as color, scale and rotation factors
function Vector.draw(from, v, opts)
    local color = opts.color or { 0, 0, 255 }
    local scale = opts.scale or 3
    local rotation = opts.rotation or 0
    local scaled = Vector.multiply(v, scale)
    local rotated = Vector.rotate(scaled, rotation)
    local to_x = from.x + rotated.x
    local to_y = from.y + rotated.y
    DebugCanvas:renderTo(
        function()
            love.graphics.setColor(color)
            love.graphics.line({ from.x, from.y, to_x, to_y })
            love.graphics.setColor(1, 1, 1, 1)
        end)
end

return Vector
