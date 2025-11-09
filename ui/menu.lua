local Menu = {}

function Menu:update(dt)
    for _, element in ipairs(self:get_all_children()) do
        if element.update then element:update(dt) end
    end
end

function Menu:draw()
    self.container:render_to(function()
        if self.background_color then
            love.graphics.setBackgroundColor(unpack(self.background_color))
        end
        for _, element in ipairs(self:get_all_children()) do
            if Debug and element.inspect then element:inspect() end
            if element.draw then element:draw() end
        end
    end)
    self.container:draw()
end

function Menu:get_all_children()
    local aggregate = {}
    local position = 1
    if self.ui_components then
        for _, elem in ipairs(self.ui_components) do
            table.insert(aggregate, position, elem)
            position = position + 1
        end
    end
    if self.hud_elements then
        for _, elem in ipairs(self.hud_elements) do
            table.insert(aggregate, position, elem)
            position = position + 1
        end
    end

    return aggregate
end

return Menu
