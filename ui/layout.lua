local Layout = {}

function Layout.vertical(elements, opts)
    local margin = opts.margin or 0
    local spacing = opts.spacing or 0

    local y = margin
    for _, element in ipairs(elements) do
        element.position.y = y
        y = y + element:get_height() + spacing
    end
end

function Layout.vertical_bottom(parent, opts)
    local margin = opts.margin or 0
    local spacing = opts.spacing or 0

    local y = parent.container:get_height() - margin
    for _, element in ipairs(parent.elements) do
        element.position.y = y - element:get_height()
        y = y - element:get_height() - spacing
    end
end

function Layout.horizontal(elements, opts)
    local margin = opts.margin or 0
    local spacing = opts.spacing or 0

    local x = margin
    for _, element in ipairs(elements) do
        element.position.x = x
        x = x + element:get_width() + spacing
    end
end

function Layout.horizontal_center(parent, _)
    local width = parent.container:get_width()
    for _, element in ipairs(parent.elements) do
        element.position.x = (width - element:get_width()) / 2
    end
end


return Layout
