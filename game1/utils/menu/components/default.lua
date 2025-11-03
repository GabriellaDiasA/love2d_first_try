local Module = {}

function Module.draw(menu, option, index)
    local number_of_lines_left = #menu.options - index + 1
    local step = 70
    local margin = 0
    local y = ScreenDimensions.y - number_of_lines_left * step - margin
    local color = { 1, 1, 1 }
    local text = option.text

    if not option.enabled then
        color = { 0.5, 0.5, 0.5 }
    end

    if menu.cursor_position == index then
        if option.enabled then
            color = { 1, 0.5, 1 }
        else
            color = { 0.5, 0.25, 0.5 }
        end

        love.graphics.setColor(color)
        love.graphics.printf(">> " .. text .. " <<", 0, y, ScreenDimensions.x, "center", 0, 1, 1, 0, 0, 0, 0)
    else
        love.graphics.setColor(color)
        love.graphics.printf(text, 0, y, ScreenDimensions.x, "center", 0, 1, 1, 0, 0, 0, 0)
    end
end

return Module